# Terminate Employee

1. Deactive your users in the BambooHR tenant.

2. In the **People** tab, select your newly added user, change its' **Status** to *Inactive* and click **Save Changes**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/deactivate-user-bhr.jpg "image_tooltip")

3. Open your Okta administration UI, navigate to **Applications > Applications**, and select the BambooHR app definition to verify user profile and check if it was deactivated in Okta.

4. In the **Import tab**, click **Import Now**, and confirm changes to your user by selecting them and clicking **Confirm Assignements**.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/leaver-remove.png "image_tooltip")

5. Navigate to **Directory > Users** to check if your user status has changed.

![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/leaver-user.png "image_tooltip")

6. Open a new browser window that is not signed into Okta.

7.  Navigate to your Okta tenant. e.g. ***yourwiclabdomain*.okta.com**

8.  Authenticate as your test user: e.g.

    > ***Charlotte.Abbott@yourwiclabdomain.com***

![alt_text](https://raw.githubusercontent.com/MarcoBlaesing/LabGuide/main/images/009/image043.png "image_tooltip")

9. You should see an error, as your account was deactivated.
