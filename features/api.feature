Feature Adding Incidents
  Scenario: Add 1 incident to the database
    When I add an incident report to the database
    Then I can retrieve the incident from the database

  Scenario: Add 100 incidents to the database
    When I add 100 incident reports to the database
    Then I can retrieve all 100 incident reports from the database

  Scenario: Attempting to add bad data
    When I add an incident with inappropriate date value
    Then I receive an error message
    When When I add an incident with inappropriate name value
    Then I receive an error message
    When I add an incident with inappropriate severity value
    Then I receive an error message
    When When I add an incident with inappropriate location value
    Then I receive an error message

  Scenario: Attempting cross-site scripting



Feature Editing Incidents
  Then When I attempt to give an incident an inappropriate status value