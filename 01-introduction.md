## Welcome

*Lab guide version: 0.11.06.02*

Step into the Future of Workforce Identity Management with Okta!

Imagine being entrusted with your organization’s Workforce Identity Management. Your mission, should you choose to accept it:

1. Cut Down on IAM Costs
2. Boost Security with Zero Trust principles
3. Enhance Visibility into employee access patterns and act on them.

And... all the while ensuring an incredible user experience that amplifies productivity. Sounds intense, doesn’t it?

Here’s the Twist: With the unparalleled capabilities of Okta’s Workforce Identity Cloud, it's more than possible. And we're here to guide you every step of the way!

## Initial sign in to your Okta tenant

As part of the provisioning process for your Okta Workforce Identity Cloud tenant, an Okta admin account was created that corresponds to the email address that you used to sign in to labs.demo.okta.com.

1. Check your inbox for an email with the subject line **Your New Okta account**.
1. Copy the **Temporary password**, and then click **Sign On**.
1. Follow the instructions on the screen to sign in to your Okta tenant. After a successful sign in, you will see the **Okta End-User Dashboard**.
1. Sign out of your Okta tenant and close the browser tab.
1. Return to this lab guide for more fun and excitement.

## Launch your Virtual Desktop

1. In the  **Launch Pad** on the right, under **Virtual Desktop**, click **Launch**. This will open a new browser tab.

   |||
      |:-----|:-----|
      |![Virtual Desktop](images/011/launch_virtual_desktop.png "Launch Virtual Desktop")| |
2. Click **Launch Virtual Infrastructure**. It may take up to five minutes for your Virtual Desktop to start, so please sit back and enjoy today's featured presentation.

3. Copy this code block.
```$labName="{{idp.name}}"; (iwr https://cdn.demo.okta.com/labs/techcamps_wic/labvm/config.ps1 | iex)```

4. In the Virtual Desktop, open PowerShell, and then paste and run the code block.

   |||
   |:-----|:-----|
   |![PowerShell icon](images/011/powershell_icon_25.png   "PowerShell icon")| **Hint:** Look for this PowerShell app icon in the virtual desktop. |

## An Overview of your Lab Environment

Before we get started, here are your resources for today’s mission:

### TechCamps Outline

Where's my GPS? On the left, you’ll find an outline of today’s mission which also serves as your control panel. This TechCamps - Workforce Identity Cloud consists of seven sections, each with its own subsections. As you progress through the sections, the subsections will display. You also have the ability to collapse the outline by clicking on the arrow icon.

   |||
   |:-----|:-----|
   |![TechCamps Outline](images/011/TechCamps_outline_control_250.png   "TechCamps Outline")| |

At the bottom of each section, there's a handy control to navigate forwards and backwards between the sections.

   |||
   |:-----|:-----|
   |![VCR control?](images/011/techcamps_step_controller_200.png   "VCR control?")| |

### Launch Pad

Peek into the fashionably gray box on your right, and you'll discover an easy way to launch your lab resources.  Each resource has it's own launch button along with the tenant names and credentials where applicable. You can collapse and expand the control with the arrow icon and you can reveal the tenant credentials with the key icon.

#### Dynamic Lab Guide Variables

In addition to the ability to copy credentials from the Launch Pad, we've also produced this lab guide using dynamic variables. These variables will display values specific to your lab environment. Simply copy and paste them as needed.

### Okta Workforce Identity Cloud Tenant

Aren’t you lucky? Your own dedicated Okta tenant designed to tackle your organization's identity challenges!

Your Okta tenant will be available for seven days in case you want to continue to explore it features and capabilities.

### Virtual Desktop

The virtual environment where today's real workshop challenges await.

### HR Application

 What's a Workforce identity mission without a genuine HR application for employee sourcing?

 In this lab, all participants are sharing a single instance of BambooHR. In the next section, you'll be asked to create a new employee, so make it unique so as not to cause any confusion.

### Microsoft Office 365

Your employees need seamless and secure access to their primary collaboration tool in order to be productive and stay connected.

In this lab, each participant gets their own Office 365 tenant that is pre-configured with a domain name.
