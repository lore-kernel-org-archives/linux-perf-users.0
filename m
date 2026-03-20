Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C236F410
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994139; cv=none; b=j9zu+1s5oO+D9VjvAXkPhoboGlgeWzzE0/ijAgPTdOvXrwMNZtxoCzFudXHRCh6MKl5eUTka1B5UGxbRkbhg1ohPmQR3Zch65Qj103uLUfVLuYbSFhr1Q2SGsnFEPD5XWOS1+AVKv4cOwzpcBLNQF4YRo3fAR7QYj3vcqCyo5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994139; c=relaxed/simple;
	bh=pOwONCwz49zthD9j0psaNQ2IZyAd+kNLm99SUasUvOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T8ZIsbgz/BNgaX0xoptvh5XWAjUTOQ2kUY2cRkrTNgKH3GuSZrc8qqslVJTi5zrLxPjM6fvlEAmXIFZyblDc3gJd9+zdzA7DdoivK0dIG3HBBa5OSUpH9I1TfhCQikgSzZWu0hjjOqMyyo2dAobZa2N2ITXIvD/tbJOKNnInAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mto7BlUB; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mto7BlUB"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12737f276a2so1592802c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 01:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773994136; x=1774598936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovFGhpfY+irctpExEafrdLVsxTkGqGXcbNrxE9cSOnI=;
        b=Mto7BlUB6ZS9gWxxNT0l/RyBctPMXg6MEQRovgKJqOASQmmkKNe92yxTOBIelWX3to
         ugjg43LHHFwmLuX7uAGu2ZUtwp8A/mDgnw6WbQ1zRY23hEfAMDWmcjzHaTSuGxVBnuCJ
         qAhb53PAIpbpbbiUfc2LzB1T3jkYsoQSXgDdEJUWDxWQ1tTVCMHNL4hv9G4EuAzIwIHm
         LDUOQmd42ntw7RpBb+OariLOUHxVVVbAK9v0fL4y0TtT5GFYGFZTl67QtBB4gOU6wJVa
         7y9nPlGviLL2jMmuoS7d81umOS91aEBQgt+W5wDvHtGpwIj4u9jDCxYCZSm8rGEIJP75
         6ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773994136; x=1774598936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovFGhpfY+irctpExEafrdLVsxTkGqGXcbNrxE9cSOnI=;
        b=rDqrecf3bTSqbFRLZttqjJwabAz33tW7MTQQc0K7emdnopPTmqxwJHa7P6E9YB5dsz
         7trDoJ9/kh3WPFSh0WFMrlxhSASIa5UlBhrTsDqBoQ5RBTlbfMoijFhkTTL/WqvLZge2
         KQN9XNmJlyuAPVCUo0MhKQlspg7Viaf1xmsrZY3w5A8VSvjFbXCtFlcLieVMUQxr+/lL
         9BBl05vAsfhJ/GQuYO7OTs3NnKNcIIOQclJ/HzUEoFYF7dHpL5zJ6V8YMohQYfvWiZJg
         p1lLj5a7PdymUl/7+h5kwnroD7Enm5bLM5AUV5EdGjHWY28p8cojtG4V9uyVk1kN6W/J
         gUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF5GIOkBs0RpBRNKzmTcD6q41j83zHbOBHM7yjGxTOeYfQQl8EGrYzQUDuiis4w0fQ2wm/ZAJKotbjklhocgxN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyc0VtGd1+V+oyXDxhHaBzZCfjQ17TlD6uJbHm6S/diDie9WwX
	OecrC1lqP4cjeFXY8OPQ7aCFkaiW2LCtC+Gh0kUWxB9rUJlJi8MljzvyxnixGniZ0DYJUc1wAUB
	0578xujVJJA==
X-Received: from dycaj11.prod.google.com ([2002:a05:7300:fb8b:b0:2be:8790:abe7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f31a:b0:12a:72af:83d2
 with SMTP id a92af1059eb24-12a72af85e7mr462018c88.14.1773994135841; Fri, 20
 Mar 2026 01:08:55 -0700 (PDT)
Date: Fri, 20 Mar 2026 01:08:17 -0700
In-Reply-To: <20260320080835.724836-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319232334.287517-1-irogers@google.com> <20260320080835.724836-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320080835.724836-9-irogers@google.com>
Subject: [PATCH v3 08/25] perf callchain: Don't pass evsel and sample
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
 tools/perf/util/callchain.h                   |  5 ++--
 tools/perf/util/db-export.c                   |  8 +++----
 tools/perf/util/hist.c                        |  2 +-
 tools/perf/util/machine.c                     | 14 +++++------
 tools/perf/util/machine.h                     |  3 ---
 .../util/scripting-engines/trace-event-perl.c |  4 ++--
 .../scripting-engines/trace-event-python.c    |  4 ++--
 17 files changed, 48 insertions(+), 56 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 89456ba6fcbb..f9ac871264af 100644
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
index d03d38a18aa0..1b873377c6ad 100644
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
@@ -1020,7 +1020,7 @@ static int perf_event__inject_buildid(const struct perf_tool *tool, union perf_e
 			     /*sample_in_dso=*/true);
 	}
 
-	sample__for_each_callchain_node(thread, sample->evsel, sample, PERF_MAX_STACK_DEPTH,
+	sample__for_each_callchain_node(thread, sample, PERF_MAX_STACK_DEPTH,
 					/*symbols=*/false, mark_dso_hit_callback, &args);
 	sample->evsel = saved_evsel;
 	thread__put(thread);
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 7e6b976a2cab..df3bfb8fd9c0 100644
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
@@ -848,7 +848,7 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
 	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
 		return -1;
 
-	callsite = find_callsite(evsel, sample);
+	callsite = find_callsite(sample);
 
 	/*
 	 * This is to find the current page (with correct gfp flags and
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 111ae53025d1..043da61cdcef 100644
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
index baf0c99df5df..a35e8ea4e2ef 100644
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
index 3e7e8ad0bc13..b6271a5ec8de 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2330,7 +2330,6 @@ static bool is_idle_sample(struct perf_sample *sample,
 
 static void save_task_callchain(struct perf_sched *sched,
 				struct perf_sample *sample,
-				struct evsel *evsel,
 				struct machine *machine)
 {
 	struct callchain_cursor *cursor;
@@ -2350,7 +2349,7 @@ static void save_task_callchain(struct perf_sched *sched,
 
 	cursor = get_tls_callchain_cursor();
 
-	if (thread__resolve_callchain(thread, cursor, evsel, sample,
+	if (thread__resolve_callchain(thread, cursor, sample,
 				      NULL, NULL, sched->max_stack + 2) != 0) {
 		if (verbose > 0)
 			pr_err("Failed to resolve callchain. Skipping\n");
@@ -2524,7 +2523,7 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 				 sample->tid);
 		}
 
-		save_task_callchain(sched, sample, evsel, machine);
+		save_task_callchain(sched, sample, machine);
 		if (sched->idle_hist) {
 			struct thread *idle;
 			struct idle_thread_runtime *itr;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8724c4ab3e88..8022801721e2 100644
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
@@ -2790,7 +2790,7 @@ static int process_deferred_sample_event(const struct perf_tool *tool,
 
 		if (symbol_conf.use_callchain && sample->callchain) {
 			cursor = get_tls_callchain_cursor();
-			if (thread__resolve_callchain(al.thread, cursor, evsel,
+			if (thread__resolve_callchain(al.thread, cursor,
 						      sample, NULL, NULL,
 						      scripting_max_stack)) {
 				pr_info("cannot resolve deferred callchains\n");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 33199ff2bbfd..385a9ac2ae96 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2905,7 +2905,7 @@ static int trace__resolve_callchain(struct trace *trace,
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
index 94ae45fd1f27..32ef786abd1f 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1123,7 +1123,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 
 int sample__resolve_callchain(struct perf_sample *sample,
 			      struct callchain_cursor *cursor, struct symbol **parent,
-			      struct evsel *evsel, struct addr_location *al,
+			      struct addr_location *al,
 			      int max_stack)
 {
 	if (sample->callchain == NULL && !symbol_conf.show_branchflag_count)
@@ -1131,7 +1131,7 @@ int sample__resolve_callchain(struct perf_sample *sample,
 
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain ||
 	    perf_hpp_list.parent || symbol_conf.show_branchflag_count) {
-		return thread__resolve_callchain(al->thread, cursor, evsel, sample,
+		return thread__resolve_callchain(al->thread, cursor, sample,
 						 parent, al, max_stack);
 	}
 	return 0;
@@ -1806,7 +1806,7 @@ s64 callchain_avg_cycles(struct callchain_node *cnode)
 	return cycles;
 }
 
-int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
+int sample__for_each_callchain_node(struct thread *thread,
 				    struct perf_sample *sample, int max_stack,
 				    bool symbols, callchain_iter_fn cb, void *data)
 {
@@ -1817,7 +1817,7 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
 		return -ENOMEM;
 
 	/* Fill in the callchain. */
-	ret = __thread__resolve_callchain(thread, cursor, evsel, sample,
+	ret = __thread__resolve_callchain(thread, cursor, sample,
 					  /*parent=*/NULL, /*root_al=*/NULL,
 					  max_stack, symbols);
 	if (ret)
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index df54ddb8c0cb..6eb3e20349a9 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -8,7 +8,6 @@
 #include "branch.h"
 
 struct addr_location;
-struct evsel;
 struct ip_callchain;
 struct map;
 struct perf_sample;
@@ -251,7 +250,7 @@ int record_opts__parse_callchain(struct record_opts *record,
 
 int sample__resolve_callchain(struct perf_sample *sample,
 			      struct callchain_cursor *cursor, struct symbol **parent,
-			      struct evsel *evsel, struct addr_location *al,
+			      struct addr_location *al,
 			      int max_stack);
 int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *sample);
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
@@ -314,7 +313,7 @@ s64 callchain_avg_cycles(struct callchain_node *cnode);
 
 typedef int (*callchain_iter_fn)(struct callchain_cursor_node *node, void *data);
 
-int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
+int sample__for_each_callchain_node(struct thread *thread,
 				    struct perf_sample *sample, int max_stack,
 				    bool symbols, callchain_iter_fn cb, void *data);
 
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index ae9a9065aab7..a1f578c3a8d5 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -209,8 +209,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 static struct call_path *call_path_from_sample(struct db_export *dbe,
 					       struct machine *machine,
 					       struct thread *thread,
-					       struct perf_sample *sample,
-					       struct evsel *evsel)
+					       struct perf_sample *sample)
 {
 	u64 kernel_start = machine__kernel_start(machine);
 	struct call_path *current = &dbe->cpr->call_path;
@@ -228,7 +227,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 	 */
 	callchain_param.order = ORDER_CALLER;
 	cursor = get_tls_callchain_cursor();
-	err = thread__resolve_callchain(thread, cursor, evsel,
+	err = thread__resolve_callchain(thread, cursor,
 					sample, NULL, NULL, PERF_MAX_STACK_DEPTH);
 	if (err) {
 		callchain_param.order = saved_order;
@@ -391,8 +390,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 
 	if (dbe->cpr) {
 		struct call_path *cp = call_path_from_sample(dbe, machine,
-							     thread, sample,
-							     evsel);
+							     thread, sample);
 		if (cp) {
 			db_export__call_path(dbe, cp);
 			es.call_path_id = cp->db_id;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7ffaa3d9851b..84a402d248a3 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1339,7 +1339,7 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
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
index 2b0df7bd9a46..08197cef44c8 100644
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
2.53.0.959.g497ff81fa9-goog

