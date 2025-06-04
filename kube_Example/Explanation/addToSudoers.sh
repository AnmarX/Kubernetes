#access root
su -

#access sudo files
nano /etc/sudoers

#add sudo name
<hostname>   ALL=(ALL:ALL) ALL

#Fix time for any errors 

    #hardware clock
    sudo timedatectl set-local-rtc 1
    #recomended by linux
    sudo timedatectl set-local-rtc 0