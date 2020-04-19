# frozen_string_literal: true

# abstract model class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
