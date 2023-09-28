# Okta Security

## Overview

Okta Verify is a multifactor authentication (MFA) app developed by Okta. It lets users verify their identity when they sign in to Okta and makes it less likely that someone pretending to be the user can gain access to the account.

To use Okta Verify, you must install the app on your device and set it up. This is something you already did on your mobile device, when you received the "Your New Okta account" e-mail and signed on to your Okta org. You could see that afterwards when signing in to the Okta org you could verify your identity by approving a push notification in the app, or by entering a one-time code provided by the app.

Okta Verify also enables setting up the Okta FastPass which  provides passwordless authentication to any app in Okta. This means you don't have to enter your password when signing in, so the login experience is as smooth as possible but still highly secure. Okta FastPass obviously reduces the probability of data breaches that can occur from compromised credentials. The solution is supported on Android, iOS, macOS and Windows devices, from any location or network.

## Setup Okta Verify and Fastpass

### Install Okta Verify on Your Virtual Machine

Launch your Virtual Machine by going to the lab portal and click **Launch Virtual Machine**.

To install Okta Verify on your Windows VM (Windows Server), open a preferred browser (Chrome or Firefox) in your VM and proceed with the following steps:

1. In your lab environment, in the left-hand Okta Workforce panel, under Workforce Identity Cloud, Click **Launch**.
This will open the Okta org tab in your browser.

1. Login with your Username, Password, and Okta Verify code or push notification.
You can now see the Okta End-User Dashboard.

1. Click **Admin**.
This will open the Admin Console tab in your browser.

1. In the Admin Console, select **Settings** > **Downloads**.

1. Scroll down to **Okta Verify for Windows (.exe)** and click **Download Latest**.

1. Open the downloaded Okta Verify Setup .exe file.

1. In the Okta Verify installation window, select **I agree to the License terms and conditions** and click **Install**.
Wait for confirmation saying that Okta Verify was successfully installed.

2. Click **Finish**.

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

1. In the Admin Console, select **Security** > **Authenticators** > **Enrollment**.

1. For the Default Policy, click **Edit**.
This will open the Edit Policy window.

1. Make sure that Okta Verify is set to Optional and Password is set to Required.

1. Click **Update policy**.

### Enable Okta Verify for FastPass Authentication

1. In the Admin Console, select **Security** > **Authenticators**.

1. For Okta Verify, click **Actions**, and then select **Edit**.
This will open the Okta Verify window.

1. Make sure that the following options are checked:

- Push notification (Android and iOS only)
- Okta FastPass (All platforms)
- Show the "Sign in with Okta FastPass" button

4. Scroll down and click **Save**.

### Configure a FastPass Rule

1. In the Admin Console, select **Security** > **Authentication policies**.

2. Click **Microsoft Office365**.

3. Click **Add Rule**. Name the rule O365 - Access for Marketing rule.

4. Make sure that the following options are selected:

- User's group membership includes: At least one of the following Groups: Add Marketing Group
- Device state is: **Registered**
- Device management is: **Not Managed**
- Client is: One of the following clients: **Web Browser** and **Modern Authentication**
- User must authenticate with: **Possession factor**
- Possession factor constraints are
  - Phishing Resistant
  - Hardware protected
  - If Okta FastPass is used: The user must approve a prompt in Okta Verify or provide biometrics

5. Click **Save**.

### Challenge 3 - Verify: Test FastPass Passwordless Login

1. Sign in to your org as the New Employee (being a member of the Marketing group).

1. In the End-User Dashboard, open the **Office365** app.

1. Click **Sign in with Okta FastPass** to sign in without using your password.

## Set Up User Behavioral Analytics

### Configure Behavioral Security Measures

1. In the Admin Console, select **Security** > **Behavior Detection**.
This will take you to the Behavior Detection page, where you can see various user behavior criteria which are tracked by Okta, such as New City, New Country, New Device, New Geo-Location, New IP, and others. It is detected and recorded whether the user logs in from a "new" or "old" location or device. For each criterion, you can define how it is evaluated.

2. For New Device, click the **pen icon** (far right).
You can see that "Evaluate against past" is set to 20 authentications. This means that if a user logs in from a different device than the one used for past 20 authentications, this will be recorded in system logs as new behavior.

3. Click **Cancel** to close the window.

4. For this step, you will need to go outside of your virtual environment. In your laptop browser, sign in to your org as the Admin.
This activity will be recorded in the system logs as login from a New Device. You will track this later in the Auditing and Reporting section.

5. Go back to your virtual environment.

6. In the Admin Console, select **Security** > **Networks**.

7. Click **Add zone** and then **IP Zone**.

8. Configure the IP Zone as follows:

- Zone name: Allowed IP
- For Gateway IPs, by Add your current IP address, click the IP of your VM
- Click **Save**

9. Select **Security** > **Authentication policies**.

10. Click **Any two factors**.

11. Click **Add rule**.
This will open the Add Rule window.

12. Configure the rule as follows:

- Rule name: Travel Not Allowed
- User's IP is: Not in any of the following zones > Allowed IP
- Access is: Denied

13. Click **Save**.

14. For this step, you will need to go outside of your virtual environment. In your laptop browser, make an attempt to sign in to your org as the Admin.
Because you are now trying to log in from another IP than allowed, your login will be denied and you will get a notification saying "The resource owner or authorization server denied the request".
If you login immediately after setting up the policy rule, it may happen that you will be able to initially sign in, however will be soon automatically signed out.

15. Go back to your virtual environment.

16. Select **Security** > **Authentication policies**.

17. Click **Any two factors**.

18. For Travel Not Allowed, click **Actions** and then **Deactivate**.
This will disable this policy rule.

19. Select **Security** > **Device Assurance Policies**.

20. Click **Add a policy**.

21. Configure the device assurance policy as follows:

- Policy name: Restrict access to old operating systems
- Platform: Choose the platform appropriate for the phone on which you installed the Okta Verify app (Android or iOS)
- Minimum Android/iOS version > Customize: For Major, enter a value higher than your current OS version (even if it is a version not released yet)

22. Click **Save**.

23. Select **Security** > **Authentication policies**.

24. Click **Any two factors**.

25. Click **Add rule**.

26. Configure the rule as follows:

- Rule name: Access on New OS Only
- Device state is: **Registered**
- Device management is: **Not managed**
- Device assurance policy is > Any of the following device assurance policies: Restrict access to old operating systems
- Access is: **Allowed after successful authentication**

27. Click **Save**.

28. For Catch-all Rule, click **Actions**, and then **Edit**.

29. Configure the rule as follows:

- Access is: Denied

30. Click **Save**.

31. On the phone on which you installed the Okta Verify app, open the app, and under your org and Admin username tap **Launch Dashboard** link.
Because you are now trying to log in from a device with OS version lower than allowed, your login will be denied and you will get a notification saying that you should update your system to be able to sign in.

32. Go back to your virtual environment.

33. Select **Security** > **Authentication policies**.

34. Click **Any two factors**.

35. For Access on New OS Only, click **Actions** and then **Deactivate**.
This will disable this policy rule.

36. For Catch-all Rule, click **Actions** and then **Edit**.

37. Configure the rule as follows:

- Access is: Allowed after successful authentication.

38. Click **Save**.
This will enable login from your phone again.

### Enable Okta ThreatInsight

Okta ThreatInsight aggregates data about sign-in activity across the Okta customer base to analyze and detect potentially malicious IP addresses and to prevent credential-based attacks such as: password spraying, credential stuffing, and brute-force cryptographic attacks. Because ThreatInsight collects information about the origin of sign-in activity directed at Okta organizations and Okta endpoints, it provides a security baseline for all Okta customers.

To enable Okta ThreatInsight, proceed with the following steps:

1. In the Admin Console, select **Security** > **General**.

2. Scroll down to Okta ThreatInsight settings and click **Edit**.

3. Select **Log and enforce security based on threat level**.
This setting will make Okta automatically deny access to sign-in requests that come from potentially malicious IP addresses that ThreatInsight detects.

4. Click **Save**.
