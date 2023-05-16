from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenRefreshView
from rest_framework.authtoken.views import obtain_auth_token


from .views import *

router = DefaultRouter()
router.register(r"Recommended",RecommendedViewSet)
router.register(r"Popular",PopularViewSet)
router.register(r"Location", LocationViewSet)
router.register(r'ProfileViewSet',ProfileViewSet)
router.register(r'Register',RegisterViewSet)
#router.register(r'UpdateaddressToProfileuser',UpdateaddressToProfileuser)





urlpatterns = [
    path("api/login/v1/", include(router.urls)),
    path("api/login/",include('djoser.urls.authtoken')),
    path("auth/",obtain_auth_token),
    path('api/auth/login/', MyObtainTokenPairView.as_view(), name='token_obtain_pair'),
    path('api/auth/login/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/login/',UserLoginView.as_view(),name = 'login'),
    #path('api/saveprofileuser/',RegisterView.as_view(),name = 'saveprofileuser')
    path('googlemaps_test-page/',googlemaps_test,name = "googlemaps_test-Name"),
    path('googleAddress-page/',GoogleAddress.as_view(),name="GoogleAddress-name"),
    #path('updateaddressToProfileuser/',UpdateaddressToProfileuser),
    path('PostAndPutprofile/',PostAndPutprofile.as_view())



]