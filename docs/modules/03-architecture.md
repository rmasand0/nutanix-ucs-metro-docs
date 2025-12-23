# Module 3: Metro Architecture Deep Dive

Understanding the underlying communication patterns and data flow is essential for maintaining a resilient multi-site cluster.

## 1. Synchronous I/O Replication Flow
Metro Availability utilizes a "Strict Sync" write acknowledgment to ensure data parity across sites.

* **The Write Process**: When a VM issues a write, it is written to the local Controller VM (CVM) OpLog and simultaneously replicated to the remote site CVM OpLog.
* **Acknowledgment**: The VM only receives a write acknowledgment once the data is persistent on both the active and standby clusters.
* **Read Behavior**: Under normal conditions, reads are served locally from the active site to ensure the lowest possible latency.

[Image of Nutanix Metro Availability synchronous write I/O path]

## 2. Failure Domains and Resiliency
The architecture is categorized into distinct failure domains to automate responses to various outage scenarios:

| Failure Type | Description | Response Mechanism |
| :--- | :--- | :--- |
| **Host Failure** | Individual UCS Blade failure. | Hypervisor HA restarts VMs on remaining local nodes. |
| **Block Failure** | Loss of an entire physical chassis. | Data redundancy (RF2/RF3) ensures continued availability. |
| **Cluster/Site Failure** | Total loss of a site or management domain. | The Witness VM promotes the secondary cluster to "Active" status. |

## 3. Latency & Bandwidth Guardrails
The inter-site network is the most critical factor for storage performance.
* **Latency Requirement**: Round Trip Time (RTT) must be **$\le$ 5ms**. Spikes above this threshold will directly increase application write latency.
* **Bandwidth Sizing**: Bandwidth must accommodate peak write throughput plus replication overhead and burst handling.
