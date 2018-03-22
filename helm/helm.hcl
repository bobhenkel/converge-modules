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


task "apply" {
  check = <<EOF
set -x -v -e
if [ {{param `mode`}} = "install" ]
then
    exit 1
else
    exit 0
fi
EOF
  apply = <<EOF
set -x -v
echo "kube-crew DEBUG"
helm version --tiller-namespace {{param `tiller-namespace`}}
echo "kube-crew DEBUG"
helm upgrade --force --recreate-pods --version {{param `chart-version`}} --install {{param `release-name`}} {{param `chart`}} --tiller-namespace {{param `tiller-namespace`}} --namespace {{param `install-to-namespace`}} -f {{param `values-file`}}
EOF
}

task "delete" {
  check = <<EOF
#!/bin/bash
set -x -v -e
if [ {{param `mode`}} = "delete" ]
then
    if helm list {{param `release-name`}} --tiller-namespace bhenkel | grep -q -w {{param `release-name`}}; then
       false
    else
       true
    fi
fi
EOF
  apply = <<EOF
set -x -v -e
if [ {{param `mode`}} = "delete" ]
then
  set -x -v
  echo "kube-crew DEBUG";helm version --tiller-namespace {{param `tiller-namespace`}}
  helm delete {{param `release-name`}} --purge --tiller-namespace {{param `tiller-namespace`}}
fi
EOF

}
