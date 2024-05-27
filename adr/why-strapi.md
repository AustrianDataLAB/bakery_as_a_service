# Using strapi as backend

## Status
The status of this decision is: **superseded** 

## Context
(Strapi)[https://strapi.io/] is a headless content management system (CMS), meaning that it offers an API (RESTful or GraphQL) to the frontend, making it *flexible* as it can be used with any front-end tool able to consume those. It is *customizable* as it allows to create custom content types and connect them with other data structures recreating the database schema on the fly using a *powerful dashboard*.

In the context of our project (e-commerce platform for a bakery), strapi comes in handy as it eliminates the need of programming the back-end (api + database) and administrative interface for the customer (ui), because it already provides those. Data structures can be created and changed very easily using it's dashboard also directly exposing them over the API, making it also a great option for fast prototypes. 

We are also doing this project in the context of the "Hands On Cloud Native" course @TUWien where the main focus is on cloud deployment rather than software design, so we decided to not re-invent the wheel but rather use ready components wherever possible. 

## Decision
We will be using (strapi)[https://strapi.io/] for the back-end/api part of our project. 

## Consequences

With strapi it becomes easier to create fast prototypes, change data structures and APIs using it's dashboard. Strapi takes away the burden of programming a content managing back-end together with an administrative interface for developers as well as customers. It is open-source, flexible, customisable and developer-friendly allowing to create fast prototypes (following the fail-fast paradigm).

However, strapi also has some downsides which have to be acknowledged. In the context of cloud computing, strapi might not be the best choice as it could be considered a rather "monolithic" backend service which manages all the content (contrary to the micro services approach). Depending on the complexity of the project, performance could become an issue and the horizontal scalability has to yet to be evaluated. 