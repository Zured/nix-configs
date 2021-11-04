# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  location = {
    latitude = 0.0;
    longitude = 0.0;
  };
  boot = {
    loader = let limit = 50; in
    {
      grub = {
        configurationLimit = limit;
      };
      systemd-boot = {
        configurationLimit = limit;
      };
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    kernelParams = [
      "random.trust_cpu=on"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  users.users = {
	zure = {
		isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICbLY2iqUz4z+c+Kzcskdcc8fIuZAhFfO8YP2umtnUQe zure@nixos"
    ];
		extraGroups = [
			"wheel"
      "libvirtd"
		];
	};
  };

  virtualisation.virtualbox.guest = {
    enable = true;
 };

  services = {
    mullvad-vpn = {
      enable = true;
    };
    redshift = {
      enable = true;
    };
    xserver = {
      xkbOptions = "caps:none";
      resolutions = [{
        x = 1920;
        y = 1080;    
      }];
      enable = true;
      displayManager = {
        startx = {
	  enable = true;
	};
      };
      windowManager = {
        i3 = {
          enable = true;
        };
      };
    };
  };

  powerManagement = {
    cpuFreqGovernor = "performance";
  };

  programs = {
    ssh = {
      # Start an OpenSSH agent for each user that logs in
      startAgent = true;
    };
    thefuck = {
      enable = true;
    };
  };

  hardware = {
    opengl = {
      enable = true;
    };
  };

  security = {
      sudo = {
        extraConfig = ''
        # Provice visual feedback when typing passwords
        Defaults pwfeedback
        '';
      };
  };

  environment = {
    systemPackages = with pkgs; [
      aria2 # "aria2" command (versatile and fast download utility)
      bzip2 # "bzip2" command
      clinfo # "clinfo" command (Show OpenCL devices)
      curl # "curl" command
      fast-cli # "fast" command (measuring downlink speed
      findutils # "find" command (search for files in a directory)
      fping # "fping" command (packet loss awape ICMP ping command)
      gping # "gping" command
      gzip
      hostname
      audacity
      barrier
      ffmpeg
      electrum
      etcher
      filezilla
      flameshot
      gnome.nautilus
      gparted
      spotify
      obs-studio
      betterdiscordctl
      pavucontrol
      playerctl
      qbittorrent
      sqlitebrowser
      trash-cli
      mullvad-vpn
      virt-manager
      virt-top 
      virt-viewer
      virt-what
      vlc
      whois
      xclip
      xmousepasteblock
      pulseaudio
      htop # "htop" command (interactive process viewer)
      ioping # "ioping" command (simple disk I/O latency testing/monitoring tool)
      iotop # "iotop" command
      hwinfo # "hwinfo" command
      jq # "jq" command (command-line JSON parser)
      less # "less" command (pager program)
      lshw # "lshw" command (list hardware)
      mat2 # "mat2" command (media file metadata removal)
      ncdu # "ncdu" command
      neofetch # "netfetch" command (system info)
      restic # backups
      p7zip # "7z" command
      pciutils # "lspci" command (for listing attached PCI devices)
      pwgen-secure
      python39 # "python3" command
      stress # "stress" command
      stress-ng # "stress-ng" command (stress test systems)
      wireshark
      tldr # "tldr" command (simplified and community-driven man pages)
      tmux #for terminal multiplexing
      unrar # "unrar" command
      unzip # "unzip" command
      usbutils # "lsusb" command
      zip # "zip" command
      zlib
      zstd # "unzstd" command
      neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      vscode
      keepassxc
      dropbox
      discord
      cryptomator
      xfce.xfce4-clipman-plugin
      firefox
      rofi
      xfce.xfce4-terminal
      git
  ];
    sessionVariables = {
      TERMINAL = ["xfce4-terminal"];
    };
  };

  networking = {
    useDHCP = false;
    interfaces.enp0s3.useDHCP = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];

  };
  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

