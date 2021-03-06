module IconHelper

  ICON_MAPPING = {
    open_menu: 'menu',
    close_menu: 'x',
    indicator: 'circle',

    edit: 'edit',
    delete: 'trash-2',

    dashboard: 'home',
    hosts: 'server',
    wifi_access_points: 'wifi',
  }

  def icon(icon, options = {})
    icon_name = ICON_MAPPING[icon]
    text = options.delete(:text) || ''

    raise "unknown icon \"#{icon}\", define it in helpers/icon_helper.rb" unless icon_name

    options[:class] = [options[:class], 'align-center icon'].compact.join ' '

    content_tag 'span', options do
      html = ''.html_safe
      html << content_tag(:svg, class: 'icon--icon', 'data-icon': icon) do
        content_tag :use, nil, 'xlink:href' => "#{asset_pack_path('media/dist/feather-sprite.svg')}##{icon_name}"
      end
      html << content_tag(:span, text, class: 'icon--text') if text.present?
      html
    end


  end


end