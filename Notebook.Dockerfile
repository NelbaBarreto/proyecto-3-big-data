FROM python:3.10-slim

WORKDIR /app

USER root

# Install dependencies
RUN apt-get update && apt-get install -y curl wget \
    && apt-get clean

# Install OpenJDK 11
ENV JAVA_HOME=/home/jdk-11.0.2
ENV PATH="${JAVA_HOME}/bin/:${PATH}"
RUN DOWNLOAD_URL="https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz" \
    && TMP_DIR="$(mktemp -d)" \
    && curl -fL "${DOWNLOAD_URL}" --output "${TMP_DIR}/openjdk-11.0.2_linux-x64_bin.tar.gz" \
    && mkdir -p "${JAVA_HOME}" \
    && tar xzf "${TMP_DIR}/openjdk-11.0.2_linux-x64_bin.tar.gz" -C "${JAVA_HOME}" --strip-components=1 \
    && rm -rf "${TMP_DIR}" \
    && java --version

# Install Scala 2.12
ENV SCALA_HOME=/home/scala-2.12.15
ENV PATH="${SCALA_HOME}/bin:${PATH}"
RUN DOWNLOAD_URL="https://downloads.lightbend.com/scala/2.12.15/scala-2.12.15.tgz" \
    && TMP_DIR="$(mktemp -d)" \
    && curl -fL "${DOWNLOAD_URL}" --output "${TMP_DIR}/scala-2.12.15.tgz" \
    && mkdir -p "${SCALA_HOME}" \
    && tar xzf "${TMP_DIR}/scala-2.12.15.tgz" -C "${SCALA_HOME}" --strip-components=1 \
    && rm -rf "${TMP_DIR}"

# Crear el directorio para almacenar los JARs necesarios
RUN mkdir -p /app/jars

# Descargar los JARs de Hadoop para Azure
RUN wget https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-azure/3.3.0/hadoop-azure-3.3.0.jar -O /app/jars/hadoop-azure-3.3.0.jar
RUN wget https://repo1.maven.org/maven2/com/azure/azure-storage-file-datalake/12.14.1/azure-storage-file-datalake-12.14.1.jar -O /app/jars/azure-storage-file-datalake-12.14.1.jar
RUN wget https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-azure-datalake/3.3.0/hadoop-azure-datalake-3.3.0.jar -O /app/jars/hadoop-azure-datalake-3.3.0.jar

# Install the required packages & Jupyter 
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir jupyter 

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]