class HostsController < ApplicationController

  def index
    @host_lines = []

    host_scope.includes(macs: {ips: :hostnames}).each do |host|
      if host.macs.blank?
        @host_lines << { host: host, mac: nil, ip: nil, hostname: nil }
      else
        host.macs.each do |mac|
          if mac.ips.blank?
            @host_lines << { host: host, mac: mac, ip: nil, hostname: nil }
          else
            mac.ips.each do |ip|
              if ip.hostnames.blank?
                @host_lines << { host: host, mac: mac, ip: ip, hostname: nil }
              else
                ip.hostnames.each do |hostname|
                  @host_lines << { host: host, mac: mac, ip: ip, hostname: hostname }
                end
              end
            end
          end
        end
      end
    end

    Ip.where(mac: nil).includes(:hostnames).each do |ip|
      ip_key = "ip#{ip.id}"
      if ip.hostnames.blank?
        @host_lines << { host: ip_key, mac: ip_key, ip: ip, hostname: nil }
      else
        ip.hostnames.each do |hostname|
          @host_lines << { host: ip_key, mac: ip_key, ip: ip, hostname: hostname }
        end
      end
    end

    @host_lines.sort_by! do |host_line|
      [host_line[:ip]&.address, host_line[:mac].to_s, host_line[:host].to_s].reverse.join
    end
  end

  def edit
    load_host
  end

  def update
    load_host
    build_host
    if @host.save
      redirect_to hosts_path
    else
      render 'edit'
    end
  end

  private

  def load_hosts
    @hosts = Host.all
    @lose_ips = Ip.where(mac: nil)
  end

  def load_host
    @host ||= host_scope.find(params[:id])
  end

  def build_host
    @host ||= host_scope.build
    @host.attributes = host_params
  end

  def host_params
    host_params = params[:host]
    host_params ? host_params.permit(:name) : {}
  end

  def host_scope
    Host.all
  end

end