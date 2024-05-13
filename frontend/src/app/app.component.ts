import { Component, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { BackendService, Product } from './backend.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent implements OnInit {
  title = 'My Bakery';
  public products: Product[] = [];

  constructor(public backendService: BackendService) {

  }

  ngOnInit(): void {
    this.backendService.getAllProducts()
      .then((p) => this.products = p)
      .catch((err) => console.error(err));
  }
}
