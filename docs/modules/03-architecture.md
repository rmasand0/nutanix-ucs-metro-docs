# Module 3: Metro Architecture Deep Dive

## 3.1 Synchronous I/O Replication Flow
The core of Metro Availability is the "Double-ACK" process. This ensures that data is never considered "written" until it exists in two physical locations.

1. **Guest VM Write**: The VM issues a write request to the local Controller VM (CVM).
2. **Synchronous Mirror**: The local CVM sends the write to the remote CVM across the Inter-Site Link (ISL).
3. **Double Commit**: Both the local and remote CVMs commit the data to their respective persistent write caches (OpLogs).
4. **Final Acknowledgment**: Only after both sites confirm the write is the Guest VM notified of a successful I/O operation.

## 3.2 Failure Domain Analysis
Understanding how the cluster behaves during different failure scenarios is critical for Day 2 operations.

| Failure Level | System Impact | Automated Action |
| :--- | :--- | :--- |
| **Host Failure** | Loss of a single Cisco UCS node. | Hypervisor HA restarts VMs on remaining local nodes. |
| **Block Failure** | Loss of an entire physical chassis. | Nutanix data redundancy (RF2/RF3) ensures data remains available locally. |
| **Site Failure** | Total site or management domain loss. | The Witness promotes the surviving site to "Active," and VMs restart there. |

## 3.3 Network and Latency Requirements
The performance of a Metro cluster is directly tied to the quality of the network path between sites.

* **Latency Bound**: The Round Trip Time (RTT) between sites must remain **≤ 5ms**. Every 1ms of network latency adds 1ms of delay to every application write.
* **Bandwidth Sizing**: You must size the Inter-Site Link (ISL) to handle peak write throughput plus approximately 20% overhead for metadata replication.
* **MTU Consistency**: A consistent MTU (typically 9000 for Jumbo Frames) must be configured end-to-end to prevent packet fragmentation.

## 3.4 Storage Container Relationship
Metro Availability is configured at the **Storage Container** level.

* **Active Container**: Receives reads and writes.
* **Standby Container**: Receives synchronous replication (Read-Only to the hypervisor).
* **Witness VM**: Acts as a tie-breaker, monitoring the health of the connection between Site A and Site B.

## 3.5 Logical Architecture Diagram
Below is the logical flow of the Nutanix CVMs communicating over the Cisco Nexus backbone:

---

## 3.6 Verification: Checking Metro Health
Once configured, you can verify the status via the Nutanix CLI (nCLI):

```bash
ncli pd list-metro-avail-status
```
---
