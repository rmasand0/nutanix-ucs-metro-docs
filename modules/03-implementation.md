Module 3: Metro Implementation (L300)
With the Cisco UCS hardware optimized and the network stretched, we now configure the Nutanix software-defined storage layer to enable synchronous replication.

1. Witness Deployment & Registration
Before enabling Metro on a storage container, the Witness VM must be active and reachable by both clusters.

Deployment Placement
The Rule: Deploy the Witness OVF in a third site (e.g., a small standalone ESXi/AHV host or a cloud instance).

Network: Ensure port 9440 is open between both Cluster CVMs and the Witness VM.

Registration via CLI
While this can be done in Prism, engineers should verify via ncli to ensure quorum is healthy:

Bash

# Run on both Cluster A and Cluster B
ncli witness register-witness address=<Witness_IP> user=admin password=<Password>
2. Storage Container Mapping
Metro Availability operates by "linking" two containers with identical names across different clusters.

Steps to Configure:
Identity: Create a container named Metro_Prod_01 on Site A.

Mirror: Create a container named Metro_Prod_01 on Site B.

Enable Metro:

In Prism, navigate to Storage -> Table.

Select the container and click Configure Metro Availability.

Select the Remote Site (Site B).

Set the failure policy to Automatic Bend (requires Witness).

3. Hypervisor Specifics (Affinity Rules)
This is where most Metro deployments fail during a disaster. You must ensure VMs stay on the "Active" site during normal operations to avoid "Hairpinning" traffic across the WAN.

VMware ESXi: Host/VM Affinity
Rule Type: Use "Should run on hosts in this group" (Soft Affinity).

The Logic: If Site A fails, a "Should" rule allows VMware HA to restart the VM on Site B. A "Must" rule (Hard Affinity) will prevent the VM from ever powering on at the secondary site, causing a permanent outage during a disaster.

AHV: Affinity Policies
Use vPrefer or VM-Host affinity in Prism Central to pin VMs to the local UCS chassis.

4. HA Admission Control
Because Site B must be ready to take over the entire workload of Site A, Admission Control is non-negotiable.

Cisco UCS Capacity: Ensure you are not running your UCS blades at more than 50% utilization for RAM and CPU.

Calculation: If Site A has 10 nodes and Site B has 10 nodes, your total "usable" capacity for the Metro cluster is only 10 nodes worth of resources.

Rack2Cloud Tip: If you over-provision Site A, a failover to Site B will trigger a "Resource Contention Storm," where the UCS FIs will struggle with massive I/O wait times as the hypervisor swaps RAM to disk.

5. Verification of Synchronous State
After configuration, verify the replication status. The initial sync will depend on your data size and the 10/25GbE bandwidth you allocated in Module 2.

Bash

# Check the protection domain status
ncli pd ls name=<PD_Name>
Look for Status: Synchronous. If it says Resyncing, do not attempt a failover test yet.
