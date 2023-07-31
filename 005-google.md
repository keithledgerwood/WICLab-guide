## Configure SSO and LCM for Google Workspace


## Demo setup guide

Overview

This guide provides instructions for integrating Okta with Google Workspace so that the following use cases can be demonstrated:



* Single Sign-on (SSO) from Okta to Google Workspace
* Lifecycle Management (LCM) for Google Workspace

```
Info!
You will find the credentials to your Google Workspace account and the custom DNS domain in the hand-out document.
```

Before you can complete this guide you must have already signed up for a Google Workspace account which, in turn, requires a custom DNS domain.  You should also enable the “Cloud Identity Free” subscription so that you can create users without getting charged for them.


# Introduction

Google Workspace is a full productivity suite available in the cloud.  It provides email, calendar, and file-sharing as well as productivity tools for documents, spreadsheets, and presentations.

Google Workspace supports inbound single sign-on using the SAML 2.0 protocol.

Google Workspace allows management of users and groups via its REST APIs which are protected by OAuth 2.0.

During integration, you will be asked for your Google company domain.  If you don’t know what this is, you can find it in your Google Workspace Admin UI under **Account > Domains > Manage domains**:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image1.png "image_tooltip")


Note that in this example the domain is a subdomain (**ws**.yourdemodomain.com) in order to allow Google to share the domain with Microsoft 365.


# Configure single sign-on


## Add Google Workspace Application to Okta

Okta maintains a specific integration for Google Workspace in the Okta Integration Network (OIN).  To add this to your Okta org, follow these steps:



1. Use a browser to open the administration UI of your Okta demo org and sign in as an administrator.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image2.png "image_tooltip")


2. Navigate to **Applications > Applications**
3. Click **Browse App Catalog** to open the Okta Integration Network browser.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image3.png "image_tooltip")


4. Search for and select the **Google Workspace **integration.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image4.png "image_tooltip")


5. Click **Add integration**. \
The _Add Google Workspace _wizard opens on the _General Settings _page:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image5.png "image_tooltip")


6. Complete the **Your Google Apps company domain **field.  This must match the DNS domain you used when setting up your Google Workspace account.  If you are sharing this DNS domain with Microsoft 365, you will likely be using a sub-domain here (e.g. **ws.**yourdemodomain.com).
7. Click **Next**. \
You are taken to the _Sign-On Options _page of the wizard.


## Configure SSO in Okta


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image6.png "image_tooltip")
 \
This integration supports both Secure Web Authentication (SWA), for password injection, and SAML 2.0, for federated single sign-on.



8. Select the radio button for **SAML 2.0**.

    Note the options to set a default relay state and to add attributes to the attribute statement or group statement within SAML 2.0 messages. You don’t need these for the demo setup.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image7.png "image_tooltip")


9. While you’re here, click the **View Setup Instructions** button.  This will open org-specific instructions for setting up Google Workspace to receive SAML 2.0 assertions from your Okta org.  It will open in a new tab which you’ll refer to later on.
10. Go back to the tab where the Okta administration UI is open:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image8.png "image_tooltip")



    Under _Credential Details_, you can specify the _Application username format_.  This determines the username that is passed to Google in single sign-on messages if provisioning is not enabled.  It also sets the default username that will be used to create accounts in Google when provisioning is enabled. 


    The application username format should be an email address where the domain matches the Google company domain of the Google tenant you’re linking to. To ensure this, you will use a custom expression which replaces the domain part of the Okta username with the Google company domain.

11. Set _Application username format_ to **Custom**.
12. Enter the following for the expression - replacing _ws.yourdemodomain.com_ with your own Google company domain:

        **String.substringBefore(user.login,"@") + "@ws.yourdemodomain.com"**


    This will create the Google username by taking the part of the Okta username attribute (okta.login) before the @ sign and then adding @ws.yourdemodomain.com. \
For example, _your.name**@**atko.email_ would become_ your.name**@**_ws._yourdemodomain.com_.

13. Click **Done**. \
The wizard completes.

Your Okta org is now configured to send SAML 2.0 assertions to Google Workspace for single sign-on.  You must now configure Google Workspace so that it will trust these assertions.


## Get required information from Okta

During the configuration of Google Workspace, you will need several pieces of information from Okta.  These are all dynamically included in the setup instructions which you opened in the preview section.



1. Go to the browser tab that includes the setup instructions for Google Workspace and scroll down to find the dynamic information fields:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image9.png "image_tooltip")



    Notice the _Sign-in page URL_, _Sign-out page URL_, and _Change password URL_.  You will need all of these in the next section.

2. Click the link for the **Verification certificate**. \
This will initiate a file download.
3. Save the certificate file on your local machine.


## Configure SSO in Google Workspace

You will now use the information gathered above to configure Google Workspace for single sign-on.



1. Open a new browser tab and navigate to: [https://www.google.com](https://www.google.com).
2. Login to Google using the Google Workspace credentials of your administrator account.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image10.png "image_tooltip")


3. Click the applications icon and select the **Admin** application. \
The Admin UI for Google Workspace is opened:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image11.png "image_tooltip")


4. Navigate to **Security > Authentication > SSO with third party IdP.**
5. Click the **Edit icon** for _Third-party SSO profile for your organization_.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image12.png "image_tooltip")


6. Copy and paste the _Sign-in page URL_ and _Sign-out page URL_ from the setup instructions.
7. Click UPLOAD CERTIFICATE and upload the certificate file that you download from the setup instructions.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image13.png "image_tooltip")


8. Select the checkbox for **Use a domain specific issuer**. \
This tells Google to expect SAML assertions with an issuer that is specfic to the Workspace domain. This is how Okta sends the issuer and it needs to match.
9. Copy and paste the _Change password URL _from the setup instructions.
10. Click **Save**.

Single sign-on is now configured.  The next step is to configure provisioning.


# Configure provisioning

The single sign-on configuration performed in the previous section allows your Okta org to assert identity information to your Google account and it allows your Google account to trust it.  However that’s not enough for single sign-on to complete.  Each identity asserted by Okta must link to an existing account in Google Workspace.

The required Google Workspace accounts could be created manually but, in this case, you will set up provisioning in Okta so that it can automatically manage accounts in Google Workspace.  It will create accounts when users are assigned to the Google Workspace application and deactivate these accounts when users are unassigned.  It will also manage user attributes.

You’ll also run a one-time import and link your Okta admin user with your Google admin account. This shows how existing accounts can be assigned to Okta users.


## Enable integration

Accounts in Google Workspace can be managed via Google REST APIs.  To enable provisioning, Okta must be granted authority to call these APIs.  Follow the steps below to grant this access and enable integration:



1. If you are not already there, open your Okta administration UI, navigate to **Applications > Applications**, and select the **Google Workspace** application definition.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image14.png "image_tooltip")


2. Click on the **Provisioning **tab and click the **Configure API integration** button.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image15.png "image_tooltip")


3. Check the checkbox for **Enable API integration**.
4. Click the **Authenticate with Google Workspace **button.
5. Authenticate as the administrative user for your Google Workspace tenant. \
A consent box is shown requesting that you grant permissions to Okta:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image16.png "image_tooltip")


6. Click **Allow** to allow your Okta org to manage users in Google Workspace.

    Back in the Okta administration UI, you will see success messages:
   

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image17.png "image_tooltip")


7. Click **Save**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image18.png "image_tooltip")



    The API connection for provisioning is now in place. Provisioning configuration is now shown under the _Provisioning _tab.  The integration configuration you just created is under the _Integration_ tab.


    There are two provisioning directions supported by this integration:


    **To App **- This is provisioning from Okta to Google Workspace.  This is the integration you configure if you want Okta to manage accounts in Google Workspace.


    **To Okta** - This is provisioning from Google Workspace to Okta.  This is the integration you would set up if you want to create Okta accounts when users are created in Google Workspace.  It can also be used to match accounts created in Google Workspace to users in Okta.



## Enable provisioning to app

In this section you will enable provisioning to Google Workspace.  This will include creation of accounts in Google Workspace when users are assigned to the application, updating attributes in Google Workspace when things change in Okta, and deactivating accounts in Google Workspace when users are unassigned from the application in Okta.

Note: In general, Okta does not delete accounts from applications - it only deactivates them.  This ensures that Okta is not responsible for any data loss in the backend system that could be triggered by deleting an account.

Follow these steps to enable provisioning:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image19.png "image_tooltip")



    You should already be on the _To App_ tab under _Provisioning_.



1. Click **Edit** to set the options for Okta provisioning to Google Workspace.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image20.png "image_tooltip")


2. Click the **Enable **checkbox for **Create Users**.
3. Click the Enable checkbox for Update User Attributes.
4. Click the **Enable **checkbox for **Deactivate Users**.

        Sync Password is not enabled.  When federation is enabled for single sign-on, no password is required in Google Workspace because users will authenticate in Okta and be asserted to Google Workspace based on the trusted federation relationship.

5. Click **Save**.

Provisioning is now enabled.


# Import Google Workspace admin account

In this section you will import the Google Workspace super admin account into Okta and assign the account to your Okta admin user.  Once this is done, you’ll be able to perform single sign-on from your Okta admin account to your Google super admin account.


## Configure import

In this section you will configure inbound provisioning from Google Workspace to Okta.  This will allow you to perform a one-time import so you can assign the existing Google super admin account to your Okta admin user.

In fact, you could perform this one-time import without doing any configuration, and manually match the account, but it makes sense to set up account matching for completeness.  Follow these steps:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image21.png "image_tooltip")




1. Select the **Provisioning** tab in the Google Workspace app definition.
2. Select **To Okta**.
3. Click **Edit** to edit the import settings.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image22.png "image_tooltip")



    The _Okta username format _specifies the Okta username that will be used if a new user needs to be created to own an imported Google account.  You will use a custom expression to specify a replacement domain which does not include the **ws** subdomain.

4. Select **Custom** for _Okta username format_.
5. Enter the following expression:

        **String.substringBefore(appuser.userName,"@") + "@yourdemodomain.com"**

6. Click **Save**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image23.png "image_tooltip")



    You now need to change the creation and matching setting so that it matches based on the Okta username rather than email address.

7. Click **Edit **in the _User Creation & Matching_ section.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image24.png "image_tooltip")


8. For _Imported user is an exact match to Okta user if_, select radio button for **Okta username format matches**.
9. Click **Save**.


## Perform one time import

You will now perform a one-time import from Google Workspace.  This will import your Google admin account and attempt to match it to an existing Okta user.

Follow these steps:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image25.png "image_tooltip")




1. Select the **Import** tab in the Google Workspace application definition.
2. Click **Import Now**. \
This initiates a one time import operation.  When complete you will see a status pop-up:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image26.png "image_tooltip")


3. Click **OK**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image27.png "image_tooltip")



    The import results show that your Google admin account has been imported and, in this case, tentatively associated with the Okta admin user based on a partial match (first and last names match).


    While you’re here, it’s worth looking at the options you have for an imported account.

4. Click the **arrow icon** in the suggested action box.  You could:
    * Accept the suggested partial match
    * Create a new Okta user to own the Google account
    * Assign the account to an existing Okta user
    * Ignore this user (don’t match it and don’t show in subsequent imports)
5. Click the **arrow icon** again to close the options.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image28.png "image_tooltip")



    At this point you can confirm the suggested match.

6. Check the Checkbox for the suggested match.
7. Click **Confirm Assignments**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image29.png "image_tooltip")


8. Click **Confirm**.


## Edit application attributes


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image30.png "image_tooltip")




9. Select the **Assignments** tab in the Google Workspace application definition.
10. Click the **Edit icon **for your admin user assignment.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image31.png "image_tooltip")


11. Locate and check the **Do not suspend user** checkbox under _Deactivation options_. \
This will make sure your Google admin user is not suspended if the account is ever unassigned.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image32.png "image_tooltip")


12. Scroll to the bottom of the window and click **Save**.


# Test single sign-on

You will now test single sign-on from Okta to Google Workspace.

This test uses the Okta admin user **your.name@okta.com** as the test user.  This user was assigned the Google super admin account, **your.name@ws.yourdemodomain.com**,**  **using an import operation.



1. Open a new browser window that is not signed into Okta or Google Workspace. \
This could be a private browsing window, a different profile, or a different browser.
2. Navigate to your Okta tenant. e.g. **_yourdemoorg_.okta.com**
3. Authenticate as your test user: e.g. **_your.name_@okta.com** \
You should end up on your Okta dashboard and see that tiles for Google apps are now shown:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image33.png "image_tooltip")


4. Click the tile for **Google Workspace Account**. \
If single sign-on is successful you will see the Google Workspace home page:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image34.png "image_tooltip")


5. Click the identity icon in the top-right of the page.

    Notice the name and account name shown in the pop-up window.  This should show that you are authenticated as **_your.name_@ws._yourdemodomain_.com**.  Single sign-on was successful!

6. Click **Sign out** to clear the session.  Close the browser you used for the test.


# Configure group assignment

In this section you will assign a group to the Google Workspace application. You will configure the application attributes for the group so that members are assigned the free _Cloud Identity_ license in Google Workspace.

You will then assign a test user to that group.  This will result in the test user being provisioned with an account in Google Workspace.

Note: The _Cloud Identity _license gives access to Google docs, sheets, and slides but it does not give access to Gmail or calendar.  If you want to show these capabilities you should grant the _Business Starter_ license instead but note that this will cost you around $5 per user per month.


## Create a group

You will now create a group that will be assigned to the Google Workspace application.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image35.png "image_tooltip")




1. In the administration UI for your Okta org, navigate to **Directory > Groups**.
2. Click the **Add group** button.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image36.png "image_tooltip")


3. Enter **GoogleUsers-Free **as the _Name_ of the group.
4. Enter **Google Workspace Users** as the _Description_.
5. Click **Save**.

    Note: The group may not immediately show in the group list.  Click on the **Group **navigation item again to reload the page and it should be shown.



## Assign group to application

You can assign a group to an application by either assigning the group within the application definition or by adding the application to the group definition.  In this case you will add the application from the group definition.



1. If not already there, navigate to **Directory > Groups**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image37.png "image_tooltip")


2. Click on the link for the **GoogleUsers-Free** group.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image38.png "image_tooltip")


3. Select the **Applications** tab in the group properties.
4. Click **Assign applications**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image39.png "image_tooltip")


5. Click the **Assign **button next to the _Google Workspace_ application.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image40.png "image_tooltip")


6. Under _Licenses, _check the checkbox for **Cloud Identity**. \
This is the free license for Google Workspace.  If you don’t see it, you will need to [follow these instructions to enable Cloud Identity in Google Workspace](https://docs.google.com/document/d/1d5KsTVf9RQt7yLHiNY76NnY9OEbUeDva3N-0rHVXUWo/edit#heading=h.f56ba71rtnna).
7. Click **Save and Go Back**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image41.png "image_tooltip")


8. Click **Done**.

The application is now assigned to the _GoogleUsers-Free _group.


## Assign user to group

You will now assign a test user to the **GoogleUsers-Free** group.  This will cause the user to be assigned the Google Workspace application which, in turn, will trigger provisioning of an account.



1. If not already there, navigate to **Directory > Groups**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image42.png "image_tooltip")


2. Select the **People **tab.
3. Click **Assign people**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image43.png "image_tooltip")


4. Click the **+ icon **for a test user in your Okta org. \
This should not be the admin user (which is already directly assigned to the application)

    The user is now shown as assigned:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image44.png "image_tooltip")



The user is now assigned to the group and will be assigned to the Google Workspace application using the attribute mapping associated with the group assignment.


## Test single sign-on

You can now test single sign-on to Google Workspace for your test user.



1. Open a new browser window that is not signed into Okta or Google Workspace. \
This could be a private browsing window, a different profile, or a different browser.
2. Navigate to your Okta tenant. e.g. **_yourdemoorg_.okta.com**
3. Authenticate as your test user: e.g. **_alex.anderson@yourdemodomain.com_** \
You should end up on your Okta dashboard and see that tiles for Google Workspace apps are shown:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image45.png "image_tooltip")


4. Click the tile for **Google Workspace Account**. \
If single sign-on is successful you will see this pop-up:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image46.png "image_tooltip")


5. Click **I understand**. \
You are taken to the Google Workspace homepage:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/005/image47.png "image_tooltip")


6. Click the identity icon in the top-right of the page.

    Notice the name and account name shown in the pop-up window.  This should show that you are authenticated as your test user.  Provisioning and single sign-on were successful!

7. Click **Sign out** to clear the session.  Close the browser you used for the test.

Congratulations! You have successfully configured Lifecycle Management and Single Sign-On to Google Workspace. Your demo environment can now be used to demonstrate these capabilities to customers.
