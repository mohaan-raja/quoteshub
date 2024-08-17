class Quote < ApplicationRecord
    validates :name, :author, presence: true
end
