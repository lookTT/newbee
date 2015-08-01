################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/app.cpp \
../src/config.cpp \
../src/httpserver.cpp \
../src/lualogic.cpp \
../src/main.cpp \
../src/md5.cpp \
../src/websockets.cpp 

OBJS += \
./src/app.o \
./src/config.o \
./src/httpserver.o \
./src/lualogic.o \
./src/main.o \
./src/md5.o \
./src/websockets.o 

CPP_DEPS += \
./src/app.d \
./src/config.d \
./src/httpserver.d \
./src/lualogic.d \
./src/main.d \
./src/md5.d \
./src/websockets.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


