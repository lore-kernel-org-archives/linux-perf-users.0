Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365E394476
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658885; cv=none; b=cvhMkl3PiWM4y3v3ERNREcwYs/xaMoei+uz/Kr/H72IzeIwJmCHxXZUIG4kGcPDUMs04DFT24fpYjSxchDsHmfIb+fGyByo0R+DInV+o9xHKJnRyN/i1AX1Jy3MzcXPDu93lfdoCPVumiQ0Yf4F0KDQOwyyRxQt8MnXdoyG7beU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658885; c=relaxed/simple;
	bh=pf3hbkLfQCYaPaerb7OuwsGFEWPNhzZHZX22d5JrWl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lNyK/0y65CYZ0NKeopcbBt6hAyLkr7Fy7oQYSoyNXcCUWtTg4DgdKMJ+xuMywcdYbrmOlCCwe4KKoUd36thoIoIaqkyokS9/a4MpiFUUF/yf0GtcMkfg8+1fIbdkNQEYIUcooRYqKFG11yLmjiamr6RthaWydroHwHTivfuBCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Juu3OviU; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Juu3OviU"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12721cd1a2aso3223934c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658884; x=1771263684; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZWcD8vc7rMYbBbeqeGgKNcE3JGcfqrFuTREdT8pupU=;
        b=Juu3OviUmMUlB4mrlQAPLHR2uY2E1sWkrBRE91YWtOtNoKmLMLtC1fzWomLDrK1uYx
         nzBj0+jzDRS21OPt1Vame/03zOzHan1WUG+QbMHisgiLDmCoUfEqcXH4Ofi9e8ISDiiI
         HhIV+hcm/p0RezOYQfO6mRqGlcMcF0vqoMyZDUNogsLOs++adaSPQz115vfgljZCBKPM
         tRyg75AHfsKzLGEil7lsHd+NKY//+IjBGtl3jJlhGtrsaKkXMnQSIwejhefiYMWc5E/o
         erLzyCJ9ZKUKuHRNDQpwtoc+i45KXMgZqG0rp9kCgffBpbUK+cWJ7pJepDOHVx69qTLn
         56FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658884; x=1771263684;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZWcD8vc7rMYbBbeqeGgKNcE3JGcfqrFuTREdT8pupU=;
        b=xQUh+dgUUhh4KScrl5IjoiXLjKmwa+3O1sRYG5yLys6Mt8jQeYAK4Z7A4F/GeF+om+
         XBCUBeCL/jLAKrXJ1zmbRJyNNd3BnQ12XYodajbDwYj0wuzzVCH5KvROSNlDWfNTenXI
         CTMnycq7bIaJCV46R2VREYoSMwdTAfxxXRisNvM9IOMgzfFhfxFxfHR8IiI/XKwTc7gM
         xZO7RYKtXnRFUq3ZThsT0Blf1hSn6PFI54W2JKsGvrOzzl2L8rkjM4sCDZ5M/vNW56GO
         IF//cKtsIx2YXei7Cj87zmMYC5eeFWbUrXZk1flikUZ02f/rcpZdnSrnC/eH+/JtLdMF
         /vVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT2fMaxglSXRLxUM8AfYdkiuynap1UB6R+ycvWwHjNPCBxukJ0zzUuBOEPma5JBKHd1KY2hp5hVawiIk0ZfqDm@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2bDDSqgxEuPhWRtwY0Pyv4Jxz4TxLXQNkBcUtmvG6217wzoh
	nGl9zvWx+Vf6zvi5mwpC9BqBP9hz0q0Np3GzHNH50Xy5Stv4/gAskTV1B9revbkImJ+0dANI4fz
	d/Zbm46CuIA==
X-Received: from dlbeg30.prod.google.com ([2002:a05:7022:f9e:b0:123:2dd9:db4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6185:b0:123:3628:2ef9
 with SMTP id a92af1059eb24-127040739e4mr5508702c88.36.1770658883871; Mon, 09
 Feb 2026 09:41:23 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:26 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-20-irogers@google.com>
Subject: [PATCH v1 19/25] perf sched: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 92 ++++++++++++++------------------------
 1 file changed, 34 insertions(+), 58 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0580dc20720f..0f3982d6722e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -129,21 +129,20 @@ typedef int (*sort_fn_t)(struct work_atoms *, struct work_atoms *);
 struct perf_sched;
 
 struct trace_sched_handler {
-	int (*switch_event)(struct perf_sched *sched, struct evsel *evsel,
-			    struct perf_sample *sample, struct machine *machine);
+	int (*switch_event)(struct perf_sched *sched, struct perf_sample *sample,
+			    struct machine *machine);
 
-	int (*runtime_event)(struct perf_sched *sched, struct evsel *evsel,
-			     struct perf_sample *sample, struct machine *machine);
+	int (*runtime_event)(struct perf_sched *sched, struct perf_sample *sample,
+			     struct machine *machine);
 
-	int (*wakeup_event)(struct perf_sched *sched, struct evsel *evsel,
-			    struct perf_sample *sample, struct machine *machine);
+	int (*wakeup_event)(struct perf_sched *sched, struct perf_sample *sample,
+			    struct machine *machine);
 
 	/* PERF_RECORD_FORK event, not sched_process_fork tracepoint */
 	int (*fork_event)(struct perf_sched *sched, union perf_event *event,
 			  struct machine *machine);
 
 	int (*migrate_task_event)(struct perf_sched *sched,
-				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct machine *machine);
 };
@@ -826,7 +825,7 @@ static void test_calibrations(struct perf_sched *sched)
 
 static int
 replay_wakeup_event(struct perf_sched *sched,
-		    struct evsel *evsel, struct perf_sample *sample,
+		    struct perf_sample *sample,
 		    struct machine *machine __maybe_unused)
 {
 	const char *comm = perf_sample__strval(sample, "comm");
@@ -834,7 +833,7 @@ replay_wakeup_event(struct perf_sched *sched,
 	struct task_desc *waker, *wakee;
 
 	if (verbose > 0) {
-		printf("sched_wakeup event %p\n", evsel);
+		printf("sched_wakeup event %p\n", sample->evsel);
 
 		printf(" ... pid %d woke up %s/%d\n", sample->tid, comm, pid);
 	}
@@ -847,7 +846,6 @@ replay_wakeup_event(struct perf_sched *sched,
 }
 
 static int replay_switch_event(struct perf_sched *sched,
-			       struct evsel *evsel,
 			       struct perf_sample *sample,
 			       struct machine *machine __maybe_unused)
 {
@@ -861,7 +859,7 @@ static int replay_switch_event(struct perf_sched *sched,
 	s64 delta;
 
 	if (verbose > 0)
-		printf("sched_switch event %p\n", evsel);
+		printf("sched_switch event %p\n", sample->evsel);
 
 	if (cpu >= MAX_CPUS || cpu < 0)
 		return 0;
@@ -1134,7 +1132,6 @@ static void free_work_atoms(struct work_atoms *atoms)
 }
 
 static int latency_switch_event(struct perf_sched *sched,
-				struct evsel *evsel __maybe_unused,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
@@ -1204,7 +1201,6 @@ static int latency_switch_event(struct perf_sched *sched,
 }
 
 static int latency_runtime_event(struct perf_sched *sched,
-				 struct evsel *evsel __maybe_unused,
 				 struct perf_sample *sample,
 				 struct machine *machine)
 {
@@ -1239,7 +1235,6 @@ static int latency_runtime_event(struct perf_sched *sched,
 }
 
 static int latency_wakeup_event(struct perf_sched *sched,
-				struct evsel *evsel __maybe_unused,
 				struct perf_sample *sample,
 				struct machine *machine)
 {
@@ -1300,7 +1295,6 @@ static int latency_wakeup_event(struct perf_sched *sched,
 }
 
 static int latency_migrate_task_event(struct perf_sched *sched,
-				      struct evsel *evsel __maybe_unused,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
@@ -1519,20 +1513,18 @@ static void perf_sched__sort_lat(struct perf_sched *sched)
 }
 
 static int process_sched_wakeup_event(const struct perf_tool *tool,
-				      struct evsel *evsel,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 
 	if (sched->tp_handler->wakeup_event)
-		return sched->tp_handler->wakeup_event(sched, evsel, sample, machine);
+		return sched->tp_handler->wakeup_event(sched, sample, machine);
 
 	return 0;
 }
 
 static int process_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unused,
-				      struct evsel *evsel __maybe_unused,
 				      struct perf_sample *sample __maybe_unused,
 				      struct machine *machine __maybe_unused)
 {
@@ -1626,8 +1618,8 @@ static void print_sched_map(struct perf_sched *sched, struct perf_cpu this_cpu,
 	}
 }
 
-static int map_switch_event(struct perf_sched *sched, struct evsel *evsel __maybe_unused,
-			    struct perf_sample *sample, struct machine *machine)
+static int map_switch_event(struct perf_sched *sched,  struct perf_sample *sample,
+			    struct machine *machine)
 {
 	const u32 next_pid = perf_sample__intval(sample, "next_pid");
 	const u32 prev_pid = perf_sample__intval(sample, "prev_pid");
@@ -1791,7 +1783,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel __mayb
 }
 
 static int process_sched_switch_event(const struct perf_tool *tool,
-				      struct evsel *evsel,
 				      struct perf_sample *sample,
 				      struct machine *machine)
 {
@@ -1810,21 +1801,20 @@ static int process_sched_switch_event(const struct perf_tool *tool,
 	}
 
 	if (sched->tp_handler->switch_event)
-		err = sched->tp_handler->switch_event(sched, evsel, sample, machine);
+		err = sched->tp_handler->switch_event(sched, sample, machine);
 
 	sched->curr_pid[this_cpu] = next_pid;
 	return err;
 }
 
 static int process_sched_runtime_event(const struct perf_tool *tool,
-				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 
 	if (sched->tp_handler->runtime_event)
-		return sched->tp_handler->runtime_event(sched, evsel, sample, machine);
+		return sched->tp_handler->runtime_event(sched, sample, machine);
 
 	return 0;
 }
@@ -1847,20 +1837,18 @@ static int perf_sched__process_fork_event(const struct perf_tool *tool,
 }
 
 static int process_sched_migrate_task_event(const struct perf_tool *tool,
-					    struct evsel *evsel,
 					    struct perf_sample *sample,
 					    struct machine *machine)
 {
 	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
 
 	if (sched->tp_handler->migrate_task_event)
-		return sched->tp_handler->migrate_task_event(sched, evsel, sample, machine);
+		return sched->tp_handler->migrate_task_event(sched, sample, machine);
 
 	return 0;
 }
 
 typedef int (*tracepoint_handler)(const struct perf_tool *tool,
-				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct machine *machine);
 
@@ -1874,7 +1862,7 @@ static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		err = f(tool, evsel, sample, machine);
+		err = f(tool, sample, machine);
 	}
 
 	return err;
@@ -2313,11 +2301,10 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 	r->total_pre_mig_time += r->dt_pre_mig;
 }
 
-static bool is_idle_sample(struct perf_sample *sample,
-			   struct evsel *evsel)
+static bool is_idle_sample(struct perf_sample *sample)
 {
 	/* pid 0 == swapper == idle task */
-	if (evsel__name_is(evsel, "sched:sched_switch"))
+	if (evsel__name_is(sample->evsel, "sched:sched_switch"))
 		return perf_sample__intval(sample, "prev_pid") == 0;
 
 	return sample->pid == 0;
@@ -2499,12 +2486,11 @@ static void save_idle_callchain(struct perf_sched *sched,
 
 static struct thread *timehist_get_thread(struct perf_sched *sched,
 					  struct perf_sample *sample,
-					  struct machine *machine,
-					  struct evsel *evsel)
+					  struct machine *machine)
 {
 	struct thread *thread;
 
-	if (is_idle_sample(sample, evsel)) {
+	if (is_idle_sample(sample)) {
 		thread = get_idle_thread(sample->cpu);
 		if (thread == NULL)
 			pr_err("Failed to get idle thread for cpu %d.\n", sample->cpu);
@@ -2547,7 +2533,6 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 
 static bool timehist_skip_sample(struct perf_sched *sched,
 				 struct thread *thread,
-				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	bool rc = false;
@@ -2569,7 +2554,7 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 		tr = thread__get_runtime(thread);
 		if (tr && tr->prio != -1)
 			prio = tr->prio;
-		else if (evsel__name_is(evsel, "sched:sched_switch"))
+		else if (evsel__name_is(sample->evsel, "sched:sched_switch"))
 			prio = perf_sample__intval(sample, "prev_prio");
 
 		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
@@ -2579,7 +2564,7 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 	}
 
 	if (sched->idle_hist) {
-		if (!evsel__name_is(evsel, "sched:sched_switch"))
+		if (!evsel__name_is(sample->evsel, "sched:sched_switch"))
 			rc = true;
 		else if (perf_sample__intval(sample, "prev_pid") != 0 &&
 			 perf_sample__intval(sample, "next_pid") != 0)
@@ -2590,7 +2575,6 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 }
 
 static void timehist_print_wakeup_event(struct perf_sched *sched,
-					struct evsel *evsel,
 					struct perf_sample *sample,
 					struct machine *machine,
 					struct thread *awakened)
@@ -2603,8 +2587,8 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
 		return;
 
 	/* show wakeup unless both awakee and awaker are filtered */
-	if (timehist_skip_sample(sched, thread, evsel, sample) &&
-	    timehist_skip_sample(sched, awakened, evsel, sample)) {
+	if (timehist_skip_sample(sched, thread, sample) &&
+	    timehist_skip_sample(sched, awakened, sample)) {
 		thread__put(thread);
 		return;
 	}
@@ -2628,7 +2612,6 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
 
 static int timehist_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unused,
 					union perf_event *event __maybe_unused,
-					struct evsel *evsel __maybe_unused,
 					struct perf_sample *sample __maybe_unused,
 					struct machine *machine __maybe_unused)
 {
@@ -2637,7 +2620,6 @@ static int timehist_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unu
 
 static int timehist_sched_wakeup_event(const struct perf_tool *tool,
 				       union perf_event *event __maybe_unused,
-				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -2663,14 +2645,13 @@ static int timehist_sched_wakeup_event(const struct perf_tool *tool,
 	/* show wakeups if requested */
 	if (sched->show_wakeups &&
 	    !perf_time__skip_sample(&sched->ptime, sample->time))
-		timehist_print_wakeup_event(sched, evsel, sample, machine, thread);
+		timehist_print_wakeup_event(sched, sample, machine, thread);
 
 	thread__put(thread);
 	return 0;
 }
 
 static void timehist_print_migration_event(struct perf_sched *sched,
-					struct evsel *evsel,
 					struct perf_sample *sample,
 					struct machine *machine,
 					struct thread *migrated)
@@ -2691,8 +2672,8 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 	if (thread == NULL)
 		return;
 
-	if (timehist_skip_sample(sched, thread, evsel, sample) &&
-	    timehist_skip_sample(sched, migrated, evsel, sample)) {
+	if (timehist_skip_sample(sched, thread, sample) &&
+	    timehist_skip_sample(sched, migrated, sample)) {
 		thread__put(thread);
 		return;
 	}
@@ -2726,7 +2707,6 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 
 static int timehist_migrate_task_event(const struct perf_tool *tool,
 				       union perf_event *event __maybe_unused,
-				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -2751,8 +2731,7 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
 
 	/* show migrations if requested */
 	if (sched->show_migrations) {
-		timehist_print_migration_event(sched, evsel, sample,
-							machine, thread);
+		timehist_print_migration_event(sched, sample, machine, thread);
 	}
 	thread__put(thread);
 
@@ -2784,7 +2763,6 @@ static void timehist_update_task_prio(struct perf_sample *sample,
 
 static int timehist_sched_change_event(const struct perf_tool *tool,
 				       union perf_event *event,
-				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -2808,13 +2786,13 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 	if (sched->show_prio || sched->prio_str)
 		timehist_update_task_prio(sample, machine);
 
-	thread = timehist_get_thread(sched, sample, machine, evsel);
+	thread = timehist_get_thread(sched, sample, machine);
 	if (thread == NULL) {
 		rc = -1;
 		goto out;
 	}
 
-	if (timehist_skip_sample(sched, thread, evsel, sample))
+	if (timehist_skip_sample(sched, thread, sample))
 		goto out;
 
 	tr = thread__get_runtime(thread);
@@ -2823,7 +2801,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 		goto out;
 	}
 
-	tprev = evsel__get_time(evsel, sample->cpu);
+	tprev = evsel__get_time(sample->evsel, sample->cpu);
 
 	/*
 	 * If start time given:
@@ -2913,7 +2891,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 		tr->migrated = 0;
 	}
 
-	evsel__save_time(evsel, sample->time, sample->cpu);
+	evsel__save_time(sample->evsel, sample->time, sample->cpu);
 
 	thread__put(thread);
 	addr_location__exit(&al);
@@ -2922,11 +2900,10 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 
 static int timehist_sched_switch_event(const struct perf_tool *tool,
 			     union perf_event *event,
-			     struct evsel *evsel,
 			     struct perf_sample *sample,
 			     struct machine *machine __maybe_unused)
 {
-	return timehist_sched_change_event(tool, event, evsel, sample, machine);
+	return timehist_sched_change_event(tool, event, sample, machine);
 }
 
 static int process_lost(const struct perf_tool *tool __maybe_unused,
@@ -3174,7 +3151,6 @@ static void timehist_print_summary(struct perf_sched *sched,
 
 typedef int (*sched_handler)(const struct perf_tool *tool,
 			  union perf_event *event,
-			  struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct machine *machine);
 
@@ -3196,7 +3172,7 @@ static int perf_timehist__process_sample(const struct perf_tool *tool,
 	if (evsel->handler != NULL) {
 		sched_handler f = evsel->handler;
 
-		err = f(tool, event, evsel, sample, machine);
+		err = f(tool, event, sample, machine);
 	}
 
 	return err;
-- 
2.53.0.239.g8d8fc8a987-goog

