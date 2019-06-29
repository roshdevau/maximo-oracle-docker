# Maximo 761 on WebSphere 9 with an Oracle 12c backend

This project is inspired by the maximo-docker github project https://github.com/nishi2go/maximo-docker and the Oracle DB github project  https://github.com/oracle/docker-images/.

The project also sets up the following supported add-ons with Maximo 761:
* Maximo HSE
* Maximo Scheduler
* Maximo Linear

The list of IBM Installers required are: 
* MAM_7.6.1.0_LINUX64.tar.gz - The package contains the Installation Manager and Maximo 761 base product installation files
* Middl_Inst_WAS_90_1of3_Unix.tar.gz - WebSphere 9.0.0.7 Installation files with SDK installation files Part 1
* Middl_Inst_WAS_90_2of3_Unix.tar.gz - WebSphere 9.0.0.7 Installation files with SDK installation files Part 2
* Middl_Inst_WAS_90_3of3_Unix.tar.gz - WebSphere 9.0.0.7 Installation files with SDK installation files Part 3
* linuxx64_12201_database.zip - Oracle 12.2.0.1 installation binary
* MAMMTFP7611IMRepo.zip - Maximo 7611 fix pack
* Max_HSEM_V761.zip - Maximo HSE 761 installation files
* MAX_LNEAR_ASET_MGR_7.6_MP_ML.zip - Maximo 7.6 Linear installation files
* MAM_Scheduler_7.6.7.zip - Maximo 767 Scheduler Installation files


# Creating Images
Clone Repository
git clone https://github.com/roshdevau/maximo-oracle-docker.git

Navigate to the repository folder
cd maximo-oracle-docker

Place the above installer files in the directory **maximo-oracle-docker/binaries** before proceeding.
Execute the below command in the maximo-oracle-docker directory
./buildMaximoImages.sh

# Creating the Containers
docker-compose up -d
# Removing the Containers and Network
docker-compose down
# Viewing Logs of all containers together
docker-compose logs -f
