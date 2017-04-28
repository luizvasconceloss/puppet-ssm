# == Class ssm::install
#
# This class is called from ssm::init to install the SSM package.
#
# == Parameters
#
# [*path*]
#   Specifies the location where the package will be downloaded. The path can
#   be set using `ssm::custom_path` othwerwise, the correct default path is
#   generated in ssm::init.
#
# [*provider*]
#  Specifies the provider type to use when installing the package. The correct
#  provider is determined automatically based on platform in ssm::params.
#
# [*url*]
#   String indicating the URL to use when downloading the SSM package. The URL
#   can be set using `ssm::custom_url` otherwise, the correct default URL is
#   generated in ssm::init.
#
class ssm::install(
  $path     = undef,
  $provider = undef,
  $url      = undef,
) inherits ssm::params { # lint:ignore:class_inherits_from_params_class

  validate_absolute_path($path)
  validate_string($url)

  exec { 'download_ssm-agent':
    command => "/usr/bin/wget -T60 -N https://${url} -O ${path}",
    path    => '/bin:/usr/bin:/usr/local/bin:/usr/sbin',
    creates => $path,
  }

  package { 'amazon-ssm-agent':
    provider  => $provider,
    source    => $path,
    subscribe => Exec['download_ssm-agent'],
  }
}
