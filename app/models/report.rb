class Report < ActiveRecord::Base
  validates_inclusion_of :status, :in => [nil, 'up', 'down']

  scope :for_the_frontpage, -> { where("message IS NOT NULL").order("created_at DESC").limit(10) }

  def self.get_current_status
    # Get the status of the last report
    Report.all.order("created_at DESC").where("status IS NOT NULL").first.status
  end
end
