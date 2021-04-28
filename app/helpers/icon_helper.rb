module IconHelper

  ICON_MAPPING = {
    open_menu: 'menu',
    close_menu: 'x',

    dashboard: 'home',
  }

  def icon(icon, text = '')
    icon_name = ICON_MAPPING[icon]

    raise "unknown icon \"#{icon}\", define it in helpers/icon_helper.rb" unless icon_name

    content_tag 'span', class: 'align-center icon' do
      html = ''.html_safe
      html << content_tag(:svg, class: 'icon--icon') do
        content_tag :use, nil, 'xlink:href' => "#{asset_pack_path('media/dist/feather-sprite.svg')}##{icon_name}"
      end
      html << content_tag(:span, text, class: 'icon--text') if text.present?
      html
    end


  end


end