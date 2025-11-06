Feature: Send state factor (OTP) via email

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * if (auth && auth.token) header Authorization = 'Bearer ' + auth.token

  Scenario: POST /auth/v2/preauth/stateFactor/send
    * def token = karate.get('stateToken') || stateToken
    Given path 'auth/v2/preauth/stateFactor/send'
    And request { deviceAuthType: 'EMAIL', stateToken: '#(token)' }
    When method post
    Then status 200
    And match response == '#object'

