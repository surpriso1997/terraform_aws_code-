r: 
	terraform init -reconfigure 

a: 
	terraform apply

p:
	terraform plan 

i:
	terraform init 

c:
	rm -rf .terraform/
ia: 
	terraform init&& terraform apply 