# Workflows
# Okta Device Access Desktop MFA

## Configure Desktop MFA for Windows

### Overview

Windows MFA is a feature within the Okta Device Access SKU.  It enables an organization to add Okta-managed Multi-Factor Authentication (MFA) to the login flow that users must complete in order to sign-in to their company-managed Windows workstations.

Adding MFA to workstation login increases security and is an important capability for organizations that want to extend the use of MFA beyond web access to all points of authentication.  This might be required for industry compliance or it might be part of a company’s own security strategy.

This lab guide provides step-by-step instructions for setting up Okta Desktop MFA so that you can get familiar with the configuration and see it in action.




## Prerequisites


### Feature Flags

Info! Before starting this lab your instructors need to activate specific feature flags in your Okta org. Please use this link to provide us your Okta org URL.

[https://forms.gle/KUtL7cQQaj4DQsm66](https://forms.gle/KUtL7cQQaj4DQsm66)


### Okta Org with Okta Device Access SKU

The Desktop MFA feature is currently in Early Access but will only be offered if the Okta Device Access SKU is enabled.  For non-revenue-linked orgs used for demos, this SKU can be enabled using Support User.

Once enabled, you will see Desktop MFA listed in the self-service features list of the admin console:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image1.png "image_tooltip")



### Okta Verify authentication factors

In your Okta org, you will need to enable the authentication factors that users will use to perform online authentication.  For the use cases in this document it is assumed that you have Okta Verify enabled for both One-Time Password and Mobile Push. 


## Architecture


## Configure Desktop MFA application

In this section you will enable the Desktop MFA Early Access feature and then configure the Desktop MFA application in your Okta org.


### Enable Desktop MFA EA Feature

At the time of writing, Desktop MFA is an Early Access (EA) feature within the Okta Device Access (ODA) SKU.  For Okta Orgs that have the ODA SKU enabled, the Desktop MFA feature can be enabled (or disabled) within the Features screen of the Admin console.

Follow these instructions:



1. Navigate to the admin console for the Okta org where you are going to set up Desktop MFA. \
This should be the org that is integrated with your Active Directory.
2. Authenticate as an administrator.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image2.png "image_tooltip")


3. Select **Settings > Features** in the navigation menu.
4. Locate the **Desktop MFA** item and use the toggle to enable it.


### Enable Interaction Code grant type

The Desktop MFA feature relies on the use of the _Interaction Code _grant type.  This is not enabled by default in Okta orgs.  If it is not enabled, you will not be able to add the MFA Desktop application (it will give an error saying the feature isn’t available).

Follow these instructions:



1. Go to the Okta admin console for your org.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image3.png "image_tooltip")


2.  Select **Settings > Account** in the navigation menu.
3. Click **Edit **for the _Embedded widget sign-in support_ section (at the bottom of the page)


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image4.png "image_tooltip")


4. Check the checkbox to enable **Interaction Code**.

5. Click **Save**.


### Add the Okta Desktop MFA application

In this section you will add the Desktop MFA application to your Okta org.  This application can be found by browsing the Okta Integration Network (OIN).

Follow these instructions:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image5.png "image_tooltip")


1. Select **Applications > Applications** from the navigation menu.
2. Click **Browse App Catalog**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image6.png "image_tooltip")


3. Enter **desktop mfa** in the search bar.
4. Click on the **Desktop MFA** tile in the results.



5. Click **Add Integration**.

    If you get an error message at this point, check that you have enabled the Desktop MFA feature and enabled the Interaction Code grant type (both described above).


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image7.png "image_tooltip")


6. Click **Done**. \
There’s no need to change the application label.

    The application is added and you are taken to the application properties page.



### Set Username Format and Assign Test User

You will now make a configuration change to the Desktop MFA application definition and assign a test user.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image8.png "image_tooltip")


Before assigning users, you should change the _Username Format_ for the application.  Account matching for Desktop MFA is done based on the sAMAccountName of the Windows user - not the full username.


1. Select the **Sign On **tab on the application properties page.
2. Click **Edit**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image9.png "image_tooltip")


3. In the _Credentials Details_ section, select **AD SAM account name** from the _Application username format_ drop-down list.
4. Click **Save**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image10.png "image_tooltip")



Now you will assign a user to the application.  Only users that are assigned to the Desktop MFA application will be able to use online MFA factors to access their Windows workstations.

5. Select the **Assignments **tab on the application properties page.
6. Click **Assign** and select **Assign to People** from the drop-down menu.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image11.png "image_tooltip")


7. Click **Assign** for your test user. \
This user should be an Active Directory-sourced user who has an Okta Verify (OV) authentication factor registered on a mobile device so they can have OV Push and TOTP factors available.  If you have followed the enablement team’s demo build guides, _Emily Boone_ should meet these requirements.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image12.png "image_tooltip")


You shouldn’t need to change the _User Name_ for the user - it should default to the sAMAccountName based on the previous configuration.

8. Click **Save and Go Back**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image13.png "image_tooltip")


9. Click **Done**.

The Desktop MFA application is now configured.  You are ready to install Desktop MFA on your Windows client.


## Install Okta Verify for Desktop MFA

In this section you will install the Okta Verify application onto the Windows Server instance that is acting as your Workstation.

The current GA version of the Okta Verify application for Windows already includes the extra capability required for it to provide Desktop MFA.  This extra functionality is activated by passing additional parameters to the installer.

In a real deployment, this installation would probably be done via an MDM or using domain policy.  For this lab you will install manually on the command line.


### Download the Okta Verify installer for Windows

Please do the following tasks on your Windows server and use the pre-installed Chrome browser.

Follow these instructions:


1. If not already there, open the Okta admin console and authenticate as an administrator.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image14.png "image_tooltip")


2. Select **Settings > Downloads **in the navigation menu.
3. Locate _Okta Verify for Windows (.exe) _and click **Download Latest**.


### Install Okta Verify with Desktop MFA support

In this section you will install Okta Verify in your Windows test machine using command-line options to activate the Desktop MFA components that it contains.  As mentioned previously, in a real deployment, this installation would be controlled with MDM or Global Policy.

## Prerequisites

### Install .NET Framework 4.8


1. Download the .NET framework installer from the below URL on your Windows server.

[https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net48-web-installer](https://dotnet.microsoft.com/en-us/download/dotnet-framework/thank-you/net48-web-installer)

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image61.png "image_tooltip")

2. Locate the installer in the download directory and execute it.

Once the installation was successful please follow these instructions:


1. Go to the Admin UI of your Okta org.  Hopefully you are still logged in.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image15.png "image_tooltip")


2. Select **Applications > Applications **in the navigation menu.
3. Click the **Desktop MFA **link to open the Desktop MFA application properties.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image16.png "image_tooltip")


4. Select the **General **tab to find the _Client ID _and _Client secret_ fields.  You will need to cut-and-paste these values to build the installation command.
5. Go to the Desktop of your Windows test machine.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image17.png "image_tooltip")


6. Open search and enter **cmd**  Select the result.

This opens a command prompt.

7. Go to the Downloads directory:


```bash
cd Downloads
```

8. Enter the following command - all on one line - to start the installer:
* You can type **Okta** and hit TAB to auto-complete the installer filename which may not exactly match what is shown below)
* The _client id_ and _client secret_ should be cut and pasted from the application properties page in the admin console of your Okta org.

```bash
OktaVerifySetup-4.2.3.0-84302c2.exe SKU=ALL ORGURL=_&lt;org URL>_ CLIENTID=_&lt;client id>_ CLIENTSECRET=_&lt;client secret>_**
```

For example:


**OktaVerifySetup-4.2.3.0-84302c2.exe SKU=ALL ORGURL=https://yourtestorg.okta.com CLIENTID=0oa6i420oaAldAoH4697 CLIENTSECRET=hxQLS45RClft3LmAwx2XbQXF9p5s9weJnpXAihRsTA7x3evPw0J_zd3gN-siUt90**


When you enter this command, the standard Okta Verify install UI will start:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image18.png "image_tooltip")


9. Complete the installer as normal.

When the installer finishes, Okta Verify will be started.  You will see that there is a new _Device Access_ tab where you can register off-line MFA factors:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image19.png "image_tooltip")


Installation of Okta Desktop MFA is complete on your Windows test machine.


### Load configuration to registry (optional)

Right now the Okta Verify Desktop MFA function is running with default configuration.  If you want to change the configuration, this is done by creating/modifying entries in the Windows registry. In a real deployment, these entries would be created by MDM or Global Policy.

To create the configuration entries manually you can use a registry file.  To create this file, copy and paste the text below into a text file with .reg extension:

```bash
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Okta
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Okta\Okta Device Access]
"MfaRequiredList"=hex(7):2a,00,00,00
"MaxLoginsWithoutEnrolledFactors"=dword:00000032
"MaxLoginsWithOfflineFactor"=dword:00000032
"MFAGracePeriodInMinutes"=dword:0000003c
```

Once you have the file on the Windows test machine, you can double-click it to load the contents into the registry.  You can edit the created entries by running **regedit.exe**.


### Set Administrator password and allow local logon for domain users

To be able to use Okta Desktop MFA in this lab environment we need to reset the administrator password and add the domain users group to the domain admins group so that your test user is able to logon locally to the Windows Server. 

**This is strongly  not recommended to be done in a production environment and is not necessary in a real world deployment.**

 \
1. Go to the Desktop of your Windows Server

2. Open the Powershell from the taskbar


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image20.png "image_tooltip")


2. Enter the following two commands:


```bash
Set-ADAccountPassword -Identity Administrator -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "OktaIsAwesome" -Force)
```

```bash
Add-ADGroupMember -Identity "Domain Admins" -Members "Domain Users"
```

## Desktop MFA Use Case Walkthroughs


### Prerequisites

At this point you should be ready to test Desktop MFA for the first time.  You should have the following set up:



* An Okta Org with Okta Device Access SKU enabled
    * Desktop MFA application configured
    * Okta Verify enabled as authentication factor with Mobile push and TOTP
* A Windows Server configured as a Domain Controller for AD forest
    * Okta AD Agent installed and integrated with your Okta org
    * OV+Desktop MFA installed
    * Local logon enabled for domain users
* At least one test user (we recommend to use Emily Boone)
    * Created in Active Directory and imported into Okta
    * Assigned to Desktop MFA application
    * Registered for Okta Verify on a mobile device


### Desktop MFA when online


#### Sign off from Windows test machine


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image21.png "image_tooltip")


1. **Sign out** from within the Windows Desktop to log out.


#### Perform desktop login


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image22.png "image_tooltip")


1. Click on **Retry Connection **and** OK**


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image23.png "image_tooltip")


2. Enter the username and password for your test user. \
This should be an AD domain user that has been imported into Okta and assigned the Desktop MFA application.
3. Click the arrow to login (or press **Enter**).

    At this point, the Okta Desktop MFA Credential Provider contacts your Okta tenant to check for available authentication factors for online MFA authentication.  It should find the Okta Verify mobile registration for your test user which will populate an MFA selector:


4. Select **Okta Verify push notification** from the drop-down list.

    As soon as the option is selected it is executed. After a small pause, you’ll see this screen:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image24.png "image_tooltip")


A OV push authentication has been initiated.  The login process is now waiting for you to verify the login on your mobile device.

5. Complete Okta Verify authentication verification on your mobile device.

This first login attempt will probably show as an unusual sign-in because it’s the first time you have attempted Desktop MFA login from this EC2 instance.  You’ll see that the location reported is based on the public IP address of the EC2 instance.


Once Okta Verify authentication verification is complete, the Desktop MFA process on the Windows test machine will detect this and complete your login.


Nice work, you have successfully tested online login using Okta Desktop MFA!   Don’t log out; keep reading to see how to set up and test offline authentication.


### Configure an offline authentication factor

Standard Okta authentication factors, such as OV push authentication, can only be used when the system has internet connectivity.  These are known as _online factors_.  Online factors require connectivity to Okta to send the challenge and/or because the keys needed to validate the factor are only stored within Okta.

When a device, such as an end user laptop, does not have connectivity, end users still need to be able to authenticate.  To facilitate this, Okta Desktop MFA supports the registration and use of _offline factors_.  These factors use keys securely stored on the device itself for authentication validation.

Follow the instructions below to add an offline authentication factor for your test user:


When a user logs into their Windows account on a system where Desktop MFA is installed, Okta Verify will open if they do not have off-line authentication factors configured.  It will show the new _Device Access_ tab:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image25.png "image_tooltip")


Notice the warning showing the number of logins you have remaining.  This number will decrease each time you login without configuring an offline method.  The limit is a configuration item stored in the registry.


1. Click the **+ One-time password** button.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image26.png "image_tooltip")



The first page has links to download Okta Verify (for a user that doesn’t have the app yet).

2. Click **Next**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image27.png "image_tooltip")


3. With the Okta Verify app on your mobile device:
    1. Select the **+** icon.
    2. Select **Other** (actually it doesn’t matter here).
    3. Select **Scan a QR Code**.
    4. Scan the QR code shown on the Windows desktop screen
    5. Select **Done**.

    The offline one-time password is now registered in your OV application.

4. On the OV App on Windows desktop, click **Next**.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image28.png "image_tooltip")


5. Enter the code displayed in the mobile OV app into the OV desktop app. \
If it is correct, the Next button will activate.
6. Click **Next**.  The offline factor is now enabled:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image29.png "image_tooltip")


You now have an offline authentication method enabled for your account on this Windows system.  You can now test that it works.


### Test offline authentication factor

You can now test the offline authentication factor you just registered.  Follow these instructions:


1. Sign out of the current windows session to end the RDP session. If you simply disconnect from RDP, the windows session will still be active and reconnecting will not trigger the Desktop MFA credential provider.
2. Reconnect to the RDP session and authenticate to the RDP application \
You can use any user for this but it makes sense to use your test Windows user.

The desktop login is displayed:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image30.png "image_tooltip")


3. Enter the username and password for your test user.
4. Click the arrow to login (or press **Enter**).

At this point push verification is automatically triggered because you are online and this was the last online method to be used.  This wouldn’t happen if the machine was offline because online methods are not available when offline:


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image31.png "image_tooltip")


5. Click **Try another way** to return to the authentication method selector.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image32.png "image_tooltip")


6. Select **Offline one-time password **from the selection menu. \
If the machine were really offline, this would be the only choice available.


![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image33.png "image_tooltip")


7. Enter the offline one-time password shown in the OV app on your mobile device into the entry field on the Windows test machine.

As soon as you type the final number of the code it will be verified.  If it is incorrect, an error is shown.  If it is correct, login completes.


Note that the Okta Verify app is not opened on login this time because offline authentication has already been configured.


**Congratulations!**  You have successfully completed an offline login.
