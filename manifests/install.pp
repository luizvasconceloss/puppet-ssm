# Install the ssm package
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
