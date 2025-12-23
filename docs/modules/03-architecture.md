# Module 3: Metro Architecture Deep Dive

## 3.1 I/O Replication Flow
[cite_start]This section analyzes the path of a data packet in a Metro environment to ensure zero data loss[cite: 22].
1. [cite_start]**Request**: The Guest VM issues a write request to the local Controller VM (CVM)[cite: 22].
2. [cite_start]**Replication**: The local CVM sends a copy of the write to the CVM on the remote cluster[cite: 22].
3. [cite_start]**Commitment**: Both the local and remote CVMs write the data to their respective persistent storage logs[cite: 22, 23].
4. [cite_start]**Acknowledgment**: Once both sites have committed the data, the local CVM sends a final acknowledgment back to the Guest VM[cite: 22].

## 3.2 Failure Domain Analysis
[cite_start]Designing for resiliency requires understanding how the cluster responds to different failure types[cite: 24]:
* [cite_start]**Host Failure**: If a physical Cisco UCS node fails, VMs are restarted on remaining local hosts via hypervisor High Availability (HA)[cite: 25].
* [cite_start]**Block Failure**: Failure of an entire physical block is mitigated by Nutanix data redundancy (RF2/RF3)[cite: 26].
* [cite_start]**Cluster/Site Failure**: If an entire site goes offline, the Witness promotes the surviving site to "Active" status, allowing services to resume[cite: 27, 28].

## 3.3 Network and Latency Prerequisites
Architecture stability is highly dependent on network performance:
* [cite_start]**Latency Bound**: The Round Trip Time (RTT) between sites must remain **≤ 5ms**[cite: 29].
* [cite_start]**Bandwidth Sizing**: Bandwidth must be sized to handle peak write throughput plus replication overhead[cite: 30].
* [cite_start]**Burst Handling**: The network must be capable of handling sudden bursts in traffic without dropping replication packets[cite: 30].
