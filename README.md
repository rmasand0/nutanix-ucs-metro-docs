# nutanix-ucs-metro-docs
Engineering Guide: Nutanix Metro Availability on Cisco UCS M5/M6/M7.
# Nutanix Metro Availability on Cisco UCS: Implementation Guide

[![Documentation Status](https://img.shields.io/badge/Status-Validated-green.svg)](https://rack2cloud.com)
[![Expertise](https://img.shields.io/badge/Expertise-NCP--Principal-blue.svg)](https://nutanix.com)

This repository contains the definitive engineering guide for deploying **Nutanix Metro Availability** on **Cisco UCS M5/M6/M7** hardware. It addresses the intersection of software-defined storage logic and physical compute fabric optimization.

## 📖 Guide Modules

| Module | Level | Focus |
| :--- | :--- | :--- |
| [Foundations](./modules/01-foundations.md) | L100 | Latency (≤5ms), MTU, and Witness Quorum logic. |
| [Cisco UCS Alignment](./modules/02-ucs-hardware.md) | L200 | Fabric Interconnects, vNIC Policies, and BIOS Tuning. |
| [Implementation](./modules/03-implementation.md) | L300 | Container mapping, Witness deployment, and Affinity rules. |
| [Failure Logic](./modules/04-failure-logic.md) | L300 | Split-brain protection and automated promotion logic. |
| [Day 2 Operations](./modules/05-day2-ops.md) | L200 | Non-disruptive testing and scaling hardware. |

---

## 🛠 Automation
The `/scripts` directory contains validated PowerShell scripts for the **Cisco UCS PowerTool Suite**.
* `deploy-node.ps1`: Automates Service Profile creation from Nutanix-optimized templates.



## ⚡ Quick Specs for Metro
* **Max Latency:** 5ms Round Trip Time (RTT).
* **Storage Interface:** 10/25/100GbE (Cisco VIC 1400/1500).
* **Network:** Stretched Layer 2 (Management, Storage, and VM traffic).
* **Witness:** Required at a 3rd site (Cloud or independent On-Prem).

---

## 🚀 Getting Started
1. **Clone the repo:** `git clone https://github.com/your-org/nutanix-ucs-metro-docs.git`
2. **Review Module 2:** Ensure your Cisco UCS Fabric Interconnects are configured for Jumbo Frames (9216 MTU).
3. **Deploy Witness:** Use the lightweight OVF available on the Nutanix Support Portal.

---

## 🖋 Author
**Principal Systems Engineer | Nutanix Certified Professional (NCP)**
*Specializing in Rack2Cloud Architecture & Hybrid Cloud Integration.*
