Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486566;
	b=25KOWn6fSSWHOKVdxUE/SL60VjRt5FTQLnItiTM1hn0DYzHZkJ6tAvOrEUBqk+B45KGc
	 q5AtBYlLwBoiHamn34o/ZqZu4EeksPhiUu5B29/1EEWL+KBTnhY7GbMUzWSKVWiAlsZTm
	 Fqp0mgSslPTCyOH3KDLICfmpM/rtP7CxHk1RippS7glAUW8CvRpoyShFqQnmY2O8Pe4EQ
	 gRal58pz0YAp/X2DLLLD7gr/jiBfhOq+ZaR8wib0bIhKc697BvSOtOq8RhRqDLb7hno/r
	 cFlE0oca+izpLCBvHB+uNTsE7ptCeXQUahn76IlO8Ic2+YW00emkJIeHIawMj/AFhLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486566;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=m8SSg5Bn3b+DCocUm0d22HyQ1Olj1Kc4HTlSue4GoMI=;
	b=AL6b5bjzyC0P+GMtHX4b9JEzoQXJ3FaGwsIVW7euj3Y1kwIv3U+LB1O3zBfHhfJ05Qpd
	 KrWkRFJwHCc7sJH0C2261OJvTT/f/yo2YhvucN9bHI5NSv11/rUqAMwl3YLzPlr34l18N
	 9W2ZYAwQKz2NiJhvQ6R1pdH4DOubUbFE5L+si0JvL3iIBmaAR+ptgE/tDddBygQUBbGiE
	 j43fUzL0q/dDA80JkYLXUxVqd/oa+Undi33gGc00W5yY7ADzDqPwPnC/gPioys7wvxFZd
	 zmaSPyNoV3OAUtGmA6ugXO/SsJR0duBhyo5Km8PyuyomChFHBXQd+ivAeKyMWrGEXPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEED606A8A3;
	Thu, 12 Nov 2026 12:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AEED606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794486564; x=1826022564;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jAK76f46gfnN2w5QFzctuwiMQsb+MRcwtsQvlEGPl1s=;
  b=sFo8+Z/sJFcnkWxtJU7kJ4m2BJxesJdBZ45ZQ9rp5iyX74XG/A5C3ehC
   1rA6g9Ksz/3SrBKpckjvs8oIr/eNAlAGom5bT+w2OJLrgSvZxfkX8NlGB
   q9kV0ocqT2UJkptmoXE1RrSlS+fesyqnH7H0IYEyBPuuV+m14l+TLfZVI
   sd8V7aJUn5dGDbL8HAotY8tyCWoJdAkLNUqPnbT+xMoW6sjEAESG1FICE
   pMt/kCH+8SR774atilWZhViPr4ShObPo9nmnPkZ1LH2NkCFO/K2I8zl36
   GQxkA8qqvN1o16z/hfcM44CGsUZto/QiCoq3lmJNgxK21zkBZHms9+4Sl
   w==;
X-CSE-ConnectionGUID: 17Jg97HdQH6H9ZG49LVN+g==
X-CSE-MsgGUID: kQsHR/JSTcemERwXDtg3lg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 14:29:22 +0200
X-CSE-ConnectionGUID: 9+wFF2vFR5SXOMB2HbssYA==
X-CSE-MsgGUID: Nb0q3TY/TgaAR/hs/kky2Q==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 12 Nov 2026 14:37:19 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 12 Nov 2026 14:29:21 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 12 Nov 2026 14:29:02 +0200
Subject: [PATCH v2 5/6] perf: add MIPS Coherence Manager 3 (CM3) PMU driver
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-i6500-cm3-pmu-v2-5-cd2569571819@mobileye.com>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
In-Reply-To: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Fu Chao-Ying <chao-ying.fu@globalfoundries.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.16.0

The CM3 of the MIPS I6500 multiprocessing system serializes the requests
of all cores, IOCUs and the hardware prefetcher before they reach the
shared L2 and the memory interface. It provides two programmable 32-bit
event counters and a 32-bit cycle counter to observe this traffic:
coherence manager requests, I/O and memory interface requests, AXI bus
utilization and PDTrace statistics. Each event is refined by a 64-bit
qualifier split into groups of bits (port, thread, command, CCA, L1/L2
state, ...), where a request is counted when it matches a set bit in
every group.

Expose the counters as uncore PMUs bound to the coherency-manager DT
node, using the GCR block already mapped by mips_cm_probe(). Events are
described by 'event' (config:0-8, 0x100 selecting the cycle counter)
and 'qual' (config1:0-63); a qualifier of 0 picks a per-event default
that counts every occurrence. Named events are provided for the common
combinations and double as templates for custom qualifiers.

Every cluster has its own CM3 and its own counters, so one PMU named
mips_cm3_pmu_<cluster> is registered per cluster found in GCR_CONFIG.
A cluster does not need CPUs, online or at all, for its L2 and memory
interface to be busy, so the counters of other clusters are accessed
through the GCR redirect block from whichever CPU runs the PMU. This
only requires the CM of that cluster to be powered, which is checked
in the CPC (CM core STAT_CONF) when an event is opened: the counters
of a powered down cluster are initialized lazily on first use and
events on it fail with -ENODEV meanwhile. A cluster that Linux booted
powers down with the last of its cores (CPC_PWRUP_CTL.CM_PWRUP is
left clear), so when the last online CPU of a cluster goes offline
its PMU is paused: counts are harvested, running events keep their
state but stop counting, new events are refused; it resumes when a
CPU of the cluster comes back. The counters are shared by the whole
cluster: events are system-wide only, pinned to a single CPU which
follows CPU hotplug; sampling, task events and the exclude_*
attributes are rejected.

Counter overflow is handled through the CM interrupt when the DT node
provides one, and by periodic polling otherwise, giving 64-bit counts
in both cases. Each cluster's CM drives its own interrupt output into
its own GIC, and a GIC shared interrupt is only routed to the cluster
of its affinity CPU, so the interrupt serves the cluster the CPUs live
in, and only when they all live in that one cluster; everything else
is polled.

Document the perf interface, the event numbers and the qualifier layouts
in Documentation/admin-guide/perf/mips_cm3_pmu.rst.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 Documentation/admin-guide/perf/index.rst        |    1 +
 Documentation/admin-guide/perf/mips_cm3_pmu.rst |  346 +++++++
 drivers/perf/Kconfig                            |   12 +
 drivers/perf/Makefile                           |    1 +
 drivers/perf/mips_cm3_pmu.c                     | 1237 +++++++++++++++++++++++
 5 files changed, 1597 insertions(+)

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index aa12708ddb96..97620aa20465 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -14,6 +14,7 @@ Performance monitor support
    qcom_l2_pmu
    qcom_l3_pmu
    starfive_starlink_pmu
+   mips_cm3_pmu
    mrvl-odyssey-ddr-pmu
    mrvl-odyssey-tad-pmu
    arm-ccn
diff --git a/Documentation/admin-guide/perf/mips_cm3_pmu.rst b/Documentation/admin-guide/perf/mips_cm3_pmu.rst
new file mode 100644
index 000000000000..f952b43f668e
--- /dev/null
+++ b/Documentation/admin-guide/perf/mips_cm3_pmu.rst
@@ -0,0 +1,346 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================================================================
+MIPS Coherence Manager 3 (CM3) Performance Monitoring Unit (PMU)
+=================================================================
+
+The Coherence Manager 3 (CM3) of the MIPS I6500 multiprocessing system is
+the point where the requests of all cores, I/O coherence units (IOCU) and
+the hardware prefetcher are serialized before reaching the shared L2 cache
+and the memory interface. The CM3 implements a small set of performance
+counters which observe this traffic:
+
+- two programmable 32-bit event counters, and
+- one 32-bit cycle counter clocked at the CM3 clock.
+
+The counters live in the global debug block of the CM Global Configuration
+Registers (``GCR_DB_PC_*``), are shared by all CPUs of the cluster, and count
+regardless of which CPU, privilege level or task generated the traffic. They
+are exposed by the ``mips_cm3_pmu`` driver (``CONFIG_MIPS_CM3_PMU``, built-in
+or as the ``mips_cm3_pmu`` module) as uncore PMUs.
+
+Clusters
+========
+
+A multi-cluster system has one CM3, and so one set of counters, per
+cluster. The number of clusters is read from ``GCR_CONFIG`` and the driver
+registers one PMU per cluster, named after the cluster number::
+
+  /sys/bus/event_source/devices/mips_cm3_pmu_0/
+  /sys/bus/event_source/devices/mips_cm3_pmu_1/
+
+A single-cluster system only has ``mips_cm3_pmu_0``. Each PMU counts the
+traffic of its own cluster: a request from a core in cluster 1 to the memory
+interface of cluster 1 is seen by ``mips_cm3_pmu_1`` only.
+
+A cluster does not need CPUs for its CM to be busy: its L2 cache and memory
+interface may serve I/O devices behind its IOCUs while its cores are absent,
+offline or powered down. The counters of any cluster are therefore reached
+through the GCR redirect block from whichever CPU runs the PMU, which can be
+in any cluster. What is needed is that the CM of the counted cluster is
+powered: the driver checks the CM power sequencer state in the Cluster Power
+Controller (``CPC_STAT_CONF`` of the CM "core") when an event is opened and
+fails with ``-ENODEV`` if the cluster is powered down. The PMU of the
+cluster the CPUs run in is always usable.
+
+A cluster that Linux booted powers down with the last of its cores, as the
+kernel leaves ``CPC_PWRUP_CTL.CM_PWRUP`` clear once the cluster is up. When
+the last online CPU of such a cluster is taken down, its PMU is paused: the
+counts of its events are harvested, the events keep their state but stop
+counting, and opening new events on the PMU fails with ``-ENODEV``. The PMU
+resumes, its running events counting again from where they stood, when a
+CPU of the cluster comes back online. A cluster whose CM is kept powered
+(``CM_PWRUP`` set) is not paused and keeps counting without CPUs.
+
+Because the counters are shared, events are system wide only. Sampling
+(``perf record``), attaching to a task, and the ``exclude_*`` attributes are
+not supported; ``perf stat -a`` is the intended interface. The ``cpumask``
+attribute names the single CPU on which the counters are programmed and
+read; it migrates to another online CPU when that one goes offline::
+
+  $ cat /sys/bus/event_source/devices/mips_cm3_pmu_1/cpumask
+  0
+
+Counter overflow
+================
+
+The CM3 raises its ``so_cm_perf_cnt_int`` output when a counter reaches
+0xFFFFFFFF. Whether that output reaches an interrupt controller input is a
+decision of the SoC integrator. If the ``coherency-manager`` device tree node
+carries an ``interrupts`` property, the driver uses it to extend the counters
+to 64 bits. Otherwise the driver polls the counters every 250 ms, which is
+well below the time the fastest event needs to wrap a 32-bit counter. Either
+way, the values reported by perf are 64-bit.
+
+The interrupt can only serve the cluster the CPUs live in, and only when
+they all live in that one cluster. Every cluster's CM drives its own
+interrupt output into its own GIC, and a GIC shared interrupt is routed to
+the cluster of its affinity CPU, so a single ``interrupts`` entry cannot
+serve several clusters at once. The PMUs of all other clusters, and all PMUs
+when CPUs are spread over several clusters, are polled.
+
+The mode chosen is printed at probe time, or the fact that the cluster was
+powered down when the driver probed; the counters are then initialized when
+the first event is opened::
+
+  mips_cm3_pmu coherency-manager: mips_cm3_pmu_0: 2 counters + cycles, polled
+  mips_cm3_pmu coherency-manager: mips_cm3_pmu_1: cluster powered down
+
+Event encoding
+==============
+
+An event is described by two fields, documented in the ``format`` directory::
+
+  $ cat /sys/bus/event_source/devices/mips_cm3_pmu_0/format/event
+  config:0-8
+  $ cat /sys/bus/event_source/devices/mips_cm3_pmu_0/format/qual
+  config1:0-63
+
+``event`` selects the event number written to ``GCR_DB_PC_EVENT``. The
+value ``0x100`` is a pseudo event selecting the cycle counter.
+
+``qual`` is the 64-bit qualifier written to ``GCR_DB_PC_QUALn``. It refines
+the event: the qualifier is split into groups of bits, each group covering
+one attribute of a request (originating port, command, cacheability, L2
+state, ...). A request is counted when, in **every** group, the bit
+matching its attribute is set. Setting several bits of a group ORs the
+alternatives; setting all bits of a group makes it a "don't care". A ``qual``
+of 0 (or omitting it) selects a per-event default that counts every
+occurrence of the event.
+
+Event numbers
+-------------
+
+===========  ==========================  ======================================
+Event        Name                        Description
+===========  ==========================  ======================================
+0x01         CM requests                 Requests serialized by the coherence
+                                         manager (qualifier: Table 1)
+0x02         I/O traffic requests        Requests received by an IOCU
+                                         (qualifier: Table 2)
+0x03         Memory interface requests   Requests issued on the memory
+                                         interface (qualifier: Table 3)
+0x07         MEM AXI utilization         Cycles on the memory AXI/ACE bus
+                                         (qualifier: Table 4)
+0x08 - 0x0f  IOCU0-7 AXI utilization     Cycles on the AXI bus of IOCU
+                                         (event - 0x08) (qualifier: Table 4)
+0x11         PDTrace dropped messages    Messages dropped by CM PDTrace
+                                         (qualifier: Table 5)
+0x12         PDTrace overflow cycles     Cycles spent in CM PDTrace overflow
+0x100        cycles                      CM3 cycle counter (pseudo event)
+===========  ==========================  ======================================
+
+Table 1: Coherence Manager Requests qualifier (event 0x01)
+----------------------------------------------------------
+
+======  ===========  ===================================================
+Bits    Group        Values (one bit each, LSB first)
+======  ===========  ===================================================
+9:0     Port         Input port 0..7, prefetcher (8), intervention (9).
+                     Ports are numbered cores first, then IOCUs.
+13:10   Thread       Thread 0..3
+15:14   Target       Memory, register bus (GCR, GIC, CPC, ...)
+39:16   Command      Legacy read, legacy write, CohReadOwn,
+                     CohReadShare, CohReadDiscard, CohEvict,
+                     CohUpgrade, CohUpgradeSC, CohWriteBack,
+                     CohWriteInvalidate, CohReadDiscardAllocate,
+                     prefetch own, prefetch share, prefetch write
+                     invalidate, GetToOwn, Tag_Err, RegRead,
+                     RegWrite, Sync, L1I cacheop, L1D cacheop,
+                     L2 cacheop, L3 cacheop, other
+42:40   CCA          Uncached, uncached accelerated, other
+44:43   Size         Less than a line, one line
+47:45   L1 state     Invalid, shared, exclusive/modified
+51:48   L2 state     Invalid, shared, exclusive, modified
+53:52   L2 locked    Not locked, locked
+56:54   Eviction     None, L2 and L1 eviction, L2 eviction only
+58:57   Bank         L2 bank 0, bank 1
+60:59   Scheduler    Scheduler 0, scheduler 1
+63:61   Reserved     Must be set
+======  ===========  ===================================================
+
+Default: all bits set.
+
+Table 2: I/O Traffic Requests qualifier (event 0x02)
+----------------------------------------------------
+
+======  ===============  ===============================================
+Bits    Group            Values
+======  ===============  ===============================================
+2:0     IOCU number      Encoded 0..7 (a value, not a mask)
+7:3     Direction/CCA    Uncached read, coherent read with allocate,
+                         coherent read without allocate, uncached
+                         write, coherent write
+15:8    Size             1, 2, 4, 8, 16, 32, 64, 128 bytes per beat
+24:16   Length           1, 2, 3-4, 5-8, 9-16, 17-32, 33-64, 65-128,
+                         129-256 beats
+26:25   Alignment        Aligned, misaligned
+28:27   Prefetch         Not prefetch, prefetch
+29      All device IDs   Set to ignore bits 35:30
+35:30   Device ID        Encoded device ID
+36      All txn IDs      Set to ignore bits 41:37
+41:37   Transaction ID   Encoded transaction ID
+======  ===============  ===============================================
+
+Default: IOCU 0, every other group "don't care" (``0x3fffffffff8``).
+
+Table 3: Memory Interface Requests qualifier (event 0x03)
+---------------------------------------------------------
+
+======  ===============  ===============================================
+Bits    Group            Values
+======  ===============  ===============================================
+1:0     Direction        Read, write
+9:2     Size             1, 2, 4, 8, 16, 32, 64, 128 bytes per beat
+17:10   Length           0..7 beats
+21:18   Cacheability     Uncached, uncached accelerated, cacheable read
+                         discard, cacheable not read discard
+29:22   Source           Input port 0..7
+35:32   Thread           Thread 0..3
+37:36   Code/data        Data, code
+39:38   Prefetch         Not prefetch, prefetch
+40      All guest IDs    Set to ignore bits 45:41
+45:41   Guest ID         Encoded guest ID
+======  ===============  ===============================================
+
+Default: all groups "don't care" (``0x3fffffffffff``).
+
+Table 4: AXI Bus Utilization qualifier (events 0x07 - 0x0f)
+-----------------------------------------------------------
+
+These events count cycles, qualified by the state of the handshake signals
+of one AXI channel.
+
+======  ===============  ===============================================
+Bits    Group            Values
+======  ===============  ===============================================
+0       Not valid        Count cycles where xVALID is deasserted
+1       Valid            Count cycles where xVALID is asserted
+2       Not ready        Count cycles where xREADY is deasserted
+3       Ready            Count cycles where xREADY is asserted
+6:4     Channel          Encoded: 0 AR, 1 AW, 2 W, 3 R, 4 B
+======  ===============  ===============================================
+
+Setting both ``valid`` and ``ready`` counts completed transfers. Default:
+transfers on the AR channel (``0xa``).
+
+Table 5: CM PDTrace Dropped Messages qualifier (event 0x11)
+-----------------------------------------------------------
+
+======  ===============  ===============================================
+Bits    Group            Values
+======  ===============  ===============================================
+5:0     Trace port       ubrh, prsh, tmh0, tmh0_mulp, tmh1, tmh1_mulp
+7:6     Trace type       Request, response
+======  ===============  ===============================================
+
+Default: all bits set.
+
+Named events
+============
+
+The ``events`` directory provides ready-made event/qualifier pairs for the
+most useful combinations::
+
+  $ perf list mips_cm3_pmu_0
+
+  mips_cm3_pmu_0/cm_requests/                          [Kernel PMU event]
+  mips_cm3_pmu_0/cm_requests_coh_writeback/            [Kernel PMU event]
+  mips_cm3_pmu_0/cm_requests_l2_hit/                   [Kernel PMU event]
+  mips_cm3_pmu_0/cm_requests_l2_miss/                  [Kernel PMU event]
+  mips_cm3_pmu_0/cm_requests_legacy_read/              [Kernel PMU event]
+  mips_cm3_pmu_0/cm_requests_legacy_write/             [Kernel PMU event]
+  mips_cm3_pmu_0/cm_requests_mem/                      [Kernel PMU event]
+  mips_cm3_pmu_0/cm_requests_regbus/                   [Kernel PMU event]
+  mips_cm3_pmu_0/cycles/                               [Kernel PMU event]
+  mips_cm3_pmu_0/iocu0_requests/                       [Kernel PMU event]
+  mips_cm3_pmu_0/mem_axi_ar/                           [Kernel PMU event]
+  mips_cm3_pmu_0/mem_axi_aw/                           [Kernel PMU event]
+  mips_cm3_pmu_0/mem_axi_b/                            [Kernel PMU event]
+  mips_cm3_pmu_0/mem_axi_r/                            [Kernel PMU event]
+  mips_cm3_pmu_0/mem_axi_w/                            [Kernel PMU event]
+  mips_cm3_pmu_0/mem_reads/                            [Kernel PMU event]
+  mips_cm3_pmu_0/mem_requests/                         [Kernel PMU event]
+  mips_cm3_pmu_0/mem_writes/                           [Kernel PMU event]
+  mips_cm3_pmu_0/pdtrace_dropped/                      [Kernel PMU event]
+  mips_cm3_pmu_0/pdtrace_overflow_cycles/              [Kernel PMU event]
+
+==============================  =============================================
+Name                            Counts
+==============================  =============================================
+cycles                          CM3 clock cycles
+cm_requests                     Every request serialized by the CM
+cm_requests_mem                 Requests targeting memory
+cm_requests_regbus              Requests targeting the register bus
+cm_requests_legacy_read         Non-coherent reads, including code fetches
+cm_requests_legacy_write        Non-coherent writes
+cm_requests_coh_writeback       Coherent write backs
+cm_requests_l2_hit              Memory requests whose line is present in L2
+cm_requests_l2_miss             Memory requests whose line is not in L2
+iocu0_requests                  Requests received by IOCU 0
+mem_requests                    Requests issued on the memory interface
+mem_reads                       Memory interface reads
+mem_writes                      Memory interface writes
+mem_axi_ar/aw/w/r/b             Completed transfers on the given channel
+                                of the memory AXI bus
+pdtrace_dropped                 Messages dropped by CM PDTrace
+pdtrace_overflow_cycles         Cycles spent in CM PDTrace overflow
+==============================  =============================================
+
+The named events are plain ``event=...,qual=...`` strings, so they serve as
+templates: read one from sysfs and clear the bits of the group you want to
+narrow down.
+
+Examples
+========
+
+Count all CM requests and the share coming from port 1 (core 1), together
+with cycles, for one second::
+
+  $ perf stat -a -e mips_cm3_pmu_0/cycles/ \
+                 -e mips_cm3_pmu_0/cm_requests/ \
+                 -e mips_cm3_pmu_0/event=0x1,qual=0xfffffffffffffc02/ \
+                 sleep 1
+
+The second qualifier is the ``cm_requests`` default with the Port group
+(bits 9:0) reduced to bit 1.
+
+L2 hit rate of memory requests::
+
+  $ perf stat -a -e mips_cm3_pmu_0/cm_requests_l2_hit/ \
+                 -e mips_cm3_pmu_0/cm_requests_l2_miss/ sleep 1
+
+Utilization of the memory read data channel: cycles with a transfer versus
+cycles where the CM waits for data (valid deasserted)::
+
+  $ perf stat -a -e mips_cm3_pmu_0/cycles/ \
+                 -e mips_cm3_pmu_0/mem_axi_r/ \
+                 -e mips_cm3_pmu_0/event=0x7,qual=0x3d/ sleep 1
+
+Requests received by IOCU 1 (IOCU number is an encoded value in bits 2:0)::
+
+  $ perf stat -a -e mips_cm3_pmu_0/event=0x2,qual=0x3fffffffff9/ sleep 1
+
+Memory interface traffic of every cluster of a two-cluster system::
+
+  $ perf stat -a -e mips_cm3_pmu_0/mem_requests/ \
+                 -e mips_cm3_pmu_1/mem_requests/ sleep 1
+
+Only two programmable counters exist; a group requesting more than two
+non-cycle events, or more than one ``cycles`` event, is rejected with
+``-EINVAL``.
+
+Device tree
+===========
+
+The driver binds to the ``coherency-manager`` node (``mti,mips-cm`` or
+``mobileye,eyeq6-cm``) and uses the GCR base address already discovered by
+the kernel from the ``CMGCRBase`` register. An ``interrupts`` property on
+that node, when the SoC routes ``so_cm_perf_cnt_int`` to an interrupt
+controller, enables interrupt-driven overflow handling::
+
+  coherency-manager {
+      compatible = "mobileye,eyeq6-cm";
+      interrupt-parent = <&gic>;
+      interrupts = <GIC_SHARED 42 IRQ_TYPE_LEVEL_HIGH>;
+  };
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 245e7bb763b9..2dbed2fc7b03 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -75,6 +75,18 @@ config ARM_XSCALE_PMU
 	depends on ARM_PMU && CPU_XSCALE
 	def_bool y
 
+config MIPS_CM3_PMU
+	tristate "MIPS Coherence Manager 3 (CM3) PMU"
+	depends on MIPS_CM
+	help
+	  Support for the performance counters of the MIPS Coherence Manager 3
+	  (CM3) found in the I6500 multiprocessing system. The CM3 provides two
+	  programmable event counters and a cycle counter which can count
+	  requests serialized by the coherence manager, I/O and memory interface
+	  traffic, and AXI bus utilization, each refined by a qualifier.
+
+	  If compiled as a module, it will be called mips_cm3_pmu.
+
 config RISCV_PMU
 	depends on RISCV
 	bool "RISC-V PMU framework"
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index eb8a022dad9a..5f0920ba7058 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_FUJITSU_UNCORE_PMU) += fujitsu_uncore_pmu.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
+obj-$(CONFIG_MIPS_CM3_PMU) += mips_cm3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
diff --git a/drivers/perf/mips_cm3_pmu.c b/drivers/perf/mips_cm3_pmu.c
new file mode 100644
index 000000000000..6d53535473b9
--- /dev/null
+++ b/drivers/perf/mips_cm3_pmu.c
@@ -0,0 +1,1237 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MIPS Coherence Manager 3 (CM3) performance counter PMU driver
+ *
+ * The CM3 found in the MIPS I6500 multiprocessing system implements two
+ * programmable 32-bit event counters and a 32-bit cycle counter. They are
+ * controlled through the GCR global debug block (GCR_DB_PC_*) and count
+ * events happening at the coherence manager: serialized requests, I/O and
+ * memory traffic, AXI bus utilization, ...
+ *
+ * perf interface:
+ *
+ *   config  [8:0]  event number (GCR_DB_PC_EVENT.Px_Event), 0x100 selects
+ *                  the cycle counter.
+ *   config1 [63:0] event qualifier (GCR_DB_PC_QUALn). A qualifier is split
+ *                  into groups of bits, each selecting one attribute of the
+ *                  request; an event is counted when it matches at least one
+ *                  set bit of every group. Setting all bits of a group makes
+ *                  it a "don't care". A qualifier of 0 selects a sensible
+ *                  default which counts every occurrence of the event.
+ *
+ * Every cluster has its own CM3 and therefore its own set of counters, and
+ * one PMU instance (mips_cm3_pmu_<cluster>) is registered per cluster. A
+ * cluster does not need CPUs, online or at all, for its L2 and memory
+ * interface to be busy, so the counters of other clusters are reached
+ * through the GCR redirect block from whichever CPU runs the PMU. This
+ * requires the CM of that cluster to be powered, which is checked in the
+ * CPC before an event is opened. A cluster holding CPUs powers down with
+ * the last of them; its PMU is then paused until one comes back.
+ *
+ * The counters are shared by the whole cluster, so events are system wide,
+ * pinned to a single CPU, and cannot be sampled.
+ */
+
+#define CM3_PMU_NAME	"mips_cm3_pmu"
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+#include <asm/cpu-info.h>
+#include <asm/mips-cps.h>
+
+/* Two programmable counters followed by the cycle counter */
+#define CM3_PMU_MAX_PCS			2
+#define CM3_PMU_IDX_CYCLES		CM3_PMU_MAX_PCS
+#define CM3_PMU_NUM_COUNTERS		(CM3_PMU_MAX_PCS + 1)
+#define CM3_PMU_COUNTER_MASK		GENMASK_ULL(31, 0)
+
+/*
+ * Without an overflow interrupt the 32-bit counters are read periodically.
+ * The fastest events count a couple of occurrences per CM clock cycle, so
+ * even at 2GHz a counter takes more than a second to wrap.
+ */
+#define CM3_PMU_POLL_PERIOD_NS		(250 * NSEC_PER_MSEC)
+
+/* Event numbers (GCR_DB_PC_EVENT.Px_Event) */
+#define CM3_PMU_EV_NONE			0x00
+#define CM3_PMU_EV_CM_REQ		0x01	/* Coherence Manager requests */
+#define CM3_PMU_EV_IO_REQ		0x02	/* I/O traffic requests (IOCU) */
+#define CM3_PMU_EV_MEM_REQ		0x03	/* Memory interface requests */
+#define CM3_PMU_EV_MEM_AXI		0x07	/* MEM AXI bus utilization */
+#define CM3_PMU_EV_IOCU_AXI(n)		(0x08 + (n)) /* IOCUn AXI bus utilization */
+#define CM3_PMU_EV_IOCU_AXI_LAST	CM3_PMU_EV_IOCU_AXI(7)
+#define CM3_PMU_EV_PDTRACE_DROPPED	0x11	/* CM PDTrace dropped messages */
+#define CM3_PMU_EV_PDTRACE_OVF_CYCLES	0x12	/* CM PDTrace overflow cycles */
+#define CM3_PMU_EV_HW_MASK		GENMASK(7, 0)
+/* Pseudo event selecting the cycle counter */
+#define CM3_PMU_EV_CYCLES		0x100
+#define CM3_PMU_EV_MASK			GENMASK(8, 0)
+
+/*
+ * Qualifier of the Coherence Manager Requests event. Ports are numbered
+ * with the cores first, followed by the IOCUs; port bit 8 is the prefetcher
+ * and bit 9 interventions.
+ */
+#define CM3_PMU_Q_CMREQ_PORT		GENMASK_ULL(9, 0)
+#define CM3_PMU_Q_CMREQ_THREAD		GENMASK_ULL(13, 10)
+#define CM3_PMU_Q_CMREQ_TARGET		GENMASK_ULL(15, 14)
+#define  CM3_PMU_Q_CMREQ_TARGET_MEM	BIT_ULL(14)
+#define  CM3_PMU_Q_CMREQ_TARGET_REGBUS	BIT_ULL(15)
+#define CM3_PMU_Q_CMREQ_CMD		GENMASK_ULL(39, 16)
+#define  CM3_PMU_Q_CMREQ_CMD_LEGACY_RD	BIT_ULL(16)
+#define  CM3_PMU_Q_CMREQ_CMD_LEGACY_WR	BIT_ULL(17)
+#define  CM3_PMU_Q_CMREQ_CMD_COH_WB	BIT_ULL(24)
+#define CM3_PMU_Q_CMREQ_CCA		GENMASK_ULL(42, 40) /* UC, UCA, other */
+#define CM3_PMU_Q_CMREQ_SIZE		GENMASK_ULL(44, 43) /* sub-line, line */
+#define CM3_PMU_Q_CMREQ_L1_STATE	GENMASK_ULL(47, 45) /* I, S, E/M */
+#define CM3_PMU_Q_CMREQ_L2_STATE	GENMASK_ULL(51, 48) /* I, S, E, M */
+#define  CM3_PMU_Q_CMREQ_L2_INVALID	BIT_ULL(48)
+#define CM3_PMU_Q_CMREQ_L2_LOCKED	GENMASK_ULL(53, 52)
+#define CM3_PMU_Q_CMREQ_EVICTION	GENMASK_ULL(56, 54)
+#define CM3_PMU_Q_CMREQ_BANK		GENMASK_ULL(58, 57)
+#define CM3_PMU_Q_CMREQ_SCHEDULER	GENMASK_ULL(60, 59)
+#define CM3_PMU_Q_CMREQ_RESERVED	GENMASK_ULL(63, 61) /* must be set */
+#define CM3_PMU_Q_CMREQ_DEFAULT		GENMASK_ULL(63, 0)
+
+/*
+ * Qualifier of the I/O Traffic Requests event. The IOCU number is an
+ * encoded value, not a mask. Direction bits: UC read, coherent read with
+ * allocate, coherent read without allocate, UC write, coherent write.
+ */
+#define CM3_PMU_Q_IO_IOCU		GENMASK_ULL(2, 0)
+#define CM3_PMU_Q_IO_DIR		GENMASK_ULL(7, 3)
+#define CM3_PMU_Q_IO_SIZE		GENMASK_ULL(15, 8)  /* 1 .. 128 bytes */
+#define CM3_PMU_Q_IO_LENGTH		GENMASK_ULL(24, 16) /* 1 .. 129-256 beats */
+#define CM3_PMU_Q_IO_ALIGNED		GENMASK_ULL(26, 25)
+#define CM3_PMU_Q_IO_PREFETCH		GENMASK_ULL(28, 27)
+#define CM3_PMU_Q_IO_ALL_DEVID		BIT_ULL(29)
+#define CM3_PMU_Q_IO_DEVID		GENMASK_ULL(35, 30)
+#define CM3_PMU_Q_IO_ALL_TXNID		BIT_ULL(36)
+#define CM3_PMU_Q_IO_TXNID		GENMASK_ULL(41, 37)
+#define CM3_PMU_Q_IO_DEFAULT		GENMASK_ULL(41, 3)  /* IOCU 0 */
+
+/* Qualifier of the Memory Interface Requests event */
+#define CM3_PMU_Q_MEM_DIR		GENMASK_ULL(1, 0)
+#define  CM3_PMU_Q_MEM_DIR_READ		BIT_ULL(0)
+#define  CM3_PMU_Q_MEM_DIR_WRITE	BIT_ULL(1)
+#define CM3_PMU_Q_MEM_SIZE		GENMASK_ULL(9, 2)   /* 1 .. 128 bytes */
+#define CM3_PMU_Q_MEM_LENGTH		GENMASK_ULL(17, 10) /* 0 .. 7 */
+#define CM3_PMU_Q_MEM_CCA		GENMASK_ULL(21, 18) /* UC, UCA, read discard, cacheable */
+#define CM3_PMU_Q_MEM_SOURCE		GENMASK_ULL(29, 22) /* input port */
+#define CM3_PMU_Q_MEM_THREAD		GENMASK_ULL(35, 32)
+#define CM3_PMU_Q_MEM_CODE_DATA		GENMASK_ULL(37, 36)
+#define CM3_PMU_Q_MEM_PREFETCH		GENMASK_ULL(39, 38)
+#define CM3_PMU_Q_MEM_ALL_GUESTID	BIT_ULL(40)
+#define CM3_PMU_Q_MEM_GUESTID		GENMASK_ULL(45, 41)
+#define CM3_PMU_Q_MEM_DEFAULT		GENMASK_ULL(45, 0)
+
+/* Qualifier of the AXI Bus Utilization events, counts cycles */
+#define CM3_PMU_Q_AXI_NOT_VALID		BIT_ULL(0)
+#define CM3_PMU_Q_AXI_VALID		BIT_ULL(1)
+#define CM3_PMU_Q_AXI_NOT_READY		BIT_ULL(2)
+#define CM3_PMU_Q_AXI_READY		BIT_ULL(3)
+#define CM3_PMU_Q_AXI_CHANNEL		GENMASK_ULL(6, 4)
+#define  CM3_PMU_Q_AXI_CHANNEL_AR	0
+#define  CM3_PMU_Q_AXI_CHANNEL_AW	1
+#define  CM3_PMU_Q_AXI_CHANNEL_W	2
+#define  CM3_PMU_Q_AXI_CHANNEL_R	3
+#define  CM3_PMU_Q_AXI_CHANNEL_B	4
+/* Completed transfers (VALID && READY) on a channel */
+#define CM3_PMU_Q_AXI_XFER(ch)		(FIELD_PREP_CONST(CM3_PMU_Q_AXI_CHANNEL, ch) | \
+					 CM3_PMU_Q_AXI_VALID | CM3_PMU_Q_AXI_READY)
+#define CM3_PMU_Q_AXI_DEFAULT		CM3_PMU_Q_AXI_XFER(CM3_PMU_Q_AXI_CHANNEL_AR)
+
+/* Qualifier of the CM PDTrace Dropped Messages event */
+#define CM3_PMU_Q_PDTRACE_PORT		GENMASK_ULL(5, 0)
+#define CM3_PMU_Q_PDTRACE_TYPE		GENMASK_ULL(7, 6)   /* request, response */
+#define CM3_PMU_Q_PDTRACE_DEFAULT	GENMASK_ULL(7, 0)
+
+/* Restrict a single qualifier group of a default qualifier to @bits */
+#define CM3_PMU_QUAL(def, group, bits)	(((def) & ~(group)) | (bits))
+
+struct cm3_pmu {
+	struct pmu		pmu;
+	struct hlist_node	node;
+	struct hrtimer		hrtimer;
+	struct perf_event	*events[CM3_PMU_NUM_COUNTERS];
+	struct mutex		init_lock;	/* serializes cm3_pmu_hw_init() */
+	bool			initialized;
+	bool			paused;		/* cluster CM powered down */
+	unsigned int		cluster;
+	unsigned int		num_pcs;
+	unsigned int		num_active;
+	int			on_cpu;
+	int			irq;
+};
+
+struct cm3_pmu_dev {
+	unsigned int		num_pmus;
+	struct cm3_pmu		pmus[] __counted_by(num_pmus);
+};
+
+#define to_cm3_pmu(p)	container_of(p, struct cm3_pmu, pmu)
+
+static int cm3_pmu_cpuhp_state;
+
+/* sysfs attributes */
+
+static ssize_t cm3_pmu_format_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
+}
+
+#define CM3_PMU_FORMAT_ATTR(_name, _config)				\
+	(&((struct dev_ext_attribute[]) {				\
+		{ .attr = __ATTR(_name, 0444, cm3_pmu_format_show, NULL), \
+		  .var = (void *)_config, }				\
+	})[0].attr.attr)
+
+static struct attribute *cm3_pmu_format_attrs[] = {
+	CM3_PMU_FORMAT_ATTR(event, "config:0-8"),
+	CM3_PMU_FORMAT_ATTR(qual, "config1:0-63"),
+	NULL
+};
+
+static const struct attribute_group cm3_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = cm3_pmu_format_attrs,
+};
+
+struct cm3_pmu_event_attr {
+	struct device_attribute	attr;
+	u16			event;
+	u64			qual;
+};
+
+static ssize_t cm3_pmu_event_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cm3_pmu_event_attr *eattr;
+
+	eattr = container_of(attr, struct cm3_pmu_event_attr, attr);
+	if (!eattr->qual)
+		return sysfs_emit(buf, "event=0x%x\n", eattr->event);
+
+	return sysfs_emit(buf, "event=0x%x,qual=0x%llx\n",
+			  eattr->event, eattr->qual);
+}
+
+#define CM3_PMU_EVENT_ATTR(_name, _event, _qual)			\
+	(&((struct cm3_pmu_event_attr[]) {				\
+		{ .attr = __ATTR(_name, 0444, cm3_pmu_event_show, NULL), \
+		  .event = _event, .qual = _qual, }			\
+	})[0].attr.attr)
+
+static struct attribute *cm3_pmu_event_attrs[] = {
+	CM3_PMU_EVENT_ATTR(cycles, CM3_PMU_EV_CYCLES, 0),
+
+	/* Requests serialized by the coherence manager */
+	CM3_PMU_EVENT_ATTR(cm_requests, CM3_PMU_EV_CM_REQ,
+			   CM3_PMU_Q_CMREQ_DEFAULT),
+	CM3_PMU_EVENT_ATTR(cm_requests_mem, CM3_PMU_EV_CM_REQ,
+			   CM3_PMU_QUAL(CM3_PMU_Q_CMREQ_DEFAULT,
+					CM3_PMU_Q_CMREQ_TARGET,
+					CM3_PMU_Q_CMREQ_TARGET_MEM)),
+	CM3_PMU_EVENT_ATTR(cm_requests_regbus, CM3_PMU_EV_CM_REQ,
+			   CM3_PMU_QUAL(CM3_PMU_Q_CMREQ_DEFAULT,
+					CM3_PMU_Q_CMREQ_TARGET,
+					CM3_PMU_Q_CMREQ_TARGET_REGBUS)),
+	CM3_PMU_EVENT_ATTR(cm_requests_legacy_read, CM3_PMU_EV_CM_REQ,
+			   CM3_PMU_QUAL(CM3_PMU_Q_CMREQ_DEFAULT,
+					CM3_PMU_Q_CMREQ_CMD,
+					CM3_PMU_Q_CMREQ_CMD_LEGACY_RD)),
+	CM3_PMU_EVENT_ATTR(cm_requests_legacy_write, CM3_PMU_EV_CM_REQ,
+			   CM3_PMU_QUAL(CM3_PMU_Q_CMREQ_DEFAULT,
+					CM3_PMU_Q_CMREQ_CMD,
+					CM3_PMU_Q_CMREQ_CMD_LEGACY_WR)),
+	CM3_PMU_EVENT_ATTR(cm_requests_coh_writeback, CM3_PMU_EV_CM_REQ,
+			   CM3_PMU_QUAL(CM3_PMU_Q_CMREQ_DEFAULT,
+					CM3_PMU_Q_CMREQ_CMD,
+					CM3_PMU_Q_CMREQ_CMD_COH_WB)),
+	/* Memory requests whose line is (not) present in the L2 */
+	CM3_PMU_EVENT_ATTR(cm_requests_l2_hit, CM3_PMU_EV_CM_REQ,
+			   CM3_PMU_QUAL(CM3_PMU_QUAL(CM3_PMU_Q_CMREQ_DEFAULT,
+						     CM3_PMU_Q_CMREQ_TARGET,
+						     CM3_PMU_Q_CMREQ_TARGET_MEM),
+					CM3_PMU_Q_CMREQ_L2_STATE,
+					CM3_PMU_Q_CMREQ_L2_STATE &
+					~CM3_PMU_Q_CMREQ_L2_INVALID)),
+	CM3_PMU_EVENT_ATTR(cm_requests_l2_miss, CM3_PMU_EV_CM_REQ,
+			   CM3_PMU_QUAL(CM3_PMU_QUAL(CM3_PMU_Q_CMREQ_DEFAULT,
+						     CM3_PMU_Q_CMREQ_TARGET,
+						     CM3_PMU_Q_CMREQ_TARGET_MEM),
+					CM3_PMU_Q_CMREQ_L2_STATE,
+					CM3_PMU_Q_CMREQ_L2_INVALID)),
+
+	/* Requests received by IOCU 0 */
+	CM3_PMU_EVENT_ATTR(iocu0_requests, CM3_PMU_EV_IO_REQ,
+			   CM3_PMU_Q_IO_DEFAULT),
+
+	/* Requests issued on the memory interface */
+	CM3_PMU_EVENT_ATTR(mem_requests, CM3_PMU_EV_MEM_REQ,
+			   CM3_PMU_Q_MEM_DEFAULT),
+	CM3_PMU_EVENT_ATTR(mem_reads, CM3_PMU_EV_MEM_REQ,
+			   CM3_PMU_QUAL(CM3_PMU_Q_MEM_DEFAULT,
+					CM3_PMU_Q_MEM_DIR,
+					CM3_PMU_Q_MEM_DIR_READ)),
+	CM3_PMU_EVENT_ATTR(mem_writes, CM3_PMU_EV_MEM_REQ,
+			   CM3_PMU_QUAL(CM3_PMU_Q_MEM_DEFAULT,
+					CM3_PMU_Q_MEM_DIR,
+					CM3_PMU_Q_MEM_DIR_WRITE)),
+
+	/* Transfers on each channel of the memory AXI bus */
+	CM3_PMU_EVENT_ATTR(mem_axi_ar, CM3_PMU_EV_MEM_AXI,
+			   CM3_PMU_Q_AXI_XFER(CM3_PMU_Q_AXI_CHANNEL_AR)),
+	CM3_PMU_EVENT_ATTR(mem_axi_aw, CM3_PMU_EV_MEM_AXI,
+			   CM3_PMU_Q_AXI_XFER(CM3_PMU_Q_AXI_CHANNEL_AW)),
+	CM3_PMU_EVENT_ATTR(mem_axi_w, CM3_PMU_EV_MEM_AXI,
+			   CM3_PMU_Q_AXI_XFER(CM3_PMU_Q_AXI_CHANNEL_W)),
+	CM3_PMU_EVENT_ATTR(mem_axi_r, CM3_PMU_EV_MEM_AXI,
+			   CM3_PMU_Q_AXI_XFER(CM3_PMU_Q_AXI_CHANNEL_R)),
+	CM3_PMU_EVENT_ATTR(mem_axi_b, CM3_PMU_EV_MEM_AXI,
+			   CM3_PMU_Q_AXI_XFER(CM3_PMU_Q_AXI_CHANNEL_B)),
+
+	CM3_PMU_EVENT_ATTR(pdtrace_dropped, CM3_PMU_EV_PDTRACE_DROPPED,
+			   CM3_PMU_Q_PDTRACE_DEFAULT),
+	CM3_PMU_EVENT_ATTR(pdtrace_overflow_cycles,
+			   CM3_PMU_EV_PDTRACE_OVF_CYCLES, 0),
+	NULL
+};
+
+static const struct attribute_group cm3_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = cm3_pmu_event_attrs,
+};
+
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct cm3_pmu *cm3_pmu = to_cm3_pmu(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%*pbl\n",
+			  cpumask_pr_args(cpumask_of(cm3_pmu->on_cpu)));
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *cm3_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static const struct attribute_group cm3_pmu_cpumask_attr_group = {
+	.attrs = cm3_pmu_cpumask_attrs,
+};
+
+static const struct attribute_group *cm3_pmu_attr_groups[] = {
+	&cm3_pmu_format_attr_group,
+	&cm3_pmu_events_attr_group,
+	&cm3_pmu_cpumask_attr_group,
+	NULL
+};
+
+/*
+ * Hardware access
+ *
+ * The debug block of the local cluster is accessed directly. That of another
+ * cluster is accessed through the redirect block, pointed at the debug block
+ * of the target cluster, from whichever CPU this runs on. Both paths are
+ * valid in any context; the redirect path takes the per-CPU redirect lock
+ * with interrupts disabled.
+ */
+
+static bool cm3_pmu_lock(struct cm3_pmu *cm3_pmu)
+{
+	preempt_disable();
+	if (cm3_pmu->cluster == cpu_cluster(&current_cpu_data))
+		return false;
+
+	mips_cm_lock_other(cm3_pmu->cluster, 0, 0, CM_GCR_Cx_OTHER_BLOCK_DEBUG);
+	return true;
+}
+
+static void cm3_pmu_unlock(bool other)
+{
+	if (other)
+		mips_cm_unlock_other();
+	preempt_enable();
+}
+
+#define CM3_PMU_READ(cm3_pmu, reg)					\
+({									\
+	bool __other = cm3_pmu_lock(cm3_pmu);				\
+	typeof(read_gcr_db_##reg()) __val;				\
+									\
+	__val = __other ? read_gcr_redir_db_##reg() : read_gcr_db_##reg(); \
+	cm3_pmu_unlock(__other);					\
+	__val;								\
+})
+
+#define CM3_PMU_WRITE(cm3_pmu, reg, val)				\
+do {									\
+	typeof(read_gcr_db_##reg()) __val = (val);			\
+	bool __other = cm3_pmu_lock(cm3_pmu);				\
+									\
+	if (__other)							\
+		write_gcr_redir_db_##reg(__val);			\
+	else								\
+		write_gcr_db_##reg(__val);				\
+	cm3_pmu_unlock(__other);					\
+} while (0)
+
+/*
+ * Whether the CM of the cluster is powered. The CPC is always powered and
+ * reports the CM power sequencer state in the STAT_CONF of its "CM core".
+ * Accessing the GCRs of a powered down cluster would fault.
+ */
+static bool cm3_pmu_cluster_powered(struct cm3_pmu *cm3_pmu)
+{
+	u32 stat;
+
+	/* No other cluster before CM 3.5, and ours is obviously powered */
+	if (cm3_pmu->cluster == cpu_cluster(&raw_current_cpu_data))
+		return true;
+
+	if (!mips_cpc_present())
+		return false;
+
+	mips_cm_lock_other(cm3_pmu->cluster, CM_GCR_Cx_OTHER_CORE_CM, 0,
+			   CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+	stat = read_cpc_co_stat_conf();
+	mips_cm_unlock_other();
+
+	return FIELD_GET(CPC_Cx_STAT_CONF_SEQSTATE, stat) ==
+	       CPC_Cx_STAT_CONF_SEQSTATE_U5;
+}
+
+static u32 cm3_pmu_counton_bit(int idx)
+{
+	switch (idx) {
+	case 0:
+		return CM_GCR_DB_PC_CTL_P0_COUNTON;
+	case 1:
+		return CM_GCR_DB_PC_CTL_P1_COUNTON;
+	default:
+		return CM_GCR_DB_PC_CTL_CYCL_CNT_COUNTON;
+	}
+}
+
+static u32 cm3_pmu_reset_bit(int idx)
+{
+	switch (idx) {
+	case 0:
+		return CM_GCR_DB_PC_CTL_P0_RESET;
+	case 1:
+		return CM_GCR_DB_PC_CTL_P1_RESET;
+	default:
+		return CM_GCR_DB_PC_CTL_CYCL_CNT_RESET;
+	}
+}
+
+static u32 cm3_pmu_overflow_bit(int idx)
+{
+	switch (idx) {
+	case 0:
+		return CM_GCR_DB_PC_OV_P0_OF;
+	case 1:
+		return CM_GCR_DB_PC_OV_P1_OF;
+	default:
+		return CM_GCR_DB_PC_OV_CYCL_CNT_OF;
+	}
+}
+
+static u32 cm3_pmu_read_counter(struct cm3_pmu *cm3_pmu, int idx)
+{
+	switch (idx) {
+	case 0:
+		return CM3_PMU_READ(cm3_pmu, pc_cnt0);
+	case 1:
+		return CM3_PMU_READ(cm3_pmu, pc_cnt1);
+	default:
+		return CM3_PMU_READ(cm3_pmu, pc_cycl);
+	}
+}
+
+static void cm3_pmu_program_counter(struct cm3_pmu *cm3_pmu, int idx,
+				    u32 event, u64 qual)
+{
+	u32 val = CM3_PMU_READ(cm3_pmu, pc_event);
+
+	if (idx == 0) {
+		val &= ~CM_GCR_DB_PC_EVENT_P0_EVENT;
+		val |= FIELD_PREP(CM_GCR_DB_PC_EVENT_P0_EVENT, event);
+		CM3_PMU_WRITE(cm3_pmu, pc_event, val);
+		CM3_PMU_WRITE(cm3_pmu, pc_qual0, qual);
+	} else {
+		val &= ~CM_GCR_DB_PC_EVENT_P1_EVENT;
+		val |= FIELD_PREP(CM_GCR_DB_PC_EVENT_P1_EVENT, event);
+		CM3_PMU_WRITE(cm3_pmu, pc_event, val);
+		CM3_PMU_WRITE(cm3_pmu, pc_qual1, qual);
+	}
+}
+
+static void cm3_pmu_set_ctl(struct cm3_pmu *cm3_pmu, u32 clear, u32 set)
+{
+	u32 val = CM3_PMU_READ(cm3_pmu, pc_ctl);
+
+	CM3_PMU_WRITE(cm3_pmu, pc_ctl, (val & ~clear) | set);
+}
+
+/* Stop everything, clear pending overflows, enable the interrupt if used */
+static void cm3_pmu_hw_reset(struct cm3_pmu *cm3_pmu)
+{
+	CM3_PMU_WRITE(cm3_pmu, pc_ctl,
+		      cm3_pmu->irq > 0 ? CM_GCR_DB_PC_CTL_PERF_INT_EN : 0);
+	CM3_PMU_WRITE(cm3_pmu, pc_event, 0);
+	CM3_PMU_WRITE(cm3_pmu, pc_ov, CM_GCR_DB_PC_OV_P1_OF |
+				      CM_GCR_DB_PC_OV_P0_OF |
+				      CM_GCR_DB_PC_OV_CYCL_CNT_OF);
+}
+
+/*
+ * Run @fn on the CPU the PMU is on, with interrupts disabled. This orders
+ * it with the perf callbacks and with the pause of the PMU, which precedes
+ * the power down of a cluster holding CPUs: a cluster seen unpaused there
+ * stays powered until @fn returns. That CPU may be on its way offline, in
+ * which case either @fn still runs on it, before the hotplug sequence can
+ * go on, or the call fails and is retried on the PMU's new CPU.
+ */
+static int cm3_pmu_call_on_cpu(struct cm3_pmu *cm3_pmu, smp_call_func_t fn,
+			       void *info)
+{
+	int cpu, ret;
+
+	do {
+		cpu = READ_ONCE(cm3_pmu->on_cpu);
+		if (cpu < 0)
+			return -ENODEV;
+
+		ret = smp_call_function_single(cpu, fn, info, 1);
+	} while (ret == -ENXIO);
+
+	return ret;
+}
+
+struct cm3_pmu_hw_init_args {
+	struct cm3_pmu *cm3_pmu;
+	int ret;
+};
+
+static void cm3_pmu_hw_init_on_cpu(void *data)
+{
+	struct cm3_pmu_hw_init_args *args = data;
+	struct cm3_pmu *cm3_pmu = args->cm3_pmu;
+
+	if (cm3_pmu->paused) {
+		args->ret = -ENODEV;
+		return;
+	}
+
+	cm3_pmu->num_pcs = FIELD_GET(CM_GCR_DB_PC_CTL_PERF_NUM_CNT,
+				     CM3_PMU_READ(cm3_pmu, pc_ctl));
+	cm3_pmu->num_pcs = min_t(unsigned int, cm3_pmu->num_pcs,
+				 CM3_PMU_MAX_PCS);
+	cm3_pmu_hw_reset(cm3_pmu);
+	cm3_pmu->initialized = true;
+	args->ret = 0;
+}
+
+/*
+ * Check that the cluster is powered, and bring its counters to a known
+ * state the first time they are needed: the CM may not have been powered
+ * at probe time. A later power cycle puts the registers back to their
+ * reset values, with the counters stopped, so there is nothing to redo.
+ *
+ * The CPC check is all there is for a cluster without CPUs, whose power is
+ * not in the hands of this kernel. For a cluster with CPUs the pause flag
+ * is authoritative, and is consulted where it cannot change under us.
+ */
+static int cm3_pmu_hw_init(struct cm3_pmu *cm3_pmu)
+{
+	struct cm3_pmu_hw_init_args args = { .cm3_pmu = cm3_pmu };
+	int ret;
+
+	guard(mutex)(&cm3_pmu->init_lock);
+
+	if (!cm3_pmu_cluster_powered(cm3_pmu))
+		return -ENODEV;
+
+	if (cm3_pmu->initialized)
+		return 0;
+
+	ret = cm3_pmu_call_on_cpu(cm3_pmu, cm3_pmu_hw_init_on_cpu, &args);
+
+	return ret ?: args.ret;
+}
+
+static u64 cm3_pmu_default_qual(u32 event)
+{
+	switch (event) {
+	case CM3_PMU_EV_CM_REQ:
+		return CM3_PMU_Q_CMREQ_DEFAULT;
+	case CM3_PMU_EV_IO_REQ:
+		return CM3_PMU_Q_IO_DEFAULT;
+	case CM3_PMU_EV_MEM_REQ:
+		return CM3_PMU_Q_MEM_DEFAULT;
+	case CM3_PMU_EV_MEM_AXI:
+	case CM3_PMU_EV_IOCU_AXI(0) ... CM3_PMU_EV_IOCU_AXI_LAST:
+		return CM3_PMU_Q_AXI_DEFAULT;
+	case CM3_PMU_EV_PDTRACE_DROPPED:
+		return CM3_PMU_Q_PDTRACE_DEFAULT;
+	default:
+		/* All qualifier groups set to "don't care" */
+		return GENMASK_ULL(63, 0);
+	}
+}
+
+/* perf callbacks */
+
+static void cm3_pmu_update(struct perf_event *event)
+{
+	struct cm3_pmu *cm3_pmu = to_cm3_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u32 ov_bit = cm3_pmu_overflow_bit(hwc->idx);
+	u64 delta, prev, new;
+	bool overflowed = false;
+
+	/* Counts were harvested when the cluster went down, nothing since */
+	if (READ_ONCE(cm3_pmu->paused))
+		return;
+
+	/*
+	 * When polling, the counter cannot wrap twice between two reads and
+	 * the 32-bit difference tells the whole story. With the overflow
+	 * interrupt the counter is only read on demand and may have made a
+	 * full turn since the last read, which the overflow status tells.
+	 * It is read and cleared before the counter so that a wrap seen
+	 * here is also reflected in the counter value; a wrap happening in
+	 * between is accounted by the next update, which the interrupt it
+	 * raises makes sure happens. In interrupt mode every access to the
+	 * event runs on cm3_pmu->on_cpu with interrupts disabled, so the
+	 * status and the counter are read consistently.
+	 */
+	if (cm3_pmu->irq > 0) {
+		overflowed = CM3_PMU_READ(cm3_pmu, pc_ov) & ov_bit;
+		if (overflowed)
+			CM3_PMU_WRITE(cm3_pmu, pc_ov, ov_bit);
+	}
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+		new = cm3_pmu_read_counter(cm3_pmu, hwc->idx);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, new) != prev);
+
+	/*
+	 * If the counter wrapped and now shows a value not below the
+	 * previous one, it made a full turn on top of the 32-bit difference.
+	 */
+	delta = (new - prev) & CM3_PMU_COUNTER_MASK;
+	if (overflowed && new >= prev)
+		delta += CM3_PMU_COUNTER_MASK + 1;
+
+	local64_add(delta, &event->count);
+}
+
+/* Program the counter of the event and start it from zero */
+static void cm3_pmu_start_counter(struct cm3_pmu *cm3_pmu,
+				  struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	if (idx != CM3_PMU_IDX_CYCLES)
+		cm3_pmu_program_counter(cm3_pmu, idx, hwc->config,
+					hwc->config1);
+
+	/*
+	 * Setting the reset bit together with the count-on bit resets the
+	 * counter and its overflow status before counting is started.
+	 */
+	local64_set(&hwc->prev_count, 0);
+	cm3_pmu_set_ctl(cm3_pmu, 0,
+			cm3_pmu_reset_bit(idx) | cm3_pmu_counton_bit(idx));
+}
+
+static void cm3_pmu_start(struct perf_event *event, int flags)
+{
+	struct cm3_pmu *cm3_pmu = to_cm3_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	hwc->state = 0;
+
+	/* A paused PMU starts its running events when the cluster is back */
+	if (!cm3_pmu->paused)
+		cm3_pmu_start_counter(cm3_pmu, event);
+
+	perf_event_update_userpage(event);
+}
+
+static void cm3_pmu_stop(struct perf_event *event, int flags)
+{
+	struct cm3_pmu *cm3_pmu = to_cm3_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	if (!cm3_pmu->paused)
+		cm3_pmu_set_ctl(cm3_pmu, cm3_pmu_counton_bit(hwc->idx), 0);
+
+	cm3_pmu_update(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int cm3_pmu_add(struct perf_event *event, int flags)
+{
+	struct cm3_pmu *cm3_pmu = to_cm3_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	if (hwc->config == CM3_PMU_EV_CYCLES) {
+		idx = CM3_PMU_IDX_CYCLES;
+		if (cm3_pmu->events[idx])
+			return -EAGAIN;
+	} else {
+		for (idx = 0; idx < cm3_pmu->num_pcs; idx++)
+			if (!cm3_pmu->events[idx])
+				break;
+		if (idx == cm3_pmu->num_pcs)
+			return -EAGAIN;
+	}
+
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	cm3_pmu->events[idx] = event;
+
+	/* No polling while the cluster is down, resume takes care of it */
+	if (!cm3_pmu->num_active++ && cm3_pmu->irq <= 0 && !cm3_pmu->paused)
+		hrtimer_start(&cm3_pmu->hrtimer,
+			      ns_to_ktime(CM3_PMU_POLL_PERIOD_NS),
+			      HRTIMER_MODE_REL_PINNED);
+
+	if (flags & PERF_EF_START)
+		cm3_pmu_start(event, PERF_EF_RELOAD);
+
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void cm3_pmu_del(struct perf_event *event, int flags)
+{
+	struct cm3_pmu *cm3_pmu = to_cm3_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	cm3_pmu_stop(event, PERF_EF_UPDATE);
+
+	cm3_pmu->events[hwc->idx] = NULL;
+	if (!--cm3_pmu->num_active && cm3_pmu->irq <= 0)
+		hrtimer_cancel(&cm3_pmu->hrtimer);
+
+	perf_event_update_userpage(event);
+}
+
+static void cm3_pmu_count_group_event(struct perf_event *event,
+				      struct perf_event *member,
+				      unsigned int *cycles, unsigned int *pcs)
+{
+	if (member->pmu != event->pmu)
+		return;
+
+	if (member->hw.config == CM3_PMU_EV_CYCLES)
+		(*cycles)++;
+	else
+		(*pcs)++;
+}
+
+static bool cm3_pmu_validate_group(struct perf_event *event)
+{
+	struct cm3_pmu *cm3_pmu = to_cm3_pmu(event->pmu);
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling;
+	unsigned int cycles = 0, pcs = 0;
+
+	cm3_pmu_count_group_event(event, event, &cycles, &pcs);
+
+	/* A new leader has no siblings yet, and no context to assert on */
+	if (leader == event)
+		return pcs <= cm3_pmu->num_pcs;
+
+	/* Hardware events of the group must all be ours */
+	if (leader->pmu != event->pmu && !is_software_event(leader))
+		return false;
+
+	cm3_pmu_count_group_event(event, leader, &cycles, &pcs);
+
+	for_each_sibling_event(sibling, leader) {
+		if (sibling->pmu != event->pmu && !is_software_event(sibling))
+			return false;
+
+		cm3_pmu_count_group_event(event, sibling, &cycles, &pcs);
+	}
+
+	return cycles <= 1 && pcs <= cm3_pmu->num_pcs;
+}
+
+static int cm3_pmu_event_init(struct perf_event *event)
+{
+	struct cm3_pmu *cm3_pmu = to_cm3_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 config = event->attr.config;
+	int ret;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* Counters are shared by all CPUs: no sampling, no per-task events */
+	if (is_sampling_event(event) ||
+	    event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	if (config & ~CM3_PMU_EV_MASK)
+		return -EINVAL;
+
+	if (config != CM3_PMU_EV_CYCLES &&
+	    (config & ~CM3_PMU_EV_HW_MASK || config == CM3_PMU_EV_NONE))
+		return -EINVAL;
+
+	/* The cluster's CM must be powered for its counters to be usable */
+	if (READ_ONCE(cm3_pmu->paused))
+		return -ENODEV;
+
+	ret = cm3_pmu_hw_init(cm3_pmu);
+	if (ret)
+		return ret;
+
+	hwc->idx = -1;
+	hwc->config = config;
+	hwc->config1 = event->attr.config1 ?: cm3_pmu_default_qual(config);
+
+	/* Group validation looks at hwc->config of every member, ours too */
+	if (!cm3_pmu_validate_group(event))
+		return -EINVAL;
+
+	event->cpu = cm3_pmu->on_cpu;
+
+	return 0;
+}
+
+static enum hrtimer_restart cm3_pmu_poll(struct hrtimer *hrtimer)
+{
+	struct cm3_pmu *cm3_pmu = container_of(hrtimer, struct cm3_pmu,
+					       hrtimer);
+	int idx;
+
+	/*
+	 * Nothing to poll while the cluster is down, resume re-arms the
+	 * timer. The timer may run on another CPU than the pause did.
+	 */
+	if (READ_ONCE(cm3_pmu->paused))
+		return HRTIMER_NORESTART;
+
+	for (idx = 0; idx < CM3_PMU_NUM_COUNTERS; idx++) {
+		struct perf_event *event = cm3_pmu->events[idx];
+
+		if (event && !(event->hw.state & PERF_HES_STOPPED))
+			cm3_pmu_update(event);
+	}
+
+	hrtimer_forward_now(hrtimer, ns_to_ktime(CM3_PMU_POLL_PERIOD_NS));
+
+	return HRTIMER_RESTART;
+}
+
+static irqreturn_t cm3_pmu_handle_irq(int irq, void *data)
+{
+	struct cm3_pmu *cm3_pmu = data;
+	u32 ov = CM3_PMU_READ(cm3_pmu, pc_ov);
+	int idx;
+
+	if (!ov)
+		return IRQ_NONE;
+
+	/*
+	 * Status bits are write-1-to-clear and clearing them deasserts the
+	 * interrupt. cm3_pmu_update() clears the bit of the counter it
+	 * accounts; only bits of counters without an event are left over.
+	 */
+	for (idx = 0; idx < CM3_PMU_NUM_COUNTERS; idx++) {
+		struct perf_event *event = cm3_pmu->events[idx];
+
+		if (!(ov & cm3_pmu_overflow_bit(idx)))
+			continue;
+
+		if (event)
+			cm3_pmu_update(event);
+		else
+			CM3_PMU_WRITE(cm3_pmu, pc_ov, cm3_pmu_overflow_bit(idx));
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * CPU hotplug
+ *
+ * Besides following the CPU the PMUs run on, this tracks the power state of
+ * the clusters holding CPUs. Once Linux has booted a cluster it leaves
+ * CPC_PWRUP_CTL.CM_PWRUP clear, so that the CM powers down together with
+ * the last of its cores, taking the counters with it. The PMU of such a
+ * cluster is paused when its last CPU goes offline: the counts are
+ * harvested, the running events stop counting but keep their state, and no
+ * new event can be opened on it. It resumes when a CPU of the cluster comes
+ * back online, the CM having been powered up for it.
+ *
+ * The pause and resume run on cm3_pmu->on_cpu with interrupts disabled,
+ * like the perf callbacks, so they cannot race with them. As the pause
+ * happens before the last CPU of the cluster dies, and thus before the CM
+ * can power down, code running on cm3_pmu->on_cpu with interrupts disabled
+ * that finds the PMU unpaused can rely on the cluster staying powered.
+ */
+
+static void cm3_pmu_pause(void *data)
+{
+	struct cm3_pmu *cm3_pmu = data;
+	int idx;
+
+	for (idx = 0; idx < CM3_PMU_NUM_COUNTERS; idx++) {
+		struct perf_event *event = cm3_pmu->events[idx];
+
+		if (event && !(event->hw.state & PERF_HES_STOPPED))
+			cm3_pmu_update(event);
+	}
+
+	WRITE_ONCE(cm3_pmu->paused, true);
+}
+
+static void cm3_pmu_resume(void *data)
+{
+	struct cm3_pmu *cm3_pmu = data;
+	int idx;
+
+	WRITE_ONCE(cm3_pmu->paused, false);
+
+	/* The registers are back to their reset values; make sure of it */
+	cm3_pmu_hw_reset(cm3_pmu);
+
+	for (idx = 0; idx < CM3_PMU_NUM_COUNTERS; idx++) {
+		struct perf_event *event = cm3_pmu->events[idx];
+
+		if (event && !(event->hw.state & PERF_HES_STOPPED))
+			cm3_pmu_start_counter(cm3_pmu, event);
+	}
+
+	/*
+	 * Restart polling if the pause stopped it. Running here, on
+	 * cm3_pmu->on_cpu, also pins the timer to the CPU the PMU is on.
+	 */
+	if (cm3_pmu->num_active && cm3_pmu->irq <= 0)
+		hrtimer_start(&cm3_pmu->hrtimer,
+			      ns_to_ktime(CM3_PMU_POLL_PERIOD_NS),
+			      HRTIMER_MODE_REL_PINNED);
+}
+
+/* Whether another online CPU than @cpu lives in @cluster */
+static bool cm3_pmu_cluster_has_other_cpus(unsigned int cluster,
+					   unsigned int cpu)
+{
+	unsigned int c;
+
+	for_each_online_cpu(c)
+		if (c != cpu && cpu_cluster(&cpu_data[c]) == cluster)
+			return true;
+
+	return false;
+}
+
+/*
+ * Whether the CM of the local cluster is kept powered when all its cores
+ * power down. Must run on a CPU of that cluster, as the hotplug callbacks
+ * do. Without a CPC, or before clusters, nothing powers the CM down.
+ */
+static bool cm3_pmu_cluster_stays_powered(void)
+{
+	if (mips_cm_revision() < CM_REV_CM3_5 || !mips_cpc_present())
+		return true;
+
+	return read_cpc_pwrup_ctl() & CPC_PWRUP_CTL_CM_PWRUP;
+}
+
+static int cm3_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct cm3_pmu *cm3_pmu = hlist_entry_safe(node, struct cm3_pmu, node);
+	unsigned int cluster = cpu_cluster(&cpu_data[cpu]);
+
+	if (cm3_pmu->on_cpu < 0) {
+		cm3_pmu->on_cpu = cpu;
+		if (cm3_pmu->irq > 0)
+			WARN_ON(irq_set_affinity(cm3_pmu->irq, cpumask_of(cpu)));
+	}
+
+	/* First CPU of the cluster back: its CM is powered again */
+	if (cm3_pmu->cluster == cluster && cm3_pmu->paused &&
+	    !cm3_pmu_cluster_has_other_cpus(cluster, cpu))
+		smp_call_function_single(cm3_pmu->on_cpu, cm3_pmu_resume,
+					 cm3_pmu, 1);
+
+	return 0;
+}
+
+static int cm3_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct cm3_pmu *cm3_pmu = hlist_entry_safe(node, struct cm3_pmu, node);
+	unsigned int cluster = cpu_cluster(&cpu_data[cpu]);
+	unsigned int target;
+
+	if (cm3_pmu->on_cpu == cpu) {
+		target = cpumask_any_but(cpu_online_mask, cpu);
+		if (target >= nr_cpu_ids) {
+			cm3_pmu->on_cpu = -1;
+			return 0;
+		}
+
+		perf_pmu_migrate_context(&cm3_pmu->pmu, cpu, target);
+		cm3_pmu->on_cpu = target;
+		if (cm3_pmu->irq > 0)
+			WARN_ON(irq_set_affinity(cm3_pmu->irq,
+						 cpumask_of(target)));
+	}
+
+	/* Last CPU of the cluster going: its CM may follow */
+	if (cm3_pmu->cluster == cluster && !cm3_pmu->paused &&
+	    !cm3_pmu_cluster_has_other_cpus(cluster, cpu) &&
+	    !cm3_pmu_cluster_stays_powered()) {
+		smp_call_function_single(cm3_pmu->on_cpu, cm3_pmu_pause,
+					 cm3_pmu, 1);
+		/*
+		 * The poll timer may have been migrated away from the PMU's
+		 * CPU by an earlier hotplug and be running right now; wait
+		 * for it. Resume starts it again.
+		 */
+		hrtimer_cancel(&cm3_pmu->hrtimer);
+	}
+
+	return 0;
+}
+
+/* Platform driver */
+
+/* Leave the counters stopped, overflow interrupt disabled */
+static void cm3_pmu_hw_exit_on_cpu(void *data)
+{
+	struct cm3_pmu *cm3_pmu = data;
+
+	if (cm3_pmu->paused)
+		return;
+
+	cm3_pmu->irq = 0;
+	cm3_pmu_hw_reset(cm3_pmu);
+}
+
+static void cm3_pmu_unregister(struct cm3_pmu *cm3_pmu)
+{
+	perf_pmu_unregister(&cm3_pmu->pmu);
+
+	/* While the hotplug callbacks still track the cluster's power */
+	if (cm3_pmu->initialized && cm3_pmu_cluster_powered(cm3_pmu))
+		cm3_pmu_call_on_cpu(cm3_pmu, cm3_pmu_hw_exit_on_cpu, cm3_pmu);
+
+	cpuhp_state_remove_instance_nocalls(cm3_pmu_cpuhp_state,
+					    &cm3_pmu->node);
+	hrtimer_cancel(&cm3_pmu->hrtimer);
+}
+
+static int cm3_pmu_register(struct device *dev, struct cm3_pmu *cm3_pmu)
+{
+	const char *name;
+	int ret;
+
+	cm3_pmu->on_cpu = -1;
+	cm3_pmu->num_pcs = CM3_PMU_MAX_PCS;
+	mutex_init(&cm3_pmu->init_lock);
+	hrtimer_setup(&cm3_pmu->hrtimer, cm3_pmu_poll, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+
+	cm3_pmu->pmu = (struct pmu) {
+		.parent		= dev,
+		.module		= THIS_MODULE,
+		.task_ctx_nr	= perf_invalid_context,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE |
+				  PERF_PMU_CAP_NO_INTERRUPT,
+		.event_init	= cm3_pmu_event_init,
+		.add		= cm3_pmu_add,
+		.del		= cm3_pmu_del,
+		.start		= cm3_pmu_start,
+		.stop		= cm3_pmu_stop,
+		.read		= cm3_pmu_update,
+		.attr_groups	= cm3_pmu_attr_groups,
+	};
+
+	name = devm_kasprintf(dev, GFP_KERNEL, CM3_PMU_NAME "_%u",
+			      cm3_pmu->cluster);
+	if (!name)
+		return -ENOMEM;
+
+	/* Picks the CPU the PMU runs on, needed by cm3_pmu_hw_init() */
+	ret = cpuhp_state_add_instance(cm3_pmu_cpuhp_state, &cm3_pmu->node);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register hotplug\n");
+
+	/* Initialize now if the cluster is powered, else on first use */
+	ret = cm3_pmu_hw_init(cm3_pmu);
+	if (ret && ret != -ENODEV)
+		goto err_remove_instance;
+
+	ret = perf_pmu_register(&cm3_pmu->pmu, name, -1);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to register %s\n", name);
+		goto err_remove_instance;
+	}
+
+	if (cm3_pmu->initialized)
+		dev_info(dev, "%s: %u counters + cycles, %s\n", name,
+			 cm3_pmu->num_pcs,
+			 cm3_pmu->irq > 0 ? "overflow interrupt" : "polled");
+	else
+		dev_info(dev, "%s: cluster powered down\n", name);
+
+	return 0;
+
+err_remove_instance:
+	cpuhp_state_remove_instance_nocalls(cm3_pmu_cpuhp_state,
+					    &cm3_pmu->node);
+
+	return ret;
+}
+
+static int cm3_pmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cm3_pmu_dev *cm3_dev;
+	unsigned int nclusters, i;
+	int irq, ret;
+
+	if (!mips_cm_present() || mips_cm_revision() < CM_REV_CM3)
+		return -ENODEV;
+
+	/* One PMU per cluster, whether or not it holds CPUs */
+	nclusters = mips_cps_numclusters();
+	cm3_dev = devm_kzalloc(dev, struct_size(cm3_dev, pmus, nclusters),
+			       GFP_KERNEL);
+	if (!cm3_dev)
+		return -ENOMEM;
+
+	cm3_dev->num_pmus = nclusters;
+	for (i = 0; i < nclusters; i++)
+		cm3_dev->pmus[i].cluster = i;
+
+	/*
+	 * Each cluster's CM raises its own overflow interrupt into its own
+	 * GIC, and a GIC shared interrupt is routed to a single cluster at a
+	 * time (the one of its affinity CPU). The interrupt can therefore
+	 * only serve the cluster the CPUs live in, and only if they all live
+	 * in that one cluster so that any CPU may handle it. Other clusters
+	 * are polled.
+	 */
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq > 0 && !mips_cps_multicluster_cpus()) {
+		struct cm3_pmu *cm3_pmu;
+
+		cm3_pmu = &cm3_dev->pmus[cpu_cluster(&boot_cpu_data)];
+		ret = devm_request_irq(dev, irq, cm3_pmu_handle_irq,
+				       IRQF_NOBALANCING | IRQF_NO_THREAD,
+				       CM3_PMU_NAME, cm3_pmu);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to request IRQ\n");
+
+		cm3_pmu->irq = irq;
+	} else if (irq > 0) {
+		dev_info(dev, "CPUs in several clusters: overflow interrupt not usable, polling\n");
+	} else if (irq != -ENXIO) {
+		return dev_err_probe(dev, irq, "failed to get IRQ\n");
+	}
+
+	for (i = 0; i < cm3_dev->num_pmus; i++) {
+		ret = cm3_pmu_register(dev, &cm3_dev->pmus[i]);
+		if (ret)
+			goto err_unregister;
+	}
+
+	platform_set_drvdata(pdev, cm3_dev);
+
+	return 0;
+
+err_unregister:
+	while (i--)
+		cm3_pmu_unregister(&cm3_dev->pmus[i]);
+
+	return ret;
+}
+
+static void cm3_pmu_remove(struct platform_device *pdev)
+{
+	struct cm3_pmu_dev *cm3_dev = platform_get_drvdata(pdev);
+	unsigned int i;
+
+	for (i = 0; i < cm3_dev->num_pmus; i++)
+		cm3_pmu_unregister(&cm3_dev->pmus[i]);
+}
+
+static const struct of_device_id cm3_pmu_of_match[] = {
+	{ .compatible = "mti,mips-cm" },
+	{ .compatible = "mobileye,eyeq6-cm" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cm3_pmu_of_match);
+
+static struct platform_driver cm3_pmu_driver = {
+	.driver = {
+		.name = CM3_PMU_NAME,
+		.of_match_table = cm3_pmu_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = cm3_pmu_probe,
+	.remove = cm3_pmu_remove,
+};
+
+static int __init cm3_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "perf/mips/cm3_pmu:online",
+				      cm3_pmu_online_cpu, cm3_pmu_offline_cpu);
+	if (ret < 0)
+		return ret;
+
+	cm3_pmu_cpuhp_state = ret;
+
+	ret = platform_driver_register(&cm3_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(cm3_pmu_cpuhp_state);
+
+	return ret;
+}
+module_init(cm3_pmu_init);
+
+static void __exit cm3_pmu_exit(void)
+{
+	platform_driver_unregister(&cm3_pmu_driver);
+	cpuhp_remove_multi_state(cm3_pmu_cpuhp_state);
+}
+module_exit(cm3_pmu_exit);
+
+MODULE_DESCRIPTION("MIPS Coherence Manager 3 (CM3) PMU driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

