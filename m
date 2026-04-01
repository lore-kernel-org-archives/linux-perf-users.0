Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0ED3876B8;
	Wed,  1 Apr 2026 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077334; cv=none; b=UiPn/k3iILQuJRelpL0SK6o+3mUdiyekj2G+1m0LO9D8PHgijioNdbo58OJZRn3yzB+MXHsGm/9E9O+L+mj2LIBBID45XaPP+R5vT4wVSA1eod1LXKMA+aXo8CF5Q1i1cKUhhIQHjVFNXVF0gd/Hti7/UTpOdhRkDaP21wP/b9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077334; c=relaxed/simple;
	bh=bjdPjNq2OVxCaZPr2PrYFy/6KrfLNs4WZn4OaF+wUqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InFdGMa37htje4cG55jNaJXBwz/OkGiO4Z5Taq0O/stoTRx385+qgO5sOkbtDzQNRwQ/4viSZIsx2+DwskC6nLFkGg94B5SxphAi0X2b7d1KXh+envM3B/XzwTrmoPwlk95OzkuLFplUQ2p1KdGyZvx0Ztw3H7ZrCQ8CgCNcHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2e5W/SP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2e5W/SP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A768C116C6;
	Wed,  1 Apr 2026 21:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775077333;
	bh=bjdPjNq2OVxCaZPr2PrYFy/6KrfLNs4WZn4OaF+wUqU=;
	h=From:To:Cc:Subject:Date:From;
	b=g2e5W/SP5EGKAkrX/jp6Cvk0+baCkuRrcSuwSvKipwSeIS2ir4bnbmvVI6Y61E/Ji
	 /0RM8hyJRFW840bhe5vPDlCriWoKwLALS+TlOiEE9tPnKmlErk0NeJQlSx4uioVIpp
	 hA4ic0NSylCkCelcXGVr1BdbZOjZdug+uI1ZHbanqx2VIjd8IJvbJ7spZjcbLH9ebg
	 4Kbgb7QzcxjaUgSvLPyc0Fzck1asPLYHIYNTT+PjpxH1kY84+VN/JUdT3Gz8vxqN0B
	 yD9Q2pLJakvQ1C6qzZblC//EvE79y+ThI6swo4qY+Z7w103jZDQaPm76+4gc45Y0lU
	 J8AWHZLFuUEug==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES perf-tools-next 0/4] Cleanups and a fix
Date: Wed,  1 Apr 2026 18:01:57 -0300
Message-ID: <20260401210203.2150651-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

	Here are some cleanups, a refresh for a patch Ian sent and fell
thru the cracks, using calloc where applicable, constify some arrays and
add a missing header that was making the build fail on some musl
systems.

Thanks a lot,

- Arnaldo

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
 tools/perf/builtin-script.c                   |  12 +-
 tools/perf/builtin-stat.c                     |   2 +-
 tools/perf/builtin-top.c                      |   5 +-
 tools/perf/builtin-trace.c                    |   4 +-
 tools/perf/jvmti/libjvmti.c                   |   5 +-
 tools/perf/tests/bp_signal.c                  |   2 +-
 tools/perf/tests/code-reading.c               |   1 +
 tools/perf/tests/dso-data.c                   |   2 +-
 tools/perf/tests/make                         |   2 +-
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
 tools/perf/util/trace-event-scripting.c       |  98 +++++++++--------
 tools/perf/util/unwind-libunwind-local.c      |   1 -
 tools/perf/util/util.c                        |   2 -
 tools/perf/util/values.c                      |   8 +-
 65 files changed, 255 insertions(+), 276 deletions(-)

-- 
2.53.0

