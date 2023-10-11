
## Embracing a Passwordless Experience

In this lab, you will unlock the combined power of Okta Verify and FastPass. You will enable an experience where passwordless authentication becomes an integral part of an employee’s workday, boosting employee productivity without the common password pitfalls. Not only will you discover an enhanced security posture resistant to phishing threats, but you’ll also appreciate the inherent protection it offers, sometimes even against our own human errors.

## Setup Okta Verify and Okta FastPass

>**Tip:** You may want paste your Okta tenant url into Notepad++ for easy copying and pasting in this lab.

### Install Okta Verify on your Virtual Machine

<!-->
1. To install Okta Verify,launch your Virtual Machine (VM) from the launch panel, and then open Chrome.

1. Enter the sign-in URL to your Okta org, For example *<https://demo-xxxxxx-xxxxx-nnnnn.okta.com>, and then sign in with your administrator account.
-->
1. In the Okta Admin Console, select **Settings** > **Downloads**.
1. Scroll down to **Okta Verify for Windows (.exe)** and click **Download General Availability**.

|||
   |:-----|:-----|
   |![Alt text](images/011/marc_r74_100.png "Marc says...") |Did you know that you can also download Okta Verify for Windows directly. I probably should have told you earlier. HAH!
   <https://okta.okta.com/artifacts/WINDOWS_OKTA_VERIFY/4.4.1.0/OktaVerifySetup-4.4.1.0-470900d.exe>|

5. Open the downloaded **OktaVerifySetup-4.4.exe** file.
6. In the Okta Verify installation window, select **I agree to the License terms and conditions**, and then click **Install**.
    Wait for confirmation saying that Okta Verify was successfully installed.
7. Click **Finish**.
8. Sign out of Okta and close the browser.

### Add New Employee Account to Okta Verify

1. On the VM desktop, find and open **Okta Verify**.

1. On **Welcome to Okta Verify**, click **Get started**.

1. Click **Next**.

1. For **New Account**, enter your Okta tenant URL. For example: <https://demo-xxxxxx-xxxxx-xxxxx.okta.com>.
1. Click **Next**.
This will open your Okta tenant's sign-in page.

1. Sign in with your **New Employee** username and password and Okta Verify MFA.
Upon successful authentication, the new employee account will be added to the Okta Verify desktop app.

## Configure Security Policies and FastPass

|||
   |:-----|:-----|
   |![Alt text](images/011/marc_r74_100.png "Marc says...")|*Did you know with Okta Adaptive MFA, you get personalized security that learns from your habits, making logging in a breeze while keeping intruders at bay? Think of it as the bouncer who always spots the VIP - that's you!*|

## Enable Okta Verify for FastPass Authentication

1. In the Admin Console, select **Security** > **Authenticators** > **Setup** tab.

1. For **Okta Verify**, click **Actions**, and then select **Edit**.
This will display the Okta Verify options.

1. For **Verification options**, confirm that the following options are selected: **Push notification (Android and iOS only)** and **Okta FastPass (All platforms)**.
1. For **Okta FastPass** select **Show the "Sign in with Okta FastPass" button**.
1. Scroll down and click **Save**.

### Add a rule to the "Any Two Factors" policy

1. In the Admin Console, select **Security** > **Authentication policies**.
2. Select the  **Any Two Factors** authentication policy.
3. Click **Add Rule**.
4. Set the **Rule name** to **Okta FastPass Access for Marketing and Sales**.
5. Set the following **IF** conditions for the rule:

    | IF | Value|
    |:-----|:-----|
    |User's  type is| Accept the default |
    |User's group membership includes|**At least one of the following groups:**|
    | Enter groups to include: |  **Marketing** and **Sales**|'

6. Set the following **THEN** access and authentication settings for the rule:

    |THEN||
    |:-----|:-----|
    |User must authenticate with:| **Possession factor**|
    |Possession factor constraints are|  **Phishing resistant** and **Hardware protected**|
    |If Okta FastPass is used |**The user must approve a prompt in Okta Verify or provide biometrics**|

7. Click **Save**.

### Experience a Passwordless Login

1. Launch a Chrome browser window using the Guest profile.
1. Enter your Okta tenant URL in the browser.
1. At the Okta login, click **Sign in with Okta FastPass** . You will be signed in to the End-User Dashboard, no password required.

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

|||
   |:-----|:-----|
   |![Alt text](images/011/marc_r74_100.png "Marc says...")|*Did you know that with Okta Adaptive MFA's smart tech, you're not just getting a lock but a security system that learns? It's the future of personalized digital safety, today!*|

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
