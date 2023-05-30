#!/bin/bash

# Function to prompt for restart confirmation
confirm_restart() {
  read -p "Do you want to restart the system? (y/n): " restart
  if [[ $restart == "y" || $restart == "yes" ]]; then
    reboot
  else
    echo "Restart canceled."
  fi
}

# Prompt the user to select an option
echo "Select mode:"
echo "1. Graphical mode"
echo "2. Command-line mode"
read -p "Enter option (1 or 2): " option

# Execute the corresponding action based on the user's choice
case $option in
  1)
    # Switch to graphical mode
    systemctl set-default graphical.target
    echo "Switched to graphical mode."
    ;;
  2)
    # Switch to command-line mode
    systemctl set-default multi-user.target
    echo "Switched to command-line mode."
    ;;
  *)
    # Invalid option
    echo "Invalid option."
    ;;
esac

# Prompt for restart confirmation after the switch statement
confirm_restart

