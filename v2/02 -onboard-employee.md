# Onboard New Team Member

## Introduction

One of the most powerful features of Okta is the quick time to market that it provides. In this challenge, BambooHR will be integrated with Okta so it can act as the authoritative source of Identity Data.

Sourcing Identity Data from an HR system (such as BambooHR) has several advantages. New Employees typically get added to the HR system as part of their corporate onboarding process. Once integrated, Okta imports the selected attributes into Okta and provisions birthright access to applications.

The Okta feature that brings it all together is Universal Directory, which not only stores the employee identity data, but provides an extremely flexible way to map the attributes from one source to another.

This lab uses a pre-built and managed instance of BambooHR. The environment has users and groups defined in a pre-designed organizational structure. The integration has two connections. The first uses SSO integration to access the BambooHR tenant. The Second uses an API connection to import users from BambooHR into Okta’s Universal Directory.

## Add/Hire a new employee to BambooHR (joiner flow)

1. In the Lab environment, click **Launch** for BambooHR.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/launch-bamboohr.png "image_tooltip")

> **Note:** The launch window will display your **BambooHR tenant subdomain** and your **BambooHR admin account credentials**.
>

2. Click **Login to Tenant**, and sign in using the provided BambooHR admin account credentials.

3. In the BambooHR dashboard select **People**, and then click **New Employee**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/bamboohr-user-1.png "image_tooltip")

4. Enter the following information for the **New Employee**.

|||
|:-----:|:-----:|
|First Name |Flynn|
|Last Name |Rider|
|Work Email |<flynn.rider@01.mywiclab.com>|
|Hire Date |*Today*|
|Job Title | Director of Marketing|
|Reports To | Trent Walsh|
|Department | Marketing|
|Location | Remote Worker|
|Self-service access |*No Access*|

5. Click **Save**.
6. Make note of the BambooHR tenant subdomain name in the URL. You will need this name in the next part of this lab.

## Add the BambooHR App to Okta

Okta maintains a specific integration for BambooHR in the Okta Integration Network (OIN). To add this to your Okta org, follow these steps:

1. In the Lab environment, click **Launch** for Workforce Identity Cloud.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/launch-wic.png "image_tooltip")

2. In the Admin Console select **Applications** > **Applications**.
3. Click **Browse App Catalog**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image01.png "image_tooltip")

4. Type *bamboohr* into the **Search...** bar, and then click **BambooHR**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image001.png "image_tooltip")

5. Click **Add Integration**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image002.png "image_tooltip")

6. In the **General Settings** set **Subdomain** to your BambooHR tenant subdomain.

>**Tip** You may need to refer back to the BambooHR launch page if you forgot your BambooHR tenant subdomain

7. Click **Next**.

8. In **Sign On Options** verify that the sign-on method is set to **Secure Web Authentication**.
9. Click **Done**.

>**Note:** For the purposes of this lab, we will not be authenticating into BambooHR using Okta SSO. We are only sourcing users from BambooHR using Okta Import.

## Enable Integration and Provisioning

1. Select the **Provisioning** tab.
1. Click **Configure API Integration**, and then select **Enable API integration**.
3. Click **Authenticate with BambooHR**

> **Note:** If you don't already have an active BambooHR session, you will be prompted to login using your BambooHR admin account credentials.

4. After the success message appears, click **Save**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image004.png "image_tooltip")

5. Select **To App** under **Settings**.
7. Click **Edit**.
8. Select **Enable** for Update User Attributes.
9. Click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/to-bamboo.png "image_tooltip")

10. Select **To Okta** under **Settings**.
11. In the **Profile & Lifecycle Sourcing** section click **Edit**
12. Select **Allow BambooHR to source Okta users**.
13. Click **OK** to **Enable Profile Mastering**.
13. Click **Save**.
14. Refresh the browser page and confirm, in the **General** section, that **Update application username on** is set to **Create and update**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image005-2.png "image_tooltip")

### Configure Import

In this section you will configure inbound provisioning from BambooHR to Okta.  This will allow you to perform a one-time import of existing users into Okta Universal Directory.

In fact, you could perform this one-time import without doing any configuration, and manually match the account, but it makes sense to set up account matching for completeness.  Follow these steps:

1. In the **General** section, click **Edit** to define import settings.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-1.png "image_tooltip")

2. For **Okta username format**, select **Email Address**.
3. Click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-2.png "image_tooltip")

## Import Users

1. On the **Import** tab, click **Import Now**. You will see a popup box that shows the number of users and groups scanned.
1. Click **OK** on the popup.

2. Use the **Search** to find the new employee that you added into Bamboo HR.
3. Select the employee via the checkbox
4. Click **Confirm Assignments** for that employee.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image005.png "image_tooltip")

5. Select **Auto-activate users after confirmation**, and then click **Confirm**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image006.png "image_tooltip")

6. In the Admin Console select  **Directory** > **People** to verify that your new employee was successfully imported.
7. Select the new employee to view their **Assigned Applications**.
8. Select the **Groups** tab to view their group memberships.
9. Select the **Profile** tab to view their imported attributes.

10. In the **Directory > Groups**, check if your user was assigned to the group according to the rules you prepared.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/group-assigned.png "image_tooltip")

## Activate New Employee Okta Account and Login to Okta Dashboard

You need to activate your Okta Account before testing single sign-on for your new employee.

   > There's a rule setup to copy all of the @yourwiclabdomain.com emails to your administrator's Outlook inbox of the Office365 tenant. \
Please expect your user activation emails there.

1. In the Lab environment, click **Launch** Office365.
2. Click **Login to Tenant** and login using your admin *Credentials*.
3. Access your Admin's **Outlook** account from the **Apps** section.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/outlook-access.png "image_tooltip")

4. In your newly delivered *Welcome to Okta!* email, click **Activate Okta Account** to activate your newly created user in a new browser window.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/activate-okta-account.png "image_tooltip")

5. Set a new Password and Okta Verify as your security methods.
6. Review your Okta End-user dashboard and the apps that were automatically provisioned to the account.

## Conclusion

Congrats! In just a few minutes, you made your HR system the authoritative source of Identities. You configured attribute mapping and created a transformation such that the username and email address would be a certain way upon the import.

Using these powerful features from Okta will allow you the flexibility to onboard users from multiple sources and create a single record containing only the attributes you want, from the sources that you want.

This is critical not just to keep your data clean and business secure, but to onboard other Lines of Business and possibly other companies in an M&A scenario.
