module ApplicationHelper

  def render_number_to_currency(number)
    number_to_currency(number,
                       precision: 5,
                       strip_insignificant_zeros: true)
  end

  def render_updated_at(updated_at)
    updated_at.to_formatted_s(:long)
  end

end
