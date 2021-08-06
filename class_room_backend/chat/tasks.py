# Create your tasks here
from celery import shared_task
from chatterbot import ChatBot
from chatterbot.ext.django_chatterbot import settings
from chatterbot.trainers import ChatterBotCorpusTrainer
from chatterbot.trainers import ListTrainer

from .models import TrainData

chatterbot = ChatBot("Nsu Chat bot",

                     # trainer='chatterbot.trainers.CorpusTrainer',
                     storage_adapter='chatterbot.storage.SQLStorageAdapter',
                     database_uri='sqlite:///database.db'

                     )

trainer = ChatterBotCorpusTrainer(chatterbot)


@shared_task
def corpusTrainer():
    trainer.train(
        "chatterbot.corpus.english",
        "chatterbot.corpus.bangla.botprofile",
        # "chatterbot.corpus.buses.route3",
        # "chatterbot.corpus.buses.broute",
        "chatterbot.corpus.english.conversations",
    )


train_data = []


@shared_task
def trainFromDatabase():
    # chatterbot.storage.drop()
    trainer = ListTrainer(chatterbot)

    question_set = [obj.question for obj in TrainData.objects.all()]
    answer_set = [obj.answer for obj in TrainData.objects.all()]

    for i in range(len(question_set)):
        train_data.append(question_set[i])
        train_data.append(answer_set[i])

    trainer.train(train_data)


@shared_task
def hello():
    print("hello")
