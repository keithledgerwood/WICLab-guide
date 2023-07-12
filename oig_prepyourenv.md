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
8. 
![pushGroupsRule](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-08_oig.jpg?raw=true)

9. Check the creation of Distribution List in Google by navigating to Google Admin console, go to **Groups** under **Directory**
    
![Groups](https://github.com/MarcoBlaesing/LabGuide/blob/main/images/06-09_oig.jpg?raw=true)

