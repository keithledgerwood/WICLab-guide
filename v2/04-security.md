# Okta Security

## Overview

Okta Verify is a multifactor authentication (MFA) app developed by Okta. It lets users verify their identity when they sign in to Okta and makes it less likely that someone pretending to be the user can gain access to the account.

To use Okta Verify, you must install the app on your device and set it up. This is something you already did on your mobile device, when you received the "Your New Okta account" e-mail and signed on to your Okta org. You could see that afterwards when signing in to the Okta org you could verify your identity by approving a push notification in the app, or by entering a one-time code provided by the app.

Okta Verify also enables setting up the Okta FastPass which  provides passwordless authentication to any app in Okta. This means you don't have to enter your password when signing in, so the login experience is as smooth as possible but still highly secure. Okta FastPass obviously reduces the probability of data breaches that can occur from compromised credentials. The solution is supported on Android, iOS, macOS and Windows devices, from any location or network.

## Setup Okta Verify and Okta FastPass

### Install Okta Verify on Your Virtual Machine

To install Okta Verify on your Windows VM (Windows Server), open Chrome in your VM and proceed with the following steps:

1. In your lab environment, in the left-hand Launch panel, under Workforce Identity Cloud, click **Launch**.

>This will open the Admin Console tab in your browser.

2. In the Admin Console, select **Settings** > **Downloads**.

1. Scroll down to **Okta Verify for Windows (.exe)** and click **Download Latest**.

1. Open the downloaded Okta Verify Setup .exe file.

1. In the Okta Verify installation window, select **I agree to the License terms and conditions** and click **Install**.
Wait for confirmation saying that Okta Verify was successfully installed.

1. Click **Finish**.

### Configure Okta Verify

1. On Desktop, find and open **Okta Verify**.

1. In the Welcome to Okta Verify window, click **Get started**.

1. Click **Next**.

1. Enter the sign-in URL to your Okta org: <https://demo-xxxxxx-xxxxx-xxxxx.okta.com>
This will open your Okta org sign-in page in the browser.

1. Verify with your Password and Okta Verify mobile code or push notification.
Your account is added to the Okta Verify desktop app.

## Configure Security Policies and FastPass

### Configure Enrollment Policy for Your Users

1. In the Admin Console, select **Security** > **Authenticators** > **Enrollment** tab.

1. For the Default Policy, click **Edit**.
This will open the Edit Policy window.

1. Verify that Okta Verify is set to Optional and Password is set to Required.

1. Click **Update policy**.

### Enable Okta Verify for FastPass Authentication

1. In the Admin Console, select **Security** > **Authenticators** >**Setup** tab.

1. For **Okta Verify**, click **Actions**, and then select **Edit**.
This will display the Okta Verify options.

1. In **Verification options**, verify that the following options are selected:

- Push notification (Android and iOS only)
- Okta FastPass (All platforms)

1. Select **Show the "Sign in with Okta FastPass" button**.
1. Scroll down and click **Save**.

### Configure a FastPass Rule for Microsoft O365

1. In the Admin Console, select **Security** > **Authentication policies**.
2. Select the  **Microsoft Office 365** authentication policy.
3. Click **Add Rule**.
4. Set the **Rule name** to **Okta FastPass Access for Marketing and Sales**.
5. Set the following **IF** conditions for the rule:

| IF | Value|
|:-----|:-----|
|User's  type is| Accept the default |
|User's group membership includes|**At least one of the following groups:**|
| Enter groups to include: |  **Marketing** and **Sales**|
|Device State |**Registered**|
|Device management |**Not Managed**|
|Client is |**Web Browser** and **Modern Authentication**|'

 6. Set the following **THEN** access and authentication settings for the rule:

|THEN||
|:-----|:-----|
|User must authenticate with:| **Possession factor**|
|Possession factor constraints are|  **Phishing resistant** and **Hardware protected**|
|If Okta FastPass is used |**The user must approve a prompt in Okta Verify or provide biometrics**|

7. Click **Save**.
8. Using the *vertical waffle*, move the new rule up to the top of the priority list.

### Experience a Passwordless Login

1. Sign in to your org as the new employee, who is a member of the Marketing group.

1. In the End-User Dashboard, open the **Office365** app.

1. Click **Sign in with Okta FastPass** to sign in without using your password.

## Set Up User Behavioral Analytics

### Configure Behavioral Security Measures

1. In the Admin Console, select **Security** > **Behavior Detection**.
This will take you to the Behavior Detection page, where you can see various user behavior criteria which are tracked by Okta, such as New City, New Country, New Device, New Geo-Location, New IP, and others. It is detected and recorded whether the user logs in from a "new" or "old" location or device. For each criterion, you can define how it is evaluated.
2. For New Device, click the **pen icon** (far right).
You can see that "Evaluate against past" is set to 20 authentications. This means that if a user logs in from a different device than the one used for past 20 authentications, this will be recorded in system logs as new behavior.
3. Click **Cancel** to close the window.

### Add a Network Zone and Policy Rule

1. In a browser, outside of the virtual lab environment, sign in to your org as the Admin.
2. Return to your virtual environment.
3. In the Admin Console, select **Security** > **Networks**.
4. Click **Add zone** and then select **IP Zone**.
5. Set **Zone name** to Allowed IP.
6. Set **Gateway IPs** to your **current IP address**.
7. Click **Save**

### Add an Authentication Policy Rule

1. Select **Security** > **Authentication policies**.
2. Select the **Any two factors** policy
3. Click **Add rule**.
4. Configure the rule as follows:

- Rule name: Travel Not Allowed
- User's IP is: Not in any of the following zones > Allowed IP
- Access is: Denied

5. Click **Save**.

14. For this step, you will need to go outside of your virtual environment. In your laptop browser, make an attempt to sign in to your org as the Admin. Because you are now trying to log in from another IP than allowed, your login will be denied and you will get a notification saying "The resource owner or authorization server denied the request".
If you login immediately after setting up the policy rule, it may happen that you will be able to initially sign in, however will be soon automatically signed out.

15. Go back to your virtual environment.
16. Select **Security** > **Authentication policies**.
17. Click **Any two factors**.
18. For Travel Not Allowed, click **Actions** and then **Deactivate**.
This will disable this policy rule.

### Enable Okta ThreatInsight

Okta ThreatInsight aggregates data about sign-in activity across the Okta customer base to analyze and detect potentially malicious IP addresses and to prevent credential-based attacks such as: password spraying, credential stuffing, and brute-force cryptographic attacks. Because ThreatInsight collects information about the origin of sign-in activity directed at Okta organizations and Okta endpoints, it provides a security baseline for all Okta customers.

To enable Okta ThreatInsight, proceed with the following steps:

1. In the Admin Console, select **Security** > **General**.
2. Scroll down to Okta ThreatInsight settings and click **Edit**.
3. Select **Log and enforce security based on threat level**.
This setting will make Okta automatically deny access to sign-in requests that come from potentially malicious IP addresses that ThreatInsight detects.
4. Click **Save**.

### Add a Device Assurance Policy

1. Select **Security** > **Device Assurance Policies**.
2. Click **Add a policy**.
3. Configure the device assurance policy as follows:

- Policy name: Restrict access to old operating systems
- Platform: Choose the platform appropriate for the phone on which you installed the Okta Verify app (Android or iOS)
- Minimum Android/iOS version > Customize: For Major, enter a value higher than your current OS version (even if it is a version not released yet)

4. Click **Save**.
5. Select **Security** > **Authentication policies**.
6. Click **Any two factors**.
7. Click **Add rule**.
8. Configure the rule as follows:

- Rule name: Access on New OS Only
- Device state is: **Registered**
- Device management is: **Not managed**
- Device assurance policy is > Any of the following device assurance policies: Restrict access to old operating systems
- Access is: **Allowed after successful authentication**

9. Click **Save**.
10. For Catch-all Rule, click **Actions**, and then **Edit**.
11. Configure the rule as follows:

- Access is: Denied

12. Click **Save**.

### Test the Device Assurance Policy

1. On the phone on which you installed the Okta Verify app, open the app, and under your org and Admin username tap **Launch Dashboard** link.
Because you are now trying to sign in from a device with OS version lower than allowed, your login will be denied and you will get a notification saying that you should update your system to be able to sign in.

2. Go back to your virtual environment.
3. Select **Security** > **Authentication policies**.
4. Click **Any two factors**.
5. For Access on New OS Only, click **Actions** and then **Deactivate**.
This will disable this policy rule.
6. For Catch-all Rule, click **Actions** and then **Edit**.
7. Configure the rule as follows:

- Access is: Allowed after successful authentication.

8. Click **Save**.
This will enable sign in from your phone again.
