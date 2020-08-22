

    echo "   "
    echo " ################### I2B2 ######################  "
    echo "   "

for x in ec2-user@52.91.118.56  ec2-user@52.201.221.251 root@184.73.215.50 ec2-user@107.20.249.75 
do
   echo " $x "
   	ssh  -i /home/kmullins/secret/i2b2key.pem $x "df -h & top -b | head -n 5  "
    echo "   "

done     


    echo "   "
    echo "   "
    echo " ################### TRANSMART ######################  "
    echo "   "
    echo "   "

for i in  ubuntu@ec2-52-207-245-82.compute-1.amazonaws.com ubuntu@ec2-52-200-164-25.compute-1.amazonaws.com centos@ec2-34-228-157-32.compute-1.amazonaws.com  ubuntu@ec2-54-86-76-232.compute-1.amazonaws.com ubuntu@ec2-52-23-207-190.compute-1.amazonaws.com ubuntu@ec2-52-200-132-108.compute-1.amazonaws.com ubuntu@ec2-52-86-153-239.compute-1.amazonaws.com centos@ec2-50-16-141-243.compute-1.amazonaws.com 
do   echo " $i "
   	ssh  -i /home/kmullins/secret/transmart-key-pair.pem $i "df -h & top -b | head -n 5  "
    echo "   "

    echo "   "
done     
    

# ssh -i "transmart-key-pair.pem" ubuntu@ec2-52-207-245-82.compute-1.amazonaws.com  ### Monitor
# ssh -i "transmart-key-pair.pem" ubuntu@ec2-52-200-164-25.compute-1.amazonaws.com  ### tm-16.1-production
# ssh -i "transmart-key-pair.pem" root@ec2-34-228-157-32.compute-1.amazonaws.com    ### transmart-puppet
# ssh -i "transmart-key-pair.pem" root@ec2-54-86-76-232.compute-1.amazonaws.com     ### ci-host
# ssh -i "transmart-key-pair.pem" root@ec2-52-23-207-190.compute-1.amazonaws.com    ### BT-oracle-Bridge
# ssh -i "transmart-key-pair.pem" ubuntu@ec2-52-200-132-108.compute-1.amazonaws.com ### tm-lib
# ssh -i "openbell-key.pem" ubuntu@ec2-23-23-65-7.compute-1.amazonaws.com           ### OpenBell Infrastructure
# ssh -i "transmart-key-pair.pem" root@ec2-52-86-153-239.compute-1.amazonaws.com    ### tm-16.2-test
# ssh -i "transmart-key-pair.pem" root@ec2-50-16-141-243.compute-1.amazonaws.com    ### Transmart Atlassian




