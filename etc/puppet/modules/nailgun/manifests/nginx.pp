class nailgun::nginx(
  $repo_root = "/var/www/nailgun",
  $staticdir = "/opt/nailgun/share/nailgun/static",
  $templatedir = "/opt/nailgun/share/nailgun/static",
  $logdumpdir = "/var/www/nailgun/dump",
  $service_enabled = true,
  $ostf_host = '127.0.0.1',
  $nailgun_host = '127.0.0.1',
  $production = "production",
  ) {

  Exec  {path => '/usr/bin:/bin:/usr/sbin:/sbin'}

  anchor { "nginx-begin": }
  anchor { "nginx-end": }
#original just for reference
  Anchor<| title == "nginx-begin" |> ->
  Class["nailgun::nginx-repo"] ->
#  Exec["start_nginx_repo"] ->
  Class["nailgun::nginx-nailgun"] ->
  Anchor<| title == "nginx-end" |>

  package { 'nginx':
    ensure => latest,
  }

  class { "nailgun::user":
    nailgun_group => $nailgun_group,
    nailgun_user => $nailgun_user,
  }

  class { "nailgun::nginx-repo":
    repo_root => $repo_root,
#    notify => Service["nginx"],
  }
  class { "nailgun::nginx-service":
    service_enabled => $service_enabled,
  }
#  exec { "start_nginx_repo":
#    command => "/etc/init.d/nginx start",
#    unless => "/etc/init.d/nginx status | grep -q running",
#  }

  class { 'nailgun::nginx-nailgun':
    staticdir    => $staticdir,
    logdumpdir   => $logdumpdir,
    ostf_host    => $ostf_host,
    nailgun_host => $nailgun_host,
    notify       => Service["nginx"],
  }
}

