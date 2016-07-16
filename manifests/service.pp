# Ensure ssm service is running.
class ssm::service(
  $manage_service = $ssm::params::manage_service,
  $service_name   = $ssm::params::manage_service,
) inherits ssm::params { # lint:ignore:class_inherits_from_params_class
  if $manage_service {
    service { $service_name:
      ensure     => running,
      hasstatus  => true,
      hasrestart => true,
      restart    => "/sbin/restart ${service_name}",
      start      => "/sbin/start ${service_name}",
      status     => "/sbin/status ${service_name}",
      stop       => "/sbin/stop ${service_name}",
      subscribe  => Package['amazon-ssm-agent'],
      require    => Class['ssm::install'],
    }
  }
}
