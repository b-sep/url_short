# frozen_string_literal: true

class CreateUrlService # rubocop:disable Style/Documentation
  private attr_accessor :params

  Result = Data.define(:url, :success?)

  def initialize(**params)
    self.params = params
  end

  def call
    url = Url.new(params.merge(slug: generate_slug, short: generate_short))

    url.valid? or return result(url:, success: false)

    url.save and result(url:, success: true)
  end

  private

  def generate_slug
    @generate_slug ||= "#{Time.zone.now.to_i}#{SecureRandom.alphanumeric(10)}"
  end

  def generate_short
    "#{Rails.application.default_url_options[:protocol]}://" \
      "#{Rails.application.default_url_options[:host]}/#{generate_slug}"
  end

  def result(url:, success:) = Result.new(url:, success?: success)

  private_constant :Result
end
