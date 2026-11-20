Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138346;
	b=oZhI/ofKG7dl0kaZUAm667kCjDwKsT15ToHNU5IDSGBlVvQi4kUg6PRmMhp+XVAv7LQV
	 7zwEjDvzSHaQAB+WseMatCFIlIZufX9+mQhWkotVaFSkIOYGSxvgyfQl2GeqE/p1EtgtR
	 ixB7sqoFsFvO0OfQUccJBuby/8MSansHKnMvCKLYsbwS3pmYPZ73Zma5E7wFvGqoAUG6Z
	 7GzM1olNWS7QQM1EMFqJaGXgeYI/qFYTYZoCrhMUYRnmmHxmdeqIAOb/Ytnxec8YiVkVq
	 cqn1l5+/s9Eoz1xCfhUdAvVNIXTi6KbUFSY6bOQhsgORX9Cw8BAaumbWvA7h9vb+4iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138346;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vUkgQCtAcZss/N9u5kP8H29r03cTuvMwF1G7ko9NlH0=;
	b=0+caWdd66AaupYzf+p5bWgG2bvjzB/WCasSdM6g5RwRDTApfXRyQWVBNegubObBCU6aL
	 EKgnTnkXw0Rsu4V75v+las7/HLBPN01X+lWg/rM8dE/U4wFq0pYOZGDrLZTG95yAXHq6c
	 tO+SR6T/534tgv+7jKam6Aa0wB0QnFUoXWXvOAboH7797ztr3J8BGDNCxtFljaKAZ8m36
	 FzqE4wy2ABFtrWogqgMFbhMXjjC6MIoDIPfU4Fvy32BOJWCfFtJZyECv9UepqEAXR1J/s
	 pgfscO8anJzcfBbvcvA8K0popTJ0jzNndttBly9eOO+KufUt4eie/W6Vsn4bk9ttxBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vyg9ccff;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8C606A320;
	Fri, 20 Nov 2026 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vyg9ccff
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6D71F000C4;
	Fri, 20 Nov 2026 01:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138345;
	bh=vUkgQCtAcZss/N9u5kP8H29r03cTuvMwF1G7ko9NlH0=;
	h=From:To:Cc:Subject:Date;
	b=Vyg9ccffwZisTxcJ1h3tpjaHFucwjm829+NgR70puGNDLdZTNg5SYbb5AXWk3KWi5
	 BoljjAV9wOx4l+2t9mY3PdKt6QU/AhWvxsGam+wUcAYfp0YIcRMYTxhX/KXQF6/iS3
	 tq7sVFLXyG3dt1/3nw1hVezF8HnCVdv2nSo9PO042sEOhVwA3+O+f+ahEJ/sbZshvx
	 /VigzoiDqemZ7uPddkGCk5vN/c8XBNt5S3nLVSJsU+pmw7/lp3dmJwbplUSaUIJNMF
	 1IMaYa3qkdDgQwU9K07NDHj7hJ9Z2oZvS1rHnknH0nE4R6nvSA+yy9S+Rc+KujbFPR
	 Jc+rUgkJnKyfA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 00/13] perf coverage: A harness for perf, and the fixes it found
Date: Thu, 19 Nov 2026 22:31:55 -0300
Message-ID: <20261120013211.1510-1-acme@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

Nothing measured how much of perf the test suite reaches.  Patch 1 links
the GTK UI with EXTRA_CFLAGS, without which the coverage build never saw
the UI's counters (the jvmti agent got the same fix upstream); patch 2
adds tools/perf/scripts/coverage.sh: it builds perf with clang source
based coverage, runs the complete perf test suite and reports line and
function coverage, optionally against a baseline.  Also as 'make -C
tools/perf coverage', 'coverage-prep' and 'coverage-table'.

The useful output is the list of files with the most uncovered lines,
computed over the whole tree and not only the files the tests already
touch: that is where new tests should try to get more coverage.  Namhyung
asked what the table is, so this is what coverage-table shows by default:

make -C tools/perf coverage-table
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
tools/perf (no tests/ or bench/), 100+ executable lines:
the 20 biggest uncovered gaps, start here when adding coverage tests.
--all for every file: make -C tools/perf coverage-table COVERAGE_ARGS="--all"

┌──────────────────────────────────────────┬────────┬────────┬────────┬─────────────────────────────┬─────────────┬──────────┐
│ File                                     │  Lines │    Hit │   Miss │        Line Coverage        │       Funcs │  FuncCov │
├──────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
│ ui/browsers/hists.c                      │   2730 │      0 │   2730 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/124   │    0.00% │
│ builtin-sched.c                          │   3737 │   1542 │   2195 │ ████████░░░░░░░░░░░░  41.3% │    62/141   │   43.97% │
│ builtin-script.c                         │   3212 │   1118 │   2094 │ ██████░░░░░░░░░░░░░░  34.8% │    51/124   │   41.13% │
│ util/intel-pt-decoder/intel-pt-decoder.c │   3208 │   1201 │   2007 │ ███████░░░░░░░░░░░░░  37.4% │    70/119   │   58.82% │
│ util/intel-pt.c                          │   3237 │   1426 │   1811 │ ████████░░░░░░░░░░░░  44.0% │    79/142   │   55.63% │
│ util/python.c                            │   2984 │   1301 │   1683 │ ████████░░░░░░░░░░░░  43.6% │   128/224   │   57.14% │
│ util/sort.c                              │   2421 │    861 │   1560 │ ███████░░░░░░░░░░░░░  35.6% │    83/246   │   33.74% │
│ util/session.c                           │   2686 │   1204 │   1482 │ ████████░░░░░░░░░░░░  44.8% │    65/125   │   52.00% │
│ util/annotate.c                          │   2245 │    866 │   1379 │ ███████░░░░░░░░░░░░░  38.6% │    60/118   │   50.85% │
│ builtin-kmem.c                           │   1337 │      0 │   1337 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/70    │    0.00% │
│ util/arm-spe.c                           │   1330 │      0 │   1330 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/50    │    0.00% │
│ builtin-kvm.c                            │   1316 │      0 │   1316 │ ░░░░░░░░░░░░░░░░░░░░   0.0% │     0/90    │    0.00% │
│ util/header.c                            │   3941 │   2662 │   1279 │ █████████████░░░░░░░  67.6% │   159/180   │   88.33% │
│ util/evsel.c                             │   3326 │   2067 │   1259 │ ████████████░░░░░░░░  62.2% │   128/155   │   82.58% │
│ builtin-record.c                         │   2737 │   1501 │   1236 │ ██████████░░░░░░░░░░  54.8% │    84/120   │   70.00% │
│ util/probe-event.c                       │   2765 │   1554 │   1211 │ ███████████░░░░░░░░░  56.2% │    81/103   │   78.64% │
│ builtin-trace.c                          │   3657 │   2451 │   1206 │ █████████████░░░░░░░  67.0% │   154/198   │   77.78% │
│ builtin-inject.c                         │   2023 │    890 │   1133 │ ████████░░░░░░░░░░░░  44.0% │    37/94    │   39.36% │
│ builtin-c2c.c                            │   2027 │   1018 │   1009 │ ██████████░░░░░░░░░░  50.2% │    58/156   │   37.18% │
│ util/auxtrace.c                          │   2013 │   1009 │   1004 │ ██████████░░░░░░░░░░  50.1% │    81/126   │   64.29% │
├──────────────────────────────────────────┼────────┼────────┼────────┼─────────────────────────────┼─────────────┼──────────┤
│ TOTAL (perf)                             │ 173244 │  91059 │  82185 │ ██████████░░░░░░░░░░  52.6% │  5868/9306  │   63.06% │
└──────────────────────────────────────────┴────────┴────────┴────────┴─────────────────────────────┴─────────────┴──────────┘
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

--all lists every tools/perf file, tests and benches included, most
covered first.  The table total is the tools/perf subtotal; the run
summary has the whole report.

The rest is what the first runs found, in the code, the build and the
tests:

  - The data type resolver missed absolute addressing, in 32-bit code
    and in the 64-bit kernel's sign extended disp32 (patch 3); the
    DW_OP_addrx globals it also missed are fixed upstream by
    c3991e42f58a3650, so patch 4 only adds the test.  A struct pointer
    kept in a register at -O2 had no test (patch 7).
  - The flexible array member had no test; one showed the struct row at
    0.00% while the member said 100.00% (patches 5-6).
  - --insn-stat was printed before the loop that accounts the samples,
    so --code-with-type showed zeros (patch 8).
  - The libbfd probe printed a missing bfd.h error five times per
    build-test run (patch 9).
  - FEATURE-DUMP didn't record the features checked outside
    FEATURE_TESTS (llvm-perf, rust, jvmti), disabling them in the
    build-test builds (patch 10).
  - The Intel PT virtual LBR check lost every aux sample with a single
    data page (patch 11).
  - The dlfilter test kept samples whose IP the kernel now zeroes on a
    userspace-to-kernel skid (patch 12).
  - The LBR inline unwinding check failed instead of reporting Skip when
    the AMD PMU rejects branch sampling (patch 13).

With coverage-prep by the developer (clang DWARF 5) and the full suite
as root on this AMD host, 105,466 of 205,823 lines were covered (51.24%;
v5: 50.67% of 205,810), 86,344 of 173,257 in tools/perf/ (49.84%).  168
tests passed, 28 skipped and one failed (20.2, the POLL_HUP regression,
outside this series).  The global variable and instruction-stats tests
passed; the Intel PT hardware tests skipped here, so patch 11's 64-page
AUX buffer was only tested on the Intel host below.

The same tree as root on an Intel hybrid host (i7-14700K, Fedora 45)
covered 110,258 of 205,830 lines (53.57%), 91,059 of 173,244 in
tools/perf/ (52.56%).  166 tests passed, 27 skipped and three failed:
20.2, and 143 (branch stacks) and 212 (vfs_getname), which passed on
rerun.  The Intel PT tests ran and passed there, exercising patch 11's
64-page AUX buffer.

The AMD numbers are from the v6 set; the later versions change the
build, the tests' diagnostics, the harness and, in patch 3, the operand
parser, so read them as indicative.

The harness and the tests were developed with an AI coding assistant
(OpenCode), which drafted the script and the tests and helped debug the
failures; an independent local model reviewed the script and I verified
its findings before folding them in.  I reviewed every change and
reproduced each failure before fixing it.

What changed from v8:

  - 1 is GTK only: the jvmti link change went upstream as
    321eae8603c76a6e, and the series is rebased onto it.
  - 2 checks the path before creating anything and each level before
    using it, so the EXIT trap cannot chown a child of another user's
    directory (sashiko-bot).
  - 3 answers the 32-bit, TYPE and mem-ref questions with the kernel's
    sign extended disp32 and a resolving absolute load (Namhyung).
  - 3 restores the jump/loop* and movabs filters lost in v7 and adds the
    operand parser test.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (13):
  perf build: Link the GTK UI with EXTRA_CFLAGS
  perf scripts: Add a coverage harness for perf
  perf annotate: Handle absolute addressing in data type profiling
  perf tests: Exercise DW_OP_addrx global variables
  perf tests: Exercise the flexible array member path
  perf annotate-data: Count flexible array accesses for the whole struct
  perf tests: Exercise data type resolution from a register
  perf annotate: Print the stats after the annotations
  perf tests: Silence the libbfd probe in build-test
  perf build: Record the features checked outside FEATURE_TESTS
  perf tests: Fix the Intel PT virtual LBR check
  perf test: Drop samples without an IP in the dlfilter test
  perf test: Skip the LBR inline unwinding check when unsupported

 tools/perf/.gitignore                         |    1 +
 tools/perf/Documentation/perf-annotate.txt    |    2 +-
 tools/perf/Makefile                           |   11 +-
 tools/perf/Makefile.config                    |    7 +
 tools/perf/Makefile.perf                      |    6 +-
 tools/perf/builtin-annotate.c                 |   19 +-
 tools/perf/scripts/coverage.sh                | 1153 +++++++++++++++++
 tools/perf/tests/Build                        |    1 +
 tools/perf/tests/annotate-ops.c               |   93 ++
 tools/perf/tests/builtin-test.c               |    4 +
 tools/perf/tests/make                         |    2 +-
 tools/perf/tests/shell/addr2line_inlines.sh   |   20 +-
 tools/perf/tests/shell/annotate_stats.sh      |   69 +
 .../perf/tests/shell/data_type_flex_array.sh  |  111 ++
 tools/perf/tests/shell/data_type_global.sh    |   73 ++
 tools/perf/tests/shell/data_type_register.sh  |   63 +
 tools/perf/tests/shell/script_dlfilter.sh     |    2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   10 +-
 tools/perf/tests/tests.h                      |    4 +
 tools/perf/tests/workloads/Build              |    6 +
 tools/perf/tests/workloads/flex_array.c       |   55 +
 tools/perf/tests/workloads/global_data.c      |   57 +
 tools/perf/tests/workloads/regptr.c           |   60 +
 tools/perf/ui/browsers/annotate-data.c        |    7 +-
 tools/perf/util/annotate-arch/annotate-x86.c  |   48 +-
 tools/perf/util/annotate-data.c               |   25 +-
 tools/perf/util/annotate-data.h               |    8 +
 tools/perf/util/annotate.c                    |   27 +-
 tools/perf/util/annotate.h                    |    7 +
 29 files changed, 1922 insertions(+), 29 deletions(-)
 create mode 100755 tools/perf/scripts/coverage.sh
 create mode 100644 tools/perf/tests/annotate-ops.c
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh
 create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
 create mode 100755 tools/perf/tests/shell/data_type_global.sh
 create mode 100755 tools/perf/tests/shell/data_type_register.sh
 create mode 100644 tools/perf/tests/workloads/flex_array.c
 create mode 100644 tools/perf/tests/workloads/global_data.c
 create mode 100644 tools/perf/tests/workloads/regptr.c

base-commit: 321eae8603c76a6e
v1-head: 3f5465bea8f5a97a
v2-head: 9706c488afffeb6d
v3-head: f2daf1586528671a
v4-head: b9e240a1b80ecd2a
v5-head: a21454e3d055c93b
v6-head: e1315408a335617d
v7-head: 7f8dc594d77ed495
v8-head: 67fde34aeab98a91
v9-head: b1765115908ede31

-- 
2.56.1

