Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0DE26ED3C;
	Sat,  6 Jun 2026 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776373; cv=none; b=nIt+exOIVhvm+T7sa+SKk8f1RPOExB286zQ+JMCQ4D5qeL0b/zlQAEGwam8Ss4bL016+a/VmjXsr/rND+tgt/wAJh1ky3xIW3zKJTOQPXOqrzOOEHv3lVMIU48F3Urzh/+LtV55q9xU0oDOCygFTRkOLWET9Z5ewhURRQ35Ub30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776373; c=relaxed/simple;
	bh=OmdhiBEwEo1dkL4RUj978SJdAcUM1gknecLUPT9FBxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLw+J2/OIHq2NRPkj3s1vP5g3GoGEbl0Y7p8TCunc+KbFYYCbKQhj3vo1OFDvagjV13GpUDJKnJgN177F7FEBwa/V1R417Leji1JI6UUMkqwR6hwgO5ewev0vVMl+Oc3amus3M/OhHiQnmm7ys8bRGSnxIBa1TGX9eljYPUNvjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNALxn9W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNALxn9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9D51F00893;
	Sat,  6 Jun 2026 20:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780776371;
	bh=U8WmTto546ZT7Ha9LSLr6gI94UHOYcPt4o0uSfTpEfQ=;
	h=From:To:Cc:Subject:Date;
	b=XNALxn9WajQZKJ60AaXst73/igoYAwnJkmOdJysM0N/GSNG1QKGIMTimh2wok6+Ap
	 L0LSCAB+V/GduMTmCXJyAIk5YlLpm8fTke/H4VoeDQ/Cs1UN8G4IRTo2qDYHHeI+n9
	 kN3bDNrfsSSps4jzYHhZNFZCzcILlP4F4dAWmW1Ct0Lw+jnIQguvJMIZXm2nMySdUY
	 TWuPwUApJ6c3H7SCvL/tM/a5iiixAypePkZ8D4/w/fSSoUpl7uGJKdF2YguoGNmjvp
	 rJWglLBBHHHRSMpA+lc1Yo2r4W+rJtcjHERMPwAKoqDTgOWxma2GC5Kg7tnUVEN7Zc
	 2j0jV9KSxkxgg==
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
Subject: [PATCH v1 0/7] perf tools: Fix NULL derefs, OOB reads, use-after-free, and memory leaks
Date: Sat,  6 Jun 2026 17:05:52 -0300
Message-ID: <20260606200601.1861227-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Fifth batch of pre-existing bugs found by sashiko-bot during AI-assisted
review of the perf-data-validation hardening series.  All are independent
of that series -- they are latent bugs in surrounding code exposed during
review.

  1. perf_mmap__aio_mmap() sets nr_cblocks before allocating arrays.
     If calloc() fails, cleanup dereferences NULL map->aio.data.

  2. env->cpu can be NULL when reading old-format perf.data that
     predates topology info (process_cpu_topology() frees it while
     nr_cpus_avail remains set).  The six topology aggregation
     callbacks in builtin-stat.c dereference NULL.  Introduces
     perf_env__get_cpu_topology() accessor with the NULL/bounds guard.

  3. he__get_c2c_hists() error path frees hists without clearing
     c2c_he->hists.  Teardown finds the dangling pointer and calls
     hists__delete_entries() on freed memory.

  4. cpu2y() indexes topology_map[] without bounds check.  Also fixes
     str_to_bitmap() where perf_cpu_map__new("") returns cpu.cpu == -1,
     bypassing the signed >= nr_cpus check and calling __set_bit(-1, ...).

  5. set_max_cpu_num() assigns sysfs CPU count to int16_t max_cpu_num
     without clamping.  Systems with >32767 possible CPUs silently
     truncate to negative, causing undersized allocations.  Also makes
     max_present_cpu_num clamp consistently instead of erroring.

  6. free_idle_threads() calls free() on the thread priv without
     deep-freeing callchain cursor nodes or callchain root entries
     allocated during --idle-hist processing.  Introduces
     callchain_cursor_cleanup() for the cursor node linked list.

  7. Documents the struct perf_cpu int16_t limitation as a libperf
     ABI constraint, and creates tools/lib/perf/TODO to collect
     items that require a future ABI bump.

All require crafted or unusual perf.data inputs to trigger (except
patch 6 which is a memory leak on normal --idle-hist runs, and patch 7
which is documentation only).

Verified with gcc and clang builds, checkpatch, and perf test.

Arnaldo Carvalho de Melo (7):
  perf mmap: Fix NULL deref in aio cleanup on alloc failure
  perf stat: Introduce perf_env__get_cpu_topology() to guard NULL env->cpu
  perf c2c: Fix use-after-free in he__get_c2c_hists() error path
  perf timechart: Fix cpu2y() OOB read on untrusted CPU index
  perf tools: Fix int16_t truncation of max_cpu_num in set_max_cpu_num()
  perf sched: Free callchain nodes in idle thread cleanup
  libperf: Document struct perf_cpu int16_t ABI limitation

 tools/lib/perf/TODO                  | 22 ++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h |  8 +++++-
 tools/perf/builtin-c2c.c             |  1 +
 tools/perf/builtin-sched.c           |  5 +++-
 tools/perf/builtin-stat.c            | 51 ++++++++++++++++++++----------------
 tools/perf/util/callchain.c          | 15 +++++++++++
 tools/perf/util/callchain.h          |  1 +
 tools/perf/util/cpumap.c             | 21 ++++++++++++---
 tools/perf/util/env.h                | 14 ++++++++++
 tools/perf/util/mmap.c               | 10 ++++---
 tools/perf/util/svghelper.c          | 10 ++++---
 11 files changed, 121 insertions(+), 37 deletions(-)
 create mode 100644 tools/lib/perf/TODO

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks,

- Arnaldo
