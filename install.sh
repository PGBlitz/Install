#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

# Upgrade
#apt-get update -y

# apt-get upgrade -y # causes problems when you forced on an interactive screen
#apt-get install software-properties-common git zip unzip dialog -y

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  NOTICE: PGBlitz Version 9 - Installer
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
By installing, you agreeing to the terms and conditions of the GNUv3 License!

Thanks To: The Community, Staff, Noobs, Sponsors/Donors, Community, & You!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Please Standby!
EOF
sleep 3

# Make Critical Folders
mkdir -p /pg /pg/logs /pg/var /pg/data /pg/stage /pg/logs /pg/tmp
chmod 775 /pg /pg/logs /pg/var /pg/data /pg/stage /pg/logs /pg/tmp
chown 1000:1000 /pg /pg/logs /pg/var /pg/data /pg/stage /pg/logs /pg/tmp

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Conducting OS Checks - Standby
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
apt-get install lsb-release -yqq 2>&1 >> /dev/null
	export DEBIAN_FRONTEND=noninteractive
apt-get install software-properties-common -yqq 2>&1 >> /dev/null
	export DEBIAN_FRONTEND=noninteractive

entirelabel=$(lsb_release -sd)
echo "$entirelabel" > /pg/var/entirelabel

shortlabel=$(lsb_release -si)
echo "$shortlabel" > /pg/var/shortlabel

ipinfo=$(hostname -I | awk '{print $1}')
echo "$ipinfo" > /pg/var/ip.info

if [[ "$oslabel" == "Debian" ]]; then
	add-apt-repository main 2>&1 >> /dev/null
	add-apt-repository non-free 2>&1 >> /dev/null
	add-apt-repository contrib 2>&1 >> /dev/null
elif [[ "$oslabel" == "Ubuntu" ]]; then
	add-apt-repository main 2>&1 >> /dev/null
	add-apt-repository universe 2>&1 >> /dev/null
	add-apt-repository restricted 2>&1 >> /dev/null
	add-apt-repository multiverse 2>&1 >> /dev/null
elif [[ "$oslabel" == "Rasbian" || "$oslabel" == "Fedora" || "$oslabel" == "CentOS" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ OS Warning
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. UB 16.04/18.04 LTS/Server & Debian 9+ are supported!
2. Please read https://pgblitz.com/threads/pg-install-instructions.243
3. This will proceed onward; but you have been warned!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  sleep 10
fi

# Delete If it Exist for Cloning
if [ -e "/pg/blitz" ]; then rm -rf /pg/blitz; fi
if [ -e "/pg/stage" ]; then rm -rf /pg/stage; fi
rm -rf /pg/stage/place.holder 1>/dev/null 2>&1

# Clone the Program to Stage for Installation
git clone -b v1 --single-branch https://github.com/PGBlitz/Stage.git /pg/stage

# Checking to See if the Installer ever Installed Python; if so... skip
var37="/pg/var/python.firstime"
if [ ! -e "${var37}" ]; then
  bash /pg/stage/pyansible.sh
  touch /pg/var/python.firstime
fi

# Clone PGBlitz into /pg/blitz/ ~ this is found under the module - Stage
# The values of clone should automatically change with a version change above
ansible-playbook /pg/stage/clone.yml

# Copy Starting Commands for PGBlitz
path="/pg/stage/alias"
cp -t /bin $path/plexguide $path/pg $path/pgblitz

# Verifying the Commands Installed
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Verifiying Started Commands Installed via @ /bin
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Installation fails if the pgblitz command is not in the correct location
if [[ ! -e "/bin/pgblitz" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! The PGBlitz Installer Failed ~ http://pgblitz.wiki
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Please Reinstall PGBlitz by running the Command Again! This step is to
ensure that everything is working prior to the install!

Ensure that you utilizing the correct versions of linux as described on
the installation page!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXITING!!!

EOF
exit
fi

# If nothing failed, notify the user that installation passed!
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  PASSED! The PGBlitz Command Installed! ~ http://pgblitz.wiki
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# creates a blank var; if this executes; pgblitz will go through the install process
touch /pg/var/new.install

chmod 775 /bin/plexguide /bin/pgblitz /bin/pg
chown 1000:1000 /bin/plexguide /bin/pgblitz /bin/pg

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Start AnyTime By Typing >>> pgblitz [or] plexguide [or] pg
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
