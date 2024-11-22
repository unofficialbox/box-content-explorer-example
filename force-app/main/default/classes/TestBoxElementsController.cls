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
private class TestBoxElementsController {

    @IsTest
    public static void testGetVFOrigin() {
        Test.startTest();
        String vfOrigin = BoxElementsController.getVFOrigin();
        Test.stopTest();

        // Add assertions here to validate the actual response
        System.assertNotEquals(null, vfOrigin, 'The Visualforce origin should not be null');
    }

    @IsTest
    public static void testDownscopeToken() {
        // Create a test record for the BoxItem and insert it into the database
        BoxItem__c boxItem = new BoxItem__c();
        boxItem.Id = '12345';
        boxItem.BoxItemID__c = '12345';
        insert boxItem;

        // Call the downscopeToken method with the ID of the BoxItem record
        Map<String, String> downscopedToken = BoxClient.downscopeToken('boxItem', boxItem.Id, boxItem.BoxItemID__c, 'item_download');

        // Assert that the downscopedToken map contains the 'access_token' key
        System.assert(downscopedToken.containsKey('access_token'));

        // Assert that the 'access_token' value is not null
        System.assertNotEquals(null, downscopedToken.get('access_token'));
    }

}