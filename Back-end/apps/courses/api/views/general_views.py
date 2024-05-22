from rest_framework import generics

from apps.base.api import GeneralListApiView
from apps.courses.api.serializers.general_serializers import TutorSerializer, CategorySerializer

class TutorListApiview(GeneralListApiView):
    serializer_class = TutorSerializer
    
class CategoryListApiview(GeneralListApiView):
    serializer_class = CategorySerializer

    