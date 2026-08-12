Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C5642AFB1
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576087; cv=none; b=PJRDofhjBPqDEXljV/wFj1M4fMn+YHvRqQvzYLzUHflPOjHytN2h4ZkthH4JcwGY39jcq2/xhjVsHGf5g4Xppk/I93aljKtLeMxNFKtWT3B4I9LGpsoytwAXE29edHcfCHSEL27GHn/I18VzvyEkmyISh7FQ+amXQwAsFh3+zDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576087; c=relaxed/simple;
	bh=Cbz9apUK6WeVQ7Ai32nThEUSX7Znc3/LmVgOmqTkvFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QWPEThkedulBVC1sPwjHLPdKEyEL23q2y4SwDlLxdb9/wOVKnR50HChIEbvQw/9LF26dzKsL25PpDTVTbtYXCD9hOuBJarEWD5V39FFzYiSWL79ZiBJ1MnF/cEJaXtwrjTdqC8zZG+QvuPNdbBc4klc2/kTzp0ozNgW/eUwgqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kl1ylwOO; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kl1ylwOO"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso257559a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 16:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786576086; x=1787180886; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tlmwDWahDCpqVEzTLP2aJg+dpiOPXi64VDUj/j5mYu8=;
        b=kl1ylwOOL0EJ58VT0tEF9o+2+VgS5F7sE2Ur+GScVeL9EHf1VswZGP0UvwaG4RbjcC
         RZ0iao2TbsN7sH1geffCufLfmKXfdJGxAIAdheX8dm9SYhJjLP0KrcNc/BR16Gudh9h9
         HR6qf04BYLah5L8ECPQuwfOQkEpmuHoSnWP9nG614BR6nLfPzYuuklP40MxMzfCijHIZ
         axlPE24Hz111uDnI+GfsH/LoJn9tdF05z3JEAIUUKWHx48rUeGIibtezgHfoVXNF7bNz
         r2bqv2zVNhR8upyqqVzhcrUOPfy3rRsaaa3U2JUg2KLGx8sbu9C3uSr13GbbiWL5ccpt
         puig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786576086; x=1787180886;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tlmwDWahDCpqVEzTLP2aJg+dpiOPXi64VDUj/j5mYu8=;
        b=fMS6/awHBRO4w/o3JDeWxzo6J7bas0z0n6cvzwl5Kvf4DBqBbQwZVca2XY/KgKVS0+
         3ACsfUAWvD/HpHQvmanwMPfR04iEh3FlllHRVLbxZE5zOwTlholMUO4tSKr2vAzL7Ajr
         yxZXP/UsYaFOyduel4Uag6DM3gS0DNhiln/kaO9vKSoAIKwgBMpRVQekBRHc8SmrPfZg
         8wkpRyCoDtF+yI97tWE8qibSMPGvnfJ5ewp0mGwvs+WkCvP9tSarkhf5l/JItqk4MJk6
         yccYCLR2GvkENmqkNGHKD/6oYZ3lAB+Kh9jadXTIuozupNAxO//TLGelY6BABhqhHf3g
         mvRA==
X-Forwarded-Encrypted: i=1; AHgh+RpoIP4Zq6eDPZejFpo7a8rRt8qBC1ydFoICfl4nVbk3/MgQdg48sX50RHPz3oSaVrDpUvuhY+qY+nJghGz3YvTC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn6a/1g9BaRXdiDJLdjQ0TOuyjb8gW4qqK1ob7fvoJThbJ6GN9
	VY+mt8+dP/VqH6TPlK9sYWvftKQPP8+seMwbzHHI1VOkCnIuMDR0cw9vFIJhGsQwNvIlU7gI9mx
	6KWetqFoLEg==
X-Received: from dlbvg26.prod.google.com ([2002:a05:7022:7f1a:b0:13c:dac9:90ed])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2644:b0:38f:1dc:672f
 with SMTP id 98e67ed59e1d1-3931e29843cmr1958999a91.18.1786576085578; Wed, 12
 Aug 2026 16:08:05 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:07:58 -0700
In-Reply-To: <20260812230145.2644281-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812230145.2644281-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812230800.2646749-1-irogers@google.com>
Subject: [PATCH v5 0/2] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, u.kleine-koenig@baylibre.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series adds an uncore Performance Monitoring Unit (PMU) driver
for Broadcom AXI system and VideoCore VPU performance monitors found on
Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5).

Motivation & Background
------------------------
Currently, Linux lacks a standard perf-API compatible driver for the
Broadcom AXI performance counter blocks on Raspberry Pi platforms. Prior
out-of-tree vendor solutions relied on custom debugfs nodes and ad-hoc
kthreads, preventing integration with standard Linux perf tooling (`perf stat`,
`perf list`, etc.).

This driver implements standard `struct pmu` hardware uncore callbacks
under `drivers/perf/`, exposing human-readable sysfs event aliases, unit
scaling (`Bytes`), and bus filtering directly to user space.

Key Architectural Improvements & Features
------------------------------------------
1. Standard Linux Perf Integration:
   - Exposes uncore AXI interconnect events via `/sys/bus/event_source/devices/rpi_axi_pmu/`.
   - Supports event sampling and hardware counter accumulation (`local64_add`),
     automatically managing 31-bit hardware counter wraparound across high-bandwidth
     interconnect transfers.

2. CPU Hotplug Support (`cpuhp`):
   - Registers dynamic CPU hotplug notifiers (`CPUHP_AP_ONLINE_DYN`).
   - Automatically migrates PMU context (`perf_pmu_migrate_context`) to an online
     CPU core when a designated CPU goes offline, avoiding stale uncore state.

3. Hybrid Memory-Mapped & Mailbox Work Queue Architecture:
   - System Monitor (MMIO): Performs fast atomic-safe memory reads (~15ns)
     directly mapped over ARM physical memory space (`MON__SYSTEM`).
   - VPU Monitor (Mailbox IPC): For Broadcom BCM2835-BCM2711 platforms (RPi 1-4),
     VideoCore VPU monitor IPC calls are offloaded to process context via a dedicated
     workqueue (`vpu_work`) and serialized under `vpu_mutex`. This avoids atomic
     sleeps or blocking in timer/interrupt context.

4. PREEMPT_RT & Safety Hardening:
   - Uses HRTIMER_MODE_REL_SOFT for timer callbacks to execute in softirq context,
     ensuring spinlock acquisitions are 100% PREEMPT_RT safe.
   - Sets suppress_bind_attrs = true to prevent unsafe manual sysfs unbinding while
     active perf events exist.

5. SoC Generation Support:
   - Patch 1 adds core driver support for Broadcom BCM2835-BCM2711 (RPi 1-4).
   - Patch 2 expands support for Broadcom BCM2712 (Raspberry Pi 5), adding PCIe RP1
     Southbridge links, HEVC decoder, HVS display engine, and Cortex-A76 DSU L3
     interconnect monitoring.

Hardware Validation
-------------------
The driver has been validated on real hardware across multiple SoC generations:
- Raspberry Pi 400 (BCM2711): Validated System L2, ARM CPU, and VideoCore VPU
  firmware mailbox IPC performance counters.
- Raspberry Pi 5 (BCM2712): Validated live byte throughput across HVS display
  refresh cycles, Cortex-A76 DSU L3 interconnect memory traffic, and PCIe RP1
  Southbridge transfers.

Changes in v5
-------------
- Teardown UAF/Orphaning Fix: Reversed module exit logic, calling cpuhp_state_remove_instance()
  *before* perf_pmu_unregister() to prevent accessing an unregistered PMU in the offline
  CPU handler during device removal, and to prevent event orphaning races during hotplug.
- VPU Hardware Watcher Leak Fix: In rpi_axi_pmu_del(), hardware disablement operations for VPU 
  bus watchers are now properly deferred to the vpu_work workqueue to avoid silently leaking 
  running hardware counters when the VPU monitor is no longer in use.
- Grouped Event Start Bug Fix: Deprecated reliance on num_monitored == 1 to initialize
  the global bus watcher. Instead, use a dedicated monitor_running flag correctly to
  start the global monitor when the first bus watcher gets enabled, mitigating bugs when
  adding grouped PMU events.
- IPC Phantom Spikes Zero Fallback Fix: Modified rpi_axi_pmu_read_counter() to return U32_MAX
  on IPC or MMIO hardware read failures, gracefully ignoring the delta calculation returning.
  This fixes unsigned 31-bit huge spikes where delta (0 - old_count) & 0x7FFFFFFF occurred.
- Code Comments: Added doc block comments inside rpi_axi_pmu_read(), rpi_axi_pmu_vpu_work_handler(),
  and everywhere U32_MAX returns occur to document the explicit justification for why U32_MAX indicates
  failure (valid counters are 31-bit) and why the driver drops the sample to avoid artificial spikes.
- VPU Data Race Lockdep Fix: Rewrote locking hierarchy inside vpu_work_handler(). PMU spinlock
  is now correctly held across rpi_axi_pmu_enable_bus_watcher() unconditionally since the function
  touches active monitor registers directly via MMIO, dropping it purely for mailbox IPC reads.
- Hrtimer Add/Del Forward Concurrency Warning Fix: rpi_axi_pmu_timer_handler() now executes
  hrtimer_forward_now() *before* releasing the PMU spinlock, fully mitigating timer enqueue races
  resulting from a simultaneous parallel pmu->add()/pmu->del().
- VPU Start Asynchronous Latency: Added explicit schedule_work(&pmu->vpu_work) call inside
  rpi_axi_pmu_start() when starting VPU-tracked events so they begin immediately instead of
  waiting for a 2-second timer interrupt period for short workloads.
- Event Stop Read-Modify-Write Spinlock Protection: Moved event->hw.state modifications inside
  rpi_axi_pmu_stop() under the local CPU PMU irqsave spinlock to safeguard atomic bitwise flags
  against the timer handler or workqueue updates.
- BCM2712 Pre-probe Initializer UAF race: Shifted perf_pmu_register() to the very end of
  rpi_axi_pmu__init() to ensure all hardware structures and CPU HP bindings securely exist prior to
  exposing the PMU to userspace tools preventing devres unregistration memory faults.
- BCM2712 ARM CPU L2 Event Correction: Corrected the bus index for the Cortex-A76 Cores PMU event
  aliases to bus=14 (BCM2712_SB__CPU_L2) to match architectural routing specifications on the RPi 5.
- BCM2712 JPEG Bus Monitor Visibility: Stopped improperly hiding the legacy JPEG bus aliases in the
  is_visible() callback on BCM2712 chips.
- BCM2712 Custom Event Replacements: Created specific BCM2712 equivalents for peripheral_rtrans/wtrans
  and cpu_uc_rtrans/wtrans since raw bus mappings shifted structurally on VideoCore VII.

Ian Rogers (2):
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 drivers/perf/Kconfig       |   10 +
 drivers/perf/Makefile      |    1 +
 drivers/perf/rpi_axi_pmu.c | 2124 ++++++++++++++++++++++++++++++++++++
 3 files changed, 2135 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.55.0.691.gc56d675ccc-goog

