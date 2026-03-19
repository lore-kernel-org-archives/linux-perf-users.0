Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10261411602
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962687; cv=none; b=AZGZqSHjuG4LDl1I3A15fDGoaoVsl2p/MI6UNvCl6SXA+D/W3crxtJ/urNh7AWpzLwbqGC65rw9fKqnMkjmCWFD5xH0WOQ9R6KOWKVJ5Xix74DP42dSOEpjvI150bw0uZKwDR9oXRoYkMK5k+nHu6Zphj29pszFcb8lgCYWW3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962687; c=relaxed/simple;
	bh=NSZutYu9IXwLiRY7oCOxEQOAo+GIIQHnWcOx7ulhb8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u8MXzcKnGc+B53i9chr1CQcoXR8Mb2ZJxlMjOfuu0tZ9sF2uVvrATz7OblL7H+20w+Yg9JNpl7pgINkvXiIWUzYVGVHPZeRpgZ2J19dq6CST3SI9z+TlZEZ0o3mAsIAst8RA8ItqO0NZxreQBP8jAc7NB1jtY9B34GyZn+wZZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5Bk9iVZ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5Bk9iVZ"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128e8ac314eso19531c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962684; x=1774567484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKCH+cdSZvjQddYwKOK4gXBAmhvFc/KmpRQzl0aK/io=;
        b=o5Bk9iVZtwLWNlUzVBNgryMGkgj5lZYy3ueu4ViNabwLepgDCDKETifLT/npLbL93/
         sVAqQfNM3tgjTjg8MKD1x/9hHYl34eSzvEeJPTAMRKwbpYd94W+VrvGBSeslF8oAaKFO
         LaMBjNjRfDbvNZEPiR6UKOQeVt0x1fPxGy8noQh4KBJqlKNbnVowsOvf6iSJ/god+eID
         7a4ePRfqHMxkjRnmqeYxLzBVJNHAEx26reFyPsqK+LSw1FnC7wYLS/I4BHOCmC/BKtEy
         O9Yfm9LOhSx30R0HP1t5Q8cqTBf2QMTttn7fmetC66oguTjFeGR+5FAozIxEgQr/Vd3e
         4M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962684; x=1774567484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKCH+cdSZvjQddYwKOK4gXBAmhvFc/KmpRQzl0aK/io=;
        b=R1WU/uQdKEXnTBcVUu83RoPV4ZWKsBmIud6HduL61Gsx/iSC4rPKZ2w/cWk1rhXXdM
         /MPN3YjD+4dKJuxcrCS+RRYky9LdW1BWbxqvjFwORrFHybMbbOZcKnT4iREY0YxYygSz
         X2hJyVLoMkx/41vRmHTW5Cl1zyY7G80S9Ni0P4dJXjXAQAJ7UEChtDpRbUZ0tSWLH5z/
         PqUBoMVZF8eQH4uoewXZB2RGQIBRxdWwNyqU6wRzcq5LQ5AOgMUFvGIK2NVrgrz5hA0w
         FG//owZh6jeZlUeVehqoneVqfXs35hBI8+d+adSEB1x6/PCLLAVjoj+765v55RWazNWX
         0Gug==
X-Forwarded-Encrypted: i=1; AJvYcCUv7tARI7N9QCFAc+I3wI8sHDxME/8PW+BnmDZXmgVkAfpLRsBjY1yf6eltO7O+fnpEvBP9OeKaeuSkiMB1zi3j@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZ3wywx0colddgqjl5q1fVAe3FBjTzd25/n/O0aAr87gP02kV
	Iy+B00umiLuw8ZdC91J85FCb5DqBQVcx709jFDow/uej6I8IIu80P45hJU5b1QMV3Gm0e5fSze7
	cLoieUsgjQg==
X-Received: from dlbcy23.prod.google.com ([2002:a05:7022:b97:b0:127:2073:9a6d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:226:b0:128:d51a:5157
 with SMTP id a92af1059eb24-12a726cfa7bmr401475c88.33.1773962683839; Thu, 19
 Mar 2026 16:24:43 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:28 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-20-irogers@google.com>
Subject: [PATCH v2 19/25] perf sched: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 92 ++++++++++++++------------------------
 1 file changed, 34 insertions(+), 58 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 854e29bbd6a9..ad397c6766a2 100644
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
2.53.0.959.g497ff81fa9-goog

