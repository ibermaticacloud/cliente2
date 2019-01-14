
#####  CREDENTIALS   ######
#### Add credentials ######

aws_access_key = "<access_key>"

aws_secret_key = "<secretet_key>"

aws_region = "eu-west-1"


##### VPC  #######

###vpc_cidr_block = "10.0.0.0/16"###
vpc_cidr_block = "10.5.0.0/16"


######  INSTANCES   #######

####aws_amis = "<id_ami>"#####
aws_amis = "ami-55bdb82c"

instance_count = "1"

instance_type = "t2.micro"

###key_name = "<key_name>"####
key_name = "AWS_TESTAccount"


####subnet_cidr = "10.0.1.0/24"####
subnet_cidr = "10.5.1.0/24"

route_table_destination_cidr = "0.0.0.0/0"


##### PROYECT NAME  #######

Proyect_name = "TestAWS"
