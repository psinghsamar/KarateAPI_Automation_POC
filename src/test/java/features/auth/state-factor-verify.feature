Feature: Verify state factor (OTP)

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * if (auth && auth.token) header Authorization = 'Bearer ' + auth.token

  Scenario: POST /auth/v2/preauth/stateFactor/verify
    * def token = karate.get('stateToken') || stateToken
    * def otp = karate.get('otp') || karate.properties['otp'] || '000000'
    Given path 'auth/v2/preauth/stateFactor/verify'
    And request { otp: '#(otp)', deviceAuthType: 'EMAIL', stateToken: '#(token)' }
    When method post
    Then status 200
    And match response == '#object'

