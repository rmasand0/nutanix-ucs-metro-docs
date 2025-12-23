# Nutanix Metro Availability on Cisco UCS
### Comprehensive Implementation & Operations Guide

This repository serves as a professional-grade technical resource for deploying **Nutanix Metro Availability** across **Cisco UCS** infrastructure. [cite_start]It is designed to guide Principal Engineers through zero-downtime architecture, synchronous replication flows, and multi-site resiliency. [cite: 1, 3, 4]

## 🛠 Project Scope
* [cite_start]**Zero-RPO synchronous replication** for continuous operations. [cite: 15]
* [cite_start]**Cisco UCS Modes:** Comprehensive coverage for IMM, ISM, and UCSM. [cite: 13, 31, 51]
* [cite_start]**Cross-Hypervisor Support:** Detailed workflows for both Nutanix AHV and VMware ESXi. [cite: 87, 94]

## 📚 Documentation Modules
Click a module below to begin the deep dive:

| Module | Title | Focus |
| :--- | :--- | :--- |
| **01** | [Introduction](./docs/modules/01-intro.md) | Active-Active benefits & AOS fundamentals. |
| **02** | [Metro Overview](./docs/modules/02-overview.md) | Sync vs. Async & Witness requirements. |
| **03** | [Architecture](./docs/modules/03-architecture.md) | I/O flow & Latency (≤5ms) requirements. |
| **04** | [Intersight ISM](./docs/modules/04-ism.md) | Standalone mode & CIMC preparation. |
| **05** | [AOS Installation](./docs/modules/05-installation.md) | IMM, ISM, and UCSM imaging workflows. |
| **06** | [Network Design](./docs/modules/06-networking.md) | MTU, VLAN trunking, and vPC design. |
| **07** | [Deployment](./docs/modules/07-deployment.md) | Cluster pairing & Protection Domains. |
| **08** | [Operations](./docs/modules/08-operations.md) | Failover testing & LCM upgrades. |

---
*Created by [Your Name/Company] - Delivering Zero-Downtime Resiliency.*
