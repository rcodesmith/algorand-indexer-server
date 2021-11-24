Vagrant.configure("2") do |config|
    config.vm.box = "google/gce"

    # Provider to set up VM in Google Cloud
    config.vm.provider :google do |google, override|
      google.google_project_id = "<your google cloud project ID here>"
      google.google_json_key_location = "<Path to JSON key here>"
  
      # Use Ubuntu 20.04
      google.image_family = 'ubuntu-2004-lts'

      google.name = 'algorand-index-server'
  
      # Allocate 800 GB for disk
      google.disk_size = '800'
      
      # Tags to apply to server
      google.tags = ['algorand-indexer']

      override.ssh.username = "<username you want to create on server>"
      override.ssh.private_key_path = "<local path to your SSH private key you want to use>"
    end

    # Copy docker-compose.yml and Algorand Node config files to VM
    config.vm.provision "file", source: "./docker-compose.yml", destination: "docker-compose.yml"
    config.vm.provision "file", source: "./node-config.json", destination: "node-config.json"

    # Execute setup script on the VM
    config.vm.provision "shell", path: "setup.sh"

  end