Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F5265623
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786512262; cv=none; b=pojXCmRxszGPEe6yimHtZ0hvreetBlJN4zR5ADoTB3roEgo4zJ6+VBUN4aJxpB1gw8Gw1j3+HIFggp5AJxFCXJ0e9bueKpo5k/Y+9THtiR1BkzLydIoPQwu2lfGDK/1S8P3PVBf0Ll2ElK9JnMhzXHkplmRzsXv7TZ4xJbYA4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786512262; c=relaxed/simple;
	bh=4MZUs7bKr1tACEfDZTrwtNrisKbfiANkThNzdLUWSIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IkVOZ7rqvNoXNwc5/Tlm+yYVxydPJDgK9kN5Y5amLA1Il9zpnNhP67BODjQSM6tGCZjuGI9sYuJlo0GwKKQ9cAfWbyLpkDPgcYNQ3Bq8ZOAAdBq+/WiSymOABQcfa+pu34CtxZFFWtB1M+s3EdjL5lieEjuiKuOPuujJedFoW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYpc4LeZ; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYpc4LeZ"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so786057a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 22:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786512261; x=1787117061; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXjQ3oOfjU5GoGzikE26HldLFyYdtMlQ+8nHvN8Ud2o=;
        b=iYpc4LeZKsSV9VBnPeuBa6Uj4OYpHeJofW69jK9kMQOjTxjdCM603mvmPvdYlP+bB0
         Y8ukBZpozvquJPMvDCydiMY4SXuLRTZRbenEP38d78wmwkmNvs7ppTS8hbhSI4clyMwI
         fEbgCZfHPQw2Lx+r990JvP7q4OYc6+Hva0GGPxRBGOsfe/T53pXfMdHR7XxPP1iPIWo6
         Vipnxqjc3qh825brRAJpnckCe0yByiJdaqNlWPEWl23ME9XVrqgTigP2ia/bPda+CMnf
         kxWw9j67kw5Bj7ASJv66RWtBSyX7aIKn2FD5V47y9J0R6IS7lWeVbsKxbQoRsvytlDF8
         Hljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786512261; x=1787117061;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXjQ3oOfjU5GoGzikE26HldLFyYdtMlQ+8nHvN8Ud2o=;
        b=Q7Xa1B6Y0Xp8rA8Pzpo3olH+/FN7H7r6UsqO2H/AS3GREyzwUWQ0jhdEIe8v5KQ9rS
         Hq8VY6N36wPbqtLNOMEkw3f2Gh8ked84HbpPuybYhp9738KcP/uIg0kkRfSb8K+w0uba
         4m8phtyMiljElhZexTC/wJOHpzyZpXzhwWkjZhyuaDYVBt6eRYHKBZ1ddeRk6D5qkLvQ
         lpyOSMTkasCaeMKts+rBtSy3s9p3Uvdgld2TfiwG9udjMGeJLO8+aORYKBtf9sn7TX+1
         aE6NeqZTg8pmMyMlRvrl3rka7blkhec66TDpUW6XrSea4ojZMue3yjNuUBuFXWbAla1N
         jsrg==
X-Forwarded-Encrypted: i=1; AHgh+RpQjZDP8VYoGcVZ8rSkulG15yRdRx4m7whrYMLNhCBc75YMWsBKgKVRgzUYTz02Lkg8eDFuUMqEJrVc7OUHwjhK@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRN7EjKWD91AZuQys/fWwodxBboinmgJwYetzOEXuMVQS2oGW
	34JhlJkC36J1Q1dwh1NoKyU74y7mJyYzsKu3E5ahu1aSAtKlxaWmI/WJID1ipk5y0W1H6JsXV0P
	70M/rVlgCSA==
X-Received: from dlbro11.prod.google.com ([2002:a05:7022:158b:b0:140:ef7c:eac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b0d:b0:381:1f51:1ff0
 with SMTP id 98e67ed59e1d1-3930123c6ecmr2410896a91.2.1786512260580; Tue, 11
 Aug 2026 22:24:20 -0700 (PDT)
Date: Tue, 11 Aug 2026 22:24:15 -0700
In-Reply-To: <20260812002728.2283079-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812002728.2283079-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260812052417.2361040-1-irogers@google.com>
Subject: [PATCH v4 0/2] perf: Add Raspberry Pi AXI PMU driver
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

Changes in v4
-------------
- Global Monitor Reset Protection: In rpi_axi_pmu_enable_bus_watcher(), only issue
  global monitor resets (GEN_CTL_RESET_BIT) when num_monitored == 1. For subsequent
  watchers, reset only the individual bus watcher, keeping running watchers intact.
- IPC Failure Handling: In rpi_axi_pmu_read_counter(), return 0 on rpi_firmware_property()
  failure instead of uninitialized -1, preventing 0xFFFFFFFF phantom counter spikes.
- Lockdep & MMIO Safety: In rpi_axi_pmu_vpu_work_handler(), only unlock spinlock during
  counter reads if use_mailbox_interface is true, keeping MMIO reads lock-protected.
- Hardirq IPI Deadlock Fix: In rpi_axi_pmu_del(), use hrtimer_try_to_cancel() when in_hardirq()
  to avoid infinite spinning if an SMP cross-CPU IPI interrupts a running softirq timer callback.
- Timer Handler Early Return: In rpi_axi_pmu_timer_handler(), return HRTIMER_NORESTART early
  if active_events == 0.
- CPU Hotplug Preemption Race Fix: Initialize pmu->cpu = cpumask_first(cpu_online_mask) in
  rpi_axi_pmu__init() to guarantee assignment to a valid online CPU core.
- Type-Safe Driver Data Extraction: In rpi_axi_pmu_events_is_visible() and cpumask_show(),
  retrieve struct pmu * from dev_get_drvdata(dev) and convert via pmu_to_rpi_axi_pmu().
- Backward Compatibility: Added LINUX_VERSION_CODE check for hrtimer_setup fallback wrapper,
  allowing out-of-tree builds to compile cleanly on Linux 6.12 LTS kernels.

Ian Rogers (2):
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 drivers/perf/Kconfig       |   10 +
 drivers/perf/Makefile      |    1 +
 drivers/perf/rpi_axi_pmu.c | 2049 ++++++++++++++++++++++++++++++++++++
 3 files changed, 2060 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.55.0.679.g6767b8d81c-goog

