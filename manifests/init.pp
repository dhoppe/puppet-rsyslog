class rsyslog {
	define rsyslog::config($config = false, $host = false) {
		file { "$name":
			owner   => root,
			group   => root,
			mode    => '0644',
			alias   => 'rsyslog.conf',
			content => template("rsyslog/${::lsbdistcodename}/etc/rsyslog-${config}.conf.erb"),
			notify  => Service['rsyslog'],
			require => Package['rsyslog-relp'],
		}
	}

	rsyslog::config { '/etc/rsyslog.conf':
		config => 'client',
		host   => hiera('host'),
	}

	if $::lsbdistid == 'Ubuntu' {
		file { '/etc/rsyslog.d/50-default.conf':
			ensure => absent,
		}
	}

	file { '/var/spool/rsyslog':
		ensure => directory,
		owner  => root,
		group  => root,
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

# vim: tabstop=3