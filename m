Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0C314D21;
	Wed,  8 Apr 2026 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669342; cv=none; b=dlfQ+IWX5VoUQYZcTenHhtAZx/kWRnMONN/aV4ATPAd2KxHcySQwPv5W8l3v1qM2klfyPzQKYlsvsHzuF5uFrEG48EHv1QaMWpco09oRIHeUEMwcPv5xRUzbB8XwCCUC7GYB6dahjoy5Qf1pbAA1/iPsYHFSocuFhJrz2p7DjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669342; c=relaxed/simple;
	bh=PP9dOP4x/xVHQAL7Qpt3J7Liq1Q+dLn2SxBOAH6lqM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GoUe8wbBr9dG1csRwKmzq4wrKIXwzox5GfQS+2HiFyyxtVzoQWFJyXK1Df4CdHJjSzVhRFHmkwq2FA7w/Mvq9ns6QYUKx1F1KBCyXsi7HNTWwGmFUpVCUVKd2gSIVVCrCyh6orQdb1mgnK3thtUmZTA8aEboYOs93EW5LYXZNFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwa1lh7x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwa1lh7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53825C19421;
	Wed,  8 Apr 2026 17:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669341;
	bh=PP9dOP4x/xVHQAL7Qpt3J7Liq1Q+dLn2SxBOAH6lqM4=;
	h=From:To:Cc:Subject:Date:From;
	b=mwa1lh7x5a2BotJGS/C+tQ8nyTXMSIWF13PslcuW7cYFycLU9D2NlV6oHLxJFxXBM
	 9SaUHqm97MqqevLfkihJcDVmiU5EojkLJYuu6rAk6nm3NLgohg1T3ZP4mfNB9VrUIs
	 7vWDFLBqGTugfpKasvpGkxQmsIwa9EAY9UC/ca/H5Ig1SJ8Zp8y8HbZw3d0vIYPoaN
	 EKqj3cY6xAmwBQwa1M957a8/fmcbgcHH2/d2Y/IDPrD4C/TCh3F0+fk4bQy+oh4i2S
	 15yz3cAzf4ZjXH7uuSujMi/xHJmrqFFYcWx6CrNGpyrrFa31mjOCVznu59XaPwBDWF
	 B2A8a+8GyPXzA==
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
Subject: [PATCHES perf-tools-next v5 0/7] Cleanups and fixes
Date: Wed,  8 Apr 2026 14:28:38 -0300
Message-ID: <20260408172846.96360-1-acme@kernel.org>
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

	This also adds checks for perf.data headers that were suggested
by sashiko.

Thanks a lot,

- Arnaldo

v5: Address more comments and add perf.data header checks.

v4: Address some more Sashiko comments, see patch comments for details.

v3: Address https://sashiko.dev review, removed a malloc->calloc
conversion, flawed, and removed the changes to trace-event-scripting.c,
that made the build fail in some situation, see the committer notes
in the patch for more details.

v2: remove the commenting of gen_vmlinux in tools/perf/tests/make as
noticed by Ian Rogers.



Arnaldo Carvalho de Melo (7):
  perf symbols: Make variable receiving result strrchr() const
  perf util: Kill die() prototype, dead for a long time
  perf bench: Constify tables
  perf header: Use a max number of command line args
  perf header: Do validation of perf.data HEADER_CPU_DOMAIN_INFO
  perf tools: Use calloc() where applicable
  perf tools: Replace basename() calls with perf_basename()

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
 tools/perf/util/header.c                      |  35 ++++--
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
 69 files changed, 251 insertions(+), 280 deletions(-)

-- 
2.53.0

