Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024561;
	b=z/3pMPvGRn2IJs7BKyxUAIjtZm/nrDJMDJC29bXAXgiMpTkR1QqP+SRZ93JbbwD6fQcp
	 VKzzpW1k9MfUMR7oQ04mN50lz0Kt/W64ankbuGyzUqGI60hL++TOTRsbuM9MqUINuFLbj
	 Gxw7iFhr0ACxxw3ydV6VLsoUyuH0t/bbao3Yi8rZgPUcmEQXPJhSyT4at3BlgP9YPfeL6
	 OdrXNxWHgKSbORuw+S7hokidIvz7hH5aMYUSKtoQJEMc0OiqGu7kSW5IskobmAbRipUaL
	 fawFNzQ8DrFAkfmW6SdYs8vw+CJQ+BiaHPOxoNNy1kSS55hj641Mnercr9rD+9FzXAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=zlpYgaP1/QtzbekvOD8Fxhr+3OZF6foxQvWKTQDABbk=;
	b=vKqbyDlcE5DJ521BUw6jaL6zXVfanGW4ZbVUdTJ4AVDRKO10wSWGo+7GbP56ci1tMR1f
	 R2BcbpyiTK/EDwLgiUxy5N2XtpgDyjqy+UQsyLPDF06re4Azx21uSRLv3UqAASSeBnFQM
	 4GMnM3ccp8TM9ZX5C1KAoVMR69Xc5cLPTii6wMYEB+2GQzaiuoo/AyzB5PpxoiJXmoUQx
	 Ki03TzHyU/XtNpuNqrRxqUZ4VDbZMtzeF6EZuOHG4NHPUnHMACqQqw84l14ICrKulKKZ9
	 yrkJHb0T6eYUv5uaCAQf/t3l3aPvdkIJPN4sexOM8jPe5IK3VgPArTIeCHkTjae1CNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="MarXW+/k";
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DEB606A326
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6DEB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MarXW+/k
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-4ad5e0ddc90so1372096fac.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794024560; x=1794629360; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zlpYgaP1/QtzbekvOD8Fxhr+3OZF6foxQvWKTQDABbk=;
        b=MarXW+/kr0A8s1dLvA0JNFWFIHchPMj64tfeMgQcaHQrUvH6PnV2NT1RcYzClXZQZO
         PUANH8yXgP7RBSEs/IkKxgJumP25xORjU557MAh6dtQl6Ux46hjfJ7YKYa3hWux62nbV
         YsnEukSSrOWyFsc+NOYzGhGRt482rlJIm+z/UWZ9UiivcFrjy6eU9wR+n2Zxg9Q4y0OM
         +87IKeEPpw1nm8Llhdl+Sus12jF4LKA8UgxyETpBIrNkTBb0medTaOlzay7tZ7ed3LTX
         9vH83ljoIMD4c/LpTPTNIVtLAdbraevZrT9jzUQhsc3IGCD0e17CkdSckWGHNt1iJDtj
         K9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794024560; x=1794629360;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlpYgaP1/QtzbekvOD8Fxhr+3OZF6foxQvWKTQDABbk=;
        b=Id1ilNJT8FyI981TDg07OpQ4FEYPVK6KowU1lpyXRX0v1Xmduepr9ms4fvPA4YO+v9
         vHASgN/cKbr+u+n2qhtKjACpY2weQDFvrTUaeUPgNkQdUEeMssQ4M6u5+nfKKCaO4dMi
         ENKp0lvK9GZOTtTFtJ/uhs/ecNo435rYqc31y2O69JuOnKv6rBbvnUtHgnyAqyVgYEkn
         nJKoeXL/UehbmuhhOGy3v8tfAYM3YEDcwQsIF4qyfyGeQGYWt5bB2hu6ZuyCgtXmQX4j
         LoBHs/0P4nb4IyxRrToSOqaSossH5nG6FKZPIQxdBBOmIXfaAhhP1sDbqmonY+aGrPsM
         Jvfg==
X-Forwarded-Encrypted: i=1; AL+hErEBMn78564XcTM82uqUbC9mXG4i+1AO87eOZFdKjENEnrlj0UbFVTc9N389n5cuSa7ZB0I7KOgVy3YYIHkhMDtS@vger.kernel.org
X-Gm-Message-State: APuU4Z9/8GvimYXmPlPINjYtJLhOvlo12e/XFhhZLUYE44Nrh0jWj8xu
	feq9DtJFmUX17hL10CaNqmIc+REZZwIyHkSO7xSq3VPA2ftLCTyw7jOY1G9Cv8qQvDRsytdPZIh
	ad+3b8JyK1w==
X-Received: from oabov23.prod.google.com ([2002:a05:6870:cb97:b0:49d:ce0f:a25d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:a802:10b0:498:c323:4a90
 with SMTP id 586e51a60fabf-4adbadf93e6mr1055645fac.33.1794024559549; Fri, 06
 Nov 2026 20:09:19 -0800 (PST)
Date: Fri,  6 Nov 2026 20:09:10 -0800
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
Message-ID: <20261107040913.1384033-1-irogers@google.com>
Subject: [PATCH v18 0/3] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Dom Cobley <popcornmix@gmail.com>, Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
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
    process-context VPU mailbox polling (vpu_mutex / vpu_work), bulk VPU
    mailbox reads, BCM2712 C0/D0 stepping detection and filter masks, and
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
v18:
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
 drivers/perf/Makefile                         |    1 +
 drivers/perf/rpi_axi_pmu.c                    | 4155 +++++++++++++++++
 7 files changed, 4390 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/rpi-axi-pmu.rst
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axiperf.yaml
 create mode 100644 drivers/perf/rpi_axi_pmu.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.455.g6c5a503b38-goog

