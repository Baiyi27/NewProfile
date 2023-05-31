## zsh 安装
1. 需要安装 ZSH 并将其设置为 Ubuntu 中的默认 shell。
`sudo apt install zsh`

   + 通过检查安装的版本确保安装成功：
`zsh --version`

1. 第 2 步 - 将默认 shell 设置为 ZSH
`echo $SHELL`
`chsh -s $(which zsh)` 或者`usermod -s $(which zsh) [username]`


3. 安装 Oh My ZSH
sudo apt install curl wget git -y
```html
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 主题

```diff
中国用户可以使用 gitee.com 上的官方镜像加速下载.
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
`Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc.`
在` ~/.zshrc` 中设置 `ZSH_THEME="powerlevel10k/powerlevel10k"` 。
## 插件

### autosuggestions 
lone this repository into $ZSH_CUSTOM/plugins (by default ~/.oh-my-zsh/custom/plugins)
将此存储库克隆到 $ZSH_CUSTOM/plugins （默认为 ~/.oh-my-zsh/custom/plugins ）

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Add the plugin to the list of plugins for Oh My Zsh to load (inside ~/.zshrc):
将插件添加到要加载的 Oh My Zsh 的插件列表中（在 ~/.zshrc 内）：

        plugins=( 
            # other plugins...
            zsh-autosuggestions
        )

### highlighting
Clone this repository in oh-my-zsh's plugins directory:
在 oh-my-zsh 的插件目录中克隆这个存储库：

```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

Activate the plugin in ~/.zshrc:
在 ~/.zshrc 激活插件：

        plugins=( [plugins...] zsh-syntax-highlighting)
### cleaner
        sudo add-apt-repository ppa:gerardpuig/ppa
        sudo apt-get update
        sudo apt-get install ubuntu-cleaner

