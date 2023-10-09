# Integrating Office 365

## Streamlining Workplace Productivity Tools

In this lab, we'll effortlessly integrate Okta with your Microsoft Office 365 environment. By leveraging the Okta Integration Network, you'll experience firsthand how modern application integrations can be both straightforward and rapid. Through the benefits of automated provisioning and single sign-on, employees will be poised for instant productivity. And even as we focus on a user-friendly experience, remember, security is always at the forefront.

## Add Microsoft Office 365 App to Okta for SSO

Okta maintains a specific integration for Microsoft Office 365 in the Okta Integration Network (OIN). To add this to your Okta org, follow these steps:

1. In the Admin Console select **Applications** >  **Applications**.
2. Click **Browse App Catalog**.
3. Type *office 365* into the **Search...**, and then click **Microsoft Office 365**.
4. Click **Add integration**.

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image03.png "image_tooltip")

5. In the **General Settings** tab, set **Microsoft Tenant Name** to your Office 365 tenant name for the lab.
6. Click **Next**.

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image04.png "image_tooltip")

7. In the **Sign On Options** tab, select **WS-Federation**.
8. Enter your **Office 365 Admin Username** and **Office 365 Admin password**.
9. Click **Fetch and Select**. This will display a list of your Office 365 Domains.

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image06.png "image_tooltip")

10. Select your lab tenant domain

> **Hint:**  Don't select the domain that ends in *onmicrosoft.com*.

11. Click **Select**.

    ![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/009/image07-1.png "image_tooltip")

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image07.png "image_tooltip")

13. For **Application username format** select **Custom**.

14. Enter the following for the expression - replacing nn.mywiclab.com with your lab tenant domain:

    > **String.substringBefore(user.login,\"@\") + \"@nn.mywiclab.com\"**

15. Click **Done**.

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image08.png "image_tooltip")

Congratulations! Your Okta org and Microsoft 365 tenant are now configured for single sign-on from Okta to Azure AD.

> **Note:** You can't test single sign-on until you have enabled provisioning and assigned at least one user to this app in Okta.

## Configure Provisioning for Office 365

The single sign-on configuration performed in the previous section allows your Okta org to assert identity information to your Microsoft 365 tenant and it allows your Microsoft 365 tenant to trust it. However that's not enough for single sign-on to complete. Each identity asserted by Okta must link to an existing account in Azure AD.

The required Azure AD accounts could be created manually, or synced from a common identity source such as an on-premises AD but, in this case, you will set up provisioning in Okta so that it can automatically manage accounts in Azure AD. It will create accounts when users are assigned to the Office 365 app and deactivate these accounts when users are unassigned. It will also manage user attributes and licenses.

### Enable integration

Accounts in Azure AD can be managed via Microsoft APIs. To enable provisioning, Okta must be granted authority to call these APIs. Follow the steps below to grant this access and enable integration:

1. Verify that you are still in the **Microsoft Office 365** app definition.
2. Select the **Provisioning** tab.
3. Click **Configure API Integration**.

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image09.png "image_tooltip")

4. Select **Enable API integration**.
5. Click **Authenticate with Microsoft Office 365**.

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image010.png "image_tooltip")

6. Authenticate as the lab admin user for your Microsoft tenant.
7. Click **Accept** to grant the permissions requested by the Okta Microsoft Graph Client.
8. Click **Save**.

The API connection for provisioning is now in place. Provisioning configuration is now shown under the Provisioning tab. The integration configuration you just created is under the Integration tab.

There are two provisioning directions supported by this integration.

### Enable provisioning to app

In this section you will enable provisioning to Microsoft 365. This will include creation of accounts in Azure AD when users are assigned to the app, updating attributes in Azure AD when things change in Okta, and deactivating accounts in Azure AD when users are unassigned from the app in Okta.

> **Note:** In general, Okta does not delete accounts from apps - it only deactivates them. This ensures that Okta is not responsible for any data loss in the backend system that could be triggered by deleting an account.

Follow these steps to enable provisioning:

1. On the **Provisioning** tab, under **Settings**, select **To App**
2. Click **Edit** to set the options for provisioning from Okta  to Office 365.

    ![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/009/image013-1.png "image_tooltip")

3. For **Office 365 Provisioning Type** select **Universal Sync**.
4. For **Create Users**, select **Enable**.
5. For **Update User Attributes**, select **Enable**.
6. For **Deactivate Users**, select **Enable**.
7. Click **Save**.

# Configure group assignment

When assigning users to an app, it's common to assign a group to an app and then assign users to the group.

When assigning a group to an app, you can specify values for app attributes. These will override any mapping for those attributes in the app definition. If you don't specify any value for an attribute, the mapping in the app definition will be applied instead.

## Create a Group

You will now create a group that will be assigned the Microsoft
Office 365 app. Alternatively, you could assign the Office 365 app to existing groups.

1. In the Admin Console select **Directory** > **Groups**.
2. Click **Add group**.
3. Set the **Name** to  **O365 Users**.
4. Set the **Description** to **Office 365 Users**
5. Click **Save**.

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image033.png "image_tooltip")

## Assign Group to Application

You can assign a group to an app by either assigning the group within the app definition or by adding the app to the group definition. In this case you will add the app from the group definition.

1. In the Admin Console select **Directory** > **Groups**.
2. Select the **O365 Users** group.
3. Select the **Applications** tab, and then click **Assign applications**.
4. Find the the **Microsoft Office 365** app and click **Assign**.

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image035.png "image_tooltip")

5. In the list of Licenses, find and select **Office 365 ProPlus**.

>**Hint:** CTRL+F will pop up a search bar into which you can type *proplus*

6. Scroll to the bottom of the page and click **Save and Go Back**.
7. Click **Done**.

The application is now assigned to the **O365 Users** group.

## Assign User to Group

You will now assign the new employee to the *O365 Users* group. This will cause the user to be assigned the Microsoft Office 365 app which, in turn, will trigger provisioning of an account.

1. In the Admin Console select **Directory** > **Groups**.
2. Select the **O365 Users** group.
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

You can now test single sign-on to Microsoft 365 for your new employee.

1. Open a new browser window that is not signed in to Okta or Microsoft.

2. Enter the sign-in URL to your Okta org, For example *<https://demo-xxxxxx-xxxxx-nnnnn.okta.com>*

3. Authenticate as the new employee. For example *<flynn.rider@04.mywiclab.com>*

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image043.png "image_tooltip")

4. Click the **Microsoft Office 365 Word Online** app.
5. Click **Yes** to stay signed in.
6. In the top-right corner of the page, click the identity icon.
7. Click **Sign out** to clear the session, and then close the browser.

    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image045.png "image_tooltip")

## Conclusion

Congratulations! You have successfully integrated Microsoft Office into your Okta environment. Now your users will be able to enjoy a great Single Sign-On experience, not to mention quicker access with the help of Lifecycle Management. Considering how easy it was to integrate Microsoft Office 365, imagine how quick and easy it will be to integrate the rest of your application ecosystem!
