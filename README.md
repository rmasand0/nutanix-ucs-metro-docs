# Nutanix Metro Availability on Cisco UCS
### Comprehensive Implementation & Operations Guide

This repository serves as a professional-grade technical resource for deploying **Nutanix Metro Availability** across **Cisco UCS** infrastructure. It is designed to guide Principal Engineers through zero-downtime architecture, synchronous replication flows, and multi-site resiliency.

## 🛠 Project Scope
* **Zero-RPO Synchronous Replication:** Fundamentals of continuous operations between two sites to ensure zero data loss.
* **Cisco UCS Modes:** Comprehensive coverage for **IMM** (Intersight Managed Mode), **ISM** (Intersight Standalone Mode), and **UCSM** (Classic Fabric Interconnect Mode).
* **Cross-Hypervisor Support:** Detailed workflows and best practices for both **Nutanix AHV** and **VMware ESXi** environments.

## 📚 Documentation Modules (2-Day Deep Dive)
Click a module below to begin the detailed technical training:

| Module | Title | Focus |
| :--- | :--- | :--- |
| **01** | [Introduction](./docs/modules/01-intro.md) | Active-Active data protection architecture, AOS fundamentals, and AHV/ESXi basics. |
| **02** | [Metro Overview](./docs/modules/02-overview.md) | Synchronous replication fundamentals, Consistency Groups, and Witness roles in quorum. |
| **03** | [Architecture](./docs/modules/03-architecture.md) | Synchronous I/O flow, metadata management, and failure domain analysis (Host/Block/Site). |
| **04** | [Intersight ISM](./docs/modules/04-ism.md) | Standalone mode requirements, CIMC/Host preparation, and API-based Foundation integration. |
| **05** | [AOS Installation](./docs/modules/05-installation.md) | Policy-driven templates for IMM, ISM standalone workflows, and UCSM Service Profiles. |
| **06** | [Network Design](./docs/modules/06-networking.md) | Trunking, MTU 9000 efficiency, vPC dual-switch redundancy, and inter-site architecture. |
| **07** | [Deployment](./docs/modules/07-deployment.md) | Witness VM registration, Protection Domain creation, and site-to-site cluster pairing. |
| **08** | [Operations](./docs/modules/08-operations.md) | Planned/Unplanned failover testing, LCM firmware upgrades, and ESXi HA/DRS behaviors. |

## 📖 Reference Materials
* **[Take the Interactive Certification Quiz](https://forms.cloud.microsoft/r/Apk0qsihGe)** | 10 Questions | Estimated Time: 10 min
* **[Claim your Certificate of Completion](docs/CERTIFICATE.md)** | Available to all participants who pass the quiz.

## ⚡ Technical Guardrails
* **Latency:** Synchronous replication requires a strict Round Trip Time (RTT) of **≤ 5ms** to maintain application performance.
* **Witness:** A Witness VM must be deployed at a 3rd site to provide quorum, split-brain protection, and site arbitration.
* **MTU:** Jumbo Frames (MTU 9000) are required across the entire path for replication efficiency and throughput.
* **LACP:** Networking warning: LACP must not be enabled on the Fabric Interconnects until imaging is complete.

## 🏆 Knowledge Validation
Think you've mastered Nutanix Metro on Cisco UCS? Take our interactive certification quiz to find out!

* **[Take the Interactive Certification Quiz](https://forms.cloud.microsoft/r/Apk0qsihGe)** | 10 Questions
* **[Claim your Certificate of Completion](https://rmasand0.github.io/nutanix-ucs-metro-docs/docs/CERTIFICATE.html)** | No login required.

---
*Created for Rack2Cloud Architecture — Delivering Zero-Downtime Resiliency.*
