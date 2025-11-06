Feature: Register customer (preauth)

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * if (auth && auth.token) header Authorization = 'Bearer ' + auth.token

  Scenario: POST /auth/v2/preauth/register/customer
    * def userEmail = karate.get('email') || 'test@example.com'
    Given path 'auth/v2/preauth/register/customer'
    And request {
      customer: {
        progressiveRegistration: true,
        credential: { password: '#(password || "Welcome@1234")' },
        nationality: '#(nationality || "AU")',
        captcha: { id: null },
        communicationConsent: { sms: true, email: true, push: true },
        termsCondition: true,
        email: '#(userEmail)'
      }
    }
    When method post
    Then status 200
    And match response == '#object'

