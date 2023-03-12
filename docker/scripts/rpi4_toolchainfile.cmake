set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
set(CMAKE_C_COMPILER aarch64-linux-gnu-gcc-11)
set(CMAKE_CXX_COMPILER aarch64-linux-gnu-g++-11)

set(CMAKE_SYSROOT /root/rootfs)

set(CMAKE_FIND_ROOT_PATH
  /root/ros2_ws/install
  /root/ros2/install
  /root/rootfs
)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_SYSTEM_PROCESSOR aarch64)

# set(CMAKE_BUILD_RPATH /root/rootfs/opt/vc)

# This assumes that pthread will be available on the target system
# (this emulates that the return of the TRY_RUN is a return code "0"
set(THREADS_PTHREAD_ARG "0"
  CACHE STRING "Result from TRY_RUN" FORCE)

set(SM_RUN_RESULT "PTHREAD_RWLOCK_PREFER_READER_NP"
  CACHE STRING "Result from TRY_RUN" FORCE)
set(SM_RUN_RESULT__TRYRUN_OUTPUT "PTHREAD_RWLOCK_PREFER_READER_NP"
  CACHE STRING "Result from TRY_RUN" FORCE)
# Python related
set(PYTHON_LIBRARY /root/rootfs/usr/lib/aarch64-linux-gnu/libpython3.10.a)
set(PYTHON_INCLUDE_DIR /root/rootfs/usr/include/python3.10/)
set(PYTHON_MODULE_EXTENSION ".so")
set(PYTHONLIBS_FOUND TRUE)

