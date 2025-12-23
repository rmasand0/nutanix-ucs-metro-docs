Module 1: The Foundations (L100)
Overview
Nutanix Metro Availability provides a Zero RPO (Recovery Point Objective) and a near-zero RTO (Recovery Time Objective) by synchronously replicating data between two sites over a stretched Layer 2 network. This ensures that in the event of a site failure, your applications can resume almost instantaneously without data loss.

Metro vs. Traditional Replication
Unlike Asynchronous or NearSync replication, Metro Availability requires a "Strict Sync" write acknowledgment. A write is not acknowledged to the VM until it is committed to both the local OpLog and the remote OpLog on the secondary cluster.

Feature,Async Replication,NearSync,Metro Availability
RPO,60 mins+,1 min - 15 mins,Zero (Synchronous)
RTO,Minutes to Hours,Minutes,Seconds (Automatic)
Max Latency,High / Tolerant,High / Tolerant,≤ 5ms RTT
Data Consistency,Snapshot-based,Snapshot-based,Live Stretched Storage

Critical PrerequisitesFor a successful Cisco UCS and Nutanix Metro deployment, the physical network must meet the following "hard" requirements. Failure to meet these thresholds will result in "I/O pinning" or significant application latency.Network Latency: Round Trip Time (RTT) must be $ \le 5ms $. For every $1ms$ of latency added, you will see a direct increase in write wait times for your applications.Bandwidth: Minimum 10Gbps dedicated (or QoS prioritized) replication link. The bandwidth must be capable of handling the peak write throughput of the primary site.MTU Settings: Jumbo Frames (9000 MTU) are highly recommended. End-to-end consistency is required across Cisco Fabric Interconnects, upstream switches, and WAN providers.L2 Connectivity: Requires a stretched Layer 2 network for VM networking so that IP addresses do not change during a site failover (vMotion/HA).Engineer's Note: If your inter-site link (ISL) fluctuates above 5ms, Nutanix Metro will enter "Read-Only" or "Paused" states to protect the integrity of the data. Always over-provision the ISL.The Role of the Witness VMThe Nutanix Witness is a lightweight appliance deployed at a third physical site. It acts as a quorum arbitrator to prevent "split-brain" scenarios where both sites think they should be the "Active" master.How Quorum WorksHeartbeating: The Witness monitors the storage availability of both Site A and Site B clusters.Automatic Promote: If Site A fails, the Witness allows Site B to automatically promote the standby container to "Active," resuming I/O without manual intervention.Failure Domains: The Witness must reside in a separate failure domain (separate Power/Cooling/Network) from both participating clusters.

Failure Logic Logic Table
Scenario,Site A Status,Site B Status,Witness Status,Result
Normal,Up,Up,Up,Synchronous Replication
Site A Fail,Down,Up,Up,Site B Promotes to Active
ISL Cut,Up,Up,Up,"Winner of ""Race to Witness"" stays Active"
Witness Fail,Up,Up,Down,Metro stays Active (No Auto-Failover)
