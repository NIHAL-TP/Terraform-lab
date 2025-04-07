# Test load balancing (run multiple times)
while true; do 
  curl -s YOUR_ALB_DNS | grep -E "Blue Server|Green Server";
  sleep 1;
done

# Sample output (alternating):
# <h1 style='color: #0066cc;'>Blue Server</h1>
# <h1 style='color: #009933;'>Green Server</h1>