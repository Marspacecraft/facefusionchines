#!/bin/bash
set -e

CONDAENV=$CONDA_DEFAULT_ENV
CONDASHPATH="$(conda info --base)/etc/profile.d/conda.sh"


# 判断是否在facefusion目录
if [ ! -f "facefusion.py" ]; then
	printf "\033[31m请把安装包放在facefusion目录！！！\n\033[0m"
	exit 1
fi


# 判断是否在虚拟环境
if [[ -n "$CONDAENV" ]]; then
	printf "\033[32m当前在 conda 虚拟环境：$CONDAENV.\n\033[0m"
else
	printf "\033[31m本脚本必须在facefusion的虚拟环境中运行！！！\n\033[0m"
	exit 1
fi

# 获取conda.sh路径
printf "\033[32m获取conda.sh路径...\n\033[0m"
if [ -f "$CONDASHPATH" ]; then
    echo "---conda.sh 路径为: $CONDASHPATH"
else
	printf "\033[31m未找到 conda.sh！！！\n\033[0m"
	exit 1
fi

# 生成facefusion run.sh脚本
printf "\033[32m生成facefusion run.sh脚本...\n\033[0m"
cat > run.sh <<EOF
#!/bin/zsh
set -e

# 初始化 conda
source $CONDASHPATH

conda activate $CONDAENV

cd $PWD
python facefusion.py run --open-browser
EOF

# chmod
if [ ! -f "run.sh" ]; then
	printf "\033[31mrun.sh生成失败！！！\n\033[0m"
	exit 1
else
	chmod u+x run.sh
	echo "---facefusion run.sh 路径为: $PWD/run.sh"
fi

# 生成FaceFusion.app run.sh脚本
printf "\033[32m生成FaceFusion.app run.sh脚本...\n\033[0m"

if [ ! -f "./Contents/MacOS/run.sh" ]; then
	printf "\033[31mrun.sh生成失败，请检查是否有Contents文件夹！！！\n\033[0m"
	exit 1
fi

if head -n 1 ./Contents/MacOS/run.sh | grep -q '^#!/bin/zsh'; then
    printf "\033[33mapp已经生成，如果要重新生成app,请重新下载Contents文件夹...\n\033[0m"
else
    sed -i '' "1i\\
#!/bin/zsh\\
SCRIPT_PATH=$PWD/run.sh\\
" ./Contents/MacOS/run.sh
	chmod u+x ./Contents/MacOS/run.sh
	echo "---FaceFusion.app run.sh 已生成"
fi

# 生成FaceFusion.app
printf "\033[32m生成FaceFusion.app...\n\033[0m"
if [ -d "FaceFusion.app" ]; then
	rm -rf "FaceFusion.app"
fi

mkdir "FaceFusion.app"
cp -r Contents FaceFusion.app/Contents


printf "\033[32mapp已经生成,路径$PWD\n\033[0m"





