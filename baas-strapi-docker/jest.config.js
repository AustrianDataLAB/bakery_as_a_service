/** @type {import('ts-jest').JestConfigWithTsJest} */
module.exports = {
  "testPathIgnorePatterns": [
    "/node_modules/",
    ".tmp",
    ".cache"
  ],
  preset: 'ts-jest',
  testEnvironment: 'node',
};
