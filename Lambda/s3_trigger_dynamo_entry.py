


'''
in this code, we have set our Event Source as "S3", and when someone upload or delete any file into defined S3 Bucket, 
then lambda function will be triggered and make that file logs entry into dynamo db...

There would be 2 trigger for S3 bucket

1st Trigger :- ObjectCreated            :- lambda will be triggered when file uploaded in bucket
2nd Trigger :- ObjectRemovedDelete      :- lambda will be triggered when file deleted from bucket

'''


import boto3
from uuid import uuid4
def lambda_handler(event, context):
    s3 = boto3.client("s3")
    dynamodb = boto3.resource('dynamodb')
    for record in event['Records']:
        bucket_name = record['s3']['bucket']['name']
        object_key = record['s3']['object']['key']
        size = record['s3']['object'].get('size', -1)
        event_name = record ['eventName']
        event_time = record['eventTime']
        dynamoTable = dynamodb.Table('s3-lambda-shiva-tbl') #s3-lambda-shiva-tbl - dynamo table name
        dynamoTable.put_item(
            Item={'id': str(uuid4()), 'Bucket': bucket_name, 'Object': object_key,'Size': size, 'Event': event_name, 'EventTime': event_time})
        
        #id :- dynamo table unique id name..
