module "https://raw.githubusercontent.com/bobhenkel/converge-modules/f6b77863cf2b0ed994006515194affe6f817eb4c/helm/helm.hcl" "buildkite-agent1" {
  params {
    chart                = "stable/buildkite",
    chart-version        = "0.2.0",
    mode                 = "install",#either install or delete
    release-name         = "buildkite-agent1",
    tiller-namespace     = "default",
    install-to-namespace = "default",
    values-file          = "buildkite-agent1.yaml"#helm chart values.yaml file.
  }
}

module "https://raw.githubusercontent.com/bobhenkel/converge-modules/f6b77863cf2b0ed994006515194affe6f817eb4c/helm/helm.hcl" "buildkite-agent2" {
  params {
    chart                = "stable/buildkite",
    chart-version        = "0.2.1",
    mode                 = "install",
    release-name         = "buildkite-agent2",
    tiller-namespace     = "default",
    install-to-namespace = "default",
    values-file          = "buildkite-agent2.yaml"#helm chart values.yaml file.
  }
}

