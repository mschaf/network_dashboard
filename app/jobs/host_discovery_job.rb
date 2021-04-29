class HostDiscoveryJob < ApplicationJob
  queue_as :default

  def perform
    HostDiscovery::Nmap.ping_scan
  end

end