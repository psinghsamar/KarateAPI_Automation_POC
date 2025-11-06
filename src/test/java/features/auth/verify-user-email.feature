Feature: Verify user with email (preauth)

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * if (auth && auth.token) header Authorization = 'Bearer ' + auth.token

  Scenario: POST /auth/v2/preauth/verifyUser
    * def userEmail = karate.get('email') || 'test@example.com'
    Given path 'auth/v2/preauth/verifyUser'
    And request { customer: { email: '#(userEmail)' }, registrationType: 'EMAIL' }
    When method post
    Then status 200
    And match response == '#object'
    * def stateToken = response.stateToken || response.data && response.data.stateToken ? response.data.stateToken : null

