Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433860;
	b=0HZ2cFQRn33+kRMA3k1x1d/ppEb/diKaPxPBgToVWJqjLdnRkxtFHMAexGLqQ3JYRMEn
	 /OHp9izcQ9CXRQ4hQMZCwpVSD5SdE+YEqbwtXovPJgRp8399UKVyeAXUClo+eXscRI1UJ
	 uqvSDJApohQKI9waslP3BYO32eNDA8m/SrKTpLmfceWS7DGNXZuRGO81CHyqb7uYZq+xX
	 sMB25ILc4DaMe8DGMafb6arSckaDO2JgGY9PFGiqGMkCV6ROHWGFTnNmrBi3o2eeuKP7K
	 PkaO7rgihT0ohPMlwNOtXlvTi197RJgZ9LRnPC0btWe71H1hPeA5eafuiI7ipYes4wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433860;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=ntmDGlnmzvQf5w67HzPiljgwsUTYnXg53ZXpL1yExdk=;
	b=Nr+dq1rhS5SgHh0NQ55XFCjDRlpFbpM1IXCCUCO0+EhZlTwUjYl9fnxfEcMLdlqozHOA
	 9yABOhCyq0eIbhbRvh60TXC8+kraskVV6K8yQJChEbi439jCC787tlL7KxFq/wC7ENzPi
	 E/+TS8bVpFmeOAUqAccmbWpKBlVu0f5D5hN8RuGknp6DDOTO8gzhj8Eqs+uFIlfONCJo1
	 xRUANe/6Qz3UqTFaiFydQ0IzgVtbObmO+uZarg4WLWAd8fkHa0YPaAo3nTTTNLSvIwIzp
	 njKD+LhKeQLruDnPMFtv6W7wYUODUh/OxdSkKgukT3MfwWeiF6MX5BYUOrGcVqxj/Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4088606A31E;
	Mon, 23 Nov 2026 11:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4088606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795433857; x=1826969857;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=mpj84e/t345Jz8Ts2bXCenjgwm5ag9QWiJ6Vn+kZ7O4=;
  b=S4W85cSgOiWmNFordqZh55J+hvl7iCe+lmEdBchUWmiR78yH8fdks/ky
   rDggNM0GMKVOhgHpd37JYqmsNlMG8hFfMBmw9ySY1X+lcTpU9JFVmZ2GN
   bQQwP81rKDhCTNNvey2Y5sRul8hxmp970Vv+xFpbku+v78t2q0mFmIrkI
   5UIQZ3cn4skZHKCkJX660EOF+m1dErn8jBrVeI1etWaVYht817whUYzd+
   eJLU2GOqw7QcQHCfz0wls6KeRVvxoOvThPyjvI2ABJBxzWL2SAB6bREHt
   WgkUI7Er1BV7ZBPRD3tPQ6uEnOHEdQ4BkETlz/F7PHHbaFkNVHJlIxmuh
   g==;
X-CSE-ConnectionGUID: aFHaIcV+S7aBTvYTrtdGmA==
X-CSE-MsgGUID: x6NVHKXuR/y21SXxSXpGiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 13:37:28 +0200
X-CSE-ConnectionGUID: 804G1mV/Txq5mdhr1QNE7w==
X-CSE-MsgGUID: 2UB6xt0mRC+5r71+VZVmIA==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 23 Nov 2026 13:45:48 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Mon, 23 Nov 2026 13:37:27 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: [PATCH v4 0/6] perf: add PMU driver for the MIPS Coherence Manager
 3 performance counters
Date: Mon, 23 Nov 2026 13:37:10 +0200
Message-Id: <20261123-i6500-cm3-pmu-v4-0-5a9f5351688f@mobileye.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGYlBGsC/23NSwrCMBSF4a1IxkZy8zJx5D7EQZOmNmIfNG2xl
 O7dpiKU4PCHc787o+A67wK6HGbUudEH39Rr8OMB2TKrHw77fG1ECZUABLCXghBsK4bbasA8Ayi
 Y1oYzgtabtnOFf2/e7f7tMJins31E4qL0oW+6aXs4Qtz9bJXYI2CCTQ6gheJKQ3atGuNfbnIn2
 1Qo8iPdAUBTgK6AzamQWpxBgf4DsD2gU4BFQEkORDNuBCTAsiwfl3558EEBAAA=
X-Change-ID: 20261101-i6500-cm3-pmu-4a11f399b430
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
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
 linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Paul Burton <paulburton@kernel.org>
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

A cluster holding CPUs is a special case of the above: Linux leaves
CPC_PWRUP_CTL.CM_PWRUP clear once it has booted a cluster, so the CM
powers down together with the last of its cores and the counters go
with it. The hotplug callbacks track this: when the last online CPU
of a cluster goes down and CM_PWRUP is clear, the PMU of that cluster
is paused (counts harvested, running events kept but not counting,
new events refused with -ENODEV) and it is resumed, the events
restarted, when a CPU of the cluster comes back online and the CM
with it. Pause and resume run on the PMU's CPU with interrupts
disabled, like the perf callbacks, so they do not race with them;
the pause precedes the death of the last CPU, hence the power down,
so everything that touches the counters either runs on that CPU
with interrupts disabled or is waited for by the pause (the poll
timer). The remaining exposure is a cluster without CPUs whose power
is not managed by this kernel: only the CPC check at event open
covers it.

Overflow is where the SoC integration leaks in. The CM3 has a
so_cm_perf_cnt_int output, but whether it is wired to a GIC input is
the integrator's choice and is not discoverable. Adding here lack of the
platform to test interrupt part, desision is to not use the overflow
interrupt. Poll 32-bit counters every 250 ms, which is comfortably
below the time the fastest event needs to wrap at the CM3 clock rates,
this yield 64-bit counts.

The driver can be built as a module. That requires exporting
mips_gcr_base, mips_cpc_base, mips_cm_{lock,unlock}_other() and, less
obviously, mips_cm_is64, since the CPS accessor macros consult it on
every 64-bit GCR access. All are exported _GPL.

The redirect block is reached from the perf callbacks, which run under
the raw perf context lock, and from the polling timer in hard
interrupt context. mips_cm_lock_other() takes cm_core_lock, a plain
spinlock, which is an invalid wait context there and on PREEMPT_RT.
Paul Burton's patch turning it into a raw spinlock, posted in 2019 but
never merged, is picked up as the first patch of the series, ammended
with similar conversion to thew raw spinlock for CPC.

Patches
-------

Patch 1 is Paul Burton's conversion of cm_core_lock to a raw spinlock,
with cpc_core_lock added

Patch 2 adds the GCR_DB_PC_* register and field definitions, with
local and redirect accessors.

Patch 3 exports the CM and CPC symbols needed by a modular user of the
GCR accessors.

Patch 4 is the driver itself together with its admin-guide document,
which describes the perf interface and transcribes the event numbers
and qualifier layouts so that users do not need the TRM to build a
qualifier.

Patch 5 enables the driver (as a module) in eyeq6_defconfig.

Patch 6 adds MAINTAINERS entry

Testing
-------

Built with eyeq6_defconfig with the driver both built-in and as a
module; every patch of the series builds on its own, and the binding
and the document pass their respective checkers.

Run on the EyeQ6H board with 2 clusters, loaded as module.

[   66.128375] mips_cm3_pmu coherency-manager: mips_cm3_pmu_0: 2 counters + cycles
[   66.129617] mips_cm3_pmu coherency-manager: mips_cm3_pmu_1: 2 counters + cycles

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
Changes in v4:
- use __DEVICE_ATTR instead of __ATTR
- cm3_pmu_format_show is just a duplication of device_show_string,
  use device_show_string
- drop overflow interrupt support, it complicates the code and I have no
  platform to test it
- fix hrtimer left running unattended
- drop patch 4 (dt-bindings), not needed for polling mode;
  re-generate To/Cc list
- Link to v3: https://patch.msgid.link/20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com

Changes in v3:
- added MAINTAINERS entry (patch 7)
- Converted cpc_core_lock to raw_spinlock, addressing comment by
  sashiko-bot@kernel.org (patch 1).
- Link to v2: https://patch.msgid.link/20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com

Changes in v2:
- Pick up Paul Burton's "MIPS: CM: Make cm_core_lock raw spinlocks" as
  patch 1: the redirect block is accessed under the raw perf context
  lock and from hard interrupt context (Sashiko).
- Account a full counter turn in interrupt mode: fold the overflow
  status into the delta instead of relying on the 32-bit difference
  alone, which lost 2^32 on every wrap (Sashiko).
- Keep the 64-bit qualifier in hwc->config1 rather than the
  unsigned long hwc->config_base, truncated on 32-bit (Sashiko).
- Set hwc->config before validating the group, and do not walk the
  siblings of an event that is its own leader: it has none yet and
  its context is not set (Sashiko).
- Use cpuhp_state_remove_instance_nocalls() so that the unregistered
  PMU is not migrated (Sashiko).
- Check that the cluster is powered on every event open, not only
  the first time (Sashiko).
- Pause the PMU of a cluster when its last online CPU goes down and
  the CM is set to power down with its cores, resume it when a CPU
  of the cluster comes back online; closes the window where the
  counters of a cluster could vanish under running events. The
  poll timer stops with the pause and is re-armed by the resume.
- Note in the cover letter that the interrupt mode was not validated
  on hardware.
- Link to v1: https://patch.msgid.link/20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com

To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
To: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Benoît Monin <benoit.monin@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Théo Lebrun <theo.lebrun@bootlin.com>
To: Fu Chao-Ying <chao-ying.fu@globalfoundries.com>
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-hardening@vger.kernel.org

---
Paul Burton (1):
      mips: {cm,cpc}: Make cm_core_lock, cpc_core_lock raw spinlocks

Vladimir Kondratiev (5):
      MIPS: CM: add CM3 performance counter GCR definitions
      MIPS: CM: export the symbols needed to access the GCRs from a module
      perf: add MIPS Coherence Manager 3 (CM3) PMU driver
      MIPS: eyeq6_defconfig: enable the CM3 PMU
      MAINTAINERS: Add entry for MIPS CM3 PMU

 Documentation/admin-guide/perf/index.rst        |    1 +
 Documentation/admin-guide/perf/mips_cm3_pmu.rst |  317 +++++++
 MAINTAINERS                                     |    6 +
 arch/mips/configs/eyeq6_defconfig               |    2 +
 arch/mips/include/asm/mips-cm.h                 |   51 +-
 arch/mips/kernel/mips-cm.c                      |   25 +-
 arch/mips/kernel/mips-cpc.c                     |   14 +-
 drivers/perf/Kconfig                            |   12 +
 drivers/perf/Makefile                           |    1 +
 drivers/perf/mips_cm3_pmu.c                     | 1128 +++++++++++++++++++++++
 10 files changed, 1540 insertions(+), 17 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261101-i6500-cm3-pmu-4a11f399b430

Best regards,
--  
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

