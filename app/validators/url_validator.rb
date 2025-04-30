# frozen_string_literal: true

# adapted from here https://mroach.com/2023/02/url-validation-in-ruby/
class UrlValidator < ActiveModel::EachValidator
  def validate_each(instance, attribute, value)
    uri = URI.parse(value.to_s)

    (URI.scheme_list.keys.include?(uri.scheme&.upcase) && uri.host.present?) or
      instance.errors.add(attribute, 'must be a valid url')
  end
end
