import { Component, OnInit } from '@angular/core';
import { RouterModule, RouterOutlet } from '@angular/router';
import { BackendService, Product } from '../backend.service';
import { BasketService } from '../basket.service';

@Component({
  selector: 'products-root',
  standalone: true,
  imports: [RouterOutlet, RouterModule],
  templateUrl: './products.component.html',
  styleUrl: './products.component.scss'
})
export class ProductsComponent implements OnInit {
  public products: Product[] = [];

  constructor(public backendService: BackendService, public basketService: BasketService) {

  }

  ngOnInit(): void {
    this.backendService.getAllProducts()
      .then((p) => this.products = p)
      .catch((err) => console.error(err));
  }

  add(product: Product, quantity: number): void {
    this.basketService.addProduct(product.id, quantity);    
    console.log('Added');
  }
}
