# Web-Project

# EventHub

A web platform for university community members to create, discover, and join campus events — talks, workshops, sports activities, social gatherings, and study groups.

Built with **Ruby on Rails 8** as part of a semester-long course project (202610).

---

## Overview

EventHub provides a centralized hub for organizing and participating in university events. Users can browse upcoming events, register to attend, and share their experience through reviews once an event has ended.

---

## Features

- **Event creation** — Define title, rich-text description, category, venue, dates, and attendee capacity
- **Event discovery** — Browse all published events, filter by category, and view detailed event pages
- **Registration system** — Sign up for events; get automatically placed on a waiting list when full
- **Waitlist promotion** — Automatically moved to confirmed when a spot opens up
- **Reviews** — Leave a rating (1–5) and written comment after attending a completed event
- **Role-based access** — Regular users and Administrators with different permission levels
- **Event lifecycle management** — Draft → Published → Ongoing → Completed → Cancelled

---

## Event Lifecycle

| Status | Description |
|---|---|
| **Draft** | Visible only to the organizer; can be freely edited or published |
| **Published** | Visible to all users; open for registration |
| **Ongoing** | Event has started; no new registrations accepted |
| **Completed** | Event has ended; attendees can leave reviews |
| **Cancelled** | Voided by organizer or admin; all registrations are cancelled |

---

## Roles & Permissions

| Action | Regular User | Admin |
|---|---|---|
| Browse events, venues, categories | Yes | Yes |
| Create events | Yes | Yes |
| Edit / cancel own events | Yes | Yes |
| Edit / cancel any event | No | Yes |
| Register for events | Yes | Yes |
| Cancel own registration | Yes | Yes |
| Review attended events | Yes | Yes |
| Delete any review | No | Yes |
| Manage categories | No | Yes |
| Manage venues | No | Yes |
| Manage users | No | Yes |

---

## Test Credentials

| Role | Email | Password |
|---|---|---|
| Admin | admin@eventhub.com | password123 |
| Regular User | user@eventhub.com | password123 |
| Regular User | pepe@miuandes.cl | password123 |
| Regular User | pedro@miuandes.cl | password123 |

---

## Tech Stack

- **Framework:** Ruby on Rails 8 (MVC)
- **Database:** PostgreSQL
- **Views:** ERB templates
- **Styling:** Bootstrap 5
- **Rich Text:** ActionText
- **Authentication:** Devise
- **Authorization:** Pundit

---

## Setup & Running the Application

### Prerequisites

- Ruby 4.0.0
- Rails 8.1.x
- PostgreSQL
- Node.js 20.x
- Yarn

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

Visit `http://localhost:3000`

---

## Project Milestones

| Milestone | Due Date | Weight |
|---|---|---|
| Assignment 1 | April 20 | 20% |
| Assignment 2 | May 4 | 20% |
| Assignment 3 | May 25 | 20% |
| Assignment 4 | June 8 | 20% |
| Demo | June 15 or 22 (in class) | 20% |
