param "chart" {
  default = ""
}

param "chart-version" {
  default = ""
}

param "mode" {
  default = "install" #1 install/update or delete
}

param "release-name" {
  default = ""
}

param "tiller-namespace" {
  default = ""
}

param "install-to-namespace" {
  default = ""
}

param "values-file" {
  default = ""
}

module "https://raw.githubusercontent.com/bobhenkel/converge-modules/master/helm/helm.hcl" "tiller" {
  params {
    chart                = "chartmuseum/tiller",
    chart-version        = "0.1.0",
    mode                 = "install",#either install or delete
    release-name         = "tiller",
    tiller-namespace     = "kube-tools",
    install-to-namespace = "bhenkel",
    values-file          = "tiller.yaml"#helm chart values.yaml file.
  }
}
