---
title: "CIDR Network Notation"
date: 2019-05-29 15:22:04 +08:00
modified: 2019-05-29 15:22:04 +08:00
tags: [networking, cidr]
description: 
---

# CIDR Network Notation

<br />

## Classful vs Classless Networking

Networks are generally categorized into classful or classless types. In the beginning, classful networks were widely adopted and used by the internet community. It was named so because of the address classes defined with assignable IP address space. The problem with this scheme, however, is that ip addresses were disproportionately distributed which doesn't scale with the growth of the internet.

So, the IETF[^1] came up with a new way to identify networks and allocate ip addresses. And, in the early 90s, Classless Inter-Domain Routing (CIDR)[^2] was first introduce to prevent the fast exhaustion of ip addresses as well as to slow the growth of routing tables. It does away with the idea of classes altogether.

Even with the widespread adoption of classless networks, classful networks didn't really go away and are still being used by many devices. It is important to understand both classful and classless networking.

## CIDR Notation

In CIDR notation, an address is written in two parts (or bits) - the prefix and the suffix. The first part refers to the network (or subnet) identifier of the address. The other, which is indicated by the number of bits in the entire address, refers to the host identifier used to determine which host or device on the network should receive the incoming packets.

In CIDR notation, IP addresses are written as a prefix, and a suffix is attached to indicate how many bits are in the entire address. For instance, in the CIDR notation 192.0.1.0/24, the prefix is 192.0.1.0. The suffix is set apart from the prefix with a slash mark, and in this case, 24.

## CIDR Block
