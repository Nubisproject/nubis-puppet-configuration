# == Class: nubis_configuration
#
# Full description of class nubis_configuration here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { nubis_configuration:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class nubis_configuration {
}

define nubis::configuration(
  $format = 'sh',
  $prefix = '/%%PROJECT%%/%%ENVIRONMENT%%',
  $reload = undef,
) {

  file { "/etc/nubis-config":
    ensure => directory,
    owner => 0,
    group => 0,
    mode  => 755,
  }

  file { "/etc/confd/conf.d/$name.toml":
      ensure => present,
      owner => 0,
      group => 0,
      content => template("nubis_configuration/config.toml.erb"),
  }
  file { "/etc/confd/templates/$name.tmpl":
      ensure => present,
      owner => 0,
      group => 0,
      source => "puppet:///modules/nubis_configuration/config.$format.tmpl"
  }
  file { "/etc/nubis.d/confd":
    ensure => present,
    owner => 0,
    group => 0,
    mode => 555,
    source => "puppet:///modules/nubis_configuration/confd",
  }
}
