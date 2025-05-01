# frozen_string_literal: true

require 'test_helper'

class CreateUrlServiceTest < ActiveSupport::TestCase
  test 'with valid params returns success true and a url' do
    assert_difference('Url.count', +1) do
      res = CreateUrlService.new(**{ target: 'https://www.nodz.com' }).call

      url = res.url

      assert_equal(true, res.success?)
      assert_instance_of(Url, url)
      assert_not_nil(url.slug)
      assert_not_nil(url.short)
    end
  end

  test 'returns false if params arent valid' do
    assert_no_difference('Url.count') do
      res = CreateUrlService.new(**{ target: nil }).call

      assert_equal(false, res.success?)
      assert_equal(false, res.url.persisted?)
    end
  end
end
