from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^matrix/$', views.matrix, name='matrix'),
    url(r'^last/$', views.last, name='last'),
]
