# Drupal Project Structure

A simple base file structure for organising Drupal project releases.

This project should be used in conjunction with the [Drupal-Project Template](https://github.com/andrewholgate/drupal-project-template)

# Installation

## 1. Clone this repository

```
cd /var/www/
git clone https://github.com/andrewholgate/drupal-project-structure.git project
cd project
```

## 2. Add Project Properties

```
# Add custom project properties to the Phing configuration file, such as the repository URL, etc.
vim build.properties
```

## 3. Clone your project

Use the new release directory name and repository release tag to be cloned.

```
cd /var/www/project
# "dir" is the release/ sub-directory for the release and "tag" is the git tag from the repository.
phing clone -Ddir=v1.0.0 -Dtag=v1.0.0
```

## 4. Configure Settings

**Note:** This is only required once per project set-up.

The appropriate settings.php file will be copied over to `release/settings.local` for use on project builds.

For development environment:

```
phing exec -Dcommand=settings-dev -Ddir=v1.0.0
```

For staging environment:

```
phing exec -Dcommand=settings-staging -Ddir=v1.0.0
```

For production environment:

```
phing exec -Dcommand=settings-prod -Ddir=v1.0.0
```

## 5. Build Project

**Note:** Where ever the suffix `-prod` is used, it can substituted for `-dev`to match the environment you are setting up.

```
# Note that "dir" is the directory within release/ to install the project.
# Install project for production.
phing exec -Dcommand=install-prod -Ddir=v1.0.0

# Sync files between projects if available.
phing rsync-files -Dsource=v1.0-dev -Ddestination=v1.0.0

# Set permissions (On production)
phing exec -Dcommand=permissions-prod -Ddir=v1.0.0
```

## 6. Link the Project

```
phing release-switch -Ddir=v1.0.0
```

# Create New Release

This demonstrates how to upgrade from version `v1.0.0` to `v1.0.1` in production.

Follow steps 3 - 5 above, then:

## 1. Backup Database

```
# Note that "dir" is the directory within release/ of the current live release.
# Create a database backup of current release version.
phing exec -Dcommand=db-export -Ddir=v1.0.0
```

## 2. Set Site Offline

```
# Note that "dir" is the directory within release/ of the current live release.
# Put current site into maintenance mode (use the release version of the current site)
phing exec -Dcommand=offline -Ddir=v1.0.0
```

## 3. Switch Release Directories

```
# Note that "dir" is the directory within release/ of the new release.
phing release-switch -Ddir=v1.0.1
```

## 4. Update Database

```
# Note that "dir" is the directory within release/ of the new release.
# Update database with code changes (Features revert and database updates.)
phing exec -Dcommand=update-database -Ddir=v1.0.1
```

## 5. Set Site Online

```
# Note that "dir" is the directory within release/ of the new release.
phing exec -Dcommand=online -Ddir=v1.0.1
```
