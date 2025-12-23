# Module 2: Metro Availability Overview

## 2.1 Synchronous Replication Fundamentals
The defining characteristic of Metro Availability is its use of synchronous replication. 

* Zero RPO: Every write operation is committed to both the local and remote clusters before being acknowledged to the application.
* Replication Differences: Unlike Asynchronous replication or NearSync, Metro provides real-time data mirroring.
* Consistency Groups: These ensure that related VMs, such as a database and its app server, are protected together to maintain write-order fidelity across sites.

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

