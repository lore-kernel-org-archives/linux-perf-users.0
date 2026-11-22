Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383634;
	b=vcB9FFAl+oX78raPhLf3AmF3l6bW2lbtb0WLFmnW1buQH+zbNNV1fXHlCK9cQnjhzG3S
	 zUUrwx+4CA4igNLfGe5ZLAF3PtEBckq/sL3ng50Qp9k/F3RzRtICrcLVTdtcBDfRbowKF
	 kEH7cCnAJi/1is222VvZ1KtPPk32D0EgvjSQFERs8LxMzS4tWIGv411uDFP9pVJRzpAa1
	 Ms6aMii0rryPBHqyy/TbdCRAZ764dUyRnUaxcCwTlTqeTIB/5o+rDUURVmba2JvqrPinh
	 j3t7yiS/8w+MJKRUg2OXNme+wH+mPOr2DkIfblzrlOswfafmXKCsnXCCfF0d8ClhsUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=lQrOZ8WPZFOgczjW/yoz1Tftzms0DQJCnOt+PGo8RC8=;
	b=XWrjgS7Ovu4PMbzYU/kYIzON0epUnTOcJlB+QRU6jx1t1vY5K/RYGBQLQJiBgKq8AmwP
	 Kpg2uDrDc865zYohwzV60i+KGBfOvSwnhH43/2qhISjk9/oARjpgkiGgEf7hGWASSD6+D
	 z52GOXONm8VTko9vwiS/+NnJfDuwIigODLqZpAzLBEmmE2pjC+Bshe7YFdBucAhsZ73sg
	 0A3z3ItAiHMIxJmDNwsQn1UYJguOpQfedgPCk/cKsc+D7CAUbiosrYLY3GpsHvttxnPfd
	 /bfdbM1Y+RrmQmJF+pM0WI9IcklfStVdBZX2E1HXFf8eMjzKLLkuXD71c1aDvyIbyQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kw9VdFA7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E0606A31E;
	Sun, 22 Nov 2026 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kw9VdFA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A8A1F000CA;
	Sun, 22 Nov 2026 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383634;
	bh=lQrOZ8WPZFOgczjW/yoz1Tftzms0DQJCnOt+PGo8RC8=;
	h=From:To:Cc:Subject:Date;
	b=Kw9VdFA7z5Z5RS/j8NouVRY5fXO7OJWRaLObSRtAf7tiVQFSBAWpuzZP2hODAhgmr
	 3tMkyB1K/DX7X79Q2hTWPjOfemAUItX1v9qZ4j6F1CsWj+ed+OFMAnC0zgx04FwKEH
	 MH2jTZhyU14aVAtl+xoCh+87Yfh47KWGB0+eNPXQ6E8osaU2xFW23uTXow/Wf9quHf
	 mFS9GZk5/k8Vq1YAHV+FiOqRibR2iUf7cBe249J6HPdMQx6KVQ8YMMrYGV61+QncKL
	 BIbOJQlXYfKckgzbF4Zk9vYamB/oy6DQga4+ccKmnlEDmEtRJUv+STkuINgs42DvAs
	 Br5mYSqOz4Miw==
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
Subject: [PATCH v11 00/19] perf coverage: A harness for perf, and the fixes it found
Date: Sun, 22 Nov 2026 18:40:06 -0300
Message-ID: <20261122214025.16769-1-acme@kernel.org>
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
latest edits were built and checked with the operand test and test-list
matching on toolbx.

What changed from v10:

  - 2: recognize absolute addressing in both 32- and 64-bit objects,
    while keeping the %gs:40 stack canary handling.

  - 4: record late feature probes independently of FEATURE_DISPLAY.

  - 5, 6: parse movabs and record x86 immediates in a 64-bit field, so
    GNU and LLVM spellings of the KASAN shadow offset track the same
    value.

  - 7: count flexible-array accesses at the struct boundary, including
    tail padding.

  - 8: exercise both absolute-address conversions and reject invalid
    operands; drop the call case the data type resolver does not follow.

  - 10: test a flexible array after struct tail padding in all output modes.

  - 11: restrict the annotation to touch and verify the register path is
    not resolved by instruction tracking.

  - 12: run instruction statistics without requiring memory events and
    check the totals against the rows.

  - 15: skip the LBR test only on the unsupported branch-stack error.

  - 16: skip trace-summary BPF tests unless the running kernel exposes BTF.

  - 17: avoid online CPUs in the offline stat test, while retaining
    the check for an absent CPU.

  - 18: preserve inherited CXXFLAGS, build with clang, rebuild dlfilters,
    trim -t fragments, and support sequential and timed runs.

  - 19: keep the coverage-table filtering and end-of-run table output
    checks, including decimal --min-lines values.

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
 tools/perf/scripts/coverage.sh                | 493 ++++++++++++++++++
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/annotate-ops.c               | 172 ++++++
 tools/perf/tests/builtin-test.c               |   4 +
 tools/perf/tests/shell/addr2line_inlines.sh   |  19 +-
 tools/perf/tests/shell/annotate_stats.sh      | 172 ++++++
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
 31 files changed, 1881 insertions(+), 46 deletions(-)
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
2.56.1

