# Tailwind UI Crawler Action

> Automate the crawling and cataloging of the Tailwind UI components

[![GitHub Actions Example/Test](https://github.com/GregBrimble/tailwindui-crawler-action/workflows/Example/Test/badge.svg)](https://github.com/GregBrimble/tailwindui-crawler-action/actions?query=workflow%3AExample%2FTest)

## Usage

1. [Create a **private** GitHub repository](https://github.com/new/).
1. [Add `TAILWINDUI_EMAIL` and `TAILWINDUI_PASSWORD` secrets to the GitHub repository](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets).
1. [Optionally create a `.env` file with additional settings for the crawler](https://github.com/kiliman/tailwindui-crawler#%EF%B8%8F-example-env-file).
1. Create a new file `.github/workflows/default.yml`:

   ```yml
   name: Update
   on:
     schedule:
       - cron: "0 0 * * *" # Every day at midnight

   jobs:
     update:
       name: Update
       runs-on: ubuntu-latest
       steps:
         - name: Checkout
           uses: actions/checkout@v2
         - name: Run crawler
           uses: gregbrimble/tailwindui-crawler-action@v1.0.0
           with:
             email: ${{ secrets.TAILWINDUI_EMAIL}}
             password: ${{ secrets.TAILWINDUI_PASSWORD }}
   ```

   Read more about the schedule cron syntax in [the official GitHub Actions documentation](https://help.github.com/en/actions/reference/events-that-trigger-workflows#scheduled-events-schedule).

A live example can be found in [`.github/workflows/default.yml`](https://github.com/GregBrimble/tailwindui-crawler-action/blob/master/.github/workflows/default.yml).

### Email Notifications

To be emailed whenever there is a change to a component, simply setup [GitHub Notifications](https://help.github.com/en/github/administering-a-repository/about-email-notifications-for-pushes-to-your-repository#enabling-email-notifications-for-pushes-to-your-repository) on your repository.

## Advanced

The following input options are available:

| Name            | Value                                                                                                                                                                    | Required? | Notes                                                                                                                                                                     |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `email`         | Your tailwindui.com account email address                                                                                                                                | Yes       |                                                                                                                                                                           |
| `password`      | Your tailwindui.com account password                                                                                                                                     | Yes       |                                                                                                                                                                           |
| `token`         | [A GitHub Personal Access Token](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line) with the `repo` scope | No        | Defaults to the automatically provided [`{{ github.token }}`](https://help.github.com/en/actions/configuring-and-managing-workflows/authenticating-with-the-github_token) |
| `output`        | The repository to output to <br /> e.g. `gregbrimble/tailwindui`                                                                                                         | No        | Defaults to the current repository (`{{ github.repository }}`)                                                                                                            |
| `commitmessage` | The message to commit with in the output repository                                                                                                                      | No        | Defaults to `Update tailwindui.com`                                                                                                                                       |
| `branch`        | The branch to commit changes to                                                                                                                                          | No        | Defaults to `master`                                                                                                                                                      |
| `force`         | `true` \| `false`                                                                                                                                                        | No        | Defaults to `false`                                                                                                                                                       |
| `actor`         | The GitHub user to commit changes with <br />e.g. `gregbrimble`                                                                                                          | No        | Defaults to the current user (`{{ github.actor }}`)                                                                                                                       |
| `repository`    | The workspace repository <br />e.g. `gregbrimble/tailwindui`                                                                                                             | No        | Defaults to the current repository (`{{ github.repository }}`). Should contain a `.env` file in the root.                                                                 |
| `crawler`       | The repository of the crawler to use                                                                                                                                     | No        | Defaults to `kiliman/tailwindui-crawler`                                                                                                                                  |
| `crawlerref`    | The ref (branch, tag or SHA) to checkout of the crawler repository                                                                                                       | No        | Defaults to `master`                                                                                                                                                      |

Note: If using a separate private repository for the output, you must include a Personal Access Token in the `token` input, as the `{{ github.token }}` tokens are scoped to only the current repository.
