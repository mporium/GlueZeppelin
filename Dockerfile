FROM apache/zeppelin:0.7.3

MAINTAINER mporium 

ADD glue_zeppelin.sh $Z_HOME/bin/glue_zeppelin.sh
ADD interpreter.json $Z_HOME/conf/interpreter.json

CMD ["/zeppelin/bin/glue_zeppelin.sh"]
