require_relative '../statistics.rb'

namespace :statistics do
  desc '指定期間/プロバイダのイベント履歴を集計します'
  task :aggregation, [:from, :to, :provider] => :environment do |tasks, args|
    EventHistory.transaction do
      Statistics::Aggregation.new(args).run
    end
  end

  desc 'キーワードからイベント情報を検索します'
  task :search, [:keyword] => :environment do |tasks, args|
    raise ArgumentError, 'Require the keyword' if args[:keyword].nil?

    require 'pp'

    puts 'Searching Connpass'
    pp EventService::Providers::Connpass.new.search(keyword: args[:keyword])

    puts 'Searching Doorkeeper'
    pp EventService::Providers::Doorkeeper.new.search(keyword: args[:keyword])
  end
end
