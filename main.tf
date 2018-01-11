resource "aws_ssm_document" "install_datadog" {
  name          = "install_datadog"
  document_type = "Command"
  content       = "${data.template_file.install_datadog_document.rendered}"
}

data "template_file" "install_datadog_document" {
  template = "${file("${path.module}/documents/install_datadog.tpl")}"
}

data "template_file" "assume_role_file" {
  template = "${file("${path.module}/policies/assume_role.tpl")}"

  vars {
    datadog_external_id    = "${var.datadog_external_id}"
    datadog_aws_account_id = "${var.datadog_aws_account_id}"
  }
}

data "template_file" "monitoring_role_file" {
  template = "${file("${path.module}/policies/monitoring_role.tpl")}"
}

resource "aws_iam_role" "datadog_role" {
  name               = "datadog"
  assume_role_policy = "${data.template_file.assume_role_file.rendered}"
}

resource "aws_iam_role_policy" "datadog_role_policy" {
  name   = "datadog"
  role   = "${aws_iam_role.datadog_role.id}"
  policy = "${data.template_file.monitoring_role_file.rendered}"
}
