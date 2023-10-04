## Identity Governance - Introduction

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
- Governance Reports help organizations meet audit and compliance requirements. Share a high-level overview of past certification campaigns, including their duration and the resources included, or add more detail, including the users involved and remediation status. Administrators can also provide an audit of who has access to what resources, who approved the access, and how they got the access. Access governance data is stored for three years.

With these combined capabilities, OIG helps organizations improve their security posture, mitigate modern risks, and improve efficiency. Unlike traditional IGA products, which can require complex and custom integrations that are difficult to deploy and expensive to maintain, Okta's unified approach brings together identity, access, and governance to improve an organization's security posture holistically. For example, customers today can integrate Okta with existing HR systems and directories and manage who gets access to what resources. If Okta detects unusual activity, such as a high-risk login through Okta ThreatInsights or a lifecycle status change, you can trigger a certification campaign and immediately suspend access to a resource.

## Lab description

In this section of the lab, we will explore the following capabilities:
Access Requests. Once configured, it can be used to grant access.
Access Certifications for running Access Review Campaigns.
Workflows to trigger actions based on specific events like the change of the job title of one of the employees
This document section will use a pre-built flow and two connections with the Okta tenant.
This document section will explore the unconfigured Access Requests, walk through standard configuration, and then create and run a simple approval flow.

## Okta Access Requests

### Assign Access Request App to Everyone

1. In the Admin Console select **Applications** > **Applications**
2. Select the **Okta Access Requests** app.
3. Select the **Assignments** tab.
4. Click **Assign** and then select **Assign to Groups**.
5. Find for the **Everyone** group, and then click **Assign**.
6. Click **Done**.

### Configure Access Request Settings

1. In the Okta Admin Console select **Identity Governance** > **Access Requests**. This will open the Access Requests Admin Console in a new browser tab.
2. In the Access Requests Admin Console, select **Teams** > **All**.
3. Click the **IT** team.
4. Click **Add Member**.
5. Enter your name or email and then select **You**.
6. Click **Add Users**.
7. Verify that you are listed as a member of the IT team.
8. In the Access Requests Admin Console, select **Settings**.
9. Select the **Integrations** tab.
10. Under Access Request Configurations for Okta, click **Edit connection**.
11. Click **Update Connection.**
12. Select the **Resources** tab.
13. For both Applications and Okta Groups, click **Manage Access** and select the **IT** team.

### Create a Request Type

A request type can consist of multiple steps including Questions, Tasks, Approvals, and Actions. This request type will consist of an Approval step and an conditional Action step.

1. In the Access Requests Admin Console, select **Access Requests**
2. Click **Create request type**.
3. Configure the request type as follows:

|Request Type attribute|Value|
|:-----|:-----|
|Name|**Navan**|
|Description |  **Corporate Travel App**|
|Team |**IT**|
|Audience|**Everyone at** your demo org|'

4. Click **Continue**.
5. To add an **Approval** step, click **Add to request type**.
6. In the Approval panel, configure the approval as follows:

|Approval attribute |Value|
|:-----|:-----|
|Text|**Admin Approval**|
|Make it a required task |  **Enabled**|
|Type| **Approval task**|
|Assigned to |Select **A specific user...** and click **You**|'

7. To add an Action step, click **Action**, and then select **Assign individual app to user**.
8. In the **Action** panel, configure the action as follows:

|Action attribute|Value|
|:-----|:-----|
|Text|**Assign to Navan**|
|Make it a required task |  **Enabled**|
|Type | **Assign individual app to user**|
|Run automatically |**Enabled**|
|Email address|**Requester email**|
|Select application | **Navan**|
|Run automatically | **Enabled**|'

9. Click **Edit Logic**.
10. Click **Always show this task**, and then select **Only show this task if**.
11. Click **Field or Task**.and then select **Admin Approval**
12. Select **is approved**.
13. Click **Publish**.
14. Leave this browser session open as you will return back to it momentarily.

### As the new employee, request access to an app

1. Open a new Chrome window using the Guest profile
2. Sign in to your Okta org as the New Employee.
3. In the End-User Dashboard, open the **Okta Access Requests** app.
5. In the App Catalog, locate **Navan**, and click **Request access**.
6. Preview the request, and click **Submit new request**.
7. Leave this browser session open as you will return back to it momentarily.

### As the Okta admin, approve the access request

1. Return to your Okta admin browser session
2. In the Access Requests Admin Console, select **Requests** > **Inbox**.
3. Click on the Navan app request from the new employee, and then click **Approve**.
4. Select the **Activity** tab to verify that the app was assigned to the new employee.

### As the new employee, verify access to the app

1. Return back to the new employee browser session.
2. Reload the End-User Dashboard, and verify the new employee has access to Navan.

# Workflow
>
>**JZ** This section is still "Under Construction" \
I think the flow should be as follows: \
From Okta Admin Console (OAC) launch the Workflow Console (WC)
then in WC (Connections) new Okta connection
then in OAC: open Okta Workflows OAuth app & copy client id & secret
then in WC: paste into Okta connection (back and forth between browser tabs)
then in WC (Connections) : new API Connector
then in OAC: generate API token and copy
then in WC (Connections): paste API token into API connection
then in WC (flows): import flowpack, add tenant and superadmin value into cards,

## Workflow Setup

### Workflow Connections

Now, you must configure the following Okta connectors in your Okta Tenant with Workflow enabled.

Different components within Okta have other API endpoints and connectors. In this section, we will build 2 separate connections, one to access the **Universal Directory** and the second to push the configurations to the **Identity Governance**.

#### Create an Okta Connection

1. Open Okta Admin Console and browse to **Applications** > **Applications** and search for **Okta Workflows OAuth**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img9.png "image_tooltip")

2. in **Okta Workflows OAuth** navigate to the **Sign On** Tab

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img10.png "image_tooltip")

3. Copy and note down the **Client ID** and **Client secret** for later use in this section.

4. Open Okta Workflows by navigating to Okta Admin Console > **Workflow** > **Workflows Console**. This will open the Worflows Console in a new browser tab.

5. On the Workflows Console page, Click **CONNECTIONS** in the top navigation pan and create a connection by clicking the **new connection** button

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img8.png "image_tooltip")

6. Enter **Okta** in the search bar, and choose **Okta** from the results

7. Enter the **Domain** of your Okta tenant

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img11.png "image_tooltip")

 > The domain should be provided without **https://** or **-admin**.for example, if you copy the following domain from the URL bar '<https://atko-admin.okta.com>,' then you should enter 'atko.okta.com' as the domain.

8. Return to the Okta Admin Console browser tab and copy the Paste the **Client ID** and **Client secret** into the Okta Workflows Connection in the other browser tab.

9. Click on **Create**

#### Create an API Connection

1. In the Workflows Console , select **CONNECTIONS**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img5.png "image_tooltip")

3. Create a new connection by clicking the **NEW CONNECTION** button and selecting **API Connector** as a connection type.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img6.png "image_tooltip")

4. Enter **Okta API - Token-based Auth** as a connection name and **Custom** as the Auth Type

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img7.png "image_tooltip")

5. Enter **Authorization** for the Header Name field and  **SSWS** + the token generated in the Okta Admin console into the Value field

#### Create API Token

For the workflows in the Okta Workflow Pack to work, you will first need to create a token to connect Okta APIs for that :

1. Open Okta Admin Console and browse to **Security** > **API**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img1.png "image_tooltip")

2. Find the menu in the content pane and click **TOKENS**

3. Create a token by giving it a name and clicking **CREATE TOKEN**

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/image2.png "image_tooltip")

4. Copy the token value and store as it will be the only time that you will be able to view it

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img3.png "image_tooltip")

The two connections have been created, and the Okta Workflow is ready to import.

## Configuring the Flow

### Importing the Flow

1. Download the lab flow "titleChanged.flow."

2. On the Workflows Console page, Click **Flows** in the top navigation pan

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img12.png "image_tooltip")

3. Create a new folder by clicking the **+** icon and name folder “Title Change”

4. Click on the **...** next to the newly created folder and select Import

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img13.png "image_tooltip")

5. Click **Choose file from computer**,or drag and drop the downloaded flow pack, to complete the import.

You have successfully imported the Flow.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img14.png "image_tooltip")

### Modify the imported Flow

There are a few modifications needed within the Workflow.

1. Click on the Workflow to update the existing cards

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img15.png "image_tooltip")

2. Update the first **Compose** card to contain your specific okta tenant name.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img16.png "image_tooltip")

3. Click **Save**

    > **Note:** When saving for the first time, select **Save all data that passes through the Flow?**, and then click **Save**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img17.png "image_tooltip")

4. Click the **Flow is Off** button and click the Flow is Off to turn on the Flow

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img18.png "image_tooltip")

You now have the Flow correctly configured and running.

### Stage a user to trigger the Workflow

In order to trigger this Flow, an action we're listening to should occur. In this case, an existing user that has a manager will have their title updated.

1. Assign the user a manager, navigate to **Directory** > **People**  and select your test user.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img19.png "image_tooltip")

2. Click on **Profile** then **Edit** and Scroll all the way down to find the **managerID** field, and update that with your email

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img20.png "image_tooltip")

3. In a separate browser tab, navigate to your **BambooHR** instance, Find the user and add a new **Job Entry**.

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

> **Note:** This app is tied to a group where membership is dynamically managed within Okta. If an Okta user is flagged as a reviewer in any active campaign, they will be in the group and see the application on the dashboard.

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
