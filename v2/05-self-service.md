# Challenge 4: Self Service

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

