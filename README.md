# BAAS - Backery as a service

Bakeries need to provide and make use of multiple services in
order to run smoothly. I sat done with a medium sized bakery in my
town in order to identify some requirements for such an
application including web shop + planning software for goods and delivery.

## Components Overview

Our application will consist of four main components: the customer app, the management interface, the document service and the planning service.

### Customer App

Webapp where customers can order baked goods. This platform should focus on commercial customers such as supermarkets and restaurants, but should also be accessible to private customers.

### Management interface

Owners of a bakery should be able to list what kind of pastries/goods they want to sell. They should be able to provide a price as well as a basic description and tags for their offers. It should be possible to list all invoices and edit them afterwards (in case the promised amount could not be delivered).

### Document service

The system should be able to generate documents such as invoices that are directly either sent to the customers automatically (e.g. by email), or printed out and mailed per post. These documents should also be kept in a database where the owner can organize and view old invoices. Furthermore, it should be possible to print a plan for all current orders (e.g. grouped by type of pastry or other criteria).

### Planning service

Overnight bakers night need to prepare the ordered goods which are then shipped to the respective customers. To facilitate this process, a software could be used to automatically generate optimal routes for the delivery team. There are various factors and other constraints that can be added to the model (e.g. number of cars, size of cars, time constraint for guaranteed delivery, etc.)

## Milestones

### Milestone 1 - Planning & Setup (until 7. April)
* Requirements gathering
* Architectural design
  * Interface & Service modeling
* Cloud/network setup
* CI/CD pipelines
* Role definition + Work Packages

### Milestone 2 - Development (10.06.2024)
* Authentication & Authorization
  * user management (customers, admins, baker and employee)
* Document generation + email service
* UI/UX + Frontend development
* Backend development (automated planning, product management)
* Database modeling

### Milestone 3 - Project presentation (21.06.2024)
* Prepare for final presentation
  * Slides
  * Demo


## Architecture Overview

![image](https://github.com/AustrianDataLAB/bakery_as_a_service/assets/75341604/643fcc98-2de8-4199-a95d-cbb5b32ac6d9)


## Value proposition

For details please refer to: https://docs.google.com/document/d/1pH0qjtOCmJ9wbqzUIkqdiRtdwsFonX-IpqglRnEzz4I/edit?usp=sharing
