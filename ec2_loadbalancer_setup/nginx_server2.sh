#!/bin/bash
# Ubuntu User Data - Web Server 2
apt-get update -y
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx

# Create custom index page
cat > /var/www/html/index.html <<EOF
<html>
<head><title>Green Server</title></head>
<body style='background-color: #e6ffe6; text-align: center;'>
  <h1 style='color: #009933;'>Green Server</h1>
  <p>Load Balancer Test - Group B</p>
  <div style='margin-top: 50px;'>
    <svg height='100' width='100'>
      <circle cx='50' cy='50' r='40' fill='#009933' />
    </svg>
  </div>
</body>
</html>
EOF

# Fix permissions (Ubuntu uses www-data user)
chown -R www-data:www-data /var/www/html