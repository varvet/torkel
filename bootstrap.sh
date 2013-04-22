locale-gen utf-8
apt-get install -y build-essential postgresql-9.1 java7-jdk git unzip

command_exists () {
  type "$1" &> /dev/null ;
  return $?
}

if command_exists foreman
then
  echo "foreman installed"
else
  wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi

if [ -d /opt/torquebox ]
then
  echo "torquebox directory found"
else
  if [ -f torquebox-dist-2.3.0-bin.zip ]
  then
    echo "torquebox found"
  else
    wget http://torquebox.org/release/org/torquebox/torquebox-dist/2.3.0/torquebox-dist-2.3.0-bin.zip
  fi

  mkdir /opt/torquebox

  unzip torquebox-dist-2.3.0-bin.zip
  mv torquebox-2.3.0 /opt/torquebox/
  ln -s /opt/torquebox/torquebox-2.3.0 /opt/torquebox/current
fi

export pf=/etc/profile.d/torquebox.sh
if [ -f $pf ]
then
  echo "profile file exists"
else
  echo 'export TORQUEBOX_HOME=/opt/torquebox/current' >> $pf
  echo 'export JBOSS_HOME=$TORQUEBOX_HOME/jboss' >> $pf
  echo 'export JRUBY_HOME=$TORQUEBOX_HOME/jruby' >> $pf
  echo 'PATH=$JBOSS_HOME/bin:$JRUBY_HOME/bin:$PATH' >> $pf
fi

sudo -u postgres createuser -s elabs -P
sudo -u postgres createdb torkel_production

if [ -f /etc/init/app.conf ]
then
  echo "app configured"
  restart app
else
  . /etc/profile.d/torquebox.sh
  cd $TORQUEBOX_HOME/jboss
  echo 'torquebox: $JBOSS_HOME/bin/standalone.sh' > Procfile
  foreman export upstart /etc/init
  start app
fi

adduser ubuntu root
