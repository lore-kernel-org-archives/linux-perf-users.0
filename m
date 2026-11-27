Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795743492;
	b=TZ+LmNQgedCIdxZabG9USRkl1/eM3upsaMutZScULo4VCVFrzpVM28zTWL6pRkBfBheT
	 oSD+cNDd9gQNFP1D8T9fEZhfNvwjh2Vd4+7iKxA8rb87/NKG88yLftGf6RBAJCauQVrOb
	 cpHofM/H3y0u0jgQlALJcYnv7TlC2Ry70PokZqFW4uH+tejnWdQKfvMMNsZuwPWrzmjyA
	 aj6KNhB2IF9GzhkSG3mSLRLWbetzl3ZeZx/3MXzCjFNBo3KkRN0wcfMnGK6pnLEFCx6Bm
	 bAsybgAdI0cktVM6zq6KzuIsy5qGKgMb+FHRkqdjHbtcRo0ixGePlKMpW3LUM3tGHag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795743492;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oqleueltY0PF3Vehl75yf9ylYqgDsqD6agfTsEQoy9s=;
	b=Yu68XpVySNR66+zT3SRCuyOdh2RwkyfiyBaizUyAKAHe6w6Chi8ldPcFcusZtVc7mK2w
	 gVL5K6WgQmMjnkJL8Ml7+VTNhPVPCTiA57AovU1Olw2ViBA0EXdkh3YPpRcipSY+/nVXx
	 xhnAXrQeue+uPa9EzxEUg8EM0Jz51gzrHA4WT1ey9g+QfBDYQivH6bKiWoX/KDNVfd6kO
	 s2WQvmYPzNKXeFtqZw9tBTztOpn9O7WT5FzJxN/tEEy3BGePGG+I72A0uHGY+W9VFYQcp
	 vxLBN19jTHPodDjV4ye+utgGopYLaef62d8zIGbznL187rtV2Pi6jppzKoGVNxHemaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJ5B5BQA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAA606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJ5B5BQA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1C31F00893;
	Fri, 27 Nov 2026 01:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795743491;
	bh=oqleueltY0PF3Vehl75yf9ylYqgDsqD6agfTsEQoy9s=;
	h=From:To:Cc:Subject:Date;
	b=dJ5B5BQArTA0wc/+LDFRIOY7PabQtCEjbHd518QJ44xnTCn1QOLVVz4w/CMunSsAX
	 UX3D7l9rByNhytp0qBnUrkRQu1aNegad9Qwo8BsCuYlv+z3udD2ERYde31B28bXfnW
	 yZtU7lQjrlTv0PzmItrr3qggOnDXThNyheMHwuzM9N7qmL3Lg3359ga6TNMxxj7nsQ
	 wgHzzCrwwmbaVHJrDTzKinbdSLRnLZwAkF9SX+8sxf2MpzY4eeOgzC6q6oXqiXH5WW
	 jJ6itP9tGjhpTQ/kdtEotJ8hJeNo/DUgF12htLLkb+XR+1OmjPLhZttqzTC/iB7DFK
	 JXE2UDKnZVYWA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 00/18] perf tests: Add coverage for the untested perf subcommands
Date: Thu, 26 Nov 2026 22:37:43 -0300
Message-ID: <20261127013801.14841-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

The v13 "perf coverage: A harness for perf, and the fixes it found"
series is posted but still unmerged.  The coverage analysis showed
that several perf subcommands had no shell test coverage at all, and it
also caught issues in the existing tests and in perf kmem.  This series
is that result, made independent of the harness: everything here applies
to perf-tools-next with nothing from v13, so it can be considered on its
own while that series is still being reviewed.

Patch 1 fixes perf kmem, patches 2-3 fix existing tests, patches 4-18
add or extend tests for the subcommands the analysis found untested.
The only production change is (1); the rest is in tools/perf/tests/shell/.

  - perf kmem's page free path looked up the alloc tree with the order
    from the free event but the other key fields from the allocation,
    so a split or reused page missed the entry and the whole stat failed
    with -ENOMEM.  Take the order from the allocation record as well (1).
  - perf top pins its ring buffer to the default data size, so the
    result does not depend on the host's perf_event_mlock_kb (2).
  - perf sched captures the workload output before grepping it, so a
    saturating grep cannot kill the producer with SIGPIPE;
    --no-inherit was dropped, it is already cleared for CPU-wide
    recording (3).
  - help (4) and config (5) get their first tests; help -a works in
    build trees via a dummy exec path.
  - script list, fields and dump (6), report and diff sort keys (7).
  - diff options (8) are checked by what each changes: the compute
    formulas by their column, --time by a window that shows nothing,
    -o by the entry order, -b on a file whose entries have no baseline
    match.
  - annotate (9) and report (10) options the same way; the ones with
    nothing to observe in stdio output run as parse checks.
  - record (11), trace (12) and timechart (13) options.
  - kmem (14) and bench (15) get their first tests; the bench ones
    skip cleanly when root or the hardware is missing, including
    benchmarks that skip themselves with a zero exit status.
  - lock (16) report and info, probe (17) variable and line listing.
  - report TUI (18): the six browsers are driven from a pty.

Running as non-root on this host, 12 of the 17 scripts exit 0; perf
sched, kmem, lock and trace need root and exit 2 with their skip
message, as designed, and timechart exits 2 when perf timechart record
is not permitted.  Running as root, the five root-only scripts and the
two with root-gated subtests all pass, including the page allocator
stats that exposed (1).  All option names and expectations were checked
against the built perf -h output and the sources.

What changed from v1
--------------------
Sashiko found environment-dependent failures in eleven patches; a
review pass found four more, and a final check caught the cleanup
trap turning a missing-symbol skip into a failure.  All are fixed in
place, with no Fixes: or Reported-by: tags added.

  - top (2): -m 512K and --no-bpf-event, so neither the main nor the
    sideband evlist sizes its ring buffer from perf_event_mlock_kb.
  - sched (3): no migration is expected from the pinned workloads, and
    the stats tests skip when /proc/schedstat is absent.
  - script (6), sort (7), kmem (14): disasm, the "type" sort key and
    kmem are gated on libcapstone, DWARF and libtraceevent support.
  - diff (8): cleanup runs before the symbol skips and preserves exit
    2; --time stays in range and checks perf's status, and later
    tests cannot mask failures or run on unrecorded files.
  - record (11): --switch-output=4K with a check that a switch really
    happened, a raised fd limit for parallel streaming, and aio and
    NUMA gates that skip CPU-less nodes.
  - trace (12): the syscall list is one -e argument, not three that
    overwrite each other, and the uid test needs BPF skeletons.
  - timechart (13): the report option tests exit 2 as a skip when
    nothing could be recorded, they were reported as Ok.
  - bench (15): libnuma and CPU gates, hardware breakpoint skips, and
    a missing uprobe result treated as a skip.
  - lock (16): a failing perf lock report or info now fails the test,
    the error trap used to exit with status 0.
  - probe (17): line listing skips when the kernel source is absent.
  - report TUI (18): one user-space event and -q avoid the event menu
    and the kptr_restrict dialog; a closed pty no longer raises EIO.
  - kmem tool (1): a root run of the new test found page frees that
    failed with -ENOMEM; the alloc-tree lookup now uses the order
    recorded at allocation time.

The tests, the three fixes and the review fixes were developed with an
AI coding assistant (OpenCode): it drafted the tests, found the three
issues above and processed five rounds of review findings.  Every
commit was reviewed, amended and run here before posting.

Arnaldo Carvalho de Melo (18):
  perf kmem: Use the allocation order when matching page frees
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

 tools/perf/builtin-kmem.c                 |   6 +
 tools/perf/tests/shell/annotate.sh        |  64 +++++++++
 tools/perf/tests/shell/bench.sh           | 154 ++++++++++++++++++++
 tools/perf/tests/shell/config.sh          | 134 +++++++++++++++++
 tools/perf/tests/shell/diff.sh            | 232 ++++++++++++++++++++++++++++--
 tools/perf/tests/shell/help.sh            |  80 +++++++++++
 tools/perf/tests/shell/kmem.sh            | 222 ++++++++++++++++++++++++++++
 tools/perf/tests/shell/lock_contention.sh |  55 +++++++
 tools/perf/tests/shell/probe_vars.sh      |  87 +++++++++++
 tools/perf/tests/shell/record_options.sh  | 215 +++++++++++++++++++++++++++
 tools/perf/tests/shell/report_options.sh  | 122 +++++++++++++++
 tools/perf/tests/shell/report_tui.sh      | 120 ++++++++++++++++
 tools/perf/tests/shell/sched.sh           | 164 +++++++++++++++------
 tools/perf/tests/shell/script.sh          | 135 +++++++++++++++++-
 tools/perf/tests/shell/sort.sh            |  77 ++++++++++
 tools/perf/tests/shell/timechart.sh       |  46 +++++
 tools/perf/tests/shell/top.sh             |  11 +-
 tools/perf/tests/shell/trace_options.sh   | 103 +++++++++++++
 18 files changed, 1964 insertions(+), 63 deletions(-)
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
