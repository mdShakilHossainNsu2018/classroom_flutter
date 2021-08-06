FROM python:3.7

ENV PYTHONUNBUFFERED=1

#ENV PATH="/scripts:${PATH}"

COPY ./requirements.txt ./requirements.txt
#RUN apk update && apk add libc-dev make git libffi-dev openssl-dev python3-dev libxml2-dev libxslt-dev
#RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers

#RUN apk del .tmp
RUN mkdir /class_room_backend
COPY . /class_room_backend
WORKDIR /class_room_backend
RUN pip install -r /requirements.txt
#COPY ./scripts /scripts
#RUN pip install -U spacy
#RUN python -m spacy download en_core_web_sm
RUN python -m spacy download en



#RUN chmod +x /scripts/*
#
#RUN mkdir -p /vol/web/media
#RUN mkdir -p /vol/web
#
#RUN adduser -D user
#RUN chown -R user:user /vol
#RUN chmod -R 755 /vol/web
#
#USER user

#CMD ["entrypoint.sh"]


