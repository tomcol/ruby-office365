# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Contact
      include Concerns::Base

      # params: args => { next_link: (nil / next_page_url) }
      # response { results: [], next_link: '...' }
      def contacts(args = {})
        wrap_results(args.merge(kclass: Models::Contact, base_uri: "/me/contacts"))
      end

      def create_contact(args: {}, params: {})
        response  = post_request(args: args.merge(kclass: Models::Contact, base_uri: "/me/contacts"), params: params)
        {
          contact: Models::Contact.new(response)
        }
      end

      def update_contact(id:, args: {}, params: {})
        raise Error, "Contact.update_contact id must be supplied" if id.nil?

        response  = patch_request(args: args.merge(kclass: Models::Contact, base_uri: "/me/contacts/#{id}"), params: params)
        {
          contact: Models::Contact.new(response)
        }
      end

      def user_contacts(user_id, args = {})
        raise Error, "Contact.user_contacts user id must be supplied" if user_id.nil?

        wrap_results(args.merge(kclass: Models::Contact, base_uri: "/users/#{user_id}/contacts"))
      end

      def user_contact_folders(user_id, args = {})
        raise Error, "Contact.user_contact_folders user id must be supplied" if user_id.nil?

        wrap_results(args.merge(kclass: Models::ContactFolder, base_uri: "/users/#{user_id}/contactFolders"))
      end

      def user_create_contact_folder(user_id:, args: {}, params: {})
        raise Error, "Contact.user_create_contact_folder user id must be supplied" if user_id.nil?

        response  = post_request(args: args.merge(kclass: Models::ContactFolder, base_uri: "/users/#{user_id}/contactFolders"), params: params)
        {
          contact: Models::ContactFolder.new(response)
        }
      end

      def folder_contacts(user_id, folder_id, args = {})
        raise Error, "Contact.folder_contacts user id must be supplied" if user_id.nil?
        raise Error, "Contact.folder_contacts folder_id must be supplied" if folder_id.nil?

        wrap_results(args.merge(kclass: Models::Contact, base_uri: "/users/#{user_id}/contactfolders/#{folder_id}/contacts"))
      end

      def user_create_contact(user_id:, args: {}, params: {})
        raise Error, "Contact.user_create_contact user id must be supplied" if user_id.nil?

        response  = post_request(args: args.merge(kclass: Models::Contact, base_uri: "/users/#{user_id}/contacts"), params: params)
        {
          contact: Models::Contact.new(response)
        }
      end

      def user_update_contact(user_id:, id:, args: {}, params: {})
        raise Error, "Contact.user_update_contact user id must be supplied" if user_id.nil?
        raise Error, "Contact.user_update_contact id must be supplied" if id.nil?

        response  = patch_request(args: args.merge(kclass: Models::Contact, base_uri: "/users/#{user_id}/contacts/#{id}"), params: params)
        {
          contact: Models::Contact.new(response)
        }
      end
    end
  end
end
