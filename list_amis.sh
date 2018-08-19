#!/bin/sh
#
#  list_amis.sh
#  ======
#  Copyright (C) 2018 n.fujita
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#  
#  ======
#  SYNOPSYS
#     $ list_amis.sh "AMI NAME"
#  DESCRIPTION
#     This shell script queries AMI-ID at each regions for the specified
#     AMI NAME, and output CSV file format to STDOUT.
#
#     AMI NAME is like 'amzn2-ami-hvm-2.0.20180622.1-x86_64-gp',
#     and is searched by Management Console or "aws ec2 describe-amis" command.
#  PREREQUISITE
#     Required commands
#        - bash
#        - aws cli(https://aws.amazon.com/jp/cli/)
#        - awk
#  ======

# The list of aws regions
# reffer https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html
code[0]='us-east-1';        descript[0]='US East (N. Virginia)';
code[1]='us-east-2';        descript[1]='US East (Ohio)';
code[2]='us-west-1';        descript[2]='US West (N. California)';
code[3]='us-west-2';        descript[3]='US West (Oregon)';
code[4]='ca-central-1';     descript[4]='Canada (Central)';
code[5]='eu-central-1';     descript[5]='EU (Frankfurt)';
code[6]='eu-west-1';        descript[6]='EU (Ireland)';
code[7]='eu-west-2';        descript[7]='EU (London)';
code[8]='eu-west-3';        descript[8]='EU (Paris)';
code[9]='ap-northeast-1';   descript[9]='Asia Pacific (Tokyo)';
code[10]='ap-northeast-2';  descript[10]='Asia Pacific (Seoul)';
code[11]='ap-northeast-3';  descript[11]='Asia Pacific (Osaka-Local)';
code[12]='ap-southeast-1';  descript[12]='Asia Pacific (Singapore)';
code[13]='ap-southeast-2';  descript[13]='Asia Pacific (Sydney)';
code[14]='ap-south-1';      descript[14]='Asia Pacific (Mumbai)';
code[15]='sa-east-1';       descript[15]='South America (São Paulo)';
LAST_NUM=15

#----------
# Initialize
#----------
# Check aws cli
if [ ! -x "$( which aws )" ]; then
    echo 'not found aws cli'
    exit 1
fi

# target AMI Name
AMI_NAME="NULL"
if [ "${1}A" = "A" ]; then
    echo "Input AMI NAME(example: amzn2-ami-hvm-2.0.20180622.1-x86_64-gp)"
    read AMI_NAME
else
    AMI_NAME=${1}
fi

#----------
# print csv
#----------
# print header
echo '"region name","region code","ImageID","VirtualizationType","Hypervisor","Architecture","ImageType","Name","Description"'

# output csv
for i in $( seq 0 ${LAST_NUM} );
do
    #set hash code

    #Query by aws cli
    aws --region ${code[$i]} --output json ec2 describe-images \
        --owners amazon \
        --filters "Name=name","Values=${AMI_NAME}" \
        --query "Images[*].{N8Th5tGkgiXXXID:ImageId,
                            N8Th5tGkgiXXXVirt:VirtualizationType,
                            N8Th5tGkgiXXXHyper:Hypervisor,
                            N8Th5tGkgiXXXArch:Architecture,
                            N8Th5tGkgiXXXType:ImageType,
                            N8Th5tGkgiXXXName:Name,
                            N8Th5tGkgiXXXDesc:Description}" \
        2>/dev/null | \
    awk -v region="${code[$i]}" -v region_descript="${descript[$i]}" '
        BEGIN {
            # set fileld separator
            FS = ": ";

            # set variables
            ImageID="\"N/A\",";
            Virtual="\"N/A\",";
            Hypervisor="\"N/A\",";
            Arch="\"N/A\",";
            ImageType="\"N/A\",";
            Name="\"N/A\",";
            Desc="\"N/A\",";

        }
        /"N8Th5tGkgiXXXID":/   { ImageID = $2; }
        /"N8Th5tGkgiXXXVirt":/ { Virtual = $2; }
        /"N8Th5tGkgiXXXHyper":/{ Hypervisor = $2; }
        /"N8Th5tGkgiXXXArch":/ { Arch = $2; }
        /"N8Th5tGkgiXXXType":/ { ImageType = $2; }
        /"N8Th5tGkgiXXXName":/ { Name = $2; }
        /"N8Th5tGkgiXXXDesc":/ { Desc = $2; }
        END{
            print "\""region_descript"\",\""region"\","ImageID""Virtual""Hypervisor""Arch""ImageType""Desc
        }';
done
