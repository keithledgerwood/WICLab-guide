### Integrate BambooHR


## Overview

This guide provides instructions for integrating Okta with BambooHR so that the following use cases can be demonstrated:

HRaaS - Sourcing a user profile from BambooHR into Universal Directory.\
This guide also provides instructions for attribute mapping.

# Introduction

This lab uses a pre-built and managed instance of BambooHR. The environment has users and groups defined in a pre-designed organisational structure. The integration has two connections. The first uses SSO integration to access the BambooHR tenant. The Second uses an API connection to import users from BambooHR into Okta’s Universal Directory.

This document covers the most straightforward integration you need to build a demo system.

   > **Info:** \
   > You will find the credentials and tenant URL in the lab environment.

# Add BambooHR App to Okta

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

7. In the Sign On Methods section of the Sign-On Options panel, select **Secure Web Authentification** as a sign-on option. If you select SAML 2.0, click **View Setup Instructions** and follow the instructions.


# Enable integration and provisioning

1. In the **Provisioning tab** complete the required fields as follows:

* Check the checkbox for **Enable API integration**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image004-1.png "image_tooltip")

* Click **Authenticate with BambooHR** and login using your BambooHR admin account credentials.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image004-2.png "image_tooltip")


* Leave other parameters unchanged and click **Save** when the successful verification message appears.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image004.png "image_tooltip")

2. Change the *Okta to BambooHR* provisioning settings:

* Select the **Provisioning** tab then select **To App** in the Settings list.
* Click **Edit**.
* Select **Update User Attributes** to enable the functionality.
* Click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/to-bamboo.png "image_tooltip")

3. Change the *BambooHR to Okta* provisioning settings:

* Select the **Provisioning** tab, and then select **To Okta** in the Settings list.
* Click **Edit** in the **Profile & Lifecycle Sourcing** area to edit the settings.
* Select **Allow BambooHR to source Okta users** in the Profile & Lifecycle Sourcing area, to make BambooHR your main source for user profile data.
* Click **Save** and review that your **Update application username on** was set to **Create and update**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image005-1.png "image_tooltip")

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image005-2.png "image_tooltip")

# Configure import

In this section you will configure inbound provisioning from BambooHR to Okta.  This will allow you to perform a one-time import so you can assign the existing your user to your Okta admin user.

In fact, you could perform this one-time import without doing any configuration, and manually match the account, but it makes sense to set up account matching for completeness.  Follow these steps:

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-1.png "image_tooltip")

1. Select the **Provisioning** tab in the BambooHR app definition.
2. Select **To Okta**.
3. In the **General** section, click **Edit** to define import settings.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-2.png "image_tooltip")

The Okta username format specifies the Okta username that will be used if a new user needs to be created to own an imported BombooHR account.  You will use a custom expression to specify a replacement domain.

4. Select *Custom* for Okta username format.
5. Enter the following expression, using your own domain:

    > appuser.firstName + "." + appuser.lastName + "@yourwiclabdomain.com"


7. Click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-3.png "image_tooltip")

7. In the **Okta Attribute Mappings** section, edit *Primary email* parameter, by entering transformational expression, to import users with an email indicating your own domain parameters.

    > appuser.firstName + "." + appuser.lastName + "@yourwiclabdomain.com"

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/con-imp-4.png "image_tooltip")

8. Click **Save**.

# Add/Hire a new employee to BambooHR

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

# Configure group assignments

## Create Groups

1. Navigate to **Directory > Groups**

2. Click **Add Group**.

3. Complete the details on the *Add group* page using the table below and click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image007.png "image_tooltip")

4. Repeat your steps by creating another group for **Sales** and **Human Resources** department.

## Configure Group Rules

1. On the Groups page, select the **Rules** tab.

2. Click **Add Rule**.

3. Complete the details on the *Add Rule* page using the table below and click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image008.png "image_tooltip")

4. On the Groups page, select **Activate** from the *Actions* drop-down list.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image009.png "image_tooltip")

5. Repeat your steps by creating another rule for **Sales** and **Human Resources** department.

## Assign Groups to Applications

1. On the Groups page, select your newly created Universal Directory Groups.

2. In the **Applications tab**, click **Assign applications** to assign your applications according to the table below.

|Group|Application|
|:-----:|:-----:|
|Marketing | Tableau|
|Marketing | Lucid Chart|
|Sales | SalesForce|
|Sales | Vivun|
|Human Resources | BambooHR |
|Human Resources | 2nd Bookmark App|

# Import Users

1. In the Okta administration UI, navigate to **Applications > Applications**, and select the BambooHR app definition.

2. In the **Import tab**, click **Import Now**, and assing your users to Okta by selecting them and clicking **Confirm Assignements**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image005.png "image_tooltip")

3. Select **Auto-activate users after confirmation** and click **Confirm**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image006.png "image_tooltip")

4. In the **Directory > People/Groups** tab, check if your users and groups are reflected.

For the best experience, create your own BambooHR provisioning with your own Okta tenant so that you can perform the manual import to verify the new employee that you created in BambooHR tenant.

Please do not configure "Schedule Import" in your own Okta tenant.

5. In the **Directory > Groups**, check if your user was assigned to the group according to the rules you prepared.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/group-assigned.png "image_tooltip")

   > There's a rule setup to copy all of the @yourwiclabdomain emails to your administrator's Outlook inbox of the Office365 tenant. \
Please expect your user activation emails there.

# Test provisioning (leaver flow)

1. Deactive your users in the BambooHR tenant.

2. In the **People** tab, select your newly added user, change its' **Status** to *Inactive* and click **Save Changes**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/deactivate-user-bhr.jpg "image_tooltip")

3. Open your Okta administration UI, navigate to **Applications > Applications**, and select the BambooHR app definition to verify user profile and check if it was deactivated in Okta.

4. In the **Import tab**, click **Import Now**, and confirm changes to your user by selecting them and clicking **Confirm Assignements**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/leaver-remove.png "image_tooltip")

5. Navigate to **Directory > Users** to check if your user status has changed.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/leaver-user.png "image_tooltip")

# Test provisioning (mover flow)

1. Move your user to the new *Department* in the BambooHR tenant.

2. In the **People > Personal** tab, select your newly added user, and click **+ Add Entry** in the **Job Information** field.

3. In the **Department** field, select **Sales**, and make sure that the **Effective Date** is set for *Today*, click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/mover-bamboo.png "image_tooltip")

4. Open your Okta administration UI, navigate to **Applications > Applications**, and select the BambooHR app definition to verify user profile and check if it was deactivated in Okta.

5. In the **Import tab**, click **Import Now**, and confirm changes to your user by selecting them and clicking **Confirm Assignements**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/mover-updated.png "image_tooltip")

6. Navigate to **Directory > Groups** to check if your user was automatically assigned to the new Group and has access to the new set of Apps.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/mover-user.png "image_tooltip")


Congratulations! You have successfully configured Lifecycle Management for
BambooHR, and you have tested joiner/mover flow.