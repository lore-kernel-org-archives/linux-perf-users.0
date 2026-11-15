Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706868;
	b=zIzw7yQd+cn60rCR7/CzmrsmZqcOeHgqL0UUeCmrJSJ5PJRMY4bC3qrJuFtHOtuEdzAQ
	 XOEYdkcWDUEqwgtJOMQQh0pNg1qZNGswpZUYK8sZIn/WezR+xiEAWg8AqX5Hg37yZjv46
	 EP9RR/tgq8loF7z2J8KliRAm8BAk00wT8il0ZgkylCffrrT4fkZool2yQQqtnlmRUAF7z
	 cDmeyWexq7IJZb2nWMCu2yUx9KIO+bzY6GCy2K2dnL7Ml73nXa0pj4gRtPkFuo0IIBenS
	 nUjiUO097689TQkVqZF9OHEycF8HvDEtwi+V+GIMeAtvw16hqD5Q0ImjNlQtbh5mx5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706868;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/hy7qDQ+11+JAbMYqroO1C/ylKcjMHmYNkw/Y+qhCI4=;
	b=hz1syLsbALi1Swb9mF50H0t86PS7bClOg7DIhwz4F9gzy9SrOCf77sNxGa7ixfVtu2Lj
	 D5mBsMapAMj387qt1Dq4bZr0EEBzfyKhYkUsCHFetZZzjvsqux10eR/eLeMqm1P4F9MDU
	 6+xD6e+EBlaBxe7sGQWR8mpHUL43G1nKtDtF2cH11/x/JIAsd8zP7GUXdosRB47+G1Zh+
	 9mcWY/iAomjeUSr3X5PFRATFStJ0XD1OQQvfwHKQWbuBXVlFvY+ZJtd/GAiorVQSWIF/R
	 Wn+H1A6fbt/GLbBBz/J4FkxIFF0aGn8Z7tjmXsomqUNofUH2fgkR90BwbSbk1z14kJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HtQHX/bl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FB606A32C;
	Sun, 15 Nov 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtQHX/bl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439471F000C4;
	Sun, 15 Nov 2026 01:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706868;
	bh=/hy7qDQ+11+JAbMYqroO1C/ylKcjMHmYNkw/Y+qhCI4=;
	h=From:To:Cc:Subject:Date;
	b=HtQHX/blS0uw9mCm9YHUDetpGA8kWPasSyL2goU0qhcG2fjXusMxghDzjXktSyNhy
	 Tsvc8uGj1MpiI7DGl/9vxEMRxobRI6CMmqNey8m0qjLEgc0E3v/VfRV8djE8McKLPa
	 vymXbi69yX0NmWNb1e8152KxZQ/iZzMCsd0n1U9en36l08V1gImEhej9AVG6xfdhTg
	 tMXcq5dqaGXpo8dfL1eEEKNmAkKgB9U5NqCp+u9MF1FtNbaiYCqWjigIQ66HmakR/p
	 OqeqVWHbY3nO9Jwzv5CHDmgj009wbRxmFZkAFAam4VDRLxO5ZX940ifGQFXOj0gqxQ
	 ua6L3jWrpvpSA==
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
Subject: [PATCH v3 0/12] perf coverage: A harness for perf, and the fixes it found
Date: Sat, 14 Nov 2026 22:40:48 -0300
Message-ID: <20261115014102.2879372-1-acme@kernel.org>
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

Nothing measured how much of perf the test suite reaches.  Patch 1 adds
tools/perf/scripts/coverage.sh: it builds perf with clang source based
coverage, runs the complete perf test suite and reports line and function
coverage, optionally against a baseline, with --table and --html like
pahole's coverage_table.py.  Also as 'make -C tools/perf coverage',
'coverage-prep' and 'coverage-table'.

The rest is what the first runs found, in the code, the build and the
tests:

  - 32-bit x86 accesses globals with absolute addresses, which the data
    type resolver did not handle (patch 2).
  - clang DWARF 5 describes globals with DW_OP_addrx, which was not
    resolved (patch 3).
  - The flexible array member had no test; one showed the struct row at
    0.00% while the member said 100.00% (patches 4-5).
  - Resolving a struct pointer that -O2 keeps in a register from its
    DWARF location had no test (patch 6).
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
  - The LBR inline unwinding check failed instead of skipping when the
    AMD PMU rejects branch sampling (patch 12).

In a root run on this box the suite covered 51.12% of perf's 205,007
lines.  The only failure is the POLL_HUP tracepoint regression, in code
this series does not change.

The harness and the tests were developed with an AI coding assistant
(OpenCode), which drafted the script and the tests and helped debug the
failures; I reviewed every change and reproduced each failure before
fixing it.

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
  perf annotate-data: Resolve DW_OP_addrx global variables
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
 tools/perf/scripts/coverage.sh                | 722 ++++++++++++++++++
 tools/perf/tests/builtin-test.c               |   3 +
 tools/perf/tests/make                         |   2 +-
 tools/perf/tests/shell/addr2line_inlines.sh   |   9 +-
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
 tools/perf/util/annotate-arch/annotate-x86.c  |  41 +-
 tools/perf/util/annotate-data.c               |  24 +-
 tools/perf/util/annotate-data.h               |   8 +
 tools/perf/util/annotate.c                    |  20 +-
 tools/perf/util/annotate.h                    |   6 +
 tools/perf/util/dwarf-aux.c                   |  42 +-
 27 files changed, 1380 insertions(+), 29 deletions(-)
 create mode 100755 tools/perf/scripts/coverage.sh
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh
 create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
 create mode 100755 tools/perf/tests/shell/data_type_global.sh
 create mode 100755 tools/perf/tests/shell/data_type_register.sh
 create mode 100644 tools/perf/tests/workloads/flex_array.c
 create mode 100644 tools/perf/tests/workloads/global_data.c
 create mode 100644 tools/perf/tests/workloads/regptr.c

base-commit: cc905a18a647a8e3ad42cd1596baa0e08fba26eb
v1-head: 3f5465bea8f5a97a
v2-head: 9706c488afffeb6d
-- 
2.56.0

