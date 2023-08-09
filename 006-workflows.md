# Workflows

Okta Workflows can be used to augment Lifecycle Management and provide custom logic for organization-specific use cases. Okta Workflows is a no-code automation platform that enables admins to modernize ever-more-sophisticated identity-centric processes without leaning on developers. It provides a graphical drag-and-drop interface that combines triggers, logic, and time-based actions to build powerful “if-this-then-that” flows. As a result, anyone can easily stitch together app-specific provisioning and deprovisioning tasks. For instance, with Okta Workflows, you can leverage Okta’s library of pre-built connectors for apps like Box, Slack, Salesforce, and more (or connect via public APIs) to tailor processes with deeper actions that meet your precise requirements.

With out-of-the-box functions for flow control, branching, and data manipulation, Okta offers the power of code without code, and it is finally possible to orchestrate identity tasks that were previously just too hard to automate. By having this capability built-in to your identity architecture, your team will increase agility and decrease costs, all while facilitating constant business change and improving your company’s security posture.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image9.png "image_tooltip")

Here are a few ways Okta Workflows can automate complex identity scenarios:

1\. Take granular actions during onboarding and offboarding

2\. Resolve identity creation conflicts

3\. Define identity processes based on time, role, and other factors

4\. Distill and share identity insights

## Lab description

The purpose of this Workflow pack is to perform various tasks in Google Workspace when a given target user is being off-boarded from Google Workspace or from the organization as a whole. This flow pack is triggered when a user is added to a specified Okta Group (by default that name of this group is G-Suite De-provisioned Users).  The effects of this Workflow on the Google Workspace User are as follows:

- Mailbox Delegate: Delegate the target user’s GMail mailbox to the target user’s manager (The manager is as defined in Okta Universal Directory in the Manager attribute).
- Mailbox Forward Emails: Setup a forwarder on the target user’s Gmail mailbox so that all emails sent to that mailbox are automatically forwarded to the target user’s manager  (The manager is as defined in Okta Universal Directory in the Manager attribute).
- Mailbox Auto-Reply: Set an GMail auto reply on the target user’s GMail mailbox (by default this will inform people that send emails to this mailbox that the target user is no longer with the company as well as who to contact, in this case the user’s manager)
- Clear Okta Session (Optional): When this feature is turned on, all of the target user’s Okta sessions will automatically be cleared. 
- Remove GSuite Licenses (Optional): When this feature is turned on, all of the GSuite licenses assigned to the target user will be removed.
- Remove All Users Devices in GSuite (Optional): When this feature is turned on, all of the devices registered to the target user in GSuite will be removed.
- Remove All Users Access Tokens in GSuite (Optional): When this feature is turned on, all of the application Access Tokens associated with this user will be removed.
- Deactivate GSuite Directory User (Optional): When this feature is turned on the target user will automatically be deactivated in the GSuite Directory.
- Create GDrive Transfer Request (Optional): When this feature is turned on a transfer request in Google Workspace to have all of the target user’s GDrive files and folders transferred to that user’s manager (The manager is as defined in Okta Universal Directory in the Manager attribute) will be created.
- Create Calendar Transfer Request (Optional): When this feature is set to true, a transfer request for the target users Google Workspace calendar to the  Google Workspace users manager will be created.

## Lab Prerequisites

For the workflows in the Okta Workflow Pack to work you will need:

1. You will need to configure the following Okta connectors in your Okta Tenant that has workflow enabled

1. Configure Okta Connector

1. From Okta Admin Console, go to Workflows console under Workflow section

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image8.png "image_tooltip")

2. Go to Connections tab and click New Connection

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image3.png "image_tooltip")

3. Select Okta connection from the list

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image6.png "image_tooltip")

4. Configure you Okta connection, you will need

1. Okta domain name of your tenant (without the https)
2. Okta Workflows App client ID and Client Secret, to get them, go Okta Workflows OAuth application, under Applications in the Okta Admin console

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image16.png "image_tooltip")

3. The configuration will look like this, click on Create button

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image23.png "image_tooltip")

2. Configure Google Workspace connector

1. Go to Connections tab and click New Connection
2. Select Google Workspace from the list

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image15.png "image_tooltip")

3. Set the Domain to okta-wic-lab.com and click on Sign in with Google
4. Login with the provided google admin account, check all the consent boxes and click Continue

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image2.png "image_tooltip")

3. Configure Google Calendar Connector: follow the same steps to configure it

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image5.png "image_tooltip")

4. Configure Google Drive Connector: follow the same steps to configure it

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image4.png "image_tooltip")

5. Configure Google Sheets Connector: follow the same steps to configure it

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image20.png "image_tooltip")

2. An Okta Workflow connector in to your Okta tenant that has Workflows enabled

1. An existing user (that will represent the manager user) in Okta and Google Workspaces where the username in Okta and in Google account are the same (the user’s email address) The manager user’s email address needs to point to a valid email address and have the appropriate Google Workspace licenses so that the manager can get the email notifications as part of the flow.
2. An existing target user (that will represent the target user) in Okta where the Okta Primary Email Address for that user is the same as the user’s Google Workspace username. The manager attribute in Okta Universal Directory will need to be the username of the Okta user that represents the manager and you created in the step above.
3. An existing Okta Group that will be used to trigger this Workflow when the Okta target user is added to this group (for the lab please create a group named Okta Google Workspace De-Provisioned Users.

3. Google Cloud Project and Service Account Setup: To use Gmail transfer of ownership features, you need to set up a Google Cloud project and service account. The API endpoints that are needed to add a delegate or forward emails are only available to service accounts that have been given domain-wide authority.

1. Go to Google Cloud Platform [https://console.cloud.google.com](https://www.google.com/url?q=https://console.cloud.google.com/&sa=D&source=editors&ust=1691574662298217&usg=AOvVaw1cQ8DqyG_eAPUgYJbqdtQr)
2. You should see a default project in your organization where you can enable the Gmail API for Google Cloud Project. From the Quick access select API & Services

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image21.png "image_tooltip")

3. To enable the Gmail API: In the search field, type Gmail. The search results will show Gmail API. Click Gmail API then Enable on the Gmail API page.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image7.png "image_tooltip")

4. You have enabled the Gmail API for your default project
5. Create Service Account for the Google Cloud Project

1. In the left navigation pane, select IAM & Admin > Service Accounts.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image19.png "image_tooltip")

2. At the top of the Service accounts page, click CREATE SERVICE ACCOUNT. Add a service account name and description (optional) in the Service account details section, then click CREATE. On the Service account permissions (optional) page, click Continue. This step will be completed later. On the Grant users access to this service page, click DONE. This step will also be completed later.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image10.png "image_tooltip")

3. You have created a service account

6. Set Up Google Workspace Domain-Wide Delegation of Authority: To use the endpoints to add a delegate or forward a user’s emails, you need a Google Cloud service account with domain-wide authority. By enabling domain-wide authority for a service account, you allow the service account to programmatically access a user’s data without any manual authorization on their part

1. Find the service account that you created in the previous task
2. Copy the client id under the Advanced Settings of your service account details page as shown below

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image18.png "image_tooltip")

3. To set up domain-wide delegation of authority, go to your Google Admin Console [https://admin.google.com/](https://www.google.com/url?q=https://admin.google.com/&sa=D&source=editors&ust=1691574662301435&usg=AOvVaw3n1gzoNhAeKYNL-aBEqUid)
4. Go to Main menu menu > Security > Access and data control \> API Controls. In the Domain wide delegation pane, select Manage Domain Wide Delegation.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image17.png "image_tooltip")

5. In the Client ID field, enter the service account's Client ID.
6. In the OAuth scopes (comma-delimited) field, enter the list of scopes:

[https://www.googleapis.com/auth/gmail.settings.basic](https://www.google.com/url?q=https://www.googleapis.com/auth/gmail.settings.basic&sa=D&source=editors&ust=1691574662302711&usg=AOvVaw1J2keBB27OhkUmmP9rlYGb)

[https://www.googleapis.com/auth/gmail.settings.sharing](https://www.google.com/url?q=https://www.googleapis.com/auth/gmail.settings.sharing&sa=D&source=editors&ust=1691574662303120&usg=AOvVaw0yqzvuILceNS_EaVg1TLRr)

7. Click Authorize.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image1.png "image_tooltip")

8. You have registered your service account with the Google Workspace domain and added the appropriate permissions (scopes) to the account. The service account can now access users’ data in the Google Workspace domain.

7. Add users and assign roles in the Google Cloud Project: Each user in your Google Cloud project needs permissions to use the Add Delegate, Forward Emails, or Set Auto Reply action card in the Workflows Gmail connector. Each user will need the role of Service Account User on the project level. This role will allow a user to load dynamic dropdown parameters in the action cards in Okta Workflows. Each user will also need the role of Service Account Token Creator on the service account level. This role assigns the user permissions to generate short-lived credentials for the service account so that it can access user data in the Google Workspace domain.

1. Go to [https://console.cloud.google.com](https://www.google.com/url?q=https://console.cloud.google.com&sa=D&source=editors&ust=1691574662304225&usg=AOvVaw1eP2hKOCMzfHri3XfTGKPK) .From the left navigation pane, click IAM & Admin, select IAM, click GRANT ACCESS. In the New members field, add the user’s email address (your test users). In the Select a role dropdown, select Service Accounts > Service Account User and click Save.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image11.png "image_tooltip")

2. To add your test users and assign the Service Account Token Creator : From the left navigation pane, click IAM & Admin, click Service Accounts, select your service account, in the Permissions section, click ADD MEMBER. In the New members field, add the user’s email address (email of your test users). In the Select a role dropdown, select Service Accounts > Service Account Token Creator. Click Save.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image13.png "image_tooltip")

3. You permission tab should look like the following

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image14.png "image_tooltip")

4. You have added a user to your Google Project who can authenticate to the Workflows Gmail connector and use the Add Delegate, Forward Emails, and Set Auto Reply action cards.

## Okta Workflows - Flow Pack Setup Steps

1. Go to the Okta Workflows Console
2. Create a new folder called Google Workspace Off-Boarding Flow
3. Import the googleWorkspaceOffBoardingFlow.folder into this newly created folder

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image22.png "image_tooltip")

4. If you have not already done so, authorize the connections to Google Workspace Admin, GMail, Google Drive and Okta.
5. Make sure that the following Okta Workflow cards have valid connections assigned: open all the flows and verify that all the connections are correctly setup
6. Toggle all the flows from Off to On

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/006/image12.png "image_tooltip")

## Testing the Okta Workflow Flow

To test the Google Google Workspace Off-Boarding Flow:

1. Stage Google Workspace Target User’s GMail Settings

1. Login to [https://mail.google.com](https://www.google.com/url?q=https://mail.google.com&sa=D&source=editors&ust=1691574662307957&usg=AOvVaw1Mlx9zxQxQjkQv1-KX0NuP) as the target user in Google Workspace.
2. Click on the gear icon in the right top corner
3. Click on the See all settings button.
4. Click on the Forwarding and POP/IMAP tab
5. Under the “Forwarding” section check to make sure that no existing entry exists  for the Forward a copy of incoming mail to section. If there is an entry, remove it by using the drop down.
6. Now go to the Accounts tab.
7. Under the Grant access to your account: section make sure there is no entry in that section. If there is, use the delete link to remove it.
8. Click on the General tab.
9. Scroll down to the Vacation responder section.
10. Ensure that the option for Vacation responder off is selected.
11. Scroll to the bottom of this page and select Save Changes if available.

2. Record  Google Workspace Target User’s Calendar Events Settings

1. While you are still logged into Google Workspace as the target user, goto [https://calendar.google.com/](https://www.google.com/url?q=https://calendar.google.com/&sa=D&source=editors&ust=1691574662310084&usg=AOvVaw2igQq7TPgadTax3Sj9JNgn)
2. Make note of any calendar events that the target user currently has on their Google Calendar.

3. Record  Google Workspace Target User’s Drive Settings

1. While you are still logged into Google Workspace as the target user, goto [https://drive.google.com/](https://www.google.com/url?q=https://drive.google.com/&sa=D&source=editors&ust=1691574662310694&usg=AOvVaw2IXuX2SLz1cZ6usdmwdY7w)
2. Create a test document
3. Make note of any files or folders that the target user currently has on their Google Drive.

4. Initiate the  Google Workspace Off-Boarding Flow Workflow

1. Initiate the Workflow by adding an existing Google Workspace user in the Okta Admin Console to the Okta group that you created as part of the prerequisites section as well as defined in the Okta Google Workspace De-Provisioned Users Group
2. Goto the Okta Workflows Console and click on the Google Workspace Off-Boarding Flow workflow.
3. Click on Flow History and validate that this workflow was executed and that there were no errors during the execution of this workflow.

5. Validate the  Google Workspace Off-Boarding Flow Workflow Execution

1. Check that the documents are transferred to the manager for example.
