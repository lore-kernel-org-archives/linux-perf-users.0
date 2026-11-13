Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599765;
	b=BiCQyLGK/JglTgn2b7+csJp5+PWQF8HEq+jtPW4cP4ecv5/vuN9IwnfMdavEJXG5xjko
	 +aZktUkqKLC0JqkG9CvLkh1yASS6pCOIUWoFVtt0GA9o3WmyDU27L7IfzvcRvgdWeXKCv
	 GZC2TQClPCXFrb5bhxPxNq3t6U6LgfTDiG9ptExDBTh0Ip00WSv/h9JA6TuQV3Hra3Suc
	 dmIg8BXPvVtRO6sqQ80R/34dla0Vp+Yk4WBEyCbEvJtmrfKMK5DNeidPFy23MtvlRU5Ex
	 1kUAw1K40o+0uZaNAHPG83qBACrt47uOHJ8GFxc35w/vcxSgIRLZa1yXw1+Kbq1whCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=eTvRtn7YsqE6ogU2RhcGADPrfVQIEr/gvpsAjTl6bCU=;
	b=qjKilIcyEAgGSe2UNRFEsebntCS5NS89YYh1oXiqKc6CaKNmxF0q8U1sMwxReyG+Q2cg
	 +Y6nTnTDkCkVVXPvm3U4Fm6tdOYN3Zc6iLEe5kZsEl7MmuZFta9zMJdyaXNSwkH1yhpXV
	 XlJ2b90x7GiBSq+J5LhlvIcFS+r74TRGxG0HYI0wORDJFqGObakb19BxhT2KuleBSmf62
	 lsnCbDwHkAIHFEA3SR6OjYb2xEl9iQoSOgtb8feFxJTTjAMOLfGYf3pGpkpJChPojPDwJ
	 EtIibhabjKfeUEjZpnRGDG+81YwisUbxDgCtJ2ilxpRHXfIaqxKNYgXseWHZPLUzfgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L8QOfzJ8;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA4606A884
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19AA4606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L8QOfzJ8
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-378722fd4a3so1575599eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599764; x=1795204564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eTvRtn7YsqE6ogU2RhcGADPrfVQIEr/gvpsAjTl6bCU=;
        b=L8QOfzJ8gGqNLQZkkwm28ldmGV0nz78/pMlv8EogyiMFqAD3ZuXl4ZViyvi0XgttS5
         hNOOfKTDtNBVSlrqK4bsGeowTa1Am3TNA2FVHhMr6nKUpLtSj/r7nM5ggzy33f4z5McP
         L9aBLFxxArlSvGVDqdv0e7y3/9+ngpT+Q+IAt79Ius9YQe3ofhb7sanKNjTbS7G87TEG
         Kmv9jYO1RsAssFx5T5FP+XJ47+jNoKYtVcAvwhQ2J/aUlMMMa//aJ8DtzemldttGdxZj
         Dw49GJgpT3JTcmNbJGpzL+LCtIPV7ol8sC1JpfDOqlCjIBKUAcZQWg/Cv+Vw26fuKI3d
         OkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599764; x=1795204564;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eTvRtn7YsqE6ogU2RhcGADPrfVQIEr/gvpsAjTl6bCU=;
        b=FOKgCxlZx9xGYDu910sOI1AZ7RGCEZKsOBfQJoTamxVlnRPVX9BO+X9HmW6SvI14r7
         lQqN3kEhZjNVd5YdgG4gjFmGOHA55tU9Trnd07Y6kHcrYB3LDQoDm99QzkR7jUfxJnB3
         8u2lOcbEs8DISorfuAl3hpBmzj2HHd704XZVj7zm8FTRifInFjISncof060wt7sXcSj3
         d5lpag4eOE5yNNPPgNCy9w/jGZ2vBlbCNuupd2KPXHfQU2P+qCekeWl4U37QxZucY6vy
         sgV2zOeOOdrO/sZAZ9xDd168KKaoKwoy469khHW3u1UqqHuIHXPy05C5WwOzL8u3ccef
         9xqQ==
X-Gm-Message-State: APuU4Z8qv1zSUKg7Y6klGlynpF1agQ7oGlFr0iQsPP/qrA8PVH42x8Fp
	ADyzgaRuyhg/NR2c3Mv7mA/RC4nbfQKrzxJ0mMwTnONNzuzQ8D9WYJysER3IvzuVtN5M2M6rCS3
	SKkkPqqCwRw==
X-Received: from dycnd10.prod.google.com ([2002:a05:7301:c0a:b0:369:fbca:f649])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:835c:20b0:375:e4de:96d3
 with SMTP id 5a478bee46e88-3796721dfb7mr2998254eec.31.1794599763772; Fri, 13
 Nov 2026 11:56:03 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:45 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195601.2872738-1-irogers@google.com>
Subject: [PATCH v2 00/16] perf sysinfo: Add subcommand to probe and summarize
 PMU capabilities
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series adds the 'perf sysinfo' subcommand to probe and summarize
the PMU capabilities of a system, or of the system a perf.data file was
recorded on.

It depends on, and applies on top of, the series "perf: Per-env PMUs,
metric event sharing, and recorded event metrics":
https://lore.kernel.org/all/20261113195335.2865725-1-irogers@google.com/
Together they were sent as the single 41 patch v1 series "perf: Per-env
PMUs, recorded event metrics, and perf sysinfo":
https://lore.kernel.org/all/20261103234502.1008382-1-irogers@google.com/
which followed on from the v2 RFC series ("perf sysinfo: Add subcommand
to probe and summarize PMU capabilities"):
https://lore.kernel.org/linux-perf-users/20261017185442.2137623-1-irogers@g=
oogle.com/

Determining what performance monitoring hardware, driver capabilities,
and event/metric support are available on a system currently requires
piecing together sysfs files under /sys/bus/event_source/devices/,
perf list output, and trial-and-error perf_event_open() calls. Across
architectures and SoCs, support varies widely: an advanced system
provides core PMUs with zero-skid precise event sampling
(PEBS/IBS/SPE), hardware branch stack recording (LBR/BRBE),
user-space counter reading (rdpmc), memory profiling (DATA_SRC),
hardware AUX trace PMUs, memory and PCIe/IO interconnect bandwidth
PMUs, and multi-level pipeline metric drill-down hierarchies, whereas
a minimal system may only offer software timer sampling.

   - Patch 1 exports perf_pmus__scan_skip_duplicates() and adds
     perf_pmu__num_duplicates() to count numbered uncore PMU instances.
   - Patch 2 exports perf_pmu__mem_events_init_pmu() and
     perf_pmu__mem_events_name() for per-PMU memory profiling events.
   - Patches 3-13 add struct perf_pmu::probed and perf_pmu__probe(),
     split into individual capability probes:
     - Patch 3: Basic event opening, counting, interrupt sampling, and
       branch stack sampling (PERF_SAMPLE_BRANCH_STACK).
     - Patch 4: Supported perf_event_sample_format flags (sample_type).
     - Patch 5: Supported precise_ip levels (:p, :pp, :ppp).
     - Patch 6: Privilege and execution-mode exclusion modifiers
       (exclude_user, exclude_kernel, exclude_hv, exclude_idle,
       exclude_host, exclude_guest).
     - Patch 7: Execution and AUX area features (leader_sampling,
       sw_grouping, auto-counter reload, aux_output, aux_pause,
       aux_sample, inherit, sample_freq, write_backward, callchain,
       data_src, weight, pinned, exclusive, format_lost, cgroup).
     - Patch 8: Event group size limits (max events counted
       simultaneously without multiplexing, for both all core counters
       and general-purpose counters only). The number of events accepted
       by perf_event_open() isn't reported as PMUs may accept groups that
       can never be scheduled.
     - Patch 9: User and interrupt sample register bitmasks
       (general-purpose and SIMD vector/predicate registers).
     - Patch 10: Interrupt registers that can only be sampled with
       precise sampling, such as x86 XMM registers captured by PEBS.
     - Patch 11: Memory profiling events (ldlat-loads, ldlat-stores,
       load-store) and supported memory sample formats.
     - Patch 12: User-space perf_event_mmap_page capabilities
       (cap_user_rdpmc, cap_user_time*, pmc_width, and live rdpmc
       verification).
     - Patch 13: Empirically measured branch instruction skid across
       precise_ip levels 0..3 using a noinline nop-runway loop.
   - Patch 14 adds the 'perf sysinfo' subcommand. By default,
     'perf sysinfo' outputs a colorized system capability summary,
     pipeline metric drill-down hierarchy (via <metric>_group chains),
     overall system rating (Advanced, Standard, Basic, Minimal), and any
     missing baseline features. Passing '-p'/'--pmus' (or a PMU glob
     filter, '-v'/'--verbose', '-a'/'--all', or '-j'/'--json') displays
     detailed per-PMU static and probed attributes.
   - Patch 15 adds the 'perf-sysinfo' man page documentation.
   - Patch 16 adds the 'perf sysinfo' shell test.

Changes since v1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Split from the v1 series into this series, which depends on the
  "perf: Per-env PMUs, metric event sharing, and recorded event
  metrics" series.
- Patch 1's perf_pmu__num_duplicates() reports a duplicate count of 1
  for core PMUs, as core PMUs are no longer skipped as duplicates.
- Rebased onto the latest perf-tools-next.
- Addressed Sashiko review feedback:
  - Probing: skip ftrace tracepoints and limit tracepoint candidates,
    don't try an all zero config for tracepoint, breakpoint, kprobe and
    uprobe PMUs, report tracefs errors, treat precise_ip as ignored by
    sampling-only PMUs where all levels open (AMD IBS), probe inherit
    with a task event, probe sample_freq with a low frequency, add
    perf_reg_probe_candidates() for architecture specific extended
    register candidates (x86 eGPRs/SSP and XMM), require rdpmc counts
    to advance and read kernel/perf_user_access for core PMUs.
  - 'perf sysinfo -j' IntrRegisters excludes precise only registers,
    matching the text output.
  - Only check register names in the sysinfo test on x86_64 and
    aarch64.

Changes since v2 RFC
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Split the two perf_pmu__probe() commits into 10 per-capability commits
  (Patches 3-13) and moved the 'perf sysinfo' commits to the end of the
  series (Patches 14-16).
- The per-perf_env PMU support used by 'perf sysinfo -i' is in the
  series this one depends on.

Example outputs
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Example default 'perf sysinfo' output on an Intel AlderLake hybrid system:

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
, R9, R10, R11, R12, R13, R14, R15
      Intr registers (precise sampling only): XMM0, XMM1, XMM2, XMM3, XMM4,=
 XMM5, XMM6, XMM7, XMM8, XMM9, XMM10, XMM11, XMM12, XMM13, XMM14, XMM15
      Memory events (probed): ldlat-loads, ldlat-stores (sample types: addr=
, weight, data_src, transaction, data_page_size, weight_struct)
      Exclusion modifiers: exclude_user, exclude_kernel, exclude_hv, exclud=
e_idle, exclude_host, exclude_guest
      Features: leader_sampling, sw_grouping, inherit, sample_freq, write_b=
ackward, callchain, data_src, weight, pinned, exclusive, format_lost, user_=
rdpmc, user_time, user_time_zero
      User space counter reading (rdpmc): available, enabled, working (widt=
h: 48 bits)
      Max event group size: 8
      Max GP event group size: 7

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
      Max event group size: 7
      Max GP event group size: 6

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

Ian Rogers (16):
  perf pmus: Expose duplicate uncore PMU scanning helpers
  perf mem-events: Expose PMU init and name formatting helpers
  perf pmu: Add perf_pmu__probe() for basic open, counting, and sampling
  perf pmu: Probe supported sample_type flags
  perf pmu: Probe precise_ip levels
  perf pmu: Probe privilege exclusion modifiers
  perf pmu: Probe execution and AUX area features
  perf pmu: Probe event group size limits
  perf pmu: Probe user and interrupt sample register masks
  perf pmu: Probe interrupt registers that require precise sampling
  perf pmu: Probe memory profiling events and sample formats
  perf pmu: Probe user-space mmap capabilities
  perf pmu: Probe branch instruction skid
  perf sysinfo: Add sysinfo subcommand
  perf docs: Add perf-sysinfo man page
  perf test: Add perf sysinfo shell test

 tools/perf/Build                              |    1 +
 tools/perf/Documentation/perf-sysinfo.txt     |  113 +
 tools/perf/Documentation/perf.txt             |    2 +-
 tools/perf/builtin-help.c                     |    3 +-
 tools/perf/builtin-sysinfo.c                  | 2024 ++++++++++++++++
 tools/perf/builtin.h                          |    1 +
 tools/perf/perf.c                             |    1 +
 tools/perf/tests/shell/sysinfo.sh             |   88 +
 tools/perf/util/mem-events.c                  |   12 +-
 tools/perf/util/mem-events.h                  |   20 +
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |   10 +
 tools/perf/util/perf_regs.c                   |   16 +
 tools/perf/util/perf_regs.h                   |    2 +
 tools/perf/util/pmu.c                         | 2145 +++++++++++++++++
 tools/perf/util/pmu.h                         |  197 +-
 tools/perf/util/pmus.c                        |   26 +-
 tools/perf/util/pmus.h                        |   21 +
 17 files changed, 4672 insertions(+), 10 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-sysinfo.txt
 create mode 100644 tools/perf/builtin-sysinfo.c
 create mode 100755 tools/perf/tests/shell/sysinfo.sh


base-commit: 4af65363b11fc4fe65fcb497f68bbe4f3e3a4d2c
prerequisite-patch-id: acc4e1da262cddf12ae8d1c74892fcebe33dc93f
prerequisite-patch-id: fa6ab66e2aa7716cbd182de0f92456f6b6edb60d
prerequisite-patch-id: fa99754455a4f9e681661837fb6d6835b7d425c5
prerequisite-patch-id: 492d797b54751da228948fac5f40f663f5ea3c62
prerequisite-patch-id: b99319e27324e7083fc6cd1ecd5aec042c562b53
prerequisite-patch-id: 696e5fff8cf5a4ce80bd1ed889d50bdaa78dc392
prerequisite-patch-id: ef1abbc7686bcb7785a16a90f1154260973c5f5e
prerequisite-patch-id: 27a18ce42c011a70a0464458dc50e67c75469e96
prerequisite-patch-id: 81ce66bcf2bf46a082a6660f32cc72fd22aa81c6
prerequisite-patch-id: 983a33d705bc24f9388e7949b1b8749a3864d736
prerequisite-patch-id: 2862db041ea93e0288a0a00f6f89485c16ed614e
prerequisite-patch-id: f1e7c89e852518a146a71eb66777eef402a6a0e0
prerequisite-patch-id: 0de8efa65dfeae2eafc0a5d73ef8886c789d6c6f
prerequisite-patch-id: 0dbd6a8a6e1d5da3c66ae81e965e6b959c2616f6
prerequisite-patch-id: 867e4c865f782d64c6c0f5a56b663d48c146c9a5
prerequisite-patch-id: b8f9e457fbc0e73d0d22a61d9019dfa72eed9169
prerequisite-patch-id: b07eae786bb7c5c8e4463bf1ebeac4751a99f5c8
prerequisite-patch-id: 1ec4d183f7e2cd4d8a677acec4bfec0bf8c48b07
prerequisite-patch-id: f831001f8da976c05c831a2233bd54879caef69c
prerequisite-patch-id: d1909df2b6cc3b5ed8fa59babde6867d17b76a2c
prerequisite-patch-id: 5668910716a6b85387440573e4ef9bbe0c84c1e9
prerequisite-patch-id: 54c6ff1d396ee78b279041a5be55c70ce8b908f1
prerequisite-patch-id: ef24f3acdcf55f5bc48ce3c7b40bdab0e75da477
prerequisite-patch-id: eae037d7c72f03e535eb9e3ffcb87d843592912b
prerequisite-patch-id: 44da8d15a6114a3205dc7fb18a84f1983593113a
prerequisite-patch-id: e665d48c6980205eeb2f51c8af9108cd30eacabb
prerequisite-patch-id: 37c850ea0c093556c4902e79a6698d4101ff837c
prerequisite-patch-id: 8f91bf53dd07618c46f435d925156bd8c11abb32
prerequisite-patch-id: d28eb7fb9c332c1dfe064afe794b4669af0647ee
prerequisite-patch-id: 815eff9d52cab3857b4e8d07c82fbf486af3b860
--=20
2.56.1.703.gf848ed807c-goog

