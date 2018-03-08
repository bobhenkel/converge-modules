param "message" {
  default = "hello world"
}

task "render" {
  check = "exit 1"
  apply = "echo '{{param `message`}}'"
}

