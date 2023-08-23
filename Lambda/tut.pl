
Note:- Lambda function is platform as service, where it gives us directly platform to run our code, 
       we can not choose custom platform such as OS Type, Storage, CPU Type.
       
       Whereas, EC2 Instance is Infrastructure as service where we can choose our own custom settings.


1) There are 3 ways/process by which lambda function will be triggered (called)


  * Event source trigger :- its like the previous task, this task return its response and triggers the lambda function.
      
  * Downstream Request :- this is the task that will be performed by lambda function i.e - store data into table, store response into sqs que.
  
  * Concurrency :- this is the number of request that lambda function will be handling/serving at a time.
                   by def. numbers of request is 1000.

  a) Synchronous Invoke (Push)
  
      -> here push does mean by previous service will trigger the lambda function (gives response to lambda function to run)
      
      -> this process waits to complete the main service and once the main service is successfully runs then Lambda function will be triggered.
         Synchronous Invokation handles the single response at a time, as it is single time processor, 
         means lambda will only be triggered when previous task is finished and that gives response to lambda, and so on for further responses.
    
       EG. [ Event source ]     ->    [ Lambda Function triggers ]    -> [ lambda function code apply for destination service ]
           [ S3 Bucket file uploaded ]  ->  [ Lambda Function Trigger (if uploading was success) ] -> [ Enter File Meta data into Dynamo db ]
           
       below services that invoke Lambda function Synchronously:
       
        i)    ELB
        ii)   Amazon cognito
        iii)  Cloudfront
        iv)   API Gateway
        v)    Kinesis Data Firehose
        vi)   Amazon Lex
       
    
    
  b) Asynchronous Invoke (Event)
      
      -> this process can pass/handle multiple response/requests at a time and will send the multiple response to next service in Que.
         we can use other AWS services to store those response in Que, service - [SNS, SQS, another lambda function, eventbridge]
         once response is stored in Que lambda function will get response about this, 
         but lambda function can not get its success or failure response after request stored in Que. 
         
         below services that invoke Lambda function Asynchronously:
          
          i)    Amazon S3
          ii)   Amazon SNS
          iii)  Cloudformation
          iv)   Cloudwatch logs
          v)    Cloudwatch events
          vi)   AWS Config
          vii)  AWS CodeCommit
         
  
  c) Poll Base Invoke (Pull Based)
  
      -> this process does not wait to get response from previous service, whereas it checks or pulls the response itself if there is any changes 
         in previous service it will be triggered automatically, generally it happens in SQS and kinesis streaming services 
         where they check is there any pending request in SQS or any changing in kinesis streaming and will be triggered automatically.
       
        below services that invoke Lambda Automatically:
       
        i)    SQS 
        ii)   Kinesis
        iii)  Dynamo DB Kinesis
        
        
2)  Runtime in Lambda :- Runtime is the programming languages which lambda supports
    a)  python
    b)  nodejs
    c)  ruby
    d)  powershell
    e)  java
    f)  c#
        
----------------------------------------------------------- LAMBDA MEMORY STORAGE ------------------------------------------------------------------

1)  Minimum memory for a lambda function is 128 MB, and can be updated upto 3008 MB, memory size can only be in *64 multiplication
       eg. 128, 198, 264 .....so on.. upto 3008 (if our requirement is above than 3008 MB memory, then we need to move to EC2 instances)
       
2)  If our lambda function is equal or greater than 1536 MB, 
    then AWS will automatically allocate multiple CPU Threads to that lambda function (more CORE CPU Proccessor, 2 CORE, 4 CORE)      


------------------------------------------- LAMBDA PRACTICAL -----------------------------------

1) Very fist, need to create a role to attach with lambda function, and role policy would be for the service where lambda function code will be applied.
    (SQS, S3 etc..)
    
    

       
