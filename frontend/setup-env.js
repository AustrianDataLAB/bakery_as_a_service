const fs = require('fs');
const path = require('path');

// Define the default environment variables
const defaultEnv = {
  API_URL: 'http://localhost:8055', // WITHOUT TRAILING SLASH!!!
  APP_NAME: 'Bakery as a Service',
  // add more default environment variables here
};

// Override the defaults with actual environment variables
const environment = {
  API_URL: process.env.API_URL || defaultEnv.API_URL,
  APP_NAME: process.env.APP_NAME || defaultEnv.APP_NAME,
  // add more environment variables here
};

// Ensure the environments directory exists
const envDir = path.join(__dirname, 'src/environments');
if (!fs.existsSync(envDir)) {
  fs.mkdirSync(envDir, { recursive: true });
}

// Write the environment variables to the environment file
const envFileContent = `
export const environment = ${JSON.stringify(environment, null, 2)};
`;

fs.writeFileSync(path.join(envDir, 'environment.prod.ts'), envFileContent);
fs.writeFileSync(path.join(envDir, 'environment.ts'), envFileContent);