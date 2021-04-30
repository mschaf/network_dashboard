module HostDiscovery
  module Nmap

    def self.ping_scan
      nmap_output = `sudo nmap -PR -PP -PM -sn 192.168.1.0/24 -oX -`
      nmap_doc = Nokogiri::XML(nmap_output)
      updated_host_ids = []
      (nmap_doc % 'nmaprun' / 'host').each do |host_node|
        state = host_node.at('status').attr('state')
        hostname = host_node.search('hostname').first&.attr('name')
        addresses = host_node.search('address').map { |a| [a['addrtype'].to_sym, a['addr']] }.to_h
        mac = Address::Mac.find_or_initialize_by(address: addresses[:mac]) if addresses[:mac].present?
        ipv4 = Address::Ipv4.find_or_initialize_by(address: addresses[:ipv4]) if addresses[:ipv4].present?

        host = mac&.host || ipv4&.host || Host.new
        host.hostname = hostname
        host.last_up = Time.now
        host.flags |= ['discovered']
        host.save!

        updated_host_ids << host.id

        if mac
          mac.host = host
          mac.save!
        end

        if ipv4
          ipv4.host = host
          ipv4.save!
        end

      end

      Host.where.not(id: updated_host_ids) do |host|
        host.flags -= ['discovered']
        host.save
      end
    end

  end
end