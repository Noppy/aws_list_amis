# Name
list_amis.sh  :list Amazon Machine Image(AMI) IDs
# SYNOPSYS
```
liste_amis.sh "AMI NAME"
```
# DESCRIPTION
This shell script queries AMI-ID at each regions for the specified `AMI NAME`, and output CSV file format to STDOUT.

`AMI NAME` is like 'amzn2-ami-hvm-2.0.20180622.1-x86_64-gp', and is searched by Management Console or "aws ec2 describe-amis" command.
# PREREQUISITE
## operability confirmed OSs
- Linux
- MacOS
## Required Commands
- bash
- aws cli(https://aws.amazon.com/jp/cli/)
- awk

# How to Use
## Setup
- check aws cli
Confirm whether the AWS command is available.
```
aws ec2 describe-instances
```
- git clone this repository.
```
git clone https://github.com/Noppy/aws_list_amis.git
```
- move the shell script to a suitable directory
```
mv aws_list_amis/list_amis.sh DEST_DIRECTORY_PATH
```
## Usage
- Get AMI Name
Check and get the name of the AMI which you would like to search.
The following figure is an example to confirm with the management console.
![check AMI name by Management Console](https://user-images.githubusercontent.com/2317667/44307628-5f334f00-a3e0-11e8-93be-9bb618ffe695.png)
- Execute the shell script
```
./list_amis.sh "Microsoft Windows Server 2012 R2 with SQL Server 2016 Web" > Win_SQL_WebEdition.csv
```