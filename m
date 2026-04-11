Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943C2C11C4
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890659; cv=none; b=A5sxAupZt3GnMCNF5iD85jYUmZrodZFejxuCdaESWAXdXKjBJ2PvKHdfUQmIE3mPlgV/+/OeSEnrGuI6sTXqJ1x+E3hPfhsSaUqNRDgGu//h5PqBDN7N53uhRzGtTTyAUG/5xC3kYM6FmQKRFZTOg4FsEiXaF8FYs3/9qlDKyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890659; c=relaxed/simple;
	bh=Im87kpiE1mCRpUhKWEyGLRXhd1Qth7QHJinoIVYLWy8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kp7x9uXXpTYJLWko2bffnY6FnlBLWAFC72aOD1JpIflaeBs2BhWQTjTEOXGO+0ikTpc4kmtNKn6J/w/brVhjhXS/m+obiFC21BsCdcy1hgx9T6zOnVzW86FyENm+cigafhW/WGg1UmKg+g0uuryEObH0E97jMxF0wLGeTJqaf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZeFQElx; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZeFQElx"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so3814924eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890656; x=1776495456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsskwNPYc/x4hKxjINvxOnZC5qtHPM2EMfYW3IF50E4=;
        b=MZeFQElxYhRhzY0EZMpGELa/G6CWMhFG0TF+tizD8TKgtD4xpfmiXn4/VH2EfCd7FU
         ObzCkRkP1NiDN6rwW5u3axfi7KuOIYBkgEpv5YWBJzDd1UZZT5LVRQyU/XAn0Av9bD8M
         ep3WWcHbxCMOr3oL7uJ6iocssveO2TRNmDB+VUrb1jnie5eIC0ZM2JA3Y1A6bY6iXb1M
         PqzhOmo6632AsvEO4iyW8LB1iXVZHZKwCVOJJPYTXjB72OAcM2P4dxcUg+Yt8AQ3Ov4F
         aZlbdc90Ib9seYFCxh9Sup1VaEPYZ67k0hwFk7q3fBXDZNzhBhQpSVRRQ33I5MaUiwsQ
         KHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890656; x=1776495456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsskwNPYc/x4hKxjINvxOnZC5qtHPM2EMfYW3IF50E4=;
        b=MOgL8JBewKyY2AfYlIIfIYaDyIbsKOY82Hbz1b51DxvnYftmCa7VwOLgSlhhK9Sbwe
         +XmGr3lrnYLT3QWpu7ZyAZEk8PoL+YLA9WD6tX4CXhRRH3VuEZDwObSGZMjAphcQbAs3
         GCV96GBCIOp5WEdmf4ZiQlx9JrDW4k9esNpf3/H2Is8FGv/DB5BtOJsRpRwjqgCheuH9
         q0T7KIlw7iWn/+FMAy0IvI5KotzsYkwzBKrESDa+rDJP3eVfiLWvDxz/WFfcTRt/FLTq
         XzrzeDCNOSxFymIwMRWCdG2/Jb7pBDGJHhB22vM+Rlk+lUOkjNocY3wdVm20CjGPNdVb
         dVjA==
X-Forwarded-Encrypted: i=1; AJvYcCW6W/Y5/kjBOD4rynCCCl7rXFtkdF7gAOtG33uw5xjCgXg5HEYZEKHi4kO/555vHgUEmEJkNMjF7AfiYRnhYwlT@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1H8TH+f57tnv2Y8jcPtWc4fm7qI5Vxn43cVLWpI0ONo1yv6+
	qe/zPbgWnlmWl+8AIUgeuO+bfiMNlyuQt1JTOBZ2V8YbtL5z83PipeYCGrqj/PRDyu02+uy+iy5
	Q/mh6N8lEuA==
X-Received: from dysc40.prod.google.com ([2002:a05:7300:3b28:b0:2ca:e667:252])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:19af:b0:2c0:bfe3:b95c
 with SMTP id 5a478bee46e88-2d5870ad63emr3884479eec.4.1775890655813; Fri, 10
 Apr 2026 23:57:35 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:56:55 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-7-irogers@google.com>
Subject: [PATCH v8 06/29] perf callchain: Don't pass evsel and sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

Change callchain resolve code to not pass an evsel with the sample,
instead just read the evsel from the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
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
index 3d3f3272918c..f43c165c3a13 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -417,7 +417,7 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 		goto out;
 
 	/* this will parse DWARF using stack and register data */
-	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
+	ret = thread__resolve_callchain(thread, cursor, sample,
 					/*parent=*/NULL, /*root_al=*/NULL,
 					PERF_MAX_STACK_DEPTH);
 	thread__put(thread);
@@ -1017,7 +1017,7 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
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
index 8ba5ea201bf9..177491eadb70 100644
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
index f15b64157589..aea14bff7e61 100644
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
index 3ffb8baf40f6..6ea739f20495 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1683,7 +1683,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 
 		if (symbol_conf.use_callchain && sample->callchain) {
 			cursor = get_tls_callchain_cursor();
-			if (thread__resolve_callchain(al->thread, cursor, evsel,
+			if (thread__resolve_callchain(al->thread, cursor,
 						      sample, NULL, NULL,
 						      scripting_max_stack))
 				cursor = NULL;
@@ -2506,7 +2506,7 @@ static void process_event(struct perf_script *script,
 
 		if (symbol_conf.use_callchain && sample->callchain) {
 			cursor = get_tls_callchain_cursor();
-			if (thread__resolve_callchain(al->thread, cursor, evsel,
+			if (thread__resolve_callchain(al->thread, cursor,
 						      sample, NULL, NULL,
 						      scripting_max_stack))
 				cursor = NULL;
@@ -2791,7 +2791,7 @@ static int process_deferred_sample_event(const struct perf_tool *tool,
 
 		if (symbol_conf.use_callchain && sample->callchain) {
 			cursor = get_tls_callchain_cursor();
-			if (thread__resolve_callchain(al.thread, cursor, evsel,
+			if (thread__resolve_callchain(al.thread, cursor,
 						      sample, NULL, NULL,
 						      scripting_max_stack)) {
 				pr_info("cannot resolve deferred callchains\n");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7f40cc81fd21..1fac167f7436 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2907,7 +2907,7 @@ static int trace__resolve_callchain(struct trace *trace,
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
index 06d463ccc7a0..27d8e486dc22 100644
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
@@ -308,7 +306,7 @@ s64 callchain_avg_cycles(struct callchain_node *cnode);
 
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
2.53.0.1213.gd9a14994de-goog

