exec { "/usr/bin/apt-get update": }
-> package { ["php5-cli", "php5-curl"]:
    ensure => present
}

class { "composer":
    sourceLocation => "/vagrant/tests/build"
}
