Feature: Create preauth session

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * if (auth && auth.token) header Authorization = 'Bearer ' + auth.token

  Scenario: POST /auth/v1/preauth/session/create
    * def cc = karate.get('countryCode') || 'US'
    * def lang = karate.get('language') || 'en'
    * def extRef = karate.get('externalReferenceNo') || '1'
    Given path 'auth/v1/preauth/session/create'
    And request { businessMode: 'DIGITAL', externalReferenceNo: '#(extRef)', locale: { countryCode: '#(cc)', languageCode: '#(lang)' } }
    When method post
    Then status 200
    And match response == '#object'
    * def sessionId = response.sessionId || response.id || null

