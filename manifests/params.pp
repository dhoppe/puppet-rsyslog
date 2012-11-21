class rsyslog::params {
  case $::lsbdistcodename {
    'squeeze': {
      $host = hiera('host')
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}
