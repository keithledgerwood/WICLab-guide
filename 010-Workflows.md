**\
\
Before you begin** we need to add you to the Workflows app and add the
Email Connection (Gmail or Office 365 Mail).**\
**

1.  In the Okta Admin panel, go to Applications -\> Applications and
    search for "**Workflows**" and make sure [you are assigned to both
    applications]{.underline}.**\
    **![](media/image30.png){width="3.75in"
    height="1.3020833333333333in"}**\
    **

2.  In the Admin Panel go to Workflow -\> Workflows Console.

3.  Open up the Connections tab and click on **+New Connection**.

4.  Search for [Gmail or Office 365 Mail]{.underline}, click on it and
    then again on **Create**.

5.  A window will open for you to sign in with your Email Account\
    \
    **Note:** You can use your personal or company email. This is a
    connection directly to your email account to be used by Okta
    Workflows to take actions on its behalf, but we're only using it to
    send emails. (You can delete the connection when you're done)\
    ![](media/image13.png){width="4.536458880139983in"
    height="3.9066163604549433in"}

6.  Once you log in and give it access, you're done!

**The Task! - Create an email alert for when a user has been assigned
the Super Admin role.**

1.  In the Workflows Console, click on the plus "+" next to
    **Folders**.\
    ![](media/image3.png){width="4.651042213473316in"
    height="0.9302088801399825in"}

2.  Give your folder a name, we went with "**Super Admin Alert**".

3.  Go into your folder and click **+New Flow**\
    ![](media/image23.png){width="3.0104166666666665in"
    height="1.9791666666666667in"}

4.  Once the new flow Opens, click Save, give the flow a name (we went
    with **SuperAdminEvent**). Also, check the box for "**Save all data
    that passes through the Flow?**", this is to remember the flow
    history for debugging purposes.

5.  Click **Save\
    **![](media/image27.png){width="3.7031255468066493in"
    height="3.9442136920384954in"}

Now it's time to add an event trigger, and for this we'll use an **API
Endpoint**.

1.  In your new flow, click **Add event**\
    ![](media/image29.png){width="3.526042213473316in"
    height="2.6661942257217848in"}

2.  Now click on **API Endpoint**, choose Expose as Webhook, copy the
    Invoke URL and Close the pop-up.\
    ![](media/image12.png){width="4.171875546806649in"
    height="4.693359580052493in"}\
    \
    \
    \
    \
    \
    \
    \
    **NOTE:** If you want to find the endpoint again, you **\</\>**
    symbol at the bottom right corner of the **API Endpoint** card.\
    ![](media/image18.png){width="2.4791666666666665in"
    height="5.302083333333333in"}

Now that we have the **API Endpoint**, we'll need to create an **event
hook** that for each time a user or a group receives Super Admin
permissions it will send the information to our API Endpoint.

1.  In the Okta Admin Panel, go to Workflow -\> Event Hooks and click on
    **Create Event Hook**.

2.  Give it a **Name**, paste in the **API Endpoint** where it says URL.
    Notice that since it's a workflow API URL, we don't need to verify
    the endpoint ownership.

3.  Under Subscribe to events pick "**Group's admin privilege granted**"
    and "**A User's admin privileges changed**".

4.  Click Save & Continue**\
    **![](media/image25.png){width="6.5in" height="6.805555555555555in"}

We can take a look at the event hook information that will be sent by
clicking **Preview** under Actions and selecting the event type.

![](media/image22.png){width="6.5in" height="0.6111111111111112in"}

After you select the event type you'll see the output in a JSON format.
This is how the information will be sent to our flow.

There is a lot of information in that JSON and we'll need to filter out
what we need:

 \"data\": {

\"events\": \[

{

> \"**privilegeGranted**\": \"Super administrator\"
>
> \"actor\": {
>
> \"**alternateId**\": \"actor.admin@isoft-lab.co.il\"
>
> }
>
> "target\": \[

{

\"**type**\": \"User\",

\"**alternateId**\": \"new.admin@isoft-lab.co.il\",

\"**displayName**\": \"new admin\"

}

> \]
>
> }

\]

}



In order to get the information we need we'll have to create the path to
the attributes:

E.g.

> For **privilegeGranted** it will be:
> **data.events.0.privilegeGranted**
>
> For the target **type** it will be: **data.events.0.target.0.type**

**\
NOTE:** When you go from object to object, you use "." like data.events.
But in a list "\[" you have to specify the position of the object in the
list. For us it will be 0 (zero) since there is only 1 object in the
list (lists start at zero). If we had 2 objects, we'd need to do
**data.events.0.privilegeGranted** and
**data.events.1.privilegeGranted** to get both privilegeGranted objects.

Now that we've set our **Event Hook** to send the information to our
**API Endpoint** and we have our attributes, we'll proceed with
finishing our flow.

1.  Back in our flow, click on "Add function" and select from the
    **Object** category **Get Multiple**.\
    ![](media/image14.png){width="1.859375546806649in"
    height="3.095495406824147in"}![](media/image1.png){width="2.5729166666666665in"
    height="3.0833333333333335in"}

2.  Now drag the **body** from the API Endpoint card to the Get Multiple
    card\
    ![](media/image28.png){width="3.3281255468066493in"
    height="3.4419816272965877in"}

3.  In the Get Multiple card, click on the bottom of the card to add our
    attribute paths(list below).\
    ![](media/image10.png){width="1.8802088801399826in"
    height="2.2390857392825896in"}\
    \
    **NOTE:** Once you paste a path press Enter to confirm it.

-   **data.events.0.privilegeGranted -\> What privilege was granted**

-   **data.events.0.actor.alternateId -\> Who gave that privilege**

-   **data.events.0.target.0.displayName -\> The display name of the
    > target (who got the privileges)**

-   **data.events.0.target.0.type -\> The target type (user or group)**

-   **data.events.0.target.0.alternateId -\> The target's alternate id
    > (groups don't have one)\
    > **

You can always rename a field that you have put in place and you can add
a description for it as well. **\
**![](media/image11.png){width="1.9427088801399826in"
height="4.085134514435696in"}![](media/image21.png){width="2.1912893700787404in"
height="4.091791338582677in"}![](media/image15.png){width="2.057292213473316in"
height="2.3672944006999126in"}

**Once you're finished adding them it should look like this:**

> ![](media/image2.png){width="2.1302088801399823in"
> height="3.7058584864391952in"}

To make sure we know what's what, we\'ll assign a different name for the
value in each path.

1.  Click Add function again and from the **Flow Control** category pick
    **Assign**

2.  Click inside and type a name you can work with (image below). Then
    drag [from the Get Multiple card to the Assign card]{.underline} the
    corresponding paths.

![](media/image4.png){width="2.5208333333333335in"
height="3.0729166666666665in"}

![](media/image24.png){width="2.2266852580927385in"
height="5.934375546806649in"}![](media/image26.png){width="4.504408355205599in"
height="5.913542213473316in"}

Now we'll add a condition to only continue if the privilege is **equal
to** Super administrator.

1.  Click Add function, and from the **Branching** category choose
    **Continue If.**

2.  Drag the **Privilege Granted** from the Assign card to the **value
    a** of the Continue If card.

3.  For comparison select **equal to**

4.  For **value b** type in **Super administrator**

5.  For the otherwise message, type **Not a Super administrator** (since
    we only want the super admin privilege).

> ![](media/image8.png){width="3.7864588801399823in"
> height="5.0259372265966755in"}

What's left is to compose a message, set the Distribution List of emails
that should receive this message and send it. But we'd like to have a
dynamic message based on if the target is a group or a user. So let's
see how we do that:

1.  Click on Add function and from the **Branching** category choose
    **Lookup**

2.  In the **Value** section drag and drop the **Type** field from the
    [Assign card]{.underline}

3.  Next we'll set the [Value and Result.]{.underline}

4.  When Value is **User** then the result is **user**

5.  When Value is **UserGroup** then the result is **group**

6.  This time, the **Otherwise** option can be left blank since it can
    > only be the above 2 options

**\
**![](media/image17.png){width="7.0in" height="4.833333333333333in"}

Next we'll compose the Body of our email:

1.  Click on Add function and from the **Text** category select
    **Compose**

2.  Now the message will be: **Super administrator privileges have been
    granted to the () by .**

3.  And in between the text we'll drag and drop the required attributes:

> ![](media/image19.png){width="4.604166666666667in"
> height="3.0208333333333335in"}

![](media/image20.png){width="7.442708880139983in"
height="3.432717629046369in"}

Now for the mailing list:

1.  Click on Add function and from the **List** category select
    > **Construct**

2.  Click inside the card and add the address/es you'd like to send the
    > email to:

> ![](media/image7.png){width="2.5104166666666665in"
> height="3.6041666666666665in"}

Now for sending our email:

1.  Click **Add app action** -\> **Gmail** -\> **Send Email**

2.  Pick the connection and Save

3.  Add a Subject to the Email\
    E.g. **DoNotReply - Super administrator privileges have been
    granted!**

4.  Drag the constructed mailing list in the **To** field

5.  Drag the composed body to the **Body** field

![](media/image5.png){width="7.328125546806649in"
height="5.070800524934383in"}

**Save your flow and turn it on!**

![](media/image6.png){width="5.489583333333333in" height="0.5625in"}

**To test:**

1.  Go to the **Okta Admin Panel -\> Directory -\> Groups**

2.  Click on **+Add Group**

3.  Create a group called **SuperAdmins**

4.  Go to **Security -\> Administrators**

5.  Click on **Admins -\> Add Administrator**

6.  Type in the name of the group in the **Select admin** box

7.  Under **Role** select [Super Administrator]{.underline} and click
    **Save Changes**

![](media/image16.png){width="7.0in" height="3.7916666666666665in"}

That's it, you should have gotten an **email!**

**If you want to see the flow in action, you can go back to your flow
and on the top left hand corner click Flow History.**

> ![](media/image9.png){width="2.9479166666666665in"
> height="0.8020833333333334in"}
