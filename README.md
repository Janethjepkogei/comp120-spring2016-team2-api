# DIRT: Durham Incident Report Tracker API
A backend solution to Tina's problems

Access the frontend and primary documentation [here](https://github.com/tuftsdev/comp120-spring2016-team2).

## How to build
### On the server, run
- `bundle install`
- `ruby app.rb`

#### DIRT API uses the following environment variables 
- 'DIRT_USERNAME' the MySQL user with which to access the database
- 'DIRT_PASSWORD' the password of the above MySQL user
- 'DIRT_HOST'     the host running MySQL, e.g. localhost
- 'DIRT_DATABASE' the name of the database for DIRT API to use

##Live URL
http://tuftsdev.github.io/comp120-spring2016-team2/index.html

## Unit Testing
Tests can be found in the features folder of this repository.

### Why Cucumber?
In order to test for as many scenarios as possible, it is important that our tests are easy to understand and are clearly defined. Cucumber allows us to write very comprehensive tests without getting lost in test code because of the .feature file. Though it is more complicated than other test frameworks, we are willing to spend the extra time needed to create a more thorough and easy-to-understand test suite.

Our decision was also influenced by the fact that a member of our team (Max) had experience using Cucumber, and no one else had any experience with the others.

### User Testing
We asked several people for their input on our current user interface, and most of the feedback given is frontend-specific. Many of them like how the page looks; however, they do see the mostly empty space on the right side of the page as a problem. Suggestions on what to fill the unused space with were made by these users, such as putting a field that helps to see the trend of what is going on in the table. We have taken this feedback and will consider this as we further develop our frontend.

## Considering n Users
Our team has been thinking about how we will ensure that the app can handle 15,000 unique visits per day, once it is in production. As our product stands at this point in the development process, it could not handle that many users. Future improvements that we plan to look into include optimization of static content, especially since a large portion of our product involves static content. We could use Content Delivery Networks to store some of our content, use compression, and also make our static information cachable (via application cache). 

## Contributors
- [Max Ettelson](http://github.com/mdettelson)
- [Chris Hinstorff](http://github.com/chinstorff)
- [Janeth Jepkogei](http://github.com/janethjepkogei)
- [Erica Schwartz](http://github.com/ericaschwa)
- [Norman Young](http://github.com/nyoung01)
