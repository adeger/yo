YO - DevOps Exercises
================

**Please, before starting this exercise, read through all of the instructions carefully!**

Introduction
------------

This exercise is used within the SAP Hybris hiring process to determine knowledge of the type of hacking chops necessary for operations. It serves as an opportunity for you to show us your ability to do operations. 

Ok, so... A summer intern created this project and left for school in the fall. Now our business wants to make this application part of our operational environment. Currently this application runs on macOS. Your job is to get this project into production-worthy deployment setting running on Linux in the cloud provider of your choice.

Prerequisites
-------------

* Please sign up for a free trial account with Amazon, Azure or Google Cloud

* This repo uses Git for source control management (SCM). If you don't already have the git utility installed on your machine you will need to install it. To do so, check ou the [git downloads page](http://git-scm.com/downloads).

* To build this project you must use Maven 3.x. If you do not have Maven already installed on your machine you will need to install it. To do so, check out the [git downloads page](http://git-scm.com/downloads).

* For deployment of the Java app, you can use whatever web container/application server you prefer. We use [Tomcat](http://tomcat.apache.org/) to validate that the application will start up correctly.

Instructions
------------

DO:
* Fork and clone this repo from Github to your local machine.
* Build the Java code using `mvn package`. This will produce a jar file in the `target/` folder. 
* Deploy the jar using the cloud provider. 
* Provision a MySQL database.
* Provision a reverse-proxy in front of the Java application. 
* Automate as much of the deployment to the cloud provider as you can using whatever tools you are most comfortable with.
* Write a smoke-test script to ensure that after deploy the application is running.
* Follow best practices, this your opportunity to demonstrate your knowledge.
* Provide comments and documentation as if we were doing an ops review on your code/work. Please be sure to include the following:
    * Description of the deployed system architecture
    * Screenshots of any cloud provider configuration (ie. firewall settings, vpcs, etc.)
    * Pointers to help us review your code
* SEND US A PULL REQUEST to the Github project or zip up your working folder with your notes and scripts.
* Leave your environment running. Provide us with login information for the servers. Either send us a username/password, provide us with private key files, or add our SSH keys (see the attached authorized_keys`file).

DO NOT: 
* Edit the Java code.
* Pay for computing resources.
    * We recommend you use the free tier of one of the major cloud providers: Amazon, Azure or Google Cloud.
* Spend more than 4 hours on this. 

Good luck!

