$fuel_settings = parseyaml($astute_settings_yaml)

# this replaces removed postgresql version fact
$postgres_default_version = '8.4'

node default {

  Exec  {path => '/usr/bin:/bin:/usr/sbin:/sbin'}

  $centos_repos =
  [
   {
   "id" => "nailgun",
   "name" => "Nailgun",
   "url"  => "\$tree"
   },
   ]

  $ostf_host = $::fuel_settings['ADMIN_NETWORK']['ipaddress']
  $nailgun_host = $::fuel_settings['ADMIN_NETWORK']['ipaddress']

  $repo_root = "/var/www/nailgun"

  class { 'nailgun::nginx':
    ostf_host       => $ostf_host,
    nailgun_host    => $nailgun_host,
    repo_root       => $repo_root,
    service_enabled => false,
  }
}
