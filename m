Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949437266D
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786575717; cv=none; b=q6eeUfsKHFFgAXdJQU8oi8fXKqYLLUVBNgetibWzN61HDuHM6dqySXXsbttxMXKLeliBUUjLGOxzzY1bXMuG0iPdwD8jTKL13FbKCIviU90ywjjFSHHw2Dki/NdMsf6x6sq/pxUvcJBGkoBUtysYbrmojib8x2WRqOy6ctPkK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786575717; c=relaxed/simple;
	bh=P55X4qAoS3HXOAVrBnYUo5CsiiCa508PgL5f/DRXMjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QlFLTEtK1HaHX2UMV830YEkOXddeJwRqHRT8hGPa5TZwu+hsHYsazheCa0HneQU1zLpVMtRSGlsziLwFmkNIfbima1sVun5Vuc0z6Cpq0/qtjzCibO1mTTnIgTF9qFmAUs5aJwFDxwPoP4BXt/k9UzCFkdgt0SU8M+WYuU6hxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oaW6xFV0; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaW6xFV0"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso2027166a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 16:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786575715; x=1787180515; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qh3HVhLUR9PA2V0gLxs+kUm5U4kH8Fq1BvaU6kfHM4E=;
        b=oaW6xFV0L5MY11VDWUV1wkBPKJFPddV+WFP3qhI5J1CJAUCI6fdlRpmQNaPHiU6JGP
         ya1dcity6BEU26/HmJmbTLaOHUk2RY9lQno1ySUjwOWowzfR5hzxBVdbVyuDtFnFGOLV
         kbmCEJtLr1DQHBr/JCF8yLROFaVuPou4rnNhAt3q2dNulZIPllKp0NFEq+TwX51FslM9
         0I/Co3RX2apQ49xxcbCXflgoNaiWWGjK2yuobGzzIagh7Bph1AIoJSWniQx44QMshJ/e
         MAylre4iQ5rcLl5k2s2kPVQowCNDKb/yViEjR92aezM3nu8MMg2oPifoGwDb3RvQPDV4
         k9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786575715; x=1787180515;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qh3HVhLUR9PA2V0gLxs+kUm5U4kH8Fq1BvaU6kfHM4E=;
        b=UEl7xFQH1oGRScCUNqx68h9KSpZXh+lXKwdbvCoKM7pkMZihdxTCCaG3/lLKE3wrpV
         MARspmOkMO4ZTuxzfbxFioe3DRM7pwhxaBdqiJR+2w1LJXOxor8ll81ohKSHvs1DDi1S
         SqDHXX1cVe/FEIV5Jm/pz5YYX2T6DZecFxTce+oqJ13ARtLGHOdGJICVs6n0op8yRekp
         A/6XINA3Ibb/og1gszfANlQg1U4lJuSzdFPYQYdDoxqQWRS6i5xsmB8uMrQ+vofb+z2n
         kVOHE4cfLolhlL6Okren3kiVfepcaAveOScZmmhkk1r3yr3UT0xend1EzftO/Bea+Pll
         QKPg==
X-Forwarded-Encrypted: i=1; AHgh+RpGhduLYhtqnaUJfMHXRRNjfLB/FiG0uUj+0n3q7h78yRz7mpS2zgvA20z/Wt6ISqjV6yPUCBhRfudCu4LboMqK@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpjXwGSVNZGvn29mQeKklrWqi5gPzjW2+9r8ZChEoWH/TZ8Sv
	spkuT5OHWtrAzYug2mJIKQYVIH1gm4DRc5qzyzRV5mr/1/rgfuIDmbjuABnoJmpHfZTX0f6JYd5
	m6r0AI3zz8A==
X-Received: from dycue12.prod.google.com ([2002:a05:7300:8c:b0:30c:83f3:7370])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2246:b0:38d:dfd1:7c1
 with SMTP id 98e67ed59e1d1-3931dfdcc9emr1622571a91.2.1786575714974; Wed, 12
 Aug 2026 16:01:54 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:01:43 -0700
In-Reply-To: <20260812052417.2361040-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812052417.2361040-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812230145.2644281-1-irogers@google.com>
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
 drivers/perf/rpi_axi_pmu.c | 2078 ++++++++++++++++++++++++++++++++++++
 3 files changed, 2089 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.55.0.679.g6767b8d81c-goog
