# Module 7: Metro Availability Deployment

Once the underlying Cisco UCS hardware is imaged and the independent Nutanix clusters are healthy, the Metro configuration can begin. This process involves pairing the clusters and establishing the synchronous protection domain.

## 7.1 Site-to-Site Cluster Pairing
Before synchronous replication can occur, the two clusters must be introduced to one another.
* **Remote Site Configuration**: In Prism, each cluster must be added as a remote site to the other using the Virtual IP (VIP) of the remote Controller VMs.
* **Network Mapping**: Configure network mapping for the CVM and Guest VM networks to ensure that VMs can successfully transition between sites.
* **Port Verification**: Ensure port 9440 is open bi-directionally between all CVMs at Site A and Site B to allow for metadata synchronization.



## 7.2 Witness VM Registration
The Witness is the final component required for a production-ready Metro environment.
* **Witness Deployment**: The Witness VM must be deployed on a standalone host or a third Nutanix cluster in a separate failure domain.
* **Prism Integration**: Register the Witness VM via the Witness menu in Prism on both clusters.
* **Validation**: Confirm the Witness status shows as connected on both sites to ensure that automated failover is armed.

## 7.3 Creating Protection Domains
Metro Availability is managed through a specific type of Protection Domain.
* **Container Stretched Mode**: Select the storage container to be protected and enable the synchronous replication option.
* **VM Selection**: Add the target VMs to the Protection Domain to ensure all VMs within the domain share a common consistency requirement.
* **Active/Standby Assignment**: Define which site will initially serve as the active site for the container.



## 7.4 Final Health Check
* **Status Verification**: Monitor the Protection Domain until the status changes from synchronizing to enabled.
* **Consistency Check**: Verify that all nodes across both Cisco UCS domains are reporting a latency of ≤ 5ms RTT.
