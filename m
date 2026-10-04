Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0A3F4118;
	Sun,  4 Oct 2026 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791093909; cv=none; b=lRls4NYia9eR0qAB157e+RHITlUXxMebIPc0s9ifmjiGqH58X2N+RKAeO4Oz3NZ/h2+YrlELhtSYNCWfLRB4EnJFCuQ8G4C8DfytrOTRDFJced5f5kK7vsv1U8iinlLBNCQtgIQO5zCqNkdLxMl8baGDEKQ1HKe6PEHW2J5sfew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791093909; c=relaxed/simple;
	bh=Hko52g+/s21HBizQtLX++63tI6DMN3ZR0OGcSIKLIeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nIRFN+XWhgXs/hq35XbQ6ExmB9rYy8Ya5L1yYl4xkjgyMbPuvEjWiE3KjSSf6z2C0gfEYqUXm4GeW+JPEB30+YW4p+/NVXyizu77SbTImjP23RnQfvghq579CXduWPy2uXjco/z4hZOngQ3KfTaALAskrz+9s9mBl555KgmH7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oadercoT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oadercoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67C31F0089A;
	Sun,  4 Oct 2026 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791093907;
	bh=+A5hPcVP/3ByiT/3TXpnZySYCy9x1TCunBdSDaZCtCs=;
	h=From:To:Cc:Subject:Date;
	b=oadercoT2nt6lHSezXxMGI4i5Rnv7K+LqFzJBDfSKlWy7zLpEOqwPPhnFZC1hXMuL
	 IKODj3ndIvteOveOlzGPJiVf5P6hyXXSGqclXvLOaMf8UVxCCkVcXQpjnZs7GEEenN
	 wSd89MmudmM/CdaRd67FbsQlZOczu1aiXVRBnHdbYJ231HLs7lC4PNV+LBOv8SZoqo
	 jXaEf0z4TsbNMz5cDuKFNGMHZ1Gt7lH6U4AgMLxGQT+uha1n3IEwaUgWp7BJT4Ufro
	 Xfovgnu/9aEZwybA7qzHsJy+CP/LzKmE1pvlFt0WYNYbs2uQFWC6S4TyzdozaXlYby
	 WcWo/AWx4bP9Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v9 0/9] perf tools: Add progress diagnostics and a false-sharing workload
Date: Sun,  4 Oct 2026 08:04:47 +0200
Message-ID: <20261004060457.3353-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds progress and stuck-process diagnostics to perf, and a
workload that makes false sharing visible to data type profiling.

The changes are:

  - move perf_config__set_variable() to util/config.c and serialize config
    parser and read-modify-write state, so non-builtin perf code can persist
    configuration changes safely;

  - add 'perf report --progress' for stdio users, showing the current phase,
    percentage, and counts while a session is processed;

  - wire up 'perf report --no-progress', the counterpart of the option
    above, for the TUI and GTK browsers, whose progress there is no other
    way to turn off;

  - add the prototype tools/perf/scripts/perf-stuck.sh helper, which samples
    a running perf process and can invoke the accompanying GDB commands when
    progress stops;

  - add 'perf test -w false_sharing', a synthetic TCP-shaped workload with
    identity and packet counters sharing a cacheline, and include it in the
    data type profiling shell test.

Follow up work: the DO_ONCE() one-time init primitive added here mirrors
what the eight pre-existing raw pthread_once() users in util/ (annotate.c,
callchain.c, comm.c, dso.c, fncache.c, intel-tpebs.c, libbfd.c, pmus.c)
need, conversions that will also exercise the DEFINE_MUTEX() static
initializer; converting them is left for after this series.

Best regards,

- Arnaldo

What changed from v8:

  - tools/perf/util/mutex.h: DEFINE_MUTEX() statics keep mutex_init()'s
    !NDEBUG errorcheck type;

  - patch 4/9 commit log: clarify the acquire/release pairing, what the
    dropped static key used to guarantee.

What changed from v7:

  - tools/perf/util/mutex.h: the DO_ONCE() lockless fast path pairs its
    __ATOMIC_ACQUIRE load with the __ATOMIC_RELEASE store.  sashiko, v7;

What changed from v6:

  - patch 1/5 split into four: the move, perf_etc_perfconfig() never
    returning NULL, the DEFINE_MUTEX() prep and the serialization.
    Namhyung Kim asked, v6;

  - tools/perf/util/{config.c,mutex.h}: perf's own mutex type, adding
    the DEFINE_MUTEX() initializer it lacked.  Namhyung Kim, v6;

  - tools/perf/util/mutex.h: add DO_ONCE() one-time init, from the
    kernel's once.h, moving the lazy inits in config.c to it;

  - tools/perf/builtin-report.c: drop the option negation and stdio
    hook comments Namhyung Kim asked to drop, reviewing v6;

  - tools/perf/scripts/perf-stuck.gdb: break the long printf() line.
    Namhyung Kim, reviewing v6;

  - the false_sharing cset now carries the data type profiling output
    with cacheline info.  Namhyung Kim asked for it, reviewing v6.

What changed from v5:

  - tools/perf/util/config.c: drop the config_file_name read in
    bad_config(), locking would buy a consistent NULL.  Sashiko, v5;

  - tools/perf/util/config.c: new config_set_mutex around the shared
    set's init/teardown, home init via pthread_once.  Sashiko, v5;

  - tools/perf/builtin-report.c, perf-report.txt: --no-progress is
    --progress's auto negation, last wins.  Namhyung Kim, reviewing v5.

What changed from v4:

  - tools/perf/builtin-report.c: mark --progress PARSE_OPT_NOAUTONEG,
    parse_long_opt() claimed --no-progress first.  Sashiko, v4;

  - tools/perf/util/config.c: format the path buffer inside the critical
    section.  Sashiko pointed out the window, reviewing v4;

  - tools/perf/tests/workloads/false_sharing.c: walk every bit of the
    affinity mask, not _SC_NPROCESSORS_CONF.  Sashiko, reviewing v4.

What changed from v3:

  - tools/perf/util/config.c: keep the buffer handed to the parser in
    static storage.  Sashiko, reviewing v3;

  - tools/perf/scripts/perf-stuck.gdb: perf-dso walks each dso candidate
    until one evaluates, for REFCNT_CHECKING builds.  Sashiko, v3;

  - tools/perf/tests/workloads/false_sharing.c: sum before cpu in struct
    fs_reader, the padding after cpu rounded it to 128.  Sashiko, v3;

  - tools/perf/builtin-report.c: --quiet wins over --progress, the phases
    stay uncounted, documented next to it.  Namhyung Kim, v3;

  - tools/perf/builtin-report.c, tools/perf/ui/progress.c: --no-progress
    installs the no-op ops.  Suggested by Namhyung Kim, reviewing v3;

  - tools/perf/scripts/perf-stuck.sh: check gdb is there before
    watching.  Namhyung Kim, reviewing v3.

What changed from v2:

  - tools/perf/util/config.c: make perf_etc_perfconfig() total, falling
    back to the unresolved path.  Sashiko, reviewing v2;

  - tools/perf/scripts/perf-stuck.gdb: don't deref map_symbol.sym without
    a NULL check.  Sashiko, reviewing v2;

  - tools/perf/scripts/perf-stuck.gdb: note the REFCNT_CHECKING proxy
    next to the structure walks;

  - tools/perf/scripts/perf-stuck.sh: count samples with no progress to
    look at, an empty log never fired -g;

  - tools/perf/scripts/perf-stuck.sh: `--` for pgrep and tail against
    names starting with a hyphen;

  - tools/perf/scripts/perf-stuck.sh: bound the gdb run with
    `timeout --signal=INT 30`.

What changed from v1:

  - avoid calling CPU_SET() with -1 when false_sharing runs with only one
    CPU available in its affinity mask.

 tools/perf/Documentation/perf-report.txt      |  19 ++
 tools/perf/builtin-config.c                   |  70 +----
 tools/perf/builtin-report.c                   |   9 +
 tools/perf/scripts/perf-stuck.gdb             | 131 +++++++++
 tools/perf/scripts/perf-stuck.sh              | 193 ++++++++++++++
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/shell/data_type_profiling.sh |   9 +-
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/tests/workloads/Build              |   2 +
 tools/perf/tests/workloads/false_sharing.c    | 251 ++++++++++++++++++
 tools/perf/ui/Build                           |   1 +
 tools/perf/ui/progress.c                      |   6 +
 tools/perf/ui/progress.h                      |   4 +
 tools/perf/ui/stdio/progress.c                | 162 +++++++++++
 tools/perf/util/config.c                      | 166 ++++++++++--
 tools/perf/util/config.h                      |   2 +
 tools/perf/util/mutex.h                       |  36 +++
 tools/perf/util/ordered-events.c              |  16 +-
 tools/perf/util/session.c                     |  12 +-
 19 files changed, 991 insertions(+), 100 deletions(-)
 create mode 100644 tools/perf/scripts/perf-stuck.gdb
 create mode 100755 tools/perf/scripts/perf-stuck.sh
 create mode 100644 tools/perf/tests/workloads/false_sharing.c
 create mode 100644 tools/perf/ui/stdio/progress.c
base-commit: 705da5b15ab89ba9
v1-head: 45d7917f7e05e8a29828ed5f0bbdc94fc938f79f
v2-head: d4f84e4de8890194924ccd897a8e6773e7d4240b
v3-head: 485532296710225862daf8ffb19802ae327efe2a
v4-head: 38193635508e0a5f04a6ebf70db27534b68b2d5b
v5-head: e99bc48f6c72b9cc67b4e4143a0364acac5523bb
v6-head: 7dc99dbb6504f199c3c39487d91370d1bbb7a827
v7-head: b357a76666d08f74eb99c755cca41855a96f6169
v8-head: 257b5ea6115ad5126d2c881523ea6c660cf5d28c
--
