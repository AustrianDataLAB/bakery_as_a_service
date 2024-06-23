import {TestBed} from '@angular/core/testing';

import {BackendService} from './backend.service';
import {CONFIG, CONFIG_TOKEN} from "./config/config";

describe('BackendService', () => {
  let service: BackendService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        {provide: CONFIG_TOKEN, useValue: CONFIG}
      ]
    });
    service = TestBed.inject(BackendService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
