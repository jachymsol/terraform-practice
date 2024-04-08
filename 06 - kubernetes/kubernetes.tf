resource "kubernetes_namespace" "tf_namespace" {
  metadata {
    name = "tf-namespace"
    annotations = {
      name = "tf-namespace"
    }
    labels = {
        myLabel = "label-value"
    }
  }
}
