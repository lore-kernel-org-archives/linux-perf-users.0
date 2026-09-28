Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E734F7CAC;
	Mon, 28 Sep 2026 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633203; cv=none; b=X2fy4SJLMfOoQ9Yb3BgFd2JaF6VYUgGj09+kfVWwsbGqM517PyXWewln8FKI7UxiOvYJv9Psx67lX0I6C55/eF6Bu36TBeeLehfbEz5KmQ/z8TVrPkGS14qKEk4JOGlJnESbEyF6FfwHsxaVkF1u6gkJsLXYKsd/NeUpjcVkuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633203; c=relaxed/simple;
	bh=t412+FyUWMdIAYhRsJPiVcSlj9iqWE1r7COijD8Yf34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZrwT1ZFRCV3ByyknvU28Nqfflbz6Ip3J9hKR57E3gD0I3IFklpc8kYzN3rUutcPciidl/g6AE4nI7L+JLUpWzIOHHJ3JBQ8qJ9Cx8HudIyGByE7Zb5mbvsoQRKE6kmSaGjJ2dpkLH9sUu50ibUHcN6ugNZHW5nOIEt5J7DHHJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St6ZasZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St6ZasZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A8C1F000FF;
	Mon, 28 Sep 2026 22:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790633201;
	bh=6BZPb0UcVcyIBsuj//ocgdyyWVEMkUhFuzmyDZpSNq0=;
	h=From:To:Cc:Subject:Date;
	b=St6ZasZAajITwgIyL27I6NHvltfzvPVH7nCVVhM2WD2EtLyPWzmr33Dw2i/ufsUbz
	 sL2wGwDJB8NeErQnhq3wlEegN1XEoEv0mdWPGSfJvF8btL5nPXe3j1UmFbbJDIz73X
	 0oP0+XxhK73lmsUAdWymZmvK2yl6sW3QlsGahWhfW7wTrQWctYgRB2sJGpRpQHEZQx
	 uLAccEu783Zxpfus/tvHKjTnSD4oAaBBIPHW1Stc/gVjEu8FN71Coug0DVN7sT0faa
	 RE7GV3Fh4qVfjhPSWEaAAwExlm89fhiNCEJVFDfdTWBWEW/Z9wqZcqqsqD5wmsHQr7
	 AHj5tQ6lbwzKA==
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
Subject: [PATCH v3 0/4] perf tools: Add progress diagnostics and a false-sharing workload
Date: Tue, 29 Sep 2026 00:06:30 +0200
Message-ID: <20260928220634.2451784-1-acme@kernel.org>
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

  - add the prototype tools/perf/scripts/perf-stuck.sh helper, which samples
    a running perf process and can invoke the accompanying GDB commands when
    progress stops;

  - add 'perf test -w false_sharing', a synthetic TCP-shaped workload with
    identity and packet counters sharing a cacheline, and include it in the
    data type profiling shell test.

The progress backend handles nested phases and completes them on error paths
as well as successful paths. The false-sharing workload uses a shared
volatile instance so the data type profiler can resolve direct accesses to
the individual members.

The perf-stuck helper is intentionally a prototype and requires the usual
/proc access; its optional GDB mode additionally requires gdb and suitable
debug information. When only one CPU is available, the false-sharing
workload warns that it cannot produce cross-CPU traffic but still runs.

Testing:

  make -C tools/perf -j4
  tools/perf/perf test -w false_sharing
  taskset -c 0 tools/perf/perf test -w false_sharing
  bash -n tools/perf/scripts/perf-stuck.sh
  bash -n tools/perf/tests/shell/data_type_profiling.sh
  git diff --check 0ae6fc78c5ce0dfd..485532296710225862daf8ffb19802ae327efe2a

Best regards,

- Arnaldo

What changed from v2:

  - tools/perf/util/config.c: perf_etc_perfconfig() returned NULL when the
    allocation in system_path() fails, and none of its callers check for
    that.  Reported by Sashiko while reviewing v2: the deref reached from
    this series was fixed, and since the same unchecked deref is already
    reachable from the three callers predating it, perf_config_from_file()
    and 'perf daemon' among them, the opportunity was taken to make the
    accessor total as well, falling back to the unresolved path, which for
    the usual absolute ETC_PERFCONFIG is the same string;

  - tools/perf/scripts/perf-stuck.gdb: don't dereference map_symbol.sym
    without checking it for NULL, printing "(no symbol)" instead.  Reported
    by Sashiko while reviewing v2;

  - tools/perf/scripts/perf-stuck.gdb: note next to the structure walks
    that a REFCNT_CHECKING build wraps some structs in a proxy holding the
    original, where this has to read map->orig->dso->orig->name;

  - tools/perf/scripts/perf-stuck.sh: count the samples showing no progress
    when there is no progress to look at, as an empty or missing progress
    log reset the counter on every sample and never fired -g;

  - tools/perf/scripts/perf-stuck.sh: use `--` for pgrep and tail, as a
    process name starting with a hyphen was taken as an option and had the
    script attach to an unrelated process, gdb included when -g is used;

  - tools/perf/scripts/perf-stuck.sh: bound the gdb run with
    `timeout --signal=INT 30`, as the script makes inferior calls and one
    into a perf wedged in a loop never returns, while SIGINT lets gdb
    release the inferior instead of leaving perf stopped.

What changed from v1:

  - avoid calling CPU_SET() with -1 when false_sharing runs with only one
    CPU available in its affinity mask.

   tools/perf/Documentation/perf-report.txt      |  13 +
  tools/perf/builtin-config.c                   |  70 +----
  tools/perf/builtin-report.c                   |  10 +
  tools/perf/scripts/perf-stuck.gdb             | 109 ++++++++
  tools/perf/scripts/perf-stuck.sh              | 184 ++++++++++++++
  tools/perf/tests/builtin-test.c               |   1 +
  tools/perf/tests/shell/data_type_profiling.sh |   9 +-
  tools/perf/tests/tests.h                      |   1 +
  tools/perf/tests/workloads/Build              |   2 +
  tools/perf/tests/workloads/false_sharing.c    | 240 ++++++++++++++++++
  tools/perf/ui/Build                           |   1 +
  tools/perf/ui/progress.h                      |   2 +
  tools/perf/ui/stdio/progress.c                | 162 ++++++++++++
  tools/perf/util/config.c                      | 131 +++++++++-
  tools/perf/util/config.h                      |   2 +
  tools/perf/util/ordered-events.c              |  16 +-
  tools/perf/util/session.c                     |  12 +-
  17 files changed, 882 insertions(+), 83 deletions(-)
  create mode 100644 tools/perf/scripts/perf-stuck.gdb
  create mode 100755 tools/perf/scripts/perf-stuck.sh
  create mode 100644 tools/perf/tests/workloads/false_sharing.c
  create mode 100644 tools/perf/ui/stdio/progress.c

base-commit: 0ae6fc78c5ce0dfd
v1-head: 45d7917f7e05e8a29828ed5f0bbdc94fc938f79f
v2-head: d4f84e4de8890194924ccd897a8e6773e7d4240b
--
Assisted-by: OpenCode: GPT-5.6 Luna
