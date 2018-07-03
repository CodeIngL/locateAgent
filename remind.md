### 功能 ###

简单定位用户对应tomcat的应用目录所在的位置，如果用户war中存在agent，读取并解析，并追加到JAVA_OPTS

1. 目录来自docBase下
2. 目录默认webapp下情况下

test.sh 是测试findAgent.sh的输出

### 改造 ###

修改findAgent.sh 可以改造70-90行，自定义使用

### 增加weblogic支持 ###

脚本中替换变量 

	JAVA_OPTS 为 JAVA_OPTIONS

然后参考 test.sh