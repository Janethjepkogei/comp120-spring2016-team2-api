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

## Unit Testing
Tests can be found in the features folder of this repository.
Run with `cucumber features`.

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

## Contributors
- [Max Ettelson](http://github.com/mdettelson)
- [Chris Hinstorff](http://github.com/chinstorff)
- [Janeth Jepkogei](http://github.com/janethjepkogei)
- [Erica Schwartz](http://github.com/ericaschwa)
- [Norman Young](http://github.com/nyoung01)
