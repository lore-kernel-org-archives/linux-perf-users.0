Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812526;
	b=qy4My8tfDKb/QFm3ZZOc0C1i05YnzOANXMmTofBZpD1Q+hKswLdo6hD6QjNruHifWgpj
	 MY1s8mC1qg7/0O4O+l2dOR+jiHPkxsCBNuMg4UwQz1uzwR+tgt9OEFZxdiOUcVW4O3fn0
	 XaRMi/qAMqrAgV/7bm20sTBrA7Ysojwu7Hmj1fnXBtd3uuktdFJHQuWdA864yWI8outby
	 HGhWXY/KkIO3ooIErTwkYj7kXjpIzxr1d7z0eNS0juQsAa9Jh3+pc/xrQHn9Wm/4Jb94Y
	 aU1dLFHzL7gONcsso4lVcEbeP3qOTk+bUYrgSbkms0kdlxlLw8HbFBrGNXu4trM2TWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=cF1GhVGbCRbU0hezkwXtJ7kkSIkuwbbIzIGbBkJTIA0=;
	b=dietvUlR07ilO+RResUGJ7+/LDbqtbL5MUFijjnrF/obNXTkkH99u/50LJ2nNPzJysTM
	 D6OAtWzP79Hp0pkUXG7xnmBk2slq677VLZf99VJ0vyQ43F4bGCAlljKUEelMgSekNxjAu
	 d/HknjYZ3+8ipehRN1/3x99GI6a0nEfX8B5jsPg5QEfgUbJ8EV9t2W5n4/HNB39W2ERtt
	 BSCkpfdAOOdMkvkaarHMOcwWUKHyFyEKzKebdJsKQBCoXk5RAv0YgfwajKarB6k3SyOJT
	 TYWgIHYpRs3aYDByirKDuJXHDjW597NmVgAkAeXN5DMPEVxpqoYnw9FKHkb4fp0+VBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="MN7/MvbJ";
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3F606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5D3F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MN7/MvbJ
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso3968220eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794812525; x=1795417325; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cF1GhVGbCRbU0hezkwXtJ7kkSIkuwbbIzIGbBkJTIA0=;
        b=MN7/MvbJZpqBkfKVjaUwZoD87Sl1vBDgxdNBQ5s4p0KyDugQE5EqJoa1zojPEDu+T4
         0UP+WbRaHqKcmoVwMAwkz2t5NMjK9HqUVPD03YztL3uWrcUG/TS+5jQV+LGNKplse7CM
         9pEsi/yMJsVp+7lTyKPUTYfBtTyQ82itZ40072LfMFcSad65z+2vWrYpXbFJZf7XGcQo
         INUNGrRlHKbjuS3/FbF3fk4frJ0f2hCVY0AgVZfbLQB1bGjvvs6lz/Xz4Z5j/7Gk3Pol
         cCgCg94CAN7aFvrCR9+NknA3kId10AEiQOEBkNvL/UmwJ+CGpYwUL3YWifRDATP7hAR9
         DXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812525; x=1795417325;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cF1GhVGbCRbU0hezkwXtJ7kkSIkuwbbIzIGbBkJTIA0=;
        b=PQ4/ado0/qHPhaujGylPpEr0oGA63+qsOz4p1QnV4Ty9C0T0Grr933sU6OJNQeBXGi
         godPqTCzBi9m3glTo7rn0YUrvye3SfmlF80AM60w8TbwLS0UwMJtOnDvrzb2G8lsu7We
         GGGirFlyyRSeJGtvrMqWPf37jhN91nOLKGJkvqx1D9Ohapu/9d/Um153MXM+tmrIUYqa
         4X6FHuuszo0CVWWM9DFfWq14Nhy1J5RhxQCgHNZA32MkLhWC7n2mjV4CyyuT13Oou5o1
         rD4vpWop+JnHRUYqwAVL0E+xHTXQU1BX1i53fqAjbk1SuJ4PwMN+ltaeAGSz/9K6aS53
         e8YQ==
X-Forwarded-Encrypted: i=1; AL+hErHpBFkOu6stZf+2imD5VObEYgh9fjJRL7EaUSkdmzw2SNYY2edMPI57XC6CNC9Bba9gMvhq3KAw7HI0dc9qPAeU@vger.kernel.org
X-Gm-Message-State: APuU4Z8jbgg4Syw0JF/GZ4C1IzWVuxq6AGocl5Rxg6gdq3JiPzW8QLL0
	bLhELxvFfTO6ro91TXi5qkyo+1EDPsiXT3Bp3wm7QhuJXXbANRJS/bAtz8R4xiCZ5erD0tUo6hR
	p2KfB/p9x9g==
X-Received: from dybkz20.prod.google.com ([2002:a05:7301:1a14:b0:370:948e:79b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:820d:b0:36b:d3dd:2e85
 with SMTP id 5a478bee46e88-379676f8641mr9615570eec.36.1794812524383; Sun, 15
 Nov 2026 23:02:04 -0800 (PST)
Date: Sun, 15 Nov 2026 23:01:46 -0800
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
Message-ID: <20261116070200.2972362-1-irogers@google.com>
Subject: [PATCH v2 00/11] perf pmu: Layered sysfs-style PMU event and metric directories
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

v2:
- Rebase onto latest perf-tools-next and v2 of the perf jevents
  block-indexed string compression series (picking up NVIDIA Tegra410
  uncore PMU suffix handling and updated Zen 6 / Tegra410 JSON tables).
- v1: https://lore.kernel.org/linux-perf-users/20261113211105.3118281-1-irogers@google.com/

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


base-commit: b7ff10b9ddec8da75304c40fe4abf1ee4f9f0a43
prerequisite-patch-id: 380517d80b75a79f1831ac666c124fcef5cbf519
prerequisite-patch-id: 5e284ee3a3af71e8bfe3e40719396cf60fbece96
prerequisite-patch-id: 941dcc66edb6a846cc15ccc2c87c0955b000d5e4
prerequisite-patch-id: 447412f5e17799157dc8981ffa28378bc5f7fe72
prerequisite-patch-id: bbb89f0b8a053b7f91d00e834489285060b69ddc
prerequisite-patch-id: 8c306425c73d176dfeeede044b57f7ed383e19d1
prerequisite-patch-id: dfce7f2910fbd18bc8dc3965c52cf6b08a825180
prerequisite-patch-id: 4730aa572afe4e6d47f6aceaff92fccc15327881
prerequisite-patch-id: 17cb0dd6eaa58cec5d6309dda84f122c6e381d4d
prerequisite-patch-id: 8cc6043b4dd7c81151adcc8d602f93c644c5743a
-- 
2.56.1.703.gf848ed807c-goog

