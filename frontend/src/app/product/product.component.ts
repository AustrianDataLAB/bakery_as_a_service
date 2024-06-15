import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-product',
  standalone: true,
  imports: [],
  templateUrl: './product.component.html',
  styleUrl: './product.component.scss'
})
export class ProductComponent implements OnInit {
  productId: string | null = null;

  constructor(private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.productId = this.route.snapshot.paramMap.get('id');
    // Load product details using this.productId
  }
}