# frozen_string_literal: true

class UrlsController < ApplicationController # rubocop:disable Style/Documentation
  def create
    result = CreateUrlService.new(**url_params.to_h).call

    case result.success?
    in true  then redirect_to(success_url(result.url))
    in false then redirect_to(root_url, alert: 'Something went wrong')
    end
  end

  private

  def url_params
    params.expect(url: %i[target])
  end
end
