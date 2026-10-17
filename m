Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389C3C4B6A
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263294; cv=none; b=lvliPhLG/0DEju+wvwuFuy0bYy6ghaoXH/B5X1XNVRsxFtQgsEW/keT+K18v2xNQgsXmfC2mgloVRk8dx1pKREDDpUQQpFhSCggqswUzK1adUUIikk/D59iBw5trgcXhQX/05CXTEVCkhDNNLQTbEC6TkdxqFJ7X6f+2kG+CxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263294; c=relaxed/simple;
	bh=6D0/FOpsHDVXcuBKco/RJpGWdxbQUGXEUyid1XGpwFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UuQ0z0/mcIYT8hTDNiXhlJVK442++FGZ1VlDkE+bPsP3KSRsQc1eTuCeQwatnJhD9Xx8tn9LskA2PNrgArrRTe4+EVOmERgZ55lNpibcv6vb6ZErZhNNNB8yIsaS52Zwj+DyGMqSEZLv1htiR6e6cd2gwPlnKSvT3Wu9nxG14FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXSnuTs5; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXSnuTs5"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-17dc865c94cso309771c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 11:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792263292; x=1792868092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z3SvpnRUVSYPU9Fgvh1OOOrJevGnxFJ2JMA5vTQGd0Q=;
        b=eXSnuTs5rXyrcnXhlH/OXz5mPKZst4mdAT+uxeeNs3XKXhALENDzFMgf2IbMZE0Jbw
         ygXdCXopaRc7wFnwD4zZDL8l/4nf3gfUYf2ei2JBWfAhOBlcV0PqePZFAlyCou+cthO1
         +V27OSzeFOxloNnpAlaBMeQS2qDZBUaa1a0awItjR8LYb57zCzE6GzPF8jDQIXiC58hQ
         sKBg3unTQg9GpOxTgz6mchcEFYzUZyrATxLXd5PlBj4QJ0vhSF1/5S3lOkp7NEgSUPft
         V860Qo/oXvk8YNE1V7FsdBj6KN50hmr5ewmF2XYefnjIXjJyVO53SgxemVmxDNsDP9qR
         HCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792263292; x=1792868092;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z3SvpnRUVSYPU9Fgvh1OOOrJevGnxFJ2JMA5vTQGd0Q=;
        b=SsDHSm3KM0304UZ9zGydvVqHuqQD/d80owDgjWEDiKFVVQGntPO+SPPjGriUq6ye1m
         S/9r85zR+m2zIp8GjpZyPnCkbEOIgL9MCYF4QJptAS6N7CgTBOBcWxR7aCE/lVqh9w5J
         Y3sT4nKft7B276mJRhuHPYx3g135qWN4giJZcz82sgZqyoAuWmnFALdXYz4FvBE7XVW7
         /bjKv/O3xd3gfkloW+UQzL/mN3NPJlAFk5vuAOKVPgiscc3RO+0i58pFMHZOC4xmhTP2
         WCe/fU9OlhsxuaHFuNjDCMExSITTs4wsEiGdyniCOZ2m0LN0y5uLPC5OZl2isxeTPonL
         /PpQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnfxFml9IfCJmkIOXXUilPmsTqkK1zvf0uY23RJIvnjg91nmqDjtsjo640VwoSMglH4IHP/MQ61wLsniIYjnBu@vger.kernel.org
X-Gm-Message-State: AFq9FYIpJTLRKZLg6EqueDezCN1L9lXwkfGMGEOlpFgaeXK8zn4b0F9O
	gIkgpFMtXHvuh/IHUgkGSwrG5WiVVkoa+JxOENjKrvqisC7m8ysmH0PJHgoFT7DjMmNlDxq+WHk
	xQtCl+YJAlg==
X-Received: from dly17-n2.prod.google.com ([2002:a05:701b:2051:20b0:186:4a76:b5f7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:296:10b0:14d:f83b:f678
 with SMTP id a92af1059eb24-18513e7a0a8mr4687400c88.43.1792263291403; Sat, 17
 Oct 2026 11:54:51 -0700 (PDT)
Date: Sat, 17 Oct 2026 11:54:33 -0700
In-Reply-To: <20261016213258.945737-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016213258.945737-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017185442.2137623-1-irogers@google.com>
Subject: [RFC PATCH v2 0/9] perf sysinfo: Add subcommand to probe and
 summarize PMU capabilities
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, eranian@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Determining what performance monitoring hardware, driver capabilities,
and event/metric support are available on a system currently requires
piecing together sysfs files under /sys/bus/event_source/devices/,
perf list output, and trial-and-error perf_event_open() calls. Across
architectures and SoCs, support varies widely: an advanced system
provides core PMUs with zero-skid precise event sampling (PEBS/IBS/SPE),
hardware branch stack recording (LBR/BRBE), user-space counter reading
(rdpmc), memory profiling (DATA_SRC), hardware AUX trace PMUs, memory
and PCIe/IO interconnect bandwidth PMUs, and multi-level pipeline metric
drill-down hierarchies, whereas a minimal system may only offer software
timer sampling.

This RFC series introduces 'perf sysinfo' to inspect, actively probe,
and summarize the PMU and performance monitoring capabilities of a live
system or a recorded perf.data file:

- Patch 1 adds a from_env constructor parameter to perf_pmu__init() to
  distinguish PMUs reconstructed from perf_env headers from live host
  PMUs.
- Patch 2 adds perf_pmus__read_from_env() and perf_pmu__add_cap() to
  reconstruct core_pmus and other_pmus lists and their capabilities from
  perf.data headers.
- Patch 3 exports perf_pmus__scan_skip_duplicates() and adds
  perf_pmu__num_duplicates() to count numbered uncore PMU instances.
- Patch 4 exports perf_pmu__mem_events_init_pmu() and
  perf_pmu__mem_events_name() for per-PMU memory profiling events.
- Patch 5 adds struct perf_pmu::probed and perf_pmu__probe() to probe
  counting/sampling/branch_stack modes, precise_ip levels, sample format
  flags, privilege exclusion modifiers, execution features (leader
  sampling, software grouping, auto-counter reload, AUX pause/resume),
  and event group size limits.
- Patch 6 extends perf_pmu__probe() to probe user/interrupt sampling
  register masks (general-purpose and SIMD), memory profiling events,
  user-space rdpmc counter reading and PMC bit-width, and empirically
  measured branch instruction skid across precision levels.
- Patch 7 adds the 'perf sysinfo' subcommand. By default, 'perf sysinfo'
  outputs a colorized system capability summary, pipeline metric
  drill-down hierarchy (via <metric>_group chains), overall system
  rating (Advanced, Standard, Basic, Minimal), and any missing baseline
  features. Passing '-p'/'--pmus' (or a PMU glob filter,
  '-v'/'--verbose', '-a'/'--all', or '-j'/'--json') displays detailed
  per-PMU static and probed attributes.
- Patch 8 adds the 'perf-sysinfo' man page documentation.
- Patch 9 adds the 'perf sysinfo' shell test.

v2:
- Split the initial PMU environment, capability probing, and subcommand
  patches into 9 smaller, single-purpose patches.
- Disable the pager in 'perf sysinfo'.
- Fix ARM64 and RISC-V branch-range assembly errors in
  run_skid_branch_loop() by marking it noinline and reducing the .rept
  nop counts on ARM64 and RISC-V.
- Count tracepoint, drm, and hwmon events under sysfs rather than json
  in per-PMU and summary event totals.
- Replace glibc-specific ElfW() macro in get_self_uprobe_target() with
  standard <elf.h> Elf64_Ehdr/Elf64_Phdr and Elf32_Ehdr/Elf32_Phdr for
  musl libc compatibility.

Example default output on an Intel AlderLake hybrid system:

  $ perf sysinfo
  Summary:
    Core PMUs (2, hybrid): cpu_atom, cpu_core
    Core features:
      Interrupt-based sampling: supported
      Precise event sampling: supported (max_precise: 3 [3 - SAMPLE_IP must=
 have 0 skid, or uses randomization])
      Branch stack sampling (LBR/BRBE): supported (depth: 32 branches)
      User-space counter reading (rdpmc): supported
      Leader sampling: supported
      Memory profiling events (DATA_SRC): supported
      Hardware AUX trace PMUs: intel_bts, intel_pt
    Bus & uncore monitoring:
      Memory bandwidth PMUs: uncore_imc, uncore_imc_free_running
      PCIe / IO interconnect bandwidth PMUs: uncore_arb
    Events & metrics:
      Available events: 3161 total (120 sysfs, 3041 json) across 28 PMUs
      Available metrics: 438 metrics in 192 groups (advanced)
      Metric drill-down levels (6): L1 (TopdownL1: 7 metrics), L2 (TopdownL=
2: 14 metrics), L3 (TopdownL3: 44 metrics), L4 (TopdownL4: 45 metrics), L5 =
(TopdownL5: 15 metrics), L6 (TopdownL6: 9 metrics)
    System rating: Advanced (core PMU with precise sampling, branch stack (=
LBR), user rdpmc, bus PMUs, and metric drill-down)

Example filtered per-PMU output:

  $ perf sysinfo cpu_core
  cpu_core (type: 4 [PERF_TYPE_RAW], core):
    CPUs: 0-15 (16 CPUs)
    Capabilities: branches=3D32, max_precise=3D3, pmu_name=3Dalderlake_hybr=
id
    Formats: event (config:0-7), pc (config:19), edge (config:18), offcore_=
rsp (config1:0-63), ldlat (config1:0-15), inv (config:23), umask (config:8-=
15), frontend (config1:0-23), cmask (config:24-31)
    Events: 1563 total (20 sysfs, 1543 json)
    Memory events: ldlat-loads ({cpu_core/mem-loads-aux/,cpu_core/mem-loads=
,ldlat=3D30/}:P), ldlat-stores (cpu_core/mem-stores/P)
    Probed capabilities (event: cpu_core/cycles/):
      Modes: counting, sampling, branch_stack
      Precise sampling: :p (1 - SAMPLE_IP must have constant skid), :pp (2 =
- SAMPLE_IP requested to have 0 skid), :ppp (3 - SAMPLE_IP must have 0 skid=
, or uses randomization) (max_precise: 3)
      Measured branch skid (instructions from branch):
        level 0 (no :p): min 105, max 174, avg 156.8 (0/32 exact_ip)
        level 1 (:p)   : min 1, max 1, avg 1.0 (0/31 exact_ip)
        level 2 (:pp)  : min 0, max 0, avg 0.0 (31/31 exact_ip)
        level 3 (:ppp) : min 0, max 0, avg 0.0 (32/32 exact_ip)
      Sample types: ip, tid, time, addr, read, callchain, id, cpu, period, =
stream_id, raw, branch_stack, regs_user, stack_user, weight, data_src, iden=
tifier, transaction, regs_intr, aux, cgroup, data_page_size, code_page_size=
, weight_struct
      User registers: AX, BX, CX, DX, SI, DI, BP, SP, IP, FLAGS, CS, SS, R8=
, R9, R10, R11, R12, R13, R14, R15
      Intr registers: AX, BX, CX, DX, SI, DI, BP, SP, IP, FLAGS, CS, SS, R8=
, R9, R10, R11, R12, R13, R14, R15, XMM0, XMM1, XMM2, XMM3, XMM4, XMM5, XMM=
6, XMM7, XMM8, XMM9, XMM10, XMM11, XMM12, XMM13, XMM14, XMM15
      Memory events (probed): ldlat-loads, ldlat-stores (sample types: addr=
, weight, data_src, transaction, data_page_size, weight_struct)
      Exclusion modifiers: exclude_user, exclude_kernel, exclude_hv, exclud=
e_idle, exclude_host, exclude_guest
      Features: leader_sampling, sw_grouping, inherit, sample_freq, write_b=
ackward, callchain, data_src, weight, pinned, exclusive, format_lost, user_=
rdpmc, user_time, user_time_zero
      User space counter reading (rdpmc): available, enabled, working (widt=
h: 48 bits)
      Max event group size: 18 (active: 8)
      Max GP event group size: 16 (active: 7)

Example output on a Raspberry Pi 5 (ARM Cortex-A76):

  $ sudo perf sysinfo armv8_cortex_a76
  armv8_cortex_a76 (type: 9 [dynamic], core):
    CPUs: 0-3 (4 CPUs)
    Capabilities: slots=3D0x00000000, threshold_max=3D0x00000000, bus_slots=
=3D0x00000000, bus_width=3D0x00000000
    Formats: threshold_count (config1:2), event (config:0-15), long (config=
1:0), rdpmc (config1:1), threshold (config1:5-16), threshold_compare (confi=
g1:3-4)
    Events: 1336 total (40 sysfs, 1296 json)
    Probed capabilities (event: armv8_cortex_a76/cycles/):
      Modes: counting, sampling
      Precise sampling: not supported (0 - SAMPLE_IP can have arbitrary ski=
d)
      Measured branch skid (instructions from branch):
        level 0 (no :p): min 340, max 352, avg 346.2 (0/31 exact_ip)
      Sample types: ip, tid, time, addr, read, callchain, id, cpu, period, =
stream_id, raw, regs_user, stack_user, weight, data_src, identifier, transa=
ction, regs_intr, phys_addr, aux, cgroup, data_page_size, code_page_size, w=
eight_struct
      User registers: x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12=
, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27=
, x28, x29, lr, sp, pc
      Intr registers: x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12=
, x13, x14, x15, x16, x17, x18, x19, x20, x21, x22, x23, x24, x25, x26, x27=
, x28, x29, lr, sp, pc
      Exclusion modifiers: exclude_user, exclude_kernel, exclude_hv, exclud=
e_host, exclude_guest
      Features: leader_sampling, sw_grouping, inherit, sample_freq, write_b=
ackward, callchain, data_src, weight, pinned, exclusive, format_lost, user_=
time, user_time_zero, user_time_short
      User space counter reading (rdpmc): available, disabled (sysfs: 0) (w=
idth: 32 bits)
      Max event group size: 14 (active: 7)
      Max GP event group size: 13 (active: 6)

  $ sudo perf sysinfo
  Summary:
    Core PMUs (1): armv8_cortex_a76
    Core features:
      Interrupt-based sampling: supported
      Precise event sampling: missing (0 - SAMPLE_IP can have arbitrary ski=
d)
      Branch stack sampling (LBR/BRBE): missing
      User-space counter reading (rdpmc): missing/disabled
      Leader sampling: supported
      Memory profiling events (DATA_SRC): missing
      Hardware AUX trace PMUs: missing
    Bus & uncore monitoring:
      Memory bandwidth PMUs: missing
      PCIe / IO interconnect bandwidth PMUs: missing
    Events & metrics:
      Available events: 3695 total (2371 sysfs, 1324 json) across 11 PMUs
      Available metrics: 21 metrics in 5 groups (minimal)
      Metric drill-down levels: none (flat metrics only)
    System rating: Basic (core PMU with basic counting/sampling only; missi=
ng advanced features)
    Missing baseline features: PCIe/IO interconnect bandwidth PMUs, hardwar=
e AUX trace PMU, hardware branch stack sampling (LBR/BRBE), memory bus band=
width PMUs, memory load/store profiling events, multi-level pipeline drill-=
down metrics (<metric>_group), precise event sampling (PEBS/IBS/SPE), user-=
space counter reading (rdpmc)

This patch series was generated with the assistance of antigravity and
Gemini 4.0.

Ian Rogers (9):
  perf pmu: Add from_env parameter to perf_pmu__init()
  perf pmus: Add perf_pmus__read_from_env()
  perf pmus: Expose duplicate uncore PMU scanning helpers
  perf mem-events: Expose PMU init and name formatting helpers
  perf pmu: Add perf_pmu__probe() for live capability probing
  perf pmu: Probe registers, memory events, rdpmc, and branch skid
  perf sysinfo: Add sysinfo subcommand
  perf docs: Add perf-sysinfo man page
  perf test: Add perf sysinfo shell test

 tools/perf/Build                          |    1 +
 tools/perf/Documentation/perf-sysinfo.txt |  109 ++
 tools/perf/Documentation/perf.txt         |    2 +-
 tools/perf/builtin-help.c                 |    3 +-
 tools/perf/builtin-sysinfo.c              | 2010 ++++++++++++++++++++
 tools/perf/builtin.h                      |    1 +
 tools/perf/perf.c                         |    1 +
 tools/perf/tests/pmu-events.c             |    4 +-
 tools/perf/tests/shell/sysinfo.sh         |   71 +
 tools/perf/util/drm_pmu.c                 |    2 +-
 tools/perf/util/hwmon_pmu.c               |    2 +-
 tools/perf/util/mem-events.c              |   14 +-
 tools/perf/util/mem-events.h              |    3 +
 tools/perf/util/pmu.c                     | 2047 ++++++++++++++++++++-
 tools/perf/util/pmu.h                     |  139 +-
 tools/perf/util/pmus.c                    |  228 ++-
 tools/perf/util/pmus.h                    |    4 +
 tools/perf/util/tool_pmu.c                |    2 +-
 18 files changed, 4611 insertions(+), 32 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-sysinfo.txt
 create mode 100644 tools/perf/builtin-sysinfo.c
 create mode 100755 tools/perf/tests/shell/sysinfo.sh

--=20
2.56.0.212.g129ede20d9-goog

