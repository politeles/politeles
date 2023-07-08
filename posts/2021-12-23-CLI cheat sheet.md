---
aliases:
- /2021/12/23/CLI cheat sheet
categories:
- aws 
- cli
date: '2021-12-23'
description: List of commands for AWS CLI and Powershell
layout: post
title: AWS commands cheat sheet
toc: true

---

# AWS commands cheat sheet

## S3 
Max filesize upload in GUI 160GB.


 AWS CLI

## Configure

```shell
aws configure
```

## Create a bucket

```shell
aws s3api create-bucket --bucket bucketName --region frankfurt --create-bucket-configuration LocationConstraint=frankfurt
```

## list buckets

```shell
aws s3api list-buckets --query "Buckets[].Name"
```

## upload files

```shell
aws s3 cp d:\localfile s3://bucketname --recursive --exclude "*" --include "*.txt"
```

### list files

```shell
aws s3 ls s3://bucket
```

### Change storage class

```shell
aws s3 cp s3://bucketName  s3://bucketName  --storage-class GLACIER
```

### Set encryption

```shell
aws s3 cp s3://bucketName/file.txt s3://bucketName/file.txt --sse AES256
```
To apply to the entire bucket recursively

```shell
aws s3 cp s3://bucketName/ s3://bucketName/ --recursive --sse AES256
```

### Network ACL management

```shell
aws ec2 describe-vpcs --output table

aws ec2 create-network-acl --vpc-id vpc-12312321
```

To give it a name

```shell
aws ec2 create-tags --resources acl-asdasd --tags Key=Name,Value=NetworkACL1
```

to create a network rule:

```shell
aws ec2 create-network-acl-entry --network-acl-id acl-afdadf --ingress --rule-number 100 --protocol tcp --port-range From=22,To=22 --cidr-block 0.0.0.0/0 --rule-action allow
```

### Security Group in the CLI
Get the vpc ID


```shell
aws ec2 create-security-group --group-name SecurityGroup1 --description "Security Group" --vpc-id vpc-asdasd
```

we will get the group id

```shell
aws ec2 describe-security-groups --output table
```

Tag the security group

```shell
aws ec2 create-tags --resources sg-asdfasdfasdf --tags Key=Name,Value=SecGroup1

aws ec2 authorize-security-group-ingress --group-id sg-asdfasdf --protocol tcp --port 3380 --cidr 100.11.11.0/24
```


### VPC creation

```shell
aws ec2 create-vpc --cidr-block 12.0.0.0/16
```

Get the vpc id:

```shell
aws ec2 describe-vpcs
```

Add tags

```shell
aws ec2 create-tags --resources vpc-idididid --tags Key=Name,Value=VPC2

aws ec2 create-subnet --vpc-id vpc-001010101 --cidr-block 12.0.1.0/24
```

Add tags to the subnet:

```shell
aws ec2 create-tags --resources subnet-idididid --tags Key=Name,Value=Subnet2
```

### EC2 instances
We need to get the id of the AMI first

```shell
aws ec2 run-instances --image-id ami-asdasda --count 1 --instance-type t2.micro --key-name Keypair1 --security-groups-ids sg-asdfas --subnet-id subnet-asdasd
```

to update the name, we can use the tags.


### RDS on the CLI

```shell
aws rds help

aws rds describe-db-instance --output table | more

aws rds start-db-instance --db-instance-identifier database-1
```

To see the current status we can run the previous command

### IAM create user

```shell
aws create-user --user-name JGold
```

### IAM add user to group

```shell
aws iam add-user-to-group --user-name JGold ---group-name Group1
```

### IAM get user information

```shell
aws iam get-user //For your own user
aws iam get-user --user-name JGold
```

### IAM list groups for user

```shell
aws iam list-groups-for-user --user-name JGold
```

### IAM crete group

```shell
aws iam create-group --group-name Group4
```

### get group

```shell
aws iam get-group --group-name Group4
```

### IAM add user to group

```shell
aws iam add-user-to-group --user-name JGold --group-name Group4
```

### Explore costs using the GUI
 We have the following config file:

```json
{ "Dimensions": {
	"Key" : "SERVICE",
	 "Values": [ "Amazon Elastic Compute Cloud - Compute"]
	 }
}
```

```shell
aws ce get-cost-and-usage --time-period Start=2019-09-01,End=2019-12-01 
--granularity MONTHLY --metrics "BlendedCost" "UnblendedCost" "UsageQuantity" 
--group-by Type=DIMENSION,Key=SERVICE Type=TAG,Key=Environment 
--filter file://aws_cost_filter.json --output table
```


# AWS PowerShell CLI

## Initialize the connection

```powershell
initialize-awsdefaults -region us-east-1
```

## Search for a command

```powershell
Get-Command *s3b*
```

## Create a bucket

```powershell
New-S3Bucket -BucketName pp -Region us-west-2
```

### list buckets

````powershell
Get-S3Bucket
```

### upload a file

```powershell
Write-S3Object -BucketName name -File filename -Key localfile -CannedACLName Private
```

### list files

```powershell
Get-S3Object -BucketName name -Key parentFolder

Get-S3Object -BucketName name -Key parentFolder | select Key
```

### change storage class

```powershell
Copy-S3Object -BucketName bucket -Key file.txt -DestinationKey file.txt -StorageClass GLACIER
```

### set encryption 
This rule add encryption for new items in the bucket but do not change

```powershell
Set-S3BucketEncryption -BucketName bucketName -ServerSideEncryptionConfiguration_ServerSideEnctryptionRule @{ServerSideEncryptionByDefault=@{ServerSideEncryptionAlgorithm="AES256"}}
```
`
### Network ACL in Powershell

```powershell
Get-EC2VPC
```

to get the VPC ID

```powershell
New-EC2NetworkAcl -VpcId vpc-asdasd
```

to get the network ACL ID

```powershell
New-EC2Tag -ResourceId acl-asdasd -Tag @{Key="Name";Value="NetworkACL4"}
```

to add traffic:

```powershell
New-EC2NetworkAclEntry -NetworkAclId acl-sfsdf -Egress $false -RuleNumner 100 -Protocol 6 -PortRange_From 443 -PortRange_To 443 CidrBlock 199.111.111.111/24 -RuleAction allow
```

Note:
 - protocol 6 is for TCP
 - 70 is for UDP
 - 1 for ICMP


### Security group 

 - Get the vpc ID
 - Create the security group

```powershell
New-EC2SecurityGroup -GroupName secgroupname -Description "DEscription" -VpcId vpc-asdfasdf
```

It returns a sec group id

```powershell
New-EC2Tag -ResourceId sg-asfdasdf -Tag @{Key="Name";Value="SecurityGroup3"}
```

To create a rule:

```powershell
$rule1 = @{IPProtocol="tcp";FromPort="22";ToPort="22";IpRanges="199.11.11.0/24"}
```

To apply

```powershell
Grant-EC2SecurityGroupIngress -GroupId sg-fasfd -IpPermission $rule1
```

### VPC creation

```powershell
New-EC2VPC -CidrBlock 13.0.0.0/16
```

Give a name with the tags:

```powershell
New-EC2Tag -ResourceId vpc-asdasd -Tag @{Key="Name";Value="VPC3"}
```

Create a subnet:

```powershell
New-EC2Subnet -VpcId vpc-asda -CidrBlock 13.0.1.0/24
```

Give a name to the subnet

```powershell
New-EC2Tag -ResourceId subnet-asdasd -Tag @{Key="Name";Value="subnet21"}
```

### EC2 creation

```powershell
New-EC2Instance -ImageId ami-asdfasdf -MinCount 1 -MaxCount 1 -KeyName KeyPair1 -SecurityGroupId sg-asdf -InstanceType m1.small -SubnetId subnet-asfas
```

Add a tag to add a name.

### Get Status RDS Database

```powershell
Get-RDSDBInstance
```

To do a selection

```powershell
Get-RFSDBInstance | select engine,dbinstancestatus

Get-RFSDBInstance | select DBInstanceIdentifier,Engine,EngineVersion | where-object {$_.Engine -like "*mysql*"}
```

### Start RDS InstanceType

```powershell
Start-RDSDBInstance 
```

### IAM create user

```powershell
New-IAMUser -UserName MBishop
```

### Get user

```powershell
Get-IAMUser
Get-IAMUer -Username MBishop
```

### IAM add user to group

```powershell
Add-IAMUserToGroup -UserName MBishop -GroupName Group1
```

### IAM get group

```powershell
Get-AIMGroup -GroupName Group1
```

### IAM crete group

```powershell
New-IAMGroup -GroupName Group2
```

### IAM get group policies

```powershell
Get-IAMGroupPolicies -GroupName Group1
```

The attched group policies can be obtain here:

```powershell
Get-IAMattachedgrouppolicies -groupname Group1
```

### Explore costs using PowerShell

 - first, define a time interval:

```powershell
 $interval = New-Object Amazon.CostExplorer.Model.DateInterval
 $interval.Start = Get-Date (Get-Date).AddDays(-30) -Format 'yyyy-MM-dd'
 $interval.End = Get-Date -Format 'yyyy-MM-dd'
```

to get the cost:

```powershell
 $costusage = get-cecostusage -granularity monthly -timeperiod $interval -metric BlendedCost
```
 
 To check the values:

```powershell
 $costusage.resultsbytime.total.values
```