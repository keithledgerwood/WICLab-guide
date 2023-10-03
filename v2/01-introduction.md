# Okta Workforce Identity Lab

## Lab Overview

Welcome to the Okta’s Workforce Identity Cloud Lab! (Version 0.10.3.02)

Congratulations! You got the job - you’re in charge of handling your organization’s Workforce Identity Management. You’ve been given the high level directive by the CIO to do the following:

- (1) Reduce Cost related to IAM.
- (2) Increase Security Posture and follow Zero Trust best practices.
- (3) Improve Visibility into what employees are accessing and take actionable measures based on that visibility.
- (4) Create a great experience and increase employee productivity.

You’ve got 3 hours!

Nervous yet? Don’t be! We’re going to take you from Zero to Hero within the next few hours! You’re working with Okta’s Workforce Identity Cloud, the best platform in the industry to achieve your Identity Goals. We’ll show you how to look for ways to take advantage of Okta’s platform to meet all of the business needs without needing weeks, months or even years to make it all work, you’re going to be hands on and learn all this within a few hours.

Workforce Identity Cloud (WIC) is a platform that can be used to tackle numerous Identity and Access Management (IAM) challenges and is by far the easiest and most secure solution for solving these use cases. This 101 course will give you a well-rounded primer into how to think about IAM and take advantage of Okta’s quick time-to-market.

This Lab Guide will provide you with step-by-step instructions that you need to follow to complete the hands-on exercise and get practical experience with Okta’s Workforce Identity Cloud.

In this lab, you will complete a series of Workforce Identity related challenges:

1. Onboard New Team Member

- Setup:
  - Configure Bamboo HR as an Authoritative Identity Source
- Validate:
  - Onboard a new team member
  - Import the new team member in Okta
  - First Day Access: Simplifying the Initial Login
    - Establish a password
    - View available applications in Okta dashboard

2. Integrating Office 365: Streamlining Workplace Tools

- Setup:
  - Configure Office 365 single sign-on
  - Configure Office 365 provisioning
- Validate:
  - Login as a new employee and checking your Office 365 access

3. Boost Security

- Passwordless Experience with Okta Fastpass - Setup:
  - Install / configure Okta Verify
  - Enhance security for Office 365
  - Enable  passwordless authentication
- Validate
  - Experience a passwordless login
- Restrict Access Based on IP Address Network Zone
- Restrict Access Based on OS Version

4. Self-Service Solutions: Managing Passwords and Access Requests Independently
    - Perform a self-service password reset
    - Request access to an application
    - View your new application assignments
    - Request an additional application
    - Approve application requests
    - Revisit your application assignments
5. Identity Governance: Managing and Securing Access Transitions

- Setup:
  - Transfer a team member in Bamboo HR
  - Perform access  certification in Okta
- Validate
  - View application assignments

6. Offboarding: A Smooth Transition Out of the Organization

- Setup:
  - Initiate team member termination in Bamboo HR
- Validate:
  - Attempt a post-termination login

7. Insights and Oversight: Audits and Reporting Essentials
    - Review the syslog for activity events
8. Integrate Okta with Legacy Directory (Active Directory)

- Setup:
  - Install Active Directory Agent
- Validate
  - Employee provisioned to AD

## An Overview of the Lab Environment - labs.demo.okta.com

In this lab, you will be working in a dedicated environment that ....

### Initial access to your Okta tenant

1. In the mailbox you used for registration, find and open the "Your New Okta account" email.
2. Copy the temporary password, and then click **Sign On**.
3. Follow the instructions on the screen to sign on to your Okta org.

>This will require that you sign in with your temporary password (which can be found in the "Your New Okta account" email), set up a new password and set up the Okta Verify app on your mobile device.>

After successful sign on, you will see the Okta End-User Dashboard.

### Launching your  Okta Workforce Identity Cloud tenant

1. In the Lab environment, click **Launch** for Workforce Identity Cloud.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/launch-wic.png "image_tooltip")

### Launching your Virtual Infrastructure

In this lab, you will be provided with a Virtual Infrastructure with a Windows Virtual Machine (VM). We recommend that you complete the lab in this virtual environment, unless otherwise stated.

1. In the Lab environment, click **Launch** for Active Directory.

### Launching your HR tenant - BambooHR

1. In the Lab environment, click **Launch** for BambooHR.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/launch-bamboohr.png "image_tooltip")

2. Click **Login to Tenant**, and sign in using the provided BambooHR admin account credentials.

> **Note:** The launch window will display your **BambooHR tenant subdomain** and your **BambooHR admin account credentials**. This information will be needed later to configure the integration.

### Launching your Office Productivity tenant - Office 365

1. In the Lab environment, click **Launch** for Office365.
2. Click Login to Tenant and sign in with your labadmin credentials.

   > There's a rule setup to copy all of the @yourwiclabdomain.com emails to your administrator's Outlook inbox of the Office365 tenant.\
Please expect your user activation emails there.

### Chrome Profiles
>
>**Tip:** It is recommended that you create a Chrome profile for your new employee so that you can have separate browser sessions
>
