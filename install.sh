#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq - MrDoob
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

## Upgrade
#apt-get update -y
#
#apt-get upgrade -y # causes problems when forced on an interactive screen
#apt-get install software-properties-common git zip unzip dialog -y

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  NOTICE: PGBlitz Version 9 - Installer
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
By installing, you agree to the terms and conditions of the GNUv3 License!

Thanks To: Davaz, Deiteq, FlickerRate, ClownFused, MrDoob, Sub7Seven,
TimeKills, The Creator, and to the caring Community (& Linux Noobs)!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

# Remove PGBlitz if it exists
[[ -e /pg/pgblitz ]] && rm -rf /pg/pgblitz
[[ -e /pg/stage ]] && rm -rf /pg/stage

# Create base directories
mkdir -p /pg/{data,logs,stage,tmp,var}
chmod 775 /pg/{data,logs,stage,tmp,var}
chown 1000:1000 /pg/{data,logs,stage,tmp,var}

# Clone into /pg/stage
git clone -b v1 --single-branch https://github.com/PGBlitz/Stage.git /pg/stage

# Check if Python is installed
var37="/pg/var/python.firstime"
if [[ ! -e ${var37} ]]; then
  bash /pg/stage/pyansible.sh
  touch /pg/var/python.firstime
fi

# Clone PGBlitz into /pg/pgblitz/
ansible-playbook /pg/stage/clone.yml

# Copy startup scripts
path="/pg/stage/alias"
cp $path/{pg,pgblitz,plexguide} /bin

# Verify startup scripts are installed
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛  Verifying startup scripts installed in /bin...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Fails if startup scripts are not in the correct location
if [[ ! -e /bin/pg ]] || [[ ! -e /bin/pgblitz ]] || [[ ! -e /bin/plexguide ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! PGBlitz install failed! ~ http://pgblitz.wiki
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Reinstall PGBlitz by running the installer again.

Make sure you are using the correct version of linux as mentioned in the
install instructions!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EXITING!!!

EOF
exit
fi

# Success
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  PASSED! PGBlitz install successful! ~ http://pgblitz.wiki
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Creates a blank variable; if successful, pgblitz will run through the install process
touch /pg/var/new.install

chmod 775 /bin/{pg,pgblitz,plexguide}
chown 1000:1000 /bin/{pg,pgblitz,plexguide}

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  Start by typing >>> pg [or] pgblitz [or] plexguide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
