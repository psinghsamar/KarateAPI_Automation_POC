# KarateAPI_Automation_POC
This repo is for api automation using karate framework

## Getting Started

### Prerequisites
- Java 17+
- Maven 3.9+

### Run tests
```bash
mvn test
```

Run a specific runner or set env:
```bash
mvn -Dtest=runners.ApiRunner test
mvn -Dkarate.env=qa test
```

The base URL is configured via `karate-config.js` using `karate.env` (`dev`, `qa`, `stage`, `prod`).

You can pass data via system properties (examples below):

```bash
# set base env and data
mvn -Dkarate.env=qa \
    -Dtoken="<bearer-token>" \
    -Demail="user@example.com" \
    -DcountryCode=US -Dlanguage=en \
    -DexternalReferenceNo=1 \
    test

# run the preauth flow and verify OTP
mvn -Dtest=runners.ApiRunner -Dkarate.options="--tags @preauth" -Dotp=123456 test
```

### Project layout
```
src/test/java
  ├─ karate-config.js       # env, baseUrl, timeouts
  ├─ runners/ApiRunner.java # JUnit5 runner
  └─ features/              # place your .feature files here
       └─ auth/             # auth and preauth scenarios from Postman
```

## From Postman to Karate

Since this repo currently has screenshots of Postman requests, please also export the actual Postman collection to JSON (v2.1):
- In Postman, click the three dots on your collection → Export → Collection v2.1

You can then convert/import in either of these ways:
1. Karate Studio (recommended): import the Postman collection and export as Karate feature files, then place them under `src/test/java/features`.
2. Manual: translate each request to a scenario, e.g.

```gherkin
Feature: My API

  Background:
    * url baseUrl

  Scenario: GET /users
    Given path 'users'
    When method get
    Then status 200
```

Add assertions (status codes, response fields) to match your Postman tests.

## Implemented from your screenshots

Under `src/test/java/features/auth` you now have:
- `get-token.feature`: template to obtain access token
- `create-session.feature`: POST `/auth/v1/preauth/session/create`
- `verify-user-email.feature`: POST `/auth/v2/preauth/verifyUser`
- `state-factor-send.feature`: POST `/auth/v2/preauth/stateFactor/send`
- `state-factor-verify.feature`: POST `/auth/v2/preauth/stateFactor/verify`
- `add-customer.feature`: POST `/auth/v2/preauth/register/customer`
- `preauth-flow.feature`: end-to-end: create session → verify email → send OTP → verify OTP (if `-Dotp` provided)

To run only the auth folder:

```bash
mvn -Dkarate.options="classpath:features/auth" test
```