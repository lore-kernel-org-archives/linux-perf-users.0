From: Andi Kleen <andi@firstfloor.org>
Subject: ucevent uncore monitoring tool available
Date: Fri, 26 Jul 2013 06:59:55 +0200
Message-ID: <20130726045955.GJ19750@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:60196 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab3GZE75 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 26 Jul 2013 00:59:57 -0400
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: eranian@google.com

I released the ucevent Intel server uncore monitoring tool as part of
pmu-tools.

http://github.com/andikleen/pmu-tools

The largest part of modern CPUs is outside the actual cores. On Intel
CPUs this is part is called the "Uncore" and and has last level caches,
PCI-Express, memory controller, QPI, power management and other
functionalities. To understand its performance the uncore also provides
a range of performance monitoring units (PMU) with performance counters
that can count various events.

This can be useful to monitor power management, IO bandwidth, memory
bandwidth, QPI (interconnect) traffic, cache hit rates and other
metrics. The Linux kernel as part of perf has an uncore driver for Xeon
systems since Linux 3.8. But since the uncore is complex, and the perf
tool's view of them is quite raw, they have been hard to use directly.

ucevent is a tool that provides a generic uncore event list, standard
equations and an (as friendly as possible) frontend to the uncore
metrics. It runs as a wrapper around perf stat. The output is similar to
turbostat.

The tool can be used directly to monitor, or to prototype/resolve uncore events
for other tools.

The tool currently requires a Intel Xeon E5 2600 series (SandyBridge EP) 
CPU and a patched 3.10 kernel, and a BIOS that enables uncore
monitoring.

For more details please see the ucevent documentation

https://github.com/andikleen/pmu-tools/tree/master/ucevent#ucevent-uncore-monitoring

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
