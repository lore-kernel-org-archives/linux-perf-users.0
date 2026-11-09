Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211291;
	b=uFflmej6yIlgbkYNqGEXzzNmix1wKOfKbdYVY16ID6Iv/esIhGvZ/2dxKZlWZf/jt9Bm
	 Ox9M13WL2/z1bELRv2gamDEa2T5KH5W/jrnRDLo15rjiKSj6t6sJFXMFsxywtF7M2wYPR
	 cyXVHL7XaS0hdgViNrKyvXMm9expltgSwCo/CF0idM3kRKzxu9cwhfarIpK3gQvciGanv
	 WcL2CHRJ7N24bwBYeEDfzn6ob2l08w5jiVQx9Wur0xHnk6aDufmHjQ8uhhkjD2Stu5JxN
	 rWGvgoG7zUMTm3hVnN0gJSGAZqNXESTt6DvqVikB1aPAAHVMut2EnOsZTp6qM6nfY3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2bnIt4Kht+1xT2rtI01IKbuXBKTnNsl6rxyrChAjsUs=;
	b=4c27Tk5jCLWWcBjkpYb3N7mKk2KQfdUKgu3wmVfWu6S2ionjLP82IftTZkbYDF7AX3/R
	 GamwG4LS1eguuDoxWuzJzRL8oscJpe1gob/iW+71tYEPxbJ7WYFG8wnlB//DdPHHHEbZd
	 lwTZzWjUJjPrEzjnJycRrgJxjyz8WVnthfNa0eX/VPzmEOlop/6GIcxnwrrd/0Si1TFg9
	 Oqz4tqnc+iF+aSuoIsib9UYDt3GtOm3MbZwoq57InBPSc6xp68bW0LE2m7COTeYg9LLYN
	 RZNrgCt34S/c0skAYIorFLAu0zvBcX5ncJfQmUPexLo9t60dZPmGScn/G57hYMy3t0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S0yebDua;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D87606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 08:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69D87606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S0yebDua
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36d1353fdcdso978766eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 00:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794211289; x=1794816089; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2bnIt4Kht+1xT2rtI01IKbuXBKTnNsl6rxyrChAjsUs=;
        b=S0yebDuazB2b6PssMdgs9y15y0YoNyITqLZc10+UJRm+MjtXJk3MsyXgsgH47GYN4f
         H2OSzviquZYsuSpJwYdd1/Y8zQpznEkc0Qn6ajsSuzjbYstQomCvu+N9t8S9c+NnThHm
         RwxR6S+WlemhvuD/ao/dzEomu8W73hwOU3+fFFt1DV6hXoFQp/zZkQb18q5NnWQv1Usy
         0McDvYKej1+yMwlM1fo14h45UKTIuN53DEw7KdAlvHRGrpFryOsDToVNYyFFCBL7p8w4
         UDxbzD2fP9PXP+NKKq/A51GRLLBib1aOO/81CimGD2r0X/tzhZrL6L3w6IuobI8YmPo8
         eLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211289; x=1794816089;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2bnIt4Kht+1xT2rtI01IKbuXBKTnNsl6rxyrChAjsUs=;
        b=UUcRoVRCTIZm3BuK7d5H/Hy+0CrEu84uBZaMyUdU00f95KB9aJCAV3mgBX0cYogv2Y
         xStOADlZkptRYsmxbZ9cTt0Kv0mA+vLQggRW+wrlQX4ehEmrQxlchxqVJCBCHFelMzHW
         7NFa5elCA9Sgv720Ibp94FH58tXkLkWEZSpKKKtxDH4vGucRpGKVDkFjdfyD4O0dgtxn
         i1CJb5iMgc64/sisBeJMvD5a2ZMbIQ5n7eh3b+TdBrjVnoYXvCa84lVTQLzl2yY9icqO
         fQKYLTOf/x2dJ3PlO580DI/DMBE5I6CujPwVwzil2rMEUNjV6Kx6SLpJ3TZkGGLDExQE
         m0Hw==
X-Forwarded-Encrypted: i=1; AL+hErFe8967JkmILJjNAZN8AGW66btHlGRUql2NtfKbJnkec3Fgd09TMZB+PNeI7dEACyrBdnJ2+meawAYs5/dRbDH1@vger.kernel.org
X-Gm-Message-State: APuU4Z+Vd9BxM3c4/mvnRrR14zFn5/1yj9q9HC/bilNEENuuQjNbtMIp
	/EB8OKjW3gFjfXkRPKNVJ8CBu5HKeRKZmaD/8G08jvvnsLkxJMEetmPCCX8POIZj/TFPSwN0H6s
	9EMfM7EZO+w==
X-Received: from dycmp11.prod.google.com ([2002:a05:7301:70b:b0:36e:f67b:23ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:638c:20b0:36c:b8b1:a44f
 with SMTP id 5a478bee46e88-372573cd492mr6439233eec.31.1794211289184; Mon, 09
 Nov 2026 00:01:29 -0800 (PST)
Date: Mon,  9 Nov 2026 00:01:23 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261109080126.417161-1-irogers@google.com>
Subject: [PATCH v19 0/3] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Dom Cobley <popcornmix@gmail.com>, Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>, 
	bcm-kernel-feedback-list@broadcom.com, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, devicetree@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Motivation & Background
=======================
Currently, Linux lacks a standard perf-API compatible driver for the
Broadcom AXI bus-watcher performance monitor blocks on Raspberry Pi
platforms (BCM2835, BCM2711, and BCM2712). Prior out-of-tree vendor
solutions relied on custom debugfs nodes and ad-hoc kthreads, preventing
integration with standard Linux perf tooling (`perf stat`, `perf list`,
etc.).

Note that this hardware block (`brcm,bcm2835-axiperf`) is distinct from
the Northstar BCM5301X AXI Trace Module (`brcm,bcm5301x-axi-pmu`,
https://lore.kernel.org/r/20261027175124.3518239-1-florian.fainelli@broadcom.com).

Key Architectural Features
==========================
1. Standard Linux Perf Integration:
   - Exposes uncore AXI interconnect events via
     `/sys/bus/event_source/devices/rpi_axi_pmu/` and documents them in
     `Documentation/admin-guide/perf/rpi-axi-pmu.rst`.
   - Supports up to 3 concurrently monitored `(bus, filter)` pairs per
     monitor (`NUM_BUS_WATCHERS_PER_MONITOR = 3`), with reference counting
     so all counter metrics on the same `(monitor, bus, filter)` share a
     single hardware watcher without multiplexing.
   - Enforces group validation (`rpi_axi_pmu__validate_group()`) to reject
     event groups requiring more than 3 watchers per monitor at
     `perf_event_open()` time, while supporting time-multiplexing across
     more than 3 ungrouped buses.
   - Masks counter deltas to each hardware register's bit width (32-bit for
     `*trans`, 28-bit for `*wait`/`*max`, and 8-bit for `rpend`) and tracks
     per-interval watermarks for level registers (`*max` and `rpend`) so
     `perf stat` and `perf stat -I` report accurate peak levels.

2. Hybrid MMIO & Firmware Mailbox Architecture:
   - System Monitor (`monitor=0`): Performs fast atomic-safe MMIO reads.
   - VideoCore VPU Monitor (`monitor=1`): Polled asynchronously in process
     context (`vpu_work`) via a single 44-word bulk Raspberry Pi firmware
     mailbox `RPI_FIRMWARE_GET_PERIPH_REG` call across all three VPU bus
     watchers. At probe time, `rpi_axi_pmu_vpu_accessible()` verifies that
     the firmware can reach the VPU monitor hardware and hides the `vpu_*`
     sysfs events if unavailable.

3. Per-SoC & Stepping Support:
   - Patch 1 adds the Device Tree binding (`brcm,bcm2835-axiperf`,
     `brcm,bcm2711-axiperf`, `brcm,bcm2712-axiperf`) and `MAINTAINERS`
     entry.
   - Patch 2 adds the driver and admin-guide documentation for BCM2835 and
     BCM2711.
   - Patch 3 adds BCM2712 (Raspberry Pi 5) C0 and D0 support, including
     runtime D0 stepping detection via the bus-watcher AXI ID mask field,
     C0 (13-port) and D0 (10-port) System bus tables, 6-bit sparse AXI
     master ID filter tables (`BCM2712_FLT_MAX = 64`), and `ratrans`.

Hardware Validation
===================
The bus tables, master ID filters, and register layouts have been
validated against Broadcom register documentation and direct hardware
measurements on:
- BCM2835 (Raspberry Pi 1 B+)
- BCM2837 (Raspberry Pi 3 B+)
- BCM2711 B0 (Raspberry Pi 4 B and Raspberry Pi 400)
- BCM2712 C0 (Raspberry Pi 5 rev 1.0)
- BCM2712 D0 (Raspberry Pi 5 rev 1.2, Raspberry Pi 500, and Raspberry Pi 500+)

Example on Raspberry Pi 5 (BCM2712) counting all 11 metrics on the `arm`
bus simultaneously on a single bus watcher:

  $ sudo perf stat -a \
      -e rpi_axi_pmu/arm_atwait/ -e rpi_axi_pmu/arm_atrans/ \
      -e rpi_axi_pmu/arm_amax/   -e rpi_axi_pmu/arm_wwait/ \
      -e rpi_axi_pmu/arm_wtrans/ -e rpi_axi_pmu/arm_wmax/ \
      -e rpi_axi_pmu/arm_rwait/  -e rpi_axi_pmu/arm_rtrans/ \
      -e rpi_axi_pmu/arm_rmax/   -e rpi_axi_pmu/arm_rpend/ \
      -e rpi_axi_pmu/arm_ratrans/ \
      -- dd if=/dev/zero of=/dev/null bs=1M count=2048

   Performance counter stats for 'system wide':

           222,085      rpi_axi_pmu/arm_atwait/
        21,789,405      rpi_axi_pmu/arm_atrans/
             2,196      rpi_axi_pmu/arm_amax/
        39,623,624      rpi_axi_pmu/arm_wwait/
        43,482,567      rpi_axi_pmu/arm_wtrans/
             2,197      rpi_axi_pmu/arm_wmax/
               554      rpi_axi_pmu/arm_rwait/
            96,264      rpi_axi_pmu/arm_rtrans/
                 1      rpi_axi_pmu/arm_rmax/
                 5      rpi_axi_pmu/arm_rpend/
            48,148      rpi_axi_pmu/arm_ratrans/

       0.208600205 seconds time elapsed

And filtering `per_atrans` by `VPU_UC0` (`filter=1`) and `ARM` (`filter=11`):

  $ sudo perf stat -a \
      -e rpi_axi_pmu/per_atrans/ \
      -e rpi_axi_pmu/per_atrans,filter=1/ \
      -e rpi_axi_pmu/per_atrans,filter=11/ \
      -- sleep 1

   Performance counter stats for 'system wide':

            29,393      rpi_axi_pmu/per_atrans/
            19,934      rpi_axi_pmu/per_atrans,filter=1/
             9,452      rpi_axi_pmu/per_atrans,filter=11/

       1.001089440 seconds time elapsed

Tooling & AI Assistance
=======================
Per Documentation/process/coding-assistants.rst and
Documentation/process/generated-content.rst:
- Tools used: Google Antigravity (gemini-3.1-pro), Anthropic Claude, and
  Sashiko automated kernel patch review, alongside standard kernel tooling
  (scripts/checkpatch.pl, scripts/kernel-doc, make dt_binding_check).
- Summary of prompts and assistance:
  - Assisted in converting the downstream Raspberry Pi debugfs AXI monitor
    (drivers/perf/raspberrypi_axi_monitor.c) into a Linux perf PMU driver
    (drivers/perf/rpi_axi_pmu.c), generating the repetitive
    PMU_EVENT_ATTR_STRING sysfs event tables across SoC generations, the
    Device Tree binding schema (brcm,bcm2835-axiperf.yaml), and the
    admin-guide documentation (Documentation/admin-guide/perf/rpi-axi-pmu.rst).
  - Assisted with iterative review and fixes across revisions, including
    synchronization between atomic MMIO reads (pmu->lock) and deferred
    process-context VPU mailbox polling (vpu_mutex / vpu_work), scoped
    locking and compiler context-analysis annotations, bulk VPU mailbox
    reads, BCM2712 C0/D0 stepping detection and filter masks, and
    per-interval watermark tracking for level registers (*max and rpend).
- Portions affected:
  Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml,
  Documentation/admin-guide/perf/rpi-axi-pmu.rst, and
  drivers/perf/rpi_axi_pmu.c.
- Testing and verification:
  All generated code and tables were reviewed by the authors and tested on
  physical BCM2835, BCM2837, BCM2711 B0, BCM2712 C0, and BCM2712 D0
  hardware using perf list and perf stat (single-watcher multi-metric
  counting, perf stat -I interval watermark tracking, AXI master ID
  filtering, VPU firmware accessibility probing, and 10-bus multiplexing).

Changelog
=========
v19:
- Driver (Patches 2 & 3):
  - Track `pmu->timer_running` under `pmu->lock` so `0 -> 1` transitions of
    `pmu->active_events` (such as during `perf_rotate_context()`) do not
    re-arm `pmu->hrtimer` while it is already queued or executing, avoiding
    both a `WARN_ON(timer->is_queued)` race in `hrtimer_forward_now()` and
    100 ms timer resets when multiplexing intervals are shorter than 100 ms
    (per Sashiko).
  - Convert lock critical sections to scoped guards (`guard()` and
    `scoped_guard()`) from `linux/cleanup.h`, add compiler context-analysis
    locking annotations (`__guarded_by()`, `__must_hold()`,
    `__must_not_hold()`, `context_unsafe()`), and enable
    `CONTEXT_ANALYSIS_rpi_axi_pmu.o := y` in `drivers/perf/Makefile`.
  - Avoid ternary conditional between distinct `enum bcm2712d0_system_bus`
    and `enum bcm2712_system_bus` constants in `config_is_valid()` (`LLVM=1
    W=1` `-Wenum-compare-conditional`).

v18: https://lore.kernel.org/r/20261107040913.1384033-1-irogers@google.com
- Rebased onto v7.4-rc1.
- Device Tree Bindings (Patch 1, per Rob Herring and Sashiko):
  - Reworded `description:` in `brcm,bcm2835-axiperf.yaml` to avoid `: `
    inside the unquoted YAML 1.2 plain scalar (`make dt_binding_check` and
    `yamllint` clean).
- Driver & Documentation (Patches 2 & 3):
  - Added Dom Cobley's `Tested-by:` tags.

v17: https://lore.kernel.org/r/20261104030300.1140180-1-irogers@google.com
- Device Tree Bindings (Patch 1, per Krzysztof Kozlowski):
  - Clarified commit message so it describes the two MMIO register blocks
    rather than the driver's firmware mailbox IPC.
  - Dropped unneeded `|` from `description:` and dropped the redundant
    second example in `brcm,bcm2835-axiperf.yaml`.
- Driver & Documentation (Patches 2 & 3, per Dom Cobley):
  - Reset `event->hw.prev_count` to 0 in `rpi_axi_pmu_start()` for level
    counters (`*max` and `rpend`), and documented in `rpi-axi-pmu.rst`
    that level counters are only meaningful when not multiplexed.
  - Renamed BCM2712 C0 and D0 System buses after the BCM2712 block each
    port serves: `display_top` -> `display`, `rp1` -> `pcie_02`,
    `argon_top` -> `argon`, and `sdio_wifi` -> `emmc2`.

v16: https://lore.kernel.org/r/20261103041416.2940213-1-irogers@google.com
- Addressed Sashiko review feedback on v15 (Patch 2):
  - Returned early from `rpi_axi_pmu__validate_group()` when
    `leader == event` to avoid dereferencing `leader->ctx` (which is NULL
    during `event_init` for standalone events and group leaders) inside
    `for_each_sibling_event()` when `CONFIG_PROVE_LOCKING=y`.
  - Enforced `RPI_AXI_MAX_EVENTS` (66) during group validation in
    `rpi_axi_pmu__validate_event()`.
  - Dropped `depends on !RPI_AXIPERF` from `drivers/perf/Kconfig` as
    `RPI_AXIPERF` is only defined in the downstream Raspberry Pi kernel
    tree.

v15: https://lore.kernel.org/r/20261102234301.2242242-1-irogers@google.com
- Device Tree Bindings & MAINTAINERS (Patch 1):
  - Dropped `kernel-list@raspberrypi.com` from `maintainers:`, sorted
    `compatible:` alphabetically, and required both `reg` items (`System
    monitor registers` and `VPU monitor registers`) across all SoCs per
    Krzysztof Kozlowski.
  - Added `MAINTAINERS` entry and noted distinction from
    `brcm,bcm5301x-axi-pmu`.
- Driver & Hardware Validation Fixes (Patches 2 & 3, co-developed with Dom
  Cobley on https://github.com/raspberrypi/linux/pull/7671):
  - Added `Documentation/admin-guide/perf/rpi-axi-pmu.rst`.
  - Masked `*wait`/`*max` deltas to 28 bits (`GENMASK(27, 0)`) and `rpend`
    to 8 bits (`GENMASK(7, 0)`), and implemented per-read-interval
    watermark tracking (`counter_is_level()`) for `*max` and `rpend` with
    `prev_count` reset under `pmu->lock` in `rpi_axi_pmu_read()`.
  - Removed non-existent `ratrans` on BCM2835 and BCM2711, and corrected
    the BCM2835 VPU bus table (`0..13` matching BCM2711 plus `14 = sdram`).
  - Re-enabled the BCM2712 VPU monitor (`0x7ee00000`) via the firmware
    mailbox, added probe-time `rpi_axi_pmu_vpu_accessible()` verification,
    and hid `vpu_*` sysfs events via `.is_visible` when firmware support is
    unavailable.
  - Replaced per-event VPU mailbox reads with a single 44-word bulk read
    (`rpi_axi_pmu_vpu_read_watchers()`) with `__le32` endianness
    conversions (`cpu_to_le32()` / `le32_to_cpu()`) and `config_gen[]`
    tracking, and defaulted `hrtimer_interval_ms` to 1000 ms when the VPU
    mailbox is used.
  - Used `rpi_firmware_find_node()` to locate the firmware node.
  - Corrected BCM2712 sparse AXI master ID filter numbering
    (`BCM2712_FLT_MAX = 64`), added BCM2712 D0 runtime stepping detection
    (`pmu->axi_id_mask`), D0 System/VPU filter mask encoding, the 10-port
    D0 System bus table, and renamed `bstm_top`/`arb3`/`src`.

v14: https://lore.kernel.org/r/20261002175738.3242646-1-irogers@google.com
- Removed `firmware` phandle property from `brcm,bcm2835-axiperf.yaml` per
  Krzysztof Kozlowski.
- Removed `LINUX_VERSION_CODE` checks per Uwe Kleine-Koenig and Florian
  Fainelli.
- Separated BCM2835, BCM2711, and BCM2712 bus and filter tables, exposed
  all counter metrics per bus without synthetic `Bytes` scaling, and added
  bus-watcher reference counting and group validation.

v13: https://lore.kernel.org/r/20260815172712.50119-1-irogers@google.com
- Added `allOf`/`if` block in `brcm,bcm2835-axiperf.yaml` and cleaned up
  sysfs attribute definitions and comments.

v12: https://lore.kernel.org/r/20260815082048.4043217-1-irogers@google.com
- Added Device Tree binding patch (`brcm,bcm2835-axiperf.yaml`), split
  per-chip `attr_groups`, and returned `-EPROBE_DEFER` when firmware is not
  yet ready.

v11: https://lore.kernel.org/r/20260815082048.4043217-1-irogers@google.com
- Added `READ_ONCE()`/`WRITE_ONCE()` on `enabled[idx]` and restored
  `flush_work()` in `rpi_axi_pmu__exit()` so queued VPU watcher disables
  complete on module unload.

v10: https://lore.kernel.org/r/20260815082048.4043217-1-irogers@google.com
- Removed unused `num_started` state variable from `struct rpi_axi_hw_events`.

v9: https://lore.kernel.org/r/20260813064228.2799872-1-irogers@google.com
- Adjusted PMU and CPU hotplug registration order in `probe()` and
  simplified BCM2712 sysfs event visibility.

v8: https://lore.kernel.org/r/20260813064228.2799872-1-irogers@google.com
- Switched `pmu->lock` to `raw_spinlock_t` for `PREEMPT_RT` compatibility
  and reduced `RPI_AXI_PMU_TIMER_INTERVAL` from 2000 ms to 100 ms.

v7: https://lore.kernel.org/r/20260813052419.2770841-1-irogers@google.com
- Isolated all BCM2712 definitions into Patch 2 and initialized
  `vpu_disable_pending` on watcher allocation.

v6: https://lore.kernel.org/r/20260813043533.2744442-1-irogers@google.com
- Fixed `Kconfig` `RASPBERRYPI_FIRMWARE` dependency, added
  `vpu_disable_pending` for VPU watcher teardown, and let the hrtimer
  self-terminate when `active_events == 0`.

v5: https://lore.kernel.org/r/20260812230800.2646749-1-irogers@google.com
- Added `monitor_running` tracking, deferred VPU watcher disablement to
  `vpu_work`, and protected `event->hw.state` updates under `pmu->lock`.

v4: https://lore.kernel.org/r/20260812052417.2361040-1-irogers@google.com
- Avoided global monitor reset when other watchers are active and fixed
  error handling on mailbox read failures.

v3: https://lore.kernel.org/r/20260812002728.2283079-1-irogers@google.com
- Switched hrtimer to `HRTIMER_MODE_REL_SOFT`, set `.suppress_bind_attrs =
  true`, and cleaned up probe error unwinding.

v2: https://lore.kernel.org/r/20260811235112.2267241-1-irogers@google.com
- Added `of_device_get_match_data()` chip selection, CPU affinity check in
  `event_init()`, and counter wrap delta masking.

v1: https://lore.kernel.org/r/20260811083828.2057695-1-irogers@google.com
- Initial submission.

Ian Rogers (3):
  dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 Documentation/admin-guide/perf/index.rst      |    1 +
 .../admin-guide/perf/rpi-axi-pmu.rst          |  167 +
 .../bindings/perf/brcm,bcm2835-axiperf.yaml   |   44 +
 MAINTAINERS                                   |    9 +
 drivers/perf/Kconfig                          |   13 +
 drivers/perf/Makefile                         |    2 +
 drivers/perf/rpi_axi_pmu.c                    | 4161 +++++++++++++++++
 7 files changed, 4397 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/rpi-axi-pmu.rst
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
 create mode 100644 drivers/perf/rpi_axi_pmu.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.455.g6c5a503b38-goog
