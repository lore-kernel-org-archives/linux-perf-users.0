Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600538;
	b=BwNqSh2ap8tX7YZf+j6pN9mRy0r4Szn5JC/fwGfOwTwB9sVKx6IDZNL6I6NowNfkPWmK
	 0QRMzZ+VM7NTZHPEfGYwAFh63gwhazU0TkKvAoc6EzG/Xg1cYpQTbSm7/x6rkQxRx2P8g
	 LPTBGVb3LOePq4grDIOw7JVkosvUyLBSsTbmh4v74LjO39eMx1s0MGLTfVYItO3HwjDbr
	 V5x0LmK/Wj4F1Y8fsNT+qkqHO1n7JCvaURq3t5dr6jU+ERt9CxyNrgx4HHAsS0QbBdL3W
	 ucBGZ4i1/1FOOgLRZu9EWuQmuZegZKwTbt47okXizlXm6JFKp2uOg1Jo1tDBDMS1AIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600538;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Bu/vZ2ytCn2vMKJsGkCSDeZa/P8FiRBEVeaQyy0fYCc=;
	b=eUYJavHM9iGBzS4C/wW+ixIO5t3OLnaju9lEe7c0VuPtsq2yGrKWIo806neGfNoGEo8P
	 VPDH8PvvR7SzLhANPW7eWK0Ce2+WiqmjQlkOmGyd8Jp/xWNbEZBEzAZLRI6abUp3se1Xh
	 EDYuiQD1vGn0b136tiNKSvEWzm3Oj9G8+ZHzR+rMJvX/tM9qn2erd5bKcgujOGytghOmO
	 wX+uVfCJSiLDbsNSuxJXGJLD5o98gQi08bFLmaVAWYcCSvfPKyNeyjH0RfMUnBxUZPzHi
	 ApKLoDA/ks0jeQG086S1MGHjqHXxevZm54mYsg8kkT0BUy5izeRSN3/T/hXpR0HzGTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USNN2Wh1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7C606A331;
	Fri, 13 Nov 2026 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USNN2Wh1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5221F000C4;
	Fri, 13 Nov 2026 20:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600537;
	bh=Bu/vZ2ytCn2vMKJsGkCSDeZa/P8FiRBEVeaQyy0fYCc=;
	h=From:To:Cc:Subject:Date;
	b=USNN2Wh10WPwDT6kBUApf4Aefq93BdiJS4TJbNMYbc00XrN9tsFd8FPzKDLi7vuoV
	 2qp4IwpEAtF7mhmhYRzoZU3i5bj3SEQHoYZQ59dY1I5K5ruB99iS1UYhMt0+RzCNeP
	 nOtLJf4K9GhwByr8T3ZSQ2yyAa6iqYYWPPYZQJbUiqPhcKPOj45kK1MFCQz4yO8wWq
	 cx+PhcosWqb+7MYZyvQeTz2VFlOyEvxrt35fp0ouVF8aYV2I69iaXZQAV7+jBtf7Lu
	 JZkRbEkCQGkCcKa/IdLqkM94y2pLyRZ4jFMwEKjLs3Ay/5UU5TQYKftMiuIXzFBoN2
	 sb8adohF5zZEw==
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
Subject: [PATCH v2 0/11] perf coverage: A harness for perf, and the fixes it found
Date: Fri, 13 Nov 2026 17:08:38 -0300
Message-ID: <20261113200850.2803460-1-acme@kernel.org>
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
  - The Intel PT virtual LBR check lost every aux sample with a single
    data page (patch 9).
  - The dlfilter test kept samples whose IP the kernel now zeroes on a
    userspace-to-kernel skid (patch 10).
  - The LBR inline unwinding check failed instead of skipping when the
    AMD PMU rejects branch sampling (patch 11).

In a root run on this box the suite covered 49.16% of perf's 201,180
lines.  The POLL_HUP tracepoint regression and the lock contention count
fail in code this series does not change; the LBR inline unwinding check
failed there and now skips.

The numbers above are from v1 and are slightly different here: the
cs-etm patch was dropped and the issues reported in the v1 review were
addressed, which changes both the tree and what the report counts.

The harness and the tests were developed with an AI coding assistant
(OpenCode), which drafted the script and the tests and helped debug the
failures; I reviewed every change and reproduced each failure before
fixing it.

What changed from v1:

  - Patch 9 (cs-etm) is gone: Leo Yan's series replaces it.
  - Patch 1: O= is accepted by all targets, the Python extension is in
    the report, -f is normalized and the delta matches its baseline.
  - Patch 4: the TUI browser counts flexible array accesses too.
  - Patch 6: the stats test skips without libdw.
  - Patches 9 and 11 (were 10 and 12): Fixes tags corrected.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (11):
  perf scripts: Add a coverage harness for perf
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
 tools/perf/tests/make                         |   2 +-
 tools/perf/tests/shell/addr2line_inlines.sh   |   9 +-
 tools/perf/tests/shell/annotate_stats.sh      |  64 ++
 .../perf/tests/shell/data_type_flex_array.sh  | 142 ++++
 .../tests/shell/data_type_profiling_clang.sh  | 108 +++
 tools/perf/tests/shell/data_type_register.sh  | 120 +++
 tools/perf/tests/shell/script_dlfilter.sh     |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   9 +-
 tools/perf/ui/browsers/annotate-data.c        |   7 +-
 tools/perf/util/annotate-data.c               |  24 +-
 tools/perf/util/annotate-data.h               |   3 +
 tools/perf/util/dwarf-aux.c                   |  42 +-
 18 files changed, 1260 insertions(+), 24 deletions(-)
 create mode 100755 tools/perf/scripts/coverage.sh
 create mode 100755 tools/perf/tests/shell/annotate_stats.sh
 create mode 100755 tools/perf/tests/shell/data_type_flex_array.sh
 create mode 100755 tools/perf/tests/shell/data_type_profiling_clang.sh
 create mode 100755 tools/perf/tests/shell/data_type_register.sh


base-commit: cc905a18a647a8e3ad42cd1596baa0e08fba26eb
v1-head: 3f5465bea8f5a97a
-- 
2.56.0

