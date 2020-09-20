# az_terraform_handson
az_terraform_handson

Learning Notes from my desk: Aug.3
===================================

INSTALLATION
=============
$ curl -O https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip

$ sudo unzip terraform_0.12.29_linux_amd64.zip -d /mnt/d/terraform/

$ rm terraform_0.12.29_linux_amd64.zip (optional)

$ cd /mnt/d/terraform/ 

SETTING STAGE 
=============
$ terraform init -backend-config="storage_account_name=mikkystorage" -backend-config="container_name=tfstate" -backend-config="access_key=yoursecret" -backend-config="key=codelab.microsoft.tfstate"

USAGE 
=============
$ terraform --version

$ terraform init (very first cmd to execute; this cmd will install modules, backend and provider plugins)

$ terraform get -update=true 

$ terraform plan (writes a plan to apply to target provider say Azure/AWs.etc; allows user to see the actions before
commiting the permanent changes at provider side) 

$ terraform plan -out plan.tfplan

$ terraform apply

$ terraform apply plan.tfplan (for complex scenarios, persist the execution plan to a file, and apply the plan o/p)

$ terraform apply -auto-approve (same as -y for apt install) ; it will auto approve instead nagging 'yes' consent 

$ terraform destroy (delete all resources, no way to reverse) 

$ terraform plan -destroy 

$ terraform plan -destroy -out plan.destroy.rfplan 

$ terraform graph | dot -Tpng > mydeployment.png 

$ terraform validate

$ terraform providers (displays the currently configured cloud provider)

STATE
=============
$ terraform state pull > terraform.tfstate (pulls the remote state to local copy)

$ terraform state push 

WORKSPACE 
=============
$ terraform workspace new dev 

$ terraform workspace select dev 

$ terraform workspace list 

$ terraform workspace show 

VARIOUS WAYST O DECLARE AND USE VARIABLES AND IN TERRAFORM BLOCKS
==================================================================
src: https://www.terraform.io/docs/configuration/variables.html#tuple-lt-type-gt-

option1: (simple tf file) 
-------------------------
variables.tf

variable "location"{
default = "uswest2"
}

option2: (simple command line) 
-----------------------------
terraform apply -var="location=uswest2"

option3: (flat file with tfvar extension)
-------------------------------------------------------------
terraform.tfvars (exactly the same name) 
terraform.tfvars.json
.auto.tfvars or .auto.tfvars.json
 
location="uswest2"

option4: (flat file passed in console arg)
------------------------------------------------------------------
sensitive.tfvars 
location="uswest2"

cmd> terraform apply -var-file="sensitive.tfvars" 

option5: (ENV variable setting)
-------------------------------------
export TF_VAR_location="uswest2"  (defaults to literal, need not to be quoted) 
$ export TF_VAR_image_id=ami-abc123

option6: (use unset to remove from env but prompted during 'apply' 
----------------------------------------------------------------------
unset TF_VAR_location 
> enter the value in GUI 

IMP: TF loads variables in the following order, with later sources taking precedence over earlier ones:
a. Environment variables
b. The terraform.tfvars file, if present.
c. The terraform.tfvars.json file, if present.
d. Any *.auto.tfvars or *.auto.tfvars.json files 
e. Any -var and -var-file options on the command line 

