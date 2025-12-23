# Module 8: Operations and Failover Testing

Establishing a Metro Availability relationship is only the first step. Ongoing operations require rigorous testing and specific procedures for maintenance and recovery to ensure the zero-RPO promise is maintained.

## 8.1 Failover and Recovery Workflows
Understanding the difference between a planned event and an unplanned disaster is critical for operational success.

* **Planned Failover**: This is a controlled migration used for site maintenance or disaster recovery drills.
* **Unplanned Failover**: This occurs during a site or Inter-Site Link (ISL) failure where the Witness VM automates the promotion of the standby site.
* **Manual Intervention**: If the Witness is unavailable during an outage, an administrator must manually promote the standby container to active status.



## 8.2 Lifecycle Management (LCM)
Upgrading a Metro environment requires a specific sequence to avoid interrupting the synchronous replication stream.

* **One Site at a Time**: Always perform AOS or Hypervisor upgrades on one cluster fully before starting the second cluster.
* **Witness Upgrades**: The Witness VM should be upgraded to a version compatible with both site clusters to ensure continued arbitration support.
* **Pre-Upgrade Checks**: Run Nutanix Cluster Check (NCC) on both sites to verify the health of the synchronous replication before initiating any updates.

## 8.3 Operational Best Practices
* **Replication Health Monitoring**: Regularly monitor the "Replication Status" in Prism; any status other than "Enabled" indicates a risk to the zero-RPO configuration.
* **Snapshot Schedules**: While Metro provides real-time protection, local snapshots should still be utilized for point-in-time recovery against logical data corruption.
* **Alert Integration**: Configure SMTP or SNMP alerts to notify the operations team immediately if the Inter-Site Link (ISL) latency exceeds the 5ms threshold.

## 8.4 VMware ESXi Specific Operations
For environments running VMware, specific cluster settings must be maintained.
* **HA and DRS Rules**: Use "Should" affinity rules to keep VMs on the same site as their active storage container to prevent "tromboning" of I/O across the ISL.
* **Datastore Heartbeating**: Ensure that VMware HA datastore heartbeating is configured to recognize the stretched storage container properly.
