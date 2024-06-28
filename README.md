# aws-terraform-java-lambdas
AWS Serverless REST API using Java and Terraform.

## Prerequisites

- AWS CLI
- Terraform
- Maven

## Build and deploy

```
cd lambda-functions
mvn clean package
cd ../terraform
terraform init
terraform apply
```

## Destroy

```
terraform destroy
```


## Project creation steps

### Create Java project

```
mvn archetype:generate \
-DgroupId=com.example \
-DartifactId=lambda-functions \
-DarchetypeArtifactId=maven-archetype-quickstart \
-DinteractiveMode=false
```

## Sample requests

```
curl --location --request POST 'https://xxxxxx.execute-api.us-east-1.amazonaws.com/prod/calc' \
--header 'Content-Type: text/plain' \
--data-raw 'Amit'
```

```
curl --location --request POST 'https://xxxxxx.execute-api.us-east-1.amazonaws.com/prod/calc' \
--header 'Content-Type: application/json' \
--data-raw '{
    "a": 1,
    "b": 2,
    "oper": "add"
}'
```

## Project Maintenance

### Update dependencies

```
mvn versions:display-dependency-updates
mvn versions:display-plugin-updates
```

### Update dependencies

```
mvn versions:use-latest-versions
```

### Update parent

```
mvn versions:update-parent
```

### Update project

```
mvn versions:update-properties
```
