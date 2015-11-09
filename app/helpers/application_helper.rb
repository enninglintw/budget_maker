module ApplicationHelper

  def render_number_to_currency(number)
    number_to_currency(number,
                       precision: 5,
                       strip_insignificant_zeros: true)
  end

  def render_date_to_db_format(date)
    date.to_formatted_s(:db)
  end

  def render_datetime_to_short_format(datetime)
    datetime.to_formatted_s(:short)
  end

end
