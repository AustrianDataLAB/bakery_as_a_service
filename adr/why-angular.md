# Using Angular as front-end

## Status

The status of this decision is: **accepted** ✅

## Context

We need to choose a front-end framework that best complements our backend. Our backend, powered by (strapi)[https://strapi.io/], provides a RESTful API, which offers us the flexibility to select from a variety of modern front-end frameworks. Initially, we sought a front-end framework that would seamlessly integrate with Strapi, particularly one that could automatically regenerate components based on updates in Strapi to enhance our prototyping speed. However, the only compatible feature we discovered was DTO generation via the OpenAPI specification, a capability supported by numerous front-end frameworks.

Given this insight, we shifted our strategy towards selecting a framework that most team members are already familiar with, considering that it will likely constitute the bulk of our development work.

## Decision

We decided to use Angular as our front-end framework.

## Consequences

Choosing Angular as our front-end framework enhances development efficiency and consistency due to its robust features and TypeScript integration. However, it presents a steep learning curve for newcomers and potential performance overheads in complex applications. The framework's structured nature supports rapid prototyping but may complicate upgrades due to frequent updates.