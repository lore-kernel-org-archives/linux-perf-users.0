Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599620;
	b=WIKQVfGa5mUzpGrFoPk5nJPzVtjLPhUou0lVdeZwa0d9MyR5cNMjoXqyDYDrrsCUwouR
	 8EYYDEIzGE+RXpQnVR6pazn/TahU5OnWnWY6oQ5CJw2Z/1RfVDMoyPl85xs34Yhdtjgty
	 +SLG1Fc8KftYxvRTBCj3dK4ZCYwxxSeUV6JpH/Aus5AoXwilMxOu31oAe1LnoQnJ5be1A
	 upL0h9Q8oqD3pdZ39LSe+M/y0b8V/J2KncpaPcMmiL/kzX3qMUKiJ2BM9at7EaPnUi7Eb
	 xd0Zm4Wf8sXMlFeOssbwiQSyA+7D7S1qC6a3mnGxDbhKXFKHsF4k4YNYMazMCku4Vdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=bguXnfDW38G4A8VD36nnin++erKj+awmqZPBW2uYfbQ=;
	b=ptUzujqHdH0/dbXMIqCHzz4y2D9jbQHK5yTRxdxQI+5ERalaxQZ+rmQwhN7/sJtKK8Gl
	 k8LaXFyVXngKKtSOGp+GwrmeuDDsJN4uvAmho8/ngWIKhTC3QtmyJqQeSnSu/s2jgKtFD
	 zkNnr4mKu+995KqYQt+WykNc9c25pG5C4nyeczz8y6zxlfNok2UpnP5ruaLQNCKu9KJ9+
	 VOCTDjoBg4uCO8NUOwuG7DqdCSFlLDwa+ulqr5P3TmJmqo/1uTTtbZTkKEfhLIkxyYnhY
	 hQERvwiPMoeY0cjldXpviHql3TlBeukT04zDTdxfY+f1dq/bAX+MEdMamUaxBXKjQEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iWTcaCs0;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25420606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25420606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iWTcaCs0
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36f26e6abe9so1647909eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599618; x=1795204418; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bguXnfDW38G4A8VD36nnin++erKj+awmqZPBW2uYfbQ=;
        b=iWTcaCs0zno4p0QW7Tpe12PCrL5AqPEHSFqmV21Ata4Suu2vP5+/J7q/obZyLg3CUE
         J0PZDwEnjbpHBLzT/4sLB4hWw8T3TSSjUsEk1pkYif56Dm8+DEzXgXrPOLO2pfRf0Ef8
         ZpHrByPXhokt62qBnLcvJLCKbtzkJW7A9jx8gm9R2CHWXm002QviNbgNbLZYbsXPXivc
         ZtgvEbXYH9pa2u56CCZb+p6dOtTrVAzelb/qwX7VmfUiaRZ7UyRfgPV7KyEZLgaYhR7u
         muE1mLicQ2AHGcvCJuBHGzwZ49vKq7xeqGNBuFYhfnA/Xx+PGEiy+urvWrCdrX9s0rGk
         vuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599618; x=1795204418;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bguXnfDW38G4A8VD36nnin++erKj+awmqZPBW2uYfbQ=;
        b=Sizx19YXCdlzRsoOc36eSIpEU10LjU0xMYzSEN05xNYT63sz/TwdcFfCe7oytWdmWT
         7dNRybxQH5ln4LvVe8gaxaxpZlBCoyhvrqDBmmk267/1c7uN6QFPYKJQSjGwGqOEYxPk
         tkahEFw6S6KNyIamNdLBl2hNtbrAkICbndfL4LFLNzdJO+N9SousHkTVBjRzIzBmeTSP
         x4jC6yDElDk+vThyXxS0LlHK6+CQBzgNRvCAasHvFwNS72Lq2FPT4DzqU20vp020UAe2
         E5ssvKGWUDyXNLKNSBbWxvpF7QTHYXverDaqiFp4SshGbeny+w5WKS74SAAg/9DTYp7+
         UW+A==
X-Gm-Message-State: APuU4Z+DpHgPzXgafmRREOWniv2oQM+wffsqtS0fmCmvMpfrvnj8sJcp
	wV9c6/m15oTcvZEofwDd07b92ope1eMfZEz/Y1MK+z3BBT7FxXCB7QDXsgfGDIyzdWzmnL5QiXJ
	N8YrOC6prQw==
X-Received: from dybnj44.prod.google.com ([2002:a05:7300:d0ac:b0:375:861c:512e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d189:b0:376:2ddd:2ab1
 with SMTP id 5a478bee46e88-37963660405mr3098286eec.4.1794599617760; Fri, 13
 Nov 2026 11:53:37 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:05 -0800
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
Message-ID: <20261113195335.2865725-1-irogers@google.com>
Subject: [PATCH v2 00/30] perf: Per-env PMUs, metric event sharing, and
 recorded event metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series fixes some PMU and metric bugs, refactors PMU state
management into struct perf_env, makes 'perf stat' share metric events
by what they count, and computes and displays metrics from recorded
perf.data files in 'perf stat report' and 'perf script'.

It is the first part of what was sent as a single 41 patch v1 series
"perf: Per-env PMUs, recorded event metrics, and perf sysinfo":
https://lore.kernel.org/all/20261103234502.1008382-1-irogers@google.com/
The 'perf sysinfo' subcommand is sent as a second series that depends on
this one.

The series is ordered as: independent fixes (Patches 1-4), clean ups
(Patches 5-22), 'perf stat' metric event sharing (Patches 23-24) and
perf.data metric support (Patches 25-30).

1. Independent fixes (Patches 1-4)
==================================

These fix existing bugs and apply independently of the rest of the
series:

  - Patch 1 stops 'perf list' treating core PMUs whose names differ by
    a suffix, such as armv8_pmuv3_0 and armv8_pmuv3_1, as duplicates
    and so hiding the events of all but the first core PMU.
  - Patch 2 fixes 'perf script -F +metric' sample-based metric
    calculation, the counts of other CPUs were left as deltas giving
    wrong (negative) values, metrics of unrelated events were shown and
    the output was garbled.
  - Patch 3 stops 'perf script -F metric' dropping samples whose CPU
    isn't in the evsel's CPU map, which for perf record data is the
    host's online CPUs.
  - Patch 4 stops 'perf stat' displaying a metric alongside a tool
    event, such as duration_time, when a non-tool event is available.

2. Clean ups (Patches 5-22)
===========================

Previously, core_pmus, other_pmus, and sysfs scanning state were global
variables in tools/perf/util/pmus.c, preventing perf from maintaining
both the live host's PMUs and a recorded perf.data session's PMUs
simultaneously.

   - Patch 5 makes lazy perf_env initialization thread-safe using
     env->env_sem.
   - Patch 6 introduces the host_env() singleton to represent the live
     host environment explicitly, replacing the global perf_env variable
     and session->header.env fallbacks.
   - Patch 7 adds a from_env parameter to perf_pmu__init() to
     distinguish PMUs reconstructed from perf_env headers from live host
     PMUs so they never query host sysfs or get cast via container_of()
     to struct hwmon_pmu or struct drm_pmu.
   - Patches 8-10 introduce struct perf_pmus embedded in struct perf_env
     (accessed via perf_env__pmus()) and pass struct perf_pmus to the
     PMU find and scan helpers.
   - Patches 11-13 record the ELF machine (e_machine) of each pmu-events
     table's CPUIDs in struct pmu_events_map, so host lookups only
     consider the host architecture's tables, find the core events and
     metrics tables by e_machine rather than an architecture name, and
     pass the e_machine of the CPUIDs to strcmp_cpuid_str().
   - Patch 14 moves the architecture-specific strcmp_cpuid_str()
     implementations from arch/{x86,arm64}/util/header.c into common
     tools/perf/util/header.c, selecting the comparison by e_machine, so
     CPUID matching works across architectures when analyzing cross-arch
     perf.data files.
   - Patches 15-16 move the arm64 CPUID matching test to
     tools/perf/tests so it runs on all architectures, and add CPUID
     matching tests for exact (test/common), x86, PowerPC, RISC-V and
     s390 CPUIDs.
   - Patch 17 adds e_machine__same_arch() to compare ELF machines
     ignoring word size differences, such as EM_386 and EM_X86_64.
   - Patch 18 passes struct perf_pmus to metricgroup__for_each_metric()
     and pmu_metrics_table__find().
   - Patch 19 moves the matching of metrics to recorded events
     (metricgroup__add_matching_metrics()) from builtin-script.c into
     util/metricgroup.c.
   - Patch 20 moves the encoding and decoding of metric-id term values
     into parse-events.c so the metric-id is decoded when the evsel is
     created, rather than metricgroup rewriting each evsel's metric-id
     after parsing.
   - Patch 21 generalizes evsel::metric_id to a set of unique
     evsel::metric_ids, so that an evsel shared by metrics, or matched
     by metrics to a recorded event, has the identifiers of all of them.
     The set's representation is private to evsel.c and accessed through
     evsel__add_metric_id(), evsel__copy_metric_ids(),
     evsel__has_metric_id(), evsel__shares_metric_id() and the
     evsel__for_each_metric_id() callback iterator.
   - Patch 22 adds perf_pmu__for_each_name_from_config() to find the event
     names of a PMU for an encoding, including legacy hardware and cache
     event names from the legacy event tables, and uses it for
     perf_pmu__name_from_config().

3. 'perf stat' metric event sharing (Patches 23-24)
===================================================

Metrics shared events by the names of the identifiers in their
expressions, so events spelled differently but counting the same thing
weren't shared, and events were only shared within one metric group
parsing call.

   - Patch 23 adds an evsel matcher comparing a key of the PMU, the
     perf_event_attr encoding (with legacy hardware events converted to
     the equivalent sysfs/json encoding), modifiers and cgroup, and uses
     it to share events between metrics, earlier metric groups and the
     command line without splitting a metric's events across different
     groups, while preserving multi-PMU metric leadership and merging
     forced architecture groups such as x86 topdown events.
   - Patch 24 makes the -T, --smi-cost, --topdown and Default metrics
     share events with the command line events and each other.

4. perf.data metric support (Patches 25-30)
===========================================

With per-perf_env PMUs reconstructed from perf.data headers, perf can
resolve the recorded machine's PMUs and JSON metric tables offline and
match metrics against recorded evsels.

   - Patch 25 adds perf_pmus__read_from_env() and perf_pmu__add_cap() to
     reconstruct a perf_env's core_pmus and other_pmus lists,
     capabilities, CPU maps, and JSON event/metric tables from perf.data
     headers.
   - Patch 26 improves metricgroup__add_matching_metrics() to match
     each candidate metric's events to recorded evlist entries with the
     evsel matcher, in a mode tolerating evsel__fallback() exclusion
     changes and preferring events with counts, attaching copies of the
     metric to each PMU's events, supporting uncore PMU instance fan-out
     and hybrid PMUs.
   - Patch 27 adds metricgroup__add_recorded_metrics() and
     metricgroup__add_matching_metric_groups() to reconstruct the
     metrics requested on a recorded 'perf stat record' command line
     from perf_env (including -M, --transaction, --smi-cost, --topdown,
     -d, or the Default metricgroups when no events or metrics were
     specified), or optionally add all matching JSON metrics when
     --all-metrics is enabled.
   - Patch 28 enables displaying metrics for recorded events in
     'perf stat report' (and adds --all-metrics and stat.all-metrics).
   - Patch 29 enables displaying metrics for 'perf stat record'
     PERF_RECORD_STAT data in 'perf script' (and adds --all-metrics).
   - Patch 30 adds a shell test verifying metric reporting across
     'perf stat record', 'perf stat report', and 'perf script'.

Changes since v1
================
- Split the series into two, this series and a 'perf sysinfo' series.
- Reordered the series as independent fixes, clean ups, 'perf stat'
  metric event sharing and perf.data metric support, so the fixes
  (Patches 1-4) can be applied independently.
- New patch 1: don't skip core PMUs as duplicates, affecting both
  'perf list' and 'perf sysinfo'.
- New patch 4: don't prefer tool events for displaying a metric.
- New patch 17: add e_machine__same_arch() so that comparing a
  perf_env's architecture with the host's ignores word size differences
  (EM_386 vs EM_X86_64) without string comparisons, and use it for
  pmu-events table matching, is_pmu_core_len() and env_is_pmu_core().
- New patches 23-24: share metric events in 'perf stat' using the same
  evsel matcher as used for matching metrics to perf.data events, so
  there is one implementation of deciding whether two events count the
  same thing (Patch 26 now builds on it). Previously metrics shared
  events by the names in their expressions.
- Rebased onto the latest perf-tools-next.
- Addressed Sashiko review feedback:
  - Restored evsel__is_drm()/evsel__is_hwmon() and made all drm/hwmon
    open and read callbacks fail with -EINVAL for PMUs from a perf_env.
  - Fixed config_terms leaks in parse_events_add_pmu() and
    parse_events_add_breakpoint().
  - Handled HEADER_E_MACHINE in perf_event__process_feature(), and
    cleared is_uncore when upgrading or promoting env PMUs.
  - Metric matching: don't count a recorded event twice when different
    metric events match it, map all events before modifying recorded
    evsels, only treat dynamic PMU types as raw when the PMU name is
    known, only prefer matching grouping when the metric's events are
    grouped, tolerate EOPNOTSUPP exclude_guest fallback, and on hybrid
    systems add metrics for each PMU whose events were recorded.
  - Only mark recorded events used by the Default metrics, including
    duplicates across groups, as in the Default metricgroup.
  - Handle an empty thread map when determining system wide mode in
    'perf stat report' and 'perf script'.
  - Clean up all temporary files in the stat record metrics test.

This patch series was generated with the assistance of antigravity and
Gemini 4.0.

Ian Rogers (30):
  perf pmus: Don't skip core PMUs as duplicates
  perf script: Fix metrics computed from samples
  perf script: Don't drop metric samples for CPUs missing from the evsel
  perf metricgroup: Don't prefer tool events for displaying a metric
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
  perf dwarf-regs: Add e_machine__same_arch()
  perf metricgroup: Pass struct perf_pmus to
    metricgroup__for_each_metric()
  perf metricgroup: Move matching of metrics to recorded events from
    perf script
  perf parse-events: Decode metric-id terms when adding events
  perf evsel: Generalize metric_id to a set of metric_ids
  perf pmu: Add perf_pmu__for_each_name_from_config()
  perf metricgroup: Share metric events by their counter encoding
  perf stat: Share events between metrics and command line events
  perf pmus: Add perf_pmus__read_from_env()
  perf metricgroup: Improve matching of metrics to recorded events
  perf metricgroup: Add metricgroup__add_recorded_metrics()
  perf stat report: Display metrics for recorded events
  perf script: Display metrics for perf stat record data
  perf test: Add stat record metrics test

 tools/perf/Documentation/perf-config.txt      |    7 +
 tools/perf/Documentation/perf-script.txt      |    6 +
 tools/perf/Documentation/perf-stat.txt        |    5 +
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
 tools/perf/builtin-inject.c                   |    3 +-
 tools/perf/builtin-kallsyms.c                 |   12 +-
 tools/perf/builtin-list.c                     |   19 +-
 tools/perf/builtin-lock.c                     |    6 +-
 tools/perf/builtin-record.c                   |    2 +-
 tools/perf/builtin-script.c                   |  310 +--
 tools/perf/builtin-stat.c                     |  136 +-
 tools/perf/builtin-top.c                      |   17 +-
 tools/perf/builtin-trace.c                    |   18 +-
 tools/perf/perf.c                             |    3 +
 tools/perf/pmu-events/empty-pmu-events.c      |   30 +-
 tools/perf/pmu-events/jevents.py              |   41 +-
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
 tools/perf/tests/maps.c                       |   11 +-
 tools/perf/tests/mmap-basic.c                 |    6 +-
 tools/perf/tests/mmap-thread-lookup.c         |    5 +-
 tools/perf/tests/parse-events.c               |   38 +-
 tools/perf/tests/parse-metric.c               |    3 +-
 tools/perf/tests/pmu-events.c                 |   15 +-
 tools/perf/tests/pmu.c                        |    3 +-
 tools/perf/tests/shell/stat.sh                |  133 +
 tools/perf/tests/symbols.c                    |    7 +-
 tools/perf/tests/tests.h                      |    1 +
 tools/perf/tests/uncore-event-sorting.c       |    6 +-
 tools/perf/trace/beauty/perf_event_open.c     |    4 +-
 tools/perf/util/aslr.c                        |    7 +-
 tools/perf/util/config.c                      |    3 +
 tools/perf/util/cputopo.c                     |    5 +-
 tools/perf/util/debug.c                       |    6 +-
 tools/perf/util/drm_pmu.c                     |   16 +-
 tools/perf/util/env.c                         |  260 +-
 tools/perf/util/env.h                         |   25 +
 tools/perf/util/evlist.c                      |   16 +-
 tools/perf/util/evlist.h                      |    2 +
 tools/perf/util/evsel.c                       |  192 +-
 tools/perf/util/evsel.h                       |   10 +-
 tools/perf/util/evsel_fprintf.c               |    6 +-
 tools/perf/util/evsel_fprintf.h               |    4 +-
 tools/perf/util/expr.c                        |   18 +-
 tools/perf/util/expr.h                        |    2 -
 tools/perf/util/header.c                      |  204 +-
 tools/perf/util/header.h                      |    6 +-
 tools/perf/util/hwmon_pmu.c                   |   16 +-
 tools/perf/util/include/dwarf-regs.h          |   37 +
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     |    3 +-
 tools/perf/util/machine.c                     |   16 +-
 tools/perf/util/machine.h                     |   28 +-
 tools/perf/util/mem-events.c                  |    5 +-
 tools/perf/util/metricgroup.c                 | 2148 ++++++++++++++---
 tools/perf/util/metricgroup.h                 |   95 +-
 tools/perf/util/parse-events.c                |  185 +-
 tools/perf/util/parse-events.h                |    4 +
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |   11 +-
 tools/perf/util/perf_api_probe.c              |    3 +-
 tools/perf/util/perf_event_attr_fprintf.c     |    7 +-
 tools/perf/util/pfm.c                         |    6 +-
 tools/perf/util/pmu.c                         |  195 +-
 tools/perf/util/pmu.h                         |   28 +-
 tools/perf/util/pmus.c                        |  573 +++--
 tools/perf/util/pmus.h                        |  264 +-
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
 105 files changed, 4538 insertions(+), 1317 deletions(-)
 delete mode 100644 tools/perf/arch/arm64/tests/cpuid-match.c
 create mode 100644 tools/perf/tests/cpuid-match.c


base-commit: 4af65363b11fc4fe65fcb497f68bbe4f3e3a4d2c
-- 
2.56.1.703.gf848ed807c-goog

