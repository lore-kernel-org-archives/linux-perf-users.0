Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE0426419
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786492280; cv=none; b=cHCVAsbetr0dKHjjQkUJ+5qroM+kgpr+M5UejKDeCrJph+erDEjA20wVTgl8Sgygugqtyjh9ots52hq6WpiMyZvfFT6SskwApiU5N81/SGWddaw22QVJxVN1+8P0ZA+bR5PDSe8X2kTQxXhH7ovhZUVEa6DDGnVTzoUHXti7AvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786492280; c=relaxed/simple;
	bh=GXiBqm/G+j3Nh1AQw2KR3rMvjiFbf6Ekr+KtI+I+86Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YNQSfy68FVia21kd7e6ZH4iz0d3XHBWOyEjBR75XKCCMfefNP+G1A54d1/yaf5fqfHMl7CcMYrmerhk1TJ9foH18qXzBdXI1UiHb37BdZ2hou+rRgNeKurr3FFl17oGvrbsTs5aGN3WxhOsNxQ50GwqFnZFMZRFOoE6DHvN3OnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxvcWj3v; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxvcWj3v"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso627294a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786492278; x=1787097078; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4U5bn9fxWsfK1Zj0iZYwkOob+4cM7Ff/aHIVm3hMKJM=;
        b=QxvcWj3vcAdJlIHSccMSk09gvVb5oghOn5B4cgov7EQMC7yQWVcaNCL76Mq/GGbBxs
         uM19092UAc+lsbP85GWeqDLKDBZ6+3xojh/uk+XCgoUABT1zFJDHB3LPia0GIYrs3fAI
         yos/BrFi1Ij2E1yFpzMcY9ytxqM5e9z9+dZFo9YcTiyyu2Q//mSL6WloYgcDcXN3rrzU
         9YEG90xF2s///DSnKrbMH+l9/AT/LVTtWODoNV88ngF/6s8aIToucrshOiva0Sp2aiHI
         I/kALmUx10mRs/GL3O7JxnoO0KlhcEuI2E+KbElBray4Ph0P48lhpdHIs+g5ese0jOOg
         elxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786492278; x=1787097078;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4U5bn9fxWsfK1Zj0iZYwkOob+4cM7Ff/aHIVm3hMKJM=;
        b=hYp86bASTsJYceCjVXxPMKZqYVa/8RbHndIOj8e/yGzFpQ8VOXV2HUeL8Tqo+/WNUj
         wK2Qm3xF0Tf78JrpD1YuGq6xO+NUiq9MjVE0VupSjYDwtPQak5tzIHx0ErHyz0sJ9dYn
         HnUPj4e7BGlK255KxfNKq8qe+BbMnG7Iw8oAaF67yrlIHKheSWeirOpJe+Ezjj7Ie7On
         KlCgIUdSGmH+RMwdyriWB39CwNt1nZVwBi9W5QTxv62BRgfHPfJ06qazZsqtHDpnz7Dj
         KMpVXydYnKU9/xzTy/gJ6QH1Vo7WNoK+h6m2b19Yxb+Co2cYewb+D38kk/0bIbamuKoR
         s0wg==
X-Forwarded-Encrypted: i=1; AHgh+Rru54vim/ueUGl1TwFU97SHP3zK8BM7lj/gVpi0xK69sRFmETy+sdV76s0kuTTuCEpSYQu1/3P0LdY83ng++ffb@vger.kernel.org
X-Gm-Message-State: AOJu0YzhHJCSw2M3QgZptT25PBycbKQT/m/37JfJMaUVM2jxgmJRc3Xv
	CC9JKGbCaOIouHoDJWm5rM3ojAOU3XEQDOb3qWgScN6vyDjyxJNvoMoE7JZlnQfLq/iPoqUur6K
	DqUqd79ZGZA==
X-Received: from dlbsi7.prod.google.com ([2002:a05:7022:b887:b0:13f:a0ee:666f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b81:b0:38d:dfd1:7a8
 with SMTP id 98e67ed59e1d1-39301285deamr718924a91.2.1786492277667; Tue, 11
 Aug 2026 16:51:17 -0700 (PDT)
Date: Tue, 11 Aug 2026 16:51:10 -0700
In-Reply-To: <20260811083828.2057695-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260811083828.2057695-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811235112.2267241-1-irogers@google.com>
Subject: [PATCH v2 0/2] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, will@kernel.org, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <u.kleine-koenig@baylibre.com>
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

4. SoC Generation Support:
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

Changes in v2
-------------
- Match Data Initialization: In rpi_axi_pmu__init(), set pmu->chip via
  of_device_get_match_data(dev) to ensure BCM2712 match data is correctly parsed.
- Sysfs Event Visibility Filtering: Updated rpi_axi_pmu_events_is_visible() to
  properly filter all 7 BCM2712 master filtered event aliases (arm_, pcie0_,
  hvs_filtered, emmc0_) on BCM2835-BCM2711 systems, and hide legacy RPi 1-4
  aliases on BCM2712 systems.
- Unmapped Monitor Check: Added monitor base_address and initialization check to
  config_is_valid(). Events targeting uninitialized or unmapped monitors (e.g. missing
  memory resource or monitor=1 on BCM2712) are properly rejected with -EINVAL.
- CPU Affinity Enforcement: Restrict uncore events in event_init() to event->cpu == pmu->cpu
  to prevent orphaned uncore events when a non-PMU CPU goes offline.
- 31-bit Counter Wrap Delta: Mask counter accumulation with delta = (new_count - prev_count) & 0x7FFFFFFF
  in read(), timer_handler(), and vpu_work_handler() to prevent 2B+ event spikes on counter overflow.
- Stopped Event Guard: Return early in rpi_axi_pmu_read() if event->hw.state & PERF_HES_STOPPED.
- Lockless Race Fix: Pass bus and filter explicitly to rpi_axi_pmu_enable_bus_watcher()
  under spinlock to prevent lockless read races in vpu_work_handler().
- Slot Reuse Clean: Set enabled[idx] = false in rpi_axi_pmu_del() when refcount[idx] == 0 so
  re-allocated watcher slots properly enable hardware watchers.
- Events Array Bounds: Return -ENOSPC in rpi_axi_pmu_add() if pmu->events array is full.
- Timer Cancel Race Fix: Re-acquire pmu->lock after hrtimer_cancel() in rpi_axi_pmu_del()
  and re-verify active_events > 0 before returning.
- Hotplug Timer Migration: Cancel and re-pin pmu->hrtimer to target CPU in rpi_axi_pmu_offline_cpu().
- Registration Order: Call perf_pmu_register() before cpuhp_state_add_instance() in probe,
  and cancel hrtimer before cancel_work_sync() and unregister in exit teardown.
- Header & Style Cleanups: Removed <linux/mod_devicetable.h> and <linux/version.h>,
  updated rpi_axi_pmu_match[] terminator to { }, and fixed C variable declaration style.

Ian Rogers (2):
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 drivers/perf/Kconfig       |   10 +
 drivers/perf/Makefile      |    1 +
 drivers/perf/rpi_axi_pmu.c | 2001 ++++++++++++++++++++++++++++++++++++
 3 files changed, 2012 insertions(+)
 create mode 100644 drivers/perf/rpi_axi_pmu.c

-- 
2.55.0.679.g6767b8d81c-goog

