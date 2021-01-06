#!/bin/sh

# https://docs.github.com/en/free-pro-team@latest/rest/reference/actions#list-workflow-runs-for-a-repository
GITHUB_API_URL=https://api.github.com/repos/tandeday/odin-api-foundation/actions/runs?branch=master

# Provide Github Personal Access Token (https://github.com/settings/tokens) with SSO enabled.
GITHUB_API_AUTH='Authorization: token ...'

curl -s -S -H "${GITHUB_API_AUTH}" -H "Accept: application/vnd.github.v3+json" "$GITHUB_API_URL" \
    | tee all-runs-on-branch.json \
    | jq '.workflow_runs| map(select((.status == "completed") and (.name | contains("3.1"))))' \
    | tee completed-runs-of-desired-job.json \
    | jq '.[0]' \
    | tee latest-run-of-desired-job.json \
    | jq '(.artifacts_url)' \
    | tee artifact_url.txt \
    | xargs curl -J -L -s -S -H "${GITHUB_API_AUTH}" -H "Accept: application/vnd.github.v3+json" \
    | tee artifacts-for-latest-run-of-desired-job.json \
    | jq '.artifacts[0].archive_download_url' \
    | tee archive_download_url.txt \
    | xargs curl -J -L  -H "${GITHUB_API_AUTH}" -H "Accept: application/vnd.github.v3+json" -o downloaded-artifact.zip


unzip -l downloaded-artifact.zip

