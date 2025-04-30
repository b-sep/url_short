# frozen_string_literal: true

require 'test_helper'

class ShortUrlTest < ActiveSupport::TestCase
  test 'isnt valid when url is nil' do
    url = ShortUrl.new(original_url: nil, slug: '222')

    assert_equal(true, url.invalid?)
  end

  test 'isnt valid when url has no host' do
    url = ShortUrl.new(original_url: 'http://', slug: '222')

    assert_equal(true, url.invalid?)
  end

  test 'isnt valid when url has no protocol' do
    url = ShortUrl.new(original_url: 'www.google.com.br', slug: '222')

    assert_equal(true, url.invalid?)
  end

  test 'is invalid if slug isnt unique' do
    ShortUrl.create!(original_url: 'http://www.nodz.com', slug: '222')
    url = ShortUrl.new(original_url: 'http://www.google.com.br', slug: '222')

    assert_equal(true, url.invalid?)
    assert_equal(['Slug has already been taken'], url.errors.full_messages_for(:slug))
  end
end
