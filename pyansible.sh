apt-get install -y --reinstall \
  nano \
  git \
  build-essential \
  libssl-dev \
  libffi-dev \
  python3-dev \
  python3-testresources \
  python3-pip \
  python3-testresources \
  python-dev \
  python-pip
python3 -m pip install --disable-pip-version-check --upgrade --force-reinstall pip==19.1.1
python3 -m pip install --disable-pip-version-check --upgrade --force-reinstall setuptools
python3 -m pip install --disable-pip-version-check --upgrade --force-reinstall \
  pyOpenSSL \
  requests \
  netaddr \
  lxml
python -m pip install --disable-pip-version-check --upgrade --force-reinstall pip==19.1.1
python -m pip install --disable-pip-version-check --upgrade --force-reinstall setuptools
python -m pip install --disable-pip-version-check --upgrade --force-reinstall \
  pyOpenSSL \
  requests \
  netaddr \
  lxml
python -m pip install --disable-pip-version-check --upgrade --force-reinstall ansible==${1-2.8.2}

## Copy pip to /usr/bin
cp /usr/local/bin/pip /usr/bin/pip
cp /usr/local/bin/pip3 /usr/bin/pip3

mkdir -p /etc/ansible/inventories/ 1>/dev/null 2>&1
echo "[local]" >/etc/ansible/inventories/local
echo "127.0.0.1 ansible_connection=local" >>/etc/ansible/inventories/local

### Reference: https://docs.ansible.com/ansible/2.4/intro_configuration.html
echo "[defaults]" >/etc/ansible/ansible.cfg
echo "deprecation_warnings=False" >>/etc/ansible/ansible.cfg

echo "command_warnings = False" >>/etc/ansible/ansible.cfg
echo "callback_whitelist = profile_tasks" >>/etc/ansible/ansible.cfg
echo "inventory = /etc/ansible/inventories/local" >>/etc/ansible/ansible.cfg

# Remove Cows when cowsay installed on main system
echo "nocows = 1" >>/etc/ansible/ansible.cfg

# Variables Need to Line Up with pg.sh (start)
touch /var/plexguide/background.1
