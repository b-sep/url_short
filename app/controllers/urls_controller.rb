# frozen_string_literal: true

class UrlsController < ApplicationController # rubocop:disable Style/Documentation
  def create
    result = CreateUrlService.new(**url_params.to_h).call

    case result.success?
    in true  then redirect_to(success_url(result.url))
    in false then redirect_to(root_url, alert: 'Algo deu errado')
    end
  end

  def success
    @url = Url.find(params[:id])
  end

  def redirect
    @url = Url.find_by(slug: params[:slug])

    @url or (redirect_to root_url and return)

    @url.accesses += 1
    @url.save

    redirect_to @url.target, allow_other_host: true
  end

  private

  def url_params
    params.expect(url: %i[target])
  end
end
