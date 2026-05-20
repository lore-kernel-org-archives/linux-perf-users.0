Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435C332601
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303956; cv=none; b=EbBds2ksBMfT/iZ8R/IkJ5LfEJMwZCSw7n/cbXPV1S0wH0/X62YeXF6t51qjR5hw17bv4dR5Kt0nIWi5Xc1cuq3pfmymWaEuVOmOQv4zh76A3T/w0oEoVgJ5Tmh24Gvdmt0K32HPKMKe62XrFnP26svSlLb4nc2qDWv47+JOmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303956; c=relaxed/simple;
	bh=Dy9wAEr3mbtnsMF0sPpYTwHDppf/nIrME8nC3IkQDp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kyckjpymCv6BxeMRfGqjOGSslVfkDM6mcPXF5f2XuU2ctOTvzq0Y6/Ooq+8gsHUwwAEq1AEVJMNaesgM0Q6kFKbGJW4MgiKyyQcvjG7ZggtSgULG+cl9vuz5efhINyOXYylDH4+m6QaO9eDVE4L6quubISwrXtkp0pVxbuQCMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V9wG7vJj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9wG7vJj"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82c84be9c3so2461692a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303953; x=1779908753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxFMidiRV8Lxdogjg1wrSRAoJAgQIsq5AZIfCOvfZro=;
        b=V9wG7vJj+qXAws4PyLk2WOPpu137ElKBOTiVCMx/AU67gPLilxdT69XnadBPJ99EvN
         YO/q64La6sCTK8b3Nh3RBw0pLsL6E38w1or/1Loc/JhH6f0LcpxsPzibXyFmjQ1eyUHy
         sM5kUZAZYn3SRuJF0nr4MSRhuz6x/K4wW0qm2c/qrpt1m5CIVnz2/z1v51yUfIT0SDLj
         S29l0znCsEgUqtpDxIswX8DKM8/ZB43hHendbGNM3+V/spf3XVKPHPu8vgIN65qrOc6I
         H5+5cfxlYkBbmd5xXqs8MUV7gIczAcI9kgTxhdwoq+EKcEwEIeMXUdU7a8uj7EiLcbnd
         KvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303953; x=1779908753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxFMidiRV8Lxdogjg1wrSRAoJAgQIsq5AZIfCOvfZro=;
        b=oI53fMqOzjPrYipDnnZaj6XWtQdg37m3I3nRah0ILUCkRde/YgvD8lvDlEw7NqbZPQ
         cm2t9HNRG6sBG1E5vp0HQTG/VZlXLlqGcAOfE/Jl7D8O92Kshe3dzFCQfFOCLsUXJRMf
         MZhrpTue5uIQwVmnlq/Xr348+zpErwMWcg71/+ffX1XBBU6nqNimElvbP7h1vhiURyZn
         a+fsRRmSqj8US0qkXDlFBw8mTc9tbDRUpk4RYpbOFWZZBWp7KqlhV2oz8aDmxqTVUgcX
         sWfVLHParNezxQGUbeA8+szsl0RxZm1YqR8LtJ4ZvgFADtNbociqmNRWT0Ceimo+fGM+
         Ra7w==
X-Forwarded-Encrypted: i=1; AFNElJ/Gwv9+VkA83XNQZnUxPhInQRSG+ZTe6KNZZBBfuGhdabCiXaU3YGL9Blkps/VlbePpdLSbEOE2KWSP+0hrAkL9@vger.kernel.org
X-Gm-Message-State: AOJu0YzNCX2sunY+CAUR98SggpV8DU64wW4/vOTLXgiIBdRXM8U8gPbk
	3qzTr0P7h7y4d0gnI5qKL2LM/ZxgaFFF7gOOtLfWz/rCXxnY/i+tcU3Bcp996CvQ9ngIQkoteDQ
	MIIJIK2FifQ==
X-Received: from pgnd8.prod.google.com ([2002:a63:7348:0:b0:c80:1fe6:ac57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d94:b0:3a3:602d:a0d8
 with SMTP id adf61e73a8af0-3b22e7537fbmr27703722637.17.1779303953190; Wed, 20
 May 2026 12:05:53 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:11 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-6-irogers@google.com>
Subject: [PATCH v14 05/32] perf callchain: Don't pass evsel and sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

As struct perf_sample now directly contains its own resolved evsel pointer,
passing the evsel separately is redundant and clutters the interface.

Remove the redundant evsel parameter from callchain-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-c2c.c                      |  2 +-
 tools/perf/builtin-inject.c                   |  4 ++--
 tools/perf/builtin-kmem.c                     |  6 ++---
 tools/perf/builtin-kwork.c                    |  5 ++--
 tools/perf/builtin-lock.c                     | 24 +++++++++----------
 tools/perf/builtin-sched.c                    |  5 ++--
 tools/perf/builtin-script.c                   |  6 ++---
 tools/perf/builtin-trace.c                    |  2 +-
 tools/perf/util/build-id.c                    |  2 +-
 tools/perf/util/callchain.c                   |  8 +++----
 tools/perf/util/callchain.h                   |  6 ++---
 tools/perf/util/db-export.c                   |  8 +++----
 tools/perf/util/hist.c                        |  2 +-
 tools/perf/util/machine.c                     | 14 +++++------
 tools/perf/util/machine.h                     |  3 ---
 .../util/scripting-engines/trace-event-perl.c |  4 ++--
 .../scripting-engines/trace-event-python.c    |  4 ++--
 17 files changed, 48 insertions(+), 57 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 7593e5908fcc..2fa3d7ec8a09 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -339,7 +339,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	cursor = get_tls_callchain_cursor();
 	ret = sample__resolve_callchain(sample, cursor, NULL,
-					evsel, &al, sysctl_perf_event_max_stack);
+					&al, sysctl_perf_event_max_stack);
 	if (ret)
 		goto out;
 
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 3dac8bcaf6a1..3d48c8140ad9 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -418,7 +418,7 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 		goto out;
 
 	/* this will parse DWARF using stack and register data */
-	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
+	ret = thread__resolve_callchain(thread, cursor, sample,
 					/*parent=*/NULL, /*root_al=*/NULL,
 					PERF_MAX_STACK_DEPTH);
 	thread__put(thread);
@@ -1019,7 +1019,7 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 			     /*sample_in_dso=*/true);
 	}
 
-	sample__for_each_callchain_node(thread, sample->evsel, sample, PERF_MAX_STACK_DEPTH,
+	sample__for_each_callchain_node(thread, sample, PERF_MAX_STACK_DEPTH,
 					/*symbols=*/false, mark_dso_hit_callback, &args);
 	thread__put(thread);
 repipe:
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index d7233a8b43be..2cdc56bc2616 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -394,7 +394,7 @@ static int build_alloc_func_list(void)
  * Find first non-memory allocation function from callchain.
  * The allocation functions are in the 'alloc_func_list'.
  */
-static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
+static u64 find_callsite(struct perf_sample *sample)
 {
 	struct addr_location al;
 	struct machine *machine = &kmem_session->machines.host;
@@ -414,7 +414,7 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
 	if (cursor == NULL)
 		goto out;
 
-	sample__resolve_callchain(sample, cursor, NULL, evsel, &al, 16);
+	sample__resolve_callchain(sample, cursor, /*parent=*/NULL, &al, 16);
 
 	callchain_cursor_commit(cursor);
 	while (true) {
@@ -838,7 +838,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
 		return -1;
 
-	callsite = find_callsite(evsel, sample);
+	callsite = find_callsite(sample);
 
 	/*
 	 * This is to find the current page (with correct gfp flags and
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index ab4519287f47..4b312afed830 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -688,7 +688,6 @@ static int latency_entry_event(struct perf_kwork *kwork,
 
 static void timehist_save_callchain(struct perf_kwork *kwork,
 				    struct perf_sample *sample,
-				    struct evsel *evsel,
 				    struct machine *machine)
 {
 	struct symbol *sym;
@@ -708,7 +707,7 @@ static void timehist_save_callchain(struct perf_kwork *kwork,
 
 	cursor = get_tls_callchain_cursor();
 
-	if (thread__resolve_callchain(thread, cursor, evsel, sample,
+	if (thread__resolve_callchain(thread, cursor, sample,
 				      NULL, NULL, kwork->max_stack + 2) != 0) {
 		pr_debug("Failed to resolve callchain, skipping\n");
 		goto out_put;
@@ -838,7 +837,7 @@ static int timehist_entry_event(struct perf_kwork *kwork,
 		return ret;
 
 	if (work != NULL)
-		timehist_save_callchain(kwork, sample, evsel, machine);
+		timehist_save_callchain(kwork, sample, machine);
 
 	return 0;
 }
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index cbf3a39c7837..e2b585e528ac 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -551,13 +551,13 @@ static int get_key_by_aggr_mode_simple(u64 *key, u64 addr, u32 tid)
 	return 0;
 }
 
-static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample);
+static u64 callchain_id(struct perf_sample *sample);
 
-static int get_key_by_aggr_mode(u64 *key, u64 addr, struct evsel *evsel,
+static int get_key_by_aggr_mode(u64 *key, u64 addr,
 				 struct perf_sample *sample)
 {
 	if (aggr_mode == LOCK_AGGR_CALLER) {
-		*key = callchain_id(evsel, sample);
+		*key = callchain_id(sample);
 		return 0;
 	}
 	return get_key_by_aggr_mode_simple(key, addr, sample->tid);
@@ -841,7 +841,7 @@ static int get_symbol_name_offset(struct map *map, struct symbol *sym, u64 ip,
 	else
 		return strlcpy(buf, sym->name, size);
 }
-static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sample,
+static int lock_contention_caller(struct perf_sample *sample,
 				  char *buf, int size)
 {
 	struct thread *thread;
@@ -862,7 +862,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 	cursor = get_tls_callchain_cursor();
 
 	/* use caller function name from the callchain */
-	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
+	ret = thread__resolve_callchain(thread, cursor, sample,
 					NULL, NULL, max_stack_depth);
 	if (ret != 0) {
 		thread__put(thread);
@@ -896,7 +896,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 	return -1;
 }
 
-static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
+static u64 callchain_id(struct perf_sample *sample)
 {
 	struct callchain_cursor *cursor;
 	struct machine *machine = &session->machines.host;
@@ -911,7 +911,7 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
 
 	cursor = get_tls_callchain_cursor();
 	/* use caller function name from the callchain */
-	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
+	ret = thread__resolve_callchain(thread, cursor, sample,
 					NULL, NULL, max_stack_depth);
 	thread__put(thread);
 
@@ -963,7 +963,7 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
 	return callstack;
 }
 
-static int report_lock_contention_begin_event(struct evsel *evsel,
+static int report_lock_contention_begin_event(struct evsel *evsel __maybe_unused,
 					      struct perf_sample *sample)
 {
 	struct lock_stat *ls;
@@ -978,7 +978,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	struct map *kmap;
 	struct symbol *sym;
 
-	ret = get_key_by_aggr_mode(&key, addr, evsel, sample);
+	ret = get_key_by_aggr_mode(&key, addr, sample);
 	if (ret < 0)
 		return ret;
 
@@ -1025,7 +1025,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 			break;
 		case LOCK_AGGR_CALLER:
 			name = buf;
-			if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
+			if (lock_contention_caller(sample, buf, sizeof(buf)) < 0)
 				name = "Unknown";
 			break;
 		case LOCK_AGGR_CGROUP:
@@ -1127,7 +1127,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	return 0;
 }
 
-static int report_lock_contention_end_event(struct evsel *evsel,
+static int report_lock_contention_end_event(struct evsel *evsel __maybe_unused,
 					    struct perf_sample *sample)
 {
 	struct lock_stat *ls;
@@ -1138,7 +1138,7 @@ static int report_lock_contention_end_event(struct evsel *evsel,
 	u64 key;
 	int ret;
 
-	ret = get_key_by_aggr_mode(&key, addr, evsel, sample);
+	ret = get_key_by_aggr_mode(&key, addr, sample);
 	if (ret < 0)
 		return ret;
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 01228f630121..2a971081918b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2325,7 +2325,6 @@ static bool is_idle_sample(struct perf_sample *sample,
 
 static void save_task_callchain(struct perf_sched *sched,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct callchain_cursor *cursor;
@@ -2345,7 +2344,7 @@ static void save_task_callchain(struct perf_sched *sched,
 
 	cursor = get_tls_callchain_cursor();
 
-	if (thread__resolve_callchain(thread, cursor, evsel, sample,
+	if (thread__resolve_callchain(thread, cursor, sample,
 				      NULL, NULL, sched->max_stack + 2) != 0) {
 		if (verbose > 0)
 			pr_err("Failed to resolve callchain. Skipping\n");
@@ -2519,7 +2518,7 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 				 sample->tid);
 		}
 
-		save_task_callchain(sched, sample, evsel, machine);
+		save_task_callchain(sched, sample, machine);
 		if (sched->idle_hist) {
 			struct thread *idle;
 			struct idle_thread_runtime *itr;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d4e8f49a8751..b94a199ffcc9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1684,7 +1684,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 
 		if (symbol_conf.use_callchain && sample->callchain) {
 			cursor = get_tls_callchain_cursor();
-			if (thread__resolve_callchain(al->thread, cursor, evsel,
+			if (thread__resolve_callchain(al->thread, cursor,
 						      sample, NULL, NULL,
 						      scripting_max_stack))
 				cursor = NULL;
@@ -2507,7 +2507,7 @@ static void process_event(struct perf_script *script,
 
 		if (symbol_conf.use_callchain && sample->callchain) {
 			cursor = get_tls_callchain_cursor();
-			if (thread__resolve_callchain(al->thread, cursor, evsel,
+			if (thread__resolve_callchain(al->thread, cursor,
 						      sample, NULL, NULL,
 						      scripting_max_stack))
 				cursor = NULL;
@@ -2792,7 +2792,7 @@ static int process_deferred_sample_event(const struct perf_tool *tool,
 
 		if (symbol_conf.use_callchain && sample->callchain) {
 			cursor = get_tls_callchain_cursor();
-			if (thread__resolve_callchain(al.thread, cursor, evsel,
+			if (thread__resolve_callchain(al.thread, cursor,
 						      sample, NULL, NULL,
 						      scripting_max_stack)) {
 				pr_info("cannot resolve deferred callchains\n");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index eca578212def..4bc30ad8fb07 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2938,7 +2938,7 @@ static int trace__resolve_callchain(struct trace *trace,
 	if (machine__resolve(trace->host, &al, sample) < 0)
 		goto out;
 
-	err = thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, max_stack);
+	err = thread__resolve_callchain(al.thread, cursor, sample, NULL, NULL, max_stack);
 out:
 	addr_location__exit(&al);
 	return err;
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 55b72235f891..af4d874f1381 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -73,7 +73,7 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 
 	addr_location__exit(&al);
 
-	sample__for_each_callchain_node(thread, sample->evsel, sample, PERF_MAX_STACK_DEPTH,
+	sample__for_each_callchain_node(thread, sample, PERF_MAX_STACK_DEPTH,
 					/*symbols=*/false, mark_dso_hit_callback, /*data=*/NULL);
 
 
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index f031cbbeeba8..5c2282051e39 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1170,7 +1170,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 
 int sample__resolve_callchain(struct perf_sample *sample,
 			      struct callchain_cursor *cursor, struct symbol **parent,
-			      struct evsel *evsel, struct addr_location *al,
+			      struct addr_location *al,
 			      int max_stack)
 {
 	if (sample->callchain == NULL && !symbol_conf.show_branchflag_count)
@@ -1178,7 +1178,7 @@ int sample__resolve_callchain(struct perf_sample *sample,
 
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain ||
 	    perf_hpp_list.parent || symbol_conf.show_branchflag_count) {
-		return thread__resolve_callchain(al->thread, cursor, evsel, sample,
+		return thread__resolve_callchain(al->thread, cursor, sample,
 						 parent, al, max_stack);
 	}
 	return 0;
@@ -1853,7 +1853,7 @@ s64 callchain_avg_cycles(struct callchain_node *cnode)
 	return cycles;
 }
 
-int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
+int sample__for_each_callchain_node(struct thread *thread,
 				    struct perf_sample *sample, int max_stack,
 				    bool symbols, callchain_iter_fn cb, void *data)
 {
@@ -1864,7 +1864,7 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
 		return -ENOMEM;
 
 	/* Fill in the callchain. */
-	ret = __thread__resolve_callchain(thread, cursor, evsel, sample,
+	ret = __thread__resolve_callchain(thread, cursor, sample,
 					  /*parent=*/NULL, /*root_al=*/NULL,
 					  max_stack, symbols);
 	if (ret)
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index b7702d65ad60..0eb5d7a1a41d 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -8,11 +8,9 @@
 #include "branch.h"
 
 struct addr_location;
-struct evsel;
 struct hist_entry;
 struct hists;
 struct ip_callchain;
-struct map;
 struct perf_sample;
 struct record_opts;
 struct thread;
@@ -245,7 +243,7 @@ int record_opts__parse_callchain(struct record_opts *record,
 
 int sample__resolve_callchain(struct perf_sample *sample,
 			      struct callchain_cursor *cursor, struct symbol **parent,
-			      struct evsel *evsel, struct addr_location *al,
+			      struct addr_location *al,
 			      int max_stack);
 int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *sample);
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
@@ -306,7 +304,7 @@ s64 callchain_avg_cycles(struct callchain_node *cnode);
 
 typedef int (*callchain_iter_fn)(struct callchain_cursor_node *node, void *data);
 
-int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
+int sample__for_each_callchain_node(struct thread *thread,
 				    struct perf_sample *sample, int max_stack,
 				    bool symbols, callchain_iter_fn cb, void *data);
 
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index cc2bb1af4243..d991e3168aed 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -208,8 +208,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 static struct call_path *call_path_from_sample(struct db_export *dbe,
 					       struct machine *machine,
 					       struct thread *thread,
-					       struct perf_sample *sample,
-					       struct evsel *evsel)
+					       struct perf_sample *sample)
 {
 	u64 kernel_start = machine__kernel_start(machine);
 	struct call_path *current = &dbe->cpr->call_path;
@@ -227,7 +226,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 	 */
 	callchain_param.order = ORDER_CALLER;
 	cursor = get_tls_callchain_cursor();
-	err = thread__resolve_callchain(thread, cursor, evsel,
+	err = thread__resolve_callchain(thread, cursor,
 					sample, NULL, NULL, PERF_MAX_STACK_DEPTH);
 	if (err) {
 		callchain_param.order = saved_order;
@@ -390,8 +389,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 
 	if (dbe->cpr) {
 		struct call_path *cp = call_path_from_sample(dbe, machine,
-							     thread, sample,
-							     evsel);
+							     thread, sample);
 		if (cp) {
 			db_export__call_path(dbe, cp);
 			es.call_path_id = cp->db_id;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 747fdc455c80..f641cf321ace 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1342,7 +1342,7 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 		alm = map__get(al->map);
 
 	err = sample__resolve_callchain(iter->sample, get_tls_callchain_cursor(), &iter->parent,
-					iter->evsel, al, max_stack_depth);
+					al, max_stack_depth);
 	if (err) {
 		map__put(alm);
 		return err;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e76f8c86e62a..c2e0a99efe97 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2778,13 +2778,13 @@ static u64 get_leaf_frame_caller(struct perf_sample *sample,
 
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
-					    struct evsel *evsel,
 					    struct perf_sample *sample,
 					    struct symbol **parent,
 					    struct addr_location *root_al,
 					    int max_stack,
 					    bool symbols)
 {
+	struct evsel *evsel = sample->evsel;
 	struct branch_stack *branch = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct ip_callchain *chain = sample->callchain;
@@ -2986,10 +2986,11 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 
 static int thread__resolve_callchain_unwind(struct thread *thread,
 					    struct callchain_cursor *cursor,
-					    struct evsel *evsel,
 					    struct perf_sample *sample,
 					    int max_stack, bool symbols)
 {
+	struct evsel *evsel = sample->evsel;
+
 	/* Can we do dwarf post unwind? */
 	if (!((evsel->core.attr.sample_type & PERF_SAMPLE_REGS_USER) &&
 	      (evsel->core.attr.sample_type & PERF_SAMPLE_STACK_USER)))
@@ -3009,7 +3010,6 @@ static int thread__resolve_callchain_unwind(struct thread *thread,
 
 int __thread__resolve_callchain(struct thread *thread,
 				struct callchain_cursor *cursor,
-				struct evsel *evsel,
 				struct perf_sample *sample,
 				struct symbol **parent,
 				struct addr_location *root_al,
@@ -3025,22 +3025,22 @@ int __thread__resolve_callchain(struct thread *thread,
 
 	if (callchain_param.order == ORDER_CALLEE) {
 		ret = thread__resolve_callchain_sample(thread, cursor,
-						       evsel, sample,
+						       sample,
 						       parent, root_al,
 						       max_stack, symbols);
 		if (ret)
 			return ret;
 		ret = thread__resolve_callchain_unwind(thread, cursor,
-						       evsel, sample,
+						       sample,
 						       max_stack, symbols);
 	} else {
 		ret = thread__resolve_callchain_unwind(thread, cursor,
-						       evsel, sample,
+						       sample,
 						       max_stack, symbols);
 		if (ret)
 			return ret;
 		ret = thread__resolve_callchain_sample(thread, cursor,
-						       evsel, sample,
+						       sample,
 						       parent, root_al,
 						       max_stack, symbols);
 	}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 22a42c5825fa..048b24e9bd38 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -187,7 +187,6 @@ struct callchain_cursor;
 
 int __thread__resolve_callchain(struct thread *thread,
 				struct callchain_cursor *cursor,
-				struct evsel *evsel,
 				struct perf_sample *sample,
 				struct symbol **parent,
 				struct addr_location *root_al,
@@ -196,7 +195,6 @@ int __thread__resolve_callchain(struct thread *thread,
 
 static inline int thread__resolve_callchain(struct thread *thread,
 					    struct callchain_cursor *cursor,
-					    struct evsel *evsel,
 					    struct perf_sample *sample,
 					    struct symbol **parent,
 					    struct addr_location *root_al,
@@ -204,7 +202,6 @@ static inline int thread__resolve_callchain(struct thread *thread,
 {
 	return __thread__resolve_callchain(thread,
 					   cursor,
-					   evsel,
 					   sample,
 					   parent,
 					   root_al,
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index e261a57b87d4..af0d514b2397 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -257,7 +257,7 @@ static void define_event_symbols(struct tep_event *event,
 }
 
 static SV *perl_process_callchain(struct perf_sample *sample,
-				  struct evsel *evsel,
+				  struct evsel *evsel __maybe_unused,
 				  struct addr_location *al)
 {
 	struct callchain_cursor *cursor;
@@ -272,7 +272,7 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 
 	cursor = get_tls_callchain_cursor();
 
-	if (thread__resolve_callchain(al->thread, cursor, evsel,
+	if (thread__resolve_callchain(al->thread, cursor,
 				      sample, NULL, NULL, scripting_max_stack) != 0) {
 		pr_err("Failed to resolve callchain. Skipping\n");
 		goto exit;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 5a30caaec73e..1537122167d5 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -390,7 +390,7 @@ static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
 }
 
 static PyObject *python_process_callchain(struct perf_sample *sample,
-					 struct evsel *evsel,
+					 struct evsel *evsel __maybe_unused,
 					 struct addr_location *al)
 {
 	PyObject *pylist;
@@ -404,7 +404,7 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 		goto exit;
 
 	cursor = get_tls_callchain_cursor();
-	if (thread__resolve_callchain(al->thread, cursor, evsel,
+	if (thread__resolve_callchain(al->thread, cursor,
 				      sample, NULL, NULL,
 				      scripting_max_stack) != 0) {
 		pr_err("Failed to resolve callchain. Skipping\n");
-- 
2.54.0.746.g67dd491aae-goog

