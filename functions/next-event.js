// GitHub API: https://github.com/octokit/core.js
const { Octokit } = require("@octokit/core");
const github_token = process.env.GITHUB_TOKEN;

// Slack API: https://github.com/slackapi/node-slack-sdk
const { WebClient } = require('@slack/web-api');
const slack_token = process.env.SLACK_TOKEN;
const web = new WebClient(slack_token);
const octokit = new Octokit({ auth: github_token });

// The event parser is written in Ruby, so this just triggers
// the workflow with the ENVs to reply to the user.
exports.handler = async function(event, context) {
  //await octokit.request('POST /repos/{owner}/{repo}/actions/workflows/{workflow_id}/dispatches', {
    //owner: 'mikerogers0',
    //repo: 'Virtual-Coffee-Bot',
    //workflow_id: 'hourly-meeting-check.yml',
    //ref: 'feature/add-slash-command',
    //inputs: {
      //headers: event.headers,
      //body: event.body
    //}
  //})

  return {
    statusCode: 200,
    body: JSON.stringify(event.body)
  };
}
