# Module 2: Metro Availability Overview

> [!IMPORTANT]
> [cite_start]**Zero RPO Achievement**: Metro Availability is defined by its ability to maintain a Zero Recovery Point Objective (RPO)[cite: 15].

## Visualizing the Replication Spectrum
[cite_start]To understand Metro, we must compare it to other Nutanix replication types[cite: 16]:

* **Asynchronous**: Snapshots taken at intervals (1 hour+).
* **NearSync**: Light-weight snapshots (1 minute to 15 minutes).
* **Metro (Synchronous)**: Real-time replication. [cite_start]Every write is mirrored before acknowledgment[cite: 15].

### The Quorum Decision Tree
[cite_start]When a site fails, the Witness VM makes a calculated decision to prevent data corruption[cite: 19, 73].

```mermaid
graph TD
    A[Site A Outage Detected] --> B{Witness Reachable?}
    B -- Yes --> C[Witness Locks Site B]
    C --> D[Site B Promoted to Active]
    B -- No --> E[Site B Remains Standby]
    E --> F[Manual Intervention Required]
