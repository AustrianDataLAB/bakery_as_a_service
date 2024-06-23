import { InjectionToken } from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Observable, tap} from "rxjs";

export interface Config {
  apiUrl: string;
  appName: string;
  customerEmail: string;
}

export const CONFIG: Config = {
  apiUrl: "http://localhost:8055",
  appName: "Bakery as a Service",
  customerEmail: "test@example.com",
};

export const CONFIG_TOKEN = new InjectionToken<Config>('Configuration data');

export function initializeAppFactory(httpClient: HttpClient): () => Observable<Config> {
  return () =>
    httpClient.get<Config>('assets/config.json').pipe(
      tap((config) =>
        Object.assign(CONFIG, {
          ...config
        })
      )
    );
}
