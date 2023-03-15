require 'slack-notifier'

SLACK_NOTIFIER = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL']
