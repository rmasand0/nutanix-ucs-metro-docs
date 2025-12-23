# Module 8: Operations & Maintenance

This module covers the lifecycle management of a Nutanix Metro environment on Cisco UCS, including non-disruptive testing, planned migrations, and hardware maintenance procedures.

---

## 8.1 Planned Failover vs. Disaster Recovery
It is critical to understand the difference between a **Planned Failover** (Maintenance) and an **Unplanned Failover** (Disaster).

* **Planned Failover (Promotion)**: Used for site maintenance. 
    1.  VMs are gracefully shut down or vMotioned to the standby site.
    2.  The Standby site is "Promoted" to Active.
    3.  The original Active site becomes the Standby.
* **Unplanned Failover**: Occurs during a power or link loss. 
    1.  The Witness VM detects the loss of the Primary site.
    2.  The Witness confirms Site B is healthy.
    3.  The Witness locks the metadata and promotes Site B automatically.



---

## 8.2 Maintenance Mode Procedures
When performing maintenance on Cisco UCS hardware (e.g., Fabric Interconnect firmware updates or Blade replacement), follow these steps to avoid a Metro "Panic":

1. **Pause Synchronization**: If maintenance involves the Inter-Site Link (ISL) or upstream Nexus switches, manually "Pause" the Protection Domain to prevent the cluster from attempting to sync over a flapping link.
2. **Host Maintenance Mode**: Place the target Cisco UCS node in Maintenance Mode within Prism and the Hypervisor (AHV/ESXi).
3. **Cisco UCS Firmware**: Utilize Intersight/UCSM to update firmware. Ensure only one Fabric Interconnect is updated at a time to maintain path redundancy to the CVMs.
4. **Resume & Resume**: Once hardware is back online, "Resume" the Protection Domain and verify the "Double-ACK" process returns to a healthy status.

---

## 8.3 Lifecycle Management (LCM)
Nutanix LCM automates software and firmware updates, but in a Cisco UCS environment, there are specific integration points:

* **Foundation Software**: Keep the Foundation version updated to support the latest Cisco VIC drivers.
* **AOS/AHV Updates**: LCM will handle the rolling upgrade of the CVMs. During a Metro upgrade, it is best practice to upgrade the **Standby** site first, followed by the **Active** site.
* **Witness Upgrade**: The Witness VM should always be upgraded to match or exceed the version of AOS running on the main clusters.



---

## 8.4 Troubleshooting Metro Issues
When the "Metro Status" is not Green, use these CLI-based troubleshooting steps:

| Symptom | Potential Cause | Action |
| :--- | :--- | :--- |
| **Status: Interrupted** | ISL Latency > 5ms | Check Nexus interface counters for drops/errors. |
| **Status: Paused** | Manual intervention or ISL Down | Check `ping -s 8972` to verify Jumbo Frame path. |
| **Witness Offline** | Site C Connectivity | Verify Port 9440 is open from Site A/B to the Witness IP. |

**Command Line Deep Dive:**
Check the detailed replication stats between the UCS domains:
```bash
ncli pd list-repl-stats name=METRO_PD_NAME
```
