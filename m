Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E071D3218B3;
	Wed,  1 Apr 2026 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080394; cv=none; b=PYX04aEBYoHBAga1SrBTFkuxKA9xMUq4eiATIAzDOLgcfMenYGszdhR/brFYcoqtalOZWfvqY0DWRaM/ZKFxeDs4yV/sewNKn5iegnwq+gCBLDA2clMFVW43l6ngHyPOXbGzN8HmSfoFtrF9Qy+CQV8Jp0CBajtg3zQUE7nch9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080394; c=relaxed/simple;
	bh=AeaEW88iCChpqigehVa6kI5RNpR2Zlrqh3T7X512htU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTCQjPkgXOsNIGSHQ2suhth1NdVJCaJ1ovUYeqKJOSdGIRwyOTS0uAm1iTC2urLynD2vJhN6QNWAb+VdJ9wqlc7O3Nsx1xx8DzGUHh4h2wju3wHHZJ5WJCEc1h50PdF8ut86fie4InMJ8xWbTSBlTuv6KYGZZA/XJyG+/TGOSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+c2jUs9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+c2jUs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79056C4CEF7;
	Wed,  1 Apr 2026 21:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775080393;
	bh=AeaEW88iCChpqigehVa6kI5RNpR2Zlrqh3T7X512htU=;
	h=From:To:Cc:Subject:Date:From;
	b=c+c2jUs9qGFPEdSG9PTbRuQdkglfEMV6kOHSn61m1Gh3HjJ7ME18JXTiEB0IPMwZF
	 WPnPSg0RJAyl8ikPEsUxCt1BwP1SUKOiSXhzCYaFcrwYFGw/VgjTI2pqGeZFBTOxPj
	 GVjbqARL4zY99yOJxUGS/v4OoHhIMWeEi5jNfpkPdCfXfUHccprLDQxo7lDKwJ0TlS
	 Mv5ThTCO68RC+NuhGNZ2PSK+aXnEMCIQZytDVPFtc/r2jlPFdDBLwAskjzuR+0xAgT
	 tgNFOsmFwpRYzl2CgAF3ZgJf32XXFgIk9RhxTw1Es3qsCEjOGZMPCT38EqHYMAuz8x
	 gdMM7fVDNCz1Q==
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
Subject: [PATCHES v2 perf-tools-next 0/4] Cleanups and a fix
Date: Wed,  1 Apr 2026 18:53:02 -0300
Message-ID: <20260401215306.2152898-1-acme@kernel.org>
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
 tools/perf/builtin-script.c                   |  12 +-
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
 tools/perf/util/trace-event-scripting.c       |  98 +++++++++--------
 tools/perf/util/unwind-libunwind-local.c      |   1 -
 tools/perf/util/util.c                        |   2 -
 tools/perf/util/values.c                      |   8 +-
 64 files changed, 254 insertions(+), 275 deletions(-)

-- 
2.53.0

