import {ComponentFixture, TestBed} from '@angular/core/testing';

import {ProductComponent} from './product.component';
import {provideRouter} from '@angular/router';
import {CONFIG, CONFIG_TOKEN} from "../config/config";

describe('ProductComponent', () => {
  let component: ProductComponent;
  let fixture: ComponentFixture<ProductComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ProductComponent],
      providers: [
        provideRouter([]),
        {provide: CONFIG_TOKEN, useValue: CONFIG}
      ]
    })
      .compileComponents();

    fixture = TestBed.createComponent(ProductComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
