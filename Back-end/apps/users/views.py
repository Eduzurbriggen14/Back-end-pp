from django.contrib.auth import authenticate

from rest_framework import status
from rest_framework.generics import GenericAPIView
from rest_framework.response import Response

from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.views import TokenObtainPairView

from apps.users.api.serializers import (
    CustomTokenObtainPairSerializer, CustomUserSerializer
)
from apps.users.models import CustomUser


class Login(TokenObtainPairView):
    serializer_class = CustomTokenObtainPairSerializer

    def post(self, request, *args, **kwargs):
        email = request.data.get('email', '')
        password = request.data.get('password', '')
        user = authenticate(email=email, password=password)

        if user:
            login_serializer = self.serializer_class(data=request.data)
            if login_serializer.is_valid():
                user_serializer = CustomUserSerializer(user)
                return Response({
                    'token': login_serializer.validated_data.get('access'),
                    'refresh_token': login_serializer.validated_data.get('refresh'),
                    'user': user_serializer.data,
                    'message': 'Inicio de Sesion Existoso'
                }, status=status.HTTP_200_OK)
            return Response({'error': 'Contraseña o email incorrectos'}, status=status.HTTP_400_BAD_REQUEST)
        return Response({'error': 'Contraseña o email incorrectos'}, status=status.HTTP_400_BAD_REQUEST)
""" 
class Logout(GenericAPIView):
    def post(self, request, *args, **kwargs):
        user = CustomUser.objects.filter(id = request.data.get("user", ""))
        if user.exists():
            RefreshToken.for_user(user.first())
            return Response({"message": "sesion cerrada correctamente"}, status=status.HTTP_200_OK)
        return Response({'error': 'no existe este usuario'}, status=status.HTTP_400_BAD_REQUEST)

 """

"""class Register(APIView):
    model = CustomUser
    serializer_class = CustomUserSerializer
    permission_classes = (AllowAny,)
    
    def post(self, request):
        user_serializer = self.serializer_class(data=request.data)
        if user_serializer.is_valid():
            user_serializer.save()
            return Response({
                'message': 'Usuario registrado correctamente.'
            }, status=status.HTTP_201_CREATED)
        return Response({
            'message': 'Hay errores en el registro',
            'errors': user_serializer.errors
        }, status=status.HTTP_400_BAD_REQUEST)"""