FROM python:3.6.10-slim-buster

# Add project source
WORKDIR /usr/src/musicbot
COPY . ./

COPY config/example_aliases.json config/aliases.json
COPY config/example_options.ini config/options.ini
COPY config/example_permissions.ini config/permissions.ini
COPY config/example_autoplaylist.txt config/autoplaylist.txt

# Install build tools
RUN apt-get update

# Install system dependencies
RUN apt-get install -y ffmpeg libopus-dev libffi-dev libsodium-dev python3-pip

RUN apt-get clean

# Install Python dependencies
RUN python -m pip install -U pip
RUN python -m pip install -U -r requirements.txt

ENV APP_ENV=docker

ENTRYPOINT ["python3", "dockerentry.py"]
