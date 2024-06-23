# Running Tests using playwright

The application is tested using the playwright framework. This framework allows us to both write UI and API tests.

The tests load properties like test base URL and test users from an enviroment file. For each enviroment you can find its dedicated properties file in the `env` directory.
To select the enviroment where you want your tests to be run against, you have to specify the `ENV` enviroment variable. The enviroment file has to be named following this convention:
`.env.<your_env` and has to be placed in the `env` folder. 
For example, for starting tests against your local docker compose deployment, the `local` enviroment is used.

## Examples

By setting the `ENV` variable and running the playwright test (i.e., `export ENV=local && npx playwright test`), the tests will load the `.env.local` enviroment variables.
We added npm scripts in the `package.json` to quickly execute the above commands with `npm run test:local`.
