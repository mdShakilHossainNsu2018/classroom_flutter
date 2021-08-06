```shell script
docker-compose build

docker-compose run django python -m spacy download en

docker-compose up

python manage.py migrate django_chatterbot

```