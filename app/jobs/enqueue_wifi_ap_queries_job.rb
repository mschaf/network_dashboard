class EnqueueWifiApQueriesJob < ApplicationJob
  queue_as :default

  def perform
    WifiAccessPoint.all.each do |wifi_ap|
      UpdateWifiApJob.perform_later(wifi_ap)
    end
  end

end