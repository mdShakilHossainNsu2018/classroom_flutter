import os

from celery import Celery
# set the default Django settings module for the 'celery' program.
from celery.schedules import crontab

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'class_room_backend.settings')

app = Celery('class_room_backend')

# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
# - namespace='CELERY' means all celery-related configuration keys
#   should have a `CELERY_` prefix.
app.config_from_object('django.conf:settings', namespace='CELERY')

# Load task modules from all registered Django app configs.
app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')


app.conf.beat_schedule = {
    # Executes every Monday morning at 7:30 a.m.
    # 'hello': {
    #     'task': 'chat.tasks.hello',
    #     'schedule': crontab(),
    #     # 'args': (16, 16),
    # },
    # 'corpusTrainer': {
    #
    #     'task': 'chat.tasks.corpusTrainer',
    #     # Executes every Monday morning at 7:30 a.m.
    #     #         'schedule': crontab(minute=0, hour=0),
    #     'schedule': crontab(minute='*/5'),
    #     # 'args': (16, 16),
    # },
    # 'trainFromDatabase': {
    #     'task': 'chat.tasks.trainFromDatabase',
    #     'schedule': crontab(minute='*/5'),
    #     # 'args': (16, 16),
    # },
}
