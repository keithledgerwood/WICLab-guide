# Integrate SAP Successfactors

Overview

This guide provides instructions for integrating Okta with SAP Success Factors so that the following use cases can be demonstrated:

HRaaS - Sourcing a user profile from SAP Success Factors into Universal Directory
This guide also provides instructions for attribute mapping.

Introduction
This lab uses a pre-built and managed instance of SAP Success Factors. The environment has users and groups defined in a pre-designed organisational structure. The integration has two connections. The first uses SSO integration to access the SAP Success Factors tenant. The Second uses an API connection to import users from SAP Success Factors into Okta’s Universal Directory.

This document covers the most straightforward integration you need to build a demo system.

Okta maintains a specific integration for SAP Success Factors in the
Okta Integration Network (OIN). To add this to your Okta org, follow
these steps:

1.  Use a browser to open the administration UI of your Okta demo org

2.  Navigate to **Applications \> Applications**.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image01.png "image_tooltip")

3.  Click **Browse App Catalog** to open the Okta Integration Network

4. **Search** the Okta Integration Network for SAP Success Factors
   
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/010/image00.png "image_tooltip")

5. Select to **add the integration**

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/010/image05.png "image_tooltip")

6. In the **General tab** complete the required fields using the information below

   ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/010/image06.png "image_tooltip")

```
Company ID = SFCPART000524

SignOn URL = https://hcm68sales.successfactors.com/login?company=SFCPART000524

SiteURL = https://hcm68sales.successfactors.com/ 

```

7. In the **Provisioning tab** complete the required fields using the API infomration below

   ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/010/image08.png "image_tooltip")


```
Base URL for Web Service     https://api68sales.successfactors.com

Admin Username               paswin

Admin Password               XXXXX

Pre-Start Interval           0

Post-Termination Interval    0

Import Contingent Workers              (unchecked)  

Time Zone Aware Pre-hires/Terminations (unchecked) 

Import Groups                            checked 

```


8. The "Schedule Import" is being configured for "once a day" in HRM-SuccessFactors.okta.com.

For the best experience, create your own SuccessFactors provisioning with your own Okta tenant so that you can perform the manual import to verify the new employee that you created in SuccessFactors.com tenant. 

Please do not configure "Schedule Import" in your own Okta tenant.

   ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/010/image03.png "image_tooltip")

9. Complete the attribute mapping using the infomration below

```
Map Profile attributes (Directory → Profile Editor → Successfactors → 'Successfactors to Okta' mapping):

String.stringContains(appuser.person___logon_user_name, "@") ?
   appuser.person___logon_user_name : appuser.person___personal_information___first_name +
   "." + appuser.person___personal_information___last_name + "@" + org.subdomain + ".com"

Okta UserName Format (Under 'Provisioning' -> To Okta -> 'General' -> Okta Username format -> Select 'Custom'):
 String.stringContains(appuser.person___logon_user_name, "@") ? appuser.person___logon_user_name :
   appuser.person___logon_user_name + "@" + org.subdomain + ".com"


FirstName:
 String.len(String.removeSpaces(appuser.person___personal_information___first_name)) > 0 ?
  appuser.person___personal_information___first_name : "F_" + appuser.person___logon_user_name

LastName:
 String.len(String.removeSpaces(appuser.person___personal_information___last_name)) > 0 ? 
  appuser.person___personal_information___last_name : "L_" + appuser.person___logon_user_name


Email:
 String.len(String.removeSpaces(appuser.person___email_information___email_address)) > 0 ?    
  appuser.person___email_information___email_address : appuser.person___logon_user_name + "@" + org.subdomain + ".com"

```

10. Search for user XXXXX and selct the check box to only import this user from SAP Success Factors to your Okta Org
    
    ***IMPORTANT: DO NOT IMPORT ALL USERS FROM SAP SUCCESS FACTORS***

       ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/010/image07.png "image_tooltip")
