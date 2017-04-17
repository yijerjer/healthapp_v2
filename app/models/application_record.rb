class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected

  def merge_date_time
    if self.date && self.time
      d = self.date.to_date
      t = self.time.to_time

      self.time = Time.new(d.year, d.month, d.day, t.hour, t.min, t.sec)
    end
  end
end
