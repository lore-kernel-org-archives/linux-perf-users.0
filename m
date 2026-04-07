Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A52126C17;
	Tue,  7 Apr 2026 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591517; cv=none; b=CZGVOP/ASWRjInuM0aylt4iRUHLMY7k2LWWawMK6oO5og1ET0wy+F08+iTlw4rTtsgyNDnBgy5rdITne43ofStkp9ivqIntUhzTRJTTDiOmye4eHZjVDwtXo1IG0vWaLguA/DuMwECaCObAlRPv1iKIl9XbUnf/nT0RCoF2W104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591517; c=relaxed/simple;
	bh=7vTxj1kei6GvT6dxvxX+GL9jqOjit73esjkS7Sgf1i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mr0f2IqA3FZXup52UKmJr6TwDFSN6H14M7r53Fdkvm1yPTmqVgO42Q69JcC09UXVNSSlQgbN4TI8MF3V88zl341pM93ZAoNChe2PFV/T+NLzZ+DY0lO5PzJ0lAmGmMbO8ft9FnB39aUVtFgU5z+CzU83Mshuf0L7n0uN1rOkCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9tlqtrL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9tlqtrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7738BC116C6;
	Tue,  7 Apr 2026 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775591517;
	bh=7vTxj1kei6GvT6dxvxX+GL9jqOjit73esjkS7Sgf1i0=;
	h=From:To:Cc:Subject:Date:From;
	b=G9tlqtrLDLd0havBBI2lk41NzyozYCIMjSJCkMOjfHCO1/2t+SHMYH4F+CkrN3lRp
	 ncAWTVxTX05B7xjvvjRHnq7gpL+LbvS2FuN/FjxnjOC97UASg8SA30JloElQQ+Ea5O
	 3gg4j4wesntMhSFdpodFF3YZWtvPZV/5XDnzi741sgofxQ3EabHlUtOJF7eQdcUIJt
	 xWBy7JWj0qeC6lALOqemxzpCB4mYEu2rOHL3mr1BCqVgA7QlEncWx8vUmDF7stgS2y
	 8YgchqagTx6lf2lodfwyCY9hIRjD5UcTRCV7V1Z++JXL95MI/tNMy1QRvilvrp8p2O
	 VJo6hMV//H8Qg==
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
Subject: [PATCHES perf-tools-next v4 0/6] Cleanups and fixes
Date: Tue,  7 Apr 2026 16:51:39 -0300
Message-ID: <20260407195145.2372104-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

        Here are some cleanups, a refresh for a patch Ian sent and fell
thru the cracks, using calloc where applicable, constify some arrays and
add a missing header that was making the build fail on some musl
systems.

Thanks a lot,

- Arnaldo

v4: Address some more Sashiko comments, see patch comments for details.

v3: Address https://sashiko.dev review, removed a malloc->calloc
conversion, flawed, and removed the changes to trace-event-scripting.c,
that made the build fail in some situation, see the committer notes
in the patch for more details.

v2: remove the commenting of gen_vmlinux in tools/perf/tests/make as
noticed by Ian Rogers.

Arnaldo Carvalho de Melo (5):
  perf symbols: Make variable receiving result strrchr() const
  perf bench: Constify tables
  perf tools: Use calloc() were applicable
  perf tools: Replace basename() calls with perf_basename()
  perf util: Kill die() prototype, dead for a long time

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
 tools/perf/builtin-daemon.c                   |   4 +-
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
 tools/perf/util/annotate.c                    |   3 +-
 tools/perf/util/block-range.c                 |   2 +-
 tools/perf/util/bpf-event.c                   |   2 +-
 tools/perf/util/bpf_counter.c                 |   4 +-
 tools/perf/util/bpf_counter_cgroup.c          |   1 -
 tools/perf/util/bpf_off_cpu.c                 |   2 +-
 tools/perf/util/data-convert-bt.c             |   2 +-
 tools/perf/util/data-convert-json.c           |   4 +-
 tools/perf/util/data.c                        |   2 +-
 tools/perf/util/db-export.c                   |   1 -
 tools/perf/util/debug.c                       |   2 +-
 tools/perf/util/debuginfo.c                   |  19 ++--
 tools/perf/util/disasm.c                      |   1 +
 tools/perf/util/dsos.c                        |  32 ++----
 tools/perf/util/event.c                       |   1 -
 tools/perf/util/evlist.c                      |   3 +-
 tools/perf/util/header.c                      |  18 +--
 tools/perf/util/hist.c                        |   2 +-
 tools/perf/util/mem2node.c                    |   2 +-
 tools/perf/util/pmus.c                        |   2 +-
 tools/perf/util/powerpc-vpadtl.c              |   1 +
 tools/perf/util/probe-event.c                 |  20 ++--
 tools/perf/util/probe-file.c                  |   2 +-
 tools/perf/util/probe-finder.c                |   8 +-
 tools/perf/util/session.c                     |   2 +-
 tools/perf/util/sort.c                        | 104 +++++++++---------
 tools/perf/util/srcline.c                     |  12 +-
 tools/perf/util/stat-shadow.c                 |   1 -
 tools/perf/util/symbol.c                      |   2 +-
 tools/perf/util/symbol.h                      |  16 +--
 tools/perf/util/unwind-libunwind-local.c      |   1 -
 tools/perf/util/util.c                        |  10 +-
 tools/perf/util/util.h                        |   3 +-
 tools/perf/util/values.c                      |   8 +-
 69 files changed, 234 insertions(+), 280 deletions(-)

-- 
2.53.0

