from rest_framework import serializers
from rest_flex_fields import FlexFieldsModelSerializer,is_expanded
from .models import *
from django.contrib.auth.models import User


from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password

from rest_framework_simplejwt.serializers import TokenObtainPairSerializer

class MyTokenObtainPairSerializer(TokenObtainPairSerializer):

    @classmethod
    def get_token(cls, user):
        token = super(MyTokenObtainPairSerializer, cls).get_token(user)

        # Add custom claims
        token['username'] = user.username
        return token


class RecommendedSerializer(serializers.ModelSerializer):

	class Meta:
		model = Recommended
		fields = ("id","name","description","price","stars","img","location","create_At","update_At","type_id")

class PopularSerializer(serializers.ModelSerializer):

	class Meta:
		model = Popular
		fields = ("id","name","description","price","stars","img","location","create_At","update_At","type_id")

class LocationSerializer(serializers.ModelSerializer):

	class Meta:
		model = Location1
		fields = ("id","addressname","address","tombon","amphure","zip_code","province","city","location","type_id")
		
class UserSerializer(serializers.ModelSerializer):
	class Meta:
		model = User
		fields = '__all__'



class ProfileSerializer(serializers.ModelSerializer):

	user = serializers.SerializerMethodField(read_only=True)
	homeaddress = serializers.SerializerMethodField(read_only=True)
	officeaddress = serializers.SerializerMethodField(read_only=True)
	presentpositionaddress = serializers.SerializerMethodField(read_only=True)


	class Meta:
		model = Profile
		fields = ['user','phone','homeaddress','officeaddress','presentpositionaddress','order_count','type_id']

	def get_user(self,obj):
		return {
		"user_id" :obj.user.id,
		"username":obj.user.username,
		"firstname":obj.user.first_name,
		"lastname":obj.user.last_name,
		"email":obj.user.email,
		}

	def get_homeaddress(self,obj):
		if obj.homeaddress is not None:
			return {
				"homeaddress_id" : obj.homeaddress.id,
				"latitude":obj.homeaddress.latitude,
				"longitude":obj.homeaddress.longitude,
				"addressname" : obj.homeaddress.addressname,
				"address" : obj.homeaddress.address,
				"tombon" : obj.homeaddress.tombon,
				"amphure" : obj.homeaddress.amphure,
				"province" : obj.homeaddress.province,
				"city" : obj.homeaddress.city,
				"zip_code" : obj.homeaddress.zip_code,
				"type_id" : obj.homeaddress.type_id
			}
		else:
			return {
				"homeaddress_id" : "",
				"latitude":"",
				"longitude":"",
				"addressname":"",
				"address" : "",
				"tombon" : "",
				"amphure" : "",
				"province" : "",
				"city" : "",
				"zip_code" : "",
				"type_id" : ""
			}
	def get_officeaddress(self,obj):
		if obj.officeaddress is not None:
			return {
				"officeaddress_id" : obj.officeaddress.id,
				"latitude":obj.officeaddress.latitude,
				"longitude":obj.officeaddress.longitude,
				"addressname" : obj.officeaddress.addressname,
				"address" : obj.officeaddress.address,
				"tombon" : obj.officeaddress.tombon,
				"amphure" : obj.officeaddress.amphure,
				"province" : obj.officeaddress.province,
				"city" : obj.officeaddress.city,
				"zip_code" : obj.officeaddress.zip_code,
				"type_id" : obj.officeaddress.type_id
			}
		else:
			return {
				"officeaddress_id" : "",
				"latitude":"",
				"longitude":"",
				"addressname":"",
				"address" : "",
				"tombon" : "",
				"amphure" : "",
				"province" : "",
				"city" : "",
				"zip_code" : "",
				"type_id" : ""
			}
	def get_presentpositionaddress(self,obj):
		if obj.presentpositionaddress is not None:
			return {
				"presentpositionaddress_id" : obj.presentpositionaddress.id,
				"latitude":obj.presentpositionaddress.latitude,
				"longitude":obj.presentpositionaddress.longitude,
				"addressname" : obj.presentpositionaddress.addressname,
				"address" : obj.presentpositionaddress.address,
				"tombon" : obj.presentpositionaddress.tombon,
				"amphure" : obj.presentpositionaddress.amphure,
				"province" : obj.presentpositionaddress.province,
				"city" : obj.presentpositionaddress.city,
				"zip_code" : obj.presentpositionaddress.zip_code,
				"type_id" : obj.presentpositionaddress.type_id
			}
		else:
			return {
				"presentpositionaddress_id" : "",
				"latitude":"",
				"longitude":"",
				"location":"",
				"addressname":"",
				"tombon" : "",
				"amphure" : "",
				"province" : "",
				"city" : "",
				"zip_code" : "",
				"type_id" : ""
			}


class UpdateAddressProfileuserSerializer(serializers.ModelSerializer):
	class Meta:
		model = Profile
		fields = ['id','user','phone','homeaddress','officeaddress','presentpositionaddress','order_count','type_id']




class RegisterSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(
            required=True,
            validators=[UniqueValidator(queryset=User.objects.all())]
            )

    password = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = User
        fields = ('id','username', 'password', 'password2', 'email', 'first_name', 'last_name')
        extra_kwargs = {
            'first_name': {'required': True},
            'last_name': {'required': True}
        }

    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Password fields didn't match."})

        return attrs

    def create(self, validated_data):
        user = User.objects.create(
            username=validated_data['username'],
            email=validated_data['email'],
            first_name=validated_data['first_name'],
            last_name=validated_data['last_name'],
            is_active=True,
            is_staff=True,
        )
        user.set_password(validated_data['password'])
        user.save()

        profile = Profile.objects.create(
        	user = User.objects.get(username=user.username),
            phone = validated_data['username']
            
    	)

        return user

       
        
        


        

class UserLoginSerializer(serializers.ModelSerializer):
	class Meta:
		model = User
		fields = ['username','password']







'''class FriendSerializer(serializers.ModelSerializer):
	owner = serializers.HiddenField(
		default = serializers.CurrentUserDefault()
		)
	#has_overdue = serializers.SerializerMethodField()

	class Meta:
		model = Friend
		fields = ["id","name","owner"]

	def get_has_overdue(self,obj):
		if hasattr(obj,'ann_overdue'):
			return obj.ann_overdue
		return obj.borrowed_set.filter(
			returned__isnull=True,when=pendulum.now().subtract(months=2)).exist()

class BelongingSerializer(serializers.ModelSerializer):
	
	class Meta:
		model = Belonging
		fields = ["id","name"]
		

class BorrowedSelializer(FlexFieldsModelSerializer):
	
	class Meta:
		model = Borrowed
		fields = ["id","what","to_who","when","returned"]
		expandable_fields = {
		'to_who': FriendSerializer,
		'what': BelongingSerializer ,
		
		}'''
		






