# Identity Governance

Okta Identity Governance (OIG) is a unified IAM and governance solution that includes three products to help governance, risk, and compliance teams simplify access fulfillment and entitlement tasks throughout the identity lifecycle:

- Okta Lifecycle Management
- Okta Workflows
- Okta Access Governance

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/007/image2.png "image_tooltip")

Okta Lifecycle Management provides pre-built integrations between HR and IT systems to automatically keep employee information and status in sync with the IT applications they use. As employees join, move, or leave the company, IT can automatically assign, upgrade, or revoke applications and access to increase productivity, protect the organization from data loss, and eliminate orphaned accounts that increase the attack surface area.

Okta Workflows provides the extensibility and customization necessary to solve your organization's complex identity governance requirements. Easily automate identity processes at scale without writing a single line of code. Enable anyone at your company to create innovative solutions with Okta using if-this-then-that logic, Okta's pre-built connector library, and the ability to connect to any publicly available API.

Okta Access Governance plays a central role in the solution, simplifying access management tasks so administrators can ensure the right people have access to the right resources when needed. Access Governance includes three key features:

- Access Request simplifies and automates the process of requesting access to applications and resources. It meets users where they are by offering self-service capabilities tightly integrated with collaboration tools, delivering a streamlined, frictionless approach that automatically routes user requests to one or more reviewers for approval and auto-provisions the access.
- Access Certification campaigns offer a simple process for creating audit campaigns to periodically review user access to critical resources and approve or revoke access automatically. Those processes are important for making sure employees do not accumulate access and only users who need a resource have access to it.
- Governance Reports help organizations meet audit and compliance requirements. Share a high-level overview of past certification campaigns, including their duration and the resources included—or add more detail, including the users involved and remediation status. Administrators can also provide an audit of who has access to what resources, who approved the access, and how they got the access. Access governance data is stored for three years.

With these combined capabilities, OIG helps organizations improve their security posture, mitigate modern risks, and improve efficiency. Unlike traditional IGA products, which can require complex and custom integrations that are difficult to deploy and expensive to maintain, Okta's unified approach brings together identity, access, and governance to improve an organization's security posture holistically. For example, customers today can integrate Okta with existing HR systems and directories and manage who gets access to what resources. If Okta detects unusual activity, such as a high-risk login through Okta ThreatInsights or a lifecycle status change, you can trigger a certification campaign and immediately suspend access to a resource.


## Workshop description

In this section of the workshop, we will explore the following capabilities:
Access Requests. Once configured, it can be used to grant access.
Access Certifications for Running Access Review Campaigns
Workflows to trigger actions based on specific events like the Change of the job title of one of the employees
This document section will use a pre-built flow and two connections with the Okta tenant.
This document section will explore the unconfigured Access Requests, walk through standard configuration, and then create and run a simple approval flow.

### Workflow connections pre-work

For the workflows in the Okta Workflow Pack to work, you will first need to create a token to connect Okta APIs for that :

1. Open Okta Admin Console and browse to **Security** > **API**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img1.png "image_tooltip")

2. Find the menu in the content pane and click **TOKENS**

3. Create a token by clicking **CREATE TOKEN**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/image2.png "image_tooltip")

4. Copy the token value and store as it will be the only time that you will be able to view it

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img3.png "image_tooltip")


### Workflow Connections


Now, you must configure the following Okta connectors in your Okta Tenant with Workflow enabled.

Different components within Okta have other API endpoints and connectors. In this section, we will build 2 separate connections, one to access the **Universal Directory** and the second to push the configurations to the **Identity Governance**.

#### Create an API Connection


1. Open Okta Workflows by navigating to Okta Admin Console > **Workflow** > **Workflows Console**. This will redirect you to a new page

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img4.png "image_tooltip")

2. On the Workflows Console page, Click **CONNECTIONS** in the top navigation pan 

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img5.png "image_tooltip")

3. Create a new connection by clicking the **NEW CONNECTION** button and selecting **API Connector** as a connection type.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img6.png "image_tooltip")

4. Enter **Okta API - Token-based Auth** as a connection name and **Custom** as the Auth Type

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img7.png "image_tooltip")


5. Enter **Authorization** for the Header Name field and  **SSWS** + the token generated in the Okta Admin console into the Value field


#### Create an Okta Connection

1. Open Okta Admin Console and browse to **Applications** > **Applications** and search for **Okta Workflows OAuth**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img9.png "image_tooltip")

2. in **Okta Workflows OAuth** navigate to the **Sign On** Tab

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img10.png "image_tooltip")

3. Copy and note down the **Client ID** and **Client secret** for later use in this secation.

4. Open Okta Workflows by navigating to Okta Admin Console > **Workflow** > **Workflows Console**. This will redirect you to a new page.

5. On the Workflows Console page, Click **CONNECTIONS** in the top navigation pan and create a 2nd connection by clicking the **new connection** button 

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img8.png "image_tooltip")

6. Entre **Okta** in the search bar, and choose **Okta** from the results

7. Enter the **Domain** of your Okta tenant

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img11.png "image_tooltip")

 > The domain should be provided without **https://** or **-admin**.for example, if you copy the following domain from the URL bar 'https://atko-admin.okta.com,' then you should enter 'atko.okta.com' as the domain.

8. Paste the **Client ID** and **Client secret** from step 3.

9. Click on **Create**

The two connections have been created, and the Okta Workflow is ready to import.

##  Configuring the Flow

### Importing the Flow

1. Download the lab flow "titleChanged.flow."

2. On the Workflows Console page, Click **Flows** in the top navigation pan

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img12.png "image_tooltip")

3. Create a new folder by clicking the **+** icon and name folder “Title Change”

4. Click on the **...** next to the newly created folder and select Import 

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img13.png "image_tooltip")

5. Select or Drag&Drop the downloaded flow pack

You have successfully imported the Flow.  

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img14.png "image_tooltip")


### Modify the imported Flow

There are a few modifications needed within the Workflow.

1. Click on the Workflow to update the existing cards

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img15.png "image_tooltip")

2. Update the first **Compose** card to contain your specific okta tenant name.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img16.png "image_tooltip")

3. Click **Save**

    > When saving the first time, you might see the below pop-up. Ensure the **Save all data that passes through the Flow?** box is checked, and click Save. 

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img17.png "image_tooltip")


4. Click the **Flow is Off** button and click the Flow is Off to turn on the Flow

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img18.png "image_tooltip")

You now have the Flow correctly configured and running.

### Stage a user to trigger the Workflow

In order to trigger this Flow, an action we're listening to should occur. In this case, an existing user that has a manager will have their title updated.

1. Assigne the user a manager, navigate to **Directory** > **People** > and select your test user. 

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img19.png "image_tooltip")

2. Click on **Profile** then **Edit** and Scroll all the way down to find the **managerID** field, and update that with your email

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img20.png "image_tooltip")

3. In a Saparate page navigate to your **BambooHR** instance, Find the user and add a new **Job Entry**. 

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img21.png "image_tooltip")


4. Back in the Okta administration UI, navigate to **Applications > Applications**, and select the BambooHR app definition.

5. In the **Import tab**, click **Import Now**, you should see that 1 user was updated 

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img22.png "image_tooltip")

6. Confirm changes to your user by selecting them and clicking **Confirm Assignments**.

This Event should now trigger the Flow we imported, which will launch a certification campaign. 

## Access Certification


The following capability we will explore is Access Certification. Access Certification (aka attestation, recertification, etc.) is the mechanism to validate that a user still needs the access they have. It is a common control in compliance regulations. Certification campaigns may be run periodically, or there may be continuous certification when user roles change. Okta Identity Governance currently supports user-group memberships and user-application assignments. Participants in a campaign (such as the user's manager) will approve (access retained) or revoke access (access should be removed).

This section of the document will explore the Access Certification mechanism in Okta Identity Governance by creating a campaign, launching it, and having a manager review access.

### Reviewing an Access Certification Campaign

Access certification is built into the Okta platform. There is an administrative interface to create and manage campaigns and an end-user interface for participating in campaigns.

We will review the created campaign for users that was triggered by the **Title change**. 

#### Validate the created campaign

Before proceeding with the certification campaign, make sure that the user has at least one application assigned and the user is able to access that application. 

Campaigns can be created via API and the UI of the admin platform. To review and validate the campaign that was created by the Workflow we set, you will need to perform the following actions:

1. Login into Okta as an administrator and go to the Admin console
2. Find the new Identity Governance menu item and expand it
3. Click on Access Certifications

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img23.png "image_tooltip")

4. The page provides an overview of the campaign, the progress of the campaign, and the items to be reviewed.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img26.png "image_tooltip")

> An administrator can use this page to manage the execution of a campaign. They can see the progress and any items still outstanding. They can reassign one or more items. They can also prematurely end the campaign (Actions > End).

#### Participating in an Access Certification Campaign

##### Manager Review

1. Reviewing is done from the **Access certification Review** application, Log in to your **End User Dashboard** by clicking on the **Drop down menu** in the top right corner and click on **My End User Dashboard**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img24.png "image_tooltip")

2. In the search bar, enter **Okta Access Certification Reviews** and click on the results. 

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img25.png "image_tooltip")

> This tile (Okta application) is tied to a group where membership is dynamically managed within Okta. If an Okta user is flagged as a reviewer in any active campaign, they will be in the group and see the application on the dashboard.

You are presented with a list of campaigns for which the user is a reviewer. You see a summary of information about each active campaign.

3. On the following page, you can see all of the open and closed review campaigns. Click on the **Campaign Name**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img27.png "image_tooltip")

4. You will see all applications assigned to this user.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img28.png "image_tooltip")

> For each item, you have three options as a reviewer: Approve (leave the access as is), Revoke (remove access or flag for it to be removed), or Reassign (to another Okta user). You will see the icons or icons and words depending on the screen resolution.

5. Click on the name of one of the applications to see information about the user and resource

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img29.png "image_tooltip")

This information is provided to help the reviewer in making their decision. Currently, it includes user details and resource details, but there are plans to include fine-grained access information (if available) and review history.

6. Select one user and click the Approve (tick) button

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img30.png "image_tooltip")

7. When prompted, enter a Justification and click the Submit button

8. Select one user and click the Revok (X) button

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img31.png "image_tooltip")

After each action, you will see a message displayed, and the item will disappear from the view (they can be found under the Closed tab). When all are actioned, you will get confirmation that you are done with the reviews.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img32.png "image_tooltip")

9. Now, you can return to Identity Governance > Access Certifications to end the campaign. The campaign can be completed manually once the review is done or automatically after the **Set duration** passes. 

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img33.png "image_tooltip")

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img34.png "image_tooltip")


# Test provisioning (mover flow)

1. Move your user to the new *Department* in the BambooHR tenant.

2. In the **People > Personal** tab, select your newly added user, and click **+ Add Entry** in the **Job Information** field.

3. In the **Department** field, select **Sales**, and make sure that the **Effective Date** is set for *Today*, click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/mover-bamboo.png "image_tooltip")

4. Open your Okta administration UI, navigate to **Applications > Applications**, and select the BambooHR app definition to verify user profile and check if it was deactivated in Okta.

5. In the **Import tab**, click **Import Now**, and confirm changes to your user by selecting them and clicking **Confirm Assignements**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/mover-updated.png "image_tooltip")

6. Navigate to **Directory > Groups** to check if your user was automatically assigned to the new Group and has access to the new set of Apps.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/mover-user.png "image_tooltip")

7. Open a new browser window that is not signed into Okta.

8.  Navigate to your Okta tenant. e.g. ***yourwiclabdomain*.okta.com**

9.  Authenticate as your test user: e.g.

    > ***Charlotte.Abbott@yourwiclabdomain.com***

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image043.png "image_tooltip")

10. You should see a new set of apps, that were assigned to the user based on the *Department* that they were moved into.
