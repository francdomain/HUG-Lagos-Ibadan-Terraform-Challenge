#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get upgrade -y
apt-get install -y nginx

cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HUG Lagos/Ibadan Terraform Challenge - Week Two</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      margin: 0;
      background: #f4f7fa;
      color: #111;
    }
    .card {
      background: #fffdd0;
      padding: 2rem 3rem;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
      text-align: center;
    }
    h1 {
      margin-bottom: 0.5rem;
    }
    p {
      font-size: 1.2rem;
      color: #555;
    }
  </style>
</head>
<body>
  <div class="card">
    <h1>${user_full_name}</h1>
    <p>HUG Lagos/Ibadan Terraform Challenge - Week Two</p>
  </div>
</body>
</html>
EOF

if [ -n "${ssh_public_key}" ]; then
  mkdir -p /home/ubuntu/.ssh
  cat >> /home/ubuntu/.ssh/authorized_keys <<SSHEOF
${ssh_public_key}
SSHEOF
  chmod 700 /home/ubuntu/.ssh
  chmod 600 /home/ubuntu/.ssh/authorized_keys
  chown -R ubuntu:ubuntu /home/ubuntu/.ssh
fi

systemctl enable nginx
systemctl restart nginx
