# Onboarding a New Employee

One of the most powerful features of Okta is the quick time to market that it provides. In this challenge, BambooHR will be integrated with Okta so it can act as the authoritative source of Identity Data.

Sourcing Identity Data from an HR system (such as BambooHR) has several advantages. New Employees typically get added to the HR system as part of their corporate onboarding process. Once integrated, Okta imports the selected attributes into Okta and provisions birthright access to applications.

The Okta feature that brings it all together is Universal Directory, which not only stores the employee identity data, but provides an extremely flexible way to map the attributes from one source to another.

This lab uses a pre-built and managed instance of BambooHR. The environment has users and groups defined in a pre-designed organizational structure. The integration has two connections. The first uses SSO integration to access the BambooHR tenant. The Second uses an API connection to import users from BambooHR into Okta’s Universal Directory.

## Add a New Employee to BambooHR

1. In the BambooHR dashboard select **People**, and then click **New Employee**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/bamboohr-user-1.png "image_tooltip")

2. Enter the following information for the **New Employee**.

|Attribute|Value|
|:-----|:-----|
|First Name |**Flynn**|
|Last Name |**Rider**|
|Work Email |**<flynn.rider@wiclab.com>**|
|Hire Date |*Today*|
|Job Title | **Director of Marketing**|
|Department | **Marketing**|
|Location | **Remote Worker**|

5. Click **Save**.

## Add the BambooHR App to Okta

Okta maintains a specific integration for BambooHR in the Okta Integration Network (OIN), that supports Okta SSO using SAMl and Provisioning using APIs.  In this section of the lab our focus will be on sourcing users from BambooHR using Okta Import.

1. In the Admin Console select **Applications** > **Applications**.
2. Click **Browse App Catalog**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image01.png "image_tooltip")

3. Type *bamboohr* into the **Search...** bar, and then click **BambooHR**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image001.png "image_tooltip")

4. Click **Add Integration**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image002.png "image_tooltip")

5. In the **General Settings** set **Subdomain** to your BambooHR tenant subdomain.
6. Click **Next**.

   ![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image003z.png "image_tooltip")

7. In **Sign On Options** verify that the sign-on method is set to **Secure Web Authentication**.
8. Click **Done**.

## Enable Integration and Provisioning

1. Select the **Provisioning** tab.
1. Click **Configure API Integration**, and then select **Enable API integration**.
3. Click **Authenticate with BambooHR**

> **Note:** If you don't already have an active BambooHR session, you will be prompted to login using your BambooHR admin account credentials.

4. After the success message appears, click **Save**

   ![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image004.png "image_tooltip")

5. In the **Settings** panel, select **To Okta**.
6. In the **Profile & Lifecycle Sourcing** section click **Edit**
7. Select **Allow BambooHR to source Okta users**.
8. Click **OK** to **Enable Profile Mastering**.
9. Click **Save**.

### Configure Import from BambooHR to Okta

In this section you will configure inbound provisioning from BambooHR to Okta.  This will allow you to perform a one-time import of existing users into Okta Universal Directory.

In fact, you could perform this one-time import without doing any configuration, and manually match the account, but it makes sense to set up account matching for completeness.  Follow these steps:

1. In the **General** section, click **Edit** to define import settings.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-1.png "image_tooltip")

2. For **Okta username format**, select **Email Address**.
3. Click **Save**.

## Import New Employee from BambooHR to Okta

1. On the **Import** tab, click **Import Now**.
1. When the scan of users and groups is complete, click **OK**.
2. Use **Search** to find the new employee that you added into Bamboo HR.
3. Select the new employee via the checkbox.
4. Click **Confirm Assignments**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image005.png "image_tooltip")

5. Select **Auto-activate users after confirmation**. This will send out an activation email for the new employee's Okta account.
6. Click **Confirm**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image006.png "image_tooltip")

6. In the Admin Console select  **Directory** > **People** to verify that your new employee was successfully imported with a status of *Pending user action*.
7. Select the new employee to view their **Assigned Applications**.
8. Select the **Groups** tab to view their group memberships.
9. Select the **Profile** tab to view their imported attributes.

## Activate Okta Account for New Employee and Sign In

In order to access the new employee activation email, you'll need to sign into your Office 365 tenant as the labadmin.

1. In the Lab environment, click **Launch** Office365.
2. Click **Login to Tenant** and sign in with your **labadmin** credentials.
3. Click the **Microsoft 365 app launcher** icon, and then click **Outlook**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/outlook-access.png "image_tooltip")

4. Locate and open the *Welcome to Okta!* email for the new employee.
5. Click **Activate Okta Account**. This will open a new browser window.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/activate-okta-account.png "image_tooltip")

5. Set a **password** and set up **Okta Verify** as your security methods.
6. Review the Okta End-user dashboard and the apps that were automatically provisioned for the new employee.

## Conclusion

Congrats! In just a few minutes, you made your HR system the authoritative source of Identities. You configured attribute mapping and created a transformation such that the username and email address would be a certain way upon the import.

Using these powerful features from Okta will allow you the flexibility to onboard users from multiple sources and create a single record containing only the attributes you want, from the sources that you want.

This is critical not just to keep your data clean and business secure, but to onboard other Lines of Business and possibly other companies in an M&A scenario.