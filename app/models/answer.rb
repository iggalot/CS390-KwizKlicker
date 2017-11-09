class Answer < ApplicationRecord
	validates :text, presence: true
	 belongs_to :question, dependent: :destroy
end
