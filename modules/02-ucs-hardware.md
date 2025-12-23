
Module 2: Cisco UCS Hardware Alignment (Deep Dive)
Integrating Nutanix with Cisco UCS requires moving beyond the default "Global" policies. To ensure Metro stability, we must optimize the Fabric Interconnect (FI) and the Virtual Interface Card (VIC).

Fabric Interconnect (FI) Configuration
In a Nutanix environment, most traffic is East-West (CVM to CVM). On UCS, this traffic hits the FI.

End-Host Mode: Ensure FIs are in End-Host Mode to prevent loops and rely on the upstream core for L3.

Server Ports: Map Nutanix nodes to dedicated 10/25GbE ports. For M6/M7 nodes, 25GbE/100GbE is the standard to handle the overhead of synchronous replication.

vNIC Policies and Multi-Homing
Design your vNICs to separate management, storage, and vMotion traffic. For Metro Availability, a dedicated vNIC for Replication traffic is recommended if using multiple physical uplinks.

# Example: Identifying UCS VIC interfaces for Nutanix CVM mapping
Get-UcsCentralVnic | Where-Object {$_.Name -match "Storage"} | Select Name, Dn, Mtu

UCS Service Profile: Performance Tuning
Nutanix AHV and ESXi perform best when the UCS BIOS allows the hypervisor to control power states. Apply the following in your UCS BIOS Policy:

C-States: Disable. (Prevents core sleep/latency spikes).

Intel SpeedStep/Turbo Boost: Enable for maximum single-threaded performance for CVM metadata operations.

Hardware Prefetcher: Enable.

Power Management: Set to "Performance."

Connectivity: L2 Stretched VLANs
To support Metro, you must stretch the following VLANs across the FIs at both sites:

Management VLAN: For vCenter/Prism Central and Host management.

Storage Replication VLAN: The CVM-to-CVM communication path.

VM Network VLANs: To ensure no IP changes upon failover.

Traffic Type,MTU,UCS QoS Class,Priority
Management,1500,Best Effort,Low
vMotion,9000,Silver,Medium
Storage/Metro,9000,Platinum,Highest (No Drop)

Rack2Cloud Tip: Ensure your Nutanix CVMs are pinned to the same Fabric Interconnect as their primary data path to minimize "FI hopping" latency. Use UCS Connectivity Policies to enforce this.
