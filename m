Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231262;
	b=vk5n+kDhmxF2PcZxDP2spYv3n1gtuBcG+4TbUYYPEsA+kl3sq1M/kdq+SkkzzGH+bbgc
	 +kMMzq64ykOlk8x3EGu9QDJdh+7bKzD6FiIzC3ipoACCRMuen3sRYfsDyPjKXbq1mfLyX
	 aPweskFn6fkBRpscyW4wHzbWpsywqCW0RwSGvzmN13xsZY30Pkmkiv+S7s+HP75lwGe9b
	 3yfdZiHvmnxsr+/dajwtJNsK31h1dmPbzkYdAl19NSriBdSgmeVnxuwfQwkAHR74Id/oG
	 G/Ye+5aGqclGnM64lijO5LERyaJpLeEDX7jGnn14fU5R4Q8vyq7EEyOepsZwlD2RJvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231262;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i6IPMIh4jNQ2qo/4xiiXkBRhOxqHMZd268yZ8IOQ/AY=;
	b=x7kMXhjZCX8wDcQsLGWlBWwWMgprzF02xFE8ONR7ANSWCHX23nv73yvDr0SpXPcGoaMD
	 j/QX7OJyy7jpLYR3lZIz9OV1IWXBd7u0qC8ov+I7dgF7Plv/CvE2Q016M5Y1Uw011k2Av
	 y8j5Uy/nLtcwAG6O+R111nAwvlDfb4KxckiVGsWHkJeFkKcEzaVn1s3Pxg148CPbzGIwT
	 UEv8K2iaxthA/96JJiAXDbRtoIsUC1g3HQbVsxPF480JxQCkGwLCdpwbBV1sVAFJQ/EWY
	 Y2+dzMgvAA2O1ZaAO3asNCAzHV/A6ygRnwjXAMN2uPS0thVCvyYsBf2PSzRHLY1EJgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOqPX68Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB29606A325;
	Sat, 21 Nov 2026 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOqPX68Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D52A1F000C4;
	Sat, 21 Nov 2026 03:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231262;
	bh=i6IPMIh4jNQ2qo/4xiiXkBRhOxqHMZd268yZ8IOQ/AY=;
	h=From:To:Cc:Subject:Date;
	b=DOqPX68ZKuNArYRd0R2OvUimUF5ybLD3+N175knbl2VIu21pVYdqIjWkUkJ8LM6rN
	 Z1cYV8YqF91M4w3K13OAVeLHp0xmvKG0WA5pRwET+WXyXx8eUJA+e5woMs/Qnv+LrE
	 6J7tbSepYbKufJDWB1PMxZgZ7Q7WCOXVfq5nV2Xbpq3C5ElWyC+NSDgoIAh3zM3GbY
	 Ubiw2nXbzXV8eH4d9UOLZ8RWqRNQOy7P6Se4aPxSKD7nMN9yTxVS70jzDygXMESXEY
	 WXILxKrCbwFE8Z1SzBCChFDvJyE8Tt4iwtkbwwZqxi/Z9D4W5Y5QjWzV+fU4+a6iYT
	 BCfTzYdQm0+tA==
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
Subject: [PATCH v10 00/16] perf coverage: A harness for perf, and the fixes it found
Date: Sat, 21 Nov 2026 00:20:36 -0300
Message-ID: <20261121032052.1392234-1-acme@kernel.org>
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

Nothing measured how much of perf the test suite reaches.  Patches 15-16
add coverage.sh, which builds perf with clang source based coverage, runs
the full test suite and reports line and function coverage, and
coverage-table.sh, which renders the biggest uncovered gaps over the
whole tree, not only the files the tests already touch.

Patches 1-6 are the fixes the first runs found, 7-14 their tests and the
test fixes.  1 is a build fix for the GTK UI, which the coverage build
needs; 5 is a parser change, not a regression fix.

  - The GTK UI was not linked with EXTRA_CFLAGS, so the coverage build
    never saw its counters (1).
  - Absolute addressing was missing from the data type resolver (2);
    movabs was not parsed (5).
  - --insn-stat was printed before the samples were accounted (3).
  - FEATURE-DUMP didn't record features checked outside FEATURE_TESTS
    (4).
  - The flexible array member row showed 0.00% while the member said
    100.00% (6).

  - Tests for the x86 operand parser (7), DW_OP_addrx globals (8, test
    only: fixed upstream by c3991e42f58a3650), the flexible array path
    (9), a struct pointer kept in a register at -O2 (10) and the
    annotate stats (11).
  - Intel PT virtual LBR, dlfilter zeroed IP and LBR inline unwinding
    test fixes (12-14).

clang DWARF 4, full test suite as root on this AMD host with the v10
plus cs-etm tree: 112250 of 232853 lines (48.21%), 86661 of 173942 in
tools/perf/ (49.82%), 170 passed, one failure (21.2, the known
Tracepoint event kernel regression).  The total includes libbpf and the
dlfilters, so it is not comparable with the v6 total.

The harness and the tests were developed with an AI coding assistant
(OpenCode), which drafted the script and the tests and helped debug the
failures; I reviewed every change and reproduced each failure.

What changed from v9:

  - Split into fixes, tests and infrastructure; the fixes no longer
    carry their tests.
  - The harness is 15 and the table is split out of it as 16.
  - The libbfd probe (v9 9) is dropped, the base checks it via
    Makefile.feature (5aa34144027f); the movabs change (5) is new.
  - 8 and 10: diagnostic greps use || true, so they no longer fire the
    EXIT trap.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (16):
  perf build: Link the GTK UI with EXTRA_CFLAGS
  perf annotate: Handle absolute addressing in data type profiling
  perf annotate: Print the stats after the annotations
  perf build: Record the features checked outside FEATURE_TESTS
  perf annotate-x86: Parse movabs like a mov
  perf annotate-data: Count flexible array accesses for the whole struct
  perf tests: Exercise the x86 operand parser
  perf tests: Exercise DW_OP_addrx global variables
  perf tests: Exercise the flexible array member path
  perf tests: Exercise data type resolution from a register
  perf tests: Exercise the annotate stats output
  perf tests: Fix the Intel PT virtual LBR check
  perf test: Drop samples without an IP in the dlfilter test
  perf test: Skip the LBR inline unwinding check when unsupported
  perf scripts: Add a coverage harness for perf
  perf scripts: Add a coverage table

 tools/perf/.gitignore                         |   1 +
 tools/perf/Documentation/perf-annotate.txt    |   2 +-
 tools/perf/Makefile                           |  15 +-
 tools/perf/Makefile.config                    |   7 +
 tools/perf/Makefile.perf                      |   8 +-
 tools/perf/builtin-annotate.c                 |  19 +-
 tools/perf/scripts/coverage-table.sh          | 310 +++++++++++++
 tools/perf/scripts/coverage.sh                | 434 ++++++++++++++++++
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/annotate-ops.c               | 127 +++++
 tools/perf/tests/builtin-test.c               |   4 +
 tools/perf/tests/shell/addr2line_inlines.sh   |  20 +-
 tools/perf/tests/shell/annotate_stats.sh      |  69 +++
 .../perf/tests/shell/data_type_flex_array.sh  | 111 +++++
 tools/perf/tests/shell/data_type_global.sh    |  73 +++
 tools/perf/tests/shell/data_type_register.sh  |  63 +++
 tools/perf/tests/shell/script_dlfilter.sh     |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |  10 +-
 tools/perf/tests/tests.h                      |   4 +
 tools/perf/tests/workloads/Build              |   6 +
 tools/perf/tests/workloads/flex_array.c       |  55 +++
 tools/perf/tests/workloads/global_data.c      |  57 +++
 tools/perf/tests/workloads/regptr.c           |  60 +++
 tools/perf/ui/browsers/annotate-data.c        |   7 +-
 tools/perf/util/annotate-arch/annotate-x86.c  |  45 +-
 tools/perf/util/annotate-data.c               |  25 +-
 tools/perf/util/annotate-data.h               |   8 +
 tools/perf/util/annotate.c                    |  27 +-
 tools/perf/util/annotate.h                    |   7 +
 29 files changed, 1548 insertions(+), 29 deletions(-)
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

base-commit: bb27ddbaee56536fb8df0a24f07b526766dfe131
v1-head: 3f5465bea8f5a97a
v2-head: 9706c488afffeb6d
v3-head: f2daf1586528671a
v4-head: b9e240a1b80ecd2a
v5-head: a21454e3d055c93b
v6-head: e1315408a335617d
v7-head: 7f8dc594d77ed495
v8-head: 67fde34aeab98a91
v9-head: b1765115908ede31
v10-head: 83b30d979fb2d96d
-- 
2.56.0

