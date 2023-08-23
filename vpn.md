
* Using VPN connection, we can connect other vpc machines to another vpc resources (without VPC peering )

1) Lets suppose we have 2 regions - 

    i) Mumbai          = VPC1 (AWS Database VPC - Pvt Subnet & IPs)

    ii) North Verg.     = VPC2 (customer Application VPC - Pub Subnet & IPs)
    
    Now, the VPC2 application should have access to connect with VPC1 database (privately)
    For, this we need to create VPN, so that VPC2 Application can connect with VPC1 Database.


----------------- Process of creating VPN connection -----------

 ***We need to add VPN in Region1 (Mumbai)***
 
1) Create Customer Gateway                  = here we need to put customer server PUBLIC IP.

2) Create Virtual Private Gateway           = after creating this, attach with VPC (with VPC1 where this VPN is creating)

3) Create Site-to-Site VPN Connections      = here we need to select Customer Gateway, and Virtual Private Gateway (that created recently)
                                              Now, we need to **Download Configuration** and into that downloaded file it gives certain keys
                                              that will be using in below configurations.
                                            -> select **Static** option in **Routing options** & enter **customer subnet CIDR (pub or pvt subnet)**
                                               whichever has to be connected.
                                              
4) Now, need to Enable Virtual Private Gateway in **Route Table Propagation** in VPC1 Private Route Table.
    - go to route table = add propagation it will show Virtual Private Gateway automatically there, just click to enable.
    - by doing this, both VPC can communicate with each other (within enabled propagated Route table resources)


------------------------------------ Configure this in Customer machine --------------------

After creating side-to-side VPN connection

    1.  Commands for Installation of Openswan
        i. Change to root user: 
                    $ sudo su
        ii. Install openswan:
                    $ yum install openswan -y
        iii. In /etc/ipsec.conf uncomment following line if not already 
              uncommented:
                     include /etc/ipsec.d/*.conf
        iv. Update /etc/sysctl.conf to have following
     net.ipv4.ip_forward = 1
     net.ipv4.conf.all.accept_redirects = 0
     net.ipv4.conf.all.send_redirects = 0
        v. Restart network service:
                     $ service network restart

    2. Command for /etc/ipsec.d/aws-vpn.conf
    conn Tunnel1
            authby=secret
            auto=start
            left=%defaultroute
            leftid=Customer end Gateway VPN public IP
            right=tunnel1 ip address (Virtual Private Gateway - can be found in site-to-site downloaded config file)
            type=tunnel
            ikelifetime=8h
            keylife=1h
            phase2alg=aes128-sha1;modp1024
            ike=aes128-sha1;modp1024
            keyingtries=%forever
            keyexchange=ike
            leftsubnet=Customer end public cidr block
            rightsubnet=db subnet cidr block (which has to be connected - pub/pvt)
            dpddelay=10
            dpdtimeout=30
            dpdaction=restart_by_peer

    3. Contents for  /etc/ipsec.d/aws-vpn.secrets
    customer_gateway_public_ip tunnel1_ip_address: PSK "shared secret"
    
    18.234.224.227 3.6.246.1: PSK "YGgD2mPOcqjZlEF5DhWDEtlBqvzOkixq" (eg)

    4. Commands to enable/start ipsec service
               $ chkconfig ipsec on
               $ service ipsec start
               $ service ipsec status
               
 
 --------------- Testing -------------
 
 1) Check Site-to-Site VPN Connections Tunnel must be **UP**.
 2) Now, create a private machine in VPC1, and create Public machine in VPC2, Now VPC2 machine should ping to VPC1 private machine
    - add **ALL ICMP** protocol in SECURITY GROUP for both VPC's machine (for ping).
