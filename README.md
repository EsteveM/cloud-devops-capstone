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

As a first previous step, the Kubernetes cluster is created, as can be seen below.

![script1](/ScreenShots/script1.png)

### Running the pipeline

* Test application code using linting. Below, both a failed Linting screenshot and a successful Linting screenshot are shown.
![script1](/ScreenShots/script1.png)
![script1](/ScreenShots/script1.png)
* Build a Docker image that containerizes the application, a simple Nginx one.
![script1](/ScreenShots/script1.png)
* Perform security testing with Aqua Microscanner.
![script1](/ScreenShots/script1.png)
* Deploy the containerized application using Docker.
![script1](/ScreenShots/script1.png)
* Create a configuration file for the kubectl cluster.
![script1](/ScreenShots/script1.png)
* Set the current kubctl context to the cluster.
![script1](/ScreenShots/script1.png)
* Create the blue replication controller with its Docker image.
![script1](/ScreenShots/script1.png)
* Create the green replication controller with its Docker image.
![script1](/ScreenShots/script1.png)
* Create the service in the Kubernetes cluster to the blue replication controller.
![script1](/ScreenShots/script1.png)
* Wait until the user gives the instruction to continue.
![script1](/ScreenShots/script1.png)
* Update the service to redirect to green by changing the selector to app=green.
![script1](/ScreenShots/script1.png)
* Check the application deployed in the cluster and its correct deployment.
![script1](/ScreenShots/script1.png)

## Repository Files

In this section, the repository files are described:

* *create-kubernetes-cluster/Manual-Jenkinsfile*: this is a Jenkins file which implements a pipeline that has two steps. The first one creates the Kubernetes cluster, and the second one creates the corresponding configuration file. This file has been provided for convenience, but it is not part of the main pipeline.
* *blue-controller.json*: this file specifies the replication controller blue pod.
* *blue-service.json*: this file specifies the blue service.
* *Dockerfile*: contains all the commands to assemble the image.
* *green-controller.json*: this file specifies the replication controller green pod.
* *green-service.json*: this file specifies the green service.
* *index.html*: simple html file that makes up the application.


* *output_txt_files/docker_out.txt*: it includes all log statements when making a prediction with the app running in Docker.
* *output_txt_files/kubernetes_out.txt*: it includes all log statements when making a prediction with the app running in Kubernetes.
* *app py*: Python flask app that infers predictions about housing prices through API calls.
* *Dockerfile*: contains all the commands to assemble the image.
* *make_prediction.sh*: it sends some input data to the app via the appropriate port.
* *Makefile*: the Makefile makes it possible to include a number of commands in it, and run them. In particular, this Makefile allows us to run commands to perform the setup, install, test, and lint steps.
* *requirements.txt*: it lists many of the project dependencies.
* *run_docker.sh*: it runs the containerized application, by building and running the docker image defined in the Dockerfile.
* *run_kubernetes.sh*: it deploys the application on a Kubernetes cluster, and the docker container is subsequently run.
* *upload_docker.sh*: it uploads the built image to Docker.

## Contributing

This repository contains all the work that makes up the project. Individuals and I myself are encouraged to further improve this project. As a result, I will be more than happy to consider any pull requests.
