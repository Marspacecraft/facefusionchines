# facefusion汉化及生成app文件

## 汉化文件各环境通用

- 只支持[GitHub - facefusion/facefusion at 3.2.0](https://github.com/facefusion/facefusion/tree/3.2.0)版本

- 替换`facefusion/facefusion`文件夹下的`wording.py`

## Mac生成FaceFusion.app应用

- 将`install.sh`和`Contents`文件夹放到`facefusion`根目录下下

- **进入facefusion的conda虚拟环境**
  
  - `conda activate [虚拟环境名，一般是facefusion]`
  
  - `cd [facefusion根目录]`

- 执行

```shell
chmod u+x install.sh

./install.sh
```

- 执行成功后，会在facefusion目录生成`FaceFusion.app`和`run.sh脚本`。

- `FaceFusion.app`可以移动到其他地方，双击运行。

- `run.sh`不要删除或移动，`install.sh`和`Contents`文件夹可以删除。

## 懂的都懂

```python
def detect_nsfw(vision_frame : VisionFrame) -> List[Score]:
	return []
```
