# Kubernetes namespaces

## Status

The status of this decision is: **accepted** ✅

## Context

We need to create isolated production and development environments for our applications. Managing multiple Kubernetes clusters for this purpose adds unnecessary complexity and overhead. Additionally, we use Helm charts for our deployments and require a solution that integrates well with our existing setup.

## Decision

We will use Kubernetes namespaces to create separate production, development, and testing environments within a single Kubernetes cluster. This approach will allow us to manage resources more efficiently while maintaining the necessary isolation between environments. Helm charts will be used to deploy applications into these namespaces, utilizing different values files for each environment.

## Consequences

* Easier management of resources as we only have one Kubernetes cluster to maintain.
* Simplified Helm chart deployments with the ability to use environment-specific values files.
* Reduced overhead and cost associated with running multiple clusters.
* Potential risk of misconfiguration leading to cross-environment impact, which can be mitigated with proper RBAC policies and namespace isolation practices.
