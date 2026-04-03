Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70D3DB65F
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248871; cv=none; b=SpBB5UIwJLk21T/n4f6kBZmjUKUkUXos1j1zgXu+1ePPNe9LYDlTAUQS0wbfsYi1K1gz+3YUXDhDNbx4S9AbBTr/TXj2DFIaOA81kXIL3V769pAjHSSk1b+5sVPyIcI1rgeGOOGKsNHEEyMwa5aWRGaeXM+8D632pS4QWPN5C0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248871; c=relaxed/simple;
	bh=R1eRO03wAt1dp60VJ664aBvcIUYq5ratVe3cYdnev7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QtNAO0KhPczCUuZ5tjCr/86DRBq+uKnYjlI3YdIhrMhe6/tl9Vmmtd9gPmDdxfWfK20z5bFb74sOdfK8R4nZO1LGAnfw8Z3W1P7ZOznFRTIyKRauONq/0GxgAuzSOTmrfJN0VUprZHB1esoose/dHBmrQFSr3Ua9f9L4bN+Iaqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pRGxyuBx; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pRGxyuBx"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1279caef718so3684285c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248868; x=1775853668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5k86aypFt67mnc4wsBRuul2tE1ESndRC/oJkXBZFkzg=;
        b=pRGxyuBxyFFu2iWepsKhp5auUyXOtthjJIZG72beEyx8jarkFd8pk6E40ZTFtKl6bZ
         fSGn2GEyNFuX9k6CbejmzFN0jTriCBa2As9NssKf6ttadydy1QWpg0rn+yWrk7GYsKsg
         1d7B9Q2j6h22sfNuZFq0q7JgIkFXasQQOPJzZs86pxRM3q4iVnoalTN5S+XCOlNf2NZ2
         CjVDvm6n5UTLtJ/rvWwruEFS5VpCqq9+r2ULY8f3nHGj048Fhq5TwapHxlTMTb6wGgz/
         gCBRZ9G5ae5ZyLB0Ln224OGdT/ELh1x23NmKZs6MFkCTHGgJXjXfGPSMYy6J7W/BNc2k
         jEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248868; x=1775853668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5k86aypFt67mnc4wsBRuul2tE1ESndRC/oJkXBZFkzg=;
        b=EEuhFO5ZPrL2Xvlqu9TRxeHfIEVaT+LU0xHArss+IlP4HnugZ2EtvHjAD0Upk0wcZe
         JX60Q3SHtGN3+1ORGfw62ejD3m+97TQQ00p7Hk5g0fYxl2/x+LhGyWmZfIWJshxEusBA
         bXYDbJm/IfnwiO1UUpBdzR1wNfEqgybktYV4Zm8iol0kjevYFBnzoiggeNRIr5rj6lpl
         V6LP0KGSEvcSdPEBaXGBlortiDqc0C3vfGMCnMhI2TA57Eww3EXZxQeR30VET6T/IZrW
         ksEi1t4sEervE+FZ8+ZRa8h42P2VxvjuNAlH1WWaCUqLbar16HLRIKU9IsSZclE2qtUi
         Y6hA==
X-Forwarded-Encrypted: i=1; AJvYcCXIEScn01iHgHJ7vxN8D5rZs0y/o4dR2iAbgEsGdHZ0Lntf8hu2kWWGbWUoZ0NgR116G4EM8THbpi6VTEpCuij3@vger.kernel.org
X-Gm-Message-State: AOJu0YzVbmvZIS0CjmQlbfG/HlSqZ4f0wqPh06c42Eud0OXPFOJq5Zxe
	XcKlLhmir4kpC8nj23yDGNeuiQDkvHg8mATmFIatV4oU+AzPhYN7H11snbCnFkF4y2QWFtB/tfP
	RTu4tlVpKew==
X-Received: from dled6-n1.prod.google.com ([2002:a05:701b:42c6:10b0:12b:f977:8848])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:212:b0:123:3500:b688
 with SMTP id a92af1059eb24-12bfb73ef52mr1685070c88.19.1775248867989; Fri, 03
 Apr 2026 13:41:07 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:11 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-20-irogers@google.com>
Subject: [PATCH v5 19/25] perf sched: Don't pass evsel with sample
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
index b6271a5ec8de..fdfa2fec0fe6 100644
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
@@ -1815,21 +1806,20 @@ static int process_sched_switch_event(const struct perf_tool *tool,
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
@@ -1852,20 +1842,18 @@ static int perf_sched__process_fork_event(const struct perf_tool *tool,
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
 
@@ -1879,7 +1867,7 @@ static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		err = f(tool, evsel, sample, machine);
+		err = f(tool, sample, machine);
 	}
 
 	return err;
@@ -2318,11 +2306,10 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
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
@@ -2504,12 +2491,11 @@ static void save_idle_callchain(struct perf_sched *sched,
 
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
@@ -2552,7 +2538,6 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 
 static bool timehist_skip_sample(struct perf_sched *sched,
 				 struct thread *thread,
-				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	bool rc = false;
@@ -2574,7 +2559,7 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 		tr = thread__get_runtime(thread);
 		if (tr && tr->prio != -1)
 			prio = tr->prio;
-		else if (evsel__name_is(evsel, "sched:sched_switch"))
+		else if (evsel__name_is(sample->evsel, "sched:sched_switch"))
 			prio = perf_sample__intval(sample, "prev_prio");
 
 		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
@@ -2584,7 +2569,7 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 	}
 
 	if (sched->idle_hist) {
-		if (!evsel__name_is(evsel, "sched:sched_switch"))
+		if (!evsel__name_is(sample->evsel, "sched:sched_switch"))
 			rc = true;
 		else if (perf_sample__intval(sample, "prev_pid") != 0 &&
 			 perf_sample__intval(sample, "next_pid") != 0)
@@ -2595,7 +2580,6 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 }
 
 static void timehist_print_wakeup_event(struct perf_sched *sched,
-					struct evsel *evsel,
 					struct perf_sample *sample,
 					struct machine *machine,
 					struct thread *awakened)
@@ -2608,8 +2592,8 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
 		return;
 
 	/* show wakeup unless both awakee and awaker are filtered */
-	if (timehist_skip_sample(sched, thread, evsel, sample) &&
-	    timehist_skip_sample(sched, awakened, evsel, sample)) {
+	if (timehist_skip_sample(sched, thread, sample) &&
+	    timehist_skip_sample(sched, awakened, sample)) {
 		thread__put(thread);
 		return;
 	}
@@ -2633,7 +2617,6 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
 
 static int timehist_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unused,
 					union perf_event *event __maybe_unused,
-					struct evsel *evsel __maybe_unused,
 					struct perf_sample *sample __maybe_unused,
 					struct machine *machine __maybe_unused)
 {
@@ -2642,7 +2625,6 @@ static int timehist_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unu
 
 static int timehist_sched_wakeup_event(const struct perf_tool *tool,
 				       union perf_event *event __maybe_unused,
-				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -2668,14 +2650,13 @@ static int timehist_sched_wakeup_event(const struct perf_tool *tool,
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
@@ -2696,8 +2677,8 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 	if (thread == NULL)
 		return;
 
-	if (timehist_skip_sample(sched, thread, evsel, sample) &&
-	    timehist_skip_sample(sched, migrated, evsel, sample)) {
+	if (timehist_skip_sample(sched, thread, sample) &&
+	    timehist_skip_sample(sched, migrated, sample)) {
 		thread__put(thread);
 		return;
 	}
@@ -2731,7 +2712,6 @@ static void timehist_print_migration_event(struct perf_sched *sched,
 
 static int timehist_migrate_task_event(const struct perf_tool *tool,
 				       union perf_event *event __maybe_unused,
-				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -2756,8 +2736,7 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
 
 	/* show migrations if requested */
 	if (sched->show_migrations) {
-		timehist_print_migration_event(sched, evsel, sample,
-							machine, thread);
+		timehist_print_migration_event(sched, sample, machine, thread);
 	}
 	thread__put(thread);
 
@@ -2789,7 +2768,6 @@ static void timehist_update_task_prio(struct perf_sample *sample,
 
 static int timehist_sched_change_event(const struct perf_tool *tool,
 				       union perf_event *event,
-				       struct evsel *evsel,
 				       struct perf_sample *sample,
 				       struct machine *machine)
 {
@@ -2813,13 +2791,13 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
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
@@ -2828,7 +2806,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 		goto out;
 	}
 
-	tprev = evsel__get_time(evsel, sample->cpu);
+	tprev = evsel__get_time(sample->evsel, sample->cpu);
 
 	/*
 	 * If start time given:
@@ -2918,7 +2896,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 		tr->migrated = 0;
 	}
 
-	evsel__save_time(evsel, sample->time, sample->cpu);
+	evsel__save_time(sample->evsel, sample->time, sample->cpu);
 
 	thread__put(thread);
 	addr_location__exit(&al);
@@ -2927,11 +2905,10 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 
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
@@ -3179,7 +3156,6 @@ static void timehist_print_summary(struct perf_sched *sched,
 
 typedef int (*sched_handler)(const struct perf_tool *tool,
 			  union perf_event *event,
-			  struct evsel *evsel,
 			  struct perf_sample *sample,
 			  struct machine *machine);
 
@@ -3201,7 +3177,7 @@ static int perf_timehist__process_sample(const struct perf_tool *tool,
 	if (evsel->handler != NULL) {
 		sched_handler f = evsel->handler;
 
-		err = f(tool, event, evsel, sample, machine);
+		err = f(tool, event, sample, machine);
 	}
 
 	return err;
-- 
2.53.0.1213.gd9a14994de-goog

