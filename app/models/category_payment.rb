class CategoryPayment < ApplicationRecord
  # here the names should be singlular because of models
  belongs_to :category
  belongs_to :payment
end
