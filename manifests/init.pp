# == Class: composer
#
#   Handles installing composer and composer assets
#
class composer ($installLocation) {

    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    if (!defined(Package["php"])) {
        package{ "php": ensure => "present" }
    }

    if (!defined(Package["php5-curl"])) {
        package{ "curl": ensure => "present" }
    }

    exec { "install-composer-phar":
        command => "curl -s https://getcomposer.org/installer | php",
        cwd     => $installLocation,
        creates => "${installLocation}/composer.phar",
        require => [Package["php"], Package["php5-curl"]]
    }
    ->
    exec { "update-composer-vendors":
        command => "php composer.phar install",
        cwd     => $installLocation,
        creates => "$installLocation/vendor/",
        timeout => 0
    }

}