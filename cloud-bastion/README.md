# Homework labs for the course [DevOps prctice](https://otus.ru/lessons/devops-praktiki-i-instrumenty) at [OTUS](https://otus.ru)
------------------------------------------------------------

## Lab_005 Yandex.Cloud infrastructure<a name="Lab_005"></a>
1. Create YC infra and set up SSH access via Bastion host.
2. Set up the VPN service [Pritunl](https://pritunl.com/)
3. Set SSL certificate with [Let's Encrypt](https://letsencrypt.org/) for Pritunl server.
4. Update README.md with Lab info.
5. Autotest with Github Actions and delete YC instances if ok.

### Lab_005 settings
```
    bastion_IP = 178.154.223.102
    someinternalhost_IP = 10.128.0.34
```
#### HW of [Lab_005](#Lab_005)
1. Create YC infra and set up SSH access via Bastion host.

Two Compute Clouds was created:

>**bastion** host with public ip - 178.154.223.102
>**comeinternalhost** with only lockal address

Locally generated ssh key-pair was inserted to this hosts (public key)

**~/.ssh/config** has been created to connect easily in a short format like *ssh somehost*:

```
Host bastion
    HostName 178.154.223.102
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
```
ssh inthost
```
You can also reach it with the command:
```
ssh -i ~/.ssh/appuser -A -J appuser@178.154.223.102 appuser@10.128.0.34
```

2. Set up the VPN service Pritunl

A Pritunl server was deployed on the **Bastion host** with the [setupvpn.sh](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/cloud-bastion/setupvpn.sh)

To connect to internal hosts via VPN use the [cloud-bastion.ovpn](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/cloud-bastion/cloud-bastion.ovpn) to insert the config to your openvpn client.
```
wget https://bit.ly/3mnEQfk -O cloud-bastion.ovpn
openvpn3 config-import --config cloud-bastion.ovpn
```
Then start the VPN tunnel session
```
openvpn3 session-start --config cloud-bastion.ovpn
```
3. Set SSL certificate.
To enable the Let's Encrypt bot just set the domain name [178.154.223.102.sslip.io/](178.154.223.102.sslip.io/) to the settings at *Lets Encrypt Domain* field on Pritunl web interface on **Bastion** host.

4. [README.md](https://github.com/Otus-DevOps-2021-08/laborxcom_infra/blob/cloud-bastion/README.md) updated
