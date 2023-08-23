
                                              *** Main objective of this demo ***

<img width="1103" alt="Screen Shot 2022-05-23 at 19 11 11" src="https://user-images.githubusercontent.com/29144557/169832960-e2e9b9aa-9438-4871-ac59-8d3b95f97afd.png">



Steps to do

1. Create a user with following roles :- sqs, cloudwatch, dynamodb
2. Create an API
3. Create a Lambda function to send api request data to SQS-1
4. Create 2 SQS services, first SQS is main, second is Dead letter SQS
   update Dead-letter queue with receive maximum as 2 (as per need)

Lambda-1 code to send data in SQS (Attach this lambda with role of sqs, cloudwatch)

1st Lambda event trigger is created API gateway (once that api is hit, lambda1 will be invoked to send it to SQS1)

![image](https://user-images.githubusercontent.com/29144557/170051515-c01a5f24-3508-4db2-9560-b4ca5a70d525.png)


***code for 1st lambda****

  import json, boto3

  def lambda_handler(event, context):

      try:
          sqs_client = boto3.client("sqs")
          sqs_response = sqs_client.send_message(
                  QueueUrl="https://sqs.us-east-1.amazonaws.com/402605618668/main_sqs_1",
                  MessageBody=json.dumps(event)
              )

          return {
              'statusCode': sqs_response['ResponseMetadata']['HTTPStatusCode'],
              'body': sqs_response['ResponseMetadata']
          }

      except Exception as err:
          return {
              'statusCode': 400,
              'body': err
          }


4) Create 2nd lambda function to verify and proceed the sqs data into dynamo db (Attach this lambda with role of sqs, cloudwatch, dynamodb)

2nd Lambda event trigger would be SQS-1 (once message goes into SQS-1 lambda-2 will be invoked and start verifying and putting data into db)

![image](https://user-images.githubusercontent.com/29144557/170052441-f06442f8-f1ef-4603-9103-1117dd71a629.png)


***code for 2nd lambda****

import json, boto3, logging
from uuid import uuid4

dynamo_res = boto3.resource("dynamodb")
dynamo_tbl = dynamo_res.Table("shiva_tbl")

def lambda_handler(event, context):
    
    #event['id'] = str(uuid4())  #appending id in event dict (id is primary key in dynmamo table)
    
    # try:
    event_body_attr = event['Records'][0]['body']
        
    if "id" not in event_body_attr:
        raise Exception ("id is missing")
    elif "customer_name" not in event_body_attr:
        raise Exception ("customer_name is missing")
    elif "customer_city" not in event_body_attr:
        raise Exception ("customer_city is missing")
    else:
        dynamo_tbl.put_item(Item=json.loads(event_body_attr))
        return {"code": 200, "message": "Customer added succesfully"}
            

    # except Exception as err:
    #     raise Exception (err)
    
    
    
    Lambda Note:- if some parameter is missing then 2nd lambda will generate error into cloudwatch (lambda monitor section), can view lambda-2 cloudwatch, there will be all error that occurs during 2nd lambda code running..
    
    SQS Note:- when data goes into SQS-1, it will invoke lambda-2 and data will be verified and if anything is wrong in data that data will be forwarded to dead letter queue.
    

