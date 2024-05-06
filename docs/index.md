## teste-repo

```mermaid
flowchart TD;
    A1[ecs-services/staging/CMS] -->|Commit| B;
    A2[ecs-services/production/CMS] -->|Commit| B;
    B[SERVICE.json] -->|Com um PR feito para a branch main <br> o GIT Actions executa o terraform para subir <br> o serivço no Cluster ECS correspondente.| C{Action}
    C --> D[Cluster ECS STG];
    C --> F[Cluster ECS PROD];
```
