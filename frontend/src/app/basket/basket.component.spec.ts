import {ComponentFixture, TestBed} from '@angular/core/testing';

import {BasketComponent} from './basket.component';
import {provideRouter} from '@angular/router';
import {CONFIG, CONFIG_TOKEN} from "../config/config";

describe('BasketComponent', () => {
  let component: BasketComponent;
  let fixture: ComponentFixture<BasketComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BasketComponent],
      providers: [
        provideRouter([]),
        {provide: CONFIG_TOKEN, useValue: CONFIG}
      ]
    })
      .compileComponents();

    fixture = TestBed.createComponent(BasketComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
