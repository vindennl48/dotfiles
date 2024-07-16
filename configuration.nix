# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

################################################################################
## ENVIRONMENT #################################################################
################################################################################
  environment = {
    systemPackages = with pkgs; [
      wget
      git
      less
      gcc
      neovim nodejs yarn xclip
      spice-vdagent
      alacritty
      turbovnc
    ];

    # Environment Variables
    variables = {
      # EXAMPLE_VAR = true;
    };
  };

################################################################################
## PROGRAMS ####################################################################
################################################################################
  programs = {
    firefox.enable = true; # Install firefox.
    zsh.enable = true; # Install zsh

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };

  ## libvirt and virt-manager
  programs.virt-manager.enable = true; # Install virt-manager
  virtualisation.libvirtd.enable = true; # for virt-manager


################################################################################
## FONTS #######################################################################
################################################################################
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "RobotoMono" "FiraCode" "DroidSansMono" ]; })
  ];

################################################################################
## USERS #######################################################################
################################################################################
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mitch = {
    isNormalUser = true;
    description = "mitch";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
    shell = pkgs.zsh;
  };

################################################################################
## SERVICES ####################################################################
################################################################################
  services = {
    xserver = {
      # Enable the X11 windowing system.
      # You can disable this if you're only using the Wayland session.
      enable = true;

      # Enable touchpad support (enabled default in most desktopManager).
      # services.xserver.libinput.enable = true;

      xkb.layout = "us";
      xkb.variant = "";

      ## Login screens: none will default to nixos login
      displayManager.sddm.enable = true; # use with plasma
      # displayManager.gdm.enable = true;

      ## Desktop Environment
      desktopManager.plasma6.enable = true;
      # desktopManager.gnome.enable = true;
      # desktopManager.cinnamon.enable = true;
      # windowManager.dwm.enable = true;
    };

    # ## Login Screen
    # greetd = {
    #   enable = true;
    #   settings = {
    #     default_session = {
    #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
    #       user = "greeter";
    #     };
    #   };
    # };

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
      ports = [ 22 ];
    };

    ## When running as VM / KVM / QEMU / VBOX
    # Clipboard
    spice-vdagentd.enable = true;
    ## Time sync and scripting
    qemuGuest.enable = true;
    ## VirtFS alternative for directory sharing
    spice-webdavd.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
  };

  ## PIPEWIRE
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

################################################################################
## NETWORKING ##################################################################
################################################################################
  networking = {
    # Enable networking
    networkmanager.enable = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    hostName = "nixos"; # Define your hostname.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    firewall.allowedTCPPorts = [ 22 8000 5901 ];
    # firewall.allowedUDPPorts = [ ... ];
    # firewall.enable = false; # disable the firewall altogether.
  };

################################################################################
## BOOT ########################################################################
################################################################################
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

################################################################################
## LOCALE ######################################################################
################################################################################
  i18n = {
    # Select internationalisation properties.
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

################################################################################
## SYSTEM ######################################################################
################################################################################
  # Testing out build scripts
  system.activationScripts.script.text = ''
    # source ${config.system.build.setEnvironment} # this crashes the kernel on boot

    # since this will be run as root, need this
    setPermissions() {
      argpath=$1
      if [ -d $argpath ]; then
        # folder
        chown -R mitch:users $argpath
        chmod -R 755 $argpath
      elif [ -f $argpath ]; then
        # file
        chown mitch:users $argpath
        chmod 644 $argpath
      fi
    }

    mkdir -p /home/mitch/bin

    dottest="/home/mitch/bin/dotfiles"
    if [ ! -e $dottest ]; then
      if ${pkgs.git}/bin/git clone https://github.com/vindennl48/dotfiles $dottest; then
        # git clone https://github.com/vindennl48/dotfiles $dottest
	echo "----> Cloned Dotfiles; press enter to continue" && read
        setPermissions $dottest
      else
	echo "----> Failed to clone dotfiles; press enter to continue" && read
      fi
    fi
  '';

  # Set your time zone.
  time.timeZone = "America/New_York";

  # allow packages like Nvidia drivers / steam / etc.
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
