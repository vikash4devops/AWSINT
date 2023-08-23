
1)      What are the Five AWS S3 CLI Commands

            i)  aws s3 mb
            b)  aws s3 rm
            c)  aws se ls
            d)  aws s3 cp
            e)  aws s3 mv


2)      How do you protect "data at rest" in S3 ?

            i) Server-side protection

                a)  we can encrypt our data in S3
                    (AWS managed keys) AWS server-side encryption or we can use our own keys (customer managed keys).

            ii) Client-side protection

                b)  we can encrypt data at local using AWS SDK or with java functions before putting to S3.


3)      When do you use ALB vs ELB vs NLB ?

              i)   ALB     :- works on 7th Layer, it used when we need PATH BASED ROUTING, this increase the availability of applications (i.e fast application), it supports protocols - HTTP/HTTPS

              ii)  NLB     :- works on 4th Layer, this LB used when there are multiple request in single time and response quick, mainly used in VIDEO STREAMING APPLICATIONS, it supports - TCP/UDP/TLS

              iii) CLB     :- works on 4th & 7th Layer both, it does not support TARGET GROUP, it supports protocols - HTTP/HTTPS/TCP/SSL, and - IPV4, IPV6 & DUAL

              * Layer 4 is much faster than Layer 7



4)      EBS vs EFS vs S3 Storage ?

              i)    EBS :- its a BLOCK STORAGE, it is really fast, it providers Drive Storage for EC2 Instances, RDS also use EBS for its Storage,
                           EBS has low letency, since it has high IOPS (input output operation per/sec),
                           it has fixed volume capacity, also we need to create filesystem for its volumes.
              i)    EFS :- it has inbuild filesystem intelligence, can be utilized for SHARED VOLUMES, it can shared its data with multiple instances.
              i)    S3  :- its an OBJECT STORAGE, it support multiple data types, we can put lot of blobs, media files and any big data in S3 for a longer time backup.



5)      Types of EC2 Instances ?

              There are multiple types instances for different types of requirements for an application.

              i)    Type R  :- Memory optimized instances,  if our applications need more memory intensive than CPU, then we can use this memory based instance.

              ii)   Type C  :- Compute optimized instances, used for CPU intensive applications, for multi threaded applications, like big data and the stuffs.

              iii)  Type M  :- Medium instances instances, it balance both MEMORY & CPU intensive applications, most Commonly used instance type.

              iv)   Type I  :- Storage optimized instances, used for workloads that required high Sequential read & writes, eg. DATAWAREHOUSES  applications.

              v)    Type G  :- GPU instances, this types of instances used for MACHINE LEARNING, DEEP LEARNING,  used for GAMING SERVERS.

              vi)   Type T  :- Burstable instances, CPU credits can be used handle certain workloads, ideally used for GENERAL PURPOSE applications,
                               CPU credits are accumulated when instance is ideal.



6)      How to Monitor or Identify HTTP Errors responses in EC2 Instances & LB ?

              i)    for EC2 Instances:
                      we can create LOG GROUPS for web application LOG & create a metrics filter for HTTP ERRORS on top of the log.
                        eg. if we have to indentify specifically 404 Errors we can create metrics filter and find that.

              ii)   for LB :
                      HTTP Errors can be viewed under metrics tab, once error is viewed, we can debug about the error.



7)      Aurora VS standard RDS

              i)    Aurora
                    a)  it scales its Storage automatically, it grows in increments,
                    b)  its performance is much faster than standard RDS, it cost high than standard RDS, it has more read replicas than standard RDS.

              ii)   standard RDS has fixed Storage.



8)      Launch Template VS Launch Configuration

            i)    Differences b/w Launch Template & Launch Configuration
                  a)    Launch Template takes more input informations than Launch Configuration, it can maintain multiple versions (versions can be rollback as well).
                  b)    Launch Template provides Spot Instance & on-demand instance options, while Launch Configuration doesn't have these options.
                  c)    Launch Template supports choosing multiple instance type in same ASG.
                  d)    Launch Template supports all the latest features and improvements

                * Launch Template --> this is a set of predefined hardware & configure settings ie. SG, USER DATA, KEY PAIR, STORAGE,
                                      we just need to create Launch Template once and can create instances with this, without choosing all the settings again and again while creating instances.



9)      Reserved Instance VS Sport Instance

          i)    Reserved Instance
                a)    it is best for long term uses (1 yr to 3 yrs) of same instance, AWS gives significat discount on these types of instances.
                c)    all time running purpose, not for schedule purpose, like for all day/week/month (24*7).
                b)    you can re-sell on AWS if you choose not to use.

          ii)   Spot Instance
                a)    AWS provides Spot Instance from its unsed capacity, means, in a specific AZ AWS has lot of capacity deployed and those capacity are not used by tenency,
                      so it has unsed capacity, so, AWS sells those unsed capacity for cheaper cost,

                      CONS:-

                      but it has some downfall, like its price is dynamic means it goes UP & DOWN over the time, if we purchase SPOT INSTANCE at x price and price goes higher than x,
                      then, AWS gives interruption or warning notice for 2 minutes to stop the instance (whether we can stop or terminate it within 2 mins, else AWS will terminate it)

                      PROS:-

                      there are lots of benefits of SPOT INSTANCES like, if we have AUTO SCALING
                      then we can divide capacity like if can choose 60% for on-demand instances and rest for SPOT INSTANCES.



10)     For Spot Instance, if interruption occurs (due to price goes higher), we want to stop rather than termination, how?

        i)      while Launch Instance, there is an option of "Persistent Request" check that option and it will ask "Interruption behavior" set to "stop"
                now, when we get interruption, the instance will stop rather than termination, (we can take backups and create new instance with those backups)

        * Note ==>  Spot Instance option comes in (Configure Instance tab) while launching instance  (normal on-demand instance)



11)     What kind of instance we should choose for scheduled job which run 3-4 hrs/day?

        i)      if this kind of schedule is for long term like 1yr, then we should use "Scheduled Instances" type,
                but this type of instance is not available for every region, it is available for some particular regions like North Virginia.



12)     What is Instance Store?

        i)      it is a Volume store of an instance, but is not Persistent as EBS Volume, but it is much cheaper than EBS Volume.
        ii)     if instance get stopped or terminated then its stored data will be lost.
        ii)     we can use it to store some caches, so that if caches get deleted it can be retain from db.


        * Note ==>  Not all AMIs (instances) supports instance store, to check, go to "Launch Instance" ->  Community Amis  ->  Root device type


13)     Public Subnet VS Private Subnet

        i)      Public Subnet
                a)  this subnet creates using internet Gateway, it has inbound & outbound internet connections.
                b)  we keeps our web applications, APIs under this public subnet where it can be publicly accessable.

        ii)     Private Subnet
                a)  this subnet creates using NAT Gateway or Instance Gateway, it has only outbound internet connections.
                b)  we keep our Private servers under this subnet, like database servers or any application which need to accessable privately.



14)     How to Monitor Instance Memory Utilizations

        i)    using cloudwatch we can montitor this thing, but by default cloudwatch doesn't montitor it.
        ii)   need to add CLOUDWATCH AGENT & need to Configuration metrics for memory utilization or any particular service.


15)     How to resize an EC2 Instance?

        i)    select an instance -> select action -> instance setting -> change instance type -> choose any type (t2.micro, t3.large)
        
        
        
16)		rc.lock

17)		lamda scheduler - start/stop

18)		pre warm load balancer

19)		communicate 2 instance within same vpv - (security group) 

20)		rds proxy

21)		make a policy of full rds, will attached resource able to create or access dbs (mysq,postgres)

22)		aws trail :- logs about resource created/destroy history         
        
23)                     SG vs ACL

24)     What is S3 Cors and how it works?

25)     How to access ec2 without exposing it to the internet?

26)     What is Cold Start in AWS

            A “cold start” is the 1st request that a new Lambda worker handles. 
            This request takes longer to process because the Lambda service needs to find a space in its EC2.
