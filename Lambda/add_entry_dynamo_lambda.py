import json, boto3, logging
from uuid import uuid4

dynamo_res = boto3.resource("dynamodb")
dynamo_tbl = dynamo_res.Table("shiva_tbl")

def lambda_handler(event, context):

    #event['id'] = str(uuid4())  #appending id in event dict (id is primary key in dynmamo table)
    

    try:
        dynamo_tbl.put_item(Item=event)
        return {"code": 200, "message": "Customer added succesfully"}
        
    except Exception as err:
        return {"code": 404, "message": err}
    
