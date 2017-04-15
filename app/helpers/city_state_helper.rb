module CityStateHelper
  def get_countries
    CS.get.sort_by { |key, value| value }
  end

  def get_states(country)
    CS.get(country).sort_by { |key, value| value }
  end
end
