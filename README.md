# Tailwind UI Crawler Action

> Automate the crawling and cataloging of the Tailwind UI components

[![GitHub Actions Example/Test](https://github.com/GregBrimble/tailwindui-crawler-action/workflows/Example/Test/badge.svg)](https://github.com/GregBrimble/tailwindui-crawler-action/actions?query=workflow%3AExample%2FTest)

## Usage

As a part of your [GitHub Actions](https://github.com/features/actions) workflow, add a new step as follows:

```yml
name: Deploy
on:
  push:
  schedule:
    - cron: "0 0 * * *" # Every day at midnight
jobs:
  deploy:
    name: Deploy
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Run crawler
        uses: gregbrimble/tailwindui-crawler-action@v1.0.0
        with:
          email: ${{ secrets.TAILWINDUI_EMAIL }}
          password: ${{ secrets.TAILWINDUI_PASSWORD }}
```

Read more about the schedule cron syntax in [the official GitHub Actions documentation](https://help.github.com/en/actions/reference/events-that-trigger-workflows#scheduled-events-schedule).

We strongly advise utilizing [GitHub Actions secrets](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets) to securely store your TailwindUI email and password.

A full example can be found in [`.github/workflows/default.yml`](https://github.com/GregBrimble/tailwindui-crawler-action/blob/master/.github/workflows/default.yml).

## Advanced

The following input options are available:

| Name       | Value                                     |
| ---------- | ----------------------------------------- |
| `email`    | Your tailwindui.com account email address |
| `password` | Your tailwindui.com account password      |

Note: If using a separate private repository for the output, you must include a Personal Access Token in the `token` input, as the `{{ github.token }}` tokens are scoped to only the current repository.

## Roadmap

[] Specify crawler version
[] Create a PR against the output repository
