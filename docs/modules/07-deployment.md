# Module 7: Deploying Metro Availability (AHV & ESXi)

[cite_start]This module outlines the step-by-step process for pairing clusters and enabling synchronous replication[cite: 71].

## Witness VM Deployment
[cite_start]The Witness is the "tie-breaker" for site arbitration[cite: 73].
* [cite_start]**Purpose**: Protects cluster integrity by preventing split-brain scenarios[cite: 19, 73].
* [cite_start]**Latency**: Ensure the network meets the specific latency guidelines for Witness communication[cite: 74].
* [cite_start]**Registration**: Once deployed, the Witness must be registered and health-verified in Prism on both clusters[cite: 76, 79].

## Metro Cluster Build Workflow
1. [cite_start]**Cluster Pairing**: Establish a relationship between Site A and Site B in Prism[cite: 82].
2. [cite_start]**Protection Domains**: Create Protection Domains specifically for Metro availability[cite: 80, 83].
3. [cite_start]**VM Assignment**: Add the target VMs to the Protection Domain[cite: 84].
4. [cite_start]**Enable Sync**: Activate synchronous replication between the two clusters[cite: 85].
5. [cite_start]**Initial Sync**: Monitor the initial synchronization to validate cluster readiness and Protection Domain health[cite: 86].
