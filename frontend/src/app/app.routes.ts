import { Routes, Router, CanActivateFn } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { ProductsComponent } from './products.component';
import { BasketComponent } from './basket/basket.component';
import { BackendService } from './backend.service';
import { inject } from '@angular/core';

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
    { path: 'shop', component: ProductsComponent, canActivate: [canActivate]},
    { path: 'cart', component: BasketComponent, canActivate: [canActivate]}
];
