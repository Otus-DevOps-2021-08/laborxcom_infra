# Homework labs for the course [DevOps prctice](https://otus.ru/lessons/devops-praktiki-i-instrumenty) at [OTUS](https://otus.ru)

## Lab_005 Yandex.Cloud infrastructure

1. Create YC infra and set up SSH access via the Bastion host.
2. Set up VPN service [Pritunl](https://pritunl.com/)
3. Set SSL certificate with [Let's Encrypt](https://letsencrypt.org/) for Pritunl server.
4. Update the README.md with Lab info.
5. Autotest with the Github Actions and delete YC instances if ok.

### Lab_005 settings

```text
    bastion_IP = 84.252.129.223
    someinternalhost_IP = 10.128.0.34
```

#### HW of [Lab_005](#Lab_005)

##### Task 1

Create YC infra and set up SSH access via the Bastion host.

Two Compute Clouds was created:

**bastion** host with public ip - 84.252.129.223
**comeinternalhost** with only lockal address

Locally generated ssh key-pair was inserted to this hosts (public key)

**~/.ssh/config** has been created to connect easily in a short format like *ssh somehost*:

```ssh
Host bastion
    HostName 84.252.129.223
    User appuser
    IdentityFile ~/.ssh/appuser
    ForwardAgent yes
Host inthost
    HostName 10.128.0.34
    User appuser
    IdentityFile ~/.ssh/appuser
    ForwardAgent yes
    ProxyJump bastion
```

So, to connect to **someinternalhost** via **bastion** just type:

```bash
ssh inthost
```

You can also reach it with the command:

```bash
ssh -i ~/.ssh/appuser -A -J appuser@84.252.129.223 appuser@10.128.0.34
```

##### Task 2

Set up the VPN service Pritunl

A Pritunl server was deployed on the **Bastion host** with the [setupvpn.sh](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/cloud-bastion/setupvpn.sh)

To connect to internal hosts via VPN use the [cloud-bastion.ovpn](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/cloud-bastion/cloud-bastion.ovpn).
To insert the config to your openvpn client:

```bash
wget https://bit.ly/3mnEQfk -O cloud-bastion.ovpn
openvpn3 config-import --config cloud-bastion.ovpn
```

Then start the VPN tunnel session

```bash
openvpn3 session-start --config cloud-bastion.ovpn
```

(3) Set SSL certificate.
To enable the Let's Encrypt bot just set the domain name **84.252.129.223.sslip.io** to the settings at *Lets Encrypt Domain* field on Pritunl web interface on **Bastion** host.

(4) [README.md](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/cloud-bastion/README.md) updated

## Lab_006 Test App deploy

### Task Lab_006

1. Setup YC console.
2. Create a host by YC CLI.
3. Install **Ruby** and **MongoDB**.
4. Deploy an App and check the functionality.
5. Create the Bash-scripts to that steps automatically.
6. Create a metadata.yaml
7. Create an infra and deploy the app with one command at YC CLI.

Steps 1-4 has done.

#### The scripts

(5) Scripts:

[install_ruby.sh](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/cloud-testapp/install_ruby.sh)

[install_mongodb.sh](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/cloud-testapp/install_mongodb.sh)

[deploy.sh](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/cloud-testapp/deploy.sh)

(6) [Metadata.yaml](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/cloud-testapp/metadata.yaml) describes the environment the App will be run in.

(7) Check the app with [link](https://178.154.209.113:9292)

```text
testapp_IP = 178.154.209.113
testapp_port = 9292
```

## Lab_007 Create a VM image with Packer

### Task Lab_007

1. Configure Packer account in YC CLI.
2. Create a Packer template.
3. Create an image in YC with Packer template and deploy an app.
4. Configure parameters and hide secrets from git.
5. \* Create a bake image to deploy an app with one command.

* Packer template [ubuntu16.json](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/packer-base/packer/ubuntu16.json)
* Packer variables.json added to .gitignore to hide secrets.
* Scripts to make the image and deploy apps:

[install_ruby.sh](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/packer-base/packer/scripts/install_ruby.sh)

[install_mongodb.sh](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/packer-base/packer/scripts/install_mongodb.sh)

[deploy.sh](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/packer-base/packer/scripts/deploy.sh)

* A baked image created with [immutable.json](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/packer-base/packer/immutable.json)

To start a VM with the Puma app deployed run the [create-reddit-vm.sh](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/packer-base/config-scripts/create-reddit-vm.sh) script with parameter file [create-reddit-vm.yaml](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/packer-base/config-scripts/create-reddit-vm.yaml) (should be placed to the same folder as the script is).

The script will create a VM based on previously created reddit-full image with all necessary components installed in it.

To check the result go to <http://VM-ip:9292> the Monolith reddit app will appear.

---

## Lab_008 Terraform-1

### Task Lab_008

1. Create Terraform config files.
2. Create a VM in YC with Terraform template and deploy an app.
3. Configure parameters and hide secrets from git.
4. \* Configure a Load Balancer to deploy an app with two instances and check the app availability.

To check the result go to <http://VM-ip:9292> the Monolith reddit app will appear.

---

## Lab_009 Terraform-2 (Modules and remote .state)

1. Divide App and DB to separate VMs with packer.
2. Create modules for **App**, **DB**  and **VPC** in dir _modules_.
3. Modify outputs to use **app** and **db** module instances.
4. Run _terraform get_ to apply modules. Check with _tree .terraform_.
5. Create **Stage** and **Prod** infras to use the same modules (DRY forever).
6. Correct path to modules. Format configs with _terraform fmt_.
7. Get to know [Terraform registry](https://registry.terraform.io/).
8. \* Configure **remote backend** to store state file. Check remote sharing of sate.
9. \** Add provisioner to module **app** (templatefile to provide db-ip).
10. \** Configure parameters to switch provisioner using (_resource "null_recource" "deploy"_).

* Test with URL _http://VM-app-ip:9292_

---
