# frozen_string_literal: true

class HomeController < ApplicationController # rubocop:disable Style/Documentation
  def main
    @short_url = ShortUrl.new
  end
end
