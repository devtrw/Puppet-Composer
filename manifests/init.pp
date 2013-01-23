# == Class: composer
#
#   This class handles installing composer and composer assets
#
class composer ($installLocation) {

    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    exec { "install-composer-phar":
        command => "curl -s https://getcomposer.org/installer | php",
        cwd     => $installLocation,
        creates => "${installLocation}/composer.phar",
        require => [ Package["php"], Package["curl"] ]
    }

    exec { "update-composer-vendors":
        command => "php composer.phar install",
        cwd     => $installLocation,
        require => [ Exec["install-composer-phar"] ],
        creates => "$installLocation/vendor/",
        timeout => 0
    }

}