
1)  There are 2 types of SQS

a) standard SQS :- this queue try to pass at-least one delivery (msg queue), and any message can be passed without any queue. 
                    it doesn't follow the order/sequence.

b) FIFO SQS :- it means FIRST IN FIRST OUT, it maintains the order, means which message comes first will be proceed first and then other message will be
   executed, duplicates are not introduced but it try to avoid duplicate messages for 5 minutes.


2)  Benefits of SQS:

using SQS we don't lose any message/request and that message will definetely proceed even if server has big traffice.
   eg:- if server is busy with other processing task or having big traffic and meanwhile new messages are occuring, so using SQS we store them in queue
        so every message could be proceed.
        
        
3)  Short Polling & Long Polling
  
  This is a request waiting time in SQS, suppose we have server(s) which will check the SQS if there is any message (withing given time).
  
    Short Polling:- in this polling, server will continuously check (send request) to SQS queue if there messages.
                     we need to set "Receive message wait time" option to 0 in SQS queue to define short polling.
                     
    Long Polling:-  in this polling server will not check or send request continuously to SQS queue, but it will check within         
                    "Receive message wait time" time in SQS, maximum wait time is 20 Seconds.


4)  Visibility timeout :- this is the time when SQS message will be invisible, when a message is processed till that time it is NA of other servers. 
                          no other server can take that processed message within this Visibility timeout, maximum Visibility timeout is 12 HRS AND 0 is min.
                          
                          
5)  Message retention period :- here we define the time the SQS message can last in queue. Max retention period is 14 days.

6)  Delivery delay :- here we define delay time for new messages to coming in queue, Any messages that sent to the queue remain invisible for the given delay time.
                      Maximum delay time is 15 minutes and min is 0.
                      
7)  Dead Letter Queue :- this is queue where all the failed messages are stored, we can set a number of maxium receive for a message, if within that given
                         receive numbers message could not be processed then SQS forward those message into Dead letter queue.
                         
8) How to send message in Dead Letter queue :- 

  create 2 SQS, lets first is Main SQS, another is Dead letter SQS.
  
  a) while creating main SQS, there is option of "Dead-letter queue - Optional", here we need to enable the option and need define  the maximum receive number 
    (point 7) & need to select another SQS queue ARN (this sqs will be dead letter sqs for main sqs)                      
