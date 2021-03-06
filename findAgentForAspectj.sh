# we assume there are only one 
#!/bin/bash
function dofindName()
{
    parentDir=$(echo "$1")
    dir=$(ls -l $parentDir | sed -ne '/^d/p' \
                            | awk '{print $NF}' \
                            | awk -F\/ '{print $1}' \
                            | awk '!/(^(doc)|^(examples)|^(host-manager)|^(manager))/{print $NF}')
    xfinnalLib=""
    if [ "$dir" != "" ]; then {
        for i in $parentDir/"$dir"
        do
            xfinnalLib="$i/WEB-INF/lib"
        done
    }
    fi
    echo $xfinnalLib
}

if [ ! -r "$CATALINA_BASE"/bin/findAgent.sh ]; then
    echo "Cannot find $CATALINA_BASE/conf/findAgent.sh"
    echo "ignore"
else {
    finnalLib=""
    disName=""
    disName=$(sed -ne "s/[[:space:]]//g;p" $1 \
        | sed -ne "/^<[^\!]/p" \
        | sed -ne "/docBase/p" \
        | awk -F\" 'BEGIN {count=0;} {for(i=0;i<=NF;i++){if($i=="docBase="){count=i+1;break;}}} END{print $count}')
    mark="false"
    if [ "$disName" != "" ]; then {
        echo "use ContextPath's docBase $disName"
        dir=$(ls -l $disName |awk '/\.war$/{print $NF}')
        echo "here we see some war need to do $dir"

        for i in $dir
        do   
        name=$(echo $i | awk -F\. '{print $1;}')
        goalName=$disName/$name
        echo "find the war we need find: $1"
        echo "try mkdir if there no $name"
        mkdir -p $goalName
        echo "copy $name to dir"
        cp $disName/$i $goalName
        $(cd $goalName; jar -xvf $goalName/$i)
        echo "rem old war"
        $(rm $goalName/$i)
        finnalLib=$goalName/WEB-INF/lib
        if [ "$finnalLib" != "" ] ; then {
            mark="true"
        }
        fi
        done
        if [ "$mark" == "false" ]; then {
            finnalLib=$(dofindName "$disName")
            if [ "$finnalLib" != "" ]; then {
                mark="true"
            }
            fi
        }
        fi
        }
    fi
    if [ "$mark" == "false" ]; then {
        finnalLib=$(dofindName "$2")
    }
    fi
    if [ "$finnalLib" != "" ]; then {
        echo "the goal dir is $finnalLib"
        aspectj=$(ls -l  $finnalLib \
                    | awk '/\-/{print $NF}' \
                    | awk '/aspectjweaver/{print $0}' \
                    | sed -ne '1p')
        echo "aspectjweaver is $aspectj"
        if [ -f "$finnalLib/$aspectj" ]; then {
            CATALINA_ASPECTJ="$finnalLib"
            ASPECTJ_OPTS="-Dorg.aspectj.weaver.loadtime.configuration=aop.xml;INNER-INF/aop.xml -Dorg.aspectj.weaver.loadtime.configuration.lightxmlparser=true"
            echo "Using ASPECTJ_OPTS: $ASPECTJ_OPTS"
            JAVA_OPTS="$JAVA_OPTS -javaagent:$CATALINA_ASPECTJ/$aspectj  $ASPECTJ_OPTS"
        } 
        fi
        }
    fi
}
fi