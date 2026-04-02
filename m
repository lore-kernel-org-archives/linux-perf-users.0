Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9A8EEC0;
	Thu,  2 Apr 2026 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089199; cv=none; b=VGlujJblXGrtfax9FNQiDDOKb/aD7NsrAOteO32Xd+eWkRZtMFVQRf1FKXbUl7FmqFnnYRPtXxWGN81E0PnsP9ASHZUcsXTvbesuznXUbg8tLn2GKzsfMqbF41Iwnpcoic26HLTY0H+1/oruDRk6yIYbhRL8dm78BocPGUrAgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089199; c=relaxed/simple;
	bh=f9sB/1//joPS8ubwbxPeKWWL8+USedHZx6jCYajWihk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geY/GQ0R3nJK5zDSfd+uKKLbXX41fP3NPloD4o3KcTpJhO3bsdofalDOvHmD9pgXNYoIJraRs3fYiOCTkovjMdXZB/RivhaUVhhYrjv+35+MZ5+BehQzzhnaZnIzQGuf9OiP/Pj+s20pSrteU9BFjG+M3edsZlbeHnb5zMKcxv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEu7CMoq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEu7CMoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A61BC4CEF7;
	Thu,  2 Apr 2026 00:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775089199;
	bh=f9sB/1//joPS8ubwbxPeKWWL8+USedHZx6jCYajWihk=;
	h=From:To:Cc:Subject:Date:From;
	b=HEu7CMoq6lDqI45rzApA2U+NEaJqgqOl3h6nzSlLpR5UhlpfyUK8gWsAhsCWLr5qp
	 XF7mhiTw6DuiBEqz2jqFnIpRwCIjnMIQeic4w2EKnX1QQnJ8xK1p8uABnvp0/DWdjS
	 USVsw8w3OTzutpxgWcxR4Yh7p9rNaQ2IIAC5KRMPaELkps82++LpCfoa5jqppyb2lZ
	 M7lk6MRYzdRt64yUFo96Obw8fzs8n7/0MpbDEdvLMRW9PU6R+7omj4snP9nme7p0uN
	 4Nh5oZfmZmVFGNXGw94WuVMotDkH5LNHd7lritMgjNdUK3o19uHggHZmQySTlxAtY5
	 m6iFlWhwLvRoQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCHES v3 perf-tools-next 0/4] Cleanups and a fix
Date: Wed,  1 Apr 2026 21:17:36 -0300
Message-ID: <20260402001740.2220481-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

        Here are some cleanups, a refresh for a patch Ian sent and fell
thru the cracks, using calloc where applicable, constify some arrays and
add a missing header that was making the build fail on some musl
systems.

Thanks a lot,

- Arnaldo

v3: Address https://sashiko.dev review, removed a malloc->calloc
conversion, flawed, and removed the changes to trace-event-scripting.c,
that made the build fail in some situation, see the committer notes
in the patch for more details.

v2: remove the commenting of gen_vmlinux in tools/perf/tests/make as
noticed by Ian Rogers.

Arnaldo Carvalho de Melo (3):
  perf bench: Constify tables
  perf tools: Use calloc() were applicable
  perf symbol: Add missing libgen.h include to get basename() prototype

Ian Rogers (1):
  perf tools: Make more global variables static

 tools/perf/arch/arm/util/auxtrace.c           |   6 +-
 tools/perf/arch/common.c                      |  22 ++--
 tools/perf/arch/powerpc/util/auxtrace.c       |   1 +
 tools/perf/arch/sh/include/dwarf-regs-table.h |   2 +-
 tools/perf/arch/x86/tests/amd-ibs-period.c    |   3 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c      |  11 +-
 tools/perf/arch/x86/util/pmu.c                |   1 -
 tools/perf/bench/breakpoint.c                 |   4 +-
 tools/perf/bench/mem-functions.c              |   2 +-
 tools/perf/bench/numa.c                       |  15 +--
 tools/perf/bench/sched-messaging.c            |   2 +-
 tools/perf/bench/uprobe.c                     |   2 +-
 tools/perf/builtin-annotate.c                 |   1 -
 tools/perf/builtin-bench.c                    |  42 +++----
 tools/perf/builtin-c2c.c                      |  13 ++-
 tools/perf/builtin-config.c                   |   2 +-
 tools/perf/builtin-data.c                     |   8 +-
 tools/perf/builtin-diff.c                     |   6 +-
 tools/perf/builtin-ftrace.c                   |   1 +
 tools/perf/builtin-kmem.c                     |   2 +-
 tools/perf/builtin-kwork.c                    |  14 +--
 tools/perf/builtin-record.c                   |  10 +-
 tools/perf/builtin-sched.c                    |   6 +-
 tools/perf/builtin-script.c                   |  10 +-
 tools/perf/builtin-stat.c                     |   2 +-
 tools/perf/builtin-top.c                      |   5 +-
 tools/perf/builtin-trace.c                    |   4 +-
 tools/perf/jvmti/libjvmti.c                   |   5 +-
 tools/perf/tests/bp_signal.c                  |   2 +-
 tools/perf/tests/code-reading.c               |   1 +
 tools/perf/tests/dso-data.c                   |   2 +-
 tools/perf/tests/thread-map.c                 |   1 -
 tools/perf/tests/wp.c                         |   6 +-
 tools/perf/util/annotate-arch/annotate-x86.c  |   1 +
 tools/perf/util/block-range.c                 |   2 +-
 tools/perf/util/bpf-event.c                   |   2 +-
 tools/perf/util/bpf_counter.c                 |   4 +-
 tools/perf/util/bpf_counter_cgroup.c          |   1 -
 tools/perf/util/bpf_off_cpu.c                 |   2 +-
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/data.c                        |   2 +-
 tools/perf/util/db-export.c                   |   1 -
 tools/perf/util/debug.c                       |   2 +-
 tools/perf/util/debuginfo.c                   |  19 ++--
 tools/perf/util/disasm.c                      |   1 +
 tools/perf/util/event.c                       |   1 -
 tools/perf/util/evlist.c                      |   3 +-
 tools/perf/util/header.c                      |  18 +--
 tools/perf/util/hist.c                        |   2 +-
 tools/perf/util/mem2node.c                    |   2 +-
 tools/perf/util/pmus.c                        |   2 +-
 tools/perf/util/powerpc-vpadtl.c              |   1 +
 tools/perf/util/probe-event.c                 |  17 ++-
 tools/perf/util/probe-file.c                  |   2 +-
 tools/perf/util/probe-finder.c                |   8 +-
 tools/perf/util/session.c                     |   2 +-
 tools/perf/util/sort.c                        | 104 +++++++++---------
 tools/perf/util/srcline.c                     |   1 +
 tools/perf/util/stat-shadow.c                 |   1 -
 tools/perf/util/symbol.h                      |   1 +
 tools/perf/util/unwind-libunwind-local.c      |   1 -
 tools/perf/util/util.c                        |   2 -
 tools/perf/util/values.c                      |   8 +-
 63 files changed, 203 insertions(+), 226 deletions(-)

-- 
2.53.0

