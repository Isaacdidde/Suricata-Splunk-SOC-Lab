## Wireshark Overview

Wireshark was used in this lab for packet-level visibility and traffic validation.
It served as the ground-truth tool to confirm whether network activity observed
by Suricata was actually present on the wire.

Wireshark captures were used to:
- Observe normal vs suspicious traffic patterns
- Validate scan and attack behavior
- Correlate packet-level events with Suricata alerts
- Understand protocol-level details (TCP, ICMP, DNS)

This helped ensure that IDS/IPS detections were accurate and explainable.

## Wireshark Display Filters Used

The following display filters were commonly used during analysis:

- tcp  
  Used to observe TCP-based communication and scans.

- icmp  
  Used to identify ping sweeps and ICMP-based reconnaissance.

- ip.addr == <target_ip>  
  Used to isolate traffic related to a specific host.

- tcp.flags.syn == 1 && tcp.flags.ack == 0  
  Used to identify SYN scans and connection attempts.

These filters helped reduce noise and focus on relevant traffic.


## Traffic Analysis Summary

Key observations during traffic analysis:

- Port scanning activity was clearly visible through repeated SYN packets.
- TCP three-way handshakes were observable for successful connections.
- Dropped traffic in IPS mode showed incomplete or reset connections.
- Normal browsing traffic showed expected DNS queries and TCP sessions.

These observations were later correlated with Suricata alerts and drops.


## Correlation with Suricata

Wireshark was used to validate Suricata detections by correlating:

- Source and destination IP addresses
- Protocol and port information
- Timestamps of packet activity and alerts

When Suricata generated alerts or drops, corresponding packets could be
observed in Wireshark, confirming correct IDS/IPS behavior.

This correlation ensured detections were based on real traffic and not false positives.


## PCAP Usage Notes

Packet captures were taken during:
- Normal network activity
- Scanning and reconnaissance tests

PCAP files were analyzed both live and offline to understand traffic behavior
and validate security tool responses.
