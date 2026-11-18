param location string = 'eastus'
param webTestName string = 'test-nginx-availability'
param requestUrl string
param appInsightsResourceId string

resource webTest 'Microsoft.Insights/webTests@2022-06-15' = {
  name: webTestName
  location: location
  kind: 'standard'
  tags: {
    'hidden-link:${appInsightsResourceId}': 'Resource'
  }
  properties: {
    Name: webTestName
    SyntheticMonitorId: webTestName
    Description: 'Monitors Nginx website availability'
    Enabled: true
    Frequency: 300
    Timeout: 30
    Kind: 'standard'
    RetryEnabled: true
    Locations: [
      {
        Id: 'us-fl-mia-edge'
      }
    ]
    Request: {
      RequestUrl: requestUrl
      HttpVerb: 'GET'
      FollowRedirects: true
      ParseDependentRequests: false
    }
    ValidationRules: {
      ExpectedHttpStatusCode: 200
      IgnoreHttpStatusCode: false
      SSLCheck: false
    }
  }
}
