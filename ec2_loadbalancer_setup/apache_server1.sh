#!/bin/bash
# Ubuntu Apache Server (Blue)
apt-get update -y
apt-get install -y apache2  # <-- Correct package name for Ubuntu
systemctl start apache2
systemctl enable apache2

cat > /var/www/html/index.html <<EOF
<html>
<head><title>Blue Server</title></head>
<body style='background-color: #e6f3ff; text-align: center;'>
  <h1 style='color: #0066cc;'>Blue Server</h1>
  <p>Load Balancer Test - Group A</p>
  <div style='margin-top: 50px;'>
    <svg height='100' width='100'>
      <circle cx='50' cy='50' r='40' fill='#0066cc' />
    </svg>
  </div>
</body>
</html>
EOF

# Fix permissions (Ubuntu uses www-data user)
chown -R www-data:www-data /var/www/html