from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework import status
from apps.base.api import GeneralListApiView
from apps.courses.api.serializers.courses_serializers import CourseSerializer, CourseretrieverSerializer

class CourseViewSet(viewsets.ModelViewSet):
    serializer_class = CourseSerializer

    def get_queryset(self, pk = None):
        if pk is None:
            return self.get_serializer().Meta.model.objects.filter(state = True)
        return self.get_serializer().Meta.model.objects.filter(id = pk, state = True).first()
    
    def list(self, request):
        course_serializer = self.get_serializer(self.get_queryset(), many = True)
        return Response(course_serializer.data, status= status.HTTP_200_OK)
    
    def create(self, request):
        serializer = self.get_serializer(data = request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({'msj': 'Curso creado correctamente'}, status= status.HTTP_201_CREATED)
        return Response(serializer.errors, status= status.HTTP_400_BAD_REQUEST)
    
    def update(self, request, pk = None):
        if self.get_queryset(pk):
            course_serializer = self.serializer_class(self.get_queryset(pk), data = request.data)
            if course_serializer.is_valid():
                course_serializer.save()
                return Response(course_serializer.data, status=status.HTTP_200_OK)
            return Response(course_serializer.errors,status=status.HTTP_400_BAD_REQUEST)
    
    def destroy(self, request, pk = None):
        course = self.get_queryset().filter(id = pk).first()
        if course:
            course.state = False
            course.save()
            return Response({'msj': 'Curso eliminado correctamente'}, status= status.HTTP_200_OK)
        
        return Response({'msj': 'No existe el curso con ese id'}, state = status.HTTP_400_BAD_REQUEST)
    

        