require 'rails_helper'

RSpec.describe SendSlackMessageJob, type: :job do
  it 'sends a Slack notification' do
    expect_any_instance_of(Slack::Notifier).to receive(:ping).with('Spam notification from zaphod@example.com')
    described_class.perform_now('Spam notification from zaphod@example.com')
  end
end
