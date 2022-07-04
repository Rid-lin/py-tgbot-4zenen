FROM python:3.10.5-alpine3.16
# Install app dependencies
WORKDIR /app
COPY requirements.txt .
COPY main.py .
# ADD main.py /
RUN pip install -r requirements.txt

LABEL MAINTAINER Author vlad@vegner.org
# Bundle app source
# COPY src /app
# USER appuser
CMD [ "python", "/app/main.py" ]
