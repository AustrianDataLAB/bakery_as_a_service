import { Component, OnInit } from '@angular/core';
import { RouterModule, RouterOutlet } from '@angular/router';
import { BackendService, Product } from './backend.service';

@Component({
  selector: 'products-root',
  standalone: true,
  imports: [RouterOutlet, RouterModule],
  templateUrl: './products.component.html',
  styleUrl: './products.component.scss'
})
export class ProductsComponent implements OnInit {
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
