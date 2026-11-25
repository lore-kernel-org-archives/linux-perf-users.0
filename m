Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634599;
	b=PmbtWshb8LEd+KjV5MoXXrLfACtbA0zTMnhRwwyoiJyA6dLVGMygu3Sb47Zd3bORl04P
	 VjRp+uHILIiwkxbGt9KMtz0B8efYxAItoaDSHLI5JsshBZ95pMl9H+RY77qMyt/DCuGzA
	 Wy6b5n6Ye0pSMZ3LQRpcTjLijV93YTS2pTsEXiYVwO/N88VFdp8n1xfXfl9yeAMu51ZQE
	 q2U/eeYuF7CU1r49PVG7a9jmq006tiaCN4KObvX4IPgJ/h2439hXYx14KQz7eRmPdrjHn
	 XTeO2XPMs7uuFm+QWGmr908wJfE4aG/lEB2266W4L0+tejf8v4I+h25SEt104VdCX4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OtjxZmt0Zy0PIDSLdBhMwC9phQp9LtO4XGhX+W3MCCQ=;
	b=z4uSj19xwus88bhT63XWEZMoY1uxewDFURRrZayQ+g24Z262iP0vDKXy2UxczrAudIqk
	 pnVAFnS2wMQV57a3G8Q/fbLmYcrCb5SH28KbFaF2cO60evAZzYxpYJiPQFmxLqhJa5uLZ
	 gwrIrxLjGEAcCnplxqTi0X5lpxKAajehWuPUyByByddxK0w+7TPyOPrw906kF1u3kYJ2S
	 Su5ddmiMzs56TaGEz/yjpUse+ijmWXGySPlZUcg+NfxD127VTR7Colg06iMFF/eyIAjTH
	 R5eOU76wEcKecLGfQl5i7/Xw+jeJPFChJQ5RI4CRZSH04TGSdF+Y46+1HwB5Rt8CBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOLg2GHb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53769606A31E;
	Wed, 25 Nov 2026 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOLg2GHb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194961F000D4;
	Wed, 25 Nov 2026 19:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634598;
	bh=OtjxZmt0Zy0PIDSLdBhMwC9phQp9LtO4XGhX+W3MCCQ=;
	h=From:To:Cc:Subject:Date;
	b=fOLg2GHbiVGoPVXapJ2p3x9B+AajE/eYF0nnLNcg59jYg15WsSu0wCeqQJ+OvR0kX
	 d6huHq5/Ql2aP3xdVlhaS3L3Caz4abdd3lJr7hqEzp9bZXxzc1gRTyAMPWeiObjVNW
	 0vSRTpCRuvzKH/KjeZAcC5Xbz4Ii5OM0dtEUg3E6+rOIbpn1rVJLNaisQsuhWenl49
	 R/CXSRRsdPy8hbrawCp4jvcO/Wt2JJb9wKCm3vOwTvAU/kaecEoTwxsFOZvAW/Lg25
	 O/nVqlMpu6tWWqss8k9eqz6QbDb48rhzn3OFDckTRhrqYdIWbbYJlbA5m7WnSQn6ki
	 MyCuCiFYk93JQ==
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
Subject: [PATCH v13 00/19] perf coverage: A harness for perf, and the fixes it found
Date: Wed, 25 Nov 2026 16:22:53 -0300
Message-ID: <20261125192312.34134-1-acme@kernel.org>
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
coverage probes, and proposed the fixes for the review findings.  This
round's edits were built and re-run with the annotate and data type
tests; the coverage table was regenerated from a test suite run.

What changed from v12:

  - 2, 5, 8: take a bare hex operand for an absolute address only in
    AT&T disassembly, where an immediate carries $; Intel syntax prints
    both bare (Namhyung).  The operand parser test now covers it.
  - 3, 12: print the stats before the annotations in stdio without
    --code-with-type, where they are final after the resort, and after
    them where they are still counted during the output (Namhyung).
  - 19: one executed/total count and one coverage bar per metric, lines
    and funcs in the same format (Namhyung).  Ship the script executable
    so the Make target and coverage.sh can run it; skip zero-line files
    in -f so they take the missing-data error path.

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
  perf annotate: Print the stats where the counters are final
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
 tools/perf/builtin-annotate.c                 |  68 ++-
 tools/perf/scripts/coverage-table.sh          | 339 ++++++++++++
 tools/perf/scripts/coverage.sh                | 494 ++++++++++++++++++
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/annotate-ops.c               | 184 +++++++
 tools/perf/tests/builtin-test.c               |   4 +
 tools/perf/tests/shell/addr2line_inlines.sh   |  19 +-
 tools/perf/tests/shell/annotate_stats.sh      | 186 +++++++
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
 tools/perf/util/annotate-arch/annotate-x86.c  |  58 +-
 tools/perf/util/annotate-data.c               |  27 +-
 tools/perf/util/annotate-data.h               |   8 +
 tools/perf/util/annotate.c                    |  31 +-
 tools/perf/util/annotate.h                    |  13 +-
 31 files changed, 1954 insertions(+), 57 deletions(-)
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

