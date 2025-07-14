# AWS CLI default profile Manager
## Overview
This program allows management of the AWS *default* profile

![example screenshot](./menu_ex.png)

## Setup

### Installing 

Running `./setup.sh` will
- update the script configs in this directory function as the local installation of this tool
- add the alias `awss` to your `~/.zshrc` file to bring up the menu

### AWS Environment Setup

Follow the steps [here](https://docs.dev.platform-services.dev1.poweredbyvia.com/welcome/onboarding/aws/) for VIA aws cli access and validation

**The following steps must be repeated for each AWS environment added**

Open your `~/.aws/config` file, it should look like this after AWS setup
```
[profile workspace-user]
sso_session = aws-commercial
sso_account_id = <account id>
sso_role_name = workspace-user

[profile vianeer]
sso_session = aws-commercial
sso_account_id = <account id>
sso_role_name = vianeer

[sso-session aws-commercial]
sso_start_url = https://<account id>.awsapps.com/start
sso_region = us-east-2
sso_registration_scopes = sso:account:access
```

Duplicate the section of the config for your profile that you want to act as the default, in this case `vianeer`
```
[profile workspace-user]
sso_session = aws-commercial
sso_account_id = <account id>
sso_role_name = workspace-user

[profile vianeer]
sso_session = aws-commercial
sso_account_id = <account id>
sso_role_name = vianeer

[profile vianeer]
sso_session = aws-commercial
sso_account_id = <account id>
sso_role_name = vianeer

[sso-session aws-commercial]
sso_start_url = https://<account id>.awsapps.com/start
sso_region = us-east-2
sso_registration_scopes = sso:account:access
```
Rename the duplicate profile header to `[default]` from `[profile <profile name>]`

```
[profile workspace-user]
sso_session = aws-commercial
sso_account_id = <account id>
sso_role_name = workspace-user

[default]
sso_session = aws-commercial
sso_account_id = <account id>
sso_role_name = vianeer

[profile vianeer]
sso_session = aws-commercial
sso_account_id = <account id>
sso_role_name = vianeer

[sso-session aws-commercial]
sso_start_url = https://<account id>.awsapps.com/start
sso_region = us-east-2
sso_registration_scopes = sso:account:access
```

Run the `awss` command and select `Add new AWS env` and follow the prompts.

These are the prompts and answers to expect for the example of adding `new-profile-name` that is part of the `aws-commercial` sso setup (all text after `:` is user entered on each line)
1. `Enter a name for the aws environment to add: new-profile-name`
1. `Does the environment need a command to activate it? (y/n): y`
1. `Is the environment the current ~/.aws default one? (y/n): y`
1. `Copying environment into ~/.aws_new-profile-name` will be printed
1. `Enter the command that is used to activate the environment: aws sso login --sso-session aws-commercial`
1. `Added new-profile-name` will be printed

Now in the `awss` menu there will be a new items that look like:
```
3. [S]elect new-profile-name
4. A[c]tivate new-profile-name
```

Repeat these steps to add different AWS profiles for any environments that are needed (dev, prod etc)

## General Usage

#### Selecting Item from Menu
Items can be selected from the menu by
- navagation using the arrow keys and pressing enter
- pressing the number key for the selected item (1-9)
- pressing the key on the keyboard for the item that has `[]` around it (ex: `S[e]lect ...` would be selected and ran by pressing `e`)


#### Changing AWS Environments
There are two steps for switching AWS CLI environments;

**Selecting** the environment copies the environment over the `~/.aws` directory.

The format that environments are saved are as copies of the whole `~/.aws` directory.
For example, the `/home/user/` directory would contain the folders `.aws`,`.aws_vianeer-dev`,`.aws_vianeer-prod`

**Activating** the environment is the step where any 2FA comes in

The activate command will be either the same or similar for all aws environments `aws sso login --sso-session aws-commercial` 

To **verify** the correct aws environment is selected, the first option of ` 1. [V]erify ID` will run both a `sts get-caller-identity` and `aws s3 ls` to give two possible recognizable outputs at a glance.

## How it works

### Scripts
The program is made up of many smaller scripts:
- `add_env` bash script that walks through the setup steps for new AWS environments
- `menu.py` python that creates a menu from a `.csv` file (see [csv file](#csv-file) for more details)
- `copy_dir_to_dot_aws` bash script that just copies a directory name that it assumes is in `~/.<name>` over the `~/.aws` directory
- `aws` bash script that runs `menu.py` and ensures no errors around the temporary scripts that it will create

### CSV file

The menu is made from the csv file called `aws.csv`. 
The first field is the text to be shown on the menu. 
The second field is anything that can be run in a single shell, excluding pipes.

When an item is selected from the menu, the content of the second field is put into a `temp` file that is then ran from a bash sub-shell via `. ./temp`