Feature: Adding Incidents
#  Scenario: Add 1 incident to the database
#    When I add an incident report to the database
#    Then The incident report entry is returned
#    And I can retrieve the incident from the database
#
#  Scenario: Add 100 incidents to the database
#   When I add 100 incident reports to the database
#   Then I can retrieve all 100 incident reports from the database

  Scenario: Attempting to add incidents with bad data
    When I add an incident with inappropriate date value
    Then I receive the error message "Failed to create incident"
    When I add an incident with inappropriate severity value
    Then I receive the error message "Failed to create incident"
#    When I add an incident with inappropriate location value
#    Then I receive the error message "Failed to create incident"
    When I attempt to add an incident with extraneous data
    Then The incident report entry is returned
    And I can retrieve the incident from the database
#
#  #Scenario: Attempting cross-site scripting
#
#
#
#Feature Editing Incidents
#  Scenario: Editing an incident stored in the database
#    When I attempt to give an incident an inappropriate status value
#    Then I receive the error message "Failed to update status"
#    When I attempt to give an incident an inappropriate location value
#    Then I receive the error message "Failed to update location"
#    When I attempt to give an incident an inappropriate severity value
#    Then I receive the error message "Failed to update severity"
#    When I attempt to give an incident an inappropriate description value
#    Then I receive the error message "Failed to update description"
#
#  Scenario: