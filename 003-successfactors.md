# Integrate SAP Successfactors

HRaaS - SAP Success Factors

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
