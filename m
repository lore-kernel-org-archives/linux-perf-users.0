Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3794B3C1D78
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963878; cv=none; b=P9x1eFcmEhvTkJpOFdBzc4YVY5W3CnLkBvFyqvTwkgvV5nZ3PEGuGwmaXQkFn/oNBQjlAR0tB21UNbeK6ppTWXMo1aZvx1bIHQgu5Rq/qJEiK3pFzsSQS9ewY0tTcF5VQteULa7XxTLHAppSCRuqq8XIYAERGQJGzuPjwvRoS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963878; c=relaxed/simple;
	bh=I3dMMNMpIPJ4cj9rXpVxarbuaRmXbx0Fqu2GQiCuDm8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iPCCndz/XHAY2zM6QDIvaSSSoMszZQ/eCzdQvvsLzjVwNa08hEtB8Hc9FN3oZ4pEHXx4Ktx6/WsiLo70ACyktiPHWRXgX7UFEHOKDaua4uMJgg6Pcht58fyM7fVWZrKl076uriqWQqdjHiEEtADtRyVRtzrEMIqRMw124hSR7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m0zpB/wy; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m0zpB/wy"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-151ba226e1bso197940c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790963873; x=1791568673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wj/zEFZh6Rrd2hodv6ZgY9rOG0aUybzzPtp3MSsbQW0=;
        b=m0zpB/wyjSsxDjkbZbdFF8aZ9DOwieVu7VHr+l4u2rR4NvToXh4xVkfC8OtaRjR6hd
         TggK2JO3TukXpvwKPo0ueQmz2P6fV18IL65vzA/Uho0uHXCIXZFVTsyRuGAV+vbqjriR
         FE4RfdlaKmZee1xHmX5ILGu9R50vyyIc/VMMLJ8CWJeQDgY/CiyaNt2m+YbC+4wk5jY4
         zbWI4ecyBsOY689X+9VYtOkTpXMrJhRAW8Seti30x8pgqHHqKM2Wov3jCYlY27b0imYr
         LgekVjqXHO10ipcRW5BJZRshkaaT87ZdYDjBpXYAmVLnHZP6+vFet7dtO39uX6aG4ddp
         jqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790963873; x=1791568673;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wj/zEFZh6Rrd2hodv6ZgY9rOG0aUybzzPtp3MSsbQW0=;
        b=FIT8NnnHQdOYfwZMZ4bnKaxqqIbENR5Lf5fKlcQztc02wVaXbRVVRey7hThN0+cTnH
         8LdCb7FysHuDS5tTEmlWAzEXRdeqkgptCp+Ab8dcmSEuhh3gU7OPltU+e18mmirWMogp
         9SHfvsHkgTT7Rz0k31QNfhTdbOmtdQ0NLCrNlFY1AE+Cu0AfxxtUN9MZbHrolJTkGHsm
         718Eo+2t3SBfODXS+m69QZODD1ywsHA2rCu3xf9U/EqfpMLEb2681Ten0ETdq0Vmbj+x
         VlkN5mTvo+m8pI9dMtMAqwZ8gK223nX2cW/vcxdTGKKmvMQKZqNy9KPpnRvezkChFTEX
         2kig==
X-Forwarded-Encrypted: i=1; AKwUvBxX4MNph4BaTI1tZxSOaJyvXgTNDxsZLS+DdguLttsINC9hxrxOJAW34BufEZz/Lz29EIgj36WMGZE/+eLEYAvc@vger.kernel.org
X-Gm-Message-State: AFuF++nquQ1d6fa0tsPXRg4FE+2EzRhAsKz3c7juq6AxgPKP+r9rSQKG
	T6EHgmVcoZRZVnC1mWymKBS2n1sPKpivbww2jnZUXcyN8ndtX4HNAUDqb+qIM39y4A3710El17r
	jOadSojs7Hg==
X-Received: from dlbqs3.prod.google.com ([2002:a05:7023:d03:b0:14f:14f5:d3a1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:238f:b0:14c:96a4:b631
 with SMTP id a92af1059eb24-14f5cbd53b1mr4523116c88.30.1790963872116; Fri, 02
 Oct 2026 10:57:52 -0700 (PDT)
Date: Fri,  2 Oct 2026 10:57:33 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002175738.3242646-1-irogers@google.com>
Subject: [PATCH v14 0/3] perf: Add Raspberry Pi AXI PMU driver
From: Ian Rogers <irogers@google.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, 
	Kernel Maintenance <kernel-list@raspberrypi.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Motivation & Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Currently, Linux lacks a standard perf-API compatible driver for the
Broadcom AXI performance counter blocks on Raspberry Pi platforms. Prior
out-of-tree vendor solutions relied on custom debugfs nodes and ad-hoc
kthreads, preventing integration with standard Linux perf tooling (`perf st=
at`,
`perf list`, etc.).

This driver implements standard `struct pmu` hardware uncore callbacks
under `drivers/perf/`, exposing human-readable sysfs event aliases for all
11 hardware metrics per bus (`atwait`, `atrans`, `amax`, `wwait`, `wtrans`,
`wmax`, `rwait`, `rtrans`, `rmax`, `rpend`, `ratrans`) and 6-bit AXI master
ID filtering (`filter=3D0..50`) directly to user space.

Key Architectural Improvements & Features
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
1. Standard Linux Perf Integration:
   - Exposes uncore AXI interconnect events via
     `/sys/bus/event_source/devices/rpi_axi_pmu/`.
   - Supports up to 3 concurrently monitored buses per monitor
     (`NUM_BUS_WATCHER_RESULTS =3D 3`), with bus-watcher reference counting
     so all 11 counter metrics on the same `(monitor, bus, filter)` tuple
     share a single hardware watcher without multiplexing.
   - Enforces atomic group validation (`rpi_axi_pmu__validate_group`) to
     reject event groups requiring more than 3 watchers per monitor at
     `perf_event_open()` time, while supporting time-multiplexing across
     more than 3 ungrouped buses.
   - Supports hardware counter accumulation (`local64_add`) using full
     32-bit unsigned counter reads (`u32`) and periodic hrtimer polling
     (`POLL_INTERVAL_MS =3D 100`) to prevent counter saturation.

2. CPU Hotplug Support (`cpuhp`):
   - Registers dynamic CPU hotplug callbacks (`CPUHP_AP_ONLINE_DYN` via
     `cpuhp_state_add_instance()`).
   - Automatically migrates PMU context (`perf_pmu_migrate_context`) to an
     online CPU core when the designated CPU goes offline.

3. Hybrid Memory-Mapped & Mailbox Work Queue Architecture:
   - System Monitor (MMIO): Performs fast atomic-safe memory reads directly
     mapped over ARM physical memory space (`MON__SYSTEM`).
   - VPU Monitor (Mailbox IPC): For Broadcom BCM2835-BCM2711 platforms
     (RPi 1-4) when configured via `system-only`, VideoCore VPU monitor
     (`MON__VPU`) mailbox IPC calls are offloaded to process context via
     `schedule_work(&pmu->mailbox_work)` and serialized with an atomic
     snapshot cache (`cached_values`), avoiding sleeping in atomic/hrtimer
     context. The firmware node is discovered via
     `of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware")`
     and untranslated VideoCore bus addresses are read from the `reg`
     property via `of_property_read_u32_index()`.

4. Per-SoC Generation Support:
   - Patch 1 documents the Device Tree bindings (`brcm,bcm2835-axiperf`,
     `brcm,bcm2711-axiperf`, `brcm,bcm2712-axiperf`).
   - Patch 2 adds core driver support for Broadcom BCM2835 and BCM2711 with
     distinct per-SoC bus and AXI master ID filter tables matching the
     hardware topology of each generation.
   - Patch 3 expands support for Broadcom BCM2712 (Raspberry Pi 5), adding
     the BCM2712 System monitor pipelines (`DISPLAY_TOP`, `ARGON_TOP`,
     `BSTM_TOP`, `PCIE_01`, `XPT`, `ARM`, `SYSTEM_L2`, etc.) and 6-bit AXI
     master ID filter tables (51 filter IDs, `GENMASK(13, 8)`).

Hardware Validation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
The driver has been validated on Raspberry Pi 400 (BCM2711) and Raspberry
Pi 5 (BCM2712). Example on Raspberry Pi 5 monitoring 17 events across 3
buses (`bstm_top`, `arm`, `system_l2`) simultaneously without multiplexing:

  $ sudo perf stat -a \
      -e rpi_axi_pmu/bstm_top_atwait/,rpi_axi_pmu/bstm_top_atrans/,rpi_axi_=
pmu/bstm_top_amax/ \
      -e rpi_axi_pmu/bstm_top_wwait/,rpi_axi_pmu/bstm_top_wtrans/,rpi_axi_p=
mu/bstm_top_wmax/ \
      -e rpi_axi_pmu/bstm_top_rwait/,rpi_axi_pmu/bstm_top_rtrans/,rpi_axi_p=
mu/bstm_top_rmax/ \
      -e rpi_axi_pmu/bstm_top_rpend/,rpi_axi_pmu/bstm_top_ratrans/ \
      -e rpi_axi_pmu/arm_rtrans/,rpi_axi_pmu/arm_wtrans/,rpi_axi_pmu/arm_rm=
ax/,rpi_axi_pmu/arm_wmax/ \
      -e rpi_axi_pmu/system_l2_rtrans/,rpi_axi_pmu/system_l2_wtrans/ \
      -- python3 -c 'a =3D bytearray(256 * 1024 * 1024); b =3D bytearray(a)=
'

   Performance counter stats for 'system wide':

                   0      rpi_axi_pmu/bstm_top_atwait/
                  64      rpi_axi_pmu/bstm_top_atrans/
                   0      rpi_axi_pmu/bstm_top_amax/
                   0      rpi_axi_pmu/bstm_top_wwait/
                   0      rpi_axi_pmu/bstm_top_wtrans/
                   0      rpi_axi_pmu/bstm_top_wmax/
                   0      rpi_axi_pmu/bstm_top_rwait/
                 256      rpi_axi_pmu/bstm_top_rtrans/
                   0      rpi_axi_pmu/bstm_top_rmax/
                 190      rpi_axi_pmu/bstm_top_rpend/
                  64      rpi_axi_pmu/bstm_top_ratrans/
          10,987,780      rpi_axi_pmu/arm_rtrans/
          17,265,030      rpi_axi_pmu/arm_wtrans/
               2,519      rpi_axi_pmu/arm_rmax/
               1,093      rpi_axi_pmu/arm_wmax/
                   0      rpi_axi_pmu/system_l2_rtrans/
                   0      rpi_axi_pmu/system_l2_wtrans/

         0.165352897 seconds time elapsed

Additionally verified on Raspberry Pi 5:
- 6-bit AXI master ID filtering (`filter=3D0..50` accepted, with active
  traffic on `filter=3D16..23` and `filter=3D32..43` confirming bit 5 is
  decoded in BCM2712 hardware, and `filter=3D51` rejected with `-EINVAL`).
- Time-multiplexing across all 13 BCM2712 buses and atomic group rejection
  (`-EINVAL`) when grouping 4 distinct buses.
- Live CPU hotplug context migration when offlining `CPU0`.

Changes since v13
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Addresses feedback from the upstream v13 review as well as downstream
review on https://github.com/raspberrypi/linux/pull/7571 (with the
corresponding updates tracked in
https://github.com/raspberrypi/linux/pull/7671):

- Device Tree Bindings (Patch 1):
  - Removed the `firmware` phandle property and `allOf` conditional from
    `brcm,bcm2835-axiperf.yaml` per Krzysztof Kozlowski's review; the
    driver now locates `raspberrypi,bcm2835-firmware` via
    `of_find_compatible_node()`.
  - Set `reg` `minItems: 2` (`MON_SYSTEM` and `MON_VPU`) and updated the
    example to use the BCM2712 address map (`0x7c012800` / `0x7e000000`).
- Core Driver & SoC Support (Patches 2 & 3):
  - Removed all `LINUX_VERSION_CODE` conditional checks per Uwe
    Kleine-K=C3=B6nig and Florian Fainelli.
  - Separated BCM2835, BCM2711, and BCM2712 bus and AXI master ID filter
    tables (`CHIP_BCM2835`, `CHIP_BCM2711`, `CHIP_BCM2712`) to match the
    hardware definitions per https://github.com/raspberrypi/linux/pull/7571=
.
  - Fixed VPU mailbox base address lookup to read untranslated 32-bit
    VideoCore peripheral addresses via `of_property_read_u32_index()`
    instead of CPU-translated `platform_get_resource()` addresses, and
    skipped mapping `MON_VPU` on BCM2712 (`CHIP_BCM2712`).
  - Widened the AXI master ID filter field from 5 bits to 6 bits
    (`GENMASK(13, 8)` in hardware, `config:10-15` in perf attr) to support
    all 51 BCM2712 filter IDs without truncation.
  - Replaced 31-bit counter masking (`& 0x7FFFFFFF`) with full 32-bit
    unsigned reads (`u32`) and removed speculative `scale=3D"32"` /
    `unit=3D"Bytes"` sysfs attributes so raw transaction, cycle, and latenc=
y
    counts are reported accurately.
  - Added bus-watcher reference counting and
    `rpi_axi_pmu__validate_group()` so multiple metrics on the same
    `(monitor, bus, filter)` share a single hardware watcher and
    unschedulable event groups fail at `perf_event_open()` with `-EINVAL`.
  - Switched CPU hotplug registration to exported
    `cpuhp_state_add_instance()` with an online callback
    (`rpi_axi_pmu_online_cpu`) and updated `cpumask_show()` to use
    `sysfs_emit()`.
  - Fixed `Kconfig` dependencies (`ARCH_BCM2835`, `RASPBERRYPI_FIRMWARE`,
    and `!RPI_AXIPERF`).

Ian Rogers (3):
  dt-bindings: perf: Add Broadcom Raspberry Pi AXI PMU definition
  perf: Add Raspberry Pi BCM2835 AXI PMU driver
  perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

 .../bindings/perf/brcm,bcm2835-axiperf.yaml   |   71 +
 drivers/perf/Kconfig                          |   13 +
 drivers/perf/Makefile                         |    1 +
 drivers/perf/rpi_axi_pmu.c                    | 3397 +++++++++++++++++
 4 files changed, 3482 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/brcm,bcm2835-axi=
perf.yaml
 create mode 100644 drivers/perf/rpi_axi_pmu.c

--=20
2.56.0.rc1.315.gc6ed9934b7-goog

