class HostScanJob < ApplicationJob
  queue_as :default

  def perform(host_scan)
    host_scan.perform_scan
  end
end