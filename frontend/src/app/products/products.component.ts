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
      .then((products) => {
        this.products = products;
        console.log(products);
      })
      .catch((err) => console.error(err));
  }

  add(product: Product, quantity: number, event: MouseEvent): void {
    const button = event.target as HTMLElement;
    button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>';
  
    // Simulate adding to cart with a timeout
    setTimeout(() => {
      button.innerHTML = '<i class="bi bi-bag-check"></i> Added to cart';
      // Show check icon for a short period before returning to default state
      setTimeout(() => {
        button.innerHTML = '<i class="bi bi-cart-plus"></i> Add to cart';
      }, 500); // Adjust timing as needed
    }, 100); // Loading time simulation
    this.basketService.addProduct(product.id, quantity);    
    console.log('Added');
  }
}
