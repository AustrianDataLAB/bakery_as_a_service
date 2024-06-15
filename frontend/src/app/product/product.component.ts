import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { BackendService, Product } from '../backend.service';
import { BasketService } from '../basket.service';

@Component({
  selector: 'app-product',
  standalone: true,
  imports: [],
  templateUrl: './product.component.html',
  styleUrl: './product.component.scss'
})
export class ProductComponent implements OnInit {
  product: Product | undefined;

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
}