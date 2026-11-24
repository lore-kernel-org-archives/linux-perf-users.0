Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545972;
	b=JtQttwSfP1meIMzgJjL6qeuVfGWn96Jm2AF6Xxcb4R8fP663i4CNpby0l2W7mViiSeqX
	 iIhQ3ExE/mWWBrGwHReps78bDihJ86j+o83IwrLfwXxNy/KpmGwgAn6WqFu8OGCLJlP7G
	 HwbhCRDn8dxGXo//GJnNyFc/NxuJ0EA/pgKyuxJQSXeG7zgfWn2fTdwdMmzj7aI3Kf3G/
	 FXAWT+oVrEgWe32FMhbpkHUcYvGT6Mz6xZEzXs8k+SDVib++rl7j9zsA/bWXJ4GPdJtX3
	 b1nbQbRiQKjoC4zwaB/axrFEjA7DkWlKODmQfbk5CBAnasmE88wUlfDeMQ7ZX2c9REQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545972;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fPYJMnakdHXmxaVsksF+JqMCJDQXjUDeJTxAeWt9ZMg=;
	b=Ar2H3L9Oya6+g/A79KqCEgysJFW9fZBH+rQF/Apkk4sjo+JCpkUWMc9LBdxVXNrcdjj2
	 rvIMT5rxj44EYfCKsbVy4c0FnuMhWPjJkQw0c3NK4dh48pw4qyzG8M6V1j3hpqvGKGM86
	 LGht2s4VjKFSZn62ckeK/GwhQrzhWvG28+U0iCWT5f2SXQIo4IL9ESmI8vNNqsvmuvwR5
	 ELFCLLPM7nSOOkQ7e9zOyo7+UpwhMQiGIa03ALYtHgFBQpakomzGVWyEqzDdyvaID8lnm
	 NS6iU+Ln7KqHWHQAiRAzMufoWoJMF0JkstdNY0NJtnBeSzQZeJeSYeVG1RwPaaMfFlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnfsgSdV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADA606A321;
	Tue, 24 Nov 2026 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnfsgSdV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013AC1F000C6;
	Tue, 24 Nov 2026 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545971;
	bh=fPYJMnakdHXmxaVsksF+JqMCJDQXjUDeJTxAeWt9ZMg=;
	h=From:To:Cc:Subject:Date;
	b=mnfsgSdVk4GOHXfGr3Q1mN6W8egHsMIL3X/w0Ozxz+RLHfKB++YPJPQIKapeWH52f
	 BZo8ZFO6Tx6AVsNZvJMeITngRkmDUpgXKEzXiZMbwhC86vuiPRqmAmDe49a/uZnj5J
	 tQkDPcngMujE3j3VOpQuNPApQpBEDloDFp8bFNtCjHTtJeji7RS9dtyz5gDxNqsKOn
	 nnitcgjMov14u1WyjXt83ZM3+PM+kU42So2wfqBHIvBUfZxF5A+s/Q/+H56mJqseg9
	 NS2JA/3943QUhxqIZWHn1JLKjW0mWrcX9p8RUtinnrYru8S7p3r30lC/4Z9VZAeIlR
	 phvIUUtpxJing==
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
Subject: [PATCH v1 00/17] perf tests: Add coverage for the untested perf subcommands
Date: Tue, 24 Nov 2026 15:45:47 -0300
Message-ID: <20261124184604.24983-1-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The v12 "perf coverage: A harness for perf, and the fixes it found"
series is still unmerged.  The coverage analysis done for it showed
that several perf subcommands had no shell test coverage at all, and it
also caught two issues in the existing tests.  This series is that
result, made independent of the harness: everything here applies to
perf-tools-next with nothing from v12, so it can be considered on its
own while that series is still being reviewed.

Patches 1-2 fix existing tests, patches 3-17 add or extend tests for
the subcommands the analysis found untested.  All changes are in
tools/perf/tests/shell/, no production code is touched.

  - perf top pins its ring buffer to the default data size, so the
    result does not depend on the host's perf_event_mlock_kb (1).
  - perf sched captures the workload output before grepping it, so a
    saturating grep cannot kill the producer with SIGPIPE;
    --no-inherit was dropped, it is already cleared for CPU-wide
    recording (2).
  - help (3) and config (4) get their first tests; help -a works in
    build trees via a dummy exec path.
  - script list, fields and dump (5), report and diff sort keys (6).
  - diff options (7) are checked by what each changes: the compute
    formulas by their column, --time by a window that shows nothing,
    -o by the entry order, -b on a file whose entries have no baseline
    match.
  - annotate (8) and report (9) options the same way; the ones with
    nothing to observe in stdio output run as parse checks.
  - record (10), trace (11) and timechart (12) options.
  - kmem (13) and bench (14) get their first tests; the bench ones
    skip cleanly when root or the hardware is missing, including
    benchmarks that skip themselves with a zero exit status.
  - lock (15) report and info, probe (16) variable and line listing.
  - report TUI (17): the six browsers are driven from a pty.

Running as non-root on this host, 13 of the 17 scripts exit 0; perf
sched, kmem, lock and trace need root and exit 2 with their skip
message, as designed.  All option names and expectations were checked
against the built perf -h output and the sources.

The tests, the two fixes and the review fixes were developed with an AI
coding assistant (OpenCode): it drafted the tests, found the two issues
above and processed three rounds of review findings.  Every commit was
reviewed, amended and run here before posting.

Arnaldo Carvalho de Melo (17):
  perf tests top: Pin the ring buffer size
  perf tests sched: Exercise the sched views and options
  perf tests help: Add a basic perf help test
  perf tests config: Exercise the config file and list options
  perf tests script: Exercise the list, fields and dump options
  perf tests sort: Exercise the report and diff sort keys
  perf tests diff: Exercise the output options
  perf tests annotate: Exercise the output and filter options
  perf tests report: Exercise the output and format options
  perf tests record: Exercise more record options
  perf tests trace: Exercise the tracing options
  perf tests timechart: Exercise the report options
  perf tests kmem: Add a basic perf kmem test
  perf tests bench: Add smoke tests for perf bench
  perf tests lock: Exercise perf lock report and info
  perf tests probe: Exercise the variable and line listing
  perf tests report: Exercise the TUI browsers

 tools/perf/tests/shell/annotate.sh        |  64 +++++++
 tools/perf/tests/shell/bench.sh           | 130 +++++++++++++
 tools/perf/tests/shell/config.sh          | 134 ++++++++++++++
 tools/perf/tests/shell/diff.sh            | 191 ++++++++++++++++++-
 tools/perf/tests/shell/help.sh            |  80 ++++++++
 tools/perf/tests/shell/kmem.sh            | 215 ++++++++++++++++++++++
 tools/perf/tests/shell/lock_contention.sh |  40 ++++
 tools/perf/tests/shell/probe_vars.sh      |  80 ++++++++
 tools/perf/tests/shell/record_options.sh  | 173 +++++++++++++++++
 tools/perf/tests/shell/report_options.sh  | 122 ++++++++++++
 tools/perf/tests/shell/report_tui.sh      | 112 +++++++++++
 tools/perf/tests/shell/sched.sh           | 154 +++++++++++-----
 tools/perf/tests/shell/script.sh          | 131 ++++++++++++-
 tools/perf/tests/shell/sort.sh            |  72 ++++++++
 tools/perf/tests/shell/timechart.sh       |  46 +++++
 tools/perf/tests/shell/top.sh             |   7 +-
 tools/perf/tests/shell/trace_options.sh   |  97 ++++++++++
 17 files changed, 1794 insertions(+), 54 deletions(-)
 create mode 100755 tools/perf/tests/shell/bench.sh
 create mode 100755 tools/perf/tests/shell/config.sh
 create mode 100755 tools/perf/tests/shell/help.sh
 create mode 100755 tools/perf/tests/shell/kmem.sh
 create mode 100755 tools/perf/tests/shell/probe_vars.sh
 create mode 100755 tools/perf/tests/shell/record_options.sh
 create mode 100755 tools/perf/tests/shell/report_options.sh
 create mode 100755 tools/perf/tests/shell/report_tui.sh
 create mode 100755 tools/perf/tests/shell/sort.sh
 create mode 100755 tools/perf/tests/shell/trace_options.sh

-- 
2.56.0

