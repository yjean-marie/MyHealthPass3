import { Component } from '@angular/core';
import { DataService } from '../_services/data.service';

@Component({
  selector: 'app-file-manager',
  templateUrl: './file-manager.component.html',
  styleUrls: ['./file-manager.component.css']
})
export class FileManagerComponent {
  selectedFile: File | null = null;
  uploading: boolean = false;
  fileList: string[] = [];

  constructor(private dataService: DataService) {
    this.refreshFileList();
  }

  onFileSelected(event: Event) {
    const element = event.currentTarget as HTMLInputElement;
    let files: FileList | null = element.files;
    if (files) {
      this.selectedFile = files.item(0);
    }
  }

  upload() {
    if (this.selectedFile) {
      this.uploading = true;
      this.dataService.uploadPdf(this.selectedFile).subscribe({
        next: (response) => {
          this.uploading = false;
          this.selectedFile = null;
          this.refreshFileList();
        },
        error: (error) => {
          this.uploading = false;
          console.error('Error uploading file:', error);
        }
      });
    }
  }

  refreshFileList() {
    this.dataService.listPdfs().subscribe({
      next: (data: any) => {
        this.fileList = data.files;
      },
      error: (error) => {
        console.error('Error fetching file list:', error);
      }
    });
  }

  delete(filename: string) {
    this.dataService.deletePdf(filename).subscribe({
      next: () => {
        this.refreshFileList();
      },
      error: (error) => {
        console.error('Error deleting file:', error);
      }
    });
  }
}