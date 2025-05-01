# frozen_string_literal: true

require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  test 'isnt valid when target is nil' do
    url = Url.new(target: nil, slug: '222', short: 'short_version')

    assert_equal(true, url.invalid?)
  end

  test 'isnt valid when target has no host' do
    url = Url.new(target: 'http://', slug: '222', short: 'short_version')

    assert_equal(true, url.invalid?)
  end

  test 'isnt valid when target has no protocol' do
    url = Url.new(target: 'www.google.com.br', slug: '222', short: 'short_version')

    assert_equal(true, url.invalid?)
  end

  test 'is invalid if slug isnt unique' do
    Url.create!(target: 'http://www.nodz.com', slug: '222', short: 'short_version1')
    url = Url.new(target: 'http://www.google.com.br', slug: '222', short: 'short_version2')

    assert_equal(true, url.invalid?)
    assert_equal(['Slug has already been taken'], url.errors.full_messages_for(:slug))
  end

  test 'is invalid if short isnt unique' do
    Url.create!(target: 'http://www.nodz.com', slug: '111', short: 'short_version')
    url = Url.new(target: 'http://www.google.com.br', slug: '222', short: 'short_version')

    assert_equal(true, url.invalid?)
    assert_equal(['Short has already been taken'], url.errors.full_messages_for(:short))
  end
end
