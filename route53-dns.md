

1)  How domain name works on internet 

        - if someone hits domain name on internet, a "DNS Resolver" gets that IP address of that domain name,
        - Now, internet redirect the user request that IP address where this IP is hosted.
    
        EG. --- domain name = www.facebook.com
    
        How DNS Resolver gets the IP address of a domain.
        
            - if user hits the domain name to internet, internet connects the DNS Resolver to get the IP,
            - if DNS Resolver does not have the IP address of that domain, it calls to "Root Name Server"
            - Root Name Server always check a domain from last to first ie. - (i) .com (ii) facebook (iii) www. or any prefix (support. or info.)
            - 1st NS gives the details about TLD (top level domain) for .com /.in /.org /.net
            - 2nd NS gives the details about domain name details eg. (facebook.com)
            - 3rd NS is the main NS which called "AUTHORITATIVE NS" and it gives actual IP address of domain.
            - This three NS hierarchy called "RECURSIVE NS".
            
            See below diagram.
  
<img width="1235" alt="image" src="https://user-images.githubusercontent.com/29144557/186133658-88982a29-d3eb-454c-825f-15fe89bde09d.png">



2)  What is HOSTED ZONE and why we create it in Route-53
        
        - all details related to our domain lies here in Hosted Zone.
        - we need to create Hosted zone as same as our domain name.
        - When we create Hosted zone it creates 4 Name Servers and 1 SOA (service of authority) automatically.
       


3)  What is NS and SOA in Hosted Zone?

        - NS (name server) is something which translate domain name into IP address and says where to redirect the domain request.
        - SOA (service of Authority) is kind of metadata of a DNS and domain, it stores data ie. admin email, when domain was updated.
        - These 2 records gets created automatically as soon as Hosted zone created.


4)  Route-53 can have maximum of 500 Hosted Zones (could be increased after requesting to AWS).



5)  How to redirect GoDaddy domain request to AWS?

        - First Create a Hosted Zone (name should be same as domain name) in AWS, and grab the 4 NS which gets created automatically in hosted zone.
        - Add these 4 NS to GoDaddy.
        - Now, every request comes to GoDaddy will be redirected to AWS server (as we have added AWS NS).
        - This Process called DNS delegation.
    
        Note:- Sometimes in GoDaddy or in other domain registrar there might not be any option to add NS server, in this case
               we need to add our domain IP address, below are the steps to get the domain IP address (by command)

                nslookup (hit this command) -> enter domain name -> it will give the domain IP address



6)  What is "A Record" & "AAAA Record" types?

      ------------------------------------------------------------------------------------------------------------------------------------------  
      - When choosing "A record" in record with non-alias option, then we need to pass our ec2 machine or ecs Public IP address as server.
      - If we enable Alias option in "A record" type, then we need to select server endpoint as load balancers, S3 Bucket etc.
      ------------------------------------------------------------------------------------------------------------------------------------------
        - A record (IP address) maps the domain with IP address in IP Version4 (IPv4) - IPv4 is 32 bit.
        - Whenever we want to add bind the domain to a particular IP we add it as in A record.
        - AAAA is also same and use to map the domain with IP address, but AAAA use for IP Version6 (IPv6) - IPv6 is 128 bit (32*4).
        - A is 4 tims in AAAA which means 32*4 = 128, thats why it use as AAAA record for IPv6.



7)  What is CName Record?

        - this is a canonical name records in DNS, which means it is an alternative of a domain (prefix for a domain).
        - if there is another subdomain or any prefix of same domain we want to map with main domain then we add these records as Cname records.
        - Eg. suppose, we have domain called "abc.com", we want if any user hit the request to "www.abc.com", it should be redirected to "abc.com".
        - in the abover eg we use Cname, also if there is any subdomain, we want to map with main domain, then we need to create Cname records.
        - Cname record must be unique records, can't be added 2 records as same.



8)  What is Alias Record?
        
        - Alias is something that points your domain name to a hostname instead of an IP address (if we enable it)
        - We need to provide server endpoint like load balancer dns name (select option from dropdown), S3 Bucket endpoint etc.
        - Multiple Alias records can be created with same name in a hosted zone.



9)  Types of Route-53 Policies.
     
        Route-53 has 7 types of Policies

        - Simple Routing (Default) :- any user can visit to website from anywhere, there is no extra/advance config. for this routing.
        - Failure Routing :- in this case, we need to have atleast 2 servers, 1 for active, another for passive, 1 fails other can handle the traffic.
        - GeoLocation Routing :- this routing works on user geo location based, when user visit to the website, ISP (internet service provide) will check which server is the nearest for this user and will redirect the local area server, so that website content will be related to that user location (server must be available to those nearest zones)
        - Multi Value Answer Routing
        - Latency Based Routing
        - Weigheted Routing
        - Geo-Proximity
