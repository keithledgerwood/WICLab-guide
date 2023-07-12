# Lab Okta Identity Governance

Okta Identity Governance (OIG) is a unified IAM and governance solution that includes three products to help governance, risk and compliance teams simplify access fulfillment and entitlement tasks throughout the identity lifecycle:
-   Okta Lifecycle Management
-   Okta Workflows
-   Okta Access Governance

![Okta OIG](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-01_oig.png?raw=true)

**Okta Lifecycle Management** provides pre-built integrations between HR and IT systems, to automatically keep employee information and status in sync with the IT applications they use. As employees join, move, or leave the company, IT can automatically assign, upgrade, or revoke applications and access, to increase productivity, protect the organization from data loss, and eliminate orphaned accounts that increase the attack surface area.

**Okta Workflows** provides the extensibility and customization necessary to solve the complex identity governance requirements of your particular organization. Easily automate identity processes at scale, without writing a single line of code. Enable anyone at your company to create innovative solutions with Okta using if-this-then-that logic, Okta’s pre-built connector library, and the ability to connect to any publicly available API.

**Okta Access Governance** plays a central role in the solution, simplifying access management tasks so administrators can make sure the right people have access to the right resources when they need them. Access Governance includes three key features:

- **Access Request** simplifies and automates the process of requesting access to applications and resources. It meets users where they are by offering self-service capabilities tightly integrated with collaboration tools, delivering a streamlined, frictionless approach that automatically routes user requests to one or more reviewers for approval and auto-provisions the access.

- **Access Certification** campaigns offer a simple process for creating audit campaigns to periodically review user access to critical resources and approve or revoke access automatically. Those processes are important for making sure employees do not accumulate access, and only users who need a resource have access to it.

- **Governance Reports** help organizations meet audit and compliance requirements. Share a high-level overview of past certification campaigns, including their duration and the resources included—or add more detail, including the users involved and remediation status. Administrators can also provide an audit of who has access to what resources, who approved the access and how they got the access. Access governance data is stored for 3 years.

With these combined capabilities, OIG helps organizations improve their security posture, mitigate modern risks, and improve efficiency. Unlike traditional IGA products, which can require complex and custom integrations that are difficult to deploy and expensive to maintain, Okta’s unified approach brings together identity, access, and governance to holistically improve an organization’s security posture. For example, customers today can integrate Okta with existing HR systems and directories and manage who gets access to what resources. If Okta detects unusual activity, such as a high-risk login through Okta ThreatInsights or a lifecycle status change, you can trigger a certification campaign and immediately suspend access to a resource.



# Prepare your environment

Prior to working through the sections looking at the three capabilities, you will need to perform the following actions:

1. Create distribution lists in Google using Okta Workflows along with Okta OOTB Google Workspace Connector

    - Open Okta **Workflows Console** from Okta Admin dashboard

    - Go to the **Flows** tab from the top hand side

    - Create a folder named **OKTA-WIC-WORKSHOP-IGA-LAB**
  
   
      
![Create Folder](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-02_oig.png?raw=true)

2. Click on the three dots and **Import** the file **oktaWicWorkshopIgaLab.folder**

![Import](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-03_oig.jpg?raw=true)

3. Open the Flow **1_Create Okta Group**, choose the **Okta** Connection on the **Create Group** Card and activate the flow
   
![Flow](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-04_oig.jpg?raw=true)

4. Activate the mail flow : **0_Read DLs** and run the flow to import the Distribution Lists in Okta as groups
   
![Activate](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-05_oig.jpg?raw=true)

5. Navigate to the Okta Admin Console, go to **Groups** under **Directory** and check that the groups prefixed by **“DL_”** are created
    
![PushGroups](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-06_oig.jpg?raw=true)

6. Use Google Workspace Connector to push the groups as Distribution Lists to Google. Open Google Workspace integration under **Applications -> Applications**
    - Go to **Push Groups** tab and create a group push policy rule
      
![Connector](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-07_oig.jpg?raw=true)

7. Create a rule to push all the groups with a name starting by **“DL_”**

![pushGroupsRule](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-08_oig.jpg?raw=true)

8. Check the creation of Distribution List in Google by navigating to Google Admin console, go to **Groups** under **Directory**
    
![Groups](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-09_oig.jpg?raw=true)


# Access Requests

In this lab you will learn how to create an **Access Request**
Okta Access Requests automates the process of requesting access to applications and resources. Expanding on Okta's existing self-service offerings, Access Requests delivers a simplified and frictionless approach that automatically routes user requests to one or more approvers for action.

1. Allow all users in Okta to request access from the **Okta Access Requests** application. From the Okta Admin Console, go to Applications -> Applications and select the **Okta Access Requests**

![AccessRequestApp](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-10_oig.jpg?raw=true)

2. Go to the **Assignments** tab and assign the group **Everyone** to the application, it will allow all users in Okta to access and submit requests

![AppAssignments](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-11_oig.jpg?raw=true)

3. Now we will explore the vanilla Access Requests module. From within the Admin console go to **Identity Governance > Access Requests** (it will open a new browser tab)
4. The default landing page is the **Requests > Inbox** view, where any requests awaiting action by this admin are displayed. It is empty.
5. Go to **Teams** menu item :  Teams are an Access Requests grouping mechanism. Workflows must be assigned to a Team, and Teams can be used to scope who can run a workflow or participate in it. There is a default team created called **IT**. For the sake of the exercise, we will create a team called **Request Admin**
6. Click the **Add Team** button
7. Select the team icon and color (optional), give it a **Name** and **Description** (optional)
8. Add team **Members** (type part of their name and select from the result list)

![AppAssignments](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-12_oig.jpg?raw=true)

9. Go to the **Settings** menu item. There are currently four integrations available – Slack, Jira, servicenow and Okta. The Okta integration is partially configured, and the others unconfigured. We will configure Slack in the next section.
10. Click on the **Resources**  tab towards the top of the page. 
Configuration items in Access Requests are lists of objects that can be used in flows. The default lists that are automatically sync’d from Okta are all Applications and all Groups
11. Click on the **icon** beside the **Applications** configuration item and click on sync **Update now** button

![AppAssignments](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-13_oig.jpg?raw=true)

12. On the **Application** configuration item, click on **Manage Access** button

![AppAssignments](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-14_oig.jpg?raw=true)

13. It opens a popup, select both options **IT** and **Request Admins**: these two teams can use all the applications when constructing access requests

![AppAssignments](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-15_oig.jpg?raw=true)

14. Do the same for the **Groups** configuration item
15. Go to the **Configuration lists** tab and click on **Create new list** named **List of Google DLs** of type **Resource list** of **Okta Groups**, allowing the two teams **IT** and **Request Admins** to use the lists. Add the following items in the list


| Groups      | 
| :---        | 
| DL_UK_LONDON     | 
| DL_FRANCE_PARIS  |
| DL_GERMANY_BERLIN   |
| DL_SPAIN_MADRID   |
| DL_NETHERLANDS_AMSTERDAM   |
| DL_PROJECT_ERP   |
| DL_PROJECT_ERP_SAP   |
| DL_PROJECT_ERP_JDE   |
| DL_PROJECT_CRM   |
| DL_PROJECT_CRM_SLAESFORCE   |

![AppAssignments](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-16_oig.jpg?raw=true)

16. Follow the same steps and create a second list named **List of Risky Google DLs** of type **Resource list** of **Okta Groups**, allowing the two teams **IT** and **Request Admins** to use the lists. Add the following items in the list

| Groups      | 
| :---        | 
| DL_PROJECT_ERP     | 
| DL_PROJECT_ERP_SAP  |
| DL_PROJECT_ERP_JDE   |
| DL_PROJECT_CRM   |
| DL_PROJECT_CRM_SLAESFORCE   |

17. Test and add the team
