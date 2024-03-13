import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class DataService {
  private apiUrl = 'http://localhost:8000'; // Adjust the URL if your API is running on a different port

  constructor(private http: HttpClient) { }

  uploadPdf(file: File) {
    const formData = new FormData();
    formData.append('file', file, file.name);
    return this.http.post(`${this.apiUrl}/upload-pdf/`, formData);
  }

  listPdfs() {
    return this.http.get(`${this.apiUrl}/list-pdfs/`);
  }

  deletePdf(filename: string) {
    return this.http.delete(`${this.apiUrl}/delete-pdf/${filename}`);
  }
}