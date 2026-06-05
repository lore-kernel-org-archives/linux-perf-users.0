Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6777404E;
	Fri,  5 Jun 2026 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691607; cv=none; b=qFSS0gXzvnNuH7A/38GGgE/8M4tKy0atdVdhEIuYs3gkM/NL5RmICtWzTzzGO3S+ghZsvNZ5Umz/+m+lEqd/kzj7CwVBteWonUZBTEtZ8hNo9bKR2nkR0OQRyX8LS8tpoIrWPeoQc3CgzCZ1x0Oz9RgvecuJBGwCN0AsGmPh4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691607; c=relaxed/simple;
	bh=grEwOPSZPzAALEEWfZVz0q+rTuXeAmMcrWfLALaKKFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eaQd2xD0hmF1+3uXRIajGvWb0Sk5AXgiGGBDfR/va395hGdPlE/fKn1snUarjQ5HtXt/0X+ABxDdqTPIbEwcAcvUM5EdWo2UUmqE3SqWWtV/k+VnMjj6bwyVE1/Ls4Cst7bAm4Cfrg5KN/vhMHXRIclzctlnRkeF+F/SJfZB1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIS9IPmp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIS9IPmp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CB91F00893;
	Fri,  5 Jun 2026 20:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780691605;
	bh=+NP6pN9moUoS8gpaa1zfFl+PZdxP/Uo/p01xJinHvCQ=;
	h=From:To:Cc:Subject:Date;
	b=OIS9IPmpXhKXOyxKIcqlA17Wz/nJus2S9vbOo+n5AhUe7WEYBcr9I0WD1kFz65iP9
	 56bRF/Ev4i55PFivrfd9Mdt0pI/a3m1pmc8nwd3aKzf5GcrcFDDLwgZF61bhaFqBN0
	 kViKCNqdf0gcam+PIayWZAxzBF6hYqyxxkyhqmKNd39NfIuF4L9jVAr+3k11pnaIGn
	 /vJevnMBnvCmnehvoikGDcfQ0oY8z45TDUJ7v3XkXmZNJMNeBW6BhkGoLo+YVPRc54
	 hCVaf3KWPoMrIrLLz05G/jyvd0wqELLnwsGp957SOfDb3Tg4bj6/BEUxXXA8CQ7NaW
	 APynC2hvoStXw==
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
Subject: [PATCHES v1 0/8] perf tools: Fix OOB writes, refcount bugs, and BUG_ON in mmap/stat/c2c/sched
Date: Fri,  5 Jun 2026 17:33:08 -0300
Message-ID: <20260605203316.1758661-1-acme@kernel.org>
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

Eight more pre-existing bugs found by sashiko-bot during AI-assisted
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

  6. timehist_sched_change_event() sets itr->last_thread to NULL
     without calling thread__put() first, leaking a thread reference
     on every idle context switch with --idle-hist.

  7. free_idle_threads() calls thread__delete() directly instead of
     thread__put(), bypassing the refcount lifecycle.

  8. get_new_event() dereferences unchecked zalloc() result and uses
     BUG_ON on realloc failure.  add_sched_event_wakeup() passes
     unchecked zalloc() to sem_init().  All crash on OOM with
     untrusted input.

All require crafted or unusual perf.data inputs to trigger.
Verified with gcc and clang builds, checkpatch, and perf test.

Arnaldo Carvalho de Melo (8):
  perf mmap: Guard cpu__get_node() return in aio_bind()
  perf stat: Bounds-check CPU index in topology aggregation callbacks
  perf c2c: Bounds-check CPU and node IDs before bitmap and array access
  perf c2c: Bounds-check CPU IDs in setup_nodes() topology loop
  perf sched: Clean up idle_threads entry on init failure
  perf sched: Fix thread reference leak in idle hist processing
  perf sched: Use thread__put() in free_idle_threads()
  perf sched: Replace BUG_ON and add NULL checks in replay event helpers

 tools/perf/builtin-c2c.c   | 23 +++++++++++++++++++++--
 tools/perf/builtin-sched.c | 37 +++++++++++++++++++++++++++++++------
 tools/perf/builtin-stat.c  | 13 +++++++------
 tools/perf/util/mmap.c     |  8 +++++++-
 4 files changed, 66 insertions(+), 15 deletions(-)

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks,

- Arnaldo
