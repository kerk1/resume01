resource "aws_dynamodb_table" "how-many-users-dynamodb" {
  name           = "VisitorCounter"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "ID"
  attribute {
    name = "ID"
    type = "N"
  }
}


resource "aws_dynamodb_table_item" "counterItem" {
  table_name = aws_dynamodb_table.how-many-users-dynamodb.name
  hash_key   = aws_dynamodb_table.how-many-users-dynamodb.hash_key

  item = <<ITEM
{
  "ID": {"N": "123"},
  "VisitorCounter": {"N": "0"}
}
ITEM
}
