import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { BackendService, Product } from '../backend.service';
import { BasketService } from '../basket.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-product',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './product.component.html',
  styleUrl: './product.component.scss'
})
export class ProductComponent implements OnInit {
  product: Product | undefined;
  quantity: number = 1;

  constructor(private route: ActivatedRoute, public backendService: BackendService, public basketService: BasketService, public router: Router) { }

  ngOnInit(): void {
    const productId = this.route.snapshot.paramMap.get('id');
    // Load product details using this.productId
    this.backendService.getProduct(productId!)
      .then((product) => {
        this.product = product;
      })
      .catch((err) => {
        console.error(err);
        this.router.navigateByUrl('/404');
      });
  }

  addToBasket(event: MouseEvent): void {
    if (this.product) {
      const button = event.target as HTMLElement;
      button.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>';
    
      setTimeout(() => {
        button.innerHTML = '<i class="bi bi-cart-plus"></i> Add to cart';
      }, 200);
      this.basketService.addProduct(this.product.id, this.quantity);
    }
  }

  incrementQuantity(): void {
    this.quantity++;
  }

  decrementQuantity(): void {
    if (this.quantity > 1) {
      this.quantity--;
    }
  }

  setQuantity(value: number): void {
    if (value < 1) {
      this.quantity = 1;
      return;
    }
    this.quantity = value;
  }
}