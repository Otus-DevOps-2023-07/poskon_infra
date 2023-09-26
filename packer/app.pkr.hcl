source "yandex" "reddit-app" {
  image_name = "reddit-app-${formatdate("MM-DD-YYYY", timestamp())}"
  image_family = "reddit-app"
  ssh_username = "ubuntu"
  platform_id = "standard-v1"
  service_account_key_file = var.service_account_key_file
  folder_id = var.folder_id
  source_image_family = var.source_image_family
  zone = var.zone
  subnet_id = var.subnet_id
  use_ipv4_nat = var.use_ipv4_nat
}

build {
  sources = ["source.yandex.reddit-app"]

  provisioner "shell" {
    inline = [
      "echo Waiting for apt-get to finish...",
      "a=1; while [ -n \"$(pgrep apt-get)\" ]; do echo $a; sleep 1s; a=$(expr $a + 1); done",
      "echo Done."
    ]
  }

  provisioner "shell" {
    name            = "ruby"
    script          = "./scripts/install_ruby.sh"
    execute_command = "sudo {{.Path}}"
  }
}
