# Helm Chart Values Structure

## Status

The status of this decision is: **proposed**

## Context

We need an efficient and maintainable way to manage configuration values for the various services and containers we deploy using Helm charts. Managing separate values files for each service can lead to inconsistencies and increased complexity, especially when making changes. We also need a flexible approach to handle environment-specific configurations (production, testing, development) without duplicating efforts.

## Decision

We will structure our Helm charts so that all values for all services and containers are written in a single `values.yaml` file. This allows us to maintain a centralized configuration where any value change can be made in one place, ensuring consistency across all deployments. When there is a need to differentiate values based on the environment, we will create a separate folder named after the target environment (e.g., `production`, `development`, `testing`). Each folder will contain its own `values.yaml` file, which can be used as a parameter during deployment to customize configurations for that specific environment.

## Consequences

* **Easier Maintenance**: Changes to configuration values can be made in a single file, reducing the risk of inconsistencies and errors.
* **Centralized Configuration**: A single source of truth for configuration values simplifies management and understanding of the deployment setup.
* **Flexible Environment Management**: By using environment-specific folders with separate `values.yaml` files, we can easily customize deployments for different environments without duplicating configuration efforts.
* **Simplified Deployments**: Using Helm’s capability to pass different values files during deployment, we can efficiently manage multiple environments with minimal overhead.
* **Risk of Overcrowded Values File**: The single `values.yaml` file can become large and complex, but this can be managed with proper organization and documentation within the file.
