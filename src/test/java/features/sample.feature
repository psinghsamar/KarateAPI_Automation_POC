Feature: Sample API checks

  Background:
    * url baseUrl

  Scenario: Health check (example)
    Given path 'health'
    When method get
    Then status 200

