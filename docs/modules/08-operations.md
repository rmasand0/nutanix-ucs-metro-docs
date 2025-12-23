# Module 8: Metro Operations (AHV + ESXi)

[cite_start]Daily operations differ slightly depending on your chosen hypervisor[cite: 87].

## AHV Metro Operations
* [cite_start]**Prism Management**: Manage Metro settings directly through Prism Element or Prism Central[cite: 89].
* [cite_start]**Upgrades**: Use the Life Cycle Manager (LCM) for non-disruptive firmware and software upgrades[cite: 90].
* [cite_start]**Failover**: Practice both planned and unplanned failover/failback operations to ensure RTO targets are met[cite: 91].
* [cite_start]**Health Checks**: Regularly run NCC (Nutanix Cluster Check) to ensure the environment remains healthy[cite: 93].

## ESXi Metro Operations
* [cite_start]**vCenter Integration**: Ensure all clusters have proper vCenter connectivity for datastore presentation[cite: 95].
* [cite_start]**HA/DRS Behavior**: Configure VMware HA and DRS to respect site boundaries while allowing for failover[cite: 96].
* [cite_start]**Placement Rules**: Use Host and VM placement best practices (Soft Affinity) to keep traffic local to the active storage[cite: 97].
* [cite_start]**Hardening**: Apply ESXi configuration hardening to maintain operational stability and security[cite: 98].
