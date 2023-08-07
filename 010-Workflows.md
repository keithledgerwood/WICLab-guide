**\
\
Before you begin** we need to add you to the Workflows app and add the
Email Connection (Gmail or Office 365 Mail).



1.  In the Okta Admin panel, go to Applications -\> Applications and
    search for "**Workflows**" and make sure [you are assigned to both
    applications]{.underline}.**\
  ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image30-25.png "image_tooltip")

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
     ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image13-27.png "image_tooltip")

7.  Once you log in and give it access, you're done!

**The Task! - Create an email alert for when a user has been assigned
the Super Admin role.**

1.  In the Workflows Console, click on the plus "+" next to
    **Folders**.\
 ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image3-29.png "image_tooltip")

2.  Give your folder a name, we went with "**Super Admin Alert**".

3.  Go into your folder and click **+New Flow**\
 ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image23-31.png "image_tooltip")

4.  Once the new flow Opens, click Save, give the flow a name (we went
    with **SuperAdminEvent**). Also, check the box for "**Save all data
    that passes through the Flow?**", this is to remember the flow
    history for debugging purposes.

5.  Click **Save**\
 ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image27-33.png "image_tooltip")


Now it's time to add an event trigger, and for this we'll use an **API
Endpoint**.

1.  In your new flow, click **Add event**\
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image29-35.png "image_tooltip")

2.  Now click on **API Endpoint**, choose Expose as Webhook, copy the
    Invoke URL and Close the pop-up.\
 ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image12-37.png "image_tooltip")
    \
    \
    \
    \
    \
    \
    \
    **NOTE:** If you want to find the endpoint again, you **\</\>**
    symbol at the bottom right corner of the **API Endpoint** card.\
 ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image18-39.png "image_tooltip")
    \

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
 ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image25-41.png "image_tooltip")
    \

We can take a look at the event hook information that will be sent by
clicking **Preview** under Actions and selecting the event type.

 ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image22-43.png "image_tooltip")

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
   ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image14-45.png "image_tooltip")   ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image1-47.png "image_tooltip")

2.  Now drag the **body** from the API Endpoint card to the Get Multiple
    card\
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image28-49.png "image_tooltip")

3.  In the Get Multiple card, click on the bottom of the card to add our
    attribute paths(list below).\
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image10-51.png "image_tooltip")
    \
    **NOTE:** Once you paste a path press Enter to confirm it.

-   **data.events.0.privilegeGranted -\> What privilege was granted**

-   **data.events.0.actor.alternateId -\> Who gave that privilege**

-   **data.events.0.target.0.displayName -\> The display name of the
  target (who got the privileges)**

-   **data.events.0.target.0.type -\> The target type (user or group)**

-   **data.events.0.target.0.alternateId -\> The target's alternate id
  (groups don't have one)**

You can always rename a field that you have put in place and you can add
a description for it as well. **\
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image11-53.png "image_tooltip") ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image21-55.png "image_tooltip") ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image15-57.png "image_tooltip")

**Once you're finished adding them it should look like this:**

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image2-59.png "image_tooltip")

To make sure we know what's what, we\'ll assign a different name for the
value in each path.

1.  Click Add function again and from the **Flow Control** category pick
    **Assign**

2.  Click inside and type a name you can work with (image below). Then
    drag [from the Get Multiple card to the Assign card]{.underline} the
    corresponding paths.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image4-61.png "image_tooltip")

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image24-63.png "image_tooltip") ![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image26-65.png "image_tooltip")

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

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image8-67.png "image_tooltip")

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
![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image17-69.png "image_tooltip")

Next we'll compose the Body of our email:

1.  Click on Add function and from the **Text** category select
    **Compose**

2.  Now the message will be: **Super administrator privileges have been
    granted to the () by .**

3.  And in between the text we'll drag and drop the required attributes:

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image19-71.png "image_tooltip")

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image20-73.png "image_tooltip")

Now for the mailing list:

1.  Click on Add function and from the **List** category select
    > **Construct**

2.  Click inside the card and add the address/es you'd like to send the
    > email to:

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image7-75.png "image_tooltip")

Now for sending our email:

1.  Click **Add app action** -\> **Gmail** -\> **Send Email**

2.  Pick the connection and Save

3.  Add a Subject to the Email\
    E.g. **DoNotReply - Super administrator privileges have been
    granted!**

4.  Drag the constructed mailing list in the **To** field

5.  Drag the composed body to the **Body** field

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image5-77.png "image_tooltip")

**Save your flow and turn it on!**

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image6-79.png "image_tooltip")

**To test:**

1.  Go to the **Okta Admin Panel -\> Directory -\> Groups**

2.  Click on **+Add Group**

3.  Create a group called **SuperAdmins**

4.  Go to **Security -\> Administrators**

5.  Click on **Admins -\> Add Administrator**

6.  Type in the name of the group in the **Select admin** box

7.  Under **Role** select [Super Administrator]{.underline} and click
    **Save Changes**

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image16-81.png "image_tooltip")

That's it, you should have gotten an **email!**

**If you want to see the flow in action, you can go back to your flow
and on the top left hand corner click Flow History.**

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/Workflows_1/image9-83.png "image_tooltip")
