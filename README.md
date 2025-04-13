1/ Deploy environment with terraform

cd terraform
terraform apply --auto-approve

2/ Create secrets for RDS
cd apache-airflow
kubectl apply -f airflow-metadata-secret.yaml 

3/ Deploy dummy app

aws ecr create-repository --repository-name rick-api --region us-west-2
# build and push to ecr
helm install rick-api ./rick_and_morty_app