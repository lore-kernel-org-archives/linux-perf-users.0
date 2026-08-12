Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CC3438A2
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786494456; cv=none; b=iA5xzOids9Wf5jXK8pmEgRaD/MZAkb1V+MeGhRjihF6IhMoimWSCNoonLB8TGMXcrKFvCorzuZ5Kqe1t5NxgMTsUL9+k2J/niKa+bDEKp/fpeMaxhll+TH/nyX285IkssspfXNuYg3GELiIWEOFk+NQBmhN42Pc3x7QcjMwxP8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786494456; c=relaxed/simple;
	bh=AN+v1Zu+ZSv1UlGmppXCNvXIKxTdhEVjW6rb3gGgQuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MA22zbIr9bT0opYBEMFxc77Ys17H9nYyh3nf8k6016J+7yWMtHjesEgWa9ZuW8SSMbO+WIQi63oFmHwqICX7m0YnMwpgMB77eS0uxM50Fzq4sg6khAxkn5UvxFymBV611neTjboMCVHzQlofDovqKCtdH1jAIoLi/Fs2Qw+c/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Suj+skMC; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Suj+skMC"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb92868263so345620a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 17:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786494454; x=1787099254; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mN+xGdtQ4SY4k8K/VufISRawtQX2DXw8ATcE7ukH54U=;
        b=Suj+skMCYYyD/KJP1qAp0D7PCi5nLpCRmJH6WRCorAUMumI/NRNMEPu8ETkpQLy/1r
         kx8ffIXKS6RoouQmhnQQ8BfzkthzBdDVKNjFTg5kJzUO753wCLHLOI69inpsWHvnrmQ0
         FwXbc7wNwC1Of21dA8kn1iG/+xkRrHP2to4Jw+CQmUB/ttEKJ4+n1beamnJV0IPOfEim
         YOOqKZPr6KopH8rIOhMjnwXKlPHV7UIzhfNEm60Rcgk+u4H7CKZRdHckgH+NjUWuBUxi
         JBvhVO4m9RXynNnBxC2ScNSXG7B7vNaAmcHZkilIxIR8L+eFdB5fO72TKRDnl2XxdTsU
         1Bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786494454; x=1787099254;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mN+xGdtQ4SY4k8K/VufISRawtQX2DXw8ATcE7ukH54U=;
        b=i1qYYQ5dKSd86TOePoPkStO3OQJFtA3x+AZ+QXc7Cz50T69zISn5sO/61fwyZbGsK1
         fvk2YjLeiNItVInL1fcawOm8VWF060M3B4vkrxdPbwkurz9AlibHjlBjZl2eBGWfvQY9
         R5/YKq5berCS1f48Htk4ugssW7fqJb2CbufDtrmgBFHkquTE1CXPE+5LWkaPNYDJi9jx
         0kWzfs9JjTuDB0mK+xLkW/52vIjVzK8tmdY/QVYLBMeECSZppj0RxHd/R2zh8rGDdvRa
         izvIxuNQxQDsnqBaS/RYUUb2j+aUAsygXXbPeqmKEGit0c2uQSfPI0pxAPm0eRSqIzli
         rqrA==
X-Forwarded-Encrypted: i=1; AHgh+RqVQodOUkNfimsNBWodiJka0WCyqaPX4PCQRZifpZor2Oy/b70E/e8weL+klH9HQ2qx8v66+8MYJPetSNyQOc8X@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7C71r4uEy7wzgQ+XXxbkRleBA+rPw19riYFx2t/p/yUNEOII
	xELyVGqbe42YSGP58Zav1WEswOxsIqvV29JuwIbGdJKwkXRvzRXvm1yZEjq+K8b84J9/QlBU6MX
	MJbI47b/fdQ==
X-Received: from dlbqj22.prod.google.com ([2002:a05:7022:ec16:b0:13f:bdf3:f58])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:62cc:b0:3bf:a638:4376
 with SMTP id adf61e73a8af0-3cc3f7333d8mr907428637.21.1786494454226; Tue, 11
 Aug 2026 17:27:34 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:27:26 -0700
In-Reply-To: <20260811235112.2267241-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811235112.2267241-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260812002728.2283079-1-irogers@google.com>
Subject: [PATCH v3 0/2] perf: Add Raspberry Pi AXI PMU driver
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

Changes in v3
-------------
- 64-bit Device Tree reg Parsing: Replaced of_property_read_u32_index with
  platform_get_resource(pdev, IORESOURCE_MEM, i) to retrieve mailbox offsets,
  supporting 64-bit DT layouts (#address-cells = <2>).
- Firmware Phandle Fallback Safety: In rpi_axi_pmu__init(), if firmware node is
  missing or rpi_firmware_get() returns NULL, explicitly set MON__VPU use_mailbox_interface = false.
  config_is_valid() then returns -EINVAL for VPU events, preventing NULL pointer dereferences.
- Driver Teardown Order: In rpi_axi_pmu__exit(), unregister perf_pmu_unregister(&pmu->pmu)
  first to block new event allocations before removing CPU hotplug callbacks, cancelling hrtimer,
  and syncing workqueue.
- Probe Error Unwind Safety: Updated rpi_axi_pmu__init() error paths to call hrtimer_cancel()
  and cancel_work_sync() before returning probe failure.
- Thread-Safe enabled[idx] Setting: Set enabled[idx] = true under pmu->lock after verifying
  event generation sequence in vpu_work_handler(), eliminating TOCTOU race conditions.
- PREEMPT_RT Compatibility: Switched hrtimer setup and start to HRTIMER_MODE_REL_SOFT
  so timer callbacks run in softirq context, allowing spinlock_t acquisitions on PREEMPT_RT.
- CPU Offline Timer Migration: In rpi_axi_pmu_offline_cpu(), restart hrtimer using unpinned
  HRTIMER_MODE_REL_SOFT so perf migrates timer execution to the target CPU.
- Suppress Unsafe Sysfs Unbind: Set .suppress_bind_attrs = true in platform_driver.
- Kconfig Cleanup: Removed non-existent ARCH_BCM2712 symbol from depends on in Kconfig.
- Legacy Sysfs Alias Filtering: Updated rpi_axi_pmu_events_is_visible() to filter out all
  legacy RPi 1-4 System Monitor aliases (ccp2tx_, mphi_, h264_, v3d_, jpeg_, peripheral_,
  cpu_uc_, cpu_l2_, etc.) on BCM2712 systems.

Ian Rogers (2):
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 drivers/perf/Kconfig       |   10 +
 drivers/perf/Makefile      |    1 +
 drivers/perf/rpi_axi_pmu.c | 2022 ++++++++++++++++++++++++++++++++++++
 3 files changed, 2033 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.55.0.679.g6767b8d81c-goog

