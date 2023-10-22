# Be Reminded System

*A dockerized system for creating TODO list for a team. See the list of all TODO's and have an option to mark it DONE. You can also register a new user of the app.*

# Table of contents

- [Tecnology Used](#technology-used)
- [Installation](#installation)
- [Test Flutter Web](#test-flutter)
- [Test Springboot Server](#test-server)
- [View Database](#database)

# Technology Used

[(Back to top)](#table-of-contents)

- Docker
- Spring Boot with GraphQL and hibernate ORM implementation
- Flutter Web
- Postgres and PgAdmin

# Installation

[(Back to top)](#table-of-contents)

1. [Download](https://docs.docker.com/engine/install/) and install Docker. 
2. [Download](https://gradle.org/install/) and install Gradle. 
 *Note: Needed temporarily. This will be removed on the next push*
2. [Update Server conf property](#custom-configurations).  *Note: Needed temporarily. This will be removed on the next push*
3. Start and run all the docker services by running: `docker-compose up -d`
4. Wait for all the containers to run

# Test Flutter

[(Back to top)](#table-of-contents)

1. Access flutter web app: [http://localhost:8081/](http://localhost:8081/)
2. Register account for new user
3. Login to test other functionalities

# Test Server

[(Back to top)](#table-of-contents)

1. Test the following GraphQL requests to [http://localhost:8082/graphql](http://localhost:8082/graphql) using POSTMAN. 

## Login API

```graphql
mutation {
  login(loginUserInput: {username: "admin",password: "admin"}){
      id
      username
      name
      accessToken
  }
}
```

## Register User API

```graphql
mutation {
  registerUser(registerUserInput: {
    name: "test",
    username: "test",
    password: "test"
    }){
      id
  }
}
```

## List All Reminders

```graphql
query {
  getAllReminders{
      id
      title
      description
      isDone
      created
      updated
  }
}

Headers:
{
   "Authorization": "Bearer <access_token>"
}
```

## Get a Reminder

```graphql
query {
  getReminder(id:"035e16b2-6bf7-4694-99d0-24942b88e39f"){
      id
      title
      description
      isDone
      created
      updated
  }
}

Headers:
{
   "Authorization": "Bearer <access_token>"
}
```

## Create a Reminder

```graphql
mutation {
  mutation {
  addReminder(addReminderInput: {title: "test",description: "test",isDone: false}){
      id
      isDone
  }
}
}

Headers:
{
   "Authorization": "Bearer <access_token>"
}
```

## Update a Reminder

```graphql
mutation {
  updateReminder(updateReminderInput: {
      id:"035e16b2-6bf7-4694-99d0-24942b88e39f",
      title: "test",
      description: "test",
      isDone: true
      }){
        id
      title
      description
      isDone
      created
      updated
  }
}

Headers:
{
   "Authorization": "Bearer <access_token>"
}
```

# Database

[(Back to top)](#table-of-contents)

1. After starting up the Postgres and pgAdmin services, access the PgAdmin portal: [http://localhost:5051/](http://localhost:5051/)
2. Login using the default admin credentials:

```
Email: admin@admin.com
Password: admin
```

3. To view all the databases, create a new server with the following values:

```
Name: bereminded-postgres
Host Name/Address: localhost
Port: 5431
Maintenance database: bereminded
Username: admin
Password: postgres
```

# Custom configurations

[(Back to top)](#table-of-contents)

1. Change springboot-graphql-server\src\main\resources\application.properties `spring.datasource.url` and change the host to your ip address. Eg., from ```jdbc:postgresql://192.168.1.15:5431/bereminded``` to ```jdbc:postgresql://<ip_address>:5431/bereminded```
3. Run `gradle bootJar` from springboot-graphql-server
4. Copy springboot-graphql-server-0.0.1-SNAPSHOT.jar generated from springboot-graphql-server/build/ to  springboot-graphql-server/

