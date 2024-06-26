import { Routes, Router, CanActivateFn } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { ProductsComponent } from './products/products.component';
import { BasketComponent } from './basket/basket.component';
import { BackendService } from './backend.service';
import { inject } from '@angular/core';
import { ProductComponent } from './product/product.component';
import { PageNotFoundComponent } from './page-not-found/page-not-found.component';
import { InvoiceComponent } from './invoice/invoice.component';

export const canActivate: CanActivateFn = () => {
    const backendService = inject(BackendService);
    const router = inject(Router);
  
    if (!backendService.checkIfLoggedIn()) {
      router.navigate(['/login']);
      return false;
    }
    return true;
  };

export const routes: Routes = [
    { path: '', redirectTo: '/login', pathMatch: 'full' },
    { path: 'login', component: LoginComponent },
    { path: 'products', component: ProductsComponent, canActivate: [canActivate] },
    { path: 'product/:id', component: ProductComponent, canActivate: [canActivate] },
    { path: 'cart', component: BasketComponent, canActivate: [canActivate] },
    { path: 'invoice/:id', component: InvoiceComponent, canActivate: [canActivate] },
    { path: '**', component: PageNotFoundComponent }
];
