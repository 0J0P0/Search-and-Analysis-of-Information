# Start with the Elasticsearch base image
FROM docker.elastic.co/elasticsearch/elasticsearch:8.15.1

# Switch to root user to install Python and dependencies
USER root

# Install dependencies for adding Python
RUN apt-get update && \
    apt-get install -y wget software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-distutils python3-pip && \
    apt-get clean

# Install pip by downloading get-pip.py directly
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3.11 get-pip.py && \
    rm get-pip.py

# Upgrade pip and setuptools after installing pip
RUN python3.11 -m pip install --upgrade pip setuptools

# Install html5lib to avoid the ImportError
RUN python3.11 -m pip install html5lib


# # Create a folder called CAI
# RUN mkdir /CAI
# RUN mkdir /CAI/Lab1
# RUN mkdir /CAI/Lab2
# RUN mkdir /CAI/Lab3
# RUN mkdir /CAI/Lab4
# RUN mkdir /CAI/Lab5
# RUN mkdir /CAI/Lab6
# RUN mkdir /CAI/Lab7
# RUN mkdir /CAI/Lab8
# RUN mkdir /CAI/Lab9

# # Copy the Laboratory folders to the CAI folder
# COPY ./Lab1 /CAI/Lab1
# COPY ./Lab2 /CAI/Lab2
# COPY ./Lab3 /CAI/Lab3
# COPY ./Lab4 /CAI/Lab4
# COPY ./Lab5 /CAI/Lab5
# COPY ./Lab6 /CAI/Lab6
# COPY ./Lab7 /CAI/Lab7
# COPY ./Lab8 /CAI/Lab8
# COPY ./Lab9 /CAI/Lab9

# Copy the requirements.txt file to the CAI folder
COPY ./requirements.txt /CAI

# Install the required Python packages
RUN python3.11 -m pip install -r /CAI/requirements.txt

# Switch back to elasticsearch user for security
USER elasticsearch

# Verify Python installation
RUN python3 --version
