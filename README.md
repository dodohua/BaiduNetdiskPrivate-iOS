# BaiduNetdiskPrivate-iOS  
基于iOS版百度云盘的解除本地p2p限速，可同时下载多个项目
* 百度网盘的ipa，自己下载个脱壳的放到对应目录
* 项目依赖[theos](https://github.com/theos/theos)和[MonkeyDev](https://github.com/AloneMonkey/MonkeyDev)
* hook方法使用我自己写的[KMHookBlock](https://github.com/dodohua/KMHookBlock) 方便hook方法
* 项目基于mac os和xcode
## theos 安装教程
1.ldid、Dpkg安装: (使用Homebrew进行安装)

```
brew install dpkg ldid
```
2.Theos安装       
把Theos安装在/opt/theos 目录下

```
sudo git clone --recursive https://github.com/theos/theos.git /opt/theos  
```      
然后把/opt/theos的权限改为自己所拥有 
sudo chown $(id -u):$(id -g) /opt/theos
**最后把theos的执行路径加入到环境变量中,在~/.bash_profile中加入两行代码 **

```
vim ~/.bash_profile

export THEOS=/opt/theos
export PATH=/opt/theos/bin/:$PATH

source ~/.bash_profile
```
在终端中输入 nic.pl，New Instance Creator开始执行则已经安装成功
## MonkeyDev 安装

```
git clone https://github.com/AloneMonkey/MonkeyDev.git
cd MonkeyDev/bin
xcode-select -p
sudo ./md-install

```


