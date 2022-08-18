# Action Slack Notify (forked from rtCamp/action-slack-notify)

This repo builds a Go binary based on this image and then starts it with a shell script. This avoids unnecessary usage
of Docker. It can even be used in the same way as the original. Some things have been ripped out of the shell scripts
since we provide those environment variables already, and wanted to avoid installing extra dependencies.

## How to build

### Install UPX (for packing binary)

`sudo apt install upx`

> NOTE: All builds are expected to target Linux.

### From POSIX:

`env GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o bin/slack-notify main.go`
`sudo upx --brute ./bin/slack-notify`

### From Windows (PowerShell 7+):

`$Env:GOOS = "linux"; $Env:GOARCH = "amd64"; go build -ldflags="-s -w" -o bin/slack-notify main.go`
`sudo upx --brute ./bin/slack-notify`

-------------------------------

# README

### [View the Original](https://github.com/rtCamp/action-slack-notify)

This action is a part of [GitHub Actions Library](https://github.com/rtCamp/github-actions-library/) created
by [rtCamp](https://github.com/rtCamp/).

# Slack Notify - GitHub Action

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

A [GitHub Action](https://github.com/features/actions) to send a message to a Slack channel.

**Screenshot**

<img width="485" alt="action-slack-notify-rtcamp" src="https://user-images.githubusercontent.com/4115/54996943-9d38c700-4ff0-11e9-9d35-7e2c16ef0d62.png">

The `Site` and `SSH Host` details are only available if this action is run
after [Deploy WordPress GitHub action](https://github.com/rtCamp/action-deploy-wordpress).

## Usage

You can use this action after any other action. Here is an example setup of this action:

1. Create a `.github/workflows/slack-notify.yml` file in your GitHub repo.
2. Add the following code to the `slack-notify.yml` file.

```yml
on: push
name: Slack Notification Demo
jobs:
  slackNotification:
    name: Slack Notification
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Slack Notification
        uses: rtCamp/action-slack-notify@v2
        env:
          SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
```

3. Create `SLACK_WEBHOOK` secret
   using [GitHub Action's Secret](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets-for-a-repository)
   . You can [generate a Slack incoming webhook token from here](https://slack.com/apps/A0F7XDUAZ-incoming-webhooks).

## Environment Variables

By default, action is designed to run with minimal configuration but you can alter Slack notification using following
environment variables:

Variable          | Default                                               | Purpose
------------------|-------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------
SLACK_CHANNEL     | Set during Slack webhook creation                     | Specify Slack channel in which message needs to be sent
SLACK_USERNAME    | `rtBot`                                               | Custom Slack Username sending the message. Does not need to be a "real" username.
SLACK_MSG_AUTHOR  | `$GITHUB_ACTOR` (The person who triggered action).    | GitHub username of the person who has triggered the action. In case you want to modify it, please specify corrent GitHub username.
SLACK_ICON        | ![rtBot Avatar](https://github.com/rtBot.png?size=32) | User/Bot icon shown with Slack message. It uses the URL supplied to this env variable to display the icon in slack message.
SLACK_ICON_EMOJI  | -                                                     | User/Bot icon shown with Slack message, in case you do not wish to add a URL for slack icon as above, you can set slack emoji in this env variable. Example value: `:bell:` or any other valid slack emoji.
SLACK_COLOR       | `good` (green)                                        | You can pass `${{ job.status }}` for automatic coloring or an RGB value like `#efefef` which would change color on left side vertical line of Slack message.
SLACK_LINK_NAMES  | -                                                     | If set to `true`, enable mention in Slack message.
SLACK_MESSAGE     | Generated from git commit message.                    | The main Slack message in attachment. It is advised not to override this.
SLACK_TITLE       | Message                                               | Title to use before main Slack message.
SLACK_FOOTER      | Powered By rtCamp's GitHub Actions Library            | Slack message footer.
MSG_MINIMAL       | -                                                     | If set to `true`, removes: `Ref`, `Event`,  `Actions URL` and `Commit` from the message. You can optionally whitelist any of these 4 removed values by passing it comma separated to the variable instead of `true`. (ex: `MSG_MINIMAL: event` or `MSG_MINIMAL: ref,actions url`, etc.)

You can see the action block with all variables as below:

```yml
    - name: Slack Notification
      uses: rtCamp/action-slack-notify@v2
      env:
        SLACK_CHANNEL: general
        SLACK_COLOR: ${{ job.status }} # or a specific color like 'good' or '#ff00ff'
        SLACK_ICON: https://github.com/rtCamp.png?size=48
        SLACK_MESSAGE: 'Post Content :rocket:'
        SLACK_TITLE: Post Title
        SLACK_USERNAME: rtCamp
        SLACK_WEBHOOK: ${{ secrets.SLACK_WEBHOOK }}
```

Below screenshot help you visualize message part controlled by different variables:

<img width="600" alt="Screenshot_2019-03-26_at_5_56_05_PM" src="https://user-images.githubusercontent.com/4115/54997488-d1f94e00-4ff1-11e9-897f-a35ab90f525f.png">

The `Site` and `SSH Host` details are only available if this action is run
after [Deploy WordPress GitHub action](https://github.com/rtCamp/action-deploy-wordpress).

## Credits

Source: [technosophos/slack-notify](https://github.com/technosophos/slack-notify)

## License

[MIT](LICENSE) © 2022 rtCamp

## Does this interest you?

<a href="https://rtcamp.com/"><img src="https://rtcamp.com/wp-content/uploads/sites/2/2019/04/github-banner@2x.png" alt="Join us at rtCamp, we specialize in providing high performance enterprise WordPress solutions"></a>
