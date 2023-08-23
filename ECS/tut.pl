

Note:- in ECS, using fargate option, we launch directly containers without having Instances..

1)   What is ECS in AWS
    
      ECS is elastic Container Service, its like orchestration service that manages docker containers like kubernetes,
      it is fully managed by AWS like monitoring, scheduling scale up/down of container etc ...
      
2)  What is ECS Task
    
    Every container launch in ECS by TASK, its like defining the container configuration 
        (ie. container name, image source, port mapping, CPU and Memory Sharing within containers etc..)
    Every Container store into a task    
    
    Tasks are launched using the fargate, and fargate is the compute engine in ECS which allows user to launch containers. 
    
    Task has 2 components
    
      i)  ECS Container Instance  :- part of EC2 instance which run ECS Container agent.
      ii) Container Agent         :- it is the responsible for the communication of AWS ECS and instance, Also provide running container status.
