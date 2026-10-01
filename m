Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D92364943;
	Thu,  1 Oct 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880850; cv=none; b=okKplNdy8DgH4KGoY5FWoeUeANMvYOh354ZJxLRuk7BMfohIRFAfj1y9Wbm2JZi2c8xwLDUsp4K94udVEL9p8iiO403bSVLWBXPX0wmDc67Dbe1aLzTFGRPpVLLAckDXfm71uFjoXvwX9fI4xKOuy6fkoyPi2rDTjmmziSnNH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880850; c=relaxed/simple;
	bh=6W9aadm6eZGsJ2BKr2Ac9REOKldkcnk/oT88YwLIiPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rE0uZC3UmWaiWhkd8xxryo3i/7DLcHvvJJ0gz52pDfRy90SfGlufRf3pCGTfJUQu6cmpq0Bl9LCLTu+IYrb8mDF1O8n868FNnkeTiMtosXCfAlYfiHubOBvZTflL7nnR1JAG4pbdcYLBTp+vjgB6MRSwtcmyqh0673r85lyR3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9WXLdf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9WXLdf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E401F000FF;
	Thu,  1 Oct 2026 18:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790880848;
	bh=rlN7RXsg9WY+NtxETUOS/bEA1ai5FgVMCMNurAw1oLU=;
	h=From:To:Cc:Subject:Date;
	b=W9WXLdf9jug89VNuy9eB4gx9GDAH/rAGB0rTsts+tF1RuSybwPOHvC74/iyDr/1bf
	 Xczz9b++551egSTUrukvv4SfRanu6swsEilHlI+9DIPHZyGuDEBPSWkSaF6mQ+duhx
	 gisME11miu9e/vGcFItl3pE/z2n46MhstXh4nZMmx82lShceLCQ2J8ZMZWhugwsmtu
	 1ayGfdMq48qQqx7wx0khvnCslSOC2OKzR9brukjg3OX3EgjPATP/vWGWP1GJr+1SkS
	 PY1qQIjwWtmORv7+SewzXtsFG1ZdNMCF4teiLenQsxDeOL/yPQcTiWGhnF5JhOIIhA
	 //E3OS3qxr3hA==
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
Subject: [PATCH v7 0/9] perf tools: Add progress diagnostics and a false-sharing workload
Date: Thu,  1 Oct 2026 20:53:51 +0200
Message-ID: <20261001185400.2754753-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
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

Best regards,

- Arnaldo

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
 tools/perf/util/mutex.h                       |  26 ++
 tools/perf/util/ordered-events.c              |  16 +-
 tools/perf/util/session.c                     |  12 +-
 19 files changed, 981 insertions(+), 100 deletions(-)
 create mode 100644 tools/perf/scripts/perf-stuck.gdb
 create mode 100755 tools/perf/scripts/perf-stuck.sh
 create mode 100644 tools/perf/tests/workloads/false_sharing.c
 create mode 100644 tools/perf/ui/stdio/progress.c

base-commit: 0ae6fc78c5ce0dfd
v1-head: 45d7917f7e05e8a29828ed5f0bbdc94fc938f79f
v2-head: d4f84e4de8890194924ccd897a8e6773e7d4240b
v3-head: 485532296710225862daf8ffb19802ae327efe2a
v4-head: 38193635508e0a5f04a6ebf70db27534b68b2d5b
v5-head: e99bc48f6c72b9cc67b4e4143a0364acac5523bb
v6-head: 7dc99dbb6504f199c3c39487d91370d1bbb7a827
--
