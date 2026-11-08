Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144038;
	b=m0A2myWNaw/MDzTnR2JeObsSap1ncfA1yqCvOEbISAUDBs8d+VVpIV2V9S+KTCyTdoDL
	 YcF6L2O+rSiFgYUCt0tsmm9n1vrchUGRDTYI9jniCWEf92YCsGm8F/KAgVswisPHZPm6V
	 jGvN0Ts8s1NG9CpePoaz76XI7d+mFgwlUxbKXWadYBpMHyDPIcO4UJ8aZIrhT0N/FQ3gr
	 +JgZkYHQg0i6Jyta5zwOg3ok9t4JkLW/4L9t6hIrZ/P22zSzSFsHqjgGfXNBMVQcyTAuL
	 wYRayuDKnbN6olIAmf2mH0qKe3lm6w7/TWPlGKINp5vFUPbaY8peOvUh2RylfdWHOlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144038;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=NMaYDAFbFDHoZRuN5JaVw6zHt8W9tmMQG3Imac9QJIc=;
	b=tilM3pcFcmKEn/mfcw3aUGzbUufbeElKKwNOtgnLyXlKR0GtRuTNPZXfg0wNxBhS0b/A
	 s05cTu5RCkzPib6Bv11fkF2VOgIwqU3c4fZ3H/WTI4LVFf503EXlK4RCd1mcsSHG3s+Vo
	 RXCNiLaTJw5tN5Em6gaJWg3fvd24g5NARqiHXAnuhOdEcd6UGX43eGxjfVdEIlbP3yLD/
	 CFTf4XtGS+fCpH24O2F2JMGJh7DSw3l/36e1isl2qm/v4xwtSPCcYTKMXHiLryWYlTtXM
	 0o7Tt9ldRzVRHFyIDR4AfIttl5RrT8KAHjLcnVSJS96CaJKrQGag17L4CU0Js3LS7tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E0606A320;
	Sun,  8 Nov 2026 13:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 976E0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794144034; x=1825680034;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=FrEnwb0WNypyTVTEhplcLKt7FgICC0VSO8uTuYeBtlY=;
  b=ASMvktqLjd92lp3vM+NQpJfXq6HqxAhoBz7i0KtEJbo/Jsby6NSiatTZ
   CMQv9kTjE33MgmU7rPVUXlP2uZkVGCEjyOk9cc1jwMS/2MCKwwWUqNpIk
   QIw8DImeBMJrJQFISt7N1OuCM4frqvzZMwcTF/lXzx8LwOSWScAqCe7UP
   N4IHD3Drn6mzk+TgmSGxCqxQjY5nuBD8twFF4ePkBeiWvnmoTSrmwWmXo
   +ne7wn9LDe4MhTO4IirCpXHXxDc4LNLGH4QuOot6ixAIMFPsQ6G8yCTUM
   gm5RaSINoHOEhUrSJHX0BsYSY5avfnI4X3lpDerKu7aa8+Yui1zzEylcw
   g==;
X-CSE-ConnectionGUID: 2x4g6s2ITqGDO7ABlUHd6w==
X-CSE-MsgGUID: hdpbPu10QDGmjwuBjlONDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 15:20:25 +0200
X-CSE-ConnectionGUID: 4izjUNGfSYOzPytRPXsd3A==
X-CSE-MsgGUID: SQGFD0xOSvydhC8Mpc344w==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 08 Nov 2026 15:28:27 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Sun, 08 Nov 2026 15:20:24 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: [PATCH 0/5] perf: add PMU driver for the MIPS Coherence Manager 3
 performance counters
Date: Sun, 08 Nov 2026 15:20:09 +0200
Message-Id: <20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com>
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
X-B4-Tracking: v=1; b=H4sIAAp38GoC/yXMzQ5FQAxA4VeRrm+T1iDhVeQuGEUlfjKDSMS7G
 yy/xTkneHEqHoroBCe7ep2nAP5FYPtq6gS1CYaY4oyZGDVLidCOBpdxw6Ribk2e14khCM3ipNX
 j/ZX/z36rB7HrM4HrugFuq936cQAAAA==
X-Change-ID: 20261101-i6500-cm3-pmu-4a11f399b430
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Fu Chao-Ying <chao-ying.fu@globalfoundries.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

The Coherence Manager 3 (CM3) of the MIPS I6500 multiprocessing system
is the point where the requests of all cores, I/O coherence units and
the hardware prefetcher are serialized before reaching the shared L2
cache and the memory interface. It carries a small set of performance
counters which observe this traffic: two programmable 32-bit event
counters and a 32-bit cycle counter, programmed through the GCR global
debug block (GCR_DB_PC_*).

The counters can count requests serialized by the CM, requests received
by an IOCU, requests issued on the memory interface, AXI handshake
cycles on the memory and IOCU buses, and PDTrace statistics. Each event
is refined by a 64-bit qualifier made of groups of bits (originating
port, thread, command, cacheability, L1/L2 line state, eviction, bank,
scheduler, ...): a request is counted when it matches a set bit in
every group, so the same event can be narrowed down to, for example,
L2 misses caused by coherent reads from core 1.

This is the only visibility into the L2 and the memory interface that
the I6500 offers; the per-core counters stop at the L1. It is the
natural place to attribute memory bandwidth to cores and IOCUs, or to
measure the L2 hit rate of a workload, on SoCs such as the Mobileye
EyeQ6H.

This series adds an uncore perf driver for these counters.

Design notes
------------

The driver binds to the existing coherency-manager device tree node
("mti,mips-cm" / "mobileye,eyeq6-cm") and reuses the GCR mapping
already set up by mips_cm_probe(), so no new reg property is needed:
the GCR base is discovered from CP0 CMGCRBase as for everything else in
the CM. The register definitions go into asm/mips-cm.h next to the
other GCRs, following the existing accessor scheme.

Events are described by two fields: 'event' (config:0-8) is the number
written to GCR_DB_PC_EVENT, with 0x100 as a pseudo event selecting the
cycle counter, and 'qual' (config1:0-63) is the raw qualifier. A
qualifier of 0 picks a per-event default counting every occurrence;
this matters for the I/O and AXI events, whose qualifiers contain
encoded values (IOCU number, AXI channel) rather than masks, so "all
ones" is not a sensible default there. Named events cover the common
combinations and, since they are plain event=/qual= strings, serve as
templates for custom qualifiers.

A multi-cluster system has one CM3, and thus one set of counters, per
cluster. The number of clusters comes from GCR_CONFIG and one PMU is
registered per cluster, named mips_cm3_pmu_<cluster>. A cluster need
not have CPUs, online or at all, for its CM to be busy: its L2 and
memory interface may serve the I/O devices behind its IOCUs while its
cores are absent or powered down. The counters of a cluster are thus
accessed through the GCR redirect block (GCR_Cx_OTHER with BLOCK set
to the debug block) from whichever CPU the PMU runs on, which may be in
any cluster. The one thing required is that the CM of the counted
cluster is powered, which the driver checks in the CPC (the CM "core"
STAT_CONF sequencer state) when an event is opened; the counters of a
cluster that is powered down at probe time are initialized on first
use, and events on it fail with -ENODEV until then. The counters are
shared by the whole cluster: events are system-wide only, pinned to one
CPU which follows CPU hotplug, and sampling, task events and the
exclude_* attributes are rejected.

Overflow is where the SoC integration leaks in. The CM3 has a
so_cm_perf_cnt_int output, but whether it is wired to a GIC input is
the integrator's choice and is not discoverable. The binding therefore
gains an optional 'interrupts' property: when present the driver uses
it to extend the 32-bit counters, otherwise it polls them every 250 ms,
which is comfortably below the time the fastest event needs to wrap
at the CM3 clock rates. Both paths yield 64-bit counts. No DTS change
is included because the EyeQ6H routing of that signal is not documented
on my side; the driver works in polling mode without it.

The interrupt can only serve the cluster the CPUs live in, and only
when they all live in that one cluster. Each cluster's CM drives its
own interrupt output into its own GIC, and the GIC driver routes a
shared interrupt to the cluster of its affinity CPU, so a single
'interrupts' entry cannot serve several clusters at once. The PMUs of
the other clusters, and all PMUs when CPUs are spread over clusters,
are polled.

The driver can be built as a module. That requires exporting
mips_gcr_base, mips_cpc_base, mips_cm_{lock,unlock}_other() and, less
obviously, mips_cm_is64, since the CPS accessor macros consult it on
every 64-bit GCR access. All are exported _GPL.

Patches
-------

Patch 1 adds the GCR_DB_PC_* register and field definitions, with
local and redirect accessors.

Patch 2 exports the CM and CPC symbols needed by a modular user of the
GCR accessors.

Patch 3 extends the mti,mips-cm binding with the optional performance
counter interrupt.

Patch 4 is the driver itself together with its admin-guide document,
which describes the perf interface and transcribes the event numbers
and qualifier layouts so that users do not need the TRM to build a
qualifier.

Patch 5 enables the driver (as a module) in eyeq6_defconfig.

Testing
-------

Built with eyeq6_defconfig with the driver both built-in and as a
module; every patch of the series builds on its own, and the binding
and the document pass their respective checkers.

Run on the EyeQ6H board with 2 clusters, loaded as module in polling mode.

[   66.128375] mips_cm3_pmu coherency-manager: mips_cm3_pmu_0: 2 counters + cycles, polled
[   66.129617] mips_cm3_pmu coherency-manager: mips_cm3_pmu_1: 2 counters + cycles, polled

dev / # perf stat -a -e mips_cm3_pmu_0/cm_requests_l2_hit/,mips_cm3_pmu_0/cm_requests_l2_miss/,mips_cm3_p
mu_1/cm_requests_l2_hit/,mips_cm3_pmu_1/cm_requests_l2_miss/,mips_cm3_pmu_0/cycles/,mips_cm3_pmu_1/cycles
/ sleep 1

 Performance counter stats for 'system wide':

            505821      mips_cm3_pmu_0/cm_requests_l2_hit/                                   
             49083      mips_cm3_pmu_0/cm_requests_l2_miss/                                   
            184893      mips_cm3_pmu_1/cm_requests_l2_hit/                                   
             37760      mips_cm3_pmu_1/cm_requests_l2_miss/                                   
        1807514589      mips_cm3_pmu_0/cycles/                                      
        1807491360      mips_cm3_pmu_1/cycles/                                      

       1.005857149 seconds time elapsed

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
Vladimir Kondratiev (5):
      MIPS: CM: add CM3 performance counter GCR definitions
      MIPS: CM: export the symbols needed to access the GCRs from a module
      dt-bindings: mips: mti,mips-cm: add performance counter interrupt
      perf: add MIPS Coherence Manager 3 (CM3) PMU driver
      MIPS: eyeq6_defconfig: enable the CM3 PMU

 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/admin-guide/perf/mips_cm3_pmu.rst    | 337 +++++++
 .../devicetree/bindings/mips/mti,mips-cm.yaml      |   6 +
 arch/mips/configs/eyeq6_defconfig                  |   2 +
 arch/mips/include/asm/mips-cm.h                    |  51 +-
 arch/mips/kernel/mips-cm.c                         |   5 +
 arch/mips/kernel/mips-cpc.c                        |   2 +
 drivers/perf/Kconfig                               |  12 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/mips_cm3_pmu.c                        | 988 +++++++++++++++++++++
 10 files changed, 1404 insertions(+), 1 deletion(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261101-i6500-cm3-pmu-4a11f399b430

Best regards,
--  
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

