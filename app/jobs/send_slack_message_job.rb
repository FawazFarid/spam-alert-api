class SendSlackMessageJob < ApplicationJob
  queue_as :default

  def perform(msg)
    SLACK_NOTIFIER.ping msg
  end
end
