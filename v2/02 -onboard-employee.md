# Challenge 1: Onboard New Team Member


## Introduction

One of the most powerful features of Okta is the quick time to market that it provides. In this challenge, Bamboo HR will be integrated with Okta so it can act as the authoritative source of Identity Data.

Sourcing Identity Data from an HR system (such as Bamboo HR) has several advantages. New Employees typically get added to the HR system as part of their corporate onboarding process. Once integrated, Okta imports the selected attributes into Okta and provisions birthright access to applications.  

The Okta feature that brings it all together is Universal Directory, which not only stores the employee identity data, but provides an extremely flexible way to map the attributes from one source to another. 

This lab uses a pre-built and managed instance of BambooHR. The environment has users and groups defined in a pre-designed organisational structure. The integration has two connections. The first uses SSO integration to access the BambooHR tenant. The Second uses an API connection to import users from BambooHR into Okta’s Universal Directory.


   > **Info:** \
   > You will find the credentials and tenant URL in the lab environment.

## CHALLENGE 1 - SETUP: Add BambooHR App to Okta

Okta maintains a specific integration for BambooHR in the
Okta Integration Network (OIN). To add this to your Okta org, follow
these steps:



1.  Use a browser to open the administration UI of your Okta demo org, click *Launch* in the lab environment, login and click **Admin**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/launch-wic.png "image_tooltip")

2.  Navigate to **Applications \> Applications**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image01.png "image_tooltip")

3.  Click **Browse App Catalog** to open the Okta Integration Network

4. **Search** the Okta Integration Network for BambooHR
   
![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image001.png "image_tooltip")

5. Select to **Add Integration**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image002.png "image_tooltip")

6. In the **General Settings** tab complete the required fields using the information below

- Verify that the **Subdomain** is your BambooHR subdomain. For example, enter **yourwiclabdomain** for http://**yourwiclabdomain**.bamboohr.com/.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image003.png "image_tooltip")

7. Click **Next** on the bottom right. 

8. In the Sign On Methods section of the Sign-On Options panel, select **Secure Web Authentification** as a sign-on option. 
>If you select SAML 2.0, click **View Setup Instructions** and follow the instructions.\
You do not need to configure this parameter, as we will be mainly sourcing users from BambooHR, not logging to BambooHR using SSO.

9. Leave the other settings as is and click **Done**. 


## Challenge 1 Setup: Enable Integration and Provisioning

1. In the **Provisioning tab** complete the required fields as follows:

* Click **Configure API Integration** 


![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image004-1.png "image_tooltip")

* Check the checkbox for **Enable API integration**.
* Click **Authenticate with BambooHR** and login using your BambooHR admin account credentials.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image004-2.png "image_tooltip")


* Leave other parameters unchanged and click **Save** when the successful verification message appears.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image004.png "image_tooltip")

2. Change the *Okta to BambooHR* provisioning settings:

* Select the **Provisioning** tab then select **To App** in the Settings list.
* Click **Edit**.
* Click **Enable** in Update User Attributes.
* Click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/to-bamboo.png "image_tooltip")

3. Change the *BambooHR to Okta* provisioning settings:

* Select the **Provisioning** tab, and then select **To Okta** in the Settings list.
* Click **Edit** in the *Profile & Lifecycle Sourcing*
* Click the **Allow BambooHR to source Okta users** checkbox. 
* A prompt will appear to *Enable Profile Mastering*. Click **OK**. Leave other settings as is.
*Click **Save**.


* Click **Save** and review that your **Update application username on** was set to **Create and update**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image005-1.png "image_tooltip")

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image005-2.png "image_tooltip")

### Configure Import

In this section you will configure inbound provisioning from BambooHR to Okta.  This will allow you to perform a one-time import so you can assign your existing users to your Okta user (in Okta Universal Directory).

In fact, you could perform this one-time import without doing any configuration, and manually match the account, but it makes sense to set up account matching for completeness.  Follow these steps:

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-1.png "image_tooltip")

1. Select the **Provisioning** tab in the BambooHR app definition.
2. Select **To Okta**.
3. In the **General** section, click **Edit** to define import settings.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-2.png "image_tooltip")

The Okta username format specifies the Okta username that will be used if a new user needs to be created to own an imported BombooHR account.  You will use a custom expression to specify a replacement domain.

4. Select *Custom* for Okta username format.
5. Enter the following expression, *using your own domain*:

    > appuser.firstName + "." + appuser.lastName + *"@yourwiclabdomain.com"*


6. Click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-3.png "image_tooltip")

7. In the **Okta Attribute Mappings** section, scroll to *Primary Email* and click the *Pencil Icon* to *Edit*. 
8. In the text box enter the transformational expression

    > appuser.firstName + "." + appuser.lastName + "@yourwiclabdomain.com"

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-4.png "image_tooltip")

9. Click **Save**.

## Challenge 1 - Validate: Add/Hire a new employee to BambooHR (joiner flow)

1. In the Lab environment, click **Launch** BambooHR.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/launch-bamboohr.png "image_tooltip")

2. Click **Login to Tenant** and login using your *Credentials*.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/bamboohr-user-1.png "image_tooltip")

3. In the BambooHR tenant, select **People** tab and click **New Employee**.

4. Add your new employee as a **New Employee** with the following **Job Information**.

|||
|:-----:|:-----:|
|Hire Date |*Today*|
|Work Email |*Your Email*|
|Job Title | Director of Marketing|
|Department | Marketing|
|Location | Remote Worker|
|Reports To | Trent Walsh|
|Self-service access |*No Access*|

5. Click **Save**.

## Challenge 1 - Setup: Configure Group Assignments


1. In Okta Admin Console, navigate to **Directory > Groups**

2. Click **Add Group**.

3. Complete the details on the *Add group* page using the table below and click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image007.png "image_tooltip")

4. Repeat your steps by creating another group for **Sales** and **Human Resources** department.

## Challenge 1 - Setup: Configure Group Rules

1. On the Groups page, select the **Rules** tab.

2. Click **Add Rule**.

3. Complete the details on the *Add Rule* page using the table below and click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image008.png "image_tooltip")

4. On the Groups page, select **Activate** from the *Actions* drop-down list.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image009.png "image_tooltip")

5. Repeat your steps by creating another rule for **Sales** and **Human Resources** department.

## Challenge 1 - Setup: Assign Groups to Applications

1. On the Groups page, select your newly created Universal Directory Groups.

2. In the **Applications tab**, click **Assign applications** to assign your applications according to the table below.

|Group|Application|
|:-----:|:-----:|
|Marketing | Office 365|
|Marketing | Marketo|
|Sales | Office 365|
|Sales | SalesForce|
|Human Resources | Office 365 |
|Human Resources | ServiceNow |

## Challenge 1 - Setup: Import Users

1. In the Okta administration UI, navigate to **Applications > Applications**, and select the BambooHR app definition.

2. In the **Import tab**, click **Import Now**. You should see a popup box that shows the number of users and groups scanned. Click **OK** on the popup. 

3. Find the Employee that you added into Bamboo HR. Click **Confirm Assignements** of that employee.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image005.png "image_tooltip")

3. Select **Auto-activate users after confirmation** and click **Confirm**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image006.png "image_tooltip")

4. In the **Directory > People/Groups** tab, check if your users and groups are reflected.

For the best experience, create your own BambooHR provisioning with your own Okta tenant so that you can perform the manual import to verify the new employee that you created in BambooHR tenant.

Please do not configure "Schedule Import" in your own Okta tenant.

5. In the **Directory > Groups**, check if your user was assigned to the group according to the rules you prepared.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/group-assigned.png "image_tooltip")


## Challenge 1 - Validate: Activate New Employee Okta Account and Login to Okta Dashboard

You need to activate your Okta Account before testing single sign-on for your test user.

   > There's a rule setup to copy all of the @yourwiclabdomain.com emails to your administrator's Outlook inbox of the Office365 tenant. \
Please expect your user activation emails there.

1. In the Lab environment, click **Launch** Office365.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/009/launch-o365.png "image_tooltip")

2. Click **Login to Tenant** and login using your admin *Credentials*.

3. Access your Admin's **Outlook** account from the **Apps** section.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/outlook-access.png "image_tooltip")

4. In your newly delivered *Welcome to Okta!* email, click **Activate Okta Account** to activate your newly created user in a new browser window.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/activate-okta-account.png "image_tooltip")

5. Set a new Password and Okta Verify as your security methods.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/setup-pw.png "image_tooltip")

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/setup-pw2.png "image_tooltip")

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/setup-ov.png "image_tooltip")

6. Review your Okta End-user dashboard and the apps that the account got automatically provisioned to.


## Conclusion

