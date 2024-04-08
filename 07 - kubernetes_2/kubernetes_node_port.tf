# This is using a NodePort service and an ingress with External Load Balancer

/*
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment-50000
spec:
  selector:
    matchLabels:
      app: metrics
      department: engineering
  replicas: 3
  template:
    metadata:
      labels:
        app: metrics
        department: engineering
    spec:
      containers:
      - name: hello
        image: "us-docker.pkg.dev/google-samples/containers/gke/hello-app:2.0"
        env:
        - name: "PORT"
          value: "50000"
*/

resource "kubernetes_deployment_v1" "node_port_deployment" {
  metadata {
    name = "my-deployment-50000"
  }
  spec {
    selector {
      match_labels = { "app" : "metrics", "department" : "engineering" }
    }
    replicas = 3
    template {
      metadata {
        labels = { "app" : "metrics", "department" : "engineering" }
      }
      spec {
        container {
          name  = "hello"
          image = "us-docker.pkg.dev/google-samples/containers/gke/hello-app:2.0"
          env {
            name  = "PORT"
            value = 50000
          }
        }
      }
    }
  }
}

/*
apiVersion: v1
kind: Service
metadata:
  name: my-np-service
spec:
  type: NodePort
  selector:
    app: metrics
    department: engineering
  ports:
  - protocol: TCP
    port: 80
    targetPort: 50000
*/

resource "kubernetes_service_v1" "node_port_service" {
  metadata {
    name = "my-np-service"
  }
  spec {
    type     = "NodePort"
    selector = { "app" : "metrics", "department" : "engineering" }
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 50000
    }
  }
}

resource "kubernetes_ingress_v1" "node_port_ingress" {
  metadata {
    name = "my-np-ingress"
  }
  spec {
    rule {
      http {
        path {
          path = "/node_port"
          backend {
            service {
              name = "my-np-service"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
