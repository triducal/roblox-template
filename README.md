<!-- Allow this file to not have a first line heading -->
<!-- markdownlint-disable-file MD041 no-emphasis-as-heading -->

<!-- inline html -->
<!-- markdownlint-disable-file MD033 -->

<div align="center">

<!--- FIXME: Pick an emoji and name your project! --->
# `📦 Roblox Template`

<!--- FIXME: Write short catchy description/tagline of project --->
**An easy to use Roblox project template with automatic deployment**

</div>

## 📝 Overview

This template serves as an easy starting point for getting my projects shipped, without the grueling process of setting up an initial repository every time I start working on a new game. This template can be used by anyone but may have some niche ways of doing things that may need to be switched up for how you want to setup your own project.

Using Mantle combined with Github Workflows, I am able to have new commits automatically deployed to Roblox without having to manually set everything up in Studio. Setting up API keys will be explained further down in the README.

**The tools used in this project include:**

-   [Darklua](https://darklua.com/)
-   [Rojo](https://rojo.space/)
-   [Rokit](https://github.com/rojo-rbx/rokit)
-   [Wally](https://wally.run/)
-   [Mantle]("https://mantledeploy.vercel.app/")
-   [Selene]("https://github.com/Kampfkarren/selene")
-   [Stylua]("https://github.com/JohnnyMorganz/StyLua")
-   [LuauLSP]("https://github.com/JohnnyMorganz/luau-lsp")

**The libraries used in this project include:**

-   📦 [Reflex](https://github.com/littensy/reflex): An all-in-one state container
-   🖥️ [Fusion](https://elttob.uk/Fusion/latest/): A modern reactive UI library
-   💎 [Lapis](https://nezuo.github.io/lapis): Immutable data store abstraction
-   🔥 [Remo](https://github.com/littensy/remo): Simple and type-safe remote library

## 🚀 Quick Start

1. Press the green `Use this template` button on the top right of the page to create a new repository.
2. Clone the repository to your local machine.
3. Run `sh scripts/dev.sh` to start the development server.
4. Start coding! 🎉

## 🔨 Setup

This will be a guide for setting everything up and general explanations of my workflow. Not everything will be covered but most subjects will be.

### Github Workflows

Github Workflows is my favorite part of this template and makes deploying game changes so much easier. If you've never used Mantle in the past, setting everything up properly might be slightly confusing so I will explain everything that needs to be known in this section. A few API keys will be needed in order for this to work.

#### Adding Keys

Go to your project settings and click `Secrets and variables` and then click `Actions`. There should be a button to add a new repository secret, this is where all your keys will need to be added.

#### ROBLOSECURITY

Navigate to [Roblox]("https://roblox.com") in your browser and open the dev tools (right-click and select "Inspect"). Navigate to the "Application" tab, then look for "Cookies" under "Storage" in the left-hand sidebar. Under "Cookies", select `https://www.roblox.com` then select `.ROBLOSECURITY` from the list of cookies. Copy the value from the "Cookie Value" section.

#### MANTLE_OPEN_CLOUD_API_KEY

Mantle needs your Open Cloud API in order to upload new places. Follow the [official Roblox Guide]("https://create.roblox.com/docs/cloud/open-cloud/api-keys") for creating a Cloud API key. You must grant the key access to Place Publishing for all experiences you want Mantle to handle. This can be done through the `universe-places` API system.

#### MANTLE_AWS_ACCESS_KEY_ID & MANTLE_AWS_SECRET_ACCESS_KEY

Both of these keys are needed for remote state management with Mantle. Mantle supports managing remote state files using AWS S3 storage which requires authentication.

If you are new to using AWS, I recommend you read their guide on [best practices for managing AWS access keys]("https://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html") before getting started.

To learn how to get an access key ID and secret, you can read their guide on [understanding and getting your AWS credentials]("https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html") (read the intro and "Programmatic access" sections).

### Mantle Config

Looking in the template, you will be able to find a `mantle.yaml` file. This is where you can make changes to your Roblox experience. In the last section you set up your AWS bucket, which will be needed for the config here. At the top of the config file should be a `region`, `bucket`, and `key` key. This is where you will enter your bucket region, name, with the key being a unique identifier relating to your game.

The rest of the configurations are pretty self explanatory so I wont cover them here, but anything you need help with should be covered on the [Mantle website](""https://mantledeploy.vercel.app/").

### String requires

This project is setup using string requires with Darklua. Multiple shorcuts already exist such as `@Services` and `@Controllers` for quickly accessing different paths in your codebase. Adding more directory alliases isn't too difficult and just need to be added to two different places. Within `.darklua.json` you will be able to see a list of the already setup alliases. If you want to add any more they just need to be added to this list along with the one in `.vscode/settings.json` for autocomplete.

### Bash scripts

Bash scripts are my preferred method of running scripts. the only two you will need to touch are `dev.sh` and `install-packages.sh`. Whenever you add a new package to `wally.toml`, you should run install-packages in order to use WallyPackageTypes. A lot of Wally packages have issues exporting types needed, so using this allows there to be no issues. This script is just a shortcut for setting all of that up.

Whenever you are wanting to test your game within Studio, just run the `dev.sh` script to start the Rojo server. Soon in the future I will be setting up a way to automatically open up studio whenever this is ran.

### Interacting with Workspace

I need to have Rojo fully managed in order to easily integrate my repository with Mantle. All of my Workspace objects are stored in `assets/game.rbxm`. Whenever adding your own assets, you can export them from studio and place them here.

### Game Assets

TODO
