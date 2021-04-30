module IndicatorHelper

  def last_seen_indicator(timestamp)
    tooltip = "Last seen: #{timestamp}"
    element_class = (timestamp > 2.minutes.ago ? 'text-success' : 'text-danger')
    icon(:indicator, class: element_class, 'up-tooltip': tooltip)
  end

end