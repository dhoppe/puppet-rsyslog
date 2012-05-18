class rsyslog (
  $host = $rsyslog::params::host
) inherits rsyslog::params {

  validate_hash(hiera('host'))

  rsyslog::config { '/etc/rsyslog.conf':
    config => 'client',
    host   => $host,
  }

  if $::lsbdistid == 'Ubuntu' {
    file { '/etc/rsyslog.d/50-default.conf':
      ensure => absent,
    }
  }

  file { '/var/spool/rsyslog':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  package { 'rsyslog-relp':
    ensure => present,
  }

  service { 'rsyslog':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => [
      File['rsyslog.conf'],
      Package['rsyslog-relp']
    ],
  }
}