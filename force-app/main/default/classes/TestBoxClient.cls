/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestBoxClient {

   @IsTest
    public static void testAuthenticate() {
        // Create a mock BoxClientCredentialsGrant__mdt record
        String boxClientCredentialsName = 'TestCredentials';
        String clientId = '123456';
        String clientSecret = '789012';
        String subjectType = 'user';
        String subjectId = '12345';
        String asUserId = '12345';

        BoxClientCredentialsGrant__mdt boxClientCredentialsGrant = new BoxClientCredentialsGrant__mdt(
            Label = boxClientCredentialsName,
            BoxClientId__c = clientId,
            BoxClientSecret__c = clientSecret,
            BoxSubjectType__c = subjectType,
            BoxSubjectId__c = subjectId
        );

        // Set up the mock metadata
        CustomMetadataBuilder.insertMockMetadata(
            new List<BoxClientCredentialsGrant__mdt>{ boxClientCredentialsGrant }
        );

        // Create a test BoxClient instance
        BoxClient boxClient = new BoxClient();

        // Authenticate with the mock credentials
        boxClient.authenticate(boxClientCredentialsName);

        // Verify that the access token and other properties are set correctly
        System.assertEquals(clientId, boxClient.clientId);
        System.assertEquals(clientSecret, boxClient.clientSecret);
        System.assertEquals(subjectType, boxClient.subjectType);
        System.assertEquals(subjectId, boxClient.subjectId);
        System.assertEquals('test-access-token', boxClient.accessToken);
        System.assertEquals('test-refresh-token', boxClient.refreshToken);
        System.assertEquals(12345, boxClient.lastRefresh);
        System.assertEquals(600, boxClient.expires);
        System.assertEquals('https://api.box.com/oauth2/token', boxClient.baseUrl);
        System.assertEquals('https://upload.box.com/api', boxClient.baseUploadUrl);
        System.assertEquals(asUserId, boxClient.asUserId);
    }

}