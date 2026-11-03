Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749509;
	b=iod+UwnLJJtPNSB90Bf4D92p9Kh6KyR/V/9bLdMn0S2l+ubzLw0lS/kxygHfs2FDbE4e
	 qDRFEMdvwUDj+T3UoB2Orwx7oG62pbU2vJAYiTGZO3rh+nvY8TCTCisHCw8fj3K2vCMAW
	 6Upbox9IOgPGrVHpp1w173HbZ3rGgkPAYUah/tUeFUEkzdJc5xGzCrji8EkPPRiGHy/PW
	 lrV74qy8sqjN7JMzOrEdxl4bsPGuvkbcefn69Cp2e/fd1lKDusanVai2WH5+FEMM1ax8N
	 ETX1pk3RTTueUpwjHwQMGiDK9K8QTBuCiMcpks8+5cwGzu62hQggJpA509G/6J2fwqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IpQWIBpD/+OCXH8zrnCK3RQ3klhJs2Ghlka3UIeP5sM=;
	b=EYH9eaNuWFTxu5uwJF9h8VNWu6dpJy1+7/Qjhbfw0qVjgslZm48s6LW6BSNF5982diC6
	 epQ9lnqljB4mOwzH4KoM5dseIDzGLWu+jh9eqhO//D/ft8YArnmQXjqVvG2iWlZsFKFQc
	 wuEao+z7EDwiMrEuqqNzinWXGTzIonAa/ekqnbztl+KB4lVDc1C3DOX0dAJnQhCTKaBIb
	 iQFgmaHBXFeEPmFh9bk8Ug3sr+ZvXAoDP32Bov0802lYNZx6Id1yC2iPMe3JWl69iK0fP
	 MdLX/XNWOHEdH9oGa0dC9Fj+mVMkuyO26IA0SCXPaDtVhhn17KzWdbLPCu5Rn0EIOSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mIY3LlaZ;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12634606A31B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12634606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mIY3LlaZ
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-351788121cfso428653eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749507; x=1794354307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IpQWIBpD/+OCXH8zrnCK3RQ3klhJs2Ghlka3UIeP5sM=;
        b=mIY3LlaZ7GqTyO5eT1DDmOxuuMWfABnWld5YxWJCnuKcs1S9PfjZHh5KfqyMmr47Hr
         uQw5wQWLF4OYjvhWO1KzPKAJ8CYgLz2IauNZJSyBMnH9cdqeH09w1BYgRwS1PsrT4ysA
         DFaND5C0vqroWOkrcLZlVzAHmE+NtXuVwqXNwriSHvEzwqAMSLb1FoWksM30GQFPMZiM
         Cv5ZqkTA5OeZ3D0U0BDk36SvwtptBFR7bUpTAhA60UC5UrkniHT0aKBN+B3v3KdTqSaJ
         esz1FtVL22SrUrhw8i2qHp1WUDJnUiagkuIOTLexEbjvTk4xipw1yweL9C4mKpoPC33w
         Daaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749507; x=1794354307;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IpQWIBpD/+OCXH8zrnCK3RQ3klhJs2Ghlka3UIeP5sM=;
        b=KGGa9fG4jQonEH5Wsfkfs8RLh0dL8rSr2/uj2nnX+/upLM3PtY/ygqrIBng9iVhS2d
         7gg8431f3sfOHeoL5xcFo7DnB4XYBDWIZs8PcshSF8oJDH+0NsM9lJ2t/Bl3nnc3L64+
         y7hMkDxF562Os7g6OafXG6CKQJYRNUkPjaYHnQm3gEGmQwLqk1jWmZ9wDowkrNJq2WN6
         nrMJBMdy9swM5rApb256VZQsSrvPXgteGxXFD+Usam9/EjGD5QJIGNI4YY7tRLbauN/V
         6X6ET7PiNs0fpA/xZQA1Z1a09RnarVYy/IBf5th3/EEwR3gGpNSguXysgDjTmvJjVFXS
         UnTw==
X-Gm-Message-State: APuU4Z+5y8fwt0z85b56zANe5hiOqVwASonaJ0taXX21turvlLxMWHUx
	0FqkQiTBzW324M0NG6KzpYpx4Wh3yWcxiCuGjnJ8f48oN518nVLU5nCWctPAD5OJSh/r2aTKxem
	93QZWRdponnbS2nvv+hZE5GpTcMGyqpEwsfaLseiuiiGWClC0tu0156WeE5Dcd4j6aBgrm0EylQ
	E7g9lPj6dhcIC5BXvoKdPy07PcUJkXJBzYcw/VhLD/Jfd6sfeWo3pDV9k=
X-Received: from dldyq16-n1.prod.google.com ([2002:a05:701b:4550:10b0:1ad:eb35:4dc3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2713:b0:144:de98:eec1
 with SMTP id a92af1059eb24-1ac59dd175fmr22069188c88.11.1793749506730; Tue, 03
 Nov 2026 15:45:06 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:16 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-1-irogers@google.com>
Subject: [PATCH v1 00/41] perf: Per-env PMUs, recorded event metrics, and perf sysinfo
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series refactors PMU state management into struct perf_env, enables
computing and displaying metrics from recorded perf.data files in
'perf stat report' and 'perf script', adds live PMU capability probing,
and introduces the 'perf sysinfo' subcommand.

It follows on from the v2 RFC series ("perf sysinfo: Add subcommand to
probe and summarize PMU capabilities"):
https://lore.kernel.org/linux-perf-users/20261017185442.2137623-1-irogers@g=
oogle.com/
Because the series has grown substantially beyond 'perf sysinfo' with
the per-perf_env PMU refactoring and 'perf stat record'/'perf stat report'
metric support, it is being sent as a non-RFC v1 series.

Overview of the series
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. Per-perf_env PMU state (struct perf_pmus) and perf.data reconstruction
   (Patches 1-13):
   Previously, core_pmus, other_pmus, and sysfs scanning state were
   global variables in tools/perf/util/pmus.c, preventing perf from
   maintaining both the live host's PMUs and a recorded perf.data
   session's PMUs simultaneously.

   - Patch 1 makes lazy perf_env initialization thread-safe using
     env->env_sem.
   - Patch 2 introduces the host_env() singleton to represent the live
     host environment explicitly, replacing the global perf_env variable
     and session->header.env fallbacks.
   - Patch 3 adds a from_env parameter to perf_pmu__init() to
     distinguish PMUs reconstructed from perf_env headers from live host
     PMUs so they never query host sysfs or get cast via container_of()
     to struct hwmon_pmu or struct drm_pmu.
   - Patches 4-6 introduce struct perf_pmus embedded in struct perf_env
     (accessed via perf_env__pmus()) and pass struct perf_pmus to the
     PMU find and scan helpers.
   - Patches 7-9 record the ELF machine (e_machine) of each pmu-events
     table's CPUIDs in struct pmu_events_map, so host lookups only
     consider the host architecture's tables, find the core events and
     metrics tables by e_machine rather than an architecture name, and
     pass the e_machine of the CPUIDs to strcmp_cpuid_str().
   - Patch 10 moves the architecture-specific strcmp_cpuid_str()
     implementations from arch/{x86,arm64}/util/header.c into common
     tools/perf/util/header.c, selecting the comparison by e_machine, so
     CPUID matching works across architectures when analyzing cross-arch
     perf.data files.
   - Patches 11-12 move the arm64 CPUID matching test to
     tools/perf/tests so it runs on all architectures, and add CPUID
     matching tests for exact (test/common), x86, PowerPC, RISC-V and
     s390 CPUIDs.
   - Patch 13 adds perf_pmus__read_from_env() and perf_pmu__add_cap() to
     reconstruct a perf_env's core_pmus and other_pmus lists,
     capabilities, CPU maps, and JSON event/metric tables from perf.data
     headers.

2. Recorded event metrics in 'perf stat report' and 'perf script'
   (Patches 14-25):
   With per-perf_env PMUs reconstructed from perf.data headers, perf can
   resolve the recorded machine's PMUs and JSON metric tables offline
   and match metrics against recorded evsels.

   - Patch 14 passes struct perf_pmus to metricgroup__for_each_metric()
     and pmu_metrics_table__find().
   - Patch 15 moves the matching of metrics to recorded events
     (metricgroup__add_matching_metrics()) from builtin-script.c into
     util/metricgroup.c.
   - Patch 16 moves the encoding and decoding of metric-id term values
     into parse-events.c so the metric-id is decoded when the evsel is
     created, rather than metricgroup rewriting each evsel's metric-id
     after parsing.
   - Patch 17 generalizes evsel::metric_id to a set of unique
     evsel::metric_ids. When events are parsed from metric groups, the
     metric-id is part of the parsed event name and stored on the evsel.
     When matching metrics to recorded events in a perf.data file,
     different metrics may refer to the same recorded evsel using
     different metric-ids (or the recorded event may have been recorded
     without a metric-id); storing a set of metric_ids on the evsel
     allows prepare_metric() to populate the expression context with all
     identifiers associated with the evsel. The set's representation is
     private to evsel.c and accessed through evsel__add_metric_id(),
     evsel__copy_metric_ids(), evsel__has_metric_id(),
     evsel__shares_metric_id() and the evsel__for_each_metric_id()
     callback iterator. evsel__metric_id(), which would arbitrarily return =
the
     first identifier of the set, is removed.
   - Patch 18 adds perf_pmu__for_each_name_from_config() to find the event
     names of a PMU for an encoding, including legacy hardware and cache
     event names from the legacy event tables, and uses it for
     perf_pmu__name_from_config().
   - Patch 19 improves metricgroup__add_matching_metrics() to parse each
     candidate metric's events against the target struct perf_pmus and
     match them to recorded evlist entries by normalized hardware
     counter keys (pmu_type, config, config1, config2, config3, and
     privilege exclusion bits), supporting PERF_TYPE_RAW extended PMU
     type encodings, uncore PMU instance fan-out, and perf_event_paranoid
     privilege exclusion fallbacks.
   - Patch 20 adds metricgroup__add_recorded_metrics() and
     metricgroup__add_matching_metric_groups() to reconstruct the
     metrics requested on a recorded 'perf stat record' command line
     from perf_env (including -M, --transaction, --smi-cost, --topdown,
     -d, or the Default metricgroups when no events or metrics were
     specified), or optionally add all matching JSON metrics when
     --all-metrics is enabled.
   - Patch 21 fixes 'perf script -F +metric' sample-based metric
     calculation to use per-sample period deltas rather than raw
     monotonically increasing counter values.
   - Patch 22 stops 'perf script -F metric' dropping samples whose CPU
     isn't in the evsel's CPU map, which for perf record data is the
     host's online CPUs.
   - Patch 23 enables displaying metrics for recorded events in
     'perf stat report' (and adds --all-metrics and stat.all-metrics).
   - Patch 24 enables displaying metrics for 'perf stat record'
     PERF_RECORD_STAT data in 'perf script' (and adds --all-metrics).
   - Patch 25 adds a shell test verifying metric reporting across
     'perf stat record', 'perf stat report', and 'perf script'.

3. Live PMU capability probing via perf_pmu__probe() (Patches 26-38):
   - Patch 26 exports perf_pmus__scan_skip_duplicates() and adds
     perf_pmu__num_duplicates() to count numbered uncore PMU instances.
   - Patch 27 exports perf_pmu__mem_events_init_pmu() and
     perf_pmu__mem_events_name() for per-PMU memory profiling events.
   - Patches 28-38 add struct perf_pmu::probed and perf_pmu__probe(),
     split into individual capability probes:
     - Patch 28: Basic event opening, counting, interrupt sampling, and
       branch stack sampling (PERF_SAMPLE_BRANCH_STACK).
     - Patch 29: Supported perf_event_sample_format flags (sample_type).
     - Patch 30: Supported precise_ip levels (:p, :pp, :ppp).
     - Patch 31: Privilege and execution-mode exclusion modifiers
       (exclude_user, exclude_kernel, exclude_hv, exclude_idle,
       exclude_host, exclude_guest).
     - Patch 32: Execution and AUX area features (leader_sampling,
       sw_grouping, auto-counter reload, aux_output, aux_pause,
       aux_sample, inherit, sample_freq, write_backward, callchain,
       data_src, weight, pinned, exclusive, format_lost, cgroup).
     - Patch 33: Event group size limits (max events counted
       simultaneously without multiplexing, for both all core counters
       and general-purpose counters only). The number of events accepted
       by perf_event_open() isn't reported as PMUs may accept groups that
       can never be scheduled.
     - Patch 34: User and interrupt sample register bitmasks
       (general-purpose and SIMD vector/predicate registers).
     - Patch 35: Interrupt registers that can only be sampled with
       precise sampling, such as x86 XMM registers captured by PEBS.
     - Patch 36: Memory profiling events (ldlat-loads, ldlat-stores,
       load-store) and supported memory sample formats.
     - Patch 37: User-space perf_event_mmap_page capabilities
       (cap_user_rdpmc, cap_user_time*, pmc_width, and live rdpmc
       verification).
     - Patch 38: Empirically measured branch instruction skid across
       precise_ip levels 0..3 using a noinline nop-runway loop.

4. 'perf sysinfo' subcommand, documentation, and test (Patches 39-41):
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

   - Patch 39 adds the 'perf sysinfo' subcommand. By default,
     'perf sysinfo' outputs a colorized system capability summary,
     pipeline metric drill-down hierarchy (via <metric>_group chains),
     overall system rating (Advanced, Standard, Basic, Minimal), and any
     missing baseline features. Passing '-p'/'--pmus' (or a PMU glob
     filter, '-v'/'--verbose', '-a'/'--all', or '-j'/'--json') displays
     detailed per-PMU static and probed attributes.
   - Patch 40 adds the 'perf-sysinfo' man page documentation.
   - Patch 41 adds the 'perf sysinfo' shell test.

Changes since v2 RFC
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Dropped RFC status and restarted numbering at v1 as the series expanded
  to include per-perf_env PMU management and recorded metric reporting.
- Added thread-safe lazy perf_env initialization and the host_env()
  singleton (Patches 1-2).
- Encapsulated global PMU lists and scan state into struct perf_pmus
  embedded in struct perf_env and updated PMU find/scan callers
  (Patches 4-6).
- Unified strcmp_cpuid_str() across all architectures in
  tools/perf/util/header.c, selecting the comparison by the ELF machine
  of the CPUIDs, which is recorded for each pmu-events table, and made
  the CPUID matching test architecture independent (Patches 7-12).
- Added recorded-event metric matching and shadow counter evaluation in
  util/metricgroup.c, enabled metric reporting in 'perf stat report' and
  'perf script' (with --all-metrics and stat.all-metrics), fixed
  'perf script -F +metric' sample-based metrics, and added a shell test
  (Patches 14-25).
- Split the two perf_pmu__probe() commits into 10 per-capability commits
  (Patches 28-38) and moved the 'perf sysinfo' commits to the end of the
  series (Patches 39-41).

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

Ian Rogers (41):
  perf env: Make lazy perf_env initialization thread-safe
  perf env: Add host_env() singleton
  perf pmu: Add from_env parameter to perf_pmu__init()
  perf pmus: Introduce struct perf_pmus and perf_env__pmus()
  perf pmus: Pass struct perf_pmus to find helpers
  perf pmus: Pass struct perf_pmus to scan helpers
  perf pmu-events: Add e_machine to struct pmu_events_map
  perf pmu-events: Pass e_machine to find_core_*_table()
  perf header: Pass e_machine to strcmp_cpuid_str()
  perf header: Support CPUID matching across all architectures
  perf test: Make the CPUID matching test architecture independent
  perf test: Add CPUID matching tests for other architectures
  perf pmus: Add perf_pmus__read_from_env()
  perf metricgroup: Pass struct perf_pmus to
    metricgroup__for_each_metric()
  perf metricgroup: Move matching of metrics to recorded events from
    perf script
  perf parse-events: Decode metric-id terms when adding events
  perf evsel: Generalize metric_id to a set of metric_ids
  perf pmu: Add perf_pmu__for_each_name_from_config()
  perf metricgroup: Improve matching of metrics to recorded events
  perf metricgroup: Add metricgroup__add_recorded_metrics()
  perf script: Fix metrics computed from samples
  perf script: Don't drop metric samples for CPUs missing from the evsel
  perf stat report: Display metrics for recorded events
  perf script: Display metrics for perf stat record data
  perf test: Add stat record metrics test
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
 tools/perf/Documentation/perf-config.txt      |    7 +
 tools/perf/Documentation/perf-script.txt      |    6 +
 tools/perf/Documentation/perf-stat.txt        |    5 +
 tools/perf/Documentation/perf-sysinfo.txt     |  113 +
 tools/perf/Documentation/perf.txt             |    2 +-
 tools/perf/arch/arm/util/auxtrace.c           |    9 +-
 tools/perf/arch/arm/util/cs-etm.c             |    3 +-
 tools/perf/arch/arm64/include/arch-tests.h    |    1 -
 tools/perf/arch/arm64/tests/Build             |    1 -
 tools/perf/arch/arm64/tests/arch-tests.c      |    4 -
 tools/perf/arch/arm64/tests/cpuid-match.c     |   37 -
 tools/perf/arch/arm64/util/header.c           |   48 -
 tools/perf/arch/arm64/util/pmu.c              |    3 +-
 tools/perf/arch/x86/tests/amd-ibs-period.c    |    5 +-
 .../arch/x86/tests/amd-ibs-via-core-pmu.c     |    3 +-
 tools/perf/arch/x86/tests/hybrid.c            |    6 +-
 tools/perf/arch/x86/tests/topdown.c           |    6 +-
 tools/perf/arch/x86/util/auxtrace.c           |    9 +-
 tools/perf/arch/x86/util/evsel.c              |    6 +-
 tools/perf/arch/x86/util/header.c             |   64 -
 tools/perf/arch/x86/util/intel-bts.c          |    4 +-
 tools/perf/arch/x86/util/intel-pt.c           |    4 +-
 tools/perf/arch/x86/util/pmu.c                |   10 +-
 tools/perf/arch/x86/util/topdown.c            |    3 +-
 tools/perf/bench/pmu-scan.c                   |   16 +-
 tools/perf/bench/synthesize.c                 |   13 +-
 tools/perf/builtin-buildid-list.c             |    5 +-
 tools/perf/builtin-help.c                     |    3 +-
 tools/perf/builtin-inject.c                   |    3 +-
 tools/perf/builtin-kallsyms.c                 |   12 +-
 tools/perf/builtin-list.c                     |   19 +-
 tools/perf/builtin-lock.c                     |    6 +-
 tools/perf/builtin-record.c                   |    2 +-
 tools/perf/builtin-script.c                   |  309 +--
 tools/perf/builtin-stat.c                     |   63 +-
 tools/perf/builtin-sysinfo.c                  | 2022 ++++++++++++++
 tools/perf/builtin-top.c                      |   17 +-
 tools/perf/builtin-trace.c                    |   18 +-
 tools/perf/builtin.h                          |    1 +
 tools/perf/perf.c                             |    4 +
 tools/perf/pmu-events/empty-pmu-events.c      |   34 +-
 tools/perf/pmu-events/jevents.py              |   45 +-
 tools/perf/pmu-events/pmu-events.h            |    9 +-
 tools/perf/tests/Build                        |    1 +
 tools/perf/tests/builtin-test.c               |    1 +
 tools/perf/tests/code-reading.c               |    5 +-
 tools/perf/tests/cpuid-match.c                |  126 +
 tools/perf/tests/dlfilter-test.c              |    5 +-
 tools/perf/tests/dwarf-unwind.c               |    5 +-
 tools/perf/tests/event_groups.c               |    4 +-
 tools/perf/tests/expand-cgroup.c              |    3 +-
 tools/perf/tests/hwmon_pmu.c                  |    4 +-
 tools/perf/tests/mmap-basic.c                 |    6 +-
 tools/perf/tests/mmap-thread-lookup.c         |    5 +-
 tools/perf/tests/parse-events.c               |   38 +-
 tools/perf/tests/parse-metric.c               |    3 +-
 tools/perf/tests/pmu-events.c                 |   15 +-
 tools/perf/tests/pmu.c                        |    3 +-
 tools/perf/tests/shell/stat.sh                |  116 +
 tools/perf/tests/shell/sysinfo.sh             |   83 +
 tools/perf/tests/symbols.c                    |    7 +-
 tools/perf/tests/tests.h                      |    1 +
 tools/perf/tests/uncore-event-sorting.c       |    6 +-
 tools/perf/trace/beauty/perf_event_open.c     |    4 +-
 tools/perf/util/aslr.c                        |    7 +-
 tools/perf/util/config.c                      |    3 +
 tools/perf/util/cputopo.c                     |    5 +-
 tools/perf/util/debug.c                       |    6 +-
 tools/perf/util/drm_pmu.c                     |   14 +-
 tools/perf/util/env.c                         |  260 +-
 tools/perf/util/env.h                         |   25 +
 tools/perf/util/evlist.c                      |   16 +-
 tools/perf/util/evlist.h                      |    2 +
 tools/perf/util/evsel.c                       |  192 +-
 tools/perf/util/evsel.h                       |   10 +-
 tools/perf/util/evsel_fprintf.c               |    6 +-
 tools/perf/util/evsel_fprintf.h               |    4 +-
 tools/perf/util/expr.c                        |    3 +-
 tools/perf/util/header.c                      |  203 +-
 tools/perf/util/header.h                      |    6 +-
 tools/perf/util/hwmon_pmu.c                   |   14 +-
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     |    3 +-
 tools/perf/util/machine.c                     |   16 +-
 tools/perf/util/machine.h                     |   28 +-
 tools/perf/util/mem-events.c                  |   17 +-
 tools/perf/util/mem-events.h                  |   20 +
 tools/perf/util/metricgroup.c                 | 1128 +++++++-
 tools/perf/util/metricgroup.h                 |   94 +-
 tools/perf/util/parse-events.c                |  179 +-
 tools/perf/util/parse-events.h                |    4 +
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |   11 +-
 tools/perf/util/perf_api_probe.c              |    3 +-
 tools/perf/util/perf_event_attr_fprintf.c     |    7 +-
 tools/perf/util/pfm.c                         |    6 +-
 tools/perf/util/pmu.c                         | 2312 ++++++++++++++++-
 tools/perf/util/pmu.h                         |  223 +-
 tools/perf/util/pmus.c                        |  564 +++-
 tools/perf/util/pmus.h                        |  283 +-
 tools/perf/util/print-events.c                |   10 +-
 tools/perf/util/probe-event.c                 |    5 +-
 tools/perf/util/python.c                      |   38 +-
 tools/perf/util/rwsem.h                       |    6 +
 tools/perf/util/s390-sample-raw.c             |   16 +-
 tools/perf/util/session.c                     |   32 +-
 tools/perf/util/session.h                     |   22 +-
 tools/perf/util/stat-display.c                |    4 +-
 tools/perf/util/stat-shadow.c                 |   40 +-
 tools/perf/util/stat.h                        |    1 +
 tools/perf/util/tool_pmu.c                    |    5 +-
 110 files changed, 8192 insertions(+), 1063 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-sysinfo.txt
 delete mode 100644 tools/perf/arch/arm64/tests/cpuid-match.c
 create mode 100644 tools/perf/builtin-sysinfo.c
 create mode 100644 tools/perf/tests/cpuid-match.c
 create mode 100755 tools/perf/tests/shell/sysinfo.sh

--=20
2.56.0.385.gac671c819a-goog

