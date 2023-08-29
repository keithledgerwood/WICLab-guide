## Install Okta Verify

### Overview

Okta Verify is a multifactor authentication (MFA) app developed by Okta. It lets users verify their identity when they sign in to Okta and makes it less likely that someone pretending to be the user can gain access to the account.

To use Okta Verify, you must install the app on your device and set it up. This is something you already did on your mobile device, when you received the "Your New Okta account" e-mail and signed on to your Okta org. You could see that afterwards when signing in to the Okta org you could verify your identity by approving a push notification in the app, or by entering a one-time code provided by the app.

Okta Verify also enables setting up the Okta FastPass which  provides passwordless authentication to any app in Okta. This means you don't have to enter your password when signing in, so the login experience is as smooth as possible but still highly secure. Okta FastPass obviously reduces the probability of data breaches that can occur from compromised credentials. The solution is supported on Android, iOS, macOS and Windows devices, from any location or network.  

To install Okta Verify on your Windows VM (Windows Server), open a preferred browser (Chrome or Firefox) and proceed with the following steps:




## Configure Security Policies and FastPass

### Enable Okta Verify for Authentication

1. On the Security > Authenticators page, select Edit from the Okta Verify authenticator Actions drop-down list.  

2. On the Okta Verify page, make sure Push notification (Android and iOS only) and Okta FastPass (All platforms) is checked.  

3. Scroll down and click Save.

### Create a new Authentication Policy for your O365 App

1. Navigate to Security > Authentication policies.  

2. Click Add a policy.  

2. Name the new policy: O365.  

4. Add your O365 app to the new policy, select the Applications tab and press the Add App button.

5. Select O365 from the list of applications.

6. Add a new rule and call it O365 - Access for Marketing.  

7. Configure the rule as follows:
- Select the Marketing group to be included in the rule.  
- For User must authenticate with option, select Any 1 Factor type.

8. Save rule.

### Test Multi-Factor Authentication

1. Sign in to your org as ..... (who is in the Marketing group).




## Configure Behavioral Security Measures 


## Configure Self Service Password Reset