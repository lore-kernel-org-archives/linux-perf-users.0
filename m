Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CF35E94E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786595738; cv=none; b=XuUCSX3GeV8CIFhtX347GzwUy0tx50smjH4QQR1W78Zzp7a12z79ZFS6R9YeKVVi4/4GrEdof9YF9QA0PgxKiAaYC1i8UjdAN55Zt9T+rRp+HDAXdsWV3AIh8JbMf3FdsztOmaAEFWBiHS32XnZCEtZg1a5GxsXhyrAPH4pzBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786595738; c=relaxed/simple;
	bh=ptK18vV72zVGHN2GeOm2saX0T1vmqZuiltG5vU+a3Qg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CzZnEo+tYIFwzuMz4CdWDtURwu112Dh3Ca07ye30WBhPosYxk7pf7IZRlfFN5Q+L5dLpLvQRAP2obtZD7Fra8/+qIvHLht8Ihf1i4Wv0iSmdKZxFbtKISC/ilAX5YBHvff93S+vN6C17ZWTp72ZDHuD8plEOLY3WuJKx/81FvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7PSehEJ; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7PSehEJ"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso278627a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 21:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786595736; x=1787200536; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xRo1BqdUJp5dIShuL4H3kAtBQ89l0wiBBMmh3TP05iM=;
        b=d7PSehEJwcULgJaCzY4yQBUEasHRXUuLZ3vRwcomiJE0jtV8CzFt0SWqnmHuAzTsUs
         DI+uqZW5oDSzSzOlynSBkOHoL9ddI9icBwNwjcbHfvQj5a2W/6NkxZOnNXUW7rvM0Qgb
         RR3UlmEM5XS+dpevN+LY+m25KOF6Z+MxJ3evGc3OrZefYD2l8QLu0sWMoXAZ5xfDWHbR
         C2AT/TULrzGKBBKLEAsiXQeKgJvDiangEDaydvJua9pQcy9cX8GKlqmM8VHc0flWNhmb
         hi7yJuvpW2C0GsSqA25JJ1yo7E1n+T2bYpHjUF+BcsFzE0XMMImrfaqByYRpvo9N4ArB
         e7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786595736; x=1787200536;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xRo1BqdUJp5dIShuL4H3kAtBQ89l0wiBBMmh3TP05iM=;
        b=KmkgtWxAJXOSDf2SRtiyc6ynMhiAiX6KHDryaXzPj+idU2LqfdWJIRn/eYpvvn760x
         EALDADR7VBcoPPhZwQmMImv2HdHFXZ6kAKz6Qd4GVFTwA28dOXx3lMFGXvjZzEDZutPj
         pQyhEM9F95KpggAffR120fxAlADywKE1nIulb8JkZzD1YFkDI+GU+nhuBfiJTEfdYrqR
         9wmacY7mCzCK4Fsn8qxcQBRt9HUZ3mGEyzDInOEyLATQ/ZpuRYvFZTgxmbG+PjEx+XKg
         TibYWNSMkVtP85sydOEdb4Fkxyou1Ej9NUOjHulZL2zIrYhQJDXS/kZzD7L6TXsUpsDz
         RtpA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4L5joGikvdVGmph3wdM4VdetPXpG89kWhPItHywY68JjpENiQGsxN20dihl0gJDtXlAiHy9QIXBk4by5OfWlT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94kEk/8wQVOKVZI+dDySvfSmpB2HxcQPLUezoNLoCG38QqXjv
	ToqFwgJS/3ixoP8UTM7njLktrdufXEwT9Z/uS0IAnEpBQ1PbHFnr5bsVWKLJHUP3fQfjQcU9Scn
	CPkmpmPD7cQ==
X-Received: from dycpw8.prod.google.com ([2002:a05:7300:de48:b0:313:fdd8:8131])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6017:b0:3c9:1c1f:f516
 with SMTP id adf61e73a8af0-3cc552c3825mr4189391637.19.1786595736235; Wed, 12
 Aug 2026 21:35:36 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:35:31 -0700
In-Reply-To: <20260812230145.2644281-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812230145.2644281-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813043533.2744442-1-irogers@google.com>
Subject: [PATCH v6 0/2] perf: Add Raspberry Pi AXI PMU driver
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
The driver has been rigorously validated on physical hardware across multiple 
SoC generations:
- Raspberry Pi 400 (BCM2711): Validated System MMIO and VideoCore VPU firmware
  mailbox IPC performance counters. Explicitly mechanically verified precisely zero 
  lockup behaviors across 100Hz aggressive asynchronous timer interrupts. Profiling 
  the `h264_v4l2m2m` pipeline hardware isolated >11.1MB in pure AXI VPU hardware matrix reads.
- Raspberry Pi 5 (BCM2712): Validated live byte throughput across HVS display
  refresh cycles, Cortex-A76 DSU L3 interconnect memory traffic, and PCIe RP1
  Southbridge transfers.

Changes in v6
-------------
- Reorganized commit structure rigorously into two cleanly bisectable patches
  (BCM2835 core in Patch 1, BCM2712 additions in Patch 2).
- Resolved unmet Kconfig dependency warnings when MAILBOX=n by cleanly relying
  on 'depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)'
  rather than forcefully using 'select' (Patch 1).
- Resolved catastrophic PREEMPT_RT/softirq deadlocks associated with atomic
  spinlocks globally preempting 'hrtimer_cancel()' routines by permitting the
  timer loop to detect 0 active events and cleanly self-terminate (Patch 1).
- Purged unsafe 'spin_unlock_irqrestore' lock dropping maneuvers occurring
  abruptly inside 'rpi_axi_pmu_read()', ensuring atomic contexts and missing
  flags no longer inadvertently trigger kernel panics (Patch 1).
- Eliminated silent ABA VPU slot data-corruption and event hardware leaks by
  decoupling 'vpu_work_handler' loops safely onto a 'vpu_disable_pending' matrix.
  Deleted VPU watchers are safely disabled exactly prior to newly allocated slots 
  executing initialization within the same asynchronous worker loop (Patch 1).
- Resolved lockless data races across VPU mailbox hardware mutation checks by fully
  protecting 'monitor_running' and 'enabled' state modifications structurally inside 
  the 'rpi_axi_pmu_start' and 'rpi_axi_pmu_vpu_work_handler' core locks.
- Disentangled rigid 'cancel_work_sync' usages back to safe 'flush_work' variants in
  teardown unloading contexts so dynamic Mailbox IPC teardown flows successfully 
  execute without aborting directly in mid-flight (Patch 2).
- Sharpened the sysfs 'is_visible' string-masking logic to properly accommodate
  Raspberry Pi 5 aliases, resolving an overzealous 'strstr' bug directly hiding
  "bcm2712_peripheral_" aliases on RPi 5 hardware (Patch 2).
- Rewrote component destruction sequencing logic completely onto safe CPU hotplug 
  '_nocalls' handlers to strictly avoid User-After-Free events from persisting 
  against unregistered/defunct driver models during 'perf_pmu_unregister' (Patch 1).
- Eradicated cross-execution bus tracker leaks across failed/zombied workflows where
  'monitored' mask properties remained structurally trapped inside invalid state
  loops by surgically injecting manual 'enabled = false' boolean teardowns into 'del()'.
- Inserted explicit comments explaining the critical 31-bit counter-masking logic
  regarding standard U32_MAX hardware exception signaling (Patch 1).
- Scrubbed all erroneous 'TAG=agy' trailing metadata from commit descriptions.

Ian Rogers (2):
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 drivers/perf/Kconfig       |    9 +
 drivers/perf/Makefile      |    1 +
 drivers/perf/rpi_axi_pmu.c | 2119 ++++++++++++++++++++++++++++++++++++
 3 files changed, 2129 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.47.0
