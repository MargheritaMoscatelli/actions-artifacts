# actions-artifacts

Sample public repository for investigating how to use Github Actions Artifacts.

https://docs.github.com/en/free-pro-team@latest/rest/reference/actions#list-workflow-runs-for-a-repository

jq tutorial: https://stedolan.github.io/jq/tutorial/

```
curl   -H "Accept: application/vnd.github.v3+json"   https://api.github.com/repos/tandeday/actions-artifacts/actions/runs?branch=main | jq -r '. | .workflow_runs[0].artifacts_url '
```

https://gist.github.com/umohi/bfc7ad9a845fc10289c03d532e3d2c2f




