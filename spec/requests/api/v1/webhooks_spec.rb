require 'rails_helper'

RSpec.describe 'Api::V1::Webhooks', type: :request do
  describe 'POST #create' do
    context 'when the payload is a spam notification' do
      let(:payload) do
        {
          "RecordType": 'Bounce',
          "Type": 'SpamNotification',
          "TypeCode": 512,
          "Name": 'Spam notification',
          "Tag": '',
          "MessageStream": 'outbound',
          "Description": 'The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.',
          "Email": 'zaphod@example.com',
          "From": 'notifications@honeybadger.io',
          "BouncedAt": '2023-02-27T21:41:30Z'
        }
      end

      it 'triggers job to send Slack notification' do
        expect do
          post api_v1_webhooks_path, params: payload
        end.to have_enqueued_job(SendSlackMessageJob)
        expect(response).to be_successful
      end
    end

    context 'when the payload is not a spam notification' do
      let(:payload) do
        {
          "RecordType": 'Bounce',
          "MessageStream": 'outbound',
          "Type": 'HardBounce',
          "TypeCode": 1,
          "Name": 'Hard bounce',
          "Tag": 'Test',
          "Description": 'The server was unable to deliver your message (ex: unknown user, mailbox not found).',
          "Email": 'arthur@example.com',
          "From": 'notifications@honeybadger.io',
          "BouncedAt": '2019-11-05T16:33:54.9070259Z'
        }
      end

      it 'does not trigger job to send Slack notification' do
        expect do
          post api_v1_webhooks_path, params: payload
        end.not_to have_enqueued_job(SendSlackMessageJob)
        expect(response).to be_successful
      end
    end
  end
end
