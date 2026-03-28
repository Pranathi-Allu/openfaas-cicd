terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "openfaas" {
  metadata {
    name = "openfaas"
  }
}

resource "kubernetes_namespace" "openfaas_fn" {
  metadata {
    name = "openfaas-fn"
  }
}

resource "kubernetes_deployment" "hello_python" {
  metadata {
    name      = "hello-python"
    namespace = "openfaas-fn"
    labels = {
      app = "hello-python"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "hello-python"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-python"
        }
      }

      spec {
        container {
          image = "allupranathi10/hello-python:latest"
          name  = "hello-python"

          port {
            container_port = 8080
          }
        }
      }
    }
  }

  depends_on = [kubernetes_namespace.openfaas_fn]
}

resource "kubernetes_service" "hello_python" {
  metadata {
    name      = "hello-python"
    namespace = "openfaas-fn"
  }

  spec {
    selector = {
      app = "hello-python"
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }

  depends_on = [kubernetes_deployment.hello_python]
}
