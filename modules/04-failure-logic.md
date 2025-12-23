Module 4: The Failure Logic (Troubleshooting)
In a Metro Availability environment, the "Failure Logic" is the set of automated instructions the clusters follow when heartbeats are missed. Understanding this logic is critical for preventing Data Corruption and Split-Brain scenarios.

1. The Three Failure Scenarios
There are three primary ways a Metro cluster can break. Your Cisco UCS fabric must be configured to handle each.

Scenario A: Total Site Failure (Blackout)
Event: Site A loses all power or both Cisco Fabric Interconnects fail.

Logic: Site B and the Witness lose contact with Site A.

Result: The Witness grants Quorum to Site B. Site B promotes the storage container to Active. VMware/AHV HA restarts the VMs on the Site B UCS blades.

RPO: Zero. RTO: Minutes (time to reboot VMs).

Scenario B: Inter-Site Link (ISL) Failure (Network Partition)
Event: The fiber between Site A and Site B is cut, but both sites are still running and can see the Witness.

The Race: Both sites immediately attempt to "Lock" the Witness.

The Winner: The first site to grab the Witness lock stays Active.

The Loser: To prevent different data being written to Site A and Site B (Split-Brain), the losing site unmaps the storage container. The VMs on the losing site will crash or go into a Read-Only state to protect data integrity.

Scenario C: Witness Failure
Event: The 3rd site (where the Witness lives) goes offline.

Result: Metro Availability stays Active. Synchronous replication continues between Site A and Site B.

Risk: If a site failure occurs while the Witness is down, automatic failover will not happen. A manual "Promote" command will be required via CLI.

2. Monitoring the "Refactor Cliff"
The "Refactor Cliff" occurs when latency exceeds the 5ms RTT threshold.

When latency spikes:

I/O Pinning: The Primary CVM waits for the Secondary CVM to acknowledge the write.

Application Latency: If the ISL is congested (check your Cisco FI Uplink ports), the application sees "Disk Latency," even though the SSDs are fast.

Automatic Resync: If the link drops for a few seconds, Nutanix moves from "Sync" to "Resyncing." During this time, data is sent in chunks rather than live.

Engineer's Note: Use the ncli tool to check for "Replication Lag." If the lag is increasing, your Cisco UCS uplink bandwidth is likely saturated by non-storage traffic (e.g., a massive backup job).

3. CLI Troubleshooting Commands
If Prism is unresponsive during a site flap, use these commands on any CVM:

Check Metro Status:

Bash

ncli metro-avail-status list
Manually Promote a Container (Emergency Only): Use this only if the Witness is dead and you know Site A is gone.

Bash

ncli pd promote-pds-on-remote-site name=<Protection_Domain_Name>
Check Witness Connectivity:

Bash

# Verify the CVM can talk to the Witness on port 9440
allnodes "nc -v <Witness_IP> 9440"
4. Protecting Data Integrity
Nutanix uses a "Majority Rules" logic.

2 out of 3 components (Site A, Site B, Witness) must be in communication to maintain an automatic failover state.

If you lose 2 components (e.g., Site B fails AND the Witness fails), Site A will pause replication to ensure it doesn't deviate from the last known good state of the partner.
