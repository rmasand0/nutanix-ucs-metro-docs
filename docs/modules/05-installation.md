# Module 5: Nutanix AOS Installation on Cisco UCS

[cite_start]This module covers the imaging and cluster creation process across the three supported Cisco management modes[cite: 50].

## IMM (Intersight Managed Mode)
[cite_start]IMM uses a policy-driven approach to hardware deployment[cite: 51].
* [cite_start]**Domain Profiles**: Utilize domain profiles and policy-driven templates to ensure hardware consistency[cite: 52].
* [cite_start]**Network Policies**: Define VLANs and pool definitions (MAC/IP/UUID) within Intersight before deployment[cite: 53].
* [cite_start]**Foundation Central**: Leverage the Foundation Central workflow to automate the imaging of the clusters once hardware is prepared[cite: 54].



## ISM (Standalone Mode)
[cite_start]For environments without Fabric Interconnects, the standalone workflow is used[cite: 55, 56].
* [cite_start]**Node Onboarding**: Manage node inventory directly within the Intersight dashboard[cite: 57].
* [cite_start]**Automated Imaging**: Use the cluster creation wizard to handle automated imaging of the nodes[cite: 58].
* [cite_start]**VLAN Configuration**: Pay close attention to VLAN trunk/access settings on the upstream switches[cite: 59].
* [cite_start]**LACP Note**: Do not enable LACP until the imaging process is fully complete[cite: 60, 68].

## UCSM (Classic Managed Mode)
[cite_start]Traditional Fabric Interconnect management follows a structured "Classic" workflow[cite: 61].
* [cite_start]**Fabric Interconnects**: Ensure a redundant cluster setup during the initial bring-up[cite: 62].
* [cite_start]**Service Profiles**: Create MAC/UUID pools and Service Profiles to abstract hardware from the software layer[cite: 63].
* [cite_start]**Foundation VM**: Use the Foundation VM workflow to image the Nutanix nodes in a UCSM-managed environment[cite: 64].
