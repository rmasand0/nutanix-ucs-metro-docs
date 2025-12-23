# Module 2: Metro Availability Overview

## 2.1 Synchronous Replication Fundamentals
The defining characteristic of Metro Availability is its use of synchronous replication. 

* **Zero RPO**: Every write operation is committed to both the local and remote clusters before being acknowledged to the application.
* **Replication Differences**: Unlike Asynchronous replication or NearSync, Metro provides real-time data mirroring.
* **Consistency Groups**: These ensure that related VMs, such as a database and its app server, are protected together to maintain write-order fidelity across sites.

## 2.2 The Role of the Witness
The Witness VM is a critical third-party component required for automated site failover and split-brain protection.

### Witness Arbitration Logic
The following diagram represents the decision-making process the cluster follows during a primary site outage:

```mermaid
graph TD
    A[Site A Outage Detected] --> B{Witness Reachable?}
    B -- Yes --> C[Witness Locks Site B]
    C --> D[Site B Promoted to Active]
    B -- No --> E[Site B Remains Standby]
    E --> F[Manual Intervention Required]

    style A fill:#2c3e50,stroke:#1a252f,color:#fff
    style B fill:#34495e,stroke:#2c3e50,color:#fff
    style C fill:#2c3e50,stroke:#1a252f,color:#fff
    style D fill:#27ae60,stroke:#1e8449,color:#fff
    style E fill:#2980b9,stroke:#2471a3,color:#fff
    style F fill:#c0392b,stroke:#922b21,color:#fff
```
### Understanding the Diagram
* **Quorum Lock**: When Site A fails, Site B attempts to acquire a lock on the Witness to prove it is the surviving site.
* **Promotion**: Once the lock is acquired, the standby container on Site B is promoted to Active, allowing VMs to restart.
* **Manual Intervention**: If the Witness is unreachable, Site B stays in standby to prevent a Split-Brain scenario.

## 2.3 Hypervisor and Software Support
Nutanix Metro Availability is designed to work across the industry's leading hypervisors with specific integration points for each.

* **Nutanix AHV**: Features native support for automated failover and simplified management directly through the Prism interface.
* **VMware ESXi**: Integrates with vCenter for datastore presentation and requires specific HA/DRS rules (Should/Must rules) to ensure operational stability and prevent I/O tromboning.
