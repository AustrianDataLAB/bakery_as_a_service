# Choice of registry

## Status

The status of this decision is: **accepted** ✅

## Context

We were provided with a Harbor instance for managing our container images and Helm charts. However, we encountered several issues while trying to get the Harbor instance to work effectively for our needs. Additionally, at this stage of our project, the advanced features offered by Harbor, such as the signing service, are not essential. We have the capability to sign our Helm charts or container images ourselves if necessary. Furthermore, we have already integrated vulnerability scanning into our GitHub pipeline, which reduces the additional benefits Harbor might provide over the GitHub registry.

## Decision

We have decided to use the GitHub registry exclusively for our container images and Helm charts. This decision is based on the following considerations:

1. Difficulty in getting the provided Harbor instance to function as required.
2. The current project stage does not necessitate the use of Harbor's signing service.
3. Our existing GitHub pipeline already includes vulnerability scanning, which diminishes the need for Harbor's scanning capabilities.
4. Using the GitHub registry simplifies our workflow by consolidating our tools and services within the GitHub ecosystem.

## Consequences

- **Easier**:
  - Streamlined workflow with all services integrated within GitHub.
  - Simplified management of container images and Helm charts.
  - Reduced overhead in managing and maintaining an additional registry.

- **More Difficult**:
  - If advanced features such as comprehensive signing services or additional security measures provided by Harbor are required in the future, we may need to re-evaluate and potentially integrate Harbor or another similar service.
