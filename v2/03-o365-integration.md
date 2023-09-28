# Integrate Okta with Microsoft Office 365

## Introduction

Okta integration with Microsoft Office 365 is a common pattern that provides Single Sign-On and Lifecycle Management to that application.

The Okta Integration Network (OIN) will be used in order to speed up the time it takes to complete the integration.

Microsoft Office 365 uses Microsoft Azure AD as its user store and to manage federation for single sign-on. This means that when you're configuring integration with Microsoft Office 365 in Okta, you're really configuring integration with Azure AD - even though the integration name
in the OIN is "Microsoft Office 365".

Okta's single sign-on to Microsoft Azure AD uses a protocol called WS-Federation. The WS-Federation standard, and the related WS-Trust standard, were developed by Microsoft (and a group of other companies) in the days before SAML 2.0. Today, it's unusual to see WS-Federation except for in relation to integration with Microsoft.

Note: Microsoft has recently added support for SAML 2.0 but the integration is more limited than when using WS-Federation.

The Okta Lifecycle Management integration with Microsoft uses
Microsoft-specific APIs to manage users in Azure AD. Integration with Microsoft is relatively simple if you only need to manage the basic profile attributes available via Microsoft public APIs. However, it can get pretty complex if you need to integrate with an environment that uses Microsoft Azure AD Connect (AAD Connect) to synchronize an on-premises AD with Azure AD in the cloud.

This document covers the simplest integration you need to build a demo system.

As part of this Challenge, you will configure:

- Single Sign-on (SSO) from Okta to Microsoft Office 365

- Lifecycle Management (LCM) for Microsoft Office 365

   > **Info:** \
You will find the admin credentials and tenant URL in the lab environment.

## Add Microsoft Office 365 App to Okta for SSO

Okta maintains a specific integration for Microsoft Office 365 in the Okta Integration Network (OIN). To add this to your Okta org, follow these steps:

<!--
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image01.png "image_tooltip")
-->
1. In the Admin Console select **Applications** >  **Applications**.
2. Click **Browse App Catalog**.
3. Type *office 365* into the **Search...**, and then click **Microsoft Office 365**.
4. Click **Add integration**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image03.png "image_tooltip")

<!--The Add Microsoft 365 wizard opens on the General Settings page:-->

6. In the **General Settings** tab, set **Microsoft Tenant Name** to your Office 365 tenant name for the lab.
7. Click **Next**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image04.png "image_tooltip")

8. In the **Sign On Options** tab, select **WS-Federation**.
9. Enter your Office 365 Admin *username* and *password*.
10. Click **Fetch and Select**. This displays a list of your Office 365 Domains.

<!--This integration supports both Secure Web Authentication (SWA), for password injection, and WS-Federation, for federated single sign-on.
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image05.png "image_tooltip")
-->

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image06.png "image_tooltip")

11. Select your lab tenant domain

> **Hint:**  Don't select the domain that ends in *onmicrosoft.com*.

12. Click **Select**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/009/image07-1.png "image_tooltip")

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image07.png "image_tooltip")

13. For **Application username format** select **Custom**.

14. Enter the following for the expression - replacing nn.mywiclab.com with your lab tenant domain:

    > **String.substringBefore(user.login,\"@\") + \"@nn.mywiclab.com\"**

15. Click **Done**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image08.png "image_tooltip")

Congratuations! Your Okta org and Microsoft 365 tenant are now configured for single sign-on from Okta to Azure AD.

> **Note:** You can't test single sign-on until you have enabled provisioning and assigned at least one user to this app in Okta.

## Configure Provisioning for Office 365

The single sign-on configuration performed in the previous section allows your Okta org to assert identity information to your Microsoft 365 tenant and it allows your Microsoft 365 tenant to trust it. However that's not enough for single sign-on to complete. Each identity asserted by Okta must link to an existing account in Azure AD.

The required Azure AD accounts could be created manually, or synced from a common identity source such as an on-premises AD but, in this case, you will set up provisioning in Okta so that it can automatically manage accounts in Azure AD. It will create accounts when users are assigned to the Office 365 app and deactivate these accounts when users are unassigned. It will also manage user attributes and licenses.

### Enable integration

Accounts in Azure AD can be managed via Microsoft APIs. To enable provisioning, Okta must be granted authority to call these APIs. Follow the steps below to grant this access and enable integration:

1. In the Admin Console select **Applications** > **Applications**.
2. Select the **Microsoft Office 365** app definition.
3. Select the **Provisioning** tab.
4. Click **Configure API Integration**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image09.png "image_tooltip")

4. Select **Enable API integration**.
4. Click **Authenticate with Microsoft Office 365**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image010.png "image_tooltip")

5. Authenticate as the lab admin user for your Microsoft tenant.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image011.png "image_tooltip")

6. Click **Accept** to allow your Okta org to manage users in your org.

7. Click **Save**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image012.png "image_tooltip")

The API connection for provisioning is now in place. Provisioning configuration is now shown under the Provisioning tab. The integration configuration you just created is under the Integration tab.

There are two provisioning directions supported by this integration.

### Enable provisioning to app

In this section you will enable provisioning to Microsoft 365. This will include creation of accounts in Azure AD when users are assigned to the app, updating attributes in Azure AD when things change in Okta, and deactivating accounts in Azure AD when users are unassigned from the app in Okta.

> **Note:** In general, Okta does not delete accounts from apps - it only deactivates them. This ensures that Okta is not responsible for any data loss in the backend system that could be triggered by deleting an account.

Follow these steps to enable provisioning:

1. On the **Provisioning** tab, under **Settings**, select **To App**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/009/image013-1.png "image_tooltip")

2. Click **Edit** to set the options for Okta provisioning to Azure AD.
3. For **Create Users**, select **Enable**.
4. For **Update User Attributes**, select **Enable**.
5. For **Deactivate Users**, select **Enable**.
6. Click **Save**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image014.png "image_tooltip")

### Configure attribute mapping

When a user is assigned to an app, attribute mapping determines
the default values that will be set for attributes in the app.
If attribute mapping is not configured, values for attributes must be manually set whenever a user is assigned.

For Microsoft 365, the licenses and roles to be assigned to users can beset up in attribute mapping. This is what you will configure here.

1. Verify that you are on the Microsoft Office 365 app  **Provisioning** tab with the **To App** setting selected.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image015.png "image_tooltip")

2. Scroll to the bottom of the page and click **Show Unmapped Attributes**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image016.png "image_tooltip")

3. Locate the **Licenses** attribute, and then click the **Pencil** icon to edit the attribute.
4. For the **Attribute value** select **Same value for all users**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/3a364fb9695bd6b1c1cb8c97e0bc2feb8af7b624/images/009/image017-1.png "image_tooltip")

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image017.png "image_tooltip")

4. Select  from the drop-down list.

   > The available options are shown. These have been pulled via API and so reflect the options relevant for your Microsoft tenant:

<!--![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image018.png "image_tooltip")
-->
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image019.png "image_tooltip")

5. Select the following licenses:

    - **Sharepoint Online (Plan 2)**
    - **Office Online**
    - **Office 365 ProPlus**
    - **Microsoft Teams**

6. Scroll to the bottom of the window and click **Save**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image020.png "image_tooltip")

OK. Provisioning is enabled and attribute mapping is done. You're ready to test.

<!--![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image022.png "image_tooltip")
-->

## Test provisioning and single sign-on

Now that provisioning and single sign-on have both been configured, you can test them by assigning your Okta admin user to the Microsoft Office 365 app and then attempting single sign-on.

This section uses the Okta admin user ***your.name*\@okta com** as the test user. This user will be mapped to ***your.name*\@yourdemodomain.com** by the custom username mapping you
set up when configuring single sign-on.

## Assign user to Microsoft Office 365 app

For this test you will directly assign your Okta admin user to the Office 365 app. You'll notice that it's also possible to assign via group membership - you'll set that up later.

1. Verify O365 app. If not already there, navigate to **Applications \> Applications**

2. Select the **Assignments** tab.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image021.png "image_tooltip")

3. Click **Assign**, and then select **Assign to People**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image022.png "image_tooltip")

4. Select your admin user and click **Assign**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image023.png "image_tooltip")

   > The User Name has been set based on the custom expression you specified during configuration of single sign-on.

   > The *Immutable ID* is blank. This would only be populated if the user was AD sourced and already had an immutable ID synced from Azure AD via Microsoft AD Connect or similar. In this case, the immutable ID will be populated during provisioning to Azure AD.

   > Licenses have been set based on the attribute mapping you created.

5. Scroll down to the *roles* and select the **Global Administrator**
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image024.png "image_tooltip")

<!--![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image025.png "image_tooltip")
-->

6. Scroll to the bottom and click **Save and Go Back**.

<!--![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image026.png "image_tooltip")
-->
7. Click **Done**.

    > In the background, Okta is provisioning the user account in your Microsoft 365 tenant and assigning the selected licenses and role. This should only take a few seconds to complete.

8. In the Admin Console select **Reports** > **System Log**.
9. Confirm that the log entries indicating successful provisioning are found.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image028.png "image_tooltip")

<!--![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image027.png "image_tooltip")
-->

### Test single sign-on (SSO)

You can now test single sign-on to Microsoft 365 for the assigned user.

1. Open a new browser window that is not signed into Okta or Microsoft
2. Enter the sign-in URL to your Okta org. For example,  **<https://demo-xxxxxx-xxxxx-xxxxx.okta.com>**

3. Authenticate as your user. For example, ***your.name*\@okta.com**

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image029.png "image_tooltip")

4. Click the **Microsoft Office 365 Office Portal** app.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image030.png "image_tooltip")

5. Click **Yes** to stay signed in.
6. In the top-right corner of the page, click the identity icon.

7. Click **Sign out** to clear the session, and then close the browser.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image031.png "image_tooltip")

# Configure group assignment

In the previous section, you assigned a user directly to the Microsoft 365 app. It was useful to do this so that you could assign the Global Administrator role. However, for assigning users in bulk, it's more usual to assign a group to an app and then assign users to the group.

When assigning a group to an app, you can specify values for app attributes. These will override any mapping for those attributes in the app definition. If you don't specify any value for an attribute, the mapping in the app definition will be applied instead.

## Create a Group

You will now create a group that will be assigned to the Microsoft
Office 365 app. Alternatively you can assign Office365 to the groups that you already created before (*Sales, Marketing, Human Resources*).

<!--![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image032.png "image_tooltip")
-->

1. In the Admin Console select **Directory** > **Groups**.
2. Click the **Add group** button.
3. Enter **O365Users** as the Name of the group.
4. Enter **Office 365 Users** as the Description.
5. Click **Save**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image033.png "image_tooltip")

## Assign Group to Application

You can assign a group to an app by either assigning the group
within the app definition or by adding the app to the
group definition. In this case you will add the app from the
group definition.

1. In the Admin Console select **Directory** > **Groups**.
<!-->
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image034.png "image_tooltip")
-->

2. Click on the link for the **O365Users** group.

3. Select the **Applications** tab in the group properties.
4. Click **Assign applications**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image035.png "image_tooltip")

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image036.png "image_tooltip")

5. Click the **Assign** button next to the *Microsoft Office 365*

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image038.png "image_tooltip")

6. Select the following licenses:

    - **Sharepoint Online (Plan 2)**
    - **Office Online**
    - **Office 365 ProPlus**
    - **Microsoft Teams**

7. Scroll to the bottom of the page and click **Save and Go Back**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image039.png "image_tooltip")

8. Click **Done**.

The application is now assigned to the O365Users group.

## Assign User to Group

You will now assign a test user to the *O365Users* group. This will cause the user to be assigned the Microsoft Office 365 app which, in turn, will trigger provisioning of an account.

1. In the Admin Console select **Directory** > **Groups**.
2. Select the **O365Users** group.
3. Select the **People** tab within the **O365Users** group.
4. Click **Assign people**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image040.png "image_tooltip")

5. Click  **+** for a user in your Okta org.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image041.png "image_tooltip")

> the **+** will change into **Assigned**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image042.png "image_tooltip")

6. Click **Done**.

The user is now assigned to the group and will be assigned to the Microsoft Office 365 app using the attribute mapping associated with the group assignment.

## Test single sign-on

You can now test single sign-on to Microsoft 365 for your test user.

1. Open a new browser window that is not signed into Okta or Microsoft

2. Navigate to your Okta tenant. For example, ***demo-xxxxxx-xxxxx-xxxx*.okta.com**

3. Authenticate as your new employee user. For example,

    > ***<flynn.rider@your.wiclab.com>***

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image043.png "image_tooltip")

4. Click the **Microsoft Office 365 Word Online** app./

<!--![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image044.png "image_tooltip")
-->
5. Click **Yes** to stay signed in.
6. In the top-right corner of the page, click the identity icon.
7. Click **Sign out** to clear the session, and then close the browser.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image045.png "image_tooltip")

## Challenge 2: Conclusion

Congratulations! You have successfully onboarded Microsoft Office into your Okta environment. Now your users will be able to enjoy a great Single Sign-On experience, not to mention quicker access with the help of Lifecycle Management. If Microsoft was that easy, imagine how quick and easy it will be to integrate the rest of your application ecosystem!
