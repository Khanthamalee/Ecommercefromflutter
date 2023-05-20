from rest_framework import pagination
from rest_framework.response import Response
from collections import OrderedDict
import time

class CustomPagination(pagination.LimitOffsetPagination):
    default_limit = 100
    limit_query_param = 'l'
    offset_query_param = 'o'
    max_limit = 100
    

    def get_paginated_response(self, data):
        print(data)
        if "type_id" in data[0]:
            typeid = data[0]["type_id"]
            print(typeid)
        elif "type_id" not in data[0]:
            typeid = 0
            #print(typeid)

        return Response(OrderedDict([
            ('total_size', self.count),
            #('next', self.get_next_link()),
            #('previous', self.get_previous_link()),
            ('type_id',typeid),
            ('offset',self.offset),
            ('products', data)
        ]))

    