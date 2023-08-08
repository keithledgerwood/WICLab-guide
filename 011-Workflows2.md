**Before you begin** we need to add the Okta Connection.

1.  In the Okta Admin panel, go to Applications -\> Applications and
   search for "**Workflows**".

2.  Open the "**Okta Workflows OAuth**" app and go to the Sign On tab.

3.  Copy and save the **Client ID** and **Client Secret**.

4.  In the Admin Panel go to Workflow -\> Workflows Console.

5.  Open up the Connections tab and click on **+New Connection**.

6.  Search for Okta, click on it and insert the required details:

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_2/image7-25.png "image_tooltip")

7.  Lastly click **Create**

Now that we have the **Connection to our Okta instance** we can add
the **template**.

1.  At the top click on Templates and search for "**Assign Group
    Memberships Temporarily Based on Time**"

2.  Click on it and then on **Add Template** and again **Add Template**\
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_2/image2-27.png "image_tooltip") ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_2/image8-28.png "image_tooltip")

3.  Open up the **Determine if user added to temporary group** and the
    **SUB - Remove User from Group** flows and make sure you **choose
    your Okta Connection** and Save the workflows.\
   ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_2/image3-30.png "image_tooltip")

4.  Create a group in Okta called "**Temp Group**"

5.  Go back to your flows and go to the **Tables** tab and open the
    **Temporary Groups** table\
   ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_2/image5-31.png "image_tooltip")

6.  Add the **group name** and the **duration in minutes** and click
    **Create**. The duration will reflect how long a user should stay
    in that group. For testing purposes we'll put in <ins>**3
    minutes</ins>**.\
  ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_2/image9-33.png "image_tooltip")

7.  Now go back to your **Flows**, **turn ON** the <ins>App
   Event</ins> and <ins>Helper</ins> flows and open up the
    <ins>Schedule</ins> one.\
   ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_2/image6-35.png "image_tooltip")

8.  Once you\'re in, click on the clock icon on the bottom right hand
    corner of the **Scheduled Flow** event. Now schedule the flow to
    run every **5 minutes** (lowest it can go). **Save** it and turn
    the flow **ON**.\
   ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_2/image1-37.png "image_tooltip")    ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_2/image4-39.png "image_tooltip")

9.  Once all 3 flows are on, go back to the **Okta Admin Dashboard** and
    assign a user (create one if needed) to the **Temp Group**.

10. Now to check the workflow on how it ran, open up the **Determine if
    user added to temporary group** flow and go to **Flow History.**

11. You can also check the **Users Added to Temporary Groups** table to
    see the user that has been added.

Time to wait 5 minutes. **Coffee Break!**

Once the 5 minutes are up, open up the **Scan users for removal**
followed by the **SUB - Remove User from Group** and check the Flow
history to see the flow in action.

Also, you can re-check the **Users Added to Temporary Groups** table to
see that the user was removed.
