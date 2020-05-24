idea
==============

work in vim
----------------------------------------------------------------

插件
^^^^^^

- IdeaVim
- IdeaVim-EasyMotion 和 AceJump     easyMotion

.. code-block:: bash
   :caption: ideavimrc

   " leader: ,
   let mapleader = ","

   set easymotion

快捷键
^^^^^^^^^^

.. code-block:: sh

   gd/gD             declare/definition
   Ctrl+]            跳转到当前标识符的定义位置 （相当于在当前光标位置的单词上按住ctrl用鼠标点击）
   Ctrl+o            回退一步 (go back)
   Ctrl+i            前进一步 (go forward)
   Ctrl+Shift+E      最近更改的文件
   
   gt                下一页/tab
   gT                上一页/tab
   
   Ctrl+shift+f      find in files
   double shift      search everything
   # 窗口跳转
   cmd+1             project window
   cmd+ctrl+1        terminal 
   cmd+ctrl+f        structure

   # 注释 , 需要安装 commentary vim 插件
   # gcc/gc
   set commentary


参考
^^^^^^^^

- `idea vim 快捷键 <https://github.com/JetBrains/ideavim/blob/master/src/com/maddyhome/idea/vim/package-info.java>`_
- `idea vim easymotion <https://github.com/AlexPl292/IdeaVim-EasyMotion>`_
- `idea.vimrc <https://gist.github.com/dewaka/ef947e52767bf453eaf77c852051eb7e>`_
