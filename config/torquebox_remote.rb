TorqueBox::RemoteDeploy.configure do
  torquebox_home "/opt/torquebox/current"
  hostname "torque2.elabs"
  port "22"
  #user "torquebox"
  user "ubuntu"
  key "~/.ec2/elabs.pem"
  rails_env "production"
end
