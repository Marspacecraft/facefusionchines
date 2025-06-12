# Video2x Mac环境安装

- Video2X没有Mac安装包，需要手动下载

## 安装依赖

### 安装 pkg-config 以便 CMake 能找到其他库

```bash
brew install pkg-config
```

### 安装 FFmpeg, spdlog, Boost, Ncnn依赖

```bash
brew install ffmpeg spdlog boost ncnn
```

### 安装llvm

clang对OpenMP支持不足，使用llvm编译

```bash
brew install llvm
```

## 安装Vulkan

[LunarXchange](https://vulkan.lunarg.com/sdk/home)

## 下载Video2X

- git下载

```bash
git clone --recurse-submodules https://github.com/k4yt3x/video2x.git
```

- .`git`文件太大，速度较慢，可以手动下载(同时下载依赖项目)

## 编译前修改

### 支持mac环境链接

```makefile
# 根目录CMakeLists.txt修改为下面形式
if(NOT APPLE)
  # 在linux环境使用这个选项
  target_link_options(some_target PRIVATE -Wl,--gc-sections)
endif()
```

#### 指定链接库路径

```cmake
# 生成libvideo2x前指定库路径
if(APPLE)
	target_link_directories(libvideo2x PRIVATE 
		${libavcodec_LIBRARY_DIRS}
		${libavfilter_LIBRARY_DIRS}
		${libavformat_LIBRARY_DIRS}
        ${libavutil_LIBRARY_DIRS}
        ${libswscale_ILIBRARY_DIRS}
	)
endif()
```

```cmake
# 生成video2x前指定库路径	
if(APPLE)
	target_link_directories(video2x PRIVATE 
		${libavcodec_LIBRARY_DIRS}
		${libavfilter_LIBRARY_DIRS}
	)
endif()
```

## cmake编译

```bash
# 创建构建目录
mkdir build && cd build

# 运行 cmake，默认会使用系统安装的库
# 如果你是 Apple Silicon 用户，可以加上 -DVIDEO2X_ENABLE_NATIVE=ON
# 如果你是 Intel Silicon 用户，可以加上 -VIDEO2X_ENABLE_X86_64_V4=ON 或VIDEO2X_ENABLE_X86_64_V3=ON
cmake -DVIDEO2X_ENABLE_NATIVE=ON .. 

# 运行编译
make VERBOSE=1

# 安装（可选）
sudo make install > ../installinfo.txt
```

### 编译问题---无法找到OpenMP

```bash
  The link interface of target "ncnn" contains:

    OpenMP::OpenMP_CXX

  but the target was not found.  Possible reasons include:
```

- 安装libomp

```bash
brew install libomp
```

- 使用llvm进行编译

```bash
# 设置CC和CXX编译器为llvm
CC=$(brew --prefix llvm)/bin/clang CXX=$(brew --prefix llvm)/bin/clang++ cmake -DVIDEO2X_ENABLE_NATIVE=ON .. r
```

#### 如果能生成Makefile文件，基本就可以编译成功

#### make 可能报错，根据报错直接修改对应的编译文件即可
