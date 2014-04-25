class Todo < ActiveRecord::Base
  def title_two_times
   "#{title} #{title}".upcase()
  end
end
