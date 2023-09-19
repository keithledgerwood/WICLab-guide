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

### Test Self-Service Password Reset 

1. Make an attempt to sign in to your org as the New Employee with your Username, Password, and Okta Verify code or push notification. Do not use Okta FastPass for this test. When prompted to Verify with your password, click **Forgot password?**.

2. Click **Send me an Email**.

3. In the mailbox you used for registration, find the "Account password reset" email and click **Reset Password**.

4. Follow the instructions on screen to reset your password.

## Set Up Self-Service App Request

### Configure Self-Service App Request

1. In the Admin Console, select **Applications** > **Self Service**.

2. In the Settings tab, for User App Requests, click **Edit**.

3. Select **Allow users to add org-managed apps** and **Allow users to add personal apps**.

4. Click **Save**.

### Test Self-Service App Request

1. Sign out of your org as Admin and sign in as the New Employee.

2. In the End-User Dashboard, in the left-hand panel, click **Add apps**.  
This will open the App Catalog page.

3. For [Name of app - TBD], click **Add**.  
You will see a notification saying "[Name of app - TBD] has been added to your dashboard".  

4. In the left-hand panel, click **My Apps**.  
You can now see [Name of app - TBD] available in your End-User Dashboard.

## Set Up Okta Access Requests  

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
- Auto Assign: On
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

31. In the left-hand panel, click **Access Requests**.

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