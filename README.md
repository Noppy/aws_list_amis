# Name
list_amis.sh  :list Amazon Machine Images ImageID
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
### check aws cli
Confirm whether the AWS command is available.
```
aws ec2 describe-instances
```
### git clone this repository.
```
git clone https://github.com/Noppy/aws_list_amis.git
```
### move the shell script to a suitable directory
```
mv aws_list_amis/list_amis.sh DEST_DIRECTORY_PATH
```
## Usage
### Get AMI Name
Check and get the name of the AMI which you would like to search.  
The following figure is an example to confirm with the management console  
(Note!: Use "Community AMIs" tab).
![check AMI name by Management Console](https://user-images.githubusercontent.com/2317667/44307780-b850b200-a3e3-11e8-8f69-442a69193cc5.png)
### Execute the shell script
```
./list_amis.sh "Windows_Server-2012-R2_RTM-English-64Bit-SQL_2016_SP1_Web-2018.07.11" > Win_SQL_WebEdition.csv
```
