# Generated by Django 4.1.7 on 2023-05-15 17:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('ecommerceapp', '0015_location1_latitude_location1_longitude_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='location2',
            name='latitude',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='location2',
            name='longitude',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='location3',
            name='latitude',
            field=models.FloatField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='location3',
            name='longitude',
            field=models.FloatField(blank=True, null=True),
        ),
    ]
