# Module 1: Introduction to Metro Availability

## 1.1 Understanding Metro Availability
Nutanix Metro Availability is a continuous availability solution that provides a zero-recovery point objective (RPO) and near-zero recovery time objective (RTO) across two sites. It enables a stretched storage container across two independent Nutanix clusters, allowing for non-disruptive migration of virtual machines (VMs) and automated recovery during a site failure.

### Core Benefits for the Enterprise
* **Active-Active Architecture**: Enables data protection and operational benefits by allowing both sites to serve I/O simultaneously.
* **Zero-Downtime Resiliency**: Organizations deploy Metro clusters to eliminate the risk of data loss and maintain business continuity.
* **Simplified Operations**: Streamlines site maintenance by allowing VMs to be moved between locations without taking them offline.

## 1.2 Required Baseline Knowledge
To succeed in this 2-day deep dive, engineers should be familiar with the following core technologies:
* **AOS Fundamentals**: Knowledge of the Nutanix Distributed Storage Fabric (DSF).
* **Hypervisor Basics**: Proficiency in either Nutanix AHV or VMware ESXi.
* **Networking Essentials**: Understanding of VLANs, MTU settings, and multi-site connectivity requirements.

## 1.3 Cisco UCS Integration Modes
A primary focus of this guide is the integration of Nutanix software with Cisco UCS hardware. We will cover three distinct operating modes:
* **IMM (Intersight Managed Mode)**: Modern, policy-driven management through the Cisco Intersight cloud.
* **ISM (Intersight Standalone Mode)**: Direct management of standalone servers through Intersight without Fabric Interconnects.
* **UCSM (Fabric Interconnect Managed Mode)**: The classic management approach using Cisco UCS Manager.

