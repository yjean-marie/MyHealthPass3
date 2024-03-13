import { Component } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {
  services = [
    { title: 'Personal Banking', subtitle: 'Manage Your Money', description: 'Experience top-notch banking services.', image: 'path/to/your/image.jpg' },
    { title: 'Business Banking', subtitle: 'Grow Your Business', description: 'Tailored solutions for businesses.', image: 'path/to/your/image.jpg' },
    { title: 'Wealth Management', subtitle: 'Secure Your Future', description: 'Let your wealth work for you.', image: 'path/to/your/image.jpg' }
    // Add more services as needed
  ];
}
