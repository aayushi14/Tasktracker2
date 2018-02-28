## Working of TaskTracker

A user can login to the application or a new user can Register to gain access to the TaskTracker application.

I have email-id validations, where you can only enter an email id in the correct email format. 
Email ids need to be unique, User name can be same. 
And hence I am letting the user login to the application through his/her unique email-id. 

On the Register page, the user can check the Manager checkbox field, if he is a manager.
Once a manager logs in to the app, he will get 4 links:

**Tasks**
- He can view a list of all the tasks. But can view, edit and delte only the tasks assigned by him and to him.
- Only a manager can create a New Task. In the Assigned to drop down he will get the names of his underlings.
- Once he assigns a task to his underling, if he edits he can only edit the Title, Description and Assigned to fields.

**Users**
- Only managers can View all the Users. And subsequently Add New user, view, eidt or delete the existing users.

**Report**
- Shows a list of all the tasks assigned to the underlings by the logged in manager. Its general report with no links or buttons.

**Choose your Reportees**
- The managers can Add New Relationship. The Manager dropdown has names of all Managers and the underlings dropdown has all the users who havent been assigned manager yet.
- Hence, there cannot be a cyclic relationship like a-->b and b-->a, there is no duplicate selection of underlings.

A user who is not a manager will get only a links of **Tasks**. He can view, edit and delete the tasks assigned to him by his manager.
- If that user wants to become a manager, a manager has to make him a manager. And then he will get full access to the application.
- As only a manager has access to delete the users, a logged in manager cannot delete himself, if he tries, a flash error occurs saying, request another manager to delete you.

Users already present in db: 
1. Alice (Manager) : alice@example.com
2. Bob (underling of A) : bob@example.com
3. Carlo (underling of A) : carlo@example.com