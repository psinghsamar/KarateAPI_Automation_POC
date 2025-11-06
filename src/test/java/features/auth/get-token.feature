Feature: Obtain OAuth token (template)

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'

  # Adjust body/params to match your auth server.
  # If you already have a token, you can pass -Dtoken=... and skip calling this.
  Scenario: POST /auth/v1/token
    Given path 'auth/v1/token'
    And param scope = 'esa.svc.guest'
    And request { grant_type: 'client_credentials', client_id: '#(clientId)', client_secret: '#(clientSecret)' }
    When method post
    Then status 200
    And match response == '#object'
    * def accessToken = response.access_token || response.token || null

