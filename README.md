# Spam alert API
A production-ready endpoint that accepts a JSON payload and sends an alert to a Slack channel if the payload is spam.

## Setup
- Create your own Incoming Webhook on Slack API. Follow [these instructions](https://api.slack.com/messaging/webhooks).

- Clone the repo and `cd` into it
  ```shell
  git clone https://github.com/FawazFarid/spam-alert-api.git && cd spam-alert-api
  ```

- Install required gems

  ```shell
  bundle install
  ```

- Copy the contents of `.env.example` into `.env` file and edit the `SLACK_WEBHOOK_URL` env variable to point to your Slack your own webhook URL.

  ```shell
  cp .env.example .env
  ```

## Usage

### Start Rails Server

```shell
rails s
```

### Using spam payload (sends notification):

```shell
curl -X POST \
  http://localhost:3000/api/v1/webhooks \
    -H 'Content-Type: application/json' \
    -d '{
    "RecordType": "Bounce",
    "Type": "SpamNotification",
    "TypeCode": 512,
    "Name": "Spam notification",
    "Tag": "",
    "MessageStream": "outbound",
    "Description": "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
    "Email": "zaphod@example.com",
    "From": "notifications@honeybadger.io",
    "BouncedAt": "2023-02-27T21:41:30Z"
  }'
```

### Using any other payload (**does not** sends the notification):

```shell
curl -X POST \
  http://localhost:3000/api/v1/webhooks \
    -H 'Content-Type: application/json' \
    -d '{
    "RecordType": "Bounce",
    "MessageStream": "outbound",
    "Type": "HardBounce",
    "TypeCode": 1,
    "Name": "Hard bounce",
    "Tag": "Test",
    "Description": "The server was unable to deliver your message (ex: unknown user, mailbox not found).",
    "Email": "arthur@example.com",
    "From": "notifications@honeybadger.io",
    "BouncedAt": "2019-11-05T16:33:54.9070259Z"
}'
```

## Running tests

**running all tests**

```shell
$ bundle exec rspec
```

**running a single test**

```shell
$ bundle exec rspec spec/requests/api/v1/webhooks_spec.rb
```
