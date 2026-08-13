Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD454756CA
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786631170; cv=none; b=PXDhoFRn8ifKRHzHXyn1IIqDrvhJT2bYnspOV1IJJYEIfsLOZrCxn5MDN8p5PsYVut+2XT0rK6XdHwesXAgNXFzPj59gJx7eZFhV1ZsyyW99825FOJNsVHduNw/O6Q4F/YOc9SraZZMB5eKvs6dMbgFWOnl+B3ybvoY+yMHZkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786631170; c=relaxed/simple;
	bh=vhgZHuMvUoFFvNQ8BMqZR1WpBTzAsFfJJljmuoi4Ryk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tUgnaDjboBBpS5z8z0rKSspqzDpj/yx0xn4Z2pIOoD45AB051e9v4XufNyHG9mutBEeDcgNWCoMmRoWUZgvMGcHUzd8QE7am1wMpLSKx6OTJaiV8OKyrxcqzsRhKvxE8RL0aYizekI2/aePoSGUH+p7VZ5ME5mlyw9CyraBDSi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRIZplVJ; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRIZplVJ"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso1059739a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786631168; x=1787235968; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CtE5+SwfaqiVt1ovz5nhzu1q4YH4d9K6aiYS2Nt3N1g=;
        b=NRIZplVJ4DsOULpzAEYZOURXfj+5dWjEH3XBnw2MOIPCYA7cqQlx7uO4EZPIyX4N0d
         +z3oZhytdDW3H1CHz+zLQY5gqdaOE6mfpecrJA+QY3fgOc3gwp10XveWFKwwLX1cNO6P
         2axfBUEfkEw07DOUpbpWrTn3VT+dZrkqKjRpgunCbO/M9+eoWOiplnHP8p/prYWkgkLJ
         9zBhN3A64eoCzbS6sFTz3kj98/By1cd8QvwPWTthFAMhABUjYF8e8Osm3Cj+vkb1svrV
         RYQG3Mh9QEYKV0CUT1FfeB87M5oPSsMPeQQkRjwSUNMi1bAH2U1HCMGexBZHYShIpycF
         +qrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786631168; x=1787235968;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CtE5+SwfaqiVt1ovz5nhzu1q4YH4d9K6aiYS2Nt3N1g=;
        b=g/lyNVd+ArFBz7ov6M5ii87bSB5n4mkpataLwlc9MBw/ZXDQqyWh0jFO3NK80TTmk5
         +lOxVXP4fPv/OLb0X2pefjVCcm5xBY+wjw/M+/kmlUhycDp+jY/akbvyIb3BZWq+faCU
         5+6q3NjDPdss75RM84CryZbnVRKOdrVFGYjv7nQAI1qD84w02kjFZJgijg+NuFIjbvWB
         YFqqJ0An3xFZWpvs7R+xo5J2jy7jPorF/x1TEO84U4LCwt+fjQqV1Y1eCEeQPMSUaktS
         +k/hGo3ojWPXgH5twDLmlh9CjPetV6ETNOvXUw7eOvj4pc0rniBYSA2D7QqM2oEb87Wh
         j+yw==
X-Forwarded-Encrypted: i=1; AHgh+RowG3WTfM+MNVVzD8xTlXfN7dmweZZeoybjx5KeU2VIFA1IZloKv6WOAzX46mVxl68K0IjuqzT21ydc/j9P+4qV@vger.kernel.org
X-Gm-Message-State: AOJu0YxGetvYDZA5Atsa5qqtrsNtVfC1huLenp2Q2UWb3j8e7LLi73eD
	rZ4sQbvwJLprGR8B6V5DXSfCCroTZKV5+ODFL+NUIPjvFlZOm6itVEcJXDmHlyVPMHiO0kdDjzH
	eVc7aA+uX1Q==
X-Received: from dled8-n1.prod.google.com ([2002:a05:701b:42c8:10b0:13b:8289:9a55])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:999d:b0:3c3:9a7f:7307
 with SMTP id adf61e73a8af0-3cc55319ed3mr6860167637.24.1786631167816; Thu, 13
 Aug 2026 07:26:07 -0700 (PDT)
Date: Thu, 13 Aug 2026 07:26:02 -0700
In-Reply-To: <cover.1691900000.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1691900000.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <cover.1691900000.git.irogers@google.com>
Subject: [PATCH v11 0/2] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20260813142602.xMUIIMiPilE_F_nl2maItT-TgkSFp1o7aYdAgKaeTdE@z>

This patch series adds an uncore Performance Monitoring Unit (PMU) driver
for Broadcom AXI system and VideoCore VPU performance monitors found on
Raspberry Pi SoCs (BCM2835 through BCM2712 / Raspberry Pi 1 through 5).

Motivation & Background
==============================
Currently, Linux lacks a standard perf-API compatible driver for the
Broadcom AXI performance counter blocks on Raspberry Pi platforms. Prior
out-of-tree vendor solutions relied on custom debugfs nodes and ad-hoc
kthreads, preventing integration with standard Linux perf tooling (`perf stat`,
`perf list`, etc.).

This driver implements standard `struct pmu` hardware uncore callbacks
under `drivers/perf/`, exposing human-readable sysfs event aliases, unit
scaling (`Bytes`), and bus filtering directly to user space.

Key Architectural Improvements & Features
==============================
1. Standard Linux Perf Integration:
   - Exposes uncore AXI interconnect events via `/sys/bus/event_source/devices/rpi_axi_pmu/`.
   - Supports event sampling and hardware counter accumulation (`local64_add`),
     automatically managing 31-bit hardware counter wraparound across high-bandwidth
     interconnect transfers.

2. CPU Hotplug Support (`cpuhp`):
   - Registers dynamic CPU hotplug notifiers (`CPUHP_AP_ONLINE_DYN`).
   - Automatically migrates PMU context (`perf_pmu_migrate_context`) to an online
     CPU core when a designated CPU goes offline, safely guarding memory teardown boundaries.

3. Hybrid Memory-Mapped & Mailbox Work Queue Architecture:
   - System Monitor (MMIO): Performs fast atomic-safe memory reads (~15ns)
     directly mapped over ARM physical memory space (`MON__SYSTEM`).
   - VPU Monitor (Mailbox IPC): For Broadcom BCM2835-BCM2711 platforms (RPi 1-4),
     VideoCore VPU monitor IPC calls are offloaded to process context via a dedicated
     workqueue (`vpu_work`) and serialized under `vpu_mutex`. This avoids atomic
     sleeps or blocking in timer/interrupt context.

4. SoC Generation Support:
   - Patch 1 adds core driver support for Broadcom BCM2835-BCM2711 (RPi 1-4).
   - Patch 2 expands support for Broadcom BCM2712 (Raspberry Pi 5), adding PCIe RP1
     Southbridge links, HEVC decoder, HVS display engine, and Cortex-A76 DSU L3
     interconnect monitoring.

Hardware Validation
==============================
The driver has been rigorously validated on real hardware:
- Raspberry Pi 400 (BCM2711): Validated System L2, ARM CPU, and VideoCore VPU
  firmware mailbox IPC performance counters organically spanning multi-slice multiplexing boundaries.
- Raspberry Pi 5 (BCM2712): Validated live byte throughput across HVS display
  refresh cycles, Cortex-A76 DSU L3 interconnect memory traffic, and PCIe RP1
  Southbridge transfers independently configuring `bcm2712_` filters.

Changes in v11 (Addressing upstream integration feedback)
==============================
- Removed the unused `num_started` state tracking variable from `struct rpi_axi_hw_events`
  and its associated start/stop increments, cleanly addressing a reviewer's note on dead code.
- Eliminated KCSAN data race warnings in `rpi_axi_pmu_read_counter()`. Annotated
  the `enabled[idx]` flag with `READ_ONCE()` during lockless VPU thread polling, and matching
  `WRITE_ONCE()` barriers during subsystem teardowns.
- Restored `flush_work()` in `rpi_axi_pmu__exit`. When the module is unloaded, 
  `perf_pmu_unregister()` asynchronously schedules `vpu_work` to gracefully
  disable the physical VideoCore IPC hardware. Using `cancel_work_sync()` was 
  blindly dropping these critical queued disables, silently leaking running hardware monitors!
  Included an explicit defensive comment mathematically documenting this dependency.
- Inverted PMU and CPU hotplug initialization sequence in `probe()` 
  to cleanly eliminate a theoretical `devm_kzalloc` memory UAF race.
- Embedded a robust boolean initialization guard physically into the 
  hotplug event handler, definitively securing offline context callbacks
  from concurrent access panics during concurrent failures.
- Architecturally radically simplified BCM2712 sysfs generation loops 
  by switching to an explicit inverse `bcm2712_` whitelist. This 
  mathematically prevents ghost suffix parameters (`.unit` and `.scale`) 
  from orphaned legacy VPU transactions bleeding into userspace dynamically.
- Explicitly appended documentation notes organically defending the inclusion 
  of the `#if LINUX_VERSION_CODE` legacy shim surrounding `hrtimer_setup` 
  for seamlessly preserving downstream compatibility with Raspberry Pi LTS
  kernel deployments natively.

Ian Rogers (2):
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 drivers/perf/Kconfig       |   10 +
 drivers/perf/Makefile      |    1 +
 drivers/perf/rpi_axi_pmu.c | 2877 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 2888 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.41.0
