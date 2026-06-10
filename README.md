# Web-Project

# EventHub

A web platform for university community members to create, discover, and join campus events such as talks, workshops, sports activities, social gatherings, and study groups.

Built with **Ruby on Rails 8** as part of a semester-long course project (202610).

---

## Overview

EventHub is a centralized platform for organizing and participating in university events. Users can browse published events, register to attend, join a waiting list when events are full, and leave reviews after attending completed events.

The application includes authentication, role-based authorization, event lifecycle management, registration logic, waitlist promotion, and rich-text event descriptions.

---

## Features

* **Event creation** — Users can create events with title, rich-text description, category, venue, dates, and attendee capacity.
* **Event discovery** — Visitors and users can browse published events and view detailed event pages.
* **Registration system** — Authenticated users can register for published events.
* **Waiting list** — Users are automatically waitlisted when an event reaches full capacity.
* **Waitlist promotion** — When a confirmed attendee cancels, the first waitlisted user is automatically promoted.
* **Reviews** — Users can leave a rating from 1 to 5 and a written comment after attending a completed event.
* **Role-based access** — Regular users and administrators have different permissions.
* **Event lifecycle management** — Events move through draft, published, ongoing, completed, or cancelled states.
* **Authentication** — User sign up, log in, log out, password recovery, and account editing are handled with Devise.
* **Authorization** — Permissions are managed with Pundit policies.

---

## Event Lifecycle

| Status        | Description                                                           |
| ------------- | --------------------------------------------------------------------- |
| **Draft**     | Visible only to the organizer and admins. Can be edited or published. |
| **Published** | Visible to all users. Open for registration.                          |
| **Ongoing**   | Event has started. New registrations are not accepted.                |
| **Completed** | Event has ended. Confirmed attendees can leave reviews.               |
| **Cancelled** | Event has been cancelled by the organizer or an admin.                |

---

## Roles & Permissions

| Action                               | Regular User | Admin |
| ------------------------------------ | ------------ | ----- |
| Browse published events              | Yes          | Yes   |
| View venues and categories           | Yes          | Yes   |
| Create events                        | Yes          | Yes   |
| Edit own events                      | Yes          | Yes   |
| Cancel own draft or published events | Yes          | Yes   |
| Edit or cancel any event             | No           | Yes   |
| Publish own draft events             | Yes          | Yes   |
| Register for published events        | Yes          | Yes   |
| Cancel own registration              | Yes          | Yes   |
| Review attended completed events     | Yes          | Yes   |
| Delete own reviews                   | Yes          | Yes   |
| Delete any review                    | No           | Yes   |
| Manage categories                    | No           | Yes   |
| Manage venues                        | No           | Yes   |
| Manage users                         | No           | Yes   |

---

## Test Credentials

Use the following accounts after running `rails db:seed`:

| Role         | Email                                           | Password    |
| ------------ | ----------------------------------------------- | ----------- |
| Admin        | [admin@eventhub.com](mailto:admin@eventhub.com) | password123 |
| Regular User | [user@eventhub.com](mailto:user@eventhub.com)   | password123 |
| Regular User | [pepe@miuandes.cl](mailto:pepe@miuandes.cl)     | password123 |
| Regular User | [pedro@miuandes.cl](mailto:pedro@miuandes.cl)   | password123 |

---

## Tech Stack

* **Framework:** Ruby on Rails 8
* **Language:** Ruby 3.3.x
* **Database:** PostgreSQL
* **Views:** ERB templates
* **Styling:** Bootstrap 5
* **Rich Text:** ActionText
* **Authentication:** Devise
* **Authorization:** Pundit

---

## Main Models

The application includes the following main models:

* **User** — Handles authentication and roles.
* **Event** — Represents a university event.
* **Category** — Groups events by type.
* **Venue** — Stores event location information.
* **Registration** — Connects users with events and manages confirmed/waitlisted/cancelled statuses.
* **Review** — Stores user ratings and comments for completed events.
* **Notification** — Stores user notifications related to platform activity.

---

## Setup & Running the Application

### Prerequisites

Make sure you have installed:

* Ruby 3.3.x
* Rails 8.x
* PostgreSQL
* Node.js
* Yarn

### Installation

```bash
git clone <repository-url>
cd Web-Proyect-main

bundle install
yarn install

rails db:create
rails db:migrate
rails db:seed

bin/dev
```

Then open:

```bash
http://localhost:3000
```

---

## Database Setup

To reset and seed the database:

```bash
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

---

## Authentication and Authorization

EventHub uses **Devise** for authentication and **Pundit** for authorization.

Unauthenticated visitors can:

* Browse published events.
* View event details.
* Read reviews.

Authenticated regular users can:

* Create events.
* Edit, publish, or cancel their own events.
* Register for published events.
* Cancel their own registrations.
* Review completed events they attended.

Administrators can:

* Manage all events.
* Manage categories.
* Manage venues.
* Manage users.
* Delete any review.

---

## Project Milestones

| Milestone    | Due Date      | Weight |
| ------------ | ------------- | ------ |
| Assignment 1 | April 20      | 20%    |
| Assignment 2 | May 4         | 20%    |
| Assignment 3 | May 25        | 20%    |
| Assignment 4 | June 8        | 20%    |
| Demo         | June 15 or 22 | 20%    |

---

## Repository Structure

```bash
app/
  controllers/
  models/
  policies/
  views/

config/
  routes.rb

db/
  migrate/
  seeds.rb

docs/
  data_model.png

README.md
```

---

## Notes

This project was developed for academic purposes as part of the Web Development course at Universidad de los Andes.

The application follows the MVC pattern, uses resourceful routing, and applies model validations, authorization policies, and Bootstrap-based views to provide a functional event management platform.
