# Nutanix Metro Availability on Cisco UCS
### Comprehensive Implementation & Operations Guide

[cite_start]This repository serves as a professional-grade technical resource for deploying **Nutanix Metro Availability** across **Cisco UCS** infrastructure[cite: 1, 50]. [cite_start]It is designed to guide Principal Engineers through zero-downtime architecture, synchronous replication flows, and multi-site resiliency[cite: 4, 15, 22].

## 🛠 Project Scope
* [cite_start]**Zero-RPO Synchronous Replication:** Fundamentals of continuous operations between two sites[cite: 15].
* [cite_start]**Cisco UCS Modes:** Comprehensive coverage for **IMM** (Intersight Managed Mode), **ISM** (Intersight Standalone Mode), and **UCSM** (Classic Fabric Interconnect Mode)[cite: 11, 12, 13].
* [cite_start]**Cross-Hypervisor Support:** Detailed workflows for both **Nutanix AHV** and **VMware ESXi**[cite: 17].



## 📚 Documentation Modules
Click a module below to begin the deep dive:

| Module | Title | Focus |
| :--- | :--- | :--- |
| **01** | [Introduction](./docs/modules/01-intro.md) | [cite_start]Active-Active benefits & AOS fundamentals[cite: 5, 7]. |
| **02** | [Metro Overview](./docs/modules/02-overview.md) | [cite_start]Sync vs. Async & Witness requirements[cite: 16, 19]. |
| **03** | [Architecture](./docs/modules/03-architecture.md) | [cite_start]I/O flow & Latency ($\le$5ms) requirements[cite: 22, 29]. |
| **04** | [Intersight ISM](./docs/modules/04-ism.md) | [cite_start]Standalone mode & CIMC preparation[cite: 31, 36]. |
| **05** | [AOS Installation](./docs/modules/05-installation.md) | [cite_start]IMM, ISM, and UCSM imaging workflows[cite: 51, 55, 61]. |
| **06** | [Network Design](./docs/modules/06-networking.md) | [cite_start]MTU, VLAN trunking, and vPC design[cite: 66, 67, 69]. |
| **07** | [Deployment](./docs/modules/07-deployment.md) | [cite_start]Cluster pairing & Protection Domains[cite: 80, 82]. |
| **08** | [Operations](./docs/modules/08-operations.md) | [cite_start]Failover testing & LCM upgrades[cite: 90, 91]. |



## ⚡ Technical Guardrails
* [cite_start]**Latency:** Synchronous replication requires a Round Trip Time (RTT) of **$\le$ 5ms**[cite: 29].
* [cite_start]**Witness:** Required at a 3rd site for quorum, split-brain protection, and site arbitration[cite: 19, 73].
* [cite_start]**MTU:** Optimized MTU settings are required for replication efficiency[cite: 67].
* [cite_start]**LACP:** Note that LACP should not be enabled until the imaging process is complete[cite: 68].

---
*Created for Rack2Cloud Architecture — Delivering Zero-Downtime Resiliency.*
