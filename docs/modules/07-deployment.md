# Module 7: Metro Availability Deployment

Once the underlying Cisco UCS hardware is imaged and the independent Nutanix clusters are healthy, the Metro configuration can begin. This module covers the pairing of clusters, Witness arbitration, and the activation of the Synchronous Protection Domain.

---

## 7.1 Site-to-Site Cluster Pairing
Before synchronous replication can occur, the two clusters must be introduced to one another to establish a trust relationship.

* **Remote Site Configuration**: In Prism Element, navigate to **Settings > Remote Sites**. Add the remote cluster using the **Virtual IP (VIP)** and the external IP addresses of all remote Controller VMs (CVMs).
* **Network Mapping**: This is critical for "vMotion-like" mobility. You must map the source VLANs on the Site A Cisco Nexus switches to the destination VLANs on the Site B switches.
* **Port & MTU Verification**: 
    * Ensure **Port 9440** (Prism/CVM) and **Port 2009** (Staging/Storage) are open.
    * **Latency Check**: Use the `ping -s 8972` command (from Module 6) to ensure the 5ms RTT limit is maintained under the increased load of the initial metadata sync.



---

## 7.2 Witness VM Registration (The Quorum)
The Witness acts as the "Tie-Breaker" during a site failure. Without a Witness, a site failure requires manual intervention to resume I/O.

* **Witness Deployment**: The Witness VM must be deployed in a **Third Failure Domain** (Site C). Never host the Witness on either of the two clusters being protected.
* **Redundancy**: The Witness VM can monitor up to 50 Metro pairs. It does not store data; it only stores metadata and lock-state information.
* **Prism Integration**: Register the Witness on **both** clusters. 
    * **Failure Handling**: Choose **"Automatic"** to allow the Witness to promote the standby site automatically if the active site's Cisco UCS chassis loses power or connectivity.



---

## 7.3 Creating Protection Domains (Stretching the Container)
Unlike standard Async DR, Metro Availability is configured at the **Storage Container** level, which then protects all VMs residing within it.

* **Container Selection**: In the **Data Protection** menu, create a "Metro Availability" Protection Domain.
* **Synchronous Options**: 
    * **Self-Healing**: If the link fails, the "Active" site will continue to run.
    * **Resync Priority**: Determines how fast Site B catches up to Site A after a link restoration.
* **Active/Standby Assignment**: 
    * **Site A**: Active (Reads/Writes happen here).
    * **Site B**: Standby (Data is synchronously mirrored here; VMs can be registered but not powered on).



---

## 7.4 Failure Handling Logic
In a deep-dive, engineers must understand how the cluster reacts to network interruptions:

| Scenario | Behavior | Witness Action |
| :--- | :--- | :--- |
| **ISL Failure (Network)** | Primary site continues; Remote sync pauses. | Prevents both sites from becoming Active (No Split-Brain). |
| **Site A Total Failure** | Site B remains Standby until promoted. | **Automatic Promotion**: Site B becomes Active; VMs restart via HA. |
| **Witness Failure** | Metro continues; no impact to I/O. | Automatic failover is temporarily disabled until Witness is restored. |

---

## 7.5 Final Health Check & Verification
Once the "Sync" status reaches 100%, perform these validation steps:

1. **Check Status**: In Prism, verify the Protection Domain status is **"Enabled"** (Green).
2. **CLI Validation**: Run the following command on any CVM:
   ```bash
   ncli pd list-metro-avail-status
