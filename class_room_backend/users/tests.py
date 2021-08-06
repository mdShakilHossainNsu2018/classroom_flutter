from django.contrib.auth.models import User
from django.test import TestCase, RequestFactory
from rest_framework import status
from rest_framework.test import APITestCase


class SimpleTest(TestCase):
    def setUp(self):
        # Every test needs access to the request factory.
        self.factory = RequestFactory()
        self.user = User.objects.create_user(
            username='jacob', email='jacob@gmail.com', password='top_secret')

        # self.user = User.objects.create_user(
        #     username='123456', email='jacob@gmail.com', password='top_secret')

    def test_user(self):
        qs = User.objects.all()
        self.assertEqual(qs.count(), 1)


class ApiUserTestCase(APITestCase):

    def test_reg_user(self):
        data = {
            "username": 18129666,
            "password": "anypassword",
            "email": "shakil@northsouth.edu",
        }

        res = self.client.post('/api/users/users/', data=data)

        self.assertEqual(res.status_code, status.HTTP_201_CREATED)

    def test_token(self):
        data = {
            "username": 18129666,
            "password": "anypassword",
            "email": "shakil@northsouth.edu",
        }

        res = self.client.post('/api/users/users/', data=data)

        data = {"username": 18129666,
                "password": "anypassword"}

        res = self.client.post('/api/users/token-auth/', data=data)

        self.assertEqual(res.status_code, status.HTTP_200_OK)
