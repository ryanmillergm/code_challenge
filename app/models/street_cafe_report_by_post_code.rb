class StreetCafeReportByPostCode < ApplicationRecord
  self.primary_key = "id"

  def archive!
    update_attribute :archived, true
  end

  def readonly?
    true
  end
end
