dotfiles/
========

Gabriel Lima's personal selection of dotfiles.

Instructions
------------

To bootstrap these configurations, run the following commands:


.. code-block:: shell

    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt-get install git curl -y
    curl -s https://raw.githubusercontent.com/ewilazarus/dotfiles/master/install.sh | sudo bash /dev/stdin
