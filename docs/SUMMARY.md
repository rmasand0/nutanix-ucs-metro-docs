# Workshop Summary: Nutanix Metro on Cisco UCS

Congratulations on completing the **Nutanix Metro on Cisco UCS Technical Workshop**. You have successfully navigated the complexities of multi-site architecture, Cisco Intersight management, and synchronous storage replication.

---

## 🔑 Key Takeaways

### 1. Hardware-Software Synergy
By utilizing **Cisco Intersight (IMM/ISM)**, we treat hardware as code. This ensures that the BIOS, firmware, and storage controller settings required by Nutanix are consistent across both sites, eliminating "configuration drift" that often causes Metro failures.

### 2. The Power of "Double-ACK"
You have mastered the I/O path logic. Understanding that every write must be acknowledged by both the local and remote Cisco UCS nodes ensures **RPO 0** (Zero Data Loss) for mission-critical applications.

### 3. Networking is the Backbone
We validated that **MTU 9000 (Jumbo Frames)** and **< 5ms RTT latency** are not just recommendations—they are requirements. Without the Nexus vPC and QoS configurations we practiced, synchronous replication cannot maintain the stability required for production.

---

## 🛠️ Your "Day 3" Checklist
As you take these skills back to your production environment, keep this checklist handy:

* [ ] **Witness Placement**: Always ensure the Witness VM is in a third, independent failure domain (Site C).
* [ ] **Firmware Alignment**: Check the Nutanix HCL before every Cisco UCS firmware upgrade.
* [ ] **Alert Monitoring**: Configure Prism Central to alert on "Metro Sync Paused" events immediately.
* [ ] **Failover Drills**: Perform a non-disruptive "Planned Failover" at least once a quarter to ensure operational readiness.

---

## 📚 Continued Learning & Resources
To further deepen your expertise, explore these official resources:

* **[Nutanix Bible - Metro Availability](https://www.nutanixbible.com/any-platform/data-protection-and-disaster-recovery/metro-availability)**: The definitive guide to the underlying logic.
* **[Cisco Intersight Documentation](https://intersight.com/help)**: Deep dives into Server Profiles and Domain Policies.
* **[Nutanix University](https://university.nutanix.com/)**: Certification paths for NCP (Nutanix Certified Professional).
* **[Nutanx Leaning Path](https://www.kqzyfj.com/click-101613965-17135603/)**: Nutanix Courses

---

## 🤝 Thank You
Thank you for your participation and technical curiosity. This workshop was designed to bridge the gap between compute and storage engineering, and your engagement has made it a success.

**The Rack2Cloud Technical Team**
*Last Updated: December 2025*
