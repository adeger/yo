FROM anapsix/alpine-java:8_server-jre
RUN addgroup youser && adduser -D -G youser -s /bin/bash youser && \
    mkdir '/home/youser/.ssh' && chmod 700 '/home/youser/.ssh' && \
    apk add python --no-cache && apk add py-pip --no-cache && \
    pip install --no-cache-dir flask && \
    pip install pymysql --no-cache-dir


COPY yo-1.2.3-SNAPSHOT.jar  /home/youser/yo-1.2.3-SNAPSHOT.jar
COPY yo-1.2.3-SNAPSHOT.py  /home/youser/yo-1.2.3-SNAPSHOT.py

RUN chown -R youser:youser '/home/youser/'


EXPOSE 8080

ENV DB_SERVER 127.0.0.1

USER youser

#CMD ["/bin/sh", "-c", "java -jar /home/youser/yo-1.2.3-SNAPSHOT.jar -Dserver.port=8080 -Dspring.datasource.url=jdbc:mysql://${DB_SERVER}:3306/yo >/home/youser/yo.log 2>&1"]
CMD ["/bin/sh", "-c", "python /home/youser/yo-1.2.3-SNAPSHOT.py >/home/youser/yo-py.log 2>&1"]

