Feature: Pre-auth email verification flow

  Background:
    * url baseUrl
    * header Content-Type = 'application/json'
    * if (auth && auth.token) header Authorization = 'Bearer ' + auth.token

  Scenario: Create session → verify user by email → send OTP → verify OTP (if provided)
    # 1) Create session
    * def cc = karate.get('countryCode') || 'US'
    * def lang = karate.get('language') || 'en'
    * def extRef = karate.get('externalReferenceNo') || '1'
    Given path 'auth/v1/preauth/session/create'
    And request { businessMode: 'DIGITAL', externalReferenceNo: '#(extRef)', locale: { countryCode: '#(cc)', languageCode: '#(lang)' } }
    When method post
    Then status 200

    # 2) Verify user (EMAIL)
    * def userEmail = karate.get('email') || 'test@example.com'
    Given path 'auth/v2/preauth/verifyUser'
    And request { customer: { email: '#(userEmail)' }, registrationType: 'EMAIL' }
    When method post
    Then status 200
    * def stateToken = response.stateToken || response.data && response.data.stateToken ? response.data.stateToken : null

    # 3) Send OTP
    Given path 'auth/v2/preauth/stateFactor/send'
    And request { deviceAuthType: 'EMAIL', stateToken: '#(stateToken)' }
    When method post
    Then status 200

    # 4) Verify OTP only if -Dotp=<code> provided
    * def otp = karate.properties['otp']
    * if (otp) karate.log('Verifying OTP with provided code')
    * if (otp)
    """
    Given path 'auth/v2/preauth/stateFactor/verify'
    And request { otp: '#(otp)', deviceAuthType: 'EMAIL', stateToken: '#(stateToken)' }
    When method post
    Then status 200
    """

