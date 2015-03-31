# Drupal Project Structure

A simple base file structure for organising Drupal project releases.

This project should be used in conjunction with the [Drupal-Project Template](https://github.com/andrewholgate/drupal-project-template)

# Installation

1. Clone this repository.

```
cd /var/www/
git clone https://github.com/andrewholgate/drupal-project-structure.git project
cd project
```

2. Add custom project properties to the Phing configuration file.

```
vim build.properties
```

3. Clone your project

```
phing clone -Ddir=v1.1 -Dtag=v1.1
```

4. Build the project

```
phing exec -Dcommand=install-prod -Ddir=v1.1
# Sync files between project if necessary.
phing rsync-files -Dsource=v1.0 -Ddestination=v1.1
```

5. Link the project

```
phing release-switch -Dnew=v1.1
```

# Create New Release

Follow steps 3-4 above.

```
# Create a database backup.
phing exec -Dcommand=db-backup -Ddir=v1.1
# Put current site into maintenance mode.
phing exec -Dcommand=offline -Ddir=current
# Switch directories
phing release-switch -Dnew=v1.1
# Update database with code changes.
phing exec -Dcommand=update-database -Ddir=current
# Put the site online.
phing exec -Dcommand=offline -Ddir=current
```
