# Ega-Cryptor Application
![GitHub last commit](https://img.shields.io/github/last-commit/lymphIDIBAPS/Ega_Cryptor)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/lymphIDIBAPS/Ega_Cryptor)
----
A Snakemake workflow for encrypting files before uploading them to the European Genome-Phenome Archive (EGA).

The workflow will produce EGA compliant encrypted files along with files for the encrypted and unencrypted MD5 checksums for each file in a specified input directory. The resulting output will be placed in a separate specified folder with the same directory structure as the input folder. The actual encryption is done by the EGA-Cryptor Encryption Utility.

The workflow will output three files per input file:

- `file.gpg` (encrypted file)
- `file.md5` (file md5 sum value file)
- `file.gpg.md5` (encrypted file md5 sum value file)

The EGACryptor v.2.0.0 is a JAVA-based application which enables submitters to produce EGA compliant encrypted files along with files for the encrypted and unencrypted md5sum for each file to be submitted. The application will generate an output folder that will by default mirror the directory structure containing the original files. This output folder can subsequently be uploaded to the EGA FTP staging area via an FTP or Aspera client.

The link to the GitHub repository of Ega-Cryptor is [available here](https://github.com/EbiEga/ega-cryptor), and the Ega website with information about the application is [available here](https://ega-archive.org/submission/data/file-preparation/egacryptor/).

# Table of Contents
1. [Installation](#installation)
2. [Linux](#linux)
3. [Windows](#windows)
4. [macOS](#macos)
5. [Download Ega-Cryptor](#download-ega-cryptor)
6. [Snakemake Environment](#snakemake-environment)
7. [Clone the repository](#clone-the-repository)
8. [Snakemake Usage](#snakemake-usage)
9. [Run the pipeline in a HPC](#run-the-pipeline-in-a-hpc)
10. [Configuration of the pipeline](#configuration-of-the-pipeline)
11. [Cluster Configuration](#cluster-configuration)

## Installation


### Linux
<details><summary>Linux Installation</summary>

#### Install Miniconda 3
Open a Linux shell, then run these three commands to quickly and quietly download the latest 64-bit Linux miniconda 3 installer, rename it to a shorter file name, silently install, and then delete the installer.
```bash
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
```
After installing, initialize your newly-installed Miniconda. The following commands initialize for bash and zsh shells:
```bash
~/miniconda3/bin/conda init bash
```
```zsh
~/miniconda3/bin/conda init zsh
```
You should see ```(base)``` in the command line prompt. This tells you that you’re in your base conda environment. To learn more about conda environments, see [Environments](https://docs.anaconda.com/working-with-conda/environments/).

Check for a good installation with:
```bash
conda --version
# conda 24.X.X

conda list
# outputs a list of packages installed in the current environment (base)
```
</details>

---
### Windows
<details><summary>Windows Installation</summary>

Since Windows does not have access to the majority of packages we need in the pipeline, we need to install *Linux on Windows*, also known as *WSL*. In the ***Windows Power Shell***:
```powershell
wsl --install
# This command will install the Ubuntu distribution of Linux.
```
If you run into an issue during the installation process, please check [the installation section of the troubleshooting guide](https://learn.microsoft.com/en-us/windows/wsl/troubleshooting#installation-issues).

#### Set up your Linux user info

Once you have installed WSL, you will need to create a user account and password for your newly installed Linux distribution. See the Best practices for [setting up a WSL development environment guide to learn more](https://learn.microsoft.com/en-us/windows/wsl/setup/environment#set-up-your-linux-username-and-password).

#### Install Miniconda 3
Once you have a working shell in your *WSL*, run these three commands to quickly and quietly download the latest 64-bit Linux miniconda 3 installer, rename it to a shorter file name, silently install, and then delete the installer.
```bash
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
```
After installing, initialize your newly-installed Miniconda. The following commands initialize for bash and zsh shells:
```bash
~/miniconda3/bin/conda init bash
```
```zsh
~/miniconda3/bin/conda init zsh
```
You should see ```(base)``` in the command line prompt. This tells you that you’re in your base conda environment. To learn more about conda environments, see [Environments](https://docs.anaconda.com/working-with-conda/environments/).

Check for a good installation with:
```bash
conda --version
# conda 24.X.X

conda list
# outputs a list of packages installed in the current environment (base)
```
</details>

----
### macOS
<details><summary>macOS Installation</summary>

These four commands download the latest M1 version of the MacOS installer, rename it to a shorter file name, silently install, and then delete the installer:
```bash
mkdir -p ~/miniconda3
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
```
After installing, initialize your newly-installed Miniconda. The following commands initialize for bash and zsh shells:
```bash
~/miniconda3/bin/conda init bash
```
```zsh
~/miniconda3/bin/conda init zsh
```

You should see ```(base)``` in the command line prompt. This tells you that you’re in your base conda environment. To learn more about conda environments, see [Environments](https://docs.anaconda.com/working-with-conda/environments/).

Check for a good installation with:
```bash
conda --version
# conda 24.X.X

conda list
# outputs a list of packages installed in the current environment (base)
```
<!-- #### Install mamba
Now we will install ***mamba***, that is a fast-ligthweigth package manager aking to conda.

In case you are downloading from the Clinic network, you will have trouble with the SLL certificate. TO solve any problems, do the following:
1. You can usually get a copy by clicking on the padlock icon in your browser when visiting any https site, then click around to view certificate, and download in PEM format.
Then we will point conda to it in our system. 
```bash
conda config --set ssl_verify <pathToYourFile>.pem
```

2. Next we will install mamba in our base environment with:
```bash
conda install -n base -c conda-forge mamba
```
To check:
```bash
mamba --version
# mamba 1.X.X
# conda 24.X.X
``` -->
</details>

---

### Download Ega-Cryptor

This application is available to download in [this link](https://ega-archive.org/assets/files/EgaCryptor.zip). You must unzip it and save it in a directory in your machine or in the cluster.

### Snakemake Environment
Now, with miniconda installed in our machine, we can create a new environment with snakemake installed:

```bash
conda create -c conda-forge -c bioconda -n snakemake snakemake
```

In case you are downloading from the Clinic network, you will have trouble with the SLL certificate. To solve any problems, do the following:
1. You can usually get a copy by clicking on the padlock icon in your browser when visiting any https site, then click around to view certificate, and download in PEM format.

2. Then we will point conda to it in our system. 
```bash
conda config --set ssl_verify <pathToYourFile>.pem
```

Once installed, we must activate and move into the snakemake environment with:
```bash
conda activate snakemake
snakemake --version
# 8.25.X
```
If at any time we want to exit the environment, we can with```conda deactivate```, and to get back in with ```conda activate snakemake```.
To see the packages we have currently installed in the environment, we can with```conda list```.
### Clone the repository

1. Above the list of files, click Code.

![Imgur](https://i.imgur.com/FiesQMl.png)

2. Copy the URL for the repository. To clone the repository using HTTPS, under "HTTPS", copy the link provided.
3. Open a Terminal.
4. Change the current working directory to the location where you want the cloned directory. For example, ```cd ega_cryptor```. Make sure that the directory exists before you move into it.
5. Type ```git clone git@github.com:lymphIDIBAPS/Ega_Cryptor.git```.
6. Press Enter to create your local clone.
```bash
git clone git@github.com:lymphIDIBAPS/Ega_Cryptor.git
> Cloning into `ega_cryptor`...
> remote: Counting objects: 10, done.
> remote: Compressing objects: 100% (8/8), done.
> remove: Total 10 (delta 1), reused 10 (delta 1)
> Unpacking objects: 100% (10/10), done.
```
## Snakemake Usage
When we have the cloned repository, we can proced and configure the application. To do this, we have a ***config/config.yaml*** file that we can edit.

The simple rulegraph for our pipeline at date 14/11 is the following:

![Imgur](https://imgur.com/BmWurpq.png)

In order to run the application, you must execute:
```bash
# For a test run of the pipeline
snakemake --use-conda -np

# For a real run of the pipeline
snakemake --use-conda
```

## Run the pipeline in a HPC
If we have many files to encrypt and our computer does not have enough computational power, we can run the application in a cluster. This pipeline has been prepared to run in the [StarLife](https://www.bsc.es/supportkc/docs/StarLife/intro) cluster, in the [BSC](https://www.bsc.es/).

1. Make a new directory named ***/slgpfs/*** in your computer and mount it to the same directory in StarLife:
```bash
mkdir /home/user/slgpfs
sshfs -o allow_other your_bsc_user@sl1.bsc.es:/slgpfs/ /home/user/slgpfs/
```
This will allow you to see and work on the custer from your computer system directly.

2. On your computer, navigate to the directory: ***/home/user/slgpfs/projects/group_folder***

3. Download and extract the following file to the directory, in which we have a full conda environment ready to run snakemake:
[Snakemake Conda Environment](https://drive.google.com/file/d/1ZQB02jZhhr5G_DlbhDKFHiqZ7AVuCxqx/view?usp=sharing)

4. Clone this repository in the directory, following the steps from [Clone the repository](#clone-the-repository)

5. Now, connect to the cluster:
```bash
ssh your_username@sl1.bsc.es # or
ssh your_username@sl2.bsc.es
```
6. In the cluster, navigate to the cloned repository: ***/slgpfs/projects/group_folder/ega_cryptor***

7. Now, activate the snakemake_bsc environment:
```bash
source ../snakemake_bsc/bin/activate
```
In your terminal, you should now see something like: ```(snakemake_bsc) your_username@sllogin1```


8. Now, you can run the pipeline from the cluster with the command:
```bash
# For a test run of the pipeline
snakemake --profile config/slurm/ --use-envmodules -np

# For a real run of the pipeline
snakemake --profile config/slurm/ --use-envmodules
``` 
This command above will run the pipeline with the pipeline configuration from the file located in ***/slgpfs/projects/group_folder/ega_cryptor/config/config.yaml***. Be sure to check and modify the configuration file to alter the pipeline with your desired options.

The cluster configuration file is located in ***/slgpfs/projects/group_folder/ega_cryptor/config/slurm/config.yaml***. Below you have all the options available to customize your cluster run.

## Configuration of the pipeline
### General Configuration

1. path_to_ega: path to the Ega-Cryptor .jar file in your machine, downloaded in the [Download Ega-Cryptor](#download-ega-cryptor) section of this readme.

2. input: the directory where our files to encrypt are located

3. output: where our encrypted files will be deposited in

4. resources: define the use of resources of the application, can be full, medium or low. Full is all the threads on the machine, medium uses 75% and low uses only 50%.

## Cluster Configuration
Remember to check the files in ***/config/slurm/config.yaml*** for the cluster configuration. Review all the items and in case something is not clear you can check [in this website](https://snakemake.github.io/snakemake-plugin-catalog/plugins/executor/slurm.html#advanced-resource-specifications) what each term means in the configuration. 

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

## Author
Developed by [@obaeza16](https://github.com/obaeza16), using an application developed by the European Genome-phenome Archive [(EGA)](https://ega-archive.org/about/ega/).

Mantained by [Lymphoid neoplasms program, IDIBAPS](https://www.clinicbarcelona.org/en/idibaps/programs/lymphoid-neoplasms-programme).

## License

[MIT](https://choosealicense.com/licenses/mit/)