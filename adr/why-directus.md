# Why directus

## Status

The status of this decision is: **accepted** ✅

## Context

Initially, we chose [Strapi](https://strapi.io/) for our backend solution. However, one of our teammates later discovered [Directus](https://directus.io/), which appeared to be an even better option.

Both Strapi and Directus are headless content management systems (CMS) that offer comprehensive APIs and a user-friendly administrative interface. Our decision to use a headless CMS stemmed from the project's focus on cloud deployment rather than extensive software development. A customizable CMS minimizes the amount of back-end code required, facilitating a faster development process.

We decided to switch to Directus early in our project after evaluating Strapi. Directus offers superior overall database support. It not only supports a wider range of database solutions than Strapi but also does not require initializing the database itself. Directus can handle manually added tables or database changes, providing greater flexibility. This allows us to modify the schema post-deployment and choose different underlying database solutions as needed.

Furthermore, Directus excels in role and permission management. It allows the creation of an unlimited number of roles and offers extensive customization of access conditions and per-field access.

The most exciting feature of Directus, in our opinion, is its "Flow" functionality. This feature enables us to execute operations triggered by various events directly from the dashboard without the need for coding. This could be incredibly useful for scenarios like reacting to customer purchase events and triggering background processes such as receipt creation.

## Decision

We are switching from [Strapi](https://strapi.io/) to [Directus](https://directus.io/) as our main back-end technology.

## Consequences

Apart from the consequences of using a headless CMS that have been described in our [Why Strapi](why-strapi.md)-ADR, switching to Directus naturally imposes some extra effort, but due to the fact that we switched so early the cost of switching was negligible and we hopefully only benefit from the transition.
