# Module 6: Metro-Ready Network & Site Design

[cite_start]A Metro-ready network requires specific configurations to handle the high-throughput, low-latency demands of synchronous replication[cite: 65].

## Core Configuration Requirements
* [cite_start]**Trunking**: Ensure all required VLANs are trunked correctly to the hosts[cite: 66].
* [cite_start]**Native VLAN**: Confirm native VLAN settings match on both ends of the trunk to prevent communication drops[cite: 66].
* [cite_start]**MTU**: Set MTU to 9000 (Jumbo Frames) across the entire path for maximum replication efficiency[cite: 67].
* [cite_start]**vPC Design**: Utilize Virtual Port Channels (vPC) for dual-switch redundancy to eliminate single points of failure[cite: 69].



## Inter-Site Architecture
[cite_start]The inter-site network must support both the Metro data traffic and the Witness communication[cite: 70].
* [cite_start]**Stretched Layer 2**: Required for VM networking to allow for seamless vMotion/HA without IP changes[cite: 1, 9].
* [cite_start]**Witness Connectivity**: Ensure Site A, Site B, and the Witness site all have reliable L3 connectivity[cite: 70, 74].

## Initial Setup Precautions
* [cite_start]**LACP**: Avoid enabling LACP on the host side until the initial Nutanix imaging is finished[cite: 68].
