
## Requests, Approvals, and Access Certifications

In this lab, you will navigate the pathways of application access requests, demonstrating the seamless experience for employees itching to get their hands on the tools they need. But there's a twist, approvals are in play! You'll witness the streamlined process of granting access post-approval, while also exploring the administrative side of things. Here, setting up approvals becomes a breeze, and configuring certification for periodic access reviews? Consider it done. Ready to experience the future of governed access?

### Configure Teams and Access Request Settings

#### Add the Okta admin to the IT team

1. In the Okta Admin Console select **Identity Governance** > **Access Requests**. This will open the Access Requests Admin Console in a new browser tab.
1. In the Access Requests Admin Console, select **Teams**.
1. Click the **IT** team.
1. Click **Add member**.
1. Enter your Okta Admin name and then select **You**.
1. Click **Add Users**.
    |||
     |:-----|:-----|
    |![Add team members to IT](images/011/oig_ar_settings_add_team_members_400.png "Add team members to IT")|

7. Verify that you are listed as a member of the **IT** team.

<!-- #### Update the Access Request Configuration for Okta

1. In the Access Requests Admin Console, select **Settings**.
1. Select the **Integrations** tab.
1. Under Access Request Configurations for Okta, click **Edit connection**.
1. Click **Update Connection.**
-->
#### Update Resources

Enable access to applications and groups to the IT team.

1. Select the **Resources** tab.
1. For **Applications**, click **Manage Access**.
1. Select the **IT** team, and then click **Save**.
1. Select **Okta Groups**, and then click **Manage Access**.
1. Toggle on the **IT** team, and then click **Save**.
    |||
     |:-----|:-----|
    |![Toggle on IT](images/011/oig_ar_teams_it_toggled_on_400.png "Toggle on IT")|

### Create a Request Type

A request type can consist of multiple steps including Questions, Tasks, Approvals, and Actions. This request type will consist of an Approval step and an conditional Action step.

1. In the Access Requests Admin Console, select **Access Requests**
1. Click **Create request type**.
1. Configure the request type as follows:

    |Request Type attribute|Value|
    |:-----|:-----|
    |Name|**Navan**|
    |Description |  **Corporate Travel App**|
    |Team |**IT**|
    |Audience|**Everyone at** your Okta tenant|'

1. Click **Continue**.
    |||
     |:-----|:-----|
    |![Navan Request Type](images/011/oig_ar_create_request_screen_1_400.png "Navan Request Type")|

#### Add an Approval step

1. To add an Approval step, select **Approval**, and then click **Add to request type**.
    |||
     |:-----|:-----|
    |![Approval](images/011/oig_ar_approval_page1_400.png "Navan Request Type")|

1. In the **Approval Details** panel, on the right, configure the Approval step:

    |Approval attribute |Value|
    |:-----|:-----|
    |Text|**Admin Approval**|
    |Make it a required task | *Enabled*|
    |Type| **Approval task**|
    |Assigned to |Select **A specific user...** and select **You**|
    |Due Date| *No due date*|'

    |||
     |:-----|:-----|
    ![Approval details](images/011/oig_ar_create_request_approval_details_400.png "Approval details")|

> **Tip:** Look at the bottom of the **Tasks & Actions** for additional step buttons.
>
#### Add an Action step

1. To add an Action step, click **Action**, and then select **Assign individual app to user**.
1. In the **Action Details** tab, on the right, configure the Action step:

    |Action attribute|Value|
    |:-----|:-----|
    |Text|**Assign to Navan**|
    |Make it a required task |  *Enabled*|
    |Type | **Assign individual app to user**|
    |Run automatically |Toggle to be **Enabled**|
    |Email address|**Requester email**|
    |Select application | **Navan** from the list of apps|
    |Run automatically | *Enabled*|'

1. Click **Edit Logic**. This will switch you from the Details tab to the Logic tab.
    |||
    |:-----|:-----|
    |![Logic tab](images/011/oig_ar_action_details_logic_tab%20400.png "Logic tab")|
1. Click **Always show this task**, and then select **Only show this task if**.
1. Click **Field or Task**.and then select **Admin Approval**
1. Select **is approved**.
1. Click **Publish**.
    |||
     |:-----|:-----|
    |![Logic Details](images/011/ar_navan_publish_700.png "Logic Details")|

8. Leave this browser session open as you will return back to it momentarily.

### As the New Employee, request access to an app

1. In the **Virtual Desktop**, open a new Chrome window.
1. Sign in to your Okta tenant as the New Employee.
1. In the End-User Dashboard, open the **Okta Access Requests** app.
1. In the App Catalog, locate **Navan**, and then click **Request access**.
1. Click **Submit new request**.
1. Notice that there 0/1 tasks are complete. The access request is waiting for Admin Approval.
    |||
     |:-----|:-----|
    |![Tasks complete](images/011/ar_awaiting_admin_approval_700.png "Tasks complete")|

7. Leave this browser session open as you will return back to it momentarily.

### As the Okta admin, approve the access request

1. Return to your Okta admin browser session
1. In the Access Requests Admin Console, select **Requests** > **Inbox**.
1. Click on the Navan app request from the new employee, and then click **Approve**.
    |||
     |:-----|:-----|
    |![Approve Request](images/011/ar_approve_navan_600.png "Approve Request")|

4. Optional. Select the **Activity** tab to verify that the app was assigned to the new employee.

### As the new employee, verify access to the app

1. Return back to the new employee browser session.
2. Reload the End-User Dashboard, and verify the new employee has access to Navan.

## Workflow Connections

 In this section of the lab, you'll set up two workflow connections and then import and configure a flowpack. When activated, this flow will automate the creation of access certification campaigns whenever an employee's title changes.

### Create an Okta Connection

1. In the Okta Admin Console select **Workflow** > **Workflows console**.

>**Note:** Your browser window now has an open tab open for the **Okta Admin Console** and another tab for the **Workflows Console**. Throughout this lab, you will be navigating between the two consoles, so pay close attention.

2. In the Workflows console, select **Connections**, and then click **New Connection**.
3. In the **New Connection** dialog search bar, enter **okta** and then click **Okta**.
4. Optional. Modify the default **Connection Nickname**.
5. Set **Domain** to the Okta tenant value found in the lab **Launch Panel**.

    |||
     |:-----|:-----|
     |![Okta Tenant](images/011/launch_okta_tenant_240.png "Okta Tenant")| |

Keep this page open. You'll need to switch to your Okta Admin Console to get the **Client ID** and **Client Secret** values needed for this Okta Connection and then return to the Workflows console to paste in the values.

#### Copy and paste the Client ID and Client Secret

1. In the Okta Admin Console, select **Applications** > **Applications**.
2. Select the **Okta Workflows OAuth** app, and then select the **Sign On** tab.
3. Copy the **Client ID**
4. Return to the **Workflows console** >  **New Connection** dialog, and then paste the **Client ID**.
5. Repeat the copy and paste steps for the **Client secret**.
6. Click **Create** to complete the Okta Connection.
    |||
     |:-----|:-----|
     |![Okta Connection](images/011//workflows_connection_okta_600.png "Okta Connection")|

## Leveraging Flowpacks

|||
   |:-----|:-----|
   |![Marc says...](images/011/marc_r74_100.png "Marc says...")|*Did you know that Okta Identity Governance, powered by Okta Workflows, lets you smoothly look up a user's manager or application owner during access certifications? It's technology bending to fit your business process, not the other way around – like having your digital cake and eating it too!*|

### Download the **Title Change** flowpack

1. [Download the lab flowpack **titleChanged.flow**](https://keithledgerwood.github.io/WICLab-guide/workflows/titleChanged.flow)

### Create a new Folder

1. In the Workflows console, select **Flows**.
2. In the **Folders** panel, create a new folder by clicking the **+** icon.
3. Set the **Folder name** to **Title Changed**.
4. Optional. Set a **Folder Description**.
5. Click **Save**.

### Import the Flow into the Folder

1. Click the **...** next to the **Title Changed** folder,  and then select **Import**
    |||
     |:-----|:-----|
    |![Import flowpack](images/011/workflows_folder_ellipsis_400.png "Import flowpack")|

2. Click **Choose file from computer**, choose the **titleChanged.flow** and then click **Open**.
You have successfully imported the Flow.
    |||
     |:-----|:-----|
    |![Imported flow](images/011/workflows_titlechanged_import_success_600.png "Imported flow")|

### Modify the imported Flow

There are a few modifications needed within the workflow. You will need to assign the Okta and API connections to the flow and your Okta admin account.

>**Tip:** To view a graphic of the all the cards in a flow, you can select the **Flow Chart** tab while in edit mode.
 ![flow chart](images/011/titlechanged_flowchart_access_240.png).
 Here's a sneak peak. You will be changing cards: **1, 3, 8 and 23**.
 ![flow chart detail](images/011/titlechanged_flowchart_700.png)

1. Click the **Title Changed** workflow to open it in edit mode.
1. In the **User Okta Profile Updated** card, click **Choose Connection**, and then click your Okta connection. This will cause the card to expand.
1. Set the contents of the first **Compose** card to your Okta tenant URL.
    |||
     |:-----|:-----|
    |![Set Okta Connection](images/011/titlechanged_okta_connection_and_compose_card_600.png "Set Okta Connection")|

1. Scroll to the right to locate the next  **Compose** card. It's the eighth card in the flow, and replace the existing login with your Okta admin login.
    |||
     |:-----|:-----|
    |![alt_text](images/011/titlechanged_compose_admin_600.png "600x144")|

1. Scroll to the right and locate the **API Connector Raw Request** card, and then click **Choose Connection**.
1. Set the **Connection** to your **API Connector**.
1. Click **Save**.

    > **Note:** When saving for the first time, select **Save all data that passes through the Flow?**, and then click **Save**.

1. Click **Flow is OFF** and select **Flow is OFF**. The result will be that the **Flow is ON** and **Saving data**.
    |||
     |:-----|:-----|
     |![flow is on](images/011/titlechanged_flow_is_on_240.png "flow is on")|

You now have the Flow correctly configured and running.

### In BambooHR, change the New Employee's title

Promote your employee from Director to Sr. Director.

1. In the BambooHR dashboard search for and select your new employee.
2. On the **Job** tab, for **Job Information** click  **Add Entry**.
3. In the **Add Job Information** dialog, set the **Job Title** to **Sr. Director of Marketing**, and then click **Save**.

### Import the Title Change into Okta

1. In the Okta Admin Console, select **Applications** > **Applications**.
2. Select the  **BambooHR** app, and then select the **Import** tab.
3. Click **Import Now**.
4. When the scan completes, confirm that one user was updated.

This event will trigger the imported **Title Changed** flow, which creates and launches a certification campaign.

## Access Certification

Access certification is built into the Okta platform. There is an administrative interface to create and manage campaigns and an end-user interface for participating in campaigns. Campaigns can be created via API and the UI of the admin platform.

### Verify the Access Certification Campaign was created

To verify that a certification campaign was created by the flowpack, you will need to perform the following actions as the Okta admin:

1. In the Okta Admin Console select **Identity Governance** > **Access Certifications**.
1. Verify that there is **Campaign** whose name starts with **Title Change:**.
1. Click on the **Title Change:** campaign to see an overview of the campaign.

The page provides an overview of the campaign, the progress of the campaign, and the items to be reviewed. An administrator can use this page to manage the execution of a campaign. They can see the progress and any items still outstanding. They can reassign one or more items. They can also prematurely end the campaign.

>**Note:** Please notify a lab assistant if there is no campaign listed.

### Participating in an Access Certification Campaign

For the purposes of this lab, we decided to assign the Okta tenant administrator ( You ) to be the reviewer of this particular campaign. Reviews are performed with the **Okta Access Certification** app on your End User Dashboard.

1. In the Okta Admin Console, click the *waffle* icon in the top right corner, and then select **My end user dashboard**.
1. In the Okta admin's **End User Dashboard**, launch the **Okta Access Certification Reviews** app.
2. Click on the **Title Change** access certification campaign to see an overview of the campaign.
1. You will see all applications assigned to this user.

    > For each item, you have three options as a reviewer: Approve (leave the access as is), Revoke (remove access or flag for it to be removed), or Reassign (to another Okta user). You will see the icons or icons and words depending on the screen resolution.

1. Click on the name of one of the applications to see information about the user and resource.
This information is provided to help the reviewer in making their decision. Currently, it includes user details and resource details, but there are plans to include fine-grained access information (if available) and review history.
1. Click **Approve**.
1. When prompted, enter a **Justification**,  and then click the **Submit**.
1. Review the rest of the applications until you get the message **You have completed all your reviews**.

### End the Campaign

The campaign can be completed manually once the review is done or automatically after the **Set duration** passes.

1. In the Okta Admin Console select **Identity Governance** > **Access Certifications**.
2. Click the **Title Change** campaign and verify that the **Progress** is **100%**.
3. To end the campaign, click **Actions**, and then select **End**.
4. Click **End Campaign**.

    ![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/007/img33.png "image_tooltip")

## Conclusion

In this lab, we've charted the exciting terrains of application access with a dash of approval spice! While employees are keen to dive into their toolkits, we've ensured that some access is granted with a nod of approval. And for our administrative maestros? Setting up those approvals was as easy as pie, and periodic access reviews? Piece of cake!
