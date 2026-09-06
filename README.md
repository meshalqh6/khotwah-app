# Khotwah

### Cross-Platform Tourist Guide System for Saudi Arabia

Khotwah is a cross-platform mobile tourist guide application designed to help travelers explore destinations across Saudi Arabia, organize trips, access real-time information, navigate using interactive maps, and manage travel-related activities through a unified interface.

The project was developed as part of the **Software Engineering CS290** course at Al-Imam Mohammad Ibn Saud Islamic University.

---

## Project Overview

Khotwah was designed to provide tourists with a centralized platform for:

- Discovering tourist destinations
- Viewing attraction information
- Creating personalized itineraries
- Accessing real-time weather information
- Navigating destinations using interactive maps
- Managing user profiles
- Exploring accommodation options
- Supporting cross-platform mobile usage

The application was developed using **Flutter**, allowing the system to target multiple platforms from a shared codebase.

---

## System Architecture

The project follows the **Model-View-Controller (MVC)** architectural pattern.

```text
                 User
                   ↓
                 View
                   ↓
              Controller
              ↙        ↘
          Model       External Services
            ↓          ↙        ↘
        App Data   Weather API   Map Service
```

### Model

Responsible for application data and business logic including:

- Tourist destinations
- User information
- Itineraries
- Accommodation data
- Application state

### View

Responsible for presenting:

- Authentication screens
- Destination information
- Explore interface
- Itinerary pages
- Weather information
- Maps
- Accommodation interfaces

### Controller

Coordinates communication between the user interface, application logic, and external services.

---

## Core Features

### User Authentication

The application includes:

- Login
- Sign-up
- Form validation
- User profile management

---

### Destination Discovery

Users can explore tourist destinations and access information about attractions and locations.

The Explore functionality was designed to support destination searching and browsing.

---

### Personalized Itinerary Planning

Users can create travel itineraries by selecting destinations and dates.

```text
User
  ↓
Select Destination
  ↓
Choose Date
  ↓
Create Itinerary
  ↓
Save Travel Plan
```

The system also supports itinerary management concepts such as modification and deletion.

---

### Real-Time Weather

Khotwah integrates real-time weather information into destination pages.

```text
Destination
     ↓
Weather Request
     ↓
External Weather Service
     ↓
Current Weather Data
     ↓
Application UI
```

This allows travelers to consider current conditions when planning activities.

---

### Interactive Maps

The application includes map functionality for displaying tourist destinations and supporting navigation.

The project uses mapping concepts based on **OpenStreetMap**.

Features include:

- Destination location display
- Map markers
- Map navigation
- Location visualization

---

### Accommodation

Khotwah includes accommodation workflows allowing users to:

- Explore hotels
- Select accommodation
- Choose booking dates
- View booking information
- Manage booking-related actions

---

## Software Engineering Process

The project was developed using structured software engineering practices including:

- Requirements analysis
- Product backlog creation
- Functional requirements
- Use-case modeling
- Sequence diagrams
- Class modeling
- Activity diagrams
- Architectural design
- Prototyping
- Implementation
- Functional testing

---

## System Design

The project includes several UML and software design artifacts.

### Use-Case Diagram

Defines interactions between:

- User
- Administrator
- Service Provider
- Tourist Guide System

Major use cases include:

```text
Registration
Manage Itinerary
Search Tourist Places
View Tourist Place Details
Receive Real-Time Updates
Book Accommodation
Manage Users
Manage Tourist Places
```

### Sequence Design

The system models communication between application components and external services such as:

```text
User
 ↓
Khotwah
 ↓
Search Controller
 ↓
Tourist Places Data

       + Weather Service
       + Map Service
       + Booking Service
```

---

## Functional Testing

The project includes test cases covering:

- Login
- Sign-up
- Destination search
- Itinerary creation
- Real-time weather
- Map functionality
- Application navigation
- User profile
- Accommodation booking

Testing was used to identify both working functionality and areas requiring further development.

---

## Technology Stack

### Application Development

`Flutter` `Dart`

### Architecture

`MVC`

### Services & Features

`REST APIs` `Weather Services` `OpenStreetMap`

### Software Engineering

`UML` `Requirements Engineering` `System Design` `Functional Testing`

### Platforms

`Android` `iOS` `Web` `Windows` `macOS` `Linux`

---

## Repository Structure

```text
khotwah-app/
│
├── android/
├── ios/
├── lib/
├── linux/
├── macos/
├── test/
├── web/
├── windows/
│
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
├── .gitignore
└── README.md
```

The main Flutter application source code is located inside:

```text
lib/
```

---

## Development Workflow

```text
Requirements
     ↓
Product Backlog
     ↓
System Modeling
     ↓
Architecture Design
     ↓
Prototype
     ↓
Flutter Development
     ↓
API / Service Integration
     ↓
Functional Testing
     ↓
Iteration
```

---

## Known Limitations

The project was developed as an academic software engineering prototype, and some functionality requires additional refinement.

Future development can improve:

- Destination search reliability
- Itinerary editing
- Map interaction
- Profile navigation
- Backend integration
- Offline capabilities
- Production-level authentication
- External service integration

---

## Future Improvements

- Complete backend architecture
- Cloud-based user data storage
- Improved authentication and authorization
- Advanced itinerary recommendations
- Real-time tourism event integration
- Improved map routing
- Offline map support
- Multilingual support
- Ratings and reviews
- AI-based personalized travel recommendations

---

## Academic Project

**Course:** Software Engineering — CS290  
**University:** Al-Imam Mohammad Ibn Saud Islamic University  
**Project:** Tourist Guide System — Khotwah

This was developed as a team software engineering project.

---

## Author

**Meshal Alqahtani**

AI & Data Science | AI Solution Architecture | Computer Vision | Generative AI
