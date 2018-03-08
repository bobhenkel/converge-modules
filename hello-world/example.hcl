param "message" {
  default = "Hello from another module!"
}

module "https://raw.githubusercontent.com/bobhenkel/converge-modules/b330d33a991a130627dcbaf82bf7ab365a268dfc/hello-world/hello-world.hcl" "hello-world1" {
  params = {
    message = "{{param `message`}}"
  }
}

module "https://raw.githubusercontent.com/bobhenkel/converge-modules/b330d33a991a130627dcbaf82bf7ab365a268dfc/hello-world/hello-world.hcl" "hello-world2" {
}
