param "chart" {
  default = ""
}

param "chart-version" {
  default = ""
}

// param "install-mode" {
//   default = "1" #1 update or 0 delete
// }
//
// param "delete-mode" {
//   default = "0" #1 update or 0 delete
// }

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
helm upgrade --force --recreate-pods --wait --version {{param `chart-version`}} --install {{param `release-name`}} {{param `chart`}} --tiller-namespace {{param `tiller-namespace`}} --namespace {{param `install-to-namespace`}} -f {{param `values-file`}}
EOF
}

// task "delete" {
//   check = "exit {{param `delete-mode`}}" #Skips apply flip to 1 to have apply run
//   apply = "helm delete {{param `release-name`}} --purge --tiller-namespace {{param `tiller-namespace`}}"
// }

// task "delete-check" {
//   check = <<EOF
// if [ {{param `mode`}} = "delete" ]
// then
//     helm list {{param `release-name`}} --tiller-namespace {{param `tiller-namespace`}}  | grep -w {{param `release-name`}}
// else
//     exit 0
// fi
// EOF
//   apply = "echo $?" #If this runs then theres no release to delete because that means a value 1 or the release was not found
// }

// task "echo" {
//   check = "exit $(echo {{lookup `task.delete-check.status.stdout`}})"
//   apply = "helm delete {{param `release-name`}} --purge --tiller-namespace {{param `tiller-namespace`}}"
//   depends = ["task.delete-check"]
// }

task "delete" {
  check = <<EOF
if [ {{param `mode`}} = "delete" ]
then
    helm list {{param `release-name`}} --tiller-namespace {{param `tiller-namespace`}}  | grep -w {{param `release-name`}}
    if [ $? -eq 0 ]
    then
       exit 1
    fi
else
    exit 0
fi
EOF
  apply = <<EOF
if [ {{param `mode`}} = "delete" ]
then
  set -x -v
  echo "kube-crew DEBUG";helm version --tiller-namespace {{param `tiller-namespace`}}
  helm delete {{param `release-name`}} --purge --tiller-namespace {{param `tiller-namespace`}}
fi
EOF

}

// task "delete" {
//   check = <<EOF
// if [ {{param `delete-mode`}} = 1] ; then
// helm list {{param `release-name`}} --tiller-namespace {{param `tiller-namespace`}}  | grep {{param `release-name`}}
// fi
// EOF
//   apply = "helm delete {{param `release-name`}} --purge --tiller-namespace {{param `tiller-namespace`}}"
// }
