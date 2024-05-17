import { Injectable } from '@angular/core';
import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptor } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {
    constructor() { }

    intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
        // add auth header with jwt if account is logged in and request is to the api url
        const auth = localStorage.getItem('user');

        if(auth != null) {
            request = request.clone({
                setHeaders: { Authorization: `Bearer ${JSON.parse(auth)['access_token']}` }
            });
        }

        

        return next.handle(request);
    }
}