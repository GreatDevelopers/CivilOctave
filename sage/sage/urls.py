from django.conf.urls import patterns, include, url
from django.contrib import admin


urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'sage.views.home', name='home'),
    #url(r'^blog/', include('blog.urls')),
    #url for civilsage files
	url(r'^', include('civilsage.urls')),
	#url for admin login
    url(r'^admin/', include(admin.site.urls)),
)
