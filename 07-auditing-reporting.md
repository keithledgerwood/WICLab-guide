## Audits and Reporting Essentials

In this lab, you will navigate through Okta's comprehensive audit and reporting functionalities. You'll get an in-depth look at the various activities performed within your organization on a daily basis. Embrace the advantages of centralized audit and reporting, a cornerstone for robust security and stringent compliance. Moreover, discover how these insights can serve as a potent enhancer to your organization's broader security operations, fortifying your defense mechanisms and optimizing operations.

## Okta System Log

1. In the Admin Console select  **Reports** > **System Log**.

>The **System Log** page displays the following items: \
   **Search** field - Here you can type your search queries about the system events to gain more insights from the data. \
   **Count of events over time** - Histogram of events, showing the number of events recorded in the system for particular time frames. \
   **Events** - Tabular List of all system events with latest on top

2. In the **Search** field, type the first name of your new employee.
This will filter the log results to show only the events for the new employee.
3. In the **Count of events over time** histogram, hover over each column to see the count of events recorded for the new employee in particular time frames.
4. In the **Events** table, find the columns **Event Info** and **Targets**, which include information about actions, apps, and authenticators involved in particular events.
5. Scroll down the table to see specific events recorded for the new employee. You may need to click **Show More** at the bottom to load all events.
Take a moment to analyze how the employee’s lifecycle and access has been recorded from hire to termination.

   > **Note:** In the Okta Expression Language, user behavior fields in the logs are stored as key : value pairs, where:
   Key is the type of behavior (following the Behavior Detection criteria: New City, New Country, New Device, New Geo-Location, New IP, and others).
   Value is either "negative" (meaning no change in behavior) or "positive" (meaning change in behavior detected).
  You will use this information in the next step.
   >

6. In the **Search** field, type **positive**.
This will filter the log results to show only the events when a change in user behavior was detected.
7. In the **Events table, choose one of the events and on its left-hand side click **>** to see details of this event.
8. On the right-hand side of the event, click **Expand All** to expand all the details.

<!-->
9. Search for the Behaviors line.
You should see a record confirming a change in user behavior. For the event in which you logged in from a New Device (following instructions in the User Behavioral Analytics section), this should be "New Device=POSITIVE" .
-->
|||
   |:-----|:-----|
   |![Alt text](images/011/marc_r74_100.png "Marc says...")|*Did you know that Okta's rich system log and auditing prowess can seamlessly flow into your organization's security operations tools, helping paint a clearer view of your security posture? It's like having night vision goggles in the realm of cybersecurity!*|

## Okta Reports

1. In the Admin Console select **Reports** > **Reports**.
This will take you to the Reports page, where you can find Okta’s out-of-the-box auditing reports.
2. Under **Application Access Audit**, click **Current Assignments**.
3. Click **Request report**.
4. Close the Report requested window.
5. In the mailbox you used for registration, find the "Current Assignments Report" email and click **Download report**.
This will take you to the Okta org Admin Console and open the Downloading report window. Your report should download automatically. If it does not, in the Downloading report window, click **Download report**.
6. Close the Downloading report window.
7. Open the downloaded "CurrentAssignmentsReport.csv" file and analyze the assignments of particular apps to the users.
