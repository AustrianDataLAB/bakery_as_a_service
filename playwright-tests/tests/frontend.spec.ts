import { test, expect } from '@playwright/test';

const USERNAME = process.env.FRONTEND_USERNAME;
const PASSWORD = process.env.FRONTEND_PASSWORD;

test.beforeEach(async ({ page }) => {
  console.log(`Running test in environement ${process.env.ENV}`);
  await page.goto('/');
});

test('has title', async ({ page }) => {
  await page.goto('/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/Frontend/);
});

test('login page loads correctly', async ({ page }) => {
  await expect(page.getByRole('banner')).toContainText('Bakery as a Service');
  await expect(page.getByText('LoginSubmitYou don\'t have an')).toBeVisible();
  await expect(page.getByPlaceholder('Email')).toBeVisible();
  await expect(page.getByPlaceholder('Password')).toBeVisible();
  await expect(page.getByRole('button', { name: 'Submit' })).toBeVisible();
});

test('Test user can login', async ({ page }) => {
  await page.getByPlaceholder('Email').click();
  await page.getByPlaceholder('Email').fill(USERNAME);
  await page.getByPlaceholder('Password').click();
  await page.getByPlaceholder('Password').fill(PASSWORD);
  await page.getByRole('button', { name: 'Submit' }).click();
  await expect(page.getByRole('heading', { name: 'Products' })).toBeVisible();
});

test('Invalid user cannot login', async ({ page }) => {
  await page.getByPlaceholder('Email').click();
  await page.getByPlaceholder('Email').fill('invalid@invalid.com');
  await page.getByPlaceholder('Password').click();
  await page.getByPlaceholder('Password').fill('invalid_pw');
  await page.getByRole('button', { name: 'Submit' }).click();
  const alert = page.getByRole('alert');
  await expect(alert).toBeVisible();
  await expect(alert).toContainText('Error! Invalid user credentials.');
});
