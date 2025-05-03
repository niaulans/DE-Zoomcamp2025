### Install Apache Spark
```bash
# Install Java 11
sudo apt update
sudo apt install openjdk-11-jdk -y
java -version

# Download Apache Spark
wget https://downloads.apache.org/spark/spark-3.5.5/spark-3.5.5-bin-hadoop3.tgz

# Extract the downloaded file in home directory
tar xvf spark-3.5.5-bin-hadoop3.tgz && mv spark-3.5.5-bin-hadoop3 spark

# Move the extracted folder to /opt directory
sudo mv spark /opt/

# Set environment variables
nano ~/.bashrc

# Add the following lines to the end of the file
export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH

# Save and exit the file (Ctrl + X, Y, Enter)
# Load the new environment variables
source ~/.bashrc

# Verify the installation
spark-shell
```

### Install PySpark (Global, not in a virtual environment)
```bash
# Install pip
sudo apt install python3-pip -y

# Install PySpark
pip install pyspark

# Verify the installation
python3 -c "import pyspark; print(pyspark.__version__)"
```

### Install PySpark (in a virtual environment)
```bash
# Already in the virtual environment directory
# Activate the virtual environment
source /bin/activate

# Install pip
pip install pyspark

# Verify the installation
python3 -c "import pyspark; print(pyspark.__version__)"
```

### Install Jupyter Notebook
```bash
# Already in the virtual environment directory
# Install Jupyter Notebook
pip install jupyter

# Verify the installation
jupyter --version

# Start Jupyter Notebook
jupyter notebook
```

### Connect to Google Cloud Platform
```bash
# Install Google Cloud SDK
sudo apt install google-cloud-sdk -y

# Authenticate with Google Cloud
gcloud auth login
gcloud auth application-default login
gcloud config set project <your-project-id>
```


