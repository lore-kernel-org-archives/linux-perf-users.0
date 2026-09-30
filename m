Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971ED5208D6;
	Wed, 30 Sep 2026 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804244; cv=none; b=q2AHsrS7pjvMquVBL1FZ0noVHfqFNiXXCKgJ/LETFqGALDmjCTPqMsTRlNzobNi4pwnPugVTWyJt0Yu9gQGPyQIrijKEGojg0h4r6bTpQ1wSwvYavL7UOmpUe50FyNxF5dwVAWuvq8P559RJTDjjG6QM1/o42f2Ms88zUDZT/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804244; c=relaxed/simple;
	bh=u7kfe8N69dpfP3XeFZn5s0b4ib5S3y6YEW2195wFpHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrArNxasA7DApgmec5MY3e0cwS//DHfialNRJbiPtRRuKSnsaTV17UfKJoD6QXguUjS4GwfD9ReBDRDnVZpXWhJO5ZmPXDsgGJ01NZbsd8+57fwNsvwGjVn8E0Gn3fZVyPwc0npmBanW++qVeD+bZNGN9GSUdPAnVT5bUbxzwcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfqoke17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wfqoke17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A411F000FF;
	Wed, 30 Sep 2026 21:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804243;
	bh=JoLNxCymMhrP/ukLhDMdK8cfpBrmNF6rTmfdgLD7dIk=;
	h=From:To:Cc:Subject:Date;
	b=Wfqoke17Ygv/8o3GUkDp8v3qQBIa++UEJMH2ISvKVDpe6Pw7YBk5OOHoTwbVVXJqJ
	 2pRoNHX3u2Xt33zJGz19aehMj3el2XPuJU77uNLtAYcjaLxYE/35m0xpSw2ODHbjYq
	 CUfuWjHFTZT0CFz0Aa0eqOdf4MuoIzJjorGFB31a1GUke9ol5n7paElVM9EzYvmWBT
	 VfwKNjPwQoJDtEgGERlcqYkoJAgGzI+jaZUjqEJOdIVf8/08TV6xtLBCFsARcFsTB/
	 wXr0uPSIAY61ZBIWuRyyC9oVUaxaweO4lehpdDC1KRaUL6JuOxfOEz+xmhLL6/7GCA
	 LhICB0MNkUbFg==
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
Subject: [PATCH v6 0/5] perf tools: Add progress diagnostics and a false-sharing workload
Date: Wed, 30 Sep 2026 23:37:11 +0200
Message-ID: <20260930213716.2633750-1-acme@kernel.org>
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

  - add 'perf report --no-progress', the counterpart above for the TUI and
    GTK browsers, whose progress there is no other way to turn off;

  - add the prototype tools/perf/scripts/perf-stuck.sh helper, which samples
    a running perf process and can invoke the accompanying GDB commands when
    progress stops;

  - add 'perf test -w false_sharing', a synthetic TCP-shaped workload with
    identity and packet counters sharing a cacheline, and include it in the
    data type profiling shell test.

Best regards,

- Arnaldo

What changed from v5:

  - tools/perf/util/config.c: check fprintf()/fclose() in
    perf_config_set__write(), a write failure was reported as success;

  - tools/perf/ui/stdio/progress.c: fix the "[42.3%]" changelog example
    and two comments that opened at the wrong indent;

  - tools/perf/scripts/perf-stuck.sh: validate -i/-n, require -g for -x,
    and clear gdb_done on progress so -g can fire more than once;

  - tools/perf/tests/workloads/false_sharing.c: say sum, not hash, and
    describe the actual perf mem record + report -s type verification;

Found in a pre-post read-through of v5, not a list reply.

What changed from v4:

  - tools/perf/builtin-report.c: mark --progress PARSE_OPT_NOAUTONEG,
    parse_long_opt() claimed --no-progress before reaching it.  Sashiko, v4;

  - tools/perf/util/config.c: format the path buffer inside the
    critical section, mkpath() ran outside the lock.  Sashiko, v4;

  - tools/perf/tests/workloads/false_sharing.c: walk every affinity mask
    bit instead of bounding by NPROCESSORS_CONF.  Sashiko, v4;

What changed from v3:

  - tools/perf/util/config.c: keep the config_file_name buffer in
    static storage, a reader outside a parse could race it.  Sashiko, v3;

  - tools/perf/scripts/perf-stuck.gdb: perf-dso walks each candidate,
    resolving the REFCNT_CHECKING proxy instead of aborting.  Sashiko, v3;

  - tools/perf/tests/workloads/false_sharing.c: put sum before cpu in
    fs_reader, alignment was doubling it to 128 bytes.  Sashiko, v3;

  - tools/perf/builtin-report.c: document what --quiet does to
    --progress, asked by Namhyung Kim reviewing v3;

  - tools/perf/builtin-report.c, tools/perf/ui/progress.c: add
    --no-progress, suggested by Namhyung Kim reviewing v3;

  - tools/perf/scripts/perf-stuck.sh: check gdb is present before
    watching instead of failing when -g first fires.  Namhyung, v3;

What changed from v2:

  - tools/perf/util/config.c: make perf_etc_perfconfig() total, it
    returned NULL on allocation failure.  Sashiko, v2;

  - tools/perf/scripts/perf-stuck.gdb: don't deref map_symbol.sym
    without a NULL check, print "(no symbol)" instead.  Sashiko, v2;

  - tools/perf/scripts/perf-stuck.gdb: note the REFCNT_CHECKING proxy
    indirection next to the structure walks;

  - tools/perf/scripts/perf-stuck.sh: count samples with no progress to
    look at, an empty log never fired -g;

  - tools/perf/scripts/perf-stuck.sh: use -- for pgrep and tail, a name
    starting with '-' attached to the wrong process;

  - tools/perf/scripts/perf-stuck.sh: bound the gdb run with
    timeout --signal=INT 30, an inferior call can hang forever;

What changed from v1:

  - avoid calling CPU_SET() with -1 when false_sharing runs with only one
    CPU available in its affinity mask.

      tools/perf/Documentation/perf-report.txt      |  19 ++
  tools/perf/builtin-config.c                   |  70 +------
  tools/perf/builtin-report.c                   |  23 +++
  tools/perf/scripts/perf-stuck.gdb             | 129 +++++++++++++
  tools/perf/scripts/perf-stuck.sh              | 193 ++++++++++++++++++++
  tools/perf/tests/builtin-test.c               |   1 +
  tools/perf/tests/shell/data_type_profiling.sh |   9 +-
  tools/perf/tests/tests.h                      |   1 +
  tools/perf/tests/workloads/Build              |   2 +
  tools/perf/tests/workloads/false_sharing.c    | 251 +++++++++++++++++++++++++
  tools/perf/ui/Build                           |   1 +
  tools/perf/ui/progress.c                      |   6 +
  tools/perf/ui/progress.h                      |   4 +
  tools/perf/ui/stdio/progress.c                | 162 +++++++++++++++
  tools/perf/util/config.c                      | 219 +++++++++++++++++---
  tools/perf/util/config.h                      |   2 +
  tools/perf/util/ordered-events.c              |  16 +-
  tools/perf/util/session.c                     |  12 +-
  18 files changed, 1021 insertions(+), 99 deletions(-)
  create mode 100644 tools/perf/scripts/perf-stuck.gdb
  create mode 100755 tools/perf/scripts/perf-stuck.sh
  create mode 100644 tools/perf/tests/workloads/false_sharing.c
  create mode 100644 tools/perf/ui/stdio/progress.c

base-commit: 0ae6fc78c5ce0dfd
v1-head: 45d7917f7e05e8a29828ed5f0bbdc94fc938f79f
v2-head: d4f84e4de8890194924ccd897a8e6773e7d4240b
v3-head: 485532296710225862daf8ffb19802ae327efe2a
v4-head: 38193635508e0a5f04a6ebf70db27534b68b2d5b
v5-head: 352709b39c0db8789a54d4ecca0251b26b1bf839
--
