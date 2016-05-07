# DIRT: Durham Incident Report Tracker API
A backend solution to Tina's problems

API documentation is available [here]
(https://github.com/tuftsdev/comp120-spring2016-team2-api/blob/master/DOC.txt).

Access the frontend and primary documentation 
[here](https://github.com/tuftsdev/comp120-spring2016-team2).

## How to build
### On the server, run
- `bundle install`
- `ruby app.rb`

#### DIRT API uses the following environment variables 
- 'DIRT_USERNAME' the MySQL user with which to access the database
- 'DIRT_PASSWORD' the password of the above MySQL user
- 'DIRT_HOST'     the host running MySQL, e.g. localhost
- 'DIRT_DATABASE' the name of the database for DIRT API to use

##API Design choices
We built our API using sinatra.  We chose Sinatra because of it is very
lightweight compared to Rails and therefore easier to manage for a simple
CRUD application like DIRT.  We built an API at the beginning of our
project because it allows for complete separation of concerns between
the frontend and the backend.  This separation means creating new interfaces
(ie. mobile web, iOS/Android app, etc) doesn't require any adjustments to be
made on the server side.  We also planned to create a refresh-free version of
our interface in the future, and this is very easy to implement
when using an API. 

## Unit Testing
Tests can be found in the features folder of this repository.
Run with `cucumber features`.

### Why Cucumber?
In order to test for as many scenarios as possible, it is important that
our tests are easy to understand and are clearly defined. Cucumber allows
us to write very comprehensive tests without getting lost in test code because
of the .feature file. Though it is more complicated than other test frameworks,
we are willing to spend the extra time needed to create a more thorough and
easy-to-understand test suite.

Our decision was also influenced by the fact that a member of our team had 
experience using Cucumber.

## Considering n Users
Our api is running on a wimpy-ass VPS. Odds are, it can not handle the volume
of requests desired by the client. With our budget of $0.00 for hosting, we
are making due. Tina and her crew can host this on their own metal or pay for
hosting if they want to handle more users.

### Photo Uploading
After researching possible ways to deal with them, our team decided to use S3 to store images that the user can upload with an incident.  Instead of using our server as a middleman between client and S3, we originally wanted to retrieve a one-time-use upload link from S3 that would be passed to the front-end.  Using this method, however, proved much more complicated than anticipated due to poor documentation.  We are currently passing images from our front-end to our API, which then uploads the files to S3 and stores a link to the image in our database as part of the corresponding incident.  The link allows anyone with it to view the image.  File sizes are limited via nginx.

## Final Leg: RabbitMQ and DigitalOcean

### Message Queues
For the final leg of this project, our team decided to implement message queue middleware. Message queues allow for further decoupling of the backend from the frontend and scalability. This also helps efficiency of information flow whenever there are spikes in the number of users using our app. 

### RabbitMQ
RabbitMQ is a messaging broker that offers a common platform for our frontend and backend to send and receive messages. RabbitMQ uses the technology of websockets, so it makes real-time communications between our frontend and backend possible, and replaces our previous need to poll the server every few seconds. Some features that RabbitMQ offers include reliability, flexible routing, and a variety of plugins for specific needs. For our frontend, we had to use the Web-Stomp Plugin, which makes it possible to use RabbitMQ from web browsers by exposing the STOMP protocol over websockets. By using this plugin, we can simply follow the STOMP protocol to receive incoming messages from the backend. For our backend, we simply create a queue called "incidents" for each client we are communicating with, and send new and edited incidents through a fanout exchange (the fanout exchange simply a type of routing that sends the same information to every queue).

### Digital Ocean
Several weeks before the final project was due, we noticed some inconsistencies with the server that was hosting our backend. We decided to use digital ocean to host and redo the server-side of the app. We did this as a team so that more members would get experience with setting up a server, and so that we would produce a server we can all understand and access. Furthermore, creating this server allowed us to demonstrate how easy it was to swap out one server with another, without needing to change things about the frontend or RabbitMQ. This highlights the independence of the backend and frontend and modularity that RabbitMQ implies.


## Contributors
- [Max Ettelson](http://github.com/mdettelson)
- [Chris Hinstorff](http://github.com/chinstorff)
- [Janeth Jepkogei](http://github.com/janethjepkogei)
- [Erica Schwartz](http://github.com/ericaschwa)
- [Norman Young](http://github.com/nyoung01)
