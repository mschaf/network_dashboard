class HostScan::Ping < HostScan

  PING_TIMEOUT = 1

  def scan(address)
    ping = Net::Ping::External.new(target, timeout: PING_TIMEOUT)

    if ping.ping
      self.up = true
      self.result = {
        state: 'up',
        ping_time: ping.duration
      }
    else
      self.up = false
      self.result = {
        state: 'down',
        exception: ping.exception
      }
    end

    address.reachable = up
    address
  end

end