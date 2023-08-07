> **Before you begin** we need to add the Okta Connection.**\
> **

1.  In the Okta Admin panel, go to Applications -\> Applications and
    > search for "**Workflows**".

2.  Open the "**Okta Workflows OAuth**" app and go to the Sign On tab.

3.  Copy and save the **Client ID** and **Client Secret**.

4.  In the Admin Panel go to Workflow -\> Workflows Console.

5.  Open up the Connections tab and click on **+New Connection**.

6.  Search for Okta, click on it and insert the required details:

> ![](media/image7.png){width="5.760416666666667in"
> height="4.145833333333333in"}

7.  Lastly click **Create**

> Now that we have the **Connection to our Okta instance** we can add
> the **template**.

1.  At the top click on Templates and search for "**Assign Group
    > Memberships Temporarily Based on Time**"

2.  Click on it and then on **Add Template** and again **Add Template**\
    > ![](media/image2.png){width="2.346874453193351in"
    > height="1.9942924321959754in"}![](media/image8.png){width="2.659374453193351in"
    > height="1.9839785651793527in"}

3.  Open up the **Determine if user added to temporary group** and the
    > **SUB - Remove User from Group** flows and make sure you **choose
    > your Okta Connection** and Save the workflows.\
    > **\
    > **![](media/image3.png){width="2.3333333333333335in"
    > height="0.6875in"}**\
    > **

4.  Create a group in Okta called "**Temp Group**"

5.  Go back to your flows and go to the **Tables** tab and open the
    > **Temporary Groups** table\
    > \
    > ![](media/image5.png){width="5.90937554680665in"
    > height="2.8941972878390203in"}

6.  Add the **group name** and the **duration in minutes** and click
    > **Create**. The duration will reflect how long a user should stay
    > in that group. For testing purposes we'll put in **[3
    > minutes]{.underline}**.\
    > \
    > ![](media/image9.png){width="6.34375in"
    > height="1.6770833333333333in"}

7.  Now go back to your **Flows**, **turn ON** the [App
    > Event]{.underline} and [Helper]{.underline} flows and open up the
    > [Schedule]{.underline} one.\
    > \
    > ![](media/image6.png){width="4.836458880139983in"
    > height="3.0406025809273842in"}

8.  Once you\'re in, click on the clock icon on the bottom right hand
    > corner of the **Scheduled Flow** event. Now schedule the flow to
    > run every **5 minutes** (lowest it can go). **Save** it and turn
    > the flow **ON**.\
    > \
    > ![](media/image1.png){width="2.5416666666666665in"
    > height="3.53125in"}![](media/image4.png){width="3.742707786526684in"
    > height="3.5218996062992125in"}

9.  Once all 3 flows are on, go back to the **Okta Admin Dashboard** and
    > assign a user (create one if needed) to the **Temp Group**.

10. Now to check the workflow on how it ran, open up the **Determine if
    > user added to temporary group** flow and go to **Flow History.**

11. You can also check the **Users Added to Temporary Groups** table to
    > see the user that has been added.

Time to wait 5 minutes. **Coffee Break!**

Once the 5 minutes are up, open up the **Scan users for removal**
followed by the **SUB - Remove User from Group** and check the Flow
history to see the flow in action.

Also, you can re-check the **Users Added to Temporary Groups** table to
see that the user was removed.
