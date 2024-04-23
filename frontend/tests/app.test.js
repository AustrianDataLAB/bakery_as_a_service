const fs = require('fs');
const { setupStrapi, cleanupStrapi } = require("./helpers/strapi");
jest.useFakeTimers()

jest.setTimeout(20000)

beforeAll(async () => {
  await setupStrapi();
});

afterAll(async () => {
  await cleanupStrapi();
});

it("strapi is defined", () => {
  expect(strapi).toBeDefined();
});
