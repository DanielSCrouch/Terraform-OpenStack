
# User data template
data "template_file" "user_data" {
  template = file(var.USER_DATA_PATH)

  vars = {
    root_password = var.ROOT_PASSWORD
  }
}
