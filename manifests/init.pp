# Class: ssm
# ===========================
#
# Downloads and installs the amazon-ssm-agent, i.e. the EC2 run command agent
#
# Parameters
# ----------
#
# * `region`
# The region to download the agent in. Default is undef.
#
# Examples
# --------
#
# @example
#    class { 'ssm':
#      region => 'us-east-1',
#    }
#
# Authors
# -------
#
# Todd Courtnage <todd@courtnage.ca>
# Shawn Sterling <shawn@systemtemplar.org>
#
# Copyright
# ---------
#
# Copyright 2016 Todd Courtnage
#
# lint:ignore:80chars
class ssm (
  $custom_path    = $ssm::params::custom_path,
  $custom_url     = $ssm::params::custom_url,
  $flavor         = $ssm::params::flavor,
  $manage_service = $ssm::params::manage_service,
  $package        = $ssm::params::package,
  $provider       = $ssm::params::provider,
  $region         = $ssm::params::region,
  $service_name   = $ssm::params::service_name,
) inherits ssm::params { # lint:ignore:class_inherits_from_params_class

  if $custom_url {
    validate_string($custom_url)
    $url = "${custom_url}/amazon-ssm-agent.${package}"
  } else {
    $url = "amazon-ssm-${region}.s3.amazonaws.com/latest/${flavor}_amd64/amazon-ssm-agent.${package}"
  }

  if $custom_path {
    validate_absolute_path($custom_path)
    if ! defined($custom_path) {
      exec { "mkdir_p-${custom_path}":
        command => "mkdir -p ${custom_path}",
        unless  => "test -d ${custom_path}",
        path    => '/bin:/usr/bin',
      }
      file { $custom_path:
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        require => Exec["mkdir_p-${custom_path}"],
      }
    }
    $path = "${custom_path}/amazon-ssm-agent.${package}"
  } else {
    $path = "/opt/amazon-ssm-agent.${package}"
  }

  class { 'ssm::install':
    path     => $path,
    provider => $provider,
    url      => $url,
  }

  class { 'ssm::service':
    manage_service => $manage_service,
    service_name   => $service_name,
  }

  anchor { 'ssm::begin': } -> Class['ssm::install'] -> Class['ssm::service'] -> anchor { 'ssm::end': }
  # lint:endignore
}
