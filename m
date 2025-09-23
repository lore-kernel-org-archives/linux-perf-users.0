Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4E72628
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666801; cv=none; b=bcLoyA8svtwGRveeFb6FiHZ4q/81nL+Vecc72BWR+fwjFVM7GAR9vmgM+vlot3oIoTXvoWlk+kozRHmVr4i+rYAYiM8BzYIDvxIzznlHP3wBG7sFJ1YcokpHqfP+LiZcsBQrsppHfg4eQJVz79A8dQo6NZtSDWacjU201TV6EJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666801; c=relaxed/simple;
	bh=hJpRABFK/HAt16zd8cPLo/nNyWUPITzWQZ6QRQ7EcKo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=cKuwWuK1TZ7X6NrPLnFqJdB/I6vHMANz9NMKZJcbjPf2q3hcbF3shkUcHbuTp+Vq/t95EAaNUpJ41d8b53Uy5VomDna/3s0gFUQc0Myl4LOA71sTGBSaFlFMuBwtVOKOAe5Frucb5shgwUaMXpUDDi2uN7P2I3vzAp0bPFMY9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1JSVgpTM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1JSVgpTM"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5516e33800so6930644a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666798; x=1759271598; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUXoPOTxAiYU9b4EjaptlZvlYFHUR3PFxkRYzhxBChA=;
        b=1JSVgpTM2VWzSWKU2L6ai5qwA/DByXnYap2LzKSpsu4ckVD9T9RQAxTp/yrP5vx44g
         F2kkNwx4N6WlR07Fyz44Ik7qBpismqUWZaS+0xY0PUUo7vqmXZ3wrKkzWwVqRRG4cnOK
         8+7L8I+mmcmBR2o48sKFvIwUSIeIfTzMmupRm+kkEX6Q4BVgmy2mhQiFoCinAhuHnsAY
         uRCW/ib5xf3P0cCq0i1NKh/mSox2J//iUziLPQiCfSyhhrT9to1BfVNpnt5AQp1U2Omm
         TYrlo7G/i75DCMWJ7PaskpwpRoDu2j0a8JrZjVSS+xMTFWtCS7By6Hx6WTLHrKDVbeVF
         rMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666798; x=1759271598;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUXoPOTxAiYU9b4EjaptlZvlYFHUR3PFxkRYzhxBChA=;
        b=NDOPG97IHw6N4BakYO+YZmsA8urydGBdNu8Lv8YCTPpSHFSHevGoc3LiPYrHXrIqL5
         ZXWzlB8cR0/TaF2H7MZMS8pE/7eff1K5wBsab8uExHi7OdpIUGJEg+5ncAIK2WyAeNy9
         YooPl1+ZiImJfcV0/SqSZ4Rqowx4BcaGXOV0zivZAfEi4IzCro1eiO4JgW3KQAnTnP+a
         yiHUbJUEgFy2MAbaYJjCcNZ2ANm1YuqqhI3HGLgyzY3BCRMkRQjXsbLvMIxNazsAeTZy
         grIDi5h83ixUGSUWQc32U9lF/pXEYZ1h6yd/t9xB60a6cucngITxYfNyv0Rkc5Q5WAkk
         lESA==
X-Forwarded-Encrypted: i=1; AJvYcCUr6EBxLHeK4lbMO+88msFLgF4Tj4f9HOI6YCXgLga9LiKCsZisulE0Mw9bUDCez9iUhOcOUEljjSHsduPOYz2v@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78osTtj61AabtdMqCblJHfQA/VjCOs1SA1SZR7sy1utDJHNPN
	ObOw+qhjPYoTnM7crpeqN5OjhAwBBcEun0u3HmWLsYtkR4YHqR1SBZ+TdPiY3exLjIls2ozTsoW
	7oEdWIvuG6g==
X-Google-Smtp-Source: AGHT+IGWTGIFhg0DUzrxJvLU+LqrrkOsNWG4yy72iHjMKfaJDTynm1N8Mx+ZGzbVWAzb/8nLwF9z0Exptc61
X-Received: from pgbcz12.prod.google.com ([2002:a05:6a02:230c:b0:b52:3192:18e1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12ca:b0:263:1c48:912f
 with SMTP id adf61e73a8af0-2cfd9cc9766mr5927459637.12.1758666798282; Tue, 23
 Sep 2025 15:33:18 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-1-irogers@google.com>
Subject: [PATCH v6 00/28] Legacy hardware/cache events as json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Mirroring similar work for software events in commit 6e9fa4131abb
("perf parse-events: Remove non-json software events"). These changes
migrate the legacy hardware and cache events to json.  With no hard
coded legacy hardware or cache events the wild card, case
insensitivity, etc. is consistent for events. This does, however, mean
events like cycles will wild card against all PMUs. A change doing the
same was originally posted and merged from:
https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
and reverted by Linus in commit 4f1b067359ac ("Revert "perf
parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
his dislike for the cycles behavior on ARM with perf record. Earlier
patches in this series make perf record event opening failures
non-fatal and hide the cycles event's failure to open on ARM in perf
record, so it is expected the behavior will now be transparent in perf
record on ARM. perf stat with a cycles event will wildcard open the
event on all PMUs, however, with default events the cycles event will
only be opened on core PMUs.

The key motivation for these patches is so that if, for example, you
run `perf stat -e cpu-cycles ...` on a hybrid x86 and the results are
printed out with "cpu_core/cpu-cycles/" and "cpu_atom/cpu-cycles/",
the perf_event_attr for cpu-cycles and cpu_core/cpu-cycles/ be the
same, similarly for the cpu_atom event. Prior to these patches the
event with a PMU prefers sysfs/json over legacy encodings while with
no PMU legacy encodings are preferred - these are different encodings
on x86.

The change to support legacy events with PMUs was done to clean up
Intel's hybrid PMU implementation. Having sysfs/json events with
increased priority to legacy was requested by Mark Rutland
 <mark.rutland@arm.com> to fix Apple-M PMU issues wrt broken legacy
events on that PMU. It is believed the PMU driver is now fixed, but
this has only been confirmed on ARM Juno boards. It was requested that
RISC-V be able to add events to the perf tool json so the PMU driver
didn't need to map legacy events to config encodings:
https://lore.kernel.org/lkml/20240217005738.3744121-1-atishp@rivosinc.com/
This patch series achieves this.

A previous series of patches decreasing legacy hardware event
priorities was posted in:
https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
Namhyung Kim <namhyung@kernel.org> mentioned that hardware and
software events can be implemented similarly:
https://lore.kernel.org/lkml/aIJmJns2lopxf3EK@google.com/
and this patch series achieves this.

Note, patch 2 (perf parse-events: Fix legacy cache events if event is
duplicated in a PMU) fixes a function deleted by patch 17 (perf
parse-events: Remove hard coded legacy hardware and cache
parsing). Adding the json exposed an issue when legacy cache (not
legacy hardware) and sysfs/json events exist. The fix is necessary to
keep tests passing through the series. It is also posted for backports
to stable trees.

The perf list behavior includes a lot more information and events. The
before behavior on a hybrid alderlake is:
```
$ perf list hw

List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  ref-cycles                                         [Hardware event]
$ perf list hwcache

List of pre-defined events (to be used in -e or -M):


cache:
  L1-dcache-loads OR cpu_atom/L1-dcache-loads/
  L1-dcache-stores OR cpu_atom/L1-dcache-stores/
  L1-icache-loads OR cpu_atom/L1-icache-loads/
  L1-icache-load-misses OR cpu_atom/L1-icache-load-misses/
  LLC-loads OR cpu_atom/LLC-loads/
  LLC-load-misses OR cpu_atom/LLC-load-misses/
  LLC-stores OR cpu_atom/LLC-stores/
  LLC-store-misses OR cpu_atom/LLC-store-misses/
  dTLB-loads OR cpu_atom/dTLB-loads/
  dTLB-load-misses OR cpu_atom/dTLB-load-misses/
  dTLB-stores OR cpu_atom/dTLB-stores/
  dTLB-store-misses OR cpu_atom/dTLB-store-misses/
  iTLB-load-misses OR cpu_atom/iTLB-load-misses/
  branch-loads OR cpu_atom/branch-loads/
  branch-load-misses OR cpu_atom/branch-load-misses/
  L1-dcache-loads OR cpu_core/L1-dcache-loads/
  L1-dcache-load-misses OR cpu_core/L1-dcache-load-misses/
  L1-dcache-stores OR cpu_core/L1-dcache-stores/
  L1-icache-load-misses OR cpu_core/L1-icache-load-misses/
  LLC-loads OR cpu_core/LLC-loads/
  LLC-load-misses OR cpu_core/LLC-load-misses/
  LLC-stores OR cpu_core/LLC-stores/
  LLC-store-misses OR cpu_core/LLC-store-misses/
  dTLB-loads OR cpu_core/dTLB-loads/
  dTLB-load-misses OR cpu_core/dTLB-load-misses/
  dTLB-stores OR cpu_core/dTLB-stores/
  dTLB-store-misses OR cpu_core/dTLB-store-misses/
  iTLB-load-misses OR cpu_core/iTLB-load-misses/
  branch-loads OR cpu_core/branch-loads/
  branch-load-misses OR cpu_core/branch-load-misses/
  node-loads OR cpu_core/node-loads/
  node-load-misses OR cpu_core/node-load-misses/
```
and after it is:
```
$ perf list hw

legacy hardware:
  branch-instructions
       [Retired branch instructions [This event is an alias of branches].
        Unit: cpu_atom]
  branch-misses
       [Mispredicted branch instructions. Unit: cpu_atom]
  branches
       [Retired branch instructions [This event is an alias of
        branch-instructions]. Unit: cpu_atom]
  bus-cycles
       [Bus cycles,which can be different from total cycles. Unit: cpu_atom]
  cache-misses
       [Cache misses. Usually this indicates Last Level Cache misses; this is
        intended to be used in conjunction with the
        PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates.
        Unit: cpu_atom]
  cache-references
       [Cache accesses. Usually this indicates Last Level Cache accesses but
        this may vary depending on your CPU. This may include prefetches and
        coherency messages; again this depends on the design of your CPU.
        Unit: cpu_atom]
  cpu-cycles
       [Total cycles. Be wary of what happens during CPU frequency scaling
        [This event is an alias of cycles]. Unit: cpu_atom]
  cycles
       [Total cycles. Be wary of what happens during CPU frequency scaling
        [This event is an alias of cpu-cycles]. Unit: cpu_atom]
  instructions
       [Retired instructions. Be careful,these can be affected by various
        issues,most notably hardware interrupt counts. Unit: cpu_atom]
  ref-cycles
       [Total cycles; not affected by CPU frequency scaling. Unit: cpu_atom]
  branch-instructions
       [Retired branch instructions [This event is an alias of branches].
        Unit: cpu_core]
  branch-misses
       [Mispredicted branch instructions. Unit: cpu_core]
  branches
       [Retired branch instructions [This event is an alias of
        branch-instructions]. Unit: cpu_core]
  bus-cycles
       [Bus cycles,which can be different from total cycles. Unit: cpu_core]
  cache-misses
       [Cache misses. Usually this indicates Last Level Cache misses; this is
        intended to be used in conjunction with the
        PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates.
        Unit: cpu_core]
  cache-references
       [Cache accesses. Usually this indicates Last Level Cache accesses but
        this may vary depending on your CPU. This may include prefetches and
        coherency messages; again this depends on the design of your CPU.
        Unit: cpu_core]
  cpu-cycles
       [Total cycles. Be wary of what happens during CPU frequency scaling
        [This event is an alias of cycles]. Unit: cpu_core]
  cycles
       [Total cycles. Be wary of what happens during CPU frequency scaling
        [This event is an alias of cpu-cycles]. Unit: cpu_core]
  instructions
       [Retired instructions. Be careful,these can be affected by various
        issues,most notably hardware interrupt counts. Unit: cpu_core]
  ref-cycles
       [Total cycles; not affected by CPU frequency scaling. Unit: cpu_core]
$ perf list hwcache

legacy cache:
  branch-load-misses
       [Branch prediction unit read misses. Unit: cpu_atom]
  branch-loads
       [Branch prediction unit read accesses. Unit: cpu_atom]
  dtlb-load-misses
       [Data TLB read misses. Unit: cpu_atom]
  dtlb-loads
       [Data TLB read accesses. Unit: cpu_atom]
  dtlb-store-misses
       [Data TLB write misses. Unit: cpu_atom]
  dtlb-stores
       [Data TLB write accesses. Unit: cpu_atom]
  itlb-load-misses
       [Instruction TLB read misses. Unit: cpu_atom]
  l1-dcache-loads
       [Level 1 data cache read accesses. Unit: cpu_atom]
  l1-dcache-stores
       [Level 1 data cache write accesses. Unit: cpu_atom]
  l1-icache-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_atom]
  l1-icache-loads
       [Level 1 instruction cache read accesses. Unit: cpu_atom]
  llc-load-misses
       [Last level cache read misses. Unit: cpu_atom]
  llc-loads
       [Last level cache read accesses. Unit: cpu_atom]
  llc-store-misses
       [Last level cache write misses. Unit: cpu_atom]
  llc-stores
       [Last level cache write accesses. Unit: cpu_atom]
  branch-load-misses
       [Branch prediction unit read misses. Unit: cpu_core]
  branch-loads
       [Branch prediction unit read accesses. Unit: cpu_core]
  dtlb-load-misses
       [Data TLB read misses. Unit: cpu_core]
  dtlb-loads
       [Data TLB read accesses. Unit: cpu_core]
  dtlb-store-misses
       [Data TLB write misses. Unit: cpu_core]
  dtlb-stores
       [Data TLB write accesses. Unit: cpu_core]
  itlb-load-misses
       [Instruction TLB read misses. Unit: cpu_core]
  l1-dcache-load-misses
       [Level 1 data cache read misses. Unit: cpu_core]
  l1-dcache-loads
       [Level 1 data cache read accesses. Unit: cpu_core]
  l1-dcache-stores
       [Level 1 data cache write accesses. Unit: cpu_core]
  l1-icache-load-misses
       [Level 1 instruction cache read misses. Unit: cpu_core]
  llc-load-misses
       [Last level cache read misses. Unit: cpu_core]
  llc-loads
       [Last level cache read accesses. Unit: cpu_core]
  llc-store-misses
       [Last level cache write misses. Unit: cpu_core]
  llc-stores
       [Last level cache write accesses. Unit: cpu_core]
  node-load-misses
       [Local memory read misses. Unit: cpu_core]
  node-loads
       [Local memory read accesses. Unit: cpu_core]
```

v6. Fix x86 hybrid mismatched number of evsels for the case a PMU is
    specified. Add patches to make failures in the parse-events test
    easier to diagnose. Reorder the perf stat default events patch to
    come earlier.

v5. Add patch for retrying default events, fixing regression when
    non-root and paranoid. Make cycles to cpu-cycles test event change
    (to avoid non-core ARM events) the default on all architectures
    (suggested by Namhyung). Switch all non-test cases to specifying a
    PMU. Improvements to the parse-events test including core PMU
    parsing support for architectures without a "cpu" PMU.
    https://lore.kernel.org/lkml/20250923041844.400164-1-irogers@google.com/

v4: Fixes for matching hard coded metrics in stat-shadow. Make the
    default "cycles" event string on ARM "cpu-cycles" which is the
    same legacy event but avoids name collisions on ARM PMUs. To
    support this, use evlist__new_default for the no command line
    event case in `perf record` and `perf top`. Make
    evlist__new_default only scan core PMUs.
    https://lore.kernel.org/lkml/20250914181121.1952748-1-irogers@google.com/#t

v3: Deprecate the legacy cache events that aren't shown in the
    previous perf list to avoid the perf list output being too verbose.
    https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.com/

v2: Additional details to the cover letter. Credit to Vince Weaver
    added to the commit message for the event details. Additional
    patches to clean up perf_pmu new_alias by removing an unused term
    scanner argument and avoid stdio usage.
    https://lore.kernel.org/lkml/20250828163225.3839073-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20250828064231.1762997-1-irogers@google.com/

Ian Rogers (28):
  perf stat: Allow retry for default events
  perf parse-events: Fix legacy cache events if event is duplicated in a
    PMU
  perf perf_api_probe: Avoid scanning all PMUs, try software PMU first
  perf stat: Avoid wildcarding PMUs for default events
  perf record: Skip don't fail for events that don't open
  perf jevents: Support copying the source json files to OUTPUT
  perf pmu: Don't eagerly parse event terms
  perf parse-events: Remove unused FILE input argument to scanner
  perf pmu: Use fd rather than FILE from new_alias
  perf pmu: Factor term parsing into a perf_event_attr into a helper
  perf parse-events: Add terms for legacy hardware and cache config
    values
  perf jevents: Add legacy json terms and default_core event table
    helper
  perf pmu: Add and use legacy_terms in alias information
  perf jevents: Add legacy-hardware and legacy-cache json
  perf print-events: Remove print_hwcache_events
  perf print-events: Remove print_symbol_events
  perf parse-events: Remove hard coded legacy hardware and cache parsing
  perf record: Use evlist__new_default when no events specified
  perf top: Use evlist__new_default when no events specified
  perf evlist: Avoid scanning all PMUs for evlist__new_default
  perf evsel: Improvements to __evsel__match
  perf test parse-events: Use evsel__match for legacy events
  perf test parse-events: Without a PMU use cpu-cycles rather than
    cycles
  perf test parse-events: Remove cpu PMU requirement
  perf test: Switch cycles event to cpu-cycles
  perf test: Clean up test_..config helpers
  perf test parse-events: Add evlist test helper
  perf test parse-events: Add evsel test helper

 tools/perf/Makefile.perf                      |   21 +-
 tools/perf/arch/x86/util/intel-pt.c           |    2 +-
 tools/perf/builtin-list.c                     |   34 +-
 tools/perf/builtin-record.c                   |   97 +-
 tools/perf/builtin-stat.c                     |  171 +-
 tools/perf/builtin-top.c                      |    8 +-
 tools/perf/pmu-events/Build                   |   24 +-
 .../arch/common/common/legacy-hardware.json   |   72 +
 tools/perf/pmu-events/empty-pmu-events.c      | 2771 ++++++++++++++++-
 tools/perf/pmu-events/jevents.py              |   32 +
 tools/perf/pmu-events/make_legacy_cache.py    |  129 +
 tools/perf/pmu-events/pmu-events.h            |    1 +
 tools/perf/tests/code-reading.c               |    2 +-
 tools/perf/tests/keep-tracking.c              |    2 +-
 tools/perf/tests/parse-events.c               | 2010 ++++++------
 tools/perf/tests/perf-time-to-tsc.c           |    4 +-
 tools/perf/tests/pmu-events.c                 |   24 +-
 tools/perf/tests/pmu.c                        |    3 +-
 tools/perf/tests/switch-tracking.c            |    2 +-
 tools/perf/util/evlist.c                      |   18 +-
 tools/perf/util/evsel.c                       |   21 +-
 tools/perf/util/parse-events.c                |  282 +-
 tools/perf/util/parse-events.h                |   22 +-
 tools/perf/util/parse-events.l                |   54 +-
 tools/perf/util/parse-events.y                |  114 +-
 tools/perf/util/perf_api_probe.c              |   27 +-
 tools/perf/util/pmu.c                         |  309 +-
 tools/perf/util/print-events.c                |  112 -
 tools/perf/util/print-events.h                |    4 -
 29 files changed, 4523 insertions(+), 1849 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/legacy-hardware.json
 create mode 100755 tools/perf/pmu-events/make_legacy_cache.py

-- 
2.51.0.534.gc79095c0ca-goog

