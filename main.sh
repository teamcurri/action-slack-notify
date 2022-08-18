#!/usr/bin/env bash

if [[ -z "$SLACK_WEBHOOK" ]]; then
  printf "[\e[0;31mERROR\e[0m] Secret \$SLACK_WEBHOOK is missing. Please add it to this action for proper execution.\nRefer https://github.com/rtCamp/action-slack-notify for more information.\n"
  exit 1
fi

export GITHUB_BRANCH=${GITHUB_REF##*heads/}
export SLACK_ICON=${SLACK_ICON:-"https://avatars0.githubusercontent.com/u/43742164"}
export SLACK_USERNAME=${SLACK_USERNAME:-"rtBot"}
export CI_SCRIPT_OPTIONS="ci_script_options"
export SLACK_TITLE=${SLACK_TITLE:-"Message"}
export COMMIT_MESSAGE=$(cat "$GITHUB_EVENT_PATH" | ./bin/jq -r '.commits[-1].message')
export GITHUB_ACTOR=${SLACK_MSG_AUTHOR:-"$GITHUB_ACTOR"}

PR_SHA=$(cat $GITHUB_EVENT_PATH | ./bin/jq -r .pull_request.head.sha)
[[ 'null' != $PR_SHA ]] && export GITHUB_SHA="$PR_SHA"

if [[ -n "$SITE_NAME" ]]; then
  export SITE_TITLE="Site"
fi

if [[ -z "$SLACK_MESSAGE" ]]; then
  export SLACK_MESSAGE="$COMMIT_MESSAGE"
fi

./bin/slack-notify "$@"
