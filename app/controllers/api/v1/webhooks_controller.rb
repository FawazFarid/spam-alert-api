class Api::V1::WebhooksController < ApplicationController
  def create
    if spammy?
      msg = 'Spam notification alert'
      msg += " from #{params[:Email]}" if params[:Email].present?

      SendSlackMessageJob.perform_later(msg)
    end
    render status: :ok
  end

  private

  def spammy?
    params[:Type] == 'SpamNotification'
  end
end
