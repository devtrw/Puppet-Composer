# == Class: composer
#
#   Handles installing composer and composer managed vendors
#
class composer (
    $sourceLocation,
    $installLocation      = "/usr/local/bin/composer",
    $vendorInstallCommand = "install",
    $logOutput            = true
) {

    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    if (!defined(Package["php5-cli"])) {
        package{ "php5-cli": ensure => "present" }
    }

    if (!defined(Package["php5-curl"])) {
        package{ "curl": ensure => "present" }
    }

    exec { "install-composer-phar":
        command => "curl -s https://getcomposer.org/installer | php && mv /tmp/composer.phar ${installLocation}",
        cwd     => "/tmp",
        creates => "${installLocation}",
        require => [Package["php5-cli"], Package["php5-curl"]]
    }

    exec { "install-vendors":
        command   => "${installLocation} $vendorInstallCommand",
        cwd       => $sourceLocation,
        logoutput => $logOutput,
        timeout   => 0,
        require    => Exec["install-composer-phar"]
    }
}
