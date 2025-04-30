# frozen_string_literal: true

# bundle exec rake short_url:create_indexes CLASS=YourModel
namespace :short_url do
  desc 'create indexes'
  task create_indexes: :environment do
    logger = Rails.logger
    klass = ENV['CLASS'].to_s.camelize.safe_constantize

    if klass.nil?
      logger.warn "#{ENV['CLASS']} does not map to a class"
      return
    end

    klass.create_indexes

    logger.info "Indexes created on #{klass}"
  end
end
