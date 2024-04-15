# Unit vs. Integration Tests

## Status
The status of this decision is: **proposed** ❔

## Context
There is a need to create some form of automated tests to ensure that the artifact we are about to deploy is functioning as expected. The discussion centered around whether to create unit tests, which test the application rather than the actual artifact to be deployed, or integration tests, which directly test the artifact. Given that our current ability to use GitHub pipelines is limited to containers, we would need to develop custom solutions like Docker-in-Docker (DinD) to properly execute integration tests on the target artifact. Consequently, we have decided to focus solely on unit tests for now and to add integration tests in the future when we have access to a Kubernetes infrastructure.

## Decision
As a first step, we will create unit tests for our project as described in the [Strapi documentation](https://docs.strapi.io/dev-docs/testing) to ensure with sufficient certainty that our deployments will function correctly.

## Consequences
Implementing unit tests for Strapi and integrating them into the pipeline presents a learning curve. There is also a possibility that these tests may become obsolete once our infrastructure evolves to support proper execution of integration tests.
