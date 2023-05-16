from django.db import models
from datetime import date
from django.conf import settings 
from location_field.models.plain import PlainLocationField
from django.contrib.auth.models import User




class OwnedModel(models.Model):
    owner = models.ForeignKey(settings.AUTH_USER_MODEL,on_delete=models.CASCADE)

    class Meta:
        abstract = True  

    def __str__(self):
        return self.name

class Location1(models.Model):
    addressname = models.CharField(max_length=300,null=True,blank=True)
    address = models.CharField(max_length=1024,null=True,blank=True)
    tombon = models.CharField(max_length=1024,null=True,blank=True)
    amphure = models.CharField(max_length=1024,null=True,blank=True)
    zip_code = models.CharField(max_length=12,null=True,blank=True)
    province = models.CharField(max_length=1024,null=True,blank=True)
    city = models.CharField(default='Thailand',max_length=1024)
    latitude = models.FloatField(null=True,blank = True)
    longitude = models.FloatField(null=True,blank = True)
    location = PlainLocationField(based_fields=['city','province'], zoom=7)
    type_id = models.IntegerField(default=3,null = True,blank = True)


    def __str__(self):
        return '{} - {}'.format(self.location,self.addressname)

class Location2(models.Model):
    addressname = models.CharField(max_length=300,null=True,blank=True)
    address = models.CharField(max_length=1024,null=True,blank=True)
    tombon = models.CharField(max_length=1024,null=True,blank=True)
    amphure = models.CharField(max_length=1024,null=True,blank=True)
    zip_code = models.CharField(max_length=12,null=True,blank=True)
    province = models.CharField(max_length=1024,null=True,blank=True)
    city = models.CharField(default='Thailand',max_length=1024)
    latitude = models.FloatField(null=True,blank = True)
    longitude = models.FloatField(null=True,blank = True)
    location = PlainLocationField(based_fields=['city','province'], zoom=7)
    type_id = models.IntegerField(default=5,null = True,blank = True)


    def __str__(self):
        return '{} - {}'.format(self.location,self.addressname)

class Location3(models.Model):
    addressname = models.CharField(max_length=300,null=True,blank=True)
    address = models.CharField(max_length=1024,null=True,blank=True)
    tombon = models.CharField(max_length=1024,null=True,blank=True)
    amphure = models.CharField(max_length=1024,null=True,blank=True)
    zip_code = models.CharField(max_length=12,null=True,blank=True)
    province = models.CharField(max_length=1024,null=True,blank=True)
    city = models.CharField(default='Thailand',max_length=1024)
    latitude = models.FloatField(null=True,blank = True)
    longitude = models.FloatField(null=True,blank = True)
    location = PlainLocationField(based_fields=['city','province'], zoom=7)
    type_id = models.IntegerField(default=6,null = True,blank = True)


    def __str__(self):
        return '{} - {}'.format(self.location,self.addressname)

class LocationType(models.Model):
    CHOICES = (("home","homeaddress"),("office","officeaddress"),("currentposition","currentpositionaddress"))
    address_type =models.CharField(max_length = 300,choices=CHOICES)
    location = models.ForeignKey(Location1,on_delete=models.CASCADE,null=True,blank=True)

class Profile(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE)
    phone = models.CharField(max_length=13,null=True,blank=True)
    homeaddress = models.ForeignKey(Location1,on_delete=models.CASCADE,null=True,blank=True)
    officeaddress = models.ForeignKey(Location2,on_delete=models.CASCADE,null=True,blank=True)
    presentpositionaddress = models.ForeignKey(Location3,on_delete=models.CASCADE,null=True,blank=True)
    order_count = models.IntegerField(default=0,null=True,blank=True)
    type_id = models.IntegerField(default=4,null = True,blank = True)

    def __str__(self):
        return self.user.username


class Recommended (models.Model):
    name = models.CharField(max_length=300)
    description = models.TextField(null=True,blank=True)
    price = models.IntegerField(null=True,blank=True)
    stars = models.IntegerField(null=True,blank = True)
    img = models.ImageField(upload_to='product',null=True,blank=True)
    location = models.TextField(null=True,blank=True)
    create_At = models.DateField(auto_now_add=True)
    update_At = models.DateField(default=date(9999, 12, 31))
    type_id = models.IntegerField(default=2,null = True,blank = True)

    '''class Meta:
        ordering = ['-create_At']'''
        
        
    def __str__(self):
        return '{} ราคา {} create_At {}'.format(self.name,self.price,self.create_At)

class Popular(models.Model):
    name = models.CharField(max_length=300)
    description = models.TextField(null=True,blank=True)
    price = models.IntegerField(null=True,blank=True)
    stars = models.IntegerField(null=True,blank = True)
    img = models.ImageField(upload_to='product',null=True,blank=True)
    location = models.TextField(null=True,blank=True)
    create_At = models.DateField(auto_now_add=True)
    update_At = models.DateField(default=date(9999, 12, 31))
    type_id = models.IntegerField(default=1,null = True,blank = True)

    '''class Meta:
        ordering = ['-create_At']'''

    def __str__(self):
        return '{} ราคา {} create_At {}'.format(self.name,self.price,self.create_At)


'''class Friend(models.Model):
    name = models.CharField(max_length=100)
    def __str__(self):
        return self.name



class FriendQuerySet(models.QuerySet):
    def with_overdue(self):
        return self.annotate(
            ann_overdue = models.Case(
                models.When(borrowed__when__lte = pendulum.now().subtract(months = 2),includethen = true),
                default = modelsValue(False),
                output_field=models.BooleanField()
                )
            )
class Friend(OwnedModel):
    name = models.CharField(max_length=100)
    objects = FriendQuerySet.as_manager()

    @property
    def has_overdue(self):
        if hasattr(self,'ann_overdue'):
            return self.ann_overdue
        return self.borrowed_set.filter(
            returned__isnull = True,when = pendulum.now().subtract(months = 2)
            ).exists()

    def __str__(self):
        return self.name

class Belonging(OwnedModel):
    name = models.CharField(max_length=100)

class Borrowed(models.Model):
    what = models.ForeignKey(Belonging,on_delete=models.CASCADE)
    to_who = models.ForeignKey(Friend,on_delete=models.CASCADE)
    when = models.DateTimeField(auto_now_add=True)
    returned = models.DateTimeField(null=True,blank=True)
    def __str__(self):
        return '{} ยืมโดย {} ส่งคืน {}'.format(self.what,self.to_who,self.returned)

'''






