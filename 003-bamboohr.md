### Integrate BambooHR


## Overview

This guide provides instructions for integrating Okta with BambooHR so that the following use cases can be demonstrated:

HRaaS - Sourcing a user profile from BambooHR into Universal Directory.\
This guide also provides instructions for attribute mapping.

# Introduction

This lab uses a pre-built and managed instance of BambooHR. The environment has users and groups defined in a pre-designed organisational structure. The integration has two connections. The first uses SSO integration to access the BambooHR tenant. The Second uses an API connection to import users from BambooHR into Okta’s Universal Directory.

This document covers the most straightforward integration you need to build a demo system.

```
Info!
You will find the credentials and tenant URL in the lab environment.
```

# Requirements (API key not required in the setup, but leaving optional)

Before you start configuring provisioning for BambooHR, you need to obtain a Bamboo API Key:

1. Login to BambooHR as an administrator.

Note: Bamboo recommends using a service account to generate the API Key, as opposed to using an individual administrator's credentials.

2. Select Account Settings in the upper right corner, then select API Keys.

3. Select **Add a new key**, or use an existing one if you have one, see the list of **My API Keys**.

4. Make a copy of the Key to enter in Okta later in this procedure.

# Configure SAML 2.0 for BambooHR (I asume not required, leaving optional)

1. Navigate to BambooHR at __https://<your_subdomain>.bamboohr.com__ where _<your_subdomain>_ is your organization's subdomain, and sign in with your existing credentials. This URL is the default relay state for your organization.

2. Go to: **Settings \> Apps**

3. Scroll down to **Okta**, then click **Install:**

# Add BambooHR App to Okta

Okta maintains a specific integration for BambooHR in the
Okta Integration Network (OIN). To add this to your Okta org, follow
these steps:

1.  Use a browser to open the administration UI of your Okta demo org

2.  Navigate to **Applications \> Applications**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image01.png "image_tooltip")

3.  Click **Browse App Catalog** to open the Okta Integration Network

4. **Search** the Okta Integration Network for BambooHR
   
![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image001.png "image_tooltip")

5. Select to **Add Integration**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image002.png "image_tooltip")

6. In the **General Settings** tab complete the required fields using the information below

- Verify that the **Subdomain** is your BambooHR subdomain. For example, enter **yourdemodomain** for http://**yourdemodomain**.bamboohr.com/.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image003.png "image_tooltip")

7. In the Sign On Methods section of the Sign-On Options panel, select **Secure Web Authn** as a sign-on option. If you select SAML 2.0, click **View Setup Instructions** and follow the instructions.


# Enable integration and provisioning

1. In the **Provisioning tab** complete the required fields as follows:


* Check the checkbox for **Enable API integration**.

* Click **Authenticate with BambooHR** and login using your BambooHR admin account credentials.

* Leave other parameters unchanged and click **Save** when the successful verification message appears.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image004.png "image_tooltip")

2. Change the Okta to BambooHR provisioning settings:

* Select the **Provisioning** tab then select **To App** in the Settings list.
* Click **Edit**.
* Select **Update User Attributes** to enable the functionality.
* Click **Save**.

3. Change the BambooHR to Okta provisioning settings:

* Select the Provisioning tab, and then select To Okta in the Settings list.
* Click **Edit** in the **General, User Creation & Matching, Profile & Lifecycle Sourcing**, or **Import Safeguard** areas to edit the settings.\
Select **Allow BambooHR to source Okta users** in the Profile & Lifecycle Sourcing area, BambooHR is the source for user profile data now.
* Click **Save**.

4. In the **Import tab**, click **Import Now**, and assing your users to Okta by clicking **Confirm Assignements**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image005.png "image_tooltip")

Select **Auto-activate users after confirmation** and click **Confirm**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image006.png "image_tooltip")

Your BambooHR-sourced users and groups will now be visible in the **Directory > People/Groups** tab.

For the best experience, create your own BambooHR provisioning with your own Okta tenant so that you can perform the manual import to verify the new employee that you created in BambooHR tenant. 

Please do not configure "Schedule Import" in your own Okta tenant. (OR WE SHOULD?)


5. Complete the attribute mapping using the information below

```
Departament, Division etc. are auto-mapped; we should be alright
```

# Configure group assignment

## Create a Marketing Groups

1. Navigate to **Directory > Groups**

2. Click **Add Group**.

3. Complete the details on the *Add group* page using the table below and click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image007.png "image_tooltip")

## Configure Group Rules

1. On the Groups page, click the **Rules** tab.

2. Click **Add Rule**.

3. Complete the details on the *Add Rule* page using the table below and click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image008.png "image_tooltip")

4. On the Groups page, select **Activate** from the *Actions* drop-down list.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/image009.png "image_tooltip")

