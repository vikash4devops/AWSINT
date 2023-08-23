
 **Note: <br>
           - IAM user is global and can perform the task in any region if permission granted. <br>
           - when a new user is created, he can't do anything if no policy is attached.**
           



1) What is Principle in AWS IAM?
  
    the principle in IAM is a person or application who will take action of that particular resouce.




2) Identity/User based Policy & Resource based Policy

    **Identity/User based Policy:**

      - this is the policy created for a **user, group & role** <br>
      - Identiy based policy doesn't have **principle** method concept
      
     
    **Resource based Policy:**

      - this is the policy created for a **resource** <br>
      - Resource based policy does have **principle** method concept 



**------------------------------------- MULTI ROLES & CROSS ACCOUNTS ----------------------------**<br>

1) any user can have only single role assigned at a time, if he has to work with another role, then first role will automatically be unassigned.
   same if he left the role2, then role1 will automatically be assigned to him.
   
2) **Trusted Account & Trusting Account & Trusted Entity**  
           
           Trusted Account       : This is the account who wants to access another account resource (AC-1).
           Trusting Account      : This is the account who will give permission to other account (AC-1) for being accessed.
           Trusted Entity        : This is method where we add the trusted acc as PRINCIPLE in trusting acc to setup the cross-acc permissions
                                   (we setup the entire account as TRUSTED ENTITY not a particular USER)

2)  **Cross Accounts - Resource based Policy & simple role policy**

           Resource Based policy: 
           
             - in this case, we directly attach policies to a RESOURCE and grant the access to other users/accounts.
             - if there AC-1 & AC-2, and AC-1 user wants to access the resource of AC-2, then there are 2 ways of doing so.
             - first, directly permit the AC-1 (account_id) in AC-2 RESOURCE and all the users from AC-1 can access that resource.
             - when we set policy to RESOURCE directly, a user does still have his original role permissions.
             - there are only few services where we can set the resource based policies:
                (i) S3,  (ii) SQS,  (iii) SNS,  (iv) AWS Glacier Vault 
      
