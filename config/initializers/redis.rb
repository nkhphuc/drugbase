# frozen_string_literal: true

$redis = Redis::Namespace.new "redis", :redis => Redis.new