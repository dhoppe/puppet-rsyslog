class rsyslog::master inherits rsyslog {
	file { "/etc/logrotate.d/rsyslog":
		owner   => root,
		group   => root,
		mode    => 0644,
		source  => "puppet:///modules/rsyslog/common/etc/logrotate.d/rsyslog",
		require => [
			File["rsyslog.conf"],
			Package["rsyslog-relp"]
		],
	}

	Rsyslog::Config["/etc/rsyslog.conf"] {
		config  => "server",
	}

	file { "/var/log/rsyslog":
		ensure => directory,
		owner  => root,
		group  => root,
		mode   => 0755,
	}

	File ["/var/spool/rsyslog"] {
		force  => true,
		ensure => absent,
	}
}

# vim: tabstop=3