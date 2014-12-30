class Fine < ActiveRecord::Base
  # Constants ##################################################################

  # Validations ################################################################

  # Scopes #####################################################################

  # Associations ###############################################################

  belongs_to :user
  has_one :attendance
  has_one :event, through: :attendance

  # Helpers ####################################################################
end
