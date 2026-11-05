import json
import os
import re
import uuid
import time
import boto3
from decimal import Decimal

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])

MAX_NAME_LEN = 60
MAX_COMMENT_LEN = 600
TAG_RE = re.compile(r"<[^>]*>")


def _response(status_code, body_obj):
    return {
        "statusCode": status_code,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(body_obj, default=str),
    }


def _clean(text):
    return TAG_RE.sub("", text).strip()


def handle_get():
    result = table.scan()
    items = result.get("Items", [])
    items.sort(key=lambda r: r.get("createdAt", ""), reverse=True)
    reviews = [
        {
            "reviewId": i["reviewId"],
            "name": i["name"],
            "rating": int(i["rating"]),
            "comment": i["comment"],
            "createdAt": i["createdAt"],
        }
        for i in items[:100]
    ]
    count = len(items)
    average_rating = round(sum(int(i["rating"]) for i in items) / count, 1) if count else 0.0
    return _response(200, {"reviews": reviews, "count": count, "averageRating": average_rating})


def handle_post(raw_body):
    try:
        data = json.loads(raw_body or "{}")
    except json.JSONDecodeError:
        return _response(400, {"error": "Invalid JSON body"})

    name = _clean(str(data.get("name", "")))
    comment = _clean(str(data.get("comment", "")))
    rating = data.get("rating")

    if not name or len(name) > MAX_NAME_LEN:
        return _response(400, {"error": f"Name is required (max {MAX_NAME_LEN} chars)"})
    if not comment or len(comment) > MAX_COMMENT_LEN:
        return _response(400, {"error": f"Comment is required (max {MAX_COMMENT_LEN} chars)"})
    try:
        rating = int(rating)
    except (TypeError, ValueError):
        return _response(400, {"error": "Rating must be an integer 1-5"})
    if rating < 1 or rating > 5:
        return _response(400, {"error": "Rating must be between 1 and 5"})

    review_id = str(uuid.uuid4())
    created_at = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())

    table.put_item(
        Item={
            "reviewId": review_id,
            "name": name,
            "comment": comment,
            "rating": Decimal(rating),
            "createdAt": created_at,
        }
    )

    return _response(
        201,
        {
            "reviewId": review_id,
            "name": name,
            "rating": rating,
            "comment": comment,
            "createdAt": created_at,
        },
    )


def lambda_handler(event, context):
    method = event.get("requestContext", {}).get("http", {}).get("method", "GET")

    try:
        if method == "OPTIONS":
            return {"statusCode": 204, "headers": {}, "body": ""}
        if method == "GET":
            return handle_get()
        if method == "POST":
            return handle_post(event.get("body"))
        return _response(405, {"error": "Method not allowed"})
    except Exception as exc:
        print(f"Unhandled error: {exc}")
        return _response(500, {"error": "Internal server error"})
