#!/bin/bash
set -e

# Install Java and dependencies
apt-get update && apt-get install -y openjdk-17-jre-headless curl gnupg

curl -fsSL https://releases.jfrog.io/artifactory/api/gpg/key/public | gpg --dearmor -o /usr/share/keyrings/jfrog.gpg
echo "deb [signed-by=/usr/share/keyrings/jfrog.gpg] https://releases.jfrog.io/artifactory/artifactory-debs jammy main" \
    > /etc/apt/sources.list.d/jfrog.list

apt-get update
apt-get install -y jfrog-artifactory-oss

# Create systemd service
cat <<EOF > /etc/systemd/system/artifactory.service
[Unit]
Description=JFrog Artifactory
After=network.target

[Service]
Type=forking
User=artifactory
ExecStart=/opt/artifactory/app/bin/artifactory.sh start
ExecStop=/opt/artifactory/app/bin/artifactory.sh stop
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl enable artifactory