Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582363;
	b=3nCqkp0geaSpySWsqnhMC5He082IINbOnAxLPAmGswUwaP/63pcx4Ons5/sfY5sPcegg
	 kW+IyyaX8SdfYX8LjMTdQcxOzkNwcd1/DUagz5OG/5gUMR/Q9RtPBdhPnFw/lg7YENYYg
	 bXS52lZV0c2O8vuW20aweA/H4IDpatW8raf7dEAlO0IvC3BNBcTkQgNq5U+PbRUNTFfS9
	 2Sh60ckQdH+BvQR8tH/HZ9YTIB/HSmL92laXiqhWUxpzkry9vdSXxXc+Btnf6janZ1VS0
	 Bb/TiL0dsUCyoFyh/K00g+wT98AKR+s27QY95Xew6+HOMFQlgp2046frd7MvV5RpdBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582363;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k7PKQaxI91YAqqrMtfdpgHceCDdV/OGsK25WhBvf6ro=;
	b=czi87fAqVzL4hLHQ8ACaY6BA4+CZYxeF+poFa9o2DlRXgDZk0xNHRUl/hvb3aaZ2VK0D
	 n4+petJ7DnLxHhzSKxjy2CfFGSt5khNyYnIOk2kog5VX6hTOj95ZFD6FJFW25DfVWAb4E
	 aFFQTY1iIV/WzD0Ayzo6W4CSNn0nMsaJgZBeCTfKl+kpBFkWiRPa0RoOABRHU1iSGHHcQ
	 Yst8F5tq01HMWPt2nctl4/e08PxdcmaAlkvMueo61vcKdyqtmclfK+FUzOq6O+Grb5PTm
	 FVCJdq4z0da8I9yZaDBCCeqywT5A37BlQA3xwmC3XIJzJ7vZz+i/HeSS55/ED9mPnwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zq7le28u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76E606A32E;
	Fri, 13 Nov 2026 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zq7le28u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760A91F000C6;
	Fri, 13 Nov 2026 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582362;
	bh=k7PKQaxI91YAqqrMtfdpgHceCDdV/OGsK25WhBvf6ro=;
	h=From:To:Cc:Subject:Date;
	b=Zq7le28uQhTKHNJbPo7nt2Q8EOWeAACM9QjTcaggrVXcNgWJw6OVEYLyR2mm4JrN2
	 PPV7DGp+4U2USiNlM6nTxjluZTvqfJCxC18KUYieg/27lD0aaKi7mrraiNGYP4iuNH
	 ELxyh2052M0ypMYsVrD6IE8CICx6H7LE1nXe91Kd1LbCXWRk9J8h2IIwZXcqwKQ0nM
	 1egBDx6vEKu+uY6AamyRYp8afuRPESnKPGyuhgKn3rwPzxYPVm+E50CVkFMF2AGLEy
	 iFSKa7dJGWkFl9a5EsA1QOBaNFSOQpHZAlTR+V8+FvC5lVHty7iWAdOtyYl4j5pUDq
	 J7WIzjWJWScKw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Leo Yan <leo.yan@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Robert Walker <robert.walker@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/12] perf coverage: A harness for perf, and the fixes it found
Date: Fri, 13 Nov 2026 12:05:41 -0300
Message-ID: <20261113150555.1163049-1-acme@kernel.org>
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

	Please consider merging,

Nothing measured how much of perf the test suite reaches.  Patch 1 adds
tools/perf/scripts/coverage.sh: it builds perf with clang source based
coverage, runs the complete perf test suite and reports line and function
coverage, optionally against a baseline, with --table and --html like
pahole's coverage_table.py.  Also as 'make -C tools/perf coverage',
'coverage-prep' and 'coverage-table'.

The rest is what the first runs found, in the code, the build and the
tests:

  - clang DWARF 5 describes globals with DW_OP_addrx, which was not
    resolved (patch 2).
  - The flexible array member had no test; one showed the struct row at
    0.00% while the member said 100.00% (patches 3-4).
  - A struct pointer that -O2 keeps in a register was not resolved from
    its DWARF location (patch 5).
  - --insn-stat was printed before the loop that accounts the samples,
    so --code-with-type showed zeros (patch 6).
  - The libbfd probe printed a missing bfd.h error five times per
    build-test run (patch 7).
  - FEATURE-DUMP didn't record llvm-perf and rust, disabling both in the
    build-test builds (patch 8).
  - GCC 16 caught an uninitialized T32 instruction buffer read in cs-etm
    (patch 9).
  - The Intel PT virtual LBR check lost every aux sample with a single
    data page (patch 10).
  - The dlfilter test kept samples whose IP the kernel now zeroes on a
    userspace-to-kernel skid (patch 11).
  - The LBR inline unwinding check failed instead of skipping when the
    AMD PMU rejects branch sampling (patch 12).

In a root run on this box the suite covered 49.16% of perf's 201,180
lines; three tests failed in code this series does not change (the
POLL_HUP tracepoint regression, the AMD BRS branch sampling rejection
and the lock contention count).

The harness and the tests were developed with an AI coding assistant
(OpenCode), which drafted the script and the tests and helped debug the
failures; I reviewed every change and reproduced each failure before
fixing it.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (12):
  perf scripts: Add a coverage harness for perf
  perf annotate-data: Resolve DW_OP_addrx global variables
  perf tests: Exercise the flexible array member path
  perf annotate-data: Count flexible array accesses for the whole struct
  perf tests: Exercise data type resolution from a register
  perf annotate: Print the stats after the annotations
  perf tests: Silence the libbfd probe in build-test
  perf build: Record the display-only features in FEATURE-DUMP
  perf cs-etm: Fall back to the recorded instruction size on a failed read
  perf tests: Fix the Intel PT virtual LBR check
  perf test: Drop samples without an IP in the dlfilter test
  perf test: Skip the LBR inline unwinding check when unsupported

 tools/perf/.gitignore                         |   1 +
 tools/perf/Makefile                           |  11 +-
 tools/perf/Makefile.config                    |   4 +
 tools/perf/Makefile.perf                      |   4 +
 tools/perf/builtin-annotate.c                 |  10 +-
 tools/perf/scripts/coverage.sh                | 703 ++++++++++++++++++
 tools/perf/tests/make                         |   2 +-
 tools/perf/tests/shell/addr2line_inlines.sh   |   9 +-
 tools/perf/tests/shell/annotate_stats.sh      |  58 ++
 .../perf/tests/shell/data_type_flex_array.sh  | 142 ++++
 .../tests/shell/data_type_profiling_clang.sh  | 108 +++
 tools/perf/tests/shell/data_type_register.sh  | 120 +++
 tools/perf/tests/shell/script_dlfilter.sh     |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   9 +-
 tools/perf/util/annotate-data.c               |  24 +-
 tools/perf/util/cs-etm.c                      |   7 +-
 tools/perf/util/dwarf-aux.c                   |  42 +-
 17 files changed, 1234 insertions(+), 22 deletions(-)
 create mode 100755 tools/perf/scripts/coverage.sh
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh
 create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
 create mode 100755 tools/perf/tests/shell/data_type_profiling_clang.sh
 create mode 100755 tools/perf/tests/shell/data_type_register.sh


base-commit: cc905a18a647a8e3ad42cd1596baa0e08fba26eb
-- 
2.56.0

