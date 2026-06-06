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

## Roles

| Role | Permissions |
|---|---|
| **Regular User** | Create events, register, leave reviews, manage own events |
| **Administrator** | All user permissions + moderate events, manage venues, categories, and users |

---

## Tech Stack

- **Framework:** Ruby on Rails 8 (MVC)
- **Database:** PostgreSQL
- **Views:** ERB templates
- **Styling:** Bootstrap (responsive)
- **Rich Text:** ActionText
- **Authentication:** Devise
- **Authorization:** CanCanCan

---

## Setup & Running the Application

### Prerequisites
- Ruby 3.x
- Rails 8.x
- PostgreSQL

### Installation

```bash
git clone
cd Web-Proyect-main

bundle install
yarn install

cp config/database.yml.example config/database.yml

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
