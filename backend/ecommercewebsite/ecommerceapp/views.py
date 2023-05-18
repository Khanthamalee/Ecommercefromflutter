from django.shortcuts import render
from .serializers import *
from .models import *
from rest_framework import status
from rest_framework.views import APIView
from rest_framework import generics,viewsets, permissions,authentication
from rest_framework.permissions import DjangoModelPermissions
from .permissions import IsOwner
from rest_framework_extensions.mixins import NestedViewSetMixin

from django.shortcuts import render, get_object_or_404
from .paginations import CustomPagination

from rest_framework.response import Response
from django.contrib.auth.models import User
from django.contrib.auth import authenticate,login

from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework.authentication import TokenAuthentication

from rest_framework.authtoken.serializers import AuthTokenSerializer
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.authtoken.models import Token



from django.http import JsonResponse
import googlemaps
from datetime import datetime

from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser 
from rest_framework.decorators import api_view


#test
def googlemaps_test(request,*args,**kwargs):

    gmaps = googlemaps.Client(key='AIzaSyA2nluxS-_G5GygEdIzH0gZ_XopuHPzSIs')

    # Geocoding an address
    geocode_result = gmaps.geocode('1600 Amphitheatre Parkway, Mountain View, CA')

    # Look up an address with reverse geocoding
   # reverse_geocode_result = gmaps.reverse_geocode((16.119, 101.895))
    latitude = request.latitude
    logitude = request.logitude
    reverse_geocode_result = gmaps.reverse_geocode((latitude, logitude))

    # Request directions via public transit
    now = datetime.now()
    directions_result = gmaps.directions("Sydney Town Hall",
                                         "Parramatta, NSW",
                                         mode="transit",
                                         departure_time=now)

    # Validate an address with address validation
    addressvalidation_result =  gmaps.addressvalidation(['1600 Amphitheatre Pk'], 
                                                        regionCode='US',
                                                        locality='Mountain View', 
                                                        enableUspsCass=True)
    return JsonResponse({
        
        "ละติจูด - ลองติจูด": [reverse_geocode_result[0]["geometry"]["location"]['lat'],reverse_geocode_result[0]["geometry"]["location"]['lng']],
        "ที่อยู่แบบเต็ม": reverse_geocode_result[0]["formatted_address"],
        "ตำบล": reverse_geocode_result[0]["address_components"][0]["short_name"],
        "อำเภอ": reverse_geocode_result[0]["address_components"][1]["short_name"],
        "จังหวัด": reverse_geocode_result[0]["address_components"][2]["short_name"],
        "รหัสไปรษณีย์": reverse_geocode_result[0]["address_components"][4]["short_name"],
        "ประเทศ": reverse_geocode_result[0]["address_components"][3]["short_name"],
        "แบบเต็ม": reverse_geocode_result,
        })


def get_tokens_for_user(user):
  refresh = RefreshToken.for_user(user)
  return {
      'refresh': str(refresh),
      'access': str(refresh.access_token),
  }
class MyObtainTokenPairView(TokenObtainPairView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = MyTokenObtainPairSerializer

class UserViewSet(viewsets.ModelViewSet):
    serializer_class = UserSerializer
    queryset = User.objects.all()
    pagination_class = CustomPagination
    authentication_classes = [authentication.SessionAuthentication]
    permission_classes = [permissions.IsAuthenticated]



class RegisterViewSet(viewsets.ModelViewSet):
    serializer_class = RegisterSerializer
    queryset = User.objects.all()
    pagination_class = CustomPagination
    permission_classes = [permissions.AllowAny]




class ProfileViewSet(viewsets.ModelViewSet):
    serializer_class = ProfileSerializer
    queryset = Profile.objects.all()
    pagination_class = CustomPagination
    authentication_classes = [authentication.SessionAuthentication,authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    lookup_field ='pk'

    def get_queryset(self,*args,**kwargs):
        qs = super().get_queryset(*args,**kwargs)
        request = self.request
        user = request.user
        print("get_queryset of ProfileViewSet :",request.user)
        if not user.is_authenticated:
            return Profile.objects.none()
        return qs.filter(user=request.user)

    def post(self, request, format=None):
        #แบบใช้ AuthTokenSerializer and ObtainAuthToken to create token
        serializer = ProfileSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)

        #print(user)
        #print(request.data)
        #print(token)


class UpdateaddressToProfileuser(viewsets.ModelViewSet):
    serializer_class = UpdateAddressProfileuserSerializer
    queryset = Profile.objects.all()
    lookup_field ='pk'

class PostAndPutprofile(APIView):
    authentication_classes = [authentication.SessionAuthentication,authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def put(self, request,*args,**kwargs):

        body = request.data
        print("body :", body)

        user = body['user']['user_id']
        username = body['user']['username']

        profile_object = Profile.objects.get(user = user)
        profile_object.user = User.objects.get(username = username)
        profile_object.phone = body['phone']
        profile_object.order_count = 0
        profile_object.type_id = 4

        print("body['homeaddress']['homeaddress_id']",body['homeaddress']['homeaddress_id'])
        if body['homeaddress']['homeaddress_id']:
            homeaddress_id = body['homeaddress']['homeaddress_id']
            addressname = body['homeaddress']['addressname']
            address = body['homeaddress']['address']
            tombon = body['homeaddress']['tombon']
            amphure = body['homeaddress']['amphure']
            zip_code = body['homeaddress']['zip_code']
            province = body['homeaddress']['province']
            city = body['homeaddress']['city']
            latitude = float(body['homeaddress']['latitude'])
            longitude = float(body['homeaddress']['longitude'])
            location = body['homeaddress']['latitude']+","+body['homeaddress']['longitude']
            print(location)




            try:

                Location1_object = Location1.objects.get(id = homeaddress_id )
                Location1_object.addressname = addressname
                Location1_object.address =address
                Location1_object.tombon = tombon
                Location1_object.amphure = amphure
                Location1_object.zip_code = zip_code
                Location1_object.province = province
                Location1_object.city = city
                Location1_object.latitude = latitude
                Location1_object.longitude = longitude
                Location1_object.location = location
                Location1_object.type_id = 3
                Location1_object.save()
                return Response({'msg':'Data homeaddress saved successful'}, status=status.HTTP_200_OK)
            except:
                newLocation1_object = Location1()
                newLocation1_object.addressname = addressname
                newLocation1_object.address =address
                newLocation1_object.tombon = address
                newLocation1_object.amphure = amphure
                newLocation1_object.zip_code = zip_code
                newLocation1_object.province = province
                newLocation1_object.city = city
                newLocation1_object.latitude = latitude
                newLocation1_object.longitude = longitude
                newLocation1_object.location = location
                newLocation1_object.type_id = 3
                newLocation1_object.save()
                profile_object.homeaddress = Location1.objects.get(id=newLocation1_object.id)
                return Response({'msg':'Data newhomeaddress created successful'}, status=status.HTTP_201_CREATED)

        if body['officeaddress']['officeaddress_id']:
            officeaddress_id = body['officeaddress']['officeaddress_id']
            addressname = body['officeaddress']['addressname']
            address = body['officeaddress']['address']
            tombon = body['officeaddress']['tombon']
            amphure = body['officeaddress']['amphure']
            zip_code = body['officeaddress']['zip_code']
            province = body['officeaddress']['province']
            city = body['officeaddress']['city']
            latitude = float(body['officeaddress']['latitude'])
            longitude = float(body['officeaddress']['longitude'])
            location = body['officeaddress']['latitude']+","+body['officeaddress']['longitude']
            print(location)



            try:
                Location2_object = Location2.objects.get(id = officeaddress_id )
                Location2_object.addressname = addressname
                Location2_object.address =address
                Location2_object.tombon = tombon
                Location2_object.amphure = amphure
                Location2_object.zip_code = zip_code
                Location2_object.province = province
                Location2_object.city = city
                Location2_object.latitude = latitude
                Location2_object.longitude = longitude
                Location2_object.location = location
                Location2_object.type_id = 5
                Location2_object.save()
                return Response({'msg':'Data officeaddress saved successful'}, status=status.HTTP_200_OK)
                
            except:
                newLocation2_object = Location2()
                newLocation2_object.addressname = addressname
                newLocation2_object.address =address
                newLocation2_object.tombon = tombon
                newLocation2_object.amphure = amphure
                newLocation2_object.zip_code = zip_code
                newLocation2_object.province = province
                newLocation2_object.city = city
                newLocation2_object.latitude = latitude
                newLocation2_object.longitude = longitude
                newLocation2_object.location = location
                newLocation2_object.type_id = 5
                newLocation2_object.save()
                profile_object.officeaddress = Location2.objects.get(id=newLocation2_object.id)
                return Response({'msg':'Data newofficeaddress created successful'}, status=status.HTTP_201_CREATED)

        if body['presentpositionaddress']['presentpositionaddress_id']:
            presentpositionaddress_id = body['presentpositionaddress']['presentpositionaddress_id']
            addressname = body['presentpositionaddress']['addressname']
            address = body['presentpositionaddress']['address']
            tombon = body['presentpositionaddress']['tombon']
            amphure = body['presentpositionaddress']['amphure']
            zip_code = body['presentpositionaddress']['zip_code']
            province = body['presentpositionaddress']['province']
            city = body['presentpositionaddress']['city']
            latitude = float(body['presentpositionaddress']['latitude'])
            longitude = float(body['presentpositionaddress']['longitude'])
            location = body['presentpositionaddress']['latitude']+","+body['presentpositionaddress']['longitude']
            print(location)

            try:
                Location3_object = Location3.objects.get(id = presentpositionaddress_id )
                Location3_object.addressname = addressname
                Location3_object.address =address
                Location3_object.tombon = tombon
                Location3_object.amphure = amphure
                Location3_object.zip_code = zip_code
                Location3_object.province = province
                Location3_object.city = city
                Location3_object.latitude = latitude
                Location3_object.longitude = longitude
                Location3_object.location = location
                Location3_object.type_id = 6
                Location3_object.save()
                return Response({'msg':'Data presentpositionaddress saved successful'}, status=status.HTTP_200_OK)

            except:
                newLocation3_object = Location3()
                newLocation3_object.addressname = addressname
                newLocation3_object.address =address
                newLocation3_object.tombon = tombon
                newLocation3_object.amphure = amphure
                newLocation3_object.zip_code = zip_code
                newLocation3_object.province = province
                newLocation3_object.city = city
                newLocation3_object.latitude = latitude
                newLocation3_object.longitude = longitude
                newLocation3_object.location = location
                newLocation3_object.type_id = 6
                newLocation3_object.save()
                profile_object.presentpositionaddress = Location3.objects.get(id=newLocation3_object.id)
                return Response({'msg':'Data newpresentpositionaddress created successful'}, status=status.HTTP_201_CREATED)

        

        profile_object.save()
        return JsonResponse({"body" : body
        })





class GoogleAddress(APIView):
    def post(self, request, format=None):
        body = request.data
        latitude = body["latitude"]
        longitude = body["longitude"]
        gmaps = googlemaps.Client(key='AIzaSyA2nluxS-_G5GygEdIzH0gZ_XopuHPzSIs')
        reverse_geocode_result = gmaps.reverse_geocode((latitude,longitude))

        return Response({"fulladdress" : reverse_geocode_result
        },status=status.HTTP_200_OK)


class UserLoginView(APIView):
    permission_classes = (permissions.AllowAny,)

    def post(self, request, format=None):
        #แบบใช้ AuthTokenSerializer and ObtainAuthToken to create token
        serializer = AuthTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        print(user)
        print(request.data)
        print(token)
        if user is not None:
            token, created = Token.objects.get_or_create(user=user)
            login(request,user)
            return Response({'token':token.key, 'msg':'Login Success'}, status=status.HTTP_200_OK)
        else:
            return Response({'errors':{'non_field_errors':['Email or Password is not Valid']}}, status=status.HTTP_404_NOT_FOUND)


        '''แบบใช้ UserLoginSerializer and RefreshToken to create token
        serializer = AuthTokenSerializer(data=request.data)
        if request.data:
            username = request.data["username"]
            print(username)
            password = request.data["password"]
            print(password)
            user = authenticate(username=username, password=password)
            login(request,user)
            if user is not None:
                token = get_tokens_for_user(user)
                return Response({'token':token, 'msg':'Login Success'}, status=status.HTTP_200_OK)
            else:
                return Response({'errors':{'non_field_errors':['Email or Password is not Valid']}}, status=status.HTTP_404_NOT_FOUND)'''
'''
{
    "username": "0834532277",
    "password": ";yoouhfu"
}
'''






class MyViewSet(viewsets.ModelViewSet):
    permission_classes = [DjangoModelPermissions]


class RecommendedViewSet(viewsets.ModelViewSet):
    serializer_class = RecommendedSerializer
    queryset = Recommended.objects.all()
    lookup_field = 'id'
    authentication_classes = [authentication.SessionAuthentication,authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated,]
    pagination_class = CustomPagination

class PopularViewSet(viewsets.ModelViewSet):
    serializer_class = PopularSerializer
    queryset = Popular.objects.all()
    authentication_classes = [authentication.SessionAuthentication,authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated,]
    pagination_class = CustomPagination

class LocationViewSet(viewsets.ModelViewSet):
    serializer_class = LocationSerializer
    queryset = Location1.objects.all()
    authentication_classes = [authentication.SessionAuthentication]
    permission_classes = [permissions.IsAuthenticated]
    pagination_class = CustomPagination







