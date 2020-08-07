# AWS CLI default profile Manager
## Overview
Changing the default profile makes it easier to use the aws cli, especially in scripts.

This program allows profile management that will control what the default runs, in an easy and expandable way
## Setup

**READ BEFORE RUNNING `setup.sh`** 

#### Python Libraries
On Linux and MacOS, make sure python3 is installed

On Windows, the curses library for python3 needs to be installed

#### CSV file

The menu is made from the csv file called `aws.csv`. 
The first field is the text to be shown on the menu. 
The second field is anything that can be run in bash.

Running the setup.sh will configure two example lines of the csv file

#### General Format

There are two steps for switching AWS CLI environments, selecting the environment


**Selecting** the environment copies or add into the existitng `~/.aws` directory

The format that environments are saved are as copies of the whole `~/.aws` directory.
For example, the `/home/user/` directory would contain the folders `.aws`,`.aws_sfl`,`.aws_cbs`,`.aws_sdc`

Some of the environments are simple copy-and-replace to select, and some could be activated by running a bash script or docker image

**Activating** the environment is the step where any 2FA comes in

Some environments activate by using the aws session token, and others just need to be set to the default profile for activation

#### Example CSV
Here is an example `aws.csv` file to show the different parts

```csv
Verify ID, aws sts get-caller-identity; aws s3 ls
Select SFL,/home/nick/Git/DevSetup/copy_dir_to_dot_aws /home/nick/.aws_sfl
Activate SFL,echo "run the command '. /home/nick/Git/DevSetup/aws_set'"
Select CBS,/home/nick/Git/DevSetup/copy_dir_to_dot_aws /home/nick/.aws_cbs
Activate CBS,echo "Should not need activation"
Select SDC,docker run -it --rm --net=host -e TZ=America/Chicago -v ~/.aws:/root/.aws ac0a9c401fd3
Activate SDC,sed -i 's/default/olddefault/g' /home/nick/.aws/credentials; sed -i 's/sdc-mfg-dev:Developer/default/g' /home/nick/.aws/credentials;
```

And this is how it is displayed when ran
[](!menu_ex.png)

The first line
`Verify ID, aws sts get-caller-identity; aws s3 ls`


The included `aws.csv` has the same "Verify ID" line as well as a template line for selecting and activating
 



## Usage

### Adding Environments

Simply add a new entry to the `aws.csv` file to add it to the options

See the setup/csv section for more details


### Running

Run with the command chosen during setup (default `awss`)

First select the environment you want, then run the command again and activate the same environment


- Uses up and down arrows to move selection
- Enter key to select
- Number on side to select
- Key in brackets to select
  - Ex: The `a` key would select the item`[A]ctivate SFL` and the `c` key would select `A[c]tivate SFL` 


Menu system is adapted from [here](https://github.com/nickssmith/dyn-menu) for more info
