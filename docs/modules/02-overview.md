# Module 2: Metro Availability Overview

## 2.1 Synchronous Replication Fundamentals
[cite_start]The defining characteristic of Metro Availability is its use of synchronous replication[cite: 15]. 

* [cite_start]**Zero-RPO**: Every write operation is committed to both the local and remote clusters before being acknowledged to the application[cite: 15, 22].
* [cite_start]**Replication Differences**: Unlike Asynchronous replication (snapshots at intervals) or NearSync (minute-level RPO), Metro provides real-time data mirroring[cite: 16].
* [cite_start]**Consistency Groups**: Critical for multi-VM applications, Consistency Groups ensure that related VMs are protected together to maintain write-order fidelity[cite: 18, 80].

## 2.2 Hypervisor and Software Support
Metro Availability is supported across leading hypervisor platforms:
* [cite_start]**AHV**: Native Nutanix hypervisor support for automated failover and simple management[cite: 17, 88].
* [cite_start]**ESXi**: Full support for VMware environments, integrating with vCenter for datastore presentation and HA/DRS management[cite: 17, 94].

## 2.3 The Role of the Witness
[cite_start]The Witness VM is a critical third-party component required for automated site failover and split-brain protection[cite: 19].
* [cite_start]**Quorum Maintenance**: The Witness acts as a tie-breaker if communication between the two primary sites is lost[cite: 19, 73].
* [cite_start]**Site Arbitration**: It automatically determines which site should remain active to avoid data corruption[cite: 19, 73].
* [cite_start]**Deployment Requirement**: The Witness must be hosted in a separate failure domain from the two protected sites[cite: 72, 74].

```mermaid
graph TD
    A[Site A Outage Detected] --> B{Witness Reachable?}
    B -- Yes --> C[Witness Locks Site B]
    C --> D[Site B Promoted to Active]
    B -- No --> E[Site B Remains Standby]
    E --> F[Manual Intervention Required]
