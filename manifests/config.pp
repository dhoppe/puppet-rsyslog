define rsyslog::config($config = false, $host = false) {
  file { $name:
    owner   => root,
    group   => root,
    mode    => '0644',
    alias   => 'rsyslog.conf',
    content => template("rsyslog/${::lsbdistcodename}/etc/rsyslog-${config}.conf.erb"),
    notify  => Service['rsyslog'],
    require => Package['rsyslog-relp'],
  }
}