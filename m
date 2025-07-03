Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041BE1DB346;
	Thu,  3 Jul 2025 01:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507386; cv=none; b=E8SraMek8z9lMiF7GmNYJzRCAKhcOcZO12HSI1JGRqfHbkUFbtZYKz57AVARO4EsoAbVrqAZpOW+9xwTXURspzFmnA41nmuv6H3mg7S9Xi0wRcnlkVdpau5+Am/DYETiNFm3EdcU/5GPNO090xq8h9m4Dk6z2brOf/PW2mAp0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507386; c=relaxed/simple;
	bh=X4NV6G18FdzyzBwiRrfRrm4NvowTBnkgrW9f4n3GILw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUVnljDoxWsRcTd6hQd6ZfbqPWyKKqX3DH0Gnwq+mCxZTFH1YD8SL6kRfU4+wBBVjIUV0bCQOeXUhodtyYmKXhFFtIL6v/0wZbCpaylSBeBevlsXOPHjszXnPd/bx4Ke2VMjGTZtPB9ZJe5G8gfATGvFMNe530slq6MxYktE3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg5/IrHz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg5/IrHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2964C4CEE7;
	Thu,  3 Jul 2025 01:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751507385;
	bh=X4NV6G18FdzyzBwiRrfRrm4NvowTBnkgrW9f4n3GILw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fg5/IrHzbk+tlq4J5jHHqQkvqiaHNVFXD4UJP10jArnzloZASWD8Vej0H2UNLq0JC
	 OtK1qxzKhtCFNeg1wIJMyzc7mbqUgiTEZAIOKrad+an7T1+2EwcNpnIWDwOzQu/caj
	 GRuZe0xtxutTPs0RUB5fLlQI5Y2GfzkXYlVABfkZ+HKx2b8D7UYGU54NSGDb1e+I6a
	 tfLGS5ZN3y2WdOz53ZmO5DKPkq9RQVBdQZfJ8pmCa6hKQEk+G1v2sWZN//U1MgPYC4
	 f/szS9zB5McZA7OzjyVnfR4P8JbfU1JSDk+Qecyw8gx37eAOJQt8DCzKMlKFZKbfBJ
	 Bkz/yqhA22MUg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/8] perf sched: Fix thread leaks in 'perf sched timehist'
Date: Wed,  2 Jul 2025 18:49:38 -0700
Message-ID: <20250703014942.1369397-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250703014942.1369397-1-namhyung@kernel.org>
References: <20250703014942.1369397-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing thread__put() after machine__findnew_thread() or
timehist_get_thread().  Also idle threads' last_thread should be
refcounted properly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 48 +++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b73989fb6acef8d6..83b5a85a91b7ffbd 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2313,8 +2313,10 @@ static void save_task_callchain(struct perf_sched *sched,
 		return;
 	}
 
-	if (!sched->show_callchain || sample->callchain == NULL)
+	if (!sched->show_callchain || sample->callchain == NULL) {
+		thread__put(thread);
 		return;
+	}
 
 	cursor = get_tls_callchain_cursor();
 
@@ -2323,10 +2325,12 @@ static void save_task_callchain(struct perf_sched *sched,
 		if (verbose > 0)
 			pr_err("Failed to resolve callchain. Skipping\n");
 
+		thread__put(thread);
 		return;
 	}
 
 	callchain_cursor_commit(cursor);
+	thread__put(thread);
 
 	while (true) {
 		struct callchain_cursor_node *node;
@@ -2403,8 +2407,17 @@ static void free_idle_threads(void)
 		return;
 
 	for (i = 0; i < idle_max_cpu; ++i) {
-		if ((idle_threads[i]))
-			thread__delete(idle_threads[i]);
+		struct thread *idle = idle_threads[i];
+
+		if (idle) {
+			struct idle_thread_runtime *itr;
+
+			itr = thread__priv(idle);
+			if (itr)
+				thread__put(itr->last_thread);
+
+			thread__delete(idle);
+		}
 	}
 
 	free(idle_threads);
@@ -2441,7 +2454,7 @@ static struct thread *get_idle_thread(int cpu)
 		}
 	}
 
-	return idle_threads[cpu];
+	return thread__get(idle_threads[cpu]);
 }
 
 static void save_idle_callchain(struct perf_sched *sched,
@@ -2496,7 +2509,8 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 			if (itr == NULL)
 				return NULL;
 
-			itr->last_thread = thread;
+			thread__put(itr->last_thread);
+			itr->last_thread = thread__get(thread);
 
 			/* copy task callchain when entering to idle */
 			if (evsel__intval(evsel, sample, "next_pid") == 0)
@@ -2567,6 +2581,7 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
 	/* show wakeup unless both awakee and awaker are filtered */
 	if (timehist_skip_sample(sched, thread, evsel, sample) &&
 	    timehist_skip_sample(sched, awakened, evsel, sample)) {
+		thread__put(thread);
 		return;
 	}
 
@@ -2583,6 +2598,8 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
 	printf("awakened: %s", timehist_get_commstr(awakened));
 
 	printf("\n");
+
+	thread__put(thread);
 }
 
 static int timehist_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unused,
@@ -2611,8 +2628,10 @@ static int timehist_sched_wakeup_event(const struct perf_tool *tool,
 		return -1;
 
 	tr = thread__get_runtime(thread);
-	if (tr == NULL)
+	if (tr == NULL) {
+		thread__put(thread);
 		return -1;
+	}
 
 	if (tr->ready_to_run == 0)
 		tr->ready_to_run = sample->time;
@@ -2622,6 +2641,7 @@ static int timehist_sched_wakeup_event(const struct perf_tool *tool,
 	    !perf_time__skip_sample(&sched->ptime, sample->time))
 		timehist_print_wakeup_event(sched, evsel, sample, machine, thread);
 
+	thread__put(thread);
 	return 0;
 }
 
@@ -2649,6 +2669,7 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 
 	if (timehist_skip_sample(sched, thread, evsel, sample) &&
 	    timehist_skip_sample(sched, migrated, evsel, sample)) {
+		thread__put(thread);
 		return;
 	}
 
@@ -2676,6 +2697,7 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 	printf(" cpu %d => %d", ocpu, dcpu);
 
 	printf("\n");
+	thread__put(thread);
 }
 
 static int timehist_migrate_task_event(const struct perf_tool *tool,
@@ -2695,8 +2717,10 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
 		return -1;
 
 	tr = thread__get_runtime(thread);
-	if (tr == NULL)
+	if (tr == NULL) {
+		thread__put(thread);
 		return -1;
+	}
 
 	tr->migrations++;
 	tr->migrated = sample->time;
@@ -2706,6 +2730,7 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
 		timehist_print_migration_event(sched, evsel, sample,
 							machine, thread);
 	}
+	thread__put(thread);
 
 	return 0;
 }
@@ -2728,10 +2753,10 @@ static void timehist_update_task_prio(struct evsel *evsel,
 		return;
 
 	tr = thread__get_runtime(thread);
-	if (tr == NULL)
-		return;
+	if (tr != NULL)
+		tr->prio = next_prio;
 
-	tr->prio = next_prio;
+	thread__put(thread);
 }
 
 static int timehist_sched_change_event(const struct perf_tool *tool,
@@ -2743,7 +2768,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 	struct perf_time_interval *ptime = &sched->ptime;
 	struct addr_location al;
-	struct thread *thread;
+	struct thread *thread = NULL;
 	struct thread_runtime *tr = NULL;
 	u64 tprev, t = sample->time;
 	int rc = 0;
@@ -2867,6 +2892,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 
 	evsel__save_time(evsel, sample->time, sample->cpu);
 
+	thread__put(thread);
 	addr_location__exit(&al);
 	return rc;
 }
-- 
2.50.0.727.gbf7dc18ff4-goog

