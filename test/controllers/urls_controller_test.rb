# frozen_string_literal: true

require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest
  test 'POST /urls redirect to success page if service returns true' do
    params = { url: { target: 'http://www.google.com' } }
    result = build_result(true)
    mock = Minitest::Mock.new
    mock.expect(:call, result)

    CreateUrlService.stubs(:new).with(**{ 'target' => 'http://www.google.com' }).returns(mock)

    post urls_path, params: params

    assert_redirected_to(success_url(result.url))
  end

  test 'POST /urls redirect to root page if service returns false' do
    params = { url: { target: nil } }
    result = build_result(false)
    mock = Minitest::Mock.new
    mock.expect(:call, result)

    CreateUrlService.stubs(:new).with(**{ 'target' => nil }).returns(mock)

    post urls_path, params: params

    assert_redirected_to(root_url)
    assert_equal('Algo deu errado', flash[:alert])
  end

  test 'GET /success redirect to root_path if Url does not exists' do
    get success_url('invalid')

    assert_redirected_to(root_url)
  end

  test 'GET /success show the short version of url' do
    url = Url.create!(target: 'http://www.nodz.com', slug: '21312', short: 'http://0.0.0.0/31312')

    get success_url(url)

    assert_response :ok
    assert_select 'h1', 'Sua URL encurtada'
    assert_select 'input[type="url"][value=?]', url.short
    assert_match(/copiar/, response.body.encode)
  end

  test 'GET /redirect redirects to root url if url does not exists' do
    get redirect_url('invalid')

    assert_redirected_to(root_url)
  end

  test 'GET /redirect updates the url accesses and redirects to target' do
    url = Url.create!(target: 'https://www.google.com', slug: '3aa2', short: 'http://0.0.0.0/urls/3aa2', accesses: 0)

    get redirect_url(slug: url.slug)

    assert_equal(1, url.reload.accesses)
    assert_redirected_to(url.target)
  end

  private

  def build_result(res)
    result = Data.define(:url, :success?)
    url = Data.define do
      # https://api.rubyonrails.org/classes/ActiveModel/Conversion.html#method-i-to_param
      def to_param = '1'
    end

    result.new(url: url.new, success?: res)
  end
end
