#!/bin/bash

# Define Tomcat URL dynamically
TOMURL=$(curl -s https://tomcat.apache.org/download-11.cgi | grep -Eo 'https://dlcdn.apache.org/tomcat/tomcat-11/v[0-9.]+/bin/apache-tomcat-[0-9.]+.tar.gz' | head -n 1)

# Install required packages
dnf -y install java-17-openjdk java-17-openjdk-devel git maven wget

# Download and extract Tomcat
cd /tmp/
wget $TOMURL -O tomcatbin.tar.gz
EXTOUT=$(tar xzvf tomcatbin.tar.gz)
TOMDIR=$(echo $EXTOUT | head -n 1 | cut -d '/' -f1)

# Create Tomcat user and move files
useradd --shell /sbin/nologin tomcat
mv /tmp/$TOMDIR /usr/local/tomcat
chown -R tomcat:tomcat /usr/local/tomcat

# Create systemd service file for Tomcat
cat <<EOT > /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat
After=network.target

[Service]
User=tomcat
Group=tomcat

WorkingDirectory=/usr/local/tomcat

Environment=JAVA_HOME=/usr/lib/jvm/java-17-openjdk
Environment=CATALINA_HOME=/usr/local/tomcat
Environment=CATALINA_BASE=/usr/local/tomcat
Environment=CATALINA_PID=/var/tomcat/run/tomcat.pid

ExecStart=/usr/local/tomcat/bin/catalina.sh run
ExecStop=/usr/local/tomcat/bin/shutdown.sh

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOT

# Reload systemd and start Tomcat
mkdir -p /var/tomcat/run
chown -R tomcat:tomcat /var/tomcat
systemctl daemon-reload
systemctl enable tomcat
systemctl start tomcat

# Clone and build the project
git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mvn install

# Deploy WAR file
if [ -f target/vprofile-v2.war ]; then
    systemctl stop tomcat
    rm -rf /usr/local/tomcat/webapps/ROOT*
    cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
    systemctl start tomcat
else
    echo "WAR file not found. Build failed!"
    exit 1
fi

# Configure firewall
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload

echo "Tomcat setup and application deployment complete!"
