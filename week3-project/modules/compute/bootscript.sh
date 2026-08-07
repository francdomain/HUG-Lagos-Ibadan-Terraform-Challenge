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
  <title>HUG Lagos/Ibadan Terraform Challenge - Week Three</title>
  <style>
    * { box-sizing: border-box; }
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
      color: #fff;
    }
    .card {
      background: rgba(255, 255, 255, 0.95);
      color: #1f2937;
      padding: 2.5rem 3rem;
      border-radius: 16px;
      box-shadow: 0 10px 40px rgba(0,0,0,0.2);
      text-align: center;
      max-width: 520px;
      width: 90%;
    }
    h1 {
      margin: 0 0 0.75rem;
      font-size: 2rem;
    }
    .badge {
      display: inline-block;
      background: #10b981;
      color: #fff;
      padding: 0.35rem 0.9rem;
      border-radius: 999px;
      font-size: 0.85rem;
      font-weight: 600;
      margin-bottom: 1rem;
    }
    p {
      font-size: 1.1rem;
      line-height: 1.6;
      color: #4b5563;
      margin: 0.5rem 0;
    }
    .tier-list {
      text-align: left;
      margin: 1.5rem 0 0;
      padding: 0;
      list-style: none;
    }
    .tier-list li {
      padding: 0.5rem 0;
      border-bottom: 1px solid #e5e7eb;
    }
    .tier-list li:last-child { border-bottom: none; }
    .tier-list strong { color: #1e40af; }
  </style>
</head>
<body>
  <div class="card">
    <div class="badge">Two-Tier Deployment</div>
    <h1>${user_full_name}</h1>
    <p>HUG Lagos/Ibadan Terraform Challenge - Week Three</p>
    <ul class="tier-list">
      <li><strong>Public Tier:</strong> EC2 web server running Nginx</li>
      <li><strong>Private Tier:</strong> RDS database with no public access</li>
      <li><strong>Networking:</strong> VPC, public/private subnets, NAT & Internet Gateways</li>
      <li><strong>Security:</strong> Least-privilege security groups</li>
    </ul>
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
