function fn() {
  var env = karate.env || 'dev';
  var config = { baseUrl: 'http://localhost:8080' };

  if (env === 'qa') {
    config.baseUrl = 'https://qa.example.com';
  } else if (env === 'stage') {
    config.baseUrl = 'https://stage.example.com';
  } else if (env === 'prod') {
    config.baseUrl = 'https://api.example.com';
  }

  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 10000);
  
  // data & auth provided via -D properties when running
  config.auth = { token: karate.properties['token'] };
  config.email = karate.properties['email'] || 'test@example.com';
  config.countryCode = karate.properties['countryCode'] || 'US';
  config.language = karate.properties['language'] || 'en';
  config.externalReferenceNo = karate.properties['externalReferenceNo'] || '1';
  config.password = karate.properties['password'] || 'Welcome@1234';
  config.nationality = karate.properties['nationality'] || 'AU';
  config.otp = karate.properties['otp'];
  config.clientId = karate.properties['clientId'];
  config.clientSecret = karate.properties['clientSecret'];
  return config;
}

