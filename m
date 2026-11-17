Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794883994;
	b=iuzir3XJTZN65RSQvAW2GakYVOsm55V/G9YUYGAZkmehbmLbPeHbYlhMeuU34Z7ngXKr
	 ReI87SP3H9hgroM6umTxEktIpgTv9i4OMwLkODCJU/cf0t+maV3/BA59q0Tovhl86974p
	 Gwjj9Lh/n2eugvuH6913lO+ALKwf0kkSHRwmbhlhK9icv1sX+5ssd/F/Yy3LS8vRepsO1
	 X113RaK83Ignrcno0v4Qe48WmmkpI2AxX9BQCyh48+YDPvifuD6fJxWq1YgYgsirxxlY6
	 eqi9KySQxqPUc0ADrILjI1IFCmGA24NaPTIXPYsMGv7KbRD45Y7NVpIhsoiOuQCRcWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794883994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kiKBg+K8L+Mja5+8e1SRuRcosBfEzE2Onqx/LDw7Opo=;
	b=bLByxuyTjhNlnZshk8HlAsg0CukdRAe9WNpBcVyWOvl+GC9RoHKGJUQOwbsts8c8Y/Dm
	 Tne295TMsL4N/VMtBYIlPQx5icm6XqhbBzSdffq5PzbCL/0FCoOQPsDwd0D52b1APmd+H
	 ZX+SzZtDpTZaivMHCbBCtj4IIQMeXx6sLvfBvQUQq22xYL7GpWBtBUZJu+PvNELMU4ejM
	 zkeDpbwPLAFVFfbmGtTMxinHVs8VOPrfnD1qFL09Sb2CG/JGvAVhwnq//2YMYpgWZZCIz
	 U8c1tS4JjfO0kFdeZ4lN5ag1tFegmOrO+YC1rqq6+BKEWCCaMumJTUda15pYw4WVP5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GamyDgeF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DE606A31C;
	Tue, 17 Nov 2026 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GamyDgeF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EF31F000C4;
	Tue, 17 Nov 2026 02:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794883993;
	bh=kiKBg+K8L+Mja5+8e1SRuRcosBfEzE2Onqx/LDw7Opo=;
	h=From:To:Cc:Subject:Date;
	b=GamyDgeFl2I2Pe1Ty7IqICWCPMhmIXAjfDBRFImSqgAAhsTGe+zOpDz71YDwGrp/7
	 yWbFzLtV9Ef+Oke1DgJ/H4r35QcSeh86+2iHXrFTyMz2J/3YQpEYeWZ1+BwwD7jqw1
	 cSlHtOu0whc7FwdE7JIejnHgxBA7vjwjTz+mAmgWrQeRNr0A2gfWFrGRP4/BKolutN
	 npLP8QM62BXePen6hEwm8Bv4ahOc88k4InjGGInhWIIbS+bfSyq7ZppldGPGKaNR0m
	 EFt2b3K4C9w6WrRU8EI8ZFDC5fYyJzmF0EVwwLbydmUIjhpMBij/2hOaTCl7ZtA7dv
	 fLq5JMQddnBQw==
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
Subject: [PATCH v5 0/12] perf coverage: A harness for perf, and the fixes it found
Date: Mon, 16 Nov 2026 23:52:52 -0300
Message-ID: <20261117025305.3958882-1-acme@kernel.org>
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

Nothing measured how much of perf the test suite reaches.  Patch 1 adds
tools/perf/scripts/coverage.sh: it builds perf with clang source based
coverage, runs the complete perf test suite and reports line and function
coverage for the whole tree, optionally against a baseline, with --table
and --html like pahole's coverage_table.py.  Also as 'make -C tools/perf
coverage', 'coverage-prep' and 'coverage-table'.

The useful output is the list of files with the most uncovered lines,
computed over the whole tree and not only the files the tests already
touch: that is where new tests should try to get more coverage.

The rest is what the first runs found, in the code, the build and the
tests:

  - The data type resolver missed 32-bit absolute addressing (patch 2);
    the DW_OP_addrx globals it also missed are fixed upstream by
    c3991e42f58a3650, so patch 3 only adds the test.  A struct pointer
    kept in a register at -O2 had no test (patch 6).
  - The flexible array member had no test; one showed the struct row at
    0.00% while the member said 100.00% (patches 4-5).
  - --insn-stat was printed before the loop that accounts the samples,
    so --code-with-type showed zeros (patch 7).
  - The libbfd probe printed a missing bfd.h error five times per
    build-test run (patch 8).
  - FEATURE-DUMP didn't record llvm-perf and rust, disabling both in the
    build-test builds (patch 9).
  - The Intel PT virtual LBR check lost every aux sample with a single
    data page (patch 10).
  - The dlfilter test kept samples whose IP the kernel now zeroes on a
    userspace-to-kernel skid (patch 11).
  - The LBR inline unwinding check failed instead of reporting Skip when the
    AMD PMU rejects branch sampling (patch 12).

In a root run on this box (coverage-prep as the developer, the tests
as root; the machine has no Intel PT, so the PT tests skip) the suite
covered 50.67% of perf's 205,810 lines (v4: 51.12% of 205,007).  The
only failure is the POLL_HUP tracepoint regression, in code this series
does not change.

The harness and the tests were developed with an AI coding assistant
(OpenCode), which drafted the script and the tests and helped debug the
failures; I reviewed every change and reproduced each failure before
fixing it.

What changed from v4:

  - Rebased onto perf-tools-next b7ff10b9 (52 commits).
  - Patch 3: the DW_OP_addrx fix is upstream as c3991e42f58a3650 ("perf
    dwarf-aux: Support DW_OP_addrx locations for global variables"), by
    James Clark, so the patch is now test-only.
  - Patch 12: also match "doesn't support branch stack sampling", how
    evsel__open_strerror() formats EOPNOTSUPP, so the test skips on AMD
    BRS (sashiko-bot).
  - Ian Rogers' Reviewed-by on v3 is carried on patches 4-6, 8 and 10-11;
    patches 1, 3 and 12 changed after that review and need a new look.

What changed from v3:

  - Patch 1: a .profraw left half written used to make llvm-profdata drop
    the whole merge, and with it the run's measurement; the bad files are
    now skipped and counted (found running the harness on the arm64 boards).
  - Patch 2: only set mem_ref for bare number operands when the offset is
    non-zero, and guard find_data_type against reg1 == -1 (sashiko-bot).
  - Patch 3: move DW_OP_addrx fallback to dwarf-aux.h so annotate-data.c
    builds with older elfutils, and fix typo in Fixes SHA (sashiko-bot).
  - Patch 12: only "Invalid argument"/"not supported" skips (exit 2);
    stderr goes to a file, any other record failure prints it and fails.
  - Ian Rogers' Reviewed-by on v3 is carried on patches 4-6, 8 and
    10-11; patches 1 and 12 changed after that review and need a new look.

What changed from v2:

  - Patch 2 is new: absolute addressing is resolved, so the new data type
    tests pass on 32-bit non-PIE builds and skip on 32-bit PIE.
  - Patches 3, 4 and 6: the C programs became 'perf test -w' workloads
    (global_data, flex_array, regptr), the shell tests no longer compile
    anything (Ian Rogers).
  - Patch 6: regptr uses long long members, so the offsets are the same
    on ILP32 and LP64.
  - Patch 5: add the missing annotated_member__extent() stub, so a
    build with slang but without libdw works (sashiko-bot); it is now
    a method of struct annotated_member.

What changed from v1:

  - Patch 9 (cs-etm) is gone: Leo Yan's series replaces it.
  - Patch 1: O= is accepted by all targets, the Python extension is in
    the report, -f is normalized and the delta matches its baseline.
  - Patch 5: the TUI browser counts flexible array accesses too.
  - Patch 7: the stats test skips without libdw.
  - Patches 10 and 12: Fixes tags corrected.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (12):
  perf scripts: Add a coverage harness for perf
  perf annotate: Handle absolute addressing in data type profiling
  perf tests: Exercise DW_OP_addrx global variables
  perf tests: Exercise the flexible array member path
  perf annotate-data: Count flexible array accesses for the whole struct
  perf tests: Exercise data type resolution from a register
  perf annotate: Print the stats after the annotations
  perf tests: Silence the libbfd probe in build-test
  perf build: Record the display-only features in FEATURE-DUMP
  perf tests: Fix the Intel PT virtual LBR check
  perf test: Drop samples without an IP in the dlfilter test
  perf test: Skip the LBR inline unwinding check when unsupported

 tools/perf/.gitignore                         |   1 +
 tools/perf/Makefile                           |  11 +-
 tools/perf/Makefile.config                    |   4 +
 tools/perf/Makefile.perf                      |   4 +
 tools/perf/builtin-annotate.c                 |  10 +-
 tools/perf/scripts/coverage.sh                | 738 ++++++++++++++++++
 tools/perf/tests/builtin-test.c               |   3 +
 tools/perf/tests/make                         |   2 +-
 tools/perf/tests/shell/addr2line_inlines.sh   |  24 +-
 tools/perf/tests/shell/annotate_stats.sh      |  64 ++
 .../perf/tests/shell/data_type_flex_array.sh  | 108 +++
 tools/perf/tests/shell/data_type_global.sh    |  70 ++
 tools/perf/tests/shell/data_type_register.sh  |  64 ++
 tools/perf/tests/shell/script_dlfilter.sh     |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   9 +-
 tools/perf/tests/tests.h                      |   3 +
 tools/perf/tests/workloads/Build              |   6 +
 tools/perf/tests/workloads/flex_array.c       |  54 ++
 tools/perf/tests/workloads/global_data.c      |  55 ++
 tools/perf/tests/workloads/regptr.c           |  60 ++
 tools/perf/ui/browsers/annotate-data.c        |   7 +-
 tools/perf/util/annotate-arch/annotate-x86.c  |  45 +-
 tools/perf/util/annotate-data.c               |  24 +-
 tools/perf/util/annotate-data.h               |   8 +
 tools/perf/util/annotate.c                    |  23 +-
 tools/perf/util/annotate.h                    |   6 +
 26 files changed, 1381 insertions(+), 24 deletions(-)
 create mode 100755 tools/perf/scripts/coverage.sh
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh
 create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
 create mode 100755 tools/perf/tests/shell/data_type_global.sh
 create mode 100755 tools/perf/tests/shell/data_type_register.sh
 create mode 100644 tools/perf/tests/workloads/flex_array.c
 create mode 100644 tools/perf/tests/workloads/global_data.c
 create mode 100644 tools/perf/tests/workloads/regptr.c

base-commit: b7ff10b9ddec8da75304c40fe4abf1ee4f9f0a43
v1-head: 3f5465bea8f5a97a
v2-head: 9706c488afffeb6d
v3-head: f2daf1586528671a
v4-head: b9e240a1b80ecd2a
v5-head: a21454e3d055c93b
-- 
2.56.0
