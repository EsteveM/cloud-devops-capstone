# Cloud DevOps Capstone Project

This project is intended to set up a pipeline that allows us to lint the target code, build the correponding Docker container, and deploy it to a [kubernetes](https://kubernetes.io/) cluster. Blue/green deployment is also used.

## Table of Contents

* [Project Overview](#project-overview)
* [Getting Started](#getting-started)
* [Repository Files](#repository-files)
* [Contributing](#contributing)


## Project Overview

The aim of this project is to create a Jenkins pipeline. Blue/green deployment is used, and the chosen Docker application is a simple Nginx one. A Jenkins master box is created, where Jenkins itself and a number of plugins are installed. A Kubernetes cluster is also created and configured by means of AWS Kubernetes as a Service. Finally, it has to be mentioned that the pipeline is constructed in a GitHub repository. These are the different steps that made up the pipeline:

* Test application code using linting.
* Build a Docker image that containerizes the application, a simple Nginx one.
* Perform security testing with Aqua Microscanner.
* Deploy the containerized application using Docker.
* Create a configuration file for the kubectl cluster.
* Set the current kubctl context to the cluster.
* Create the blue replication controller with its Docker image.
* Create the green replication controller with its Docker image.
* Create the service in the Kubernetes cluster to the blue replication controller.
* Wait until the user gives the instruction to continue.
* Update the service to redirect to green by changing the selector to app=green.
* Check the application deployed in the cluster and its correct deployment.

Apart from the steps in the pipeline, and as already mentioned, it is necessary to previously configure Kubernetes and create a Kubernetes cluster.

## Getting Started

In this section, it can be seen how the pipeline works as designed.

### Creating the Kubernetes cluster

As a first previous step, the Kubernetes cluster is created, as can be seen below. Firstly, in the pipeline as a step which can be removed from the pipeline afterwards, but which has been included here for convenience. Secondly, in AWS CloudFormation. Finaly, in AWS Elastic Kubernetes Service.

![0-KubernetesClusterCreation](/ScreenShots/0-KubernetesClusterCreation.png)
![0-KubernetesClusterCreation2](/ScreenShots/0-KubernetesClusterCreation2.png)
![0-KubernetesClusterCreation3](/ScreenShots/0-KubernetesClusterCreation3.png)

### Running the pipeline

From now on, the pipeline itself is run, and its stages are shown below.

* Test application code using linting. Below, both a failed Linting screenshot and a successful Linting screenshot are shown.
![1-FailedLintingScreenshot](/ScreenShots/1-FailedLintingScreenshot.png)
![2-SuccessfulLintingScreenshot](/ScreenShots/2-SuccessfulLintingScreenshot.png)
* Build a Docker image that containerizes the application, a simple Nginx one.
![3-BuildtheDockerImage](/ScreenShots/3-BuildtheDockerImage.png)
* Perform security testing with Aqua Microscanner.
![4-SecurityTestingwithAqua](/ScreenShots/4-SecurityTestingwithAqua.png)
* Deploy the containerized application using Docker. Both the action in the pipeline and on DockerHub are shown.
![5-UploadtheImagetoDocker](/ScreenShots/5-UploadtheImagetoDocker.png)
![5-UploadtheImagetoDocker2](/ScreenShots/5-UploadtheImagetoDocker2.png)
* Create a configuration file for the kubectl cluster.
![6-Createaconfigurationfileforkubectlcluster](/ScreenShots/6-Createaconfigurationfileforkubectlcluster.png)
* Set the current kubctl context to the cluster.
![7-Setthecurrentkubctlcontexttothecluster](/ScreenShots/7-Setthecurrentkubctlcontexttothecluster.png)
* Create the blue replication controller with its Docker image.
![8-CreatethebluereplicationcontrollerwithitsDockerimage](/ScreenShots/8-CreatethebluereplicationcontrollerwithitsDockerimage.png)
* Create the green replication controller with its Docker image.
![9-CreatethegreenreplicationcontrollerwithitsDockerimage](/ScreenShots/9-CreatethegreenreplicationcontrollerwithitsDockerimage.png)
* Create the service in the Kubernetes cluster to the blue replication controller.
![10-CreatetheserviceintheKubernetesclustertothebluereplicationcontroller](/ScreenShots/10-CreatetheserviceintheKubernetesclustertothebluereplicationcontroller.png)
* Wait until the user gives the instruction to continue. The interaction with the user and the logged result are both shown.
![11-Waituntiltheusergivestheinstructiontocontinue](/ScreenShots/11-Waituntiltheusergivestheinstructiontocontinue.png)
![11-Waituntiltheusergivestheinstructiontocontinue2](/ScreenShots/11-Waituntiltheusergivestheinstructiontocontinue2.png)
* Update the service to redirect to green by changing the selector to app=green.
![12-Updatetheservicetoredirecttogreenbychangingtheselectortoapp=green](/ScreenShots/12-Updatetheservicetoredirecttogreenbychangingtheselectortoapp=green.png)
* Check the application deployed in the cluster and its correct deployment. Firstly, we can see in the pipeline logs that the deployed application is running, as both pods are running. Secondly, with the obtained IP of the service (see at "LOAD_BALANCER_INGRESS + : + PORT"), we successfully access the application via the browser. Finally, a screenshot of the AWS EC2 page showing the newly created instances is also shown. Three instances can be seen just below the Jenkins masterbox. 
![13-CheckSuccessfulDeployment](/ScreenShots/13-CheckSuccessfulDeployment.png)
![13-CheckSuccessfulDeployment4](/ScreenShots/13-CheckSuccessfulDeployment4.png)
![13-CheckSuccessfulDeployment3](/ScreenShots/13-CheckSuccessfulDeployment3.png)

## Repository Files

In this section, the repository files are described:

* *create-kubernetes-cluster/Manual-Jenkinsfile*: this is a Jenkins file which implements a pipeline that has two steps. The first one creates the Kubernetes cluster, and the second one creates the corresponding configuration file. This file has been provided for convenience, but it is not part of the main pipeline.
* *blue-controller.json*: this file specifies the replication controller blue pod.
* *blue-service.json*: this file specifies the blue service.
* *Dockerfile*: contains all the commands to assemble the image.
* *green-controller.json*: this file specifies the replication controller green pod.
* *green-service.json*: this file specifies the green service.
* *index.html*: simple html file that makes up the application.
* *Jenkinsfile*: this file contains the pipeline which is the main goal of this project.
* */Screenshots*: this folder contains a number of screenshots to show the correct workings of the project.

## Contributing

This repository contains all the work that makes up the project. Individuals and I myself are encouraged to further improve this project. As a result, I will be more than happy to consider any pull requests.
