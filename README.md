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

### Setup the Environment

* Clone this project repository, and cd to the main project folder.
* Create a virtualenv and activate it. Run `python3 -m venv ~/.devops` and `source ~/.devops/bin/activate`.
* Run `make install` to install the necessary dependencies.
* Install Docker to build and upload a containerized application. To this end, [create a Docker account](https://hub.docker.com/), and [install the latest stable release](https://docs.docker.com/get-docker/).
* [Install hadolint](https://github.com/hadolint/hadolint) to check the Dockerfile for errors, and [install pylint](https://pypi.org/project/pylint/) to check the Python app source code for errors.
* Install VirtualBox running `brew cask install virtualbox` for Mac, and minikube by running `brew cask install minikube` for Mac as well. For Windows, see [here for VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [here for minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/).

### Running `app.py`

1. Standalone:  `python app.py`.
2. Run in Docker:  `./run_docker.sh`.
3. Run in Kubernetes:  `./run_kubernetes.sh`.

To make a prediction, please open a separate tab or terminal window, cd to the main project folder, if you are not already there, and run `./make_prediction.sh`. Please, note that the app must be running in order to make predictions.

For completeness, note that once you have already built the docker image with `./run_docker.sh`, you can upload the image to Docker Hub by running `./upload_docker.sh`.

### Kubernetes Steps

* Setup and Configure Docker locally.
* Setup and Configure Kubernetes locally.
* Create Flask app in Container.
* Run via kubectl.

## Repository Files

In this section, the repository files are described:

* *.circleci/config.yml*: identifies how to set up the testing environment and what tests to run on CircleCI.
* *model_data*: files in this folder are related to the pre-trained, sklearn model that has been trained to predict housing prices in Boston.
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
