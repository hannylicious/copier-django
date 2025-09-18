# Copier Django

Powered by [Copier](https://github.com/copier-org/copier), Copier Django is
a framework for jumpstarting
production-ready Django projects quickly.

- Documentation: <https://copier-django.readthedocs.io/en/latest/>
- See [Troubleshooting](https://copier-django.readthedocs.io/en/latest/5-help/troubleshooting.html)
for common errors and obstacles
- If you have problems with Copier Django, please open
[issues](https://github.com/hannylicious/copier-django/issues/new) don't send
emails to the maintainers.

## Features

- For Django 5.2
- Works with Python 3.12
- Renders Django projects with 100% starting test coverage
- Twitter [Bootstrap](https://github.com/twbs/bootstrap) v5
- [12-Factor](https://12factor.net) based settings via [django-environ](https://github.com/joke2k/django-environ)
- Secure by default. We believe in SSL.
- Optimized development and production settings
- Registration via [django-allauth](https://github.com/pennersr/django-allauth)
- Comes with custom user model ready to go
- Optional basic ASGI setup for Websockets
- Optional custom static build using Gulp or Webpack
- Send emails via [Anymail](https://github.com/anymail/django-anymail) (using
[Mailgun](http://www.mailgun.com/) by default or Amazon SES if AWS is
selected cloud provider, but switchable)
- Media storage using Amazon S3, Google Cloud Storage, Azure Storage or nginx
- Docker support using [docker-compose](https://github.com/docker/compose) for
development and production (using [Traefik](https://traefik.io/) with
[LetsEncrypt](https://letsencrypt.org/) support)
- [Procfile](https://devcenter.heroku.com/articles/procfile) for deploying to Heroku
- Instructions for deploying to [PythonAnywhere](https://www.pythonanywhere.com/)
- Run tests with unittest or pytest
- Customizable PostgreSQL version
- Default integration with
[pre-commit](https://github.com/pre-commit/pre-commit) for identifying simple
issues before submission to code review

## Optional Integrations

_These features can be enabled during initial project setup._

- Serve static files from Amazon S3, Google Cloud Storage, Azure Storage
or [Whitenoise](https://whitenoise.readthedocs.io/)
- Configuration for [Celery](https://docs.celeryq.dev) and
[Flower](https://github.com/mher/flower) (the latter in Docker setup only)
- Integration with [Mailpit](https://github.com/axllent/mailpit/) for local
email testing
- Integration with [Sentry](https://sentry.io/welcome/) for error logging

## Constraints

- Only maintained 3rd party libraries are used.
- Uses PostgreSQL everywhere: 14 - 17.
- Environment variables for configuration (This won't work with
Apache/mod_wsgi).

## Support this Project

This project is an open source project run by volunteers. You can sponsor us
via GitHub Sponsors:

- Hannylicious, Project Lead ([GitHub](https://github.com/hannylicious),
[Twitch](https://www.twitch.tv/hannylicious)): expertise in Django.

## Usage

Let's pretend you want to create a Django project called "redditclone".
Rather than using `startproject` and then editing the results to include
your name, email, and various configuration issues that always get forgotten
until the worst possible moment, get
[copier](https://github.com/copier-org/copier) to do all the work.

First, get Copier. Trust me, it will make your life easier:

    uv tool install "copier>=9.10.0"

Now run it against this repo:

    uvx copier copy https://github.com/hannylicious/copier-django reddit

You'll be prompted for some values. Provide them, then a Django project
will be created for you.

**Warning**: After this point, change 'John Doe', 'hannylicious', etc to
your own information.

Answer the prompts with your own desired
[options](http://copier-django.readthedocs.io/en/latest/1-getting-started/project-generation-options.html)
. For example:

    Cloning into 'copier-django'...
    remote: Counting objects: 550, done.
    remote: Compressing objects: 100% (310/310), done.
    remote: Total 550 (delta 283), reused 479 (delta 222)
    Receiving objects: 100% (550/550), 127.66 KiB | 58 KiB/s, done.
    Resolving deltas: 100% (283/283), done.
    project_name [My Awesome Project]: Reddit Clone
    project_slug [reddit_clone]: reddit
    description [Behold My Awesome Project!]: A reddit clone.
    author_name [John Doe]: John Smith
    domain_name [example.com]: myreddit.com
    email [john-doe@example.com]: john-smith@gmail.com
    version [0.1.0]: 0.0.1
    Select open_source_license:
    1 - MIT
    2 - BSD
    3 - GPLv3
    4 - Apache Software License 2.0
    5 - Not open source
    Choose from 1, 2, 3, 4, 5 [1]: 1
    Select username_type:
    1 - username
    2 - email
    Choose from 1, 2 [1]: 1
    timezone [UTC]: America/Los_Angeles
    windows [n]: n
    Select an editor to use. The choices are:
    1 - None
    2 - PyCharm
    3 - VS Code
    Choose from 1, 2, 3 [1]: 1
    use_docker [n]: n
    Select postgresql_version:
    1 - 17
    2 - 16
    3 - 15
    4 - 14
    Choose from 1, 2, 3, 4 [1]: 1
    Select cloud_provider:
    1 - AWS
    2 - GCP
    3 - None
    Choose from 1, 2, 3 [1]: 1
    Select mail_service:
    1 - Mailgun
    2 - Amazon SES
    3 - Mailjet
    4 - Mandrill
    5 - Postmark
    6 - Sendgrid
    7 - Brevo (formerly SendinBlue)
    8 - SparkPost
    9 - Other SMTP
    Choose from 1, 2, 3, 4, 5, 6, 7, 8, 9 [1]: 1
    use_async [n]: n
    use_drf [n]: y
    Select frontend_pipeline:
    1 - None
    2 - Django Compressor
    3 - Gulp
    4 - Webpack
    Choose from 1, 2, 3, 4 [1]: 1
    use_celery [n]: y
    use_mailpit [n]: n
    use_sentry [n]: y
    use_whitenoise [n]: n
    use_heroku [n]: y
    Select ci_tool:
    1 - None
    2 - Travis
    3 - Gitlab
    4 - Github
    Choose from 1, 2, 3, 4 [1]: 4
    keep_local_envs_in_vcs [y]: y
    debug [n]: n

Enter the project and take a look around:

    cd reddit/
    ls

Create a git repo and push it there:

    git init
    git add .
    git commit -m "first awesome commit"
    git remote add origin git@github.com:johnsmith/redditclone.git
    git push -u origin main

Now take a look at your repo. Don't forget to carefully look at the
generated README. Awesome, right?

For local development, see the following:

- [Developing locally](https://copier-django.readthedocs.io/en/latest/2-local-development/developing-locally.html)
- [Developing locally using docker](https://copier-django.readthedocs.io/en/latest/2-local-development/developing-locally-docker.html)

## Community

- Have questions? **Before you ask questions anywhere else**, please post your
question on
[Stack Overflow](http://stackoverflow.com/questions/tagged/copier-django)
under the _copier-django_ tag. We check there periodically for questions.
- If you think you found a bug or want to request a feature, please open an
[issue](https://github.com/hannylicious/copier-django/issues).
- For anything else, you can chat with us on [Discord](https://discord.gg/TUrCTbcz).

## "Your Stuff"

Scattered throughout the Python and HTML of this project are places marked
with "your stuff". This is where third-party libraries are to be integrated
with your project.

## For MySQL users

There is no fork currently available for MySQL.

## Releases

Need a stable release? You can find them at <https://github.com/hannylicious/copier-django/releases>

## Not Exactly What You Want?

This is what I want. _It might not be what you want._ Don't worry, you have
options:

### Fork This

If you have differences in your preferred setup, I encourage you to fork
this to create your own version.
Once you have your fork working, let me know and I'll add it to a
'_Similar Copier Templates_' list here.
It's up to you whether to rename your fork.

### Submit a Pull Request

We accept pull requests if they're small, atomic, and make our own project
development experience better.

## Articles

Have a blog or online publication? Write about your copier-django tips and
tricks, then send us a pull request with the link.
