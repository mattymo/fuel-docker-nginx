class nailgun::supervisor(
  $venv,
  $conf_file = 'nailgun/supervisord.conf.erb',
  $service_enabled = true,
  ) {
  package { "supervisor":
    ensure => latest,
  }

  file { "/etc/sysconfig/supervisord":
    source => 'puppet:///modules/nailgun/supervisor-sysconfig',
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  file { "/etc/rc.d/init.d/supervisord":
    source => 'puppet:///modules/nailgun/supervisor-init',
    owner => 'root',
    group => 'root',
    mode => '0755',
    require => [Package["supervisor"],
                File["/etc/sysconfig/supervisord"]],
    #notify => Service["supervisord"],
  }


  file { "/etc/supervisord.conf":
    content => template($conf_file),
    owner => 'root',
    group => 'root',
    mode => 0644,
    require => Package["supervisor"],
    #notify => Service["supervisord"],
  }
  if $service_enabled {
    service { "supervisord":
    #ensure => $service_ensure,
    enable => $service_enabled,
    require => [
                Package["supervisor"],
                ],
    }
  }
}
