# frozen_string_literal: true

class HomeController < ApplicationController # rubocop:disable Style/Documentation
  def main
    @url = Url.new
  end
end
