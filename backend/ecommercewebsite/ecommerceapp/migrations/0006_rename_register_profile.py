# Generated by Django 4.1.7 on 2023-04-03 12:46

from django.conf import settings
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('ecommerceapp', '0005_alter_register_type_id'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='Register',
            new_name='Profile',
        ),
    ]