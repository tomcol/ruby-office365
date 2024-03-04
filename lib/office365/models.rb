# frozen_string_literal: true

module Office365
  module Models
    autoload :Base,               "office365/models/concerns/base"
    autoload :Directory,          "office365/models/directory"
    autoload :Mailbox,            "office365/models/mailbox"
    autoload :Calendar,           "office365/models/calendar"
    autoload :User,               "office365/models/user"
    autoload :Owner,              "office365/models/owner"
    autoload :EmailAddress,       "office365/models/email_address"
    autoload :Contact,            "office365/models/contact"
    autoload :ContactFolder,      "office365/models/contact_folder"
    autoload :MasterCategory,     "office365/models/master_category"
    autoload :AccessToken,        "office365/models/access_token"
    autoload :Event,              "office365/models/event"
  end
end
