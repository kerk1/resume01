import json
import boto3


def get(dynamodb=None):
    if not dynamodb:
        dynamodb = boto3.resource('dynamodb')

    table = dynamodb.Table('VisitorCounter')
    response = table.scan()

    return response["Items"][0]["VisitorCounter"]  # ["Items"]  #["VisitorCounter"]


def lambda_handler(event, context):
    # TODO implement

    dynamodb = boto3.resource('dynamodb')
    howManyVisitorsBeforeUpdate = get(dynamodb)
    howManyVisitorsBeforeUpdate = int(howManyVisitorsBeforeUpdate)
    howManyVisitorsAfterUpdate = howManyVisitorsBeforeUpdate + 1
    howManyVisitorsAfterUpdate = str(howManyVisitorsAfterUpdate)
    table = dynamodb.Table('VisitorCounter')
    key = {'ID': {'N': '123'}}
    table.update_item(
        Key={'ID': 123},
        UpdateExpression="set  VisitorCounter = :c",
        ExpressionAttributeValues={
            ':c': howManyVisitorsAfterUpdate
        },
        ReturnValues="UPDATED_NEW"
    )

    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': 'Content-Type',
            "Access-Control-Allow-Origin": "*",
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        'body': get()
    }