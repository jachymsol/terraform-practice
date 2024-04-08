# This is using a LoadBalancer service

resource "kubernetes_deployment_v1" "name" {
  metadata {
    name = "nginx-deployment"
  }
  spec {
    selector {
      match_labels = { "app" : "nginx" }
    }
    replicas = 2
    template {
      metadata {
        labels = { "app" : "nginx" }
      }
      spec {
        container {
          name  = "nginx"
          image = "nginx:1.14.2"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}


/*
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
*/

resource "kubernetes_service_v1" "nginx-service" {
  metadata {
    name = "nginx-service"
  }
  spec {
    type     = "LoadBalancer"
    selector = { "app" : "nginx" }
    port {
      port        = 8000
      target_port = 80
      protocol    = "TCP"
    }
  }
}

/*
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  ports:
  - port: 8000 # the port that this service should serve on
    # the container on each pod to connect to, can be a name
    # (e.g. 'www') or a number (e.g. 80)
    targetPort: 80
    protocol: TCP
  # just like the selector in the deployment,
  # but this time it identifies the set of pods to load balance
  # traffic to.
  selector:
    app: nginx
*/
