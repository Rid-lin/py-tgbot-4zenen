FROM python:3.12.10-alpine3.20
# Install app dependencies
WORKDIR /app
COPY requirements.txt .
COPY main.py .
# ADD main.py /
RUN pip install -r requirements.txt

LABEL MAINTAINER Author vsvegner@yandex.ru
# Bundle app source
# COPY src /app
# USER appuser
CMD [ "python", "/app/main.py" ]
