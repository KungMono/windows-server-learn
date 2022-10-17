**實例一：複製特定類型檔案**

隨時將源資料夾中的純文本 `TXT`、Word我的文件`DOC`還有`BMP`、`TIF`圖像文件複製到目標資料夾中，這是在「檔案總管」中直接拖放所做不到的
`/s `表示跳過空資料夾

```
robocopy c:\source c:\destination *.pptx *.xlsx *.jpg *.png /s
```

**實例二：複製所有子目錄包括空資料夾**

將資料夾下的所有文件包括空資料夾全部複製到目標資料夾
`/e `表示複製所有子目錄包括空資料夾

```
robocopy c:\source c:\destination *.pptx *.xlsx *.jpg *.png /e
```

**實例三：複製兩個層級內的文件**

如果只想複製兩個層級內的文件，再下的層級裡的文件則不拷貝
`/lev:2` 表示複製的層級
比如指定層級後 c:\source\code\data（二級）下的文件會被複製，而 c:\source\code\data\app（三級）下的文件則不被複製。

```
robocopy c:\source c:\destination /e /lev:3
```

**實例四：垃圾文件不複製**

在制作備份資料時，不可避免會將類似於`BAK`、`TMP`的垃圾文件也複製到目標資料夾，用Robocopy可以將我們經常碰到的垃圾文件在拷貝時就清理出家門，從而產生一個乾乾淨淨的資料夾
`/xf`為指定不執行複製操作的檔案類型後面的檔案名支持萬用字元

```
robocopy c:\source c:\destination /e /xf *.tmp *.bak
```

`/xd`表示排除後面指定的資料夾。

```
robocopy c:\source c:\destination /e /xd Chapter11
```

**實例五：大文件 我不要**
複製的時候，為了節省時間，需要將一些大文件暫時不拷貝，等有空閒時間時，再執行複製操作不遲

```
robocopy c:\source c:\destination /e /max:1048576
```

**實例六：完全複製**

我們一般採取的複製方式預設值是增量複製，即根據文件的大小、修改時間將源資料夾裡的內容向目標資料夾複製，久而久之，目標資料夾裡就可能存在大量源件夾裡 早已經移除且無用的文件和資料夾。如果要讓制作備份完全相同，即拷貝時移除在目標資料夾裡存在但源資料夾裡並沒有的文件

/mir的作用等同於/purge /e，/purge表示清理目標資料夾有而源資料夾裡沒有的文件（夾）。通過這個指令，能保證源資料夾和目標資料夾結構與文件完全相同。這在新增映射制作備份時，非常有用

```
robcopy c:\source c:\destination /mir  
```





