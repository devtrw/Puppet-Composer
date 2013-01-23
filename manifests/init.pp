# == Class: composer
#
#   This class handles installing composer and composer assets
#
class composer ($installLocation) {

    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    package { ["php", "curl"]: ensure => "present" }
    ->
    exec { "install-composer-phar":
        command => "curl -s https://getcomposer.org/installer | php",
        cwd     => $installLocation,
        creates => "${installLocation}/composer.phar"
    }
    ->
    exec { "update-composer-vendors":
        command => "php composer.phar install",
        cwd     => $installLocation,
        creates => "$installLocation/vendor/",
        timeout => 0
    }

}