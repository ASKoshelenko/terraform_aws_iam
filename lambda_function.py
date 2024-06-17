import json
import boto3
import os
from datetime import datetime

s3_client = boto3.client('s3')

class DateTimeEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.isoformat()
        return json.JSONEncoder.default(self, obj)

def lambda_handler(event, context):
    action = event.get('action')
    bucket_name = event.get('bucket_name')

    if action == 'create':
        response = s3_client.create_bucket(
            Bucket=bucket_name,
            CreateBucketConfiguration={
                'LocationConstraint': os.environ['AWS_REGION']
            }
        )
        return json.dumps(response, cls=DateTimeEncoder)
    elif action == 'delete':
        response = s3_client.delete_bucket(Bucket=bucket_name)
        return json.dumps(response, cls=DateTimeEncoder)
    elif action == 'list':
        response = s3_client.list_buckets()
        return json.dumps(response['Buckets'], cls=DateTimeEncoder)
    else:
        return {
            'statusCode': 400,
            'body': json.dumps('Invalid action specified')
        }