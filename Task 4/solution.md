The architecture suggested would be as below:

Global Load Balancer: Use either Amazon Route 53 or AWS Global Accelerator to distribute incoming traffic across multiple regions for high availability and global redundancy.

Content Delivery: Utilize Amazon CloudFront for content delivery to cache and serve static assets globally, reducing latency.

Web Server Clusters: Deploy multiple clusters of web servers behind the global load balancer to handle user requests. These clusters are designed for horizontal scalability and can automatically scale up or down based on traffic.

Application Server Clusters: Behind each web server cluster, deploy clusters of application servers to handle the business logic of the application. These clusters are also horizontally scalable.

Database: Use database clusters (e.g., Amazon RDS Multi-AZ or Aurora) to ensure database availability and scalability. Implement read replicas to offload read traffic. Enable cross-region replication as well.

Data Synchronization:
Ensure that data synchronization is ongoing between the primary and secondary regions. This may involve real-time replication for databases and periodic synchronization for other data sources.

Caching Layer: Implement a caching layer using Amazon ElastiCache (Redis or Memcached) to improve response times and reduce the load on the database.

Auto Scaling: Implement Auto Scaling groups for web and application server clusters to automatically adjust the number of instances based on demand.

This proposed architecture will help in task 5 as well as it is based on a HA/DR model. Depending on our budget we can do an Active/Active or Active/Passive model for uptime.