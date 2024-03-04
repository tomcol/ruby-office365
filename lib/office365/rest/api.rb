# frozen_string_literal: true

require_relative "./user"
require_relative "./mailbox"
require_relative "./calendar"
require_relative "./contact"
require_relative "./event"
require_relative "./token"
require_relative "./master_category"

module Office365
  module REST
    module API
      include Office365::REST::User
      include Office365::REST::Mailbox
      include Office365::REST::Calendar
      include Office365::REST::Event
      include Office365::REST::Contact
      include Office365::REST::Token
      include Office365::REST::MasterCategory
    end
  end
end
