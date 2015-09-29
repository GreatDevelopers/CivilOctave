from django.conf.urls import url

from . import views

urlpatterns = [
	#directs to index veiw
    url(r'^$', views.index, name='index'),
    #directs request to matrix veiw
    url(r'^matrix/$', views.matrix, name='matrix'),
    #directs request to last veiw
    url(r'^last/$', views.last, name='last'),
]
