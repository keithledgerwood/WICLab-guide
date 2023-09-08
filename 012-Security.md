## Overview

Okta Verify is a multifactor authentication (MFA) app developed by Okta. It lets users verify their identity when they sign in to Okta and makes it less likely that someone pretending to be the user can gain access to the account.

To use Okta Verify, you must install the app on your device and set it up. This is something you already did on your mobile device, when you received the "Your New Okta account" e-mail and signed on to your Okta org. You could see that afterwards when signing in to the Okta org you could verify your identity by approving a push notification in the app, or by entering a one-time code provided by the app.

Okta Verify also enables setting up the Okta FastPass which  provides passwordless authentication to any app in Okta. This means you don't have to enter your password when signing in, so the login experience is as smooth as possible but still highly secure. Okta FastPass obviously reduces the probability of data breaches that can occur from compromised credentials. The solution is supported on Android, iOS, macOS and Windows devices, from any location or network.  

## Install and Configure Okta Verify

### Install Okta Verify on Your Virtual Machine

To install Okta Verify on your Windows VM (Windows Server), open a preferred browser (Chrome or Firefox) in your VM and proceed with the following steps:

1. In your lab environment, in the left-hand Okta Workforce panel, under Workforce Identity Cloud, Click **Launch**.  
This will open the Okta org tab in your browser.  

2. Login with your Username, Password, and Okta Verify code or push notification.  
You can now see the Okta End-User Dashboard.

3. Click **Admin**.  
This will open the Admin Console tab in your browser. 

4. In the Admin Console, select **Settings** > **Downloads**.  

5. Scroll down to **Okta Verify for Windows (.exe)** and click **Download Latest**.  

6. Open the downloaded Okta Verify Setup .exe file.

7. In the Okta Verify installation window, select **I agree to the License terms and conditions** and click **Install**.
Wait for confirmation saying that Okta Verify was successfully installed.

8. Click **Finish**.

### Configure Okta Verify

1. On Desktop, find and open **Okta Verify**.

2. In the Welcome to Okta Verify window, click **Get started**.

3. Click **Next**.

4. Enter the sign-in URL to your Okta org: https://demo-xxxxxx-xxxxx-xxxxx.okta.com.  
This will open your Okta org sign-in page in the browser.

5. Verify with your Password and Okta Verify mobile code or push notification.  
Your account is added to the Okta Verify desktop app.


## Configure Security Policies and FastPass

### Configure Enrollment Policy for Your Users

1. In the Admin Console, select **Security** > **Authenticators** > **Enrollment**.  

2. For the Default Policy, click **Edit**.  
This will open the Edit Policy window.

3. Make sure that Okta Verify is set to Optional and Password is set to Required.  

3. Click **Update policy**.

### Create a new Authentication Policy for your Office365 App

1. Select **Security** > **Authentication policies**.  

2. Click **Add a policy**.  
This will open the Add Authentication Policy window.

3. Name the new policy: Office365.  

4. Click **Save**.

5. Click the **Applications** tab.

6. Click **Add app**.

7. For Office365, click **Add**.

8. Click **Close**.

9. Click the **Rules** tab.

10. Click **Add rule**.  
This will open the Add Rule window.

11. Configure the rule as follows:
- Rule name: O365 - Access for Marketing
- User's group membership includes: Marketing 
- User must authenticate with: Any 1 Factor type

12. Click **Save**.

### Test Multi-Factor Authentication

1. Sign in to your org as the New Employee (being a member of the Marketing group).

2. In the End-User Dashboard, open the **Office365** app.

3. You should be asked asked to verify with your password when signing into Office365.

### Enable Okta Verify for FastPass Authentication

1. In the Admin Console, select **Security** > **Authenticators**.  

2. For Okta Verify, click **Actions**, and then select **Edit**.  
This will open the Okta Verify window.

2. Make sure that the following options are checked:
- Push notification (Android and iOS only)
- Okta FastPass (All platforms)
- Show the "Sign in with Okta FastPass" button

3. Scroll down and click **Save**.

### Configure a FastPass Rule

1. In the Admin Console, select **Security** > **Authentication policies**.

2. Click **Office365**.

3. For the O365 - Access for Marketing rule, click **Actions**, and then select **Edit**.  
This will open the Edit Rule window.

4. Make sure that the following options are selected:
- Device state is: Registered
- User must authenticate with: Possession factor

5. Click **Save**.

### Test FastPass Passwordless Login

1. Sign in to your org as the New Employee (being a member of the Marketing group).

2. In the End-User Dashboard, open the **Office365** app.

3. Click **Sign in with Okta FastPass** to sign in without using your password.

## Configure Behavioral Security Measures 


## Set Up Self-Service Password Reset

### Configure Self-Service Password Reset

1. In the Admin Console, select **Security** > **Authenticators** > **Enrollment**.

2. Click the **password policy** link.

3. Scroll down and click **Add rule**.  

4. Configure the rule as follows:
- Rule name: Self-Service Password Reset
- Users can perform self-service: Password reset is checked
- Users can initiate recovery with: Email is checked

5. Click **Create rule**.

### Test Password Reset 

1. Make an attempt to sign in to your org as the New Employee with your Username, Password, and Okta Verify code or push notification. Do not use Okta FastPass for this test. When prompted to Verify with your password, click **Forgot password?**.

2. Click **Send me an Email**.

3. In the mailbox you used for registration, find the "Account password reset" email and click **Reset Password**.

4. Follow the instructions on screen to reset your password.

## Okta Access Requests  

### Configure Access Requests

1. In the Admin Console, select **Directory** > **Groups**.

2. Click **Add group**.

3. Enter a group name: Request Approvers and click **Save**.

4. Click the **Request Approvers** link to open the group page.

5. Click **Assign people**.

6. Find your Admin account and click **+** (far right) to assign the Admin to the group.

7. Click **Done**.
 
8. Select **Applications** > **Applications** and click the **Okta Access Requests** app.

9. Select the **Assignments** tab.

10. Click **Assign** and then select **Assign to people**.

11. In the assignment window, for both the Admin and New Employee, click **Assign**.

12. Click **Done**.  
This will assign the Okta Access Requests app to these users.

13. Select the **Push Groups** tab.

14. Click **Push Groups** and then select **Find groups by name**.

15. Enter the group name: Request Approvers and click **Save**.      
This will push the group to the Okta Access Requests app.

16. Select **Identity Governance** > **Access Requests**.  
This will open the Access Requests Console.

17. In the left-hand panel, select **Settings**.

18. Select the **Resources** tab.

19. For both Applications and Okta Groups, click **Update now**.  
This will sync the resources from Okta.

20. In the left-hand panel, select **Teams**.

21. Click **Add Team**.  

22. Configure the team as follows:
- Name: App Request Approvers
- Member: You (your Admin)
- Auto Asign: On
- Assignment style: To a specific user
- Assign all requests to: You (your Admin)

23. Click **Create Team**.

24. In the left-hand panel, select **Settings**.

25. Select the **Integrations** tab.

26. Under Access Request Configurations for Okta, click **Edit connection**.

27. Click **Select teams** and then select **App Request Approvers**.

28. Click **Update connection**.

29. Select the **Resources** tab.

30. For both Applications and Okta Groups, click **Manage Access** and select the **App Request Approvers** team.

31. On the left-hand panel, click **Access Requests**.

32. Click **Create request type**.  
This will open the Request Type Details window.

33. Configure the request as follows:
- Name: [Name of app - TBD] Access Request
- Team: App Request Approvers
- Audience: Everyone at your org

34. Click **Continue**.

35. For Approval, click **Add to request type**.

36. In the right-hand panel, configure the approval as follows:
- Text: Admin Approval
- Make it a required task: On
- Assigned to: A specific user... > You (this will enable approval from your own Admin account)

37. At the bottom of the page, click **Action** > **Assign individual app to user**.

38. In the right-hand panel, configure the action as follows:
- Text: Assign to [Name of app - TBD] 
- Make it a required task: On
- Run automatically: On
- Email address: Requester email
- Select application: [Name of app - TBD]

39. Click **Publish**.

### Test Access Requests

1. Sign out of your org as Admin.

2. Sign in to the org as the New Employee. 

3. In the End-User Dashboard, open the **Okta Access Requests** app.  
This will open the Access Requests Console.

4. In the left-hand panel, select **App Catalog**.

5. Under [Name of app - TBD] Access Request, click **Request access**.

6. Click **Submit new request**.

7. Sign out of your org as the New Employee.

8. In the mailbox you used for registration, find the "[Name of app - TBD] Access Request" email and click **Approve**.

9. Sign in to the org as Admin.

10. You can see the confirmation of granting access to [Name of app - TBD] to the New Employee.

11. Sign out of your org as Admin and sign in as the New Employee.

12. In the End-User Dashboard, you can now see [Name of app - TBD] available.

## Auditing and Reporting

Okta's auditing and reporting features enable you to get valuable insights about the authentication events recorded for your users. This information is captured and kept in system logs and can be analyzed to increase the security of your organization.

1. In the Admin Console, select **Security** > **Behavior Detection**.  
This will take you to the Behavior Detection page, where you can see various user behavior criteria which are tracked by Okta, such as New City, New Country, New Device, New Geo-Location, New IP, and other. It is detected and recorded whether user logs in from a "new" or "old" location or device. For each criterion, you can define how is it evaluated.

2. For New Device, click the **pen icon** (far right).  
You can see that "Evaluate against past" is set to 20 authentications. This means that if a user logs in from other device than the one used for past 20 authentications, this will be recorded in system logs as new behavior.

3. Click **Cancel** to close the window.

4. In the left-hand panel, select **Reports** > **System Log**.  
This will take you to the System Log page, where you can see the following items:
- Search field - Here you can type your search queries about the system events to gain more insights from the data
- Count of events over time - Histogram of events, showing the number of events recorded in the system for particular time frames
- Events table - List of all system events with latest on top

5. In the Search field, type the first name of your New Employee.  
This will filter the log results to show only the events for the New Employee.

6. In the "Count of events over time" histogram, hover over each column to see the count of events recorded for the New Employee in particular time frames. 

7. In the Events table, find the columns Event Info and Targets, which include information about actions, apps, and authenticators involved in particular events.  

8. Scroll down the table to see specific events recorded for the New Employee. You may need to click **Show More** at the bottom to load all events.  
Take a moment to analyze how the employee’s lifecycle and access has been recorded from hire to termination.

   > **Note:** In the Okta Expression Language, user behavior fields in the logs are stored as key : value pairs, where:
   - Key is the type of behavior (following the Behavior Detection criteria: New City, New Country, New Device, New Geo-Location, New IP, and other)
   - Value is either "negative" (meaning no change in behavior) or "positive" (meaning change in behavior detected).  
  You will use this information in the next step.
   > 

9. In the Search field, type "positive".  
This will filter the log results to show only the events when a change in user behavior was detected.

10. In the Events table, choose one of the events and on its left-hand side click **>** to see details of this event.  

11. On the right-hand side of the event, click **Expand All** to expand all the details. 

12. Search for the Behaviors line.  
You should see a record confirming a change in user behavior. For example, for the event in which you logged in from a New Device (following instructions in the User Behavioral Analytics section), this should be "New Device=POSITIVE" .  

13. In the left-hand panel, select **Reports** > **Reports**.  
This will take you to the Reports page, where you can find Okta’s out-of-the-box auditing reports.  

14. Under Application Access Audit, click **Current Assignments**.  

15. Click **Request report**.

16. Close the Report requested window.  

17. In the mailbox you used for registration, find the "Current Assignments Report" email and click **Download report**.  
Your report should begin downloading automatically. If it does not, click **Download report**.  

18. Close the Downloading report window. 

19. Open the downloaded "CurrentAssignmentsReport.csv" file and analyze the assignments of particular apps to the users.