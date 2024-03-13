import { Component } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { ChatDialogComponent } from '../chat-dialog/chat-dialog.component';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrl: './chat.component.css'
})
export class ChatComponent {
  constructor(public dialog: MatDialog) {}

  openChat(): void {
    this.dialog.open(ChatDialogComponent, {
      width: '300px',
      height: '400px',
      position: {
        bottom: '0px',
        right: '0px'
      },
      panelClass: 'custom-chat-dialog'
    });
  }
}
