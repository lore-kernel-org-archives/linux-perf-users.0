Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB337D135;
	Fri,  5 Jun 2026 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702726; cv=none; b=pbtdKYXeQUYsJxzz7ijwUXO8BGQw9FII9xfQ77Wk96NfZCY+ybTopJy7LoMcOEBiJkddtushck+ZgXznieOYXflS4q/VTs/1EYu1ZMi1bEnks/8OnMJbsxp14kOvXE0MsjnuhUum2cGLEem+MtSUfRBADbaGYZzrDwGng+Ra9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702726; c=relaxed/simple;
	bh=oomnrPseVaWqlrCznV9anODPQh2KLZqvoAI5STGYdVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a+YBmWtLhoHsxaqXFrGD+Fmu4LWy+mVJnsmtvylsjBpGUoGJqE53bfLFAiv5Yg31qKjaAjJg8l0nt8LGnXNl3Z99x8UiPoUatVuk7dQqJoFmDBKEaO5kKCTbiewfSGI+PDutYnXWJV7avuWDey8B9Un+UhPIXJ8ky1GL/cLpvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHRGgPLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHRGgPLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FABE1F00893;
	Fri,  5 Jun 2026 23:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702725;
	bh=2phxDc4dYAiH/i/I1uESmE1l6OWIYvs3a7LCNE9JFYs=;
	h=From:To:Cc:Subject:Date;
	b=FHRGgPLKujvqA1Y+VofJ4BTpqC4skg02Vc4t2I8LcNVs950x7dF9n3FyCgEj1RdhK
	 rWHtaxAoVafCELRQwp1KJyG7/zrPtbs9xA65lBczZzNl7COx7DVVlu4DwDsP5gf4t5
	 LaMx3W87W59d0257Hf+xCr0JHg+QQhnekVZEKwOyUPiwkfiqVSLcHSZb7JfhvMu+JQ
	 RuyVG0tWm8mp+odR7aLHLZzhaO8RK2CbkMGfH2zLYHrKBGVEMBz0JkkPyE36JJKlyV
	 JGxcF0S98AoP7vLoqdLUabA/hGk0FYe/EvOCuuDdKaA6HMzk4tzMQcpsZEChMTSOtU
	 ik3z/fBPuJJuQ==
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
Subject: [PATCHES v2 0/9] perf tools: Fix OOB writes, refcount bugs, and BUG_ON in mmap/stat/c2c/sched
Date: Fri,  5 Jun 2026 20:38:28 -0300
Message-ID: <20260605233837.1773732-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Nine more pre-existing bugs found by sashiko-bot during AI-assisted
review of the perf-data-validation hardening series.  All are
independent of that series -- they are latent bugs in surrounding code
exposed during review.

  1. perf_mmap__aio_bind() passes cpu__get_node() return value to an
     unsigned long.  When -1 is returned, sign-extension to ULONG_MAX
     causes bitmap_zalloc(0) and a massive OOB __set_bit.

  2. Six perf_env__get_*_aggr_by_cpu() topology aggregation callbacks
     in builtin-stat.c access env->cpu[cpu.cpu] after only checking
     cpu.cpu != -1.  A CPU index from untrusted perf.data exceeding
     env->nr_cpus_avail causes OOB heap reads.

  3. perf c2c: __set_bit on cpuset/nodeset bitmaps without bounds
     checking sample->cpu and node IDs against their allocation sizes.
     Also, cpu2node[] array accessed without upper bound check.

  4. perf c2c: setup_nodes() iterates CPU maps from perf.data topology
     and uses cpu.cpu directly as index into cpu2node[] and __set_bit
     without validating against nr_cpus_avail.

  5. get_idle_thread() leaves a partially initialized thread in
     idle_threads[] when init_idle_thread() fails, causing subsequent
     calls to return a thread with no priv data -- later cast to a
     larger struct causes OOB writes.

  6. timehist_sched_change_event() uses thread__tid() == 0 to guard
     a cast from thread_runtime to idle_thread_runtime.  A crafted
     perf.data with common_pid=0 but prev_pid!=0 gets a machine
     thread with thread_runtime priv -- the cast reads past the
     allocation.

  7. timehist_sched_change_event() sets itr->last_thread to NULL
     without calling thread__put() first, leaking a thread reference
     on every idle context switch with --idle-hist.

  8. free_idle_threads() calls thread__delete() directly instead of
     thread__put(), bypassing the refcount lifecycle.

  9. get_new_event() dereferences unchecked zalloc() result and uses
     BUG_ON on realloc failure.  add_sched_event_wakeup() passes
     unchecked zalloc() to sem_init().  All crash on OOM with
     untrusted input.

All require crafted or unusual perf.data inputs to trigger.
Verified with gcc and clang builds, checkpatch, and perf test.

Arnaldo Carvalho de Melo (9):
  perf mmap: Guard cpu__get_node() return in aio_bind()
  perf stat: Bounds-check CPU index in topology aggregation callbacks
  perf c2c: Bounds-check CPU and node IDs before bitmap and array access
  perf c2c: Bounds-check CPU IDs in setup_nodes() topology loop
  perf sched: Clean up idle_threads entry on init failure
  perf sched: Use is_idle_sample() for idle thread runtime cast guard
  perf sched: Fix thread reference leak in idle hist processing
  perf sched: Use thread__put() in free_idle_threads()
  perf sched: Replace BUG_ON and add NULL checks in replay event helpers

 tools/perf/builtin-c2c.c   | 23 +++++++++++++++++++++--
 tools/perf/builtin-sched.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 tools/perf/builtin-stat.c  | 13 +++++++------
 tools/perf/util/mmap.c     |  8 +++++++-
 4 files changed, 73 insertions(+), 16 deletions(-)

Developed with AI assistance (Claude/sashiko), tagged in commits.

v2:
  - New patch 6: use is_idle_sample() instead of thread__tid() == 0
    to guard idle_thread_runtime cast, preventing OOB read/arbitrary
    free with crafted common_pid=0/prev_pid!=0 events (sashiko Critical
    on v1 patch 6)
  - Patch 3: add cpu < 0 check to catch large u32 sample->cpu values
    that wrap negative when assigned to signed int, bypassing the
    >= cpus_cnt bounds check (sashiko High on v1 patch 3)

Thanks,

- Arnaldo
