data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name

  user_data = templatefile("${path.module}/bootscript.sh", {
    user_full_name = var.user_full_name
    ssh_public_key = var.public_key_path != null ? file(var.public_key_path) : ""
  })

  tags = merge(var.tags, {
    Name        = "${var.name_prefix}-web-server"
    Environment = var.environment
  })
}
