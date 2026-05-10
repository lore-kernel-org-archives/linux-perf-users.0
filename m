Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB6284682;
	Sun, 10 May 2026 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384221; cv=none; b=oLzW7ysf/ZRCoNX6iwFxZbq5iQB/nFWsRztApTVRysIX5rU7nXJ3Dow21XGQeiwr0BUMpFBV/f/e+A/dqHTCnF2p1ylZqfLgDVVEdTpVsJy4gZSlGgqYujoy3+3QGfptO8TNNR8ANk7nkuPjT+vSZUm2sXP5LirqJ1OZ7JTbjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384221; c=relaxed/simple;
	bh=OxiYtueaUwtD6LMPKL557/3miX7XjO9SYu8JPtHC5Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOiUapwcr9fkzwUwIDAuawJgfu/TL6UjWmGC5quWMDBNJeqpYLYIXjnraLthBarjFp2bODVA7am6U6D8+X3DeMmAMEiTMixxqNaZc8M2xZDnkrLXnlkZXLbfvIpw50kh3tcphP2tfgiHXbct7Da9ZNL6f0qJXdxDT6+elq4Clhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odGO7vBu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odGO7vBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E692C2BCF6;
	Sun, 10 May 2026 03:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384220;
	bh=OxiYtueaUwtD6LMPKL557/3miX7XjO9SYu8JPtHC5Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odGO7vBu+IH8+h3VYVVMza6a9BYrZ7Ao4XSGsPB980d0gubN2ClWSpKa8vXyuUugc
	 CtwXlAypXTbpqM8Qk89g4y0WlcH5ohRCV+poP51lkRvSF4uehyP3rKIiTgzatcWxeY
	 uAgAKxgeO5KVzG5DOdpdUju+iKEIZfYmcEuL2h992XxP87mqbwk5aIxpAomYIu/usG
	 LNzgYLn8DsZjqW+9amLRAPIsUDl93tywdxqRSKfDqa/yA3YIDhjFKAVT4ss1f7rkUz
	 Nslj4dGemUbyx9EAnwaVBfrvxw/QwUjf+1c5jihDQ3FB4Mm6Z2Z6x5s0mk7/9I1WYj
	 cDDxkVgULsB8Q==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 26/28] perf timechart: Bounds check cpu_id and fix topology_map allocation
Date: Sun, 10 May 2026 00:34:17 -0300
Message-ID: <20260510033424.255812-27-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The cpu_idle, cpu_frequency, power_start, and power_frequency
tracepoint handlers extract cpu_id from the event payload via
evsel__intval() and use it directly as an array index into
cpus_cstate_start_times[] and cpus_pstate_start_times[], which
are allocated with MAX_CPUS (4096) entries.

Unlike sample->cpu which is validated in perf_session__deliver_event(),
cpu_id comes from the tracepoint data and is never bounds checked.
A crafted perf.data with a malicious cpu_id in a tracepoint event
causes out-of-bounds array accesses.

Validate cpu_id against tchart->numcpus (nr_cpus_avail from the
file header) and reject the event with an error if it is out of
range, as this indicates a corrupted or crafted file.

The power_end handler uses sample->cpu (not a tracepoint cpu_id
field).  Add a bounds check there too since a crafted file could
omit PERF_SAMPLE_CPU, leaving sample->cpu as the (u32)-1 sentinel
which would cause out-of-bounds access in c_state_end().

Also validate sample->cpu in sched_switch and sched_wakeup
handlers, which store it in cpu_sample structs later used as
array indices into topology_map[] during SVG generation.

Fix svg_build_topology_map() to allocate topology_map using
nr_cpus_avail instead of nr_cpus_online.  When offline CPUs exist,
nr_cpus_online < nr_cpus_avail, and a valid cpu_id that passes
the numcpus check could still exceed the topology_map allocation,
causing a heap out-of-bounds read in cpu2y().  Reject negative CPU
values in str_to_bitmap() to prevent perf_cpu_map__new("") on an
empty topology string from passing -1 to __set_bit(), which would
write at offset ULONG_MAX/BITS_PER_LONG.

Fix the pre-existing backtrace memory leak: change the
tracepoint_handler typedef to pass const char **backtrace
(pointer-to-pointer).  Handlers that consume the string
(sched_switch, sched_wakeup) set *backtrace = NULL to claim
ownership.  The caller always calls free() after the handler
returns — if ownership was taken the pointer is NULL and
free(NULL) is a no-op.  Skip cat_backtrace() entirely when
tchart->with_backtrace is not set.

Cap tchart->numcpus at MAX_CPUS in the HEADER_NRCPUS callback
so the bounds check cannot exceed the array allocation size.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c | 115 ++++++++++++++++++++++++++++-----
 tools/perf/util/svghelper.c    |   6 +-
 2 files changed, 104 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 40297f2dcd0353cc..bccc48cfb99a1d57 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -71,6 +71,7 @@ struct timechart {
 	bool			io_only,
 				skip_eagain;
 	u64			io_events;
+	u32			nr_invalid_cpu;
 	u64			min_time,
 				merge_dist;
 };
@@ -569,7 +570,7 @@ static const char *cat_backtrace(union perf_event *event,
 typedef int (*tracepoint_handler)(struct timechart *tchart,
 				  struct evsel *evsel,
 				  struct perf_sample *sample,
-				  const char *backtrace);
+				  const char **backtrace);
 
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event,
@@ -588,22 +589,46 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		return f(tchart, evsel, sample,
-			 cat_backtrace(event, sample, machine));
+		const char *bt = NULL;
+		int ret;
+
+		if (tchart->with_backtrace)
+			bt = cat_backtrace(event, sample, machine);
+		ret = f(tchart, evsel, sample, &bt);
+		/*
+		 * Handlers that consume backtrace (sched_switch,
+		 * sched_wakeup) store the pointer and set *bt = NULL
+		 * to claim ownership.  For all other handlers bt is
+		 * still ours to free.  free(NULL) is safe.
+		 */
+		free((void *)bt);
+		return ret;
 	}
 
 	return 0;
 }
 
 static int
-process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
+process_sample_cpu_idle(struct timechart *tchart,
 			struct evsel *evsel,
 			struct perf_sample *sample,
-			const char *backtrace __maybe_unused)
+			const char **backtrace __maybe_unused)
 {
 	u32 state  = evsel__intval(evsel, sample, "state");
 	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
 
+	/*
+	 * cpu_id from tracepoint data indexes cpus_cstate_start_times[]
+	 * and cpus_pstate_start_times[], both allocated as MAX_CPUS
+	 * entries.  Reject out-of-range values to prevent OOB writes;
+	 * numcpus (from nr_cpus_avail) is the tighter, valid bound.
+	 */
+	if (cpu_id >= tchart->numcpus) {
+		pr_err("cpu_idle event cpu_id %u >= nr_cpus_avail %u\n",
+		       cpu_id, tchart->numcpus);
+		return -EINVAL;
+	}
+
 	if (state == (u32)PWR_EVENT_EXIT)
 		c_state_end(tchart, cpu_id, sample->time);
 	else
@@ -615,11 +640,18 @@ static int
 process_sample_cpu_frequency(struct timechart *tchart,
 			     struct evsel *evsel,
 			     struct perf_sample *sample,
-			     const char *backtrace __maybe_unused)
+			     const char **backtrace __maybe_unused)
 {
 	u32 state  = evsel__intval(evsel, sample, "state");
 	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
 
+	/* Same bounds check as process_sample_cpu_idle — see comment there */
+	if (cpu_id >= tchart->numcpus) {
+		pr_err("cpu_frequency event cpu_id %u >= nr_cpus_avail %u\n",
+		       cpu_id, tchart->numcpus);
+		return -EINVAL;
+	}
+
 	p_state_change(tchart, cpu_id, sample->time, state);
 	return 0;
 }
@@ -628,13 +660,20 @@ static int
 process_sample_sched_wakeup(struct timechart *tchart,
 			    struct evsel *evsel,
 			    struct perf_sample *sample,
-			    const char *backtrace)
+			    const char **backtrace)
 {
 	u8 flags  = evsel__intval(evsel, sample, "common_flags");
 	int waker = evsel__intval(evsel, sample, "common_pid");
 	int wakee = evsel__intval(evsel, sample, "pid");
 
-	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
+	/* sample->cpu used as index into topology_map[] during SVG generation */
+	if (sample->cpu >= tchart->numcpus) {
+		tchart->nr_invalid_cpu++;
+		return 0;
+	}
+
+	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, *backtrace);
+	*backtrace = NULL;
 	return 0;
 }
 
@@ -642,27 +681,41 @@ static int
 process_sample_sched_switch(struct timechart *tchart,
 			    struct evsel *evsel,
 			    struct perf_sample *sample,
-			    const char *backtrace)
+			    const char **backtrace)
 {
 	int prev_pid   = evsel__intval(evsel, sample, "prev_pid");
 	int next_pid   = evsel__intval(evsel, sample, "next_pid");
 	u64 prev_state = evsel__intval(evsel, sample, "prev_state");
 
+	/* sample->cpu used as index into topology_map[] during SVG generation */
+	if (sample->cpu >= tchart->numcpus) {
+		tchart->nr_invalid_cpu++;
+		return 0;
+	}
+
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
-		     prev_state, backtrace);
+		     prev_state, *backtrace);
+	*backtrace = NULL;
 	return 0;
 }
 
 #ifdef SUPPORT_OLD_POWER_EVENTS
 static int
-process_sample_power_start(struct timechart *tchart __maybe_unused,
+process_sample_power_start(struct timechart *tchart,
 			   struct evsel *evsel,
 			   struct perf_sample *sample,
-			   const char *backtrace __maybe_unused)
+			   const char **backtrace __maybe_unused)
 {
 	u64 cpu_id = evsel__intval(evsel, sample, "cpu_id");
 	u64 value  = evsel__intval(evsel, sample, "value");
 
+	/* Same bounds check as process_sample_cpu_idle — see comment there */
+	if (cpu_id >= tchart->numcpus) {
+		pr_err("power_start event cpu_id %" PRIu64 " >= nr_cpus_avail %u\n",
+		       cpu_id, tchart->numcpus);
+		return -EINVAL;
+	}
+
 	c_state_start(cpu_id, sample->time, value);
 	return 0;
 }
@@ -671,8 +724,16 @@ static int
 process_sample_power_end(struct timechart *tchart,
 			 struct evsel *evsel __maybe_unused,
 			 struct perf_sample *sample,
-			 const char *backtrace __maybe_unused)
+			 const char **backtrace __maybe_unused)
 {
+	/*
+	 * sample->cpu is validated centrally when PERF_SAMPLE_CPU is
+	 * set, but a crafted file could omit it from sample_type.
+	 */
+	if (sample->cpu >= tchart->numcpus) {
+		tchart->nr_invalid_cpu++;
+		return 0;
+	}
 	c_state_end(tchart, sample->cpu, sample->time);
 	return 0;
 }
@@ -681,11 +742,18 @@ static int
 process_sample_power_frequency(struct timechart *tchart,
 			       struct evsel *evsel,
 			       struct perf_sample *sample,
-			       const char *backtrace __maybe_unused)
+			       const char **backtrace __maybe_unused)
 {
 	u64 cpu_id = evsel__intval(evsel, sample, "cpu_id");
 	u64 value  = evsel__intval(evsel, sample, "value");
 
+	/* Same bounds check as process_sample_cpu_idle — see comment there */
+	if (cpu_id >= tchart->numcpus) {
+		pr_err("power_frequency event cpu_id %" PRIu64 " >= nr_cpus_avail %u\n",
+		       cpu_id, tchart->numcpus);
+		return -EINVAL;
+	}
+
 	p_state_change(tchart, cpu_id, sample->time, value);
 	return 0;
 }
@@ -1519,7 +1587,8 @@ static int process_header(struct perf_file_section *section __maybe_unused,
 
 	switch (feat) {
 	case HEADER_NRCPUS:
-		tchart->numcpus = ph->env.nr_cpus_avail;
+		/* Cap at MAX_CPUS — the allocation size of cpus_cstate/pstate arrays */
+		tchart->numcpus = min((int)ph->env.nr_cpus_avail, MAX_CPUS);
 		break;
 
 	case HEADER_CPU_TOPOLOGY:
@@ -1625,6 +1694,16 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 					    tchart,
 					    process_header);
 
+	/*
+	 * Truncated files (interrupted recording) lose all feature
+	 * sections so the HEADER_NRCPUS callback never fires, and
+	 * pipe mode doesn't use perf_header__process_sections at all.
+	 * Fall back to MAX_CPUS — the actual allocation size of the
+	 * cpus_cstate/pstate arrays.
+	 */
+	if (!tchart->numcpus)
+		tchart->numcpus = MAX_CPUS;
+
 	if (!perf_session__has_traces(session, "timechart record"))
 		goto out_delete;
 
@@ -1646,6 +1725,12 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 
 	pr_info("Written %2.1f seconds of trace to %s.\n",
 		(tchart->last_time - tchart->first_time) / (double)NSEC_PER_SEC, output_name);
+
+	if (tchart->nr_invalid_cpu) {
+		pr_warning("WARNING: %u events had invalid CPU values and were skipped.\n"
+			   "  Scheduling and power state data may be incomplete.\n",
+			   tchart->nr_invalid_cpu);
+	}
 out_delete:
 	perf_session__delete(session);
 	return ret;
diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index e360e7736c7ba65b..a3c7cfecc072f3e3 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -736,7 +736,8 @@ static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
 		return -1;
 
 	perf_cpu_map__for_each_cpu(cpu, idx, map) {
-		if (cpu.cpu >= nr_cpus) {
+		/* perf_cpu_map__new("") yields cpu=-1; reject to prevent __set_bit OOB */
+		if (cpu.cpu < 0 || cpu.cpu >= nr_cpus) {
 			ret = -1;
 			break;
 		}
@@ -756,7 +757,8 @@ int svg_build_topology_map(struct perf_env *env)
 	char *sib_core, *sib_thr;
 	int ret = -1;
 
-	nr_cpus = min(env->nr_cpus_online, MAX_NR_CPUS);
+	/* Use nr_cpus_avail: offline CPUs still need slots in the topology map */
+	nr_cpus = min(env->nr_cpus_avail, MAX_NR_CPUS);
 
 	t.sib_core_nr = env->nr_sibling_cores;
 	t.sib_thr_nr = env->nr_sibling_threads;
-- 
2.54.0

