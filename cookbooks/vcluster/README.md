# vcluster : One click deployment of load balanced scalable and tired application.

**Purpose**: 
1. Keep static content of web application seperate from backend server to make loosly coupled frontend asset with backend code and reduce build-release cycle.
2. FrontEnd system can be act as CDN to serve static assets for your application.
3. Backend system can scale in number enabling load balanced and high availability of application.

**Description**: 
- Vagrant is used to provision ***one frontend web server and maximum three backend application servers*** (as in vm). 
- Nginx is used as loadbalancer and reverse proxy to ***load balance backend servers***  incase one of application server goes down.
- Environement files are used to manage application environments like ```training``` and ```production``` but they are taken care from vagrant specified jsons.

# Prerequisite (Default settings configured):
1. **Required gem ( json ) for vagrant**: run ```gem install json``` or ``` bundle install ``` from ```...cookbooks/vcluster``` directory.
2. **Required Vagrant plugin** (vagrant-berkshelf and vagrant-omnibus): 
    - run ```vagrant plugin install vagrant-berkshelf```
    - run ```vagrant plugin install vagrant-omnibus```
3. **Update** ```vcluster/cookbooks/vcluster/bootstrap.json``` for environment ("training" / "production") and number of backend java application servers
4. **Frontend .zip path** : ```vcluster/cookbooks/vcluster/vcluster_web/web.zip``` , this is local path. From central repo we can download and keep on localpath
5. **Backend .war path**: ```vcluster/cookbooks/vcluster/vcluster_app/sample.war``` , this is local path. From central repo we can download and keep on localpath

***Note:***
    1. Hope CHEFDK is already installed . [https://docs.chef.io/install_dk.html]
    2. As most of chef attributes are provided from Vagrant configurations, we have not fully levereged environment files to pin cookbook version and any attributes


# Components
- **Nginx (192.168.11.11)**:- Front end web server which act as loadbalancer for Backend fleet of server (max fleet=3 in vagrant)
- **Tomcat8 (192.168.11.21,22,23)**:- sample.war file is deployed, webapplication pull vcluster.png from Frontend server.
- **Java8** Oracle flavor is installed


# run_list to configure frontend and backend
- **Frontend box**: ``` "recipe[vcluster::web_lwrp]" ```  or ``` "recipe[vcluster::frontend]" ```
- **Backend boxes**: ``` "recipe[vcluster::backend]" ```

# Command to provision box
```
cd vcluster/cookbooks/vcluster/
vagrant up --provision

```

# To test on browser -
1. Open URL: http://192.168.11.11

___

###### Maintainer :- Mayank Gaikwad