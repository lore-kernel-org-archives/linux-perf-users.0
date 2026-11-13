Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604272;
	b=BUEz8Q3hy5etjDawuuNcpbftyDLhNUlQgT2HMXo+bF2LZ3/W1zisIX006k1Yz9S1Pa2E
	 G2l6+Pi8DSY9zq4TTaQSqwJq9kCNMCU9f1Ywio83x8n11K/CPztrsDtrjDPr6n4YwsXDP
	 2miAGLUMaWrksHAPxTvzKN9qqUomq/08D3n/64o5TNTDgaFzLYG9ptIJZYfVTDjTzzJ3G
	 XyqQl762fx3iF5kbxRMCgs/Wp3ZmmiFb3s+V2xx8lfTF7pkLpbDQUUpKcUlcLOvejp4GW
	 Nll5VGtgCPJt1p9EKVGsw5jj6U7G5FRWLgKW1ON3Wn6Y0ARYT33SFh7IsLYIN0t+QfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=u4oQRS8fxPBgnCYnRPSeSegh3AZcvqaKdvCjoy0ii5I=;
	b=osHBCwFscBl3p5qh2hglqV5xChpLJL+CsIdxc7OBa58HsGWAGqm47Cr7ShdRPx3Cvnmn
	 AmZltxIbLJQPfSXY0PTz8PjftgMGSWliWS7SEHqppYQeati9qI/JCxd4Ueu1crQ32cWK1
	 yE6Vg3vbI2lhzmywZunSTK/7tNfWttiZEaFSDZugntKj2gsxj04dfp7wpaFP0kTuG8dDL
	 fQ4awiRXlzz1XwfL5iSFAT6nHW2ubB3/pSaXwrdAYHlsaYwm8B3XYGRx5Xz7txuNC5DX1
	 WwmY5X4zy1VkgC+/BsayXLJ4LhDG8ZnaL6WjioUwxuCH5ep9MSjoZM2RnIF+A7rk6wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oPGVN2Kr;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5D606A332
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA5D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oPGVN2Kr
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed8aca9775so13439665ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604270; x=1795209070; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u4oQRS8fxPBgnCYnRPSeSegh3AZcvqaKdvCjoy0ii5I=;
        b=oPGVN2KrJSlJ/vmi5qVjaHFuHGcOF/3oAl6a/vcbLIJHwqu596QjRGQDxg4CSUlaki
         scXuSyrxVX7rfsTVIAjwV3Mtacd/wg0PLHnATCNB+q5bYJclAGvjjUiCDyKO2XcHLQ3f
         4WNf6zFyZpD3cm65XMjMQi/tMq4Ge4oiMc4WruW/o2tiX1lFMDA+5Pc7RLzNA4rbWUxg
         wtPrHz7q39+hnAHCshun2igWCayoHQfRRrOXJXKlAXRwRpNnGaNbRZmYCWtFJFD/Nx5b
         bqeuP0ARuda7rNZKe7vHYDZviwzL7kflWUZqzfPnuSdebKTbpJg2VksXj8yS595r8jFV
         WPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604270; x=1795209070;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u4oQRS8fxPBgnCYnRPSeSegh3AZcvqaKdvCjoy0ii5I=;
        b=qdbNiUwCDlSgdKsbgjPgDt0fRYGw3Cb7PCn4+N45Otn72RWcwh5aNp/O9nM0ttIL7p
         nihDbdS7XPHYFpMGCW5Tq9VXzv/8EnZXUXww+iErnxTNE1DjJBBU8ECKWrrwZZrWjsOc
         qXnQip8UVxabW0PVrP4LCCdB5kJrxE9SfY53FcncYPXkV3f0jL9ofDgJuVK7hE6kzw0n
         G0M5liNTz+OJ7pnCMSp6DIHPynJVdBzn7g6ooBH4GzNSYNgnvcnipMm14NEjMqw53GKU
         QNx3ZvwVs1gSRntmlD+kF2o2SHnYhK8+HWVe8IRtOV3qhKLS9CUgyOPBAKfuOZ0kpsAK
         0X5g==
X-Forwarded-Encrypted: i=1; AL+hErGsmdTIQrmnFS/s2AnHJrQpkY1ocidY5GNrQlJzAT3s4ixz4Y5YChptlq7IEJn+7YcFbnA+RHU8UrtfoittKLbX@vger.kernel.org
X-Gm-Message-State: APuU4Z/+FGE/0N02W7A3UOKFZYeRxPI3ITzl/N3wXLWGBH5MgdKZhTiE
	E45Q9gvMgMMGQ6fvZtRtJOysNeVJOAf6Y5HPSKrsKyXVof/d9uwc9Tw2289911sLVZQ694hPPtL
	ScZEvhfyxvw==
X-Received: from plhv17.prod.google.com ([2002:a17:903:2391:b0:2e9:7bc5:bec5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ceca:b0:2e6:2023:29fb
 with SMTP id d9443c01a7336-2edf2149038mr50514165ad.29.1794604269620; Fri, 13
 Nov 2026 13:11:09 -0800 (PST)
Date: Fri, 13 Nov 2026 13:10:51 -0800
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
Message-ID: <20261113211105.3118281-1-irogers@google.com>
Subject: [PATCH 00/11] perf pmu: Layered sysfs-style PMU event and metric directories
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently perf resolves PMU event aliases from two hardcoded sources
(/sys/bus/event_source/devices/<pmu>/events/ and compiled-in jevents.py
C tables) while metricgroup.c reads metrics and metricgroup descriptions
directly from compiled-in pmu_metrics_table arrays without associating
them with struct perf_pmu. As a result:

1. Adding, overriding, or testing PMU event encodings, descriptions, or
   metrics requires editing JSON files and recompiling perf.
2. Single-event parsing ('perf stat -e cycles true') eagerly runs
   readdir() across /sys/bus/event_source/devices/<pmu>/events/ rather
   than probing <pmu>/events/<event> on demand via openat().
3. Metrics cannot be overridden or supplied via runtime directory trees
   alongside PMU events.

This series (built on top of the perf jevents block-indexed string
compression series, which packs compiled-in event and metric strings
into independently compressed ~8 KiB blocks decompressed on demand by
(block_id << 16) | sub_offset) unifies PMU events, metrics, and
metricgroup descriptions behind a stateless, openat()-driven layered VFS
stack on struct perf_pmu, configurable via pmu-events.dir:

  Highest:  1. User directory layers (pmu-events.dir, left-to-right)
            2. Compiled-in CPUID / sys JSON tables (libpmu-events)
            3. Kernel sysfs (/sys/bus/event_source/devices/)
  Lowest:   4. Compiled-in default_core / common JSON tables

This preserves the existing util/pmu.c precedence: CPUID- and identifier-
matched JSON events override sysfs encodings (allowing architectures such
as RISC-V to map legacy event names to CPU-specific encodings in JSON
without bloating the kernel PMU driver), while sysfs events (such as
/sys/bus/event_source/devices/<pmu>/events/cycles) override generic
legacy-hardware and legacy-cache fallback encodings in common JSON
(which remain available in alias->legacy_terms).

User Directory Layout and CPUID Resolution
------------------------------------------

Each directory <root> in colon-separated pmu-events.dir supports both
portable multi-CPU trees (keyed by literal CPUID or uncore identifier
with POSIX symlinks) and host-direct PMU overrides, with no runtime
mapfile.csv or regex engine:

  <root>/
  |-- cpus/
  |   |-- GenuineIntel-6-4E -> ../models/x86/skylake
  |   |-- GenuineIntel-6-5E -> ../models/x86/skylake
  |   |-- GenuineIntel-6-8F -> ../models/x86/sapphirerapids
  |   |-- GenuineIntel-6-8F-8/          # stepping-specific override
  |   |   `-- cpu/events/inst_retired.any.desc
  |   |-- 0x00000000410fd490 -> ../models/arm64/arm/neoverse-n2-v2
  |   `-- 0x489-0x8000000000000007 -> ../models/riscv/sifive/bullet
  |-- sys/
  |   `-- 0x00000030 -> ../models/arm64/hisilicon/hip09/sys
  |-- models/
  |   |-- x86/skylake/{default_core,uncore_imc,...}/{events,metrics}/...
  |   `-- arm64/arm/neoverse-n2-v2/default_core/{events,metrics}/...
  |-- default_core/metrics/my_ipc{,.desc}
  |-- <pmu>/{events,metrics}/...
  `-- metricgroups/<group>.desc

Within each <root>, perf probes three scopes top-down:

1. <root>/cpus/<cpuid>/:
   Queries each PMU's CPUID (using perf_cpu_map__min(pmu->cpus) so
   hybrid PMUs such as cpu_core and cpu_atom use their own CPU's CPUID,
   and honoring PERF_CPUID). perf probes the exact CPUID first and then
   deterministic base CPUIDs stripped of stepping or revision fields:
   - x86 ('-' delimited):    GenuineIntel-6-8F-8 -> GenuineIntel-6-8F
   - s390 (',' delimited):   IBM,8561,703        -> IBM,8561
   - RISC-V ('-' delimited): 0x489-0x8000000000000007-0x1
                               -> 0x489-0x8000000000000007
   - ARM64 64-bit hex MIDR:  0x00000000411fd493  -> 0x00000000410fd490
                             (Variant[23:20] and Revision[3:0] zeroed)
   - PowerPC 32-bit hex PVR: 0x00800200          -> 0x00800000
                             (Revision[15:0] zeroed)
   Each <root> stops at the first matching cpus/<candidate> directory
   so a stepping override (e.g. cpus/GenuineIntel-6-8F-8/) does not
   accidentally merge coarser model events from the same <root>, while
   unset sidecar attributes and unoverridden events still merge from
   subsequent directories in pmu-events.dir (for example
   ~/.perf-events/local:/opt/pmu-events), compiled-in JSON, and sysfs.
   Because openat() traverses POSIX symlinks in the kernel VFS, multiple
   CPUIDs sharing a microarchitecture point to a single canonical
   models/<arch>/<model>/ directory.
2. <root>/sys/<id>/:
   Matches pmu->id from /sys/bus/event_source/devices/<pmu>/identifier.
3. <root>/ (host-direct and cross-CPU fallback):
   Matches <pmu> (exact name, alias_name, default_core for core PMUs,
   or suffix-stripped uncore prefix such as uncore_imc) plus
   <root>/metricgroups/<group>.desc.

Exporters materialize both layouts:
- 'perf list --export-dir <dir>' writes the running machine's active
  PMUs into host-direct <dir>/<pmu>/{events,metrics}/ for quick local
  edits.
- 'perf list --export-dir <dir> --export-cpuid <cpuid|arch[/model]|all>'
  exports compiled-in tables for any CPUID, model, or architecture (or
  'all') directly from the perf binary into <dir>/models/<arch>/<model>/
  with relative <dir>/cpus/<cpuid> and <dir>/sys/<id> symlinks (for
  example, to inspect or migrate metrics across architectures/models).
- 'jevents.py --output-dir <dir>' exports unbuilt kernel source JSON
  trees into the same <dir>/models/ + <dir>/cpus/ + <dir>/sys/ layout
  (also usable on NO_JEVENTS=1 setups).

Key changes across the series:
- Lazy sysfs probing and struct perf_pmu metric storage (Patches 1-2):
  - Patch 1 generalizes pmu_alias_info_file() to probe single event
    files and sidecars on demand via openat() before falling back to
    readdir(), keeping struct perf_pmu_alias private out of pmu.h.
  - Patch 2 adds metrics and metricgroups hashmaps on struct perf_pmu
    while keeping struct perf_pmu_metric and struct perf_pmu_metricgroup
    private out of pmu.h (so tool, drm, hwmon, and tp PMUs are
    unaffected).
- Stateless struct pmu_layer VFS and pmu-events.dir (Patches 3-6):
  - Patch 3 introduces struct pmu_layer (sharing internal alias/metric
    representations privately between pmu.c and pmu-layer.c via
    pmu-layer.h) and wraps compiled-in CPU/sys and common pmu-events
    tables as the builtin layers.
  - Patch 4 implements the openat() directory layer supporting extended
    event and metric sidecars, %2F escaping for '/' in names, and
    literal cpus/<cpuid> and sys/<id> POSIX symlink lookup.
  - Patch 5 adds the colon-separated pmu-events.dir perf config option
    (supporting -c pmu-events.dir=..., ~/.perfconfig, and PERF_CONFIG).
  - Patch 6 switches util/pmu.c alias resolution and enumeration over to
    pmu-layer.c, removing ~600 lines of legacy merge plumbing.
- PMU-routed metrics, exporters, and tests (Patches 7-11):
  - Patch 7 routes metricgroup.c, print-events.c, builtin-list.c,
    builtin-script.c, and util/python.c metric and metricgroup lookups
    through struct perf_pmu and perf_pmus helpers using public struct
    pmu_metric.
  - Patch 8 adds 'perf list --export-dir <dir>' (host PMUs) and
    'jevents.py --output-dir <dir>' (unbuilt JSON trees).
  - Patches 9-10 add compiled-in model/sys table iterators in jevents.py
    and 'perf list --export-cpuid <cpuid|arch[/model]|all>' so any
    architecture or CPU model's events and metrics can be exported
    directly from the perf binary.
  - Patch 11 adds C unit tests ('Layered PMU directory overlays' in
    tests/pmu.c) and CLI shell tests (pmu_events_dir.sh) covering
    lossless JSON round-tripping, overlay priority, file deletion
    restoring lower-layer defaults, CPUID stepping symlinks,
    '--export-cpuid' cross-architecture/model export, and heterogeneous
    multi-instance PMU sub-metric resolution.

AI Assistance Disclosure (per Documentation/process/coding-assistants.rst
and Documentation/process/generated-content.rst):
- Tools used: Antigravity coding assistant and Sashiko automated patch
  review.
- Summary of prompts and assistance: Interactive design and
  implementation of the stateless struct pmu_layer stack, openat()
  directory layer and literal CPUID/sys symlink resolution,
  pmu-events.dir config support, struct perf_pmu metric routing and
  encapsulation, 'perf list --export-dir', 'perf list --export-cpuid',
  and 'jevents.py --output-dir' exporters, documentation, unit/shell
  tests, and Sashiko review fixes.
- Testing performed: Built standard (mypy, pylint, shellcheck),
  NO_JEVENTS=1, and DEBUG=1 + AddressSanitizer/LeakSanitizer builds;
  ran perf test (including Sysfs PMU tests, PMU JSON event tests, Hybrid
  event merging, perf list, pmu-events.dir, and metricgroup suites) and
  scripts/checkpatch.pl.

Ian Rogers (11):
  perf pmu: Generalize pmu_alias_info_file() and lazy single-event sysfs
    loading
  perf pmu: Add metric and metricgroup storage on struct perf_pmu
  perf pmu-layer: Introduce stateless struct pmu_layer abstraction and
    builtin adapter
  perf pmu-layer: Add openat-based directory layer with literal
    CPUID/symlink lookup
  perf config: Add pmu-events.dir configuration option
  perf pmu: Switch alias resolution and enumeration to layered PMU stack
  perf metricgroup: Route metric and metricgroup lookups through struct
    perf_pmu
  perf list, jevents: Add --export-dir and --output-dir sysfs-style
    exporters
  perf jevents: Add compiled-in model and sys table iterators
  perf list: Add --export-cpuid to export compiled-in CPU models
  perf tests: Add round-trip export, CPUID symlink, and pmu-events.dir
    overlay tests

 tools/perf/Documentation/perf-config.txt |   52 +
 tools/perf/Documentation/perf-list.txt   |   44 +-
 tools/perf/builtin-list.c                |  366 +-
 tools/perf/builtin-script.c              |    2 +-
 tools/perf/pmu-events/README             |   19 +
 tools/perf/pmu-events/empty-pmu-events.c |   36 +
 tools/perf/pmu-events/jevents.py         |  432 ++-
 tools/perf/pmu-events/pmu-events.h       |   15 +
 tools/perf/tests/pmu.c                   |  959 ++++++
 tools/perf/tests/shell/pmu_events_dir.sh |  236 ++
 tools/perf/util/Build                    |    1 +
 tools/perf/util/config.c                 |   15 +
 tools/perf/util/metricgroup.c            |  369 +-
 tools/perf/util/pmu-layer.c              | 3894 ++++++++++++++++++++++
 tools/perf/util/pmu-layer.h              |  199 ++
 tools/perf/util/pmu.c                    |  872 ++---
 tools/perf/util/pmu.h                    |   32 +-
 tools/perf/util/pmus.c                   |  239 +-
 tools/perf/util/pmus.h                   |   13 +
 tools/perf/util/print-events.c           |   33 +-
 tools/perf/util/python.c                 |    5 +-
 21 files changed, 7091 insertions(+), 742 deletions(-)
 create mode 100755 tools/perf/tests/shell/pmu_events_dir.sh
 create mode 100644 tools/perf/util/pmu-layer.c
 create mode 100644 tools/perf/util/pmu-layer.h


base-commit: 4af65363b11fc4fe65fcb497f68bbe4f3e3a4d2c
prerequisite-patch-id: 3e93fd262f5e70cff78114a0736c8fc8abeb7977
prerequisite-patch-id: 5e284ee3a3af71e8bfe3e40719396cf60fbece96
prerequisite-patch-id: 4d4b5b43c0ca0ac929fb3b73db615805e022d86a
prerequisite-patch-id: 447412f5e17799157dc8981ffa28378bc5f7fe72
prerequisite-patch-id: ac7b807fcd0e795cc831307eed2d7148a609b941
prerequisite-patch-id: 8c306425c73d176dfeeede044b57f7ed383e19d1
prerequisite-patch-id: dfce7f2910fbd18bc8dc3965c52cf6b08a825180
prerequisite-patch-id: 4730aa572afe4e6d47f6aceaff92fccc15327881
prerequisite-patch-id: 17cb0dd6eaa58cec5d6309dda84f122c6e381d4d
prerequisite-patch-id: cda8414fd68671e1333246f22cbfedb980173821
-- 
2.56.1.703.gf848ed807c-goog
