Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471233;
	b=Xll4sruAPc8kiX3qlAL+ZW33hJoXoyljpzcTTgqCZ3Lhw7beUR3o1/THdtdJjtpM8QMM
	 RBIHE+L3lUGMCq2vfwJYFuDeWjO7cL2aL1tDobCRuTU0espmxsMBgR3TKLoGE7OhBGrJv
	 4O2eFJzsYg9jES7LZLPvz8LWgOsuiCS+Ch0xTdSznxu8MztCgnIM0wASHnJDuu7fBKFJa
	 mihBnfQLfvdCN+Erneewxdevjm0xWQklynWkIgkhFfwQJ2V4M7y2hbzkUSTcdQYj7gTVe
	 +fwXvVtnwgYEHXl5g6O6pLA6i9Q7xIKu40H4AJN004FgiCF4apoe85fGUhVJogOXyRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471233;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UtBCeTRE8uaXd72gsC5YkAITZqtqBV1//4SFj9o2EGE=;
	b=YVN8CBLlwe8OUh+xnTrQf8QKx4d42mkkzsZNhrdqhX6GRTl6q2YzH7JWGXmXR26kVID1
	 SkloCkWP8sZf4oWQCik/siFEtpAMFU0jEEaNC+154PP83QX6kGkc+fyM/rkIpYjnjMX5G
	 6yDk2Au7yOYTknu+gzZPHOuMUyfREczk66Fz4jPWFmgWiif1aLmbSQP62Hr1nPX6HXSKK
	 cAn9mXC4X6sXSGTosCgo4qSprUqsiMSr6BRYMWVTsQQpkwFm6BokhnQksyyuE3dPLjIkR
	 8XtEgoZg+JGSo2k+JWBEm9j3KO0dxlfQZ3sxO9j29y3uOTpsY5U6T1QZzER98ZCFuXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXfdoTlP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F8606A31E;
	Mon, 23 Nov 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXfdoTlP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2B41F000C0;
	Mon, 23 Nov 2026 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471233;
	bh=UtBCeTRE8uaXd72gsC5YkAITZqtqBV1//4SFj9o2EGE=;
	h=From:To:Cc:Subject:Date;
	b=aXfdoTlPqyEJXbgtZdMHHU9KCIKcjC3Q9sphmK/0CdxdQO56v/k0wxsxW0zqlqjJl
	 jlBdl831dlLWQEJurze8rQdIGHCo8PxPukXQt0L3OP4JxCG97GC6ILE5qT+NRJNFUi
	 Gwh6Rr5O9GjCJ+QcV3VGldG5jENYR/CcPkiMOlC37ufmptLr+Ftdn6mmnvghPK9TnY
	 /hoPglPKYfMRs3erW3j8NYGiv7x0aXmtjD7lcdkfigPzL2ZTE7O+AOZQ5tzp4sac0y
	 +1DO79ZzewxeqMm+5Czg5vG9yvRpw93V3+d0L26rstJfCUeNfDtS78b6zqhTo/wEA4
	 FDINYBY4B5AMA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v12 00/19] perf coverage: A harness for perf, and the fixes it found
Date: Mon, 23 Nov 2026 19:00:05 -0300
Message-ID: <20261123220024.14891-1-acme@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

Nothing measured how much of perf the test suite reaches.  Patches 18-19
add coverage.sh, which builds perf with clang source based coverage, runs
the full test suite and reports line and function coverage, and
coverage-table.sh, which renders the biggest uncovered gaps over the
whole tree, not only the files the tests already touch.

Patches 1-7 are the fixes the first runs found, 8-17 their tests and the
test fixes.  1 is a build fix for the GTK UI, which the coverage build
needs; 5 and 6 are parser changes, not regression fixes.

  - The GTK UI was not linked with EXTRA_CFLAGS, so the coverage build
    never saw its counters (1).

  - Absolute addressing was missing from the data type resolver (2);
    movabs was not parsed (6).

  - --insn-stat was printed before the samples were accounted (3).

  - FEATURE-DUMP did not record features checked outside FEATURE_TESTS
    (4).

  - The flexible array member row showed 0.00% while the member said
    100.00% (7).

  - Tests cover the x86 operand parser (8), DW_OP_addrx globals (9, test
    only: fixed upstream by c3991e42f58a3650), the flexible array path
    (10), a struct pointer kept in a register at -O2 (11) and annotate
    stats (12).

  - Intel PT virtual LBR, dlfilter zeroed IP and LBR inline unwinding
    test fixes (13-15).

The full root run used for this series, with clang DWARF 4 on this AMD
host, measured 112185 of 236044 lines (47.53%), 86374 of 174097 in
tools/perf/ (49.61%), 170 passed, 160 subtests, 27 skipped and one
failure (21.2, the known Tracepoint event kernel regression).  The total
includes libbpf and the dlfilters; the Rust workload is built and run but
is not instrumented.

That one failure makes the coverage target exit 1 after writing the
report and the baseline; the data above is from that completed run.

On aarch64 (Raspberry Pi 4, Cortex-A72, clang 19), the full suite as
root, run sequentially, measured 101119 of 232961 lines (43.41%), 75800
of 171070 in tools/perf/ (44.31%), 142 passed, 133 subtests, 47 skipped,
two timed out and one failed (130, the stat test; 17 now selects an
absent CPU instead of an online one).  The parallel test mode starts
every test at once and times out on the four cores, hence --sequential
and --timeout (18).

The harness, the tests and the review fixes were developed with an AI
coding assistant (OpenCode): it drafted the scripts and tests, ran the
coverage probes, and proposed the fixes for the review findings.  The
latest edits were built and checked with the annotate stats test, its
skip path and a coverage-prep run on toolbx.

What changed from v11:

  - 12: skip the archs without operand extraction, whose insn-stat
    totals are zero by design; compare the bad counters numerically.

  - 18: keep the built python extension so a second root run passes
    the python tests, purging only its setuptools object cache.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (19):
  perf build: Link the GTK UI with EXTRA_CFLAGS
  perf annotate: Handle absolute addressing in data type profiling
  perf annotate: Print the stats after the annotations
  perf build: Record the features checked outside FEATURE_TESTS
  perf annotate-x86: Record immediates in a 64-bit field
  perf annotate-x86: Parse movabs like a mov
  perf annotate-data: Count flexible array accesses for the whole struct
  perf test: Exercise the x86 operand parser
  perf test: Exercise DW_OP_addrx global variables
  perf test: Exercise the flexible array member path
  perf test: Exercise data type resolution from a register
  perf test: Exercise the annotate stats output
  perf test: Fix the Intel PT virtual LBR check
  perf test: Drop samples without an IP in the dlfilter test
  perf test: Skip the LBR inline unwinding check when unsupported
  perf test: Skip the trace summary BPF tests without kernel BTF
  perf test: Avoid online CPUs in the offline stat test
  perf scripts: Add a coverage harness for perf
  perf scripts: Add a coverage table

 tools/perf/.gitignore                         |   1 +
 tools/perf/Documentation/perf-annotate.txt    |   2 +-
 tools/perf/Makefile                           |  15 +-
 tools/perf/Makefile.config                    |   8 +
 tools/perf/Makefile.perf                      |  12 +-
 tools/perf/builtin-annotate.c                 |  20 +-
 tools/perf/scripts/coverage-table.sh          | 337 ++++++++++++
 tools/perf/scripts/coverage.sh                | 494 ++++++++++++++++++
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/annotate-ops.c               | 172 ++++++
 tools/perf/tests/builtin-test.c               |   4 +
 tools/perf/tests/shell/addr2line_inlines.sh   |  19 +-
 tools/perf/tests/shell/annotate_stats.sh      | 184 +++++++
 .../perf/tests/shell/data_type_flex_array.sh  | 135 +++++
 tools/perf/tests/shell/data_type_global.sh    |  73 +++
 tools/perf/tests/shell/data_type_register.sh  |  86 +++
 tools/perf/tests/shell/script_dlfilter.sh     |   2 +-
 tools/perf/tests/shell/stat.sh                |  21 +-
 tools/perf/tests/shell/test_intel_pt.sh       |  10 +-
 tools/perf/tests/shell/trace_summary.sh       |   9 +
 tools/perf/tests/tests.h                      |   4 +
 tools/perf/tests/workloads/Build              |   6 +
 tools/perf/tests/workloads/flex_array.c       |  71 +++
 tools/perf/tests/workloads/global_data.c      |  57 ++
 tools/perf/tests/workloads/regptr.c           |  60 +++
 tools/perf/ui/browsers/annotate-data.c        |   7 +-
 tools/perf/util/annotate-arch/annotate-x86.c  |  51 +-
 tools/perf/util/annotate-data.c               |  27 +-
 tools/perf/util/annotate-data.h               |   8 +
 tools/perf/util/annotate.c                    |  31 +-
 tools/perf/util/annotate.h                    |  13 +-
 31 files changed, 1894 insertions(+), 46 deletions(-)
 create mode 100755 tools/perf/scripts/coverage-table.sh
 create mode 100755 tools/perf/scripts/coverage.sh
 create mode 100644 tools/perf/tests/annotate-ops.c
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh
 create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
 create mode 100755 tools/perf/tests/shell/data_type_global.sh
 create mode 100755 tools/perf/tests/shell/data_type_register.sh
 create mode 100644 tools/perf/tests/workloads/flex_array.c
 create mode 100644 tools/perf/tests/workloads/global_data.c
 create mode 100644 tools/perf/tests/workloads/regptr.c

-- 
2.56.0

