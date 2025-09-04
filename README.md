Web service: deployed to App Service using a container image (faster deploys, scaling, integration with ACR). App Service handles TLS termination if you add a custom domain and certificate.

Message broker: self-hosted RabbitMQ on a VM for maximum compatibility. For production consider a managed alternative (Azure Service Bus or a managed RabbitMQ offering).

Security: Key Vault holds sensitive values. The App Service uses a system-assigned identity to fetch secrets securely if you wire access policies.

Bastion: recommended to avoid public SSH. Add a bastion module to access VMs privately.



Deploy
1. cd live/demo

2. terraform init

3. terraform plan -var-file=terraform.tfvars

4. terraform apply -var-file=terraform.tfvars