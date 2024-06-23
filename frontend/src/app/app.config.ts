import {APP_INITIALIZER, ApplicationConfig} from '@angular/core';
import {provideRouter} from '@angular/router';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';

import {routes} from './app.routes';
import {HttpClient, provideHttpClient} from '@angular/common/http';
import {CONFIG, CONFIG_TOKEN, initializeAppFactory} from "./config/config";

export const appConfig: ApplicationConfig = {
  providers: [
    provideRouter(routes),
    provideHttpClient(),
    NgbModule,
    {
      provide: APP_INITIALIZER,
      useFactory: initializeAppFactory,
      deps: [HttpClient],
      multi: true,
    },
    {provide: CONFIG_TOKEN, useValue: CONFIG}
  ]
};
