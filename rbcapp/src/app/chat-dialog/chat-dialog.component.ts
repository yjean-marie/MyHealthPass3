import { Component } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-chat-dialog',
  templateUrl: './chat-dialog.component.html',
  styleUrl: './chat-dialog.component.css'
})
export class ChatDialogComponent {
  messageText = '';
  loading = false;
  messages: {text: string, sender: 'user' | 'assistant'}[] = [];

  constructor(
    public dialogRef: MatDialogRef<ChatDialogComponent>,
    private http: HttpClient
  ) {}

  sendMessage(): void {
    if (!this.messageText.trim()) return;
    this.messages.push({ text: this.messageText, sender: 'user' });
    this.loading = true;
    // Replace 'YOUR_ENDPOINT' with your actual endpoint URL
    this.http.post<{answer: string}>('http://localhost:8000/chat/', { prompt: this.messageText })
      .subscribe({
        next: (response) => {
          this.messages.push({ text: response.answer, sender: 'assistant' });
          this.loading = false;
        },
        error: () => {
          this.loading = false;
          // Handle error
        }
      });
    this.messageText = '';
  }
  confirmClose(): void {
    const confirmation = window.confirm('Are you sure you want to close the chat?');
    if (confirmation) {
      this.dialogRef.close();
    }
  }

  // Placeholder for minimize functionality
  minimize(): void {
    // Minimize action
    // This might involve updating the dialog's position or size,
    // but as a direct manipulation of MatDialog is limited,
    // consider alternative UI approaches or custom implementations.
  }
}
