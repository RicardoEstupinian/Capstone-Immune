# Capstone Sistema de Inversiones
## Grupo 4
### Alumnos:
- Ricardo Bladimir Estupinian Lopez
- Paul Medrano Sanchez
- Mauricio Baca Salinas


## Requerimientos del proyecto
### Instalacion de herramientas
- AWS CLI - >= v2.13.34
- Kubernetes CLI - kubectl v4.5.4
- Helm - v3.13.0

## Creacion de componentes AWS
Para el manejo del estado de terraform (archivos .tfstate) se necesita la creacion de un bucket S3 y de una tabla de DynamoDB con los siguientes nombres:
- Bucket S3 : **capstone-terraform**
- Tabla de DynamoDB: **capstone-terraform-locks-dev**
- Partition ID DynamoDB Table: **LockID**

## Pasos de ejecucion
1. Ejecutar el codigo de la carpeta de implementacion **NETWORKING**

    **Resultado**
    - 1 VPC
    - 2 Subredes privadas
    - 2 Subredes públicas
2. Ejecutar codigo de la carpeta de implementacion **DATABASE/POSTGRES**

   **Resultado**
      - Base de datos AURORA PostgreSQL Serverless
   
3. Ejecutar codigo de la carpeta de implementacion **SECURITY/ACM**

   **Resultado**
    - Certificado TLS/SSL con validacion mediante DNS.
   
4. Ejecutar codigo de la carpeta de implementacion **SECURITY/COGNITO**

    **Resultado**
    - Pool de cognito configurado con un UserGroup creado.

5. Ejecutar codigo de la carpeta de implementacion **COMPUTE/ECR**

   **Resultado**
    - Repositorios ECR para almacenar imagenes Docker de los microservicios

6. Ejecutar codigo de la carpeta de implementacion **COMPUTE/EKS-CLUSTER**

   **Resultado**
   - Cluster EKS configurado

7. Ejecutar los siguientes comandos para el correcto funcionamiento de los pods **CORE DNS**. Documentacion AWS: https://docs.aws.amazon.com/eks/latest/userguide/fargate-getting-started.html

   **Comandos a ejecutar:**
   - kubectl patch deployment coredns -n kube-system --type json -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
   - kubectl rollout restart -n kube-system deployment coredns
     
8. Ejecutar codigo de la carpeta de implementacion **COMPUTE/SECURITY-GROUP-PODS**

   **Resultado**
   - Lista de security groups para los microservicios
   
9. Ejecutar objetos Kubernets para activar logs en **Cloudwatch**.

   **Crear objetos K8s:**
   - k8s/aws-observability-namespace.yaml
   - k8s/aws-logging-cloudwatch-configmap.yaml

**NOTA:** Se adjunta el ejemplo de un DEPLOYMENT con su respectivo SERVICE y SECURITY GROUP asociado para probar la solucion. Ademas se adjunta el ejemplo de un Ingress que aprovisiona automaticamente un ALB.
