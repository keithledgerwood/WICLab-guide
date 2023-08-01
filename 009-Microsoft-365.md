
This guide provides instructions for integrating Okta with Microsoft
Office 365 so that the following use cases can be demonstrated:

-   Single Sign-on (SSO) from Okta to Microsoft Office 365

-   Lifecycle Management (LCM) for Microsoft Office 365

This guide also provides instructions for setting up a scheduled import
and a scheduled workflow which will exercise the Microsoft Graph API in
your E5 sandbox to prevent it from expiring.

Before you can complete this guide you must have already signed up for a
Microsoft E5 sandbox and configured it with a custom DNS domain. A
custom DNS domain is required because it's not possible to set up
federation against the default onmicrosoft.com domain.

Instructions for this can be found here: [[Get Microsoft E5
sandbox]{.underline}](https://docs.google.com/document/d/1qvjRcUefXQyfwOSJ0duK35ZdFX5HBgddsAguscZSpyo/edit?usp=sharing)

This guide assumes that you have at least one test user (in addition to
your admin user) defined in your Okta org.

If you have questions about the topics covered in this document, or you
get stuck while following the instructions, you can reach out to us on
Slack in the
[[#newhires-techfield]{.underline}](https://okta.slack.com/archives/C012ZBCB9ND)
channel or email the team at
[[techenablement@okta.com]{.underline}](mailto:techenablement@okta.com).


# Introduction

Microsoft Office 365 uses Microsoft Azure AD as its user store and to
manage federation for single sign-on. This means that when you're
configuring integration with Microsoft Office 365 in Okta, you're really
configuring integration with Azure AD - even though the integration name
in the OIN "Microsoft Office 365".

Okta's single sign-on to Microsoft Azure AD uses a protocol called
WS-Federation. The WS-Federation standard, and the related WS-Trust
standard, were developed by Microsoft (and a group of other companies)
in the days before SAML 2.0. Today, it's unusual to see WS-Federation
except for in relation to integration with Microsoft.

Note: Microsoft has recently added support for SAML 2.0 but the
integration is more limited than when using WS-Federation.

The Okta Lifecycle Management integration with Microsoft uses
Microsoft-specific APIs to manage users in Azure AD. Integration with
Microsoft is relatively simple if you only need to manage the basic
profile attributes available via Microsoft public APIs. However, it can
get pretty complex if you need to integrate with an environment that
uses Microsoft Azure AD Connect (AAD Connect) to synchronize an
on-premises AD with Azure AD in the cloud.

This document covers the simplest integration you need to build a demo
system.

# Add Microsoft Office 365 Application to Okta

Okta maintains a specific integration for Microsoft Office 365 in the
Okta Integration Network (OIN). To add this to your Okta org, follow
these steps:

1.  Use a browser to open the administration UI of your Okta demo org
    > and sign in as an administrator.

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image1.png "image_tooltip")

2.  Navigate to **Applications \> Applications**.

3.  Click **Browse App Catalog** to open the Okta Integration Network
    > browser.

> ![](media/image45.png){width="6.380208880139983in"
> height="2.1742082239720033in"}

4.  Search for and select the **Microsoft Office 365** integration.

> ![](media/image82.png){width="6.359375546806649in"
> height="1.9021347331583551in"}

5.  Click **Add integration**.\
    > The *Add Microsoft 365* wizard opens on the *General Settings*
    > page:

> ![](media/image11.png){width="6.453125546806649in"
> height="5.422274715660542in"}

6.  Complete the *Microsoft Tenant Name* field. This must match the
    > tenant name you chose when setting up your Microsoft tenant. If
    > your Microsoft tenant is *yourdemodomain*.onmicrosoft.com then
    > your Microsoft tenant name is *yourdemodomain*.

7.  Click **Next**.\
    > You are taken to the *Sign-On Options* page of the wizard:

> ![](media/image53.png){width="6.463542213473316in"
> height="3.267736220472441in"}\
> This integration supports both Secure Web Authentication (SWA), for
> password injection, and WS-Federation, for federated single sign-on.

8.  Select the radio button for **WS-Federation**.

> Note: A button is shown which you can use to view setup instructions
> for the Microsoft side. These include setting up a custom DNS domain
> (which you should have already done) and manual integration steps.
>
> You won't need the manual steps because you're going to perform
> automated configuration. Okta will connect directly to your Microsoft
> tenant and perform the required configuration via Microsoft APIs. This
> is a significant differentiator for Okta; it's much simpler than
> running PowerShell scripts to perform the integration.
>
> ![](media/image16.png){width="6.442708880139983in"
> height="2.8282720909886265in"}

9.  Enter the *username* and *password* for the administrator of your
    > Microsoft tenant.\
    > These will be used to authenticate to the tenant to perform domain
    > lookup (in the next step) and to perform the automated
    > configuration.

10. Click **Fetch and Select** next to Office 365 Domains.\
    > The credentials you have provided are used to connect to your
    > Microsoft tenant and query the verified domains that can be
    > configured for federation. This may take a few seconds.

> ![](media/image20.png){width="6.463542213473316in"
> height="1.2984798775153106in"}

11. Select the custom DNS domain that you configured when you were
    > setting up your Microsoft tenant.

> If no DNS domains are shown here, refer to these instructions: [[Get
> Microsoft E5
> sandbox]{.underline}](https://docs.google.com/document/d/1qvjRcUefXQyfwOSJ0duK35ZdFX5HBgddsAguscZSpyo/minimalstatic#heading=h.q5u9bvuz3rr2)

12. Click **Select**.

> ![](media/image44.png){width="6.473958880139983in"
> height="2.5915102799650045in"}
>
> Under Credential Details, you can specify the username that will be
> passed to Microsoft in single sign-on messages. In reality, Microsoft
> doesn't really use this username for SSO - it uses an attribute called
> *immutableId* in SSO messages.
>
> However, the value specified here will be used during provisioning to
> generate the username in Azure AD. This username should be in email
> address format and the domain should match the custom DNS domain that
> you're linking to. You could use a standard attribute (Okta username
> or email address) if you are sure it will have the correct format but,
> in this case, you will use a custom expression which replaces the
> domain part of the Okta username with the custom DNS domain of your
> Microsoft tenant.

13. Set *Application username format* to **Custom**.

14. Enter the following for the expression - replacing
    > yourdemodomain.com with your own custom DNS domain:

> **String.substringBefore(user.login,\"@\") + \"@yourdemodomain.com\"**
>
> This will create the Microsoft username by taking the part of the Okta
> username attribute (okta.login) before the @ sign and then adding
> \@yourdemodomain.com.\
> For example, your.name@atko.email would become
> [[your.name@yourdemodomain.com]{.underline}](mailto:your.name@yourdemodomain.com).

15. Click **Done**.\
    > The wizard completes.

Your Okta org, and your Microsoft 365 tenant, are now configured for
single sign-on from Okta to Azure AD.

Note: You can't test single sign-on until you have enabled provisioning
and assigned at least one user to this application in Okta.

# Configure provisioning

The single sign-on configuration performed in the previous section
allows your Okta org to assert identity information to your Microsoft
365 tenant and it allows your Microsoft 365 tenant to trust it. However
that's not enough for single sign-on to complete. Each identity asserted
by Okta must link to an existing account in Azure AD.

The required Azure AD accounts could be created manually, or synced from
a common identity source such as an on-premises AD but, in this case,
you will set up provisioning in Okta so that it can automatically manage
accounts in Azure AD. It will create accounts when users are assigned to
the Office 365 application and deactivate these accounts when users are
unassigned. It will also manage user attributes and licenses.

## Enable integration

Accounts in Azure AD can be managed via Microsoft APIs. To enable
provisioning, Okta must be granted authority to call these APIs. Follow
the steps below to grant this access and enable integration:

1.  If you are not already there, open your Okta administration UI,
    > navigate to **Applications \> Applications**, and select the
    > **Microsoft Office 365** application definition.

> ![](media/image80.png){width="6.463542213473316in"
> height="2.6450503062117234in"}

2.  Click on the **Provisioning** tab and click the **Configure API
    > integration** button.

> ![](media/image21.png){width="6.473958880139983in"
> height="2.5296970691163603in"}

3.  Check the checkbox for **Enable API integration**.

4.  Click the **Authenticate with Microsoft Office 365** button.

5.  Authenticate as the administrative user for your Microsoft tenant.\
    > A consent box is shown requesting that you grant permissions to
    > the Okta Microsoft Graph Client:

> ![](media/image49.png){width="6.484375546806649in"
> height="2.6921730096237972in"}

6.  Click **Accept** to allow your Okta org to manage users in your
    > Microsoft Azure AD.

> ![](media/image74.png){width="6.453125546806649in"
> height="2.0307753718285215in"}
>
> The Admin Username and Admin Password should be pre-populated based on
> the credentials you provided for automated single sign-on
> configuration.
>
> You can optionally use the Test API Credentials button to test the
> credentials.

7.  Click **Save**.

> ![](media/image9.png){width="6.442708880139983in"
> height="2.3009667541557306in"}

The API connection for provisioning is now in place. Provisioning
configuration is now shown under the Provisioning tab. The integration
configuration you just created is under the Integration tab.

There are two provisioning directions supported by this integration:

> **To App** - This is provisioning from Okta to Microsoft 365. This is
> the integration you configure if you want Okta to manage accounts in
> Azure AD.
>
> **To Okta** - This is provisioning from Microsoft 365 to Okta. This is
> the integration you would set up if you want to create Okta accounts
> when users are created in Azure AD. It can also be used to match
> accounts created in Azure AD to users in Okta.

## Enable provisioning to app

In this section you will enable provisioning to Microsoft 365. This will
include creation of accounts in Azure AD when users are assigned to the
application, updating attributes in Azure AD when things change in Okta,
and deactivating accounts in Azure AD when users are unassigned from the
application in Okta.

Note: In general, Okta does not delete accounts from applications - it
only deactivates them. This ensures that Okta is not responsible for any
data loss in the backend system that could be triggered by deleting an
account.

Follow these steps to enable provisioning:

> ![](media/image81.png){width="6.453125546806649in"
> height="2.419922353455818in"}
>
> You should already be on the **To App** tab under **Provisioning**.

1.  Click **Edit** to set the options for Okta provisioning to Azure AD.

> ![](media/image84.png){width="6.43571741032371in"
> height="3.7104943132108485in"}

2.  Click the **Enable** checkbox for *Create Users*.

3.  Click the **Enable** checkbox for *Update User Attributes*.

4.  Click the **Enable** checkbox for *Deactivate Users*.

> Note: *Sync Password* is not enabled. When federation is enabled for
> single sign-on, no password is required in Azure AD because users will
> authenticate in Okta and be asserted to Microsoft 365 based on the
> trusted federation relationship.

5.  Click **Save**.

## Configure attribute mapping

When a user is assigned to an application, attribute mapping determines
the default values that will be set for attributes in the application.
If attribute mapping is not configured, values for attributes must be
manually set whenever a user is assigned.

For Microsoft 365, the licenses and roles to be assigned to users can be
set up in attribute mapping. This is what you will configure here.
Follow these steps:

> ![](media/image83.png){width="6.421875546806649in"
> height="2.2266327646544184in"}

1.  If not already there, open the **To App** settings under the
    > **Provisioning** tab of the Microsoft Office 365 application.

> ![](media/image3.png){width="6.453125546806649in"
> height="1.6036789151356081in"}

2.  Scroll to the bottom of the page and click **Show Unmapped
    > Attributes**.

> ![](media/image65.png){width="6.442708880139983in"
> height="1.140896762904637in"}

3.  Click the **Edit** icon for the *Licenses* attribute.

> ![](media/image62.png){width="6.380208880139983in"
> height="1.2912325021872266in"}
>
> Note the options available here. You can set the same value for all
> users or you can use an expression to programmatically set the value
> (based on attributes of the user).

4.  Select **Same value for all users** from the drop-down list.\
    > The available options are shown. These have been pulled via API
    > and so reflect the options relevant for your Microsoft tenant:

> ![](media/image77.png){width="6.432292213473316in"
> height="3.445870516185477in"}
>
> ![](media/image72.png){width="6.432292213473316in"
> height="2.574831583552056in"}

5.  Select the checkboxes for the following licenses:

    -   Nucleus

    -   Content_Explorer

    -   Microsoft_Search

    -   Sharepoint Online (Plan 2)

    -   Office Online

    -   Office 365 ProPlus

    -   Exchange Online Advanced Threat Protection

> These will give access to Office apps.
>
> If you want to enable additional apps, you could also select
> additional licenses such as:

-   Microsoft Teams

-   Intune

-   Exchange Online (Plan 2)

> These will give access to additional features you might want to
> demonstrate.
>
> ![](media/image76.png){width="6.453125546806649in"
> height="1.0840430883639545in"}

6.  Scroll to the bottom of the window and click **Save**.

> Note the option to apply on *Create* or *Create and update*. This
> determines whether this attribute should be updated in Microsoft 365
> only when the user is assigned, or any time an update is made to the
> user in Okta.

OK. Provisioning is enabled and attribute mapping is done. You're ready
to test.

# Test provisioning and single sign-on

Now that provisioning and single sign-on have both been configured, you
can test them by assigning your Okta admin user to the Microsoft Office
365 application and then attempting single sign-on.

This section uses the Okta admin user ***your.name*\@okta.com** as the
test user. This user will be mapped to
***your.name*\@yourdemodomain.com** by the custom username mapping you
set up when configuring single sign-on.

## Assign user to Microsoft Office 365 application

For this test you will directly assign your Okta admin user to the
Office 365 application. You'll notice that it's also possible to assign
via group membership - you'll set that up later.

1.  If not already there, navigate to **Applications \> Applications**
    > and select the **Microsoft Office 365** application:

> ![](media/image13.png){width="6.351193132108486in"
> height="3.468728127734033in"}

2.  Select the **Assignments** tab.

3.  Click the **Assign** button and select **Assign to People** from the
    > drop-down list.\
    > This allows you to assign access to individual users.\
    > A list of users is shown:

> ![](media/image28.png){width="6.453125546806649in"
> height="1.3872167541557305in"}

4.  Select your admin user and click **Assign**.

> Note: It is the email address of the user that is shown in this
> selector, NOT the username. These may or may not be the same.
>
> The application-specific attributes associated with the assignment are
> shown:
>
> ![](media/image60.png){width="6.484375546806649in"
> height="0.8491447944006999in"}
>
> The User Name has been set based on the custom expression you
> specified during configuration of single sign-on.
>
> The *Immutable ID* is blank. This would only be populated if the user
> was AD sourced and already had an immutable ID synced from Azure AD
> via Microsoft AD Connect or similar. In this case, the immutable ID
> will be populated during provisioning to Azure AD.
>
> Licenses have been set based on the attribute mapping you created.
>
> ![](media/image61.png){width="6.484375546806649in"
> height="1.2061712598425196in"}

5.  Scroll down to the *roles* and select the **Global Administrator**
    > option. This will make the user a global administrator in the
    > Microsoft 365 tenant.

> ![](media/image38.png){width="6.473958880139983in"
> height="1.262036307961505in"}

6.  Scroll to the bottom and click **Save and Go Back**.

> ![](media/image12.png){width="6.505208880139983in"
> height="3.320366360454943in"}

7.  Click **Done**.\
    > Your user now shows as assigned:

> ![](media/image6.png){width="6.546875546806649in"
> height="2.2504877515310584in"}
>
> In the background, Okta is now attempting to create this user in your
> Microsoft 365 tenant and assign the selected roles licenses. This
> should only take a few seconds to complete.
>
> ![](media/image75.png){width="6.442708880139983in"
> height="3.537737314085739in"}

8.  In the Okta Admin UI, navigate to **Reports \> System Log**.

9.  Confirm that the records indicating successful provisioning are
    > found.

## Test single sign-on

You can now test single sign-on to Microsoft 365 for the assigned user.

1.  Open a new browser window that is not signed into Okta or Microsoft
    > 365.\
    > This could be a private browsing window, a different profile, or a
    > different browser.

2.  Navigate to your Okta tenant. e.g. ***yourdemoorg*.okta.com**

3.  Authenticate as your test user: e.g. ***your.name*\@okta.com**\
    > You should end up on your Okta dashboard and see that tiles for
    > Microsoft apps are now shown:

> ![](media/image19.png){width="6.473958880139983in"
> height="2.784187445319335in"}

4.  Click the tile for **Microsoft Office 365 Office Portal**.\
    > If single sign-on is successful you will see this pop-up:

> ![](media/image29.png){width="6.504294619422573in"
> height="1.906765091863517in"}

5.  Click **Yes** to stay signed in.\
    > Actually it doesn't really matter which option you pick because
    > you're going to sign out again anyway.\
    > You are taken to the Office 365 site:

> ![](media/image24.png){width="6.453125546806649in"
> height="2.68450021872266in"}
>
> Notice the Word, Excel, and Powerpoint icons. These are present
> because of the licenses that were applied. Notice the Admin icon. This
> is present because of the global administrator role you selected.

6.  Click the identity icon in the top-right of the page.

> Notice the name and account name shown in the pop-up window. This
> should show that you are authenticated as
> ***your.name*\@yourdemodomain.com**. Provisioning and single sign-on
> were successful!

7.  Click **Sign out** to clear the session. Close the browser you used
    > for the test.

# Configure group assignment

In the previous section, you assigned a user directly to the Microsoft
365 application. It was useful to do this so that you could assign the
Global Administrator role. However, for assigning users in bulk, it's
more usual to assign a group to an application and then assign users to
the group.

When assigning a group to an application, you can specify values for
application attributes. These will override any mapping for those
attributes in the application definition. If you don't specify any value
for an attribute, the mapping in the application definition will be
applied instead.

## Create a group

You will now create a group that will be assigned to the Microsoft
Office 365 application.

> ![](media/image17.png){width="6.473958880139983in"
> height="2.312128171478565in"}

1.  In the administration UI for your Okta org, navigate to **Directory
    > \> Groups**.

2.  Click the **Add group** button.

> ![](media/image70.png){width="6.536458880139983in"
> height="1.478484251968504in"}

3.  Enter **O365Users** as the Name of the group.

4.  Enter **Office 365 Users** as the Description.

5.  Click **Save**.

> Note: The group may not immediately show in the group list. Click on
> the Group navigation item again to reload the page and it should be
> shown.

## Assign group to application

You can assign a group to an application by either assigning the group
within the application definition or by adding the application to the
group definition. In this case you will add the application from the
group definition.

1.  If not already there, navigate to **Directory \> Groups**.

> ![](media/image10.png){width="6.473958880139983in"
> height="3.0774464129483814in"}

2.  Click on the link for the **O365Users** group.

> ![](media/image78.png){width="6.494792213473316in"
> height="2.512866360454943in"}

3.  Select the **Applications** tab in the group properties.

4.  Click **Assign applications**.

> ![](media/image55.png){width="6.473958880139983in"
> height="2.3795647419072616in"}

5.  Click the **Assign** button next to the *Microsoft Office 365*
    > application.

> ![](media/image37.png){width="6.473958880139983in"
> height="0.8188790463692038in"}
>
> You don't need to select any licenses. Leaving these clear will mean
> the licenses configured in the application attribute mapping will be
> used. You do not want to select any role.

6.  Scroll to the bottom of the page and click **Save and Go Back**.

> ![](media/image43.png){width="6.536458880139983in"
> height="1.313127734033246in"}

7.  Click **Done**.

The application is now assigned to the *O365Users* group.

## Assign user to group

You will now assign a test user to the *O365Users* group. This will
cause the user to be assigned the Microsoft Office 365 application
which, in turn, will trigger provisioning of an account.

1.  If not already there, navigate to **Directory \> Groups**.

> ![](media/image79.png){width="6.431499343832021in"
> height="2.903853893263342in"}

2.  Select the **People** tab.

3.  Click **Assign people**.

> ![](media/image59.png){width="6.442708880139983in"
> height="2.2626181102362204in"}

4.  Click the **+ icon** for a test user in your Okta org.\
    > This should not be the admin user (which is already directly
    > assigned to the application)

> The user is now shown as assigned:
>
> ![](media/image66.png){width="6.369792213473316in"
> height="0.8341393263342082in"}

The user is now assigned to the group and will be assigned to the
Microsoft Office 365 application using the attribute mapping associated
with the group assignment.

## Test single sign-on

You can now test single sign-on to Microsoft 365 for your test user.

1.  Open a new browser window that is not signed into Okta or Microsoft
    > 365.\
    > This could be a private browsing window, a different profile, or a
    > different browser.

2.  Navigate to your Okta tenant. e.g. ***yourdemoorg*.okta.com**

3.  Authenticate as your test user: e.g.
    > ***alex.anderson@yourdemodomain.com***\
    > You should end up on your Okta dashboard and see that tiles for
    > Microsoft apps are shown:

> ![](media/image57.png){width="6.494792213473316in"
> height="2.193924978127734in"}

4.  Click the tile for **Microsoft Office 365 Word Online**.\
    > If single sign-on is successful you will see this pop-up:

> ![](media/image73.png){width="6.536458880139983in"
> height="1.9356474190726158in"}

5.  Click **Yes** to stay signed in.\
    > Actually it doesn't really matter which option you pick because
    > you're going to sign out again anyway.\
    > You are taken to Word Online in Office 365:

> ![](media/image36.png){width="6.473958880139983in"
> height="2.2350568678915135in"}
>
> Notice the Word, Excel, and Powerpoint icons. These are present
> because of the licenses that were applied. This is a standard user -
> the Admin icon is NOT shown.

6.  Click the identity icon in the top-right of the page.

> Notice the name and account name shown in the pop-up window. This
> should show that you are authenticated as your test user. Provisioning
> and single sign-on were successful!

7.  Click **Sign out** to clear the session. Close the browser you used
    > for the test.

Congratulations! You have successfully configured Lifecycle Management
and Single Sign-On to Microsoft Office 365. Your demo environment can
now be used to demonstrate these capabilities to customers.

# Keeping your developer instance active

A Microsoft 365 E5 developer instance has a default lifetime of 90 days.
This time is extended by Microsoft, at their discretion, based on
whether or not they see "activity" in the tenant. Two methods to
generate "activity", which have proven successful, are detailed below.
You should set up one (or ideally both) of these methods in your own
demo environment.

## Enable scheduled import

The Microsoft Office 365 connector in Okta supports provisioning To Okta
based on accounts found in Azure AD. Even though you probably don't want
to provision in this direction, the scheduled import process can
generate regular activity in your Microsoft tenant even if no imports
are performed.

### Configure Import and account matching

Follow these steps:

1.  Login to the administration UI of your Okta org.

2.  Navigate to **Applications \> Applications** and open the
    > **Microsoft Office 365** application definition.

> ![](media/image35.png){width="6.473958880139983in"
> height="2.5722419072615925in"}

3.  Click the **Provisioning** tab.

4.  Select **To Okta** under *Settings*

5.  Click **Edit** in the *General* section.

> ![](media/image52.png){width="6.484375546806649in"
> height="3.618512685914261in"}

6.  Set *Schedule import* for **Every 2 days**.\
    > This will cause the import process to run regularly and exercise
    > Microsoft APIs.

> The Okta username format determines the username that will be used
> when creating a new user in Okta to own an account imported from Azure
> AD. The only choices are email address and custom. Given that we don't
> know what format the email address might take in Azure, we use a
> custom expression to pick the Username from the app user instead.

7.  Select Custom for the Okta username format.

8.  Set the expression to: **appuser.userName**

9.  Click **Save**.

> ![](media/image31.png){width="6.505208880139983in"
> height="1.0842016622922135in"}

10. Click **Edit** in the *User Creation & Matching* section.

> ![](media/image5.png){width="6.442708880139983in"
> height="3.652785433070866in"}
>
> By default, an account in the source (Azure AD) is considered a match
> for an existing user in Okta if the email address matches. That's not
> what you want here.

11. Select **Okta username format matches**.\
    > This means that a match will occur if there is a user in Okta
    > which matches the username specified by the Okta username format
    > property. In this case it means it will match based on the
    > username in Azure AD matching the username in Okta.

12. Click **Save**.

### Perform initial import

You will now perform an initial import. This will allow you to tell Okta
to ignore the initial onmicrosoft.com admin account in Azure AD.

> ![](media/image54.png){width="6.380208880139983in"
> height="2.2121850393700786in"}

1.  Select the **Import** tab and click **Import Now**.

> The import is performed in real time. It should only take a few
> seconds to complete. When complete, the results are shown:
>
> ![](media/image67.png){width="6.473958880139983in"
> height="3.0860826771653542in"}

2.  Click the arrow icon for the discovered *onmicrosoft.com* account.

3.  Select **IGNORE this user for now** from the drop down menu.

> ![](media/image47.png){width="6.493757655293089in"
> height="2.2418919510061244in"}

4.  Click **Confirm Assignments**.

> ![](media/image69.png){width="6.442708880139983in"
> height="2.042108486439195in"}

5.  Click Confirm to confirm the assignments.

You're done; a scheduled import will now run every two days. This will
perform account lookups in your Microsoft 365 tenant which will help to
keep it active.

## Create a scheduled workflow

Another way you can create activity in your Microsoft 365 tenant is to
use a scheduled *workflow* to perform actions against the API of the
tenant. There are many different APIs you could call but the one
documented here is relatively simple to set up and, so far at least,
effective at keeping tenants active.

### Configure an Office 365 Admin connection

Workflows use *Connections* to perform actions against external systems.
You will now create an Office 365 Admin connection to your Microsoft
tenant.

1.  In the Administration UI of your Okta org, navigate to **Workflows
    > \> Workflows** console.\
    > The workflows console is opened in a new browser tab:

> ![](media/image64.png){width="6.484375546806649in"
> height="0.9166896325459317in"}

2.  Select the **Connections** tab and click **New Connection**.\
    > A list of connection types is shown:

> ![](media/image34.png){width="6.484375546806649in"
> height="1.852678258967629in"}

3.  Click the **Office 365 Admin** connection type.

> ![](media/image2.png){width="6.453125546806649in"
> height="2.1441360454943132in"}
>
> The default connection nickname is fine.

4.  Click **Create**.

> You are now taken to Microsoft.

5.  Authenticate as an administrator of your Microsoft tenant.\
    > This could be the ***your.name*@*yourdemodomain*.onmicrosoft.com**
    > administrator account or the ***your.name@yourdemodomain.com***
    > account.

> An OAuth consent page is displayed:
>
> ![](media/image39.png){width="3.4754680664916884in"
> height="4.835865048118985in"}

6.  Check the checkbox to **Consent on behalf of your organization**.

7.  Click **Accept**.\
    > If successful, you will see the following page showing the new
    > connection:

> ![](media/image7.png){width="6.484375546806649in"
> height="1.3219630358705161in"}
>
> The icons on the right of the row include options to test the
> connection and to re-authorize it. These can be useful for
> troubleshooting.

### Create flow

Now that you have created a connection, you can use it to create a new
flow which calls Office 365 admin APIs to create activity.

> ![](media/image26.png){width="6.473958880139983in"
> height="1.0886264216972878in"}

1.  Select **Flows** tab and click **New Flow**.

> ![](media/image46.png){width="6.494792213473316in"
> height="2.4452121609798776in"}

A *flow* is triggered by an *event*. You need to add an event.

2.  Click **Add event**.\
    > You can see that there are a lot of different ways you can trigger
    > a flow. Loads of capability here!

> ![](media/image68.png){width="6.536458880139983in"
> height="2.20799978127734in"}

3.  Select **Schedule**.\
    > This will allow you to trigger the flow at regular intervals.

> ![](media/image71.png){width="6.442708880139983in"
> height="2.3297298775153106in"}

4.  Set the *Frequency* to **WEEK**

5.  Set the flow to run at **2:00 AM** on every **Sunday** and
    > **Wednesday**.

6.  Click **Save**.

> ![](media/image27.png){width="6.475675853018373in"
> height="2.4380150918635173in"}
>
> The *cards* after the trigger are executed when the flow is triggered.
> Each card can be an *app action* or a *function*. An app action calls
> out to an application (usually using a connection). A function allows
> you to add logic and static functions to the flow.

7.  Click **Add app** action.

> ![](media/image42.png){width="6.515625546806649in"
> height="1.716169072615923in"}

8.  Select the **Office 365 Admin** app from *My Connected Apps*. This
    > is the connection that you created in the previous section.

> ![](media/image33.png){width="6.453125546806649in"
> height="1.687425634295713in"}
>
> The actions available are dependent on the app selected. You can see a
> load of Office 365-specific actions here.

9.  Select the **Get Licenses** function.\
    > This will query license information from your Microsoft 365
    > tenant.

> Usually you would use the information returned from an API call but in
> this case the purpose is only to generate activity so the response is
> not used for anything.
>
> ![](media/image1.png){width="6.473958880139983in"
> height="2.4277340332458444in"}
>
> Now you're going to add another action. This time it will be a call to
> the */Me* SCIM endpoint. This endpoint isn't a listed app action so
> you will use a custom API call.

10. Click **Add app action** to add another action.

> ![](media/image32.png){width="6.484375546806649in"
> height="1.7851334208223972in"}

11. Select the **Office 365 Admin** app again.

> ![](media/image41.png){width="6.463542213473316in"
> height="1.8731922572178479in"}

12. Select **Custom API Action**.\
    > Many apps have this option. It allows you to make API calls that
    > are not specifically listed but still using the security context
    > associated with the connection.

> ![](media/image18.png){width="6.453125546806649in"
> height="2.371907261592301in"}

13. Set the *Request Type* to **GET** and click **Save**.\
    > Setting the request type determines which inputs will be available
    > on the card.

> ![](media/image4.png){width="6.494792213473316in"
> height="2.967115048118985in"}
>
> The only input required for the /Me endpoint is the *Relative UR*L.
> The only response you might want is the *Body*.

14. Set the *Inputs* checkboxes so that **Relative URL** is the only
    > input.

15. Set the *Outputs* checkboxes so that **Body** is the only output.

16. Click **Save**.

> The Custom API Action card is added with the requested inputs and
> outputs:
>
> ![](media/image30.png){width="6.432292213473316in"
> height="2.57086832895888in"}

17. Set *Relative URL* to **/Me**

### Test the flow

You can test a flow to make sure that it works correctly. You will see
the outputs from each card so that you can check they are executing
correctly.

1.  Click the **Test** button for the flow.\
    > This triggers a save:

> ![](media/image51.png){width="6.463542213473316in"
> height="1.15420384951881in"}

2.  Give your flow a name. E.g. **M365 Keepalive**.

3.  Select the checkbox for **Save all data...**.\
    > This means that a history of flow executions will be kept whenever
    > it runs. This is really useful for debugging and is recommended
    > unless there are data privacy concerns.

4.  Click Save.

> The flow runs:
>
> ![](media/image15.png){width="6.463542213473316in"
> height="2.181829615048119in"}
>
> You can see a Success in the *Flow History*. This means that no errors
> were returned during the flow execution. You can also see the output
> from the two app action calls.
>
> Now that your flow has been saved, it has also been enabled:
>
> ![](media/image50.png){width="6.526042213473316in"
> height="1.0196937882764654in"}
>
> You can see a countdown to when it will next run because it is a
> scheduled flow.

5.  Click the **Folder icon** to see a list view of your flows:

> ![](media/image8.png){width="6.463542213473316in"
> height="1.587030839895013in"}

Congratulations. Your flow is now active and will run twice a week and
help keep your Microsoft tenant active.

If you want to extend this flow you could add an app that can send
email. You could use this to send yourself an email each time this
keepalive flow successfully completes - with the output from the API
calls.

Note: I tried setting up email using the Microsoft 365 Mail app
connector. The connection was fine but all attempts to send an email
resulted in send failures. I'm not sure if this was related to this
being a developer tenant or some other issue. If you figure it out, let
us know :)
