class Poll < ActiveRecord::Base

	has_many :questions
	has_many :replies
end
