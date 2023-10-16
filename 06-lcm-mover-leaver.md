## Navigating Employee Transitions Efficiently

In this lab, you will leverage the dynamic integration of Okta with your HR application. Experience firsthand how a change in an employee's job seamlessly translates into automatic adjustments in their application access. But that's not all - when employees bid adieu to the company, watch as their access is instantaneously disabled. Dive into the world of automation that not only streamlines processes but also ensures consistent security, equipping transitioning employees with the right tools for success and safeguarding company assets every step of the way.

## Employee Transfer

In the Add Job Information dialog, select a different department, and then click Save.

1. In the BambooHR dashboard search for and select your employee.

2. On the **Job** tab, for **Job Information**, click **Add Entry**.

3. In the **Department** field, select **Sales**, and then click **Save**.

    ![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/mover-bamboo.png "image_tooltip")

### Import changes to Okta

1. In the Okta Admin Console select **Applications > Applications**, and then select **BambooHR**.
2. On the **Import tab**, click **Import Now**.
3. In the Okta Admin Console select **Directory > Groups**.
4. Verify that the employee was automatically assigned to the **Sales**group and has access to the new set of Apps.

### Changes to Okta End-user Dashboard

1. Open a new browser window that is not signed into Okta.
2. Navigate to your Okta tenant. e.g. ***demo-xxxx-xxxx-nnnn*.okta.com**
3. Authenticate as your new employee. For example ***<flynn.rider@04.mywiclab.com>***
4. You should see a new set of apps, that were assigned to your employee based on their newly assigned *Department*.

|||
   |:-----|:-----|
   |![Alt text](images/011/marc_r74_100.png "Marc says...")|*Did you know that Okta's HR application integration streamlines employee job changes, ensuring they have just the right access and preventing a digital pile-up of permissions? It's like a digital wardrobe cleanse, keeping things tidy and just-right for security!*|

## Employee Termination

Deactivate the employee in the BambooHR tenant.

1. In the **People** tab, select your newly added user, change its' **Status** to *Inactive* and click **Save Changes**.

    ![alt_text](https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/main/images/003/deactivate-user-bhr.jpg "image_tooltip")

3. Open your Okta administration UI, navigate to **Applications > Applications**, and select the BambooHR app definition to verify user profile and check if it was deactivated in Okta.

4. In the **Import tab**, click **Import Now**, and confirm changes to your user by selecting them and clicking **Confirm Assignments**.

5. Navigate to **Directory > Users** to check if your user status has changed.
6. Open a new browser window that is not signed into Okta.
7. Navigate to your Okta tenant. e.g. ***yourwiclabdomain*.okta.com**
8. Authenticate as your test user: e.g.

    > ***<Charlotte.Abbott@yourwiclabdomain.com>***

9. You should see an error, as your account was deactivated.

## Conclusion

In this lab, we've turbocharged our HR game with Okta's dynamic prowess! Every job transition? Seamlessly mirrored in app access. Every farewell? Marked with instant, secure sign-offs. As we've delved into this automation arena, we've seen streamlined processes and top-notch security in action.
