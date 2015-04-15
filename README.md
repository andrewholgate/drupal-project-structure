# Drupal Project Structure

A simple file structure and tasks for deploying Drupal project releases.

This project should be used with projects using the [Drupal-Project Template](https://github.com/andrewholgate/drupal-project-template).

# Installation

## 1. Clone this repository

```
cd /var/www/
git clone https://github.com/andrewholgate/drupal-project-structure.git project
cd project
```

## 2. Add Custom Project Properties

```
# Add project properties to Phing such as the repository URL.
cp build.properties.dist build.properties
vim build.properties
```

## 3. First Deployment

**Note:** Where ever the suffix `:prod` is used, it can substituted for `:dev`to match the environment being set-up.

"dir" is the release/ sub-directory for the release and "tag" is the git tag from the repository.

```
cd /var/www/project

# First production deployment
# Parameters:
#  -Ddir is the name of the new project release directory.
#  -Dtag is the name of the git repository tag to clone.

phing deploy-first:prod -Ddir=v1.0.0 -Dtag=v1.0.0
```

## 4. Deploy A New Release

A new deploy release assumes that steps 1 -3 above have already been completed for the first release of the project.

**Note:** This will do a complete deployment including an upgrade of the code, database and will put the release online.

This demonstrates how to upgrade from version `v1.0.0` to `v1.0.1` in production.

### Option 1: 2-Phase Deployment

This is the more manual and safer option as it will not release it into production until the second command, giving time to manually verify if everything is correct.

```
cd /var/www/project

# Build a new release without deploying.
#  -DdirOld is the name of the current project release directory.
#  -DdirNew is the name of the new project release directory.
#  -Dtag is the name of the git repository tag to clone.
phing deploy-build:prod -DdirOld=v1.0.0 -DdirNew=v1.0.1 -Dtag=v1.0.1

# Deploy the new release.
#  -DdirOld is the name of the current project release directory.
#  -DdirNew is the name of the new project release directory.
phing deploy-release -DdirOld=v1.0.0 -DdirNew=v1.0.1
```

### Option 2: One Click Deployment

This option will build and release in one command.

```
cd /var/www/project

# New release deployment
#  -DdirOld is the name of the current project release directory.
#  -DdirNew is the name of the new project release directory.
#  -Dtag is the name of the git repository tag to clone.
phing deploy:prod -DdirOld=v1.0.0 -DdirNew=v1.0.1 -Dtag=v1.0.1
```

