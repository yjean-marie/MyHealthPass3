import os
import sys
from fastapi import FastAPI, UploadFile, File, HTTPException  
from fastapi.responses import JSONResponse
from pydantic import BaseModel
import shutil
import openai
from langchain.chains import ConversationalRetrievalChain, RetrievalQA
from langchain.chat_models import ChatOpenAI
from langchain.document_loaders import DirectoryLoader, TextLoader
from langchain.embeddings import OpenAIEmbeddings
from langchain.indexes import VectorstoreIndexCreator
from langchain.indexes.vectorstore import VectorStoreIndexWrapper
from langchain.llms import OpenAI
from langchain.vectorstores import Chroma
from fastapi.middleware.cors import CORSMiddleware


#import constants

os.environ["OPENAI_API_KEY"] = "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"

# Enable to save to disk & reuse the model (for repeatedd queries on the same data)
PERSIST = False

query = None
if len(sys.argv) > 1:
  query = sys.argv[1]

if PERSIST and os.path.exists("persist"):
  print("Reusing index...\n")
  vectorstore = Chroma(persist_directory="persist", embedding_function=OpenAIEmbeddings())
  index = VectorStoreIndexWrapper(vectorstore=vectorstore)
else:
  #loader = TextLoader("data/data.txt") # Use this line if you only need data.txt
  loader = DirectoryLoader("data/")
  if PERSIST:
    index = VectorstoreIndexCreator(vectorstore_kwargs={"persist_directory":"persist"}).from_loaders([loader])
  else:
    index = VectorstoreIndexCreator().from_loaders([loader])

chain = ConversationalRetrievalChain.from_llm(
  llm=ChatOpenAI(model="gpt-3.5-turbo"),
  retriever=index.vectorstore.as_retriever(search_kwargs={"k": 1}),
)
chat_history = []
# Create a FastAPI instance
app = FastAPI()
# Configure CORS
origins = [
    "http://localhost:4200",  # Angular default port
    # "https://www.example.com",  # You can add other origins here
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # List of allowed origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
) 

# Define the request body using Pydantic models
class PromptRequest(BaseModel):
    prompt: str

# Define the response body using Pydantic models
class PromptResponse(BaseModel):
    answer: str
DATA_FOLDER = 'data'

# Ensure data folder exists
os.makedirs(DATA_FOLDER, exist_ok=True)

@app.post("/upload-pdf/")
async def upload_pdf(file: UploadFile = File(...)):
    if not file.filename.endswith('.pdf'):
        raise HTTPException(status_code=400, detail="Invalid file format. Please upload only PDF files.")

    file_path = os.path.join(DATA_FOLDER, file.filename)
    with open(file_path, 'wb') as buffer:
        shutil.copyfileobj(file.file, buffer)
    
    return {"filename": file.filename}

@app.get("/list-pdfs/")
async def list_pdfs():
    files = os.listdir(DATA_FOLDER)
    return {"files": files}

@app.delete("/delete-pdf/{file_name}")
async def delete_pdf(file_name: str):
    file_path = os.path.join(DATA_FOLDER, file_name)
    if os.path.exists(file_path):
        os.remove(file_path)
        return {"detail": f"{file_name} deleted."}
    else:
        raise HTTPException(status_code=404, detail="File not found.")
@app.post("/chat/", response_model=PromptResponse)
async def chat_with_bot(prompt: PromptRequest):
    # Ensure the global variables like chain and chat_history are accessible
    global chain, chat_history

    # Check if the prompt is valid (not empty)
    if not prompt.prompt.strip():
        raise HTTPException(status_code=400, detail="Prompt cannot be empty.")

    # Process the prompt
    result = chain({"question": prompt.prompt, "chat_history": chat_history})

    # Append to chat history
    chat_history.append((prompt.prompt, result['answer']))

    # Return the answer in JSON format
    return PromptResponse(answer=result['answer'])

# Run the API with Uvicorn. If you save this script as `main.py`, use the command:
# uvicorn main:app --reload
# The API will be available at localhost:8000 by default.