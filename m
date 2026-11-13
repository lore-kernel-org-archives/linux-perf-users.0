Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599635;
	b=N9S7C+g5ltBlqmQoiUNIL2jzJMoJ1YpFtHJBLslfpNmv0Afuj5yGNI5svluVK9otEa12
	 k2lEhqU0HNOYLRssTlaGd7M+crGUj0j1acqdXP7rVcpBXU4FXtvMPGmspy5x6/c3m3hWk
	 SAqBjj6ESewyiN9DuE7RhnIXVunmwVl8B81SXGFZ+AiSm7KBvw0K/pgqD8wJloED+iGUZ
	 cqw0u9xXGgi0hveLIuqA6yU731VXWcXx4KZ4JN+QkmTUy49f8mszNwUPZCSdkTlEnl6or
	 nRz+ZPaWWMI8BSxRJWGKdifEZ7g6YXNEnJtHqNuf0ZtCYsB3f5oes0jvk4QydriKiQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599635;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=Jrk5AKHkxkVhlhBf4bSguxJjd9Foo/Tm38Yzr+sgE68=;
	b=C9ll0Mx2XTUbkFaQ6NAqAKqXQr+x9ixGGbFcjydb3ir0op1MVYdxOX0f7EDnvvdnb7XO
	 fr093wKAxuY3vUgbOMPtlc5ixjqyhAXNtVC+IfRrdx7biQEECQzO4TST8FPVA4/9lAwym
	 q/RUSujKAsUnICiBPzY9wzk+0Wai82anpMVO0fHmwRuVMv9fCTk7mMt/axfPBedbg9L14
	 e3dh/p96q+tqG8fCGlD5ZOVVlomkz5RGOQiPYTPhEK6lvRxeHyeROuMsi5BVwYO7wPHrG
	 +ZWDw03/JaU72ljcs44F6BKLMVFuQPELXVz7V7P458TvP7EGCzT5yCa97TGX5lCa+lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BSBE3NjV;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5060A2624
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09E5060A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BSBE3NjV
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1997036eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599634; x=1795204434; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jrk5AKHkxkVhlhBf4bSguxJjd9Foo/Tm38Yzr+sgE68=;
        b=BSBE3NjVSnq55523/UNjLq8QK9gADLywhYP2c6VYKwtRYy8ywr15+HX1nKg+T/5NZI
         LvBsWkUhabnsGwZOymG27eUzZlIpE7kBIRqHzqDGW0Yt6avvITVt5o8+WR4FNNUoMqnR
         MojQdV78oLZW3LnCUfljFbngWD6DsfDGDSglDir9/e2fMaNDW+Ar7wVAi/cJ9voZqeVq
         5t+PK9ydCd0DbLdEF94lkvZijC7SBP2mhnG3G0N/ZqSKErCg/gZXarODGqnA6gOxSsAw
         WDtaEwwXLpLSim1UKV0H+MwXIBpiidV/0KnguLZBVumFuYPpa6x8civOdUpa2dNLcX41
         XoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599634; x=1795204434;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jrk5AKHkxkVhlhBf4bSguxJjd9Foo/Tm38Yzr+sgE68=;
        b=s6hN1+OngHF0XT+bjOKIsbKWBVxd/qO0wgmuunRIWMIy1d9ozccux6+upHBVEl09en
         Dgd+EoKckDiYC2yYdiNKXgCarhSsrl5MIPxLFWMGk4e9E2lTlmdQALY5AhF/TuAB6W6R
         g27ua4ZyorZkAhApyUB/NQlDnQeoUl4dT+7/3SDjqWCDBSZg4Qucqe8aucvRc3GRx3/I
         oomu7uFT5z2rlpApWiISSOoba35Q3DixHB6QZnUKgBZVMA9YDpiw9RVA/xhIAxKy6mjL
         nTbqT7/oHJjhZr5s54Yy31Dygpy5Ahjzvn4wZM2SArdR2uXFygW39QwU+UXOq9trYwnD
         hdLQ==
X-Gm-Message-State: APuU4Z+E7dRcg0TYsxu0qKez3MW9N+b6zDKP7FqcSNuQyimhl6l+yS4n
	jhffoOp6/1vvvCznsIDST4p2LRTUIs008bnnA9hOTaUWXHYnI9FHr5d3wKnqxq5ysPBJ9iUwKnb
	IypAnlKkK1Q==
X-Received: from dycnn11.prod.google.com ([2002:a05:7301:140b:b0:36a:1c45:2f79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d185:b0:36b:fca0:80b3
 with SMTP id 5a478bee46e88-37966961040mr3338684eec.22.1794599633618; Fri, 13
 Nov 2026 11:53:53 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:11 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-7-irogers@google.com>
Subject: [PATCH v2 06/30] perf env: Add host_env() singleton
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add host_env() to provide a statically initialized singleton
struct perf_env representing the live host environment, replacing
ad-hoc stack and static host_env instances across subcommands,
utilities, benchmarks, and tests.

Drop the redundant struct perf_env * parameter from
machine__new_host(), machine__new_kallsyms(), machine__new_live(),
and __perf_session__new().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/synthesize.c         | 13 ++------
 tools/perf/builtin-buildid-list.c     |  5 +--
 tools/perf/builtin-inject.c           |  3 +-
 tools/perf/builtin-kallsyms.c         | 12 ++-----
 tools/perf/builtin-lock.c             |  6 +---
 tools/perf/builtin-top.c              | 17 +++-------
 tools/perf/builtin-trace.c            | 18 +++--------
 tools/perf/perf.c                     |  3 ++
 tools/perf/tests/code-reading.c       |  5 +--
 tools/perf/tests/dlfilter-test.c      |  5 +--
 tools/perf/tests/dwarf-unwind.c       |  5 +--
 tools/perf/tests/maps.c               | 11 ++-----
 tools/perf/tests/mmap-thread-lookup.c |  5 +--
 tools/perf/tests/symbols.c            |  7 +----
 tools/perf/util/debug.c               |  6 +---
 tools/perf/util/env.c                 | 45 +++++++++++++++++----------
 tools/perf/util/env.h                 | 10 ++++++
 tools/perf/util/header.c              |  3 ++
 tools/perf/util/machine.c             | 16 +++++-----
 tools/perf/util/machine.h             | 28 +++++++++++++++--
 tools/perf/util/parse-events.c        |  9 ++----
 tools/perf/util/probe-event.c         |  5 +--
 tools/perf/util/rwsem.h               |  6 ++++
 tools/perf/util/session.c             |  6 ++--
 tools/perf/util/session.h             | 22 +++++++++++--
 25 files changed, 131 insertions(+), 140 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 265d49a913d9..6aac1ccc7f4b 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -115,16 +115,12 @@ static int run_single_threaded(void)
 		.pid = "self",
 	};
 	struct perf_thread_map *threads;
-	struct perf_env host_env;
 	int err;
 
 	perf_set_singlethreaded();
-	perf_env__init(&host_env);
-	session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
-				      /*trace_event_repipe=*/false, &host_env);
+	session = perf_session__new(/*data=*/NULL, /*tool=*/NULL);
 	if (IS_ERR(session)) {
 		pr_err("Session creation failed.\n");
-		perf_env__exit(&host_env);
 		return PTR_ERR(session);
 	}
 	threads = thread_map__new_by_pid(getpid());
@@ -149,7 +145,6 @@ static int run_single_threaded(void)
 		perf_thread_map__put(threads);
 
 	perf_session__delete(session);
-	perf_env__exit(&host_env);
 	return err;
 }
 
@@ -163,14 +158,11 @@ static int do_run_multi_threaded(struct target *target,
 	int err = 0;
 	struct stats time_stats, event_stats;
 	struct perf_session *session;
-	struct perf_env host_env;
 
-	perf_env__init(&host_env);
 	init_stats(&time_stats);
 	init_stats(&event_stats);
 	for (i = 0; i < multi_iterations; i++) {
-		session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
-					      /*trace_event_repipe=*/false, &host_env);
+		session = perf_session__new(/*data=*/NULL, /*tool=*/NULL);
 		if (IS_ERR(session)) {
 			err = PTR_ERR(session);
 			goto err_out;
@@ -209,7 +201,6 @@ static int do_run_multi_threaded(struct target *target,
 	printf("    Average time per event %.3f usec\n",
 		time_average / event_average);
 err_out:
-	perf_env__exit(&host_env);
 	return err;
 }
 
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 5555f5dcefe4..f6159300ee63 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -45,14 +45,11 @@ static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
 
 static void buildid__show_kernel_maps(void)
 {
-	struct perf_env host_env;
 	struct machine *machine;
 
-	perf_env__init(&host_env);
-	machine = machine__new_host(&host_env);
+	machine = machine__new_host();
 	machine__for_each_kernel_map(machine, buildid__map_cb, NULL);
 	machine__delete(machine);
-	perf_env__exit(&host_env);
 }
 
 static int sysfs__fprintf_build_id(FILE *fp)
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ce7562fc788c..d115dc5ab6d6 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2871,8 +2871,7 @@ int cmd_inject(int argc, const char **argv)
 		}
 	}
 	inject.session = __perf_session__new(&data, tool,
-					     /*trace_event_repipe=*/inject.output.is_pipe,
-					     /*host_env=*/NULL);
+					     /*trace_event_repipe=*/inject.output.is_pipe);
 
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index 3c4339982b16..e85beb380d9d 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -19,17 +19,10 @@
 
 static int __cmd_kallsyms(int argc, const char **argv)
 {
-	int i, err;
-	struct perf_env host_env;
+	int i, err = 0;
 	struct machine *machine = NULL;
 
-
-	perf_env__init(&host_env);
-	err = perf_env__set_cmdline(&host_env, argc, argv);
-	if (err)
-		goto out;
-
-	machine = machine__new_kallsyms(&host_env);
+	machine = machine__new_kallsyms();
 	if (machine == NULL) {
 		pr_err("Couldn't read /proc/kallsyms\n");
 		err = -1;
@@ -54,7 +47,6 @@ static int __cmd_kallsyms(int argc, const char **argv)
 	}
 out:
 	machine__delete(machine);
-	perf_env__exit(&host_env);
 	return err;
 }
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 778923c92f42..6d557c552f36 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2015,7 +2015,6 @@ static int __cmd_contention(int argc, const char **argv)
 		.owner = show_lock_owner,
 		.cgroups = RB_ROOT,
 	};
-	struct perf_env host_env;
 
 	lockhash_table = calloc(LOCKHASH_SIZE, sizeof(*lockhash_table));
 	if (!lockhash_table)
@@ -2032,9 +2031,7 @@ static int __cmd_contention(int argc, const char **argv)
 	eops.mmap2		 = perf_event__process_mmap2;
 	eops.tracing_data	 = perf_event__process_tracing_data;
 
-	perf_env__init(&host_env);
-	session = __perf_session__new(use_bpf ? NULL : &data, &eops,
-				/*trace_event_repipe=*/false, &host_env);
+	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
@@ -2157,7 +2154,6 @@ static int __cmd_contention(int argc, const char **argv)
 	evlist__put(con.evlist);
 	lock_contention_finish(&con);
 	perf_session__delete(session);
-	perf_env__exit(&host_env);
 	zfree(&lockhash_table);
 	return err;
 }
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a3442d2d6edf..e52ee42d7e0f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1658,7 +1658,6 @@ int cmd_top(int argc, const char **argv)
 		NULL
 	};
 	int status = hists__init();
-	struct perf_env host_env;
 
 	if (status < 0)
 		return status;
@@ -1672,7 +1671,6 @@ int cmd_top(int argc, const char **argv)
 	if (top.evlist == NULL)
 		return -ENOMEM;
 
-	perf_env__init(&host_env);
 	status = perf_config(perf_top_config, &top);
 	if (status)
 		goto out_put_evlist;
@@ -1680,11 +1678,7 @@ int cmd_top(int argc, const char **argv)
 	 * Since the per arch annotation init routine may need the cpuid, read
 	 * it here, since we are not getting this from the perf.data header.
 	 */
-	status = perf_env__set_cmdline(&host_env, argc, argv);
-	if (status)
-		goto out_put_evlist;
-
-	status = perf_env__read_cpuid(&host_env);
+	status = perf_env__read_cpuid(host_env());
 	if (status) {
 		/*
 		 * Some arches do not provide a get_cpuid(), so just use pr_debug, otherwise
@@ -1803,7 +1797,7 @@ int cmd_top(int argc, const char **argv)
 		symbol_conf.show_branchflag_count = true;
 
 	if (opts->branch_stack) {
-		status = perf_env__read_core_pmu_caps(&host_env);
+		status = perf_env__read_core_pmu_caps(host_env());
 		if (status) {
 			pr_err("PMU capability data is not available\n");
 			goto out_put_evlist;
@@ -1823,9 +1817,7 @@ int cmd_top(int argc, const char **argv)
 
 	setup_browser(false);
 
-	top.session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
-					  /*trace_event_repipe=*/false,
-					  &host_env);
+	top.session = perf_session__new(/*data=*/NULL, /*tool=*/NULL);
 	if (IS_ERR(top.session)) {
 		status = PTR_ERR(top.session);
 		top.session = NULL;
@@ -1912,7 +1904,7 @@ int cmd_top(int argc, const char **argv)
 			goto out_put_evlist;
 		}
 
-		if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
+		if (evlist__add_bpf_sb_event(top.sb_evlist, host_env())) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
 			status = -EINVAL;
 			evlist__put(top.sb_evlist);
@@ -1936,7 +1928,6 @@ int cmd_top(int argc, const char **argv)
 	evlist__put(top.evlist);
 	perf_session__delete(top.session);
 	annotation_options__exit();
-	perf_env__exit(&host_env);
 
 	return status;
 }
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4094141461f9..fb02fa6dd437 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -142,7 +142,6 @@ struct syscall_fmt {
 };
 
 struct trace {
-	struct perf_env		host_env;
 	struct perf_tool	tool;
 	struct {
 		/** Sorted sycall numbers used by the trace. */
@@ -2121,20 +2120,14 @@ static char *trace__machine__resolve_kernel_addr(void *vmachine, unsigned long l
 	return machine__resolve_kernel_addr(vmachine, addrp, modp);
 }
 
-static int trace__symbols_init(struct trace *trace, int argc, const char **argv,
-			       struct evlist *evlist)
+static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
 {
 	int err = symbol__init(NULL);
 
 	if (err)
 		return err;
 
-	perf_env__init(&trace->host_env);
-	err = perf_env__set_cmdline(&trace->host_env, argc, argv);
-	if (err)
-		goto out;
-
-	trace->host = machine__new_host(&trace->host_env);
+	trace->host = machine__new_host();
 	if (trace->host == NULL) {
 		err = -ENOMEM;
 		goto out;
@@ -2155,10 +2148,8 @@ static int trace__symbols_init(struct trace *trace, int argc, const char **argv,
 					    /*mmap_data=*/false,
 					    /*nr_threads_synthesize=*/1);
 out:
-	if (err) {
-		perf_env__exit(&trace->host_env);
+	if (err)
 		symbol__exit();
-	}
 	return err;
 }
 
@@ -2167,7 +2158,6 @@ static void trace__symbols__exit(struct trace *trace)
 	machine__delete(trace->host);
 	trace->host = NULL;
 
-	perf_env__exit(&trace->host_env);
 	symbol__exit();
 }
 
@@ -4833,7 +4823,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_put_evlist;
 	}
 
-	err = trace__symbols_init(trace, argc, argv, evlist);
+	err = trace__symbols_init(trace, evlist);
 	if (err < 0) {
 		fprintf(trace->output, "Problems initializing symbol libraries!\n");
 		goto out_put_evlist;
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index d60bc929c257..bcbc12295a38 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -32,6 +32,7 @@
 #include "util/build-id.h"
 #include "util/config.h"
 #include "util/debug.h"
+#include "util/env.h"
 #ifdef HAVE_LIBTRACEEVENT
 #include "util/trace-event.h"
 #endif
@@ -380,12 +381,14 @@ static int run_builtin(const struct cmd_struct *p, int argc, const char **argv)
 		use_pager = 1;
 	commit_pager_choice();
 
+	perf_env__set_cmdline(host_env(), argc, argv);
 	status = p->fn(argc, argv);
 	perf_config__exit();
 #ifdef HAVE_LIBTRACEEVENT
 	trace_event__exit();
 #endif
 	exit_browser(status);
+	perf_env__exit(host_env());
 
 	if (status)
 		return status & 0xff;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 130cd6021f93..ac21b083eadc 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -710,12 +710,10 @@ static int do_test_code_reading(bool try_kcore)
 	struct dso *dso;
 	const char *events[] = { "cpu-cycles", "cpu-cycles:u", "cpu-clock", "cpu-clock:u", NULL };
 	int evidx = 0;
-	struct perf_env host_env;
 
 	pid = getpid();
 
-	perf_env__init(&host_env);
-	machine = machine__new_host(&host_env);
+	machine = machine__new_host();
 	if (!machine) {
 		pr_debug("machine__new_host failed\n");
 		goto out_err;
@@ -851,7 +849,6 @@ static int do_test_code_reading(bool try_kcore)
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
 	machine__delete(machine);
-	perf_env__exit(&host_env);
 	tested_sections__free(&tested_sections);
 
 	return err;
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 204663571943..312fc7e8c49a 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -322,7 +322,6 @@ static int run_perf_script(struct test_data *td)
 
 static int test__dlfilter_test(struct test_data *td)
 {
-	struct perf_env host_env;
 	u64 sample_type = TEST_SAMPLE_TYPE;
 	pid_t pid = 12345;
 	pid_t tid = 12346;
@@ -356,8 +355,7 @@ static int test__dlfilter_test(struct test_data *td)
 		return test_result("Failed to find program symbols", TEST_FAIL);
 
 	pr_debug("Creating new host machine structure\n");
-	perf_env__init(&host_env);
-	td->machine = machine__new_host(&host_env);
+	td->machine = machine__new_host();
 
 	td->fd = creat(td->perf_data_file_name, 0644);
 	if (td->fd < 0)
@@ -390,7 +388,6 @@ static int test__dlfilter_test(struct test_data *td)
 
 	err = run_perf_script(td) ? TEST_FAIL : TEST_OK;
 out:
-	perf_env__exit(&host_env);
 	return err;
 }
 
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 9ed78d00fb87..d324c9c09b0b 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -181,7 +181,6 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *th
 noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 				int subtest __maybe_unused)
 {
-	struct perf_env host_env;
 	struct machine *machine;
 	struct thread *thread;
 	int err = -1;
@@ -190,8 +189,7 @@ noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 	callchain_param.record_mode = CALLCHAIN_DWARF;
 	dwarf_callchain_users = true;
 
-	perf_env__init(&host_env);
-	machine = machine__new_live(&host_env, /*kernel_maps=*/true, pid);
+	machine = machine__new_live(/*kernel_maps=*/true, pid);
 	if (!machine) {
 		pr_err("Could not get machine\n");
 		goto out;
@@ -216,7 +214,6 @@ noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
 
  out:
 	machine__delete(machine);
-	perf_env__exit(&host_env);
 	return err;
 }
 
diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index ff6d25f9c043..2fbe61e1a64c 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -5,7 +5,6 @@
 #include <linux/kernel.h>
 #include "debug.h"
 #include "dso.h"
-#include "env.h"
 #include "map.h"
 #include "maps.h"
 #include "tests.h"
@@ -102,12 +101,10 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	};
 	struct map *map_kcore1, *map_kcore2, *map_kcore3;
 	int ret;
-	struct perf_env host_env;
 	struct machine *machine;
 	struct maps *maps;
 
-	perf_env__init(&host_env);
-	machine = machine__new_live(&host_env, /*kernel_maps=*/false, getpid());
+	machine = machine__new_live(/*kernel_maps=*/false, getpid());
 	maps = maps__new(machine);
 
 	TEST_ASSERT_VAL("failed to create machine", machine);
@@ -169,7 +166,6 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	map__zput(map_kcore2);
 	map__zput(map_kcore3);
 	machine__delete(machine);
-	perf_env__exit(&host_env);
 	return TEST_OK;
 }
 
@@ -200,12 +196,10 @@ static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unu
 	struct map *map_split, *map_eclipse;
 	int ret;
 	unsigned int i;
-	struct perf_env host_env;
 	struct machine *machine;
 	struct maps *maps;
 
-	perf_env__init(&host_env);
-	machine = machine__new_live(&host_env, /*kernel_maps=*/false, getpid());
+	machine = machine__new_live(/*kernel_maps=*/false, getpid());
 	maps = maps__new(machine);
 
 	TEST_ASSERT_VAL("failed to create machine", machine);
@@ -249,7 +243,6 @@ static int test__maps__fixup_overlap_and_insert(struct test_suite *t __maybe_unu
 
 	maps__zput(maps);
 	machine__delete(machine);
-	perf_env__exit(&host_env);
 	return TEST_OK;
 }
 
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 0c5619c6e6e9..7559123983c5 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -156,7 +156,6 @@ static int synth_process(struct machine *machine)
 
 static int mmap_events(synth_cb synth)
 {
-	struct perf_env host_env;
 	struct machine *machine;
 	int err, i;
 
@@ -169,8 +168,7 @@ static int mmap_events(synth_cb synth)
 	 */
 	TEST_ASSERT_VAL("failed to create threads", !threads_create());
 
-	perf_env__init(&host_env);
-	machine = machine__new_host(&host_env);
+	machine = machine__new_host();
 
 	dump_trace = verbose > 1 ? 1 : 0;
 
@@ -212,7 +210,6 @@ static int mmap_events(synth_cb synth)
 	}
 
 	machine__delete(machine);
-	perf_env__exit(&host_env);
 	return err;
 }
 
diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index d3180db45ee6..dce397f92006 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -18,18 +18,15 @@
 #include "tests.h"
 
 struct test_info {
-	struct perf_env host_env;
 	struct machine *machine;
 	struct thread *thread;
 };
 
 static int init_test_info(struct test_info *ti)
 {
-	perf_env__init(&ti->host_env);
-	ti->machine = machine__new_host(&ti->host_env);
+	ti->machine = machine__new_host();
 	if (!ti->machine) {
 		pr_debug("machine__new_host() failed!\n");
-		perf_env__exit(&ti->host_env);
 		return TEST_FAIL;
 	}
 
@@ -37,7 +34,6 @@ static int init_test_info(struct test_info *ti)
 	ti->thread = machine__findnew_thread(ti->machine, 100, 100);
 	if (!ti->thread) {
 		pr_debug("machine__findnew_thread() failed!\n");
-		perf_env__exit(&ti->host_env);
 		return TEST_FAIL;
 	}
 
@@ -48,7 +44,6 @@ static void exit_test_info(struct test_info *ti)
 {
 	thread__put(ti->thread);
 	machine__delete(ti->machine);
-	perf_env__exit(&ti->host_env);
 }
 
 struct dso_map {
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index b7095519419e..dfba9ddeacb7 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -312,10 +312,8 @@ void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
 	pid_t pid = getpid();
 	struct machine *machine;
 	struct thread *thread = NULL;
-	struct perf_env host_env;
 
-	perf_env__init(&host_env);
-	machine = machine__new_live(&host_env, /*kernel_maps=*/false, pid);
+	machine = machine__new_live(/*kernel_maps=*/false, pid);
 
 	if (machine)
 		thread = machine__find_thread(machine, pid, pid);
@@ -328,7 +326,6 @@ void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
 		 */
 		backtrace_symbols_fd(stackdump, stackdump_size, fileno(file));
 		machine__delete(machine);
-		perf_env__exit(&host_env);
 		return;
 	}
 #endif
@@ -355,7 +352,6 @@ void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
 	}
 	thread__put(thread);
 	machine__delete(machine);
-	perf_env__exit(&host_env);
 }
 
 /* Obtain a backtrace and print it to stdout. */
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 4ab46ca6b4ef..1fe6ce84e607 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -13,6 +13,7 @@
 #include <linux/zalloc.h>
 #include "cgroup.h"
 #include <errno.h>
+#include <pthread.h>
 #include <sys/utsname.h>
 #include <stdlib.h>
 #include <string.h>
@@ -246,6 +247,22 @@ void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version,
 	zfree(&cd_map);
 }
 
+static struct perf_env __host_env = {
+#ifdef HAVE_LIBBPF_SUPPORT
+	.bpf_progs = {
+		.lock = __PERF_RWSEM_INITIALIZER,
+		.infos = RB_ROOT,
+		.btfs = RB_ROOT,
+	},
+#endif
+	.cgroups = {
+		.lock = __PERF_RWSEM_INITIALIZER,
+		.tree = RB_ROOT,
+	},
+	.kernel_is_64_bit = -1,
+	.lock = { .lock = __PERF_MUTEX_INITIALIZER },
+};
+
 void perf_env__exit(struct perf_env *env)
 {
 	int i, j;
@@ -313,6 +330,11 @@ void perf_env__init(struct perf_env *env)
 	mutex_init(&env->lock);
 }
 
+struct perf_env *host_env(void)
+{
+	return &__host_env;
+}
+
 static const char *uts_machine(void)
 {
 	static struct utsname uts;
@@ -409,6 +431,7 @@ int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 	int i;
 
 	/* do not include NULL termination */
+	zfree(&env->cmdline_argv);
 	env->cmdline_argv = calloc(argc, sizeof(char *));
 	if (env->cmdline_argv == NULL)
 		goto out_enomem;
@@ -1110,15 +1133,10 @@ bool perf_env__is_x86_amd_cpu(struct perf_env *env)
 
 bool x86__is_amd_cpu(void)
 {
-	struct perf_env env = { .total_mem = 0, };
-	bool is_amd;
+	struct perf_env *env = host_env();
 
-	perf_env__init(&env);
-	perf_env__cpuid(&env);
-	is_amd = perf_env__is_x86_amd_cpu(&env);
-	perf_env__exit(&env);
-
-	return is_amd;
+	perf_env__cpuid(env);
+	return perf_env__is_x86_amd_cpu(env);
 }
 
 bool perf_env__is_x86_intel_cpu(struct perf_env *env)
@@ -1134,13 +1152,8 @@ bool perf_env__is_x86_intel_cpu(struct perf_env *env)
 
 bool x86__is_intel_cpu(void)
 {
-	struct perf_env env = { .total_mem = 0, };
-	bool is_intel;
-
-	perf_env__init(&env);
-	perf_env__cpuid(&env);
-	is_intel = perf_env__is_x86_intel_cpu(&env);
-	perf_env__exit(&env);
+	struct perf_env *env = host_env();
 
-	return is_intel;
+	perf_env__cpuid(env);
+	return perf_env__is_x86_intel_cpu(env);
 }
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 23d35425efe3..134102148a5c 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -221,6 +221,16 @@ const char *perf_env__cpuid(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
 void perf_env__init(struct perf_env *env);
+
+/**
+ * host_env() - Return the singleton struct perf_env for the live host.
+ *
+ * Returns a pointer to the statically initialized global struct perf_env
+ * representing the live host.
+ *
+ * Return: Pointer to the live host's struct perf_env.
+ */
+struct perf_env *host_env(void);
 #ifdef HAVE_LIBBPF_SUPPORT
 bool __perf_env__insert_bpf_prog_info(struct perf_env *env,
 				      struct bpf_prog_info_node *info_node);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9eec6deee190..b6f86f557caf 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -670,6 +670,9 @@ static int write_cmdline(struct feat_fd *ff,
 	char pbuf[MAXPATHLEN], *buf;
 	int i, ret, n;
 
+	if (!env->cmdline_argv)
+		env = host_env();
+
 	/* actual path to perf binary */
 	buf = perf_exe(pbuf, MAXPATHLEN);
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5eb5efa4eb90..999dd3e3c643 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -130,7 +130,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	return err;
 }
 
-static struct machine *__machine__new_host(struct perf_env *host_env, bool kernel_maps)
+static struct machine *__machine__new_host(bool kernel_maps)
 {
 	struct machine *machine = malloc(sizeof(*machine));
 
@@ -146,13 +146,13 @@ static struct machine *__machine__new_host(struct perf_env *host_env, bool kerne
 		free(machine);
 		return NULL;
 	}
-	machine->env = host_env;
+	machine->env = host_env();
 	return machine;
 }
 
-struct machine *machine__new_host(struct perf_env *host_env)
+struct machine *machine__new_host(void)
 {
-	return __machine__new_host(host_env, /*kernel_maps=*/true);
+	return __machine__new_host(/*kernel_maps=*/true);
 }
 
 static int mmap_handler(const struct perf_tool *tool __maybe_unused,
@@ -172,9 +172,9 @@ static int machine__init_live(struct machine *machine, pid_t pid)
 						  mmap_handler, machine, true);
 }
 
-struct machine *machine__new_live(struct perf_env *host_env, bool kernel_maps, pid_t pid)
+struct machine *machine__new_live(bool kernel_maps, pid_t pid)
 {
-	struct machine *machine = __machine__new_host(host_env, kernel_maps);
+	struct machine *machine = __machine__new_host(kernel_maps);
 
 	if (!machine)
 		return NULL;
@@ -186,9 +186,9 @@ struct machine *machine__new_live(struct perf_env *host_env, bool kernel_maps, p
 	return machine;
 }
 
-struct machine *machine__new_kallsyms(struct perf_env *host_env)
+struct machine *machine__new_kallsyms(void)
 {
-	struct machine *machine = machine__new_host(host_env);
+	struct machine *machine = machine__new_host();
 	/*
 	 * FIXME:
 	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitly
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 973a59f7c26a..be562b989c26 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -177,9 +177,31 @@ struct thread *machine__findnew_guest_code(struct machine *machine, pid_t pid);
 void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size);
 void machines__set_comm_exec(struct machines *machines, bool comm_exec);
 
-struct machine *machine__new_host(struct perf_env *host_env);
-struct machine *machine__new_kallsyms(struct perf_env *host_env);
-struct machine *machine__new_live(struct perf_env *host_env, bool kernel_maps, pid_t pid);
+/**
+ * machine__new_host() - Allocate and initialize a struct machine for the live
+ *                       host with kernel maps populated.
+ *
+ * Return: Pointer to the newly allocated struct machine, or NULL on failure.
+ */
+struct machine *machine__new_host(void);
+
+/**
+ * machine__new_kallsyms() - Allocate and initialize a struct machine for the
+ *                           live host and load /proc/kallsyms.
+ *
+ * Return: Pointer to the newly allocated struct machine, or NULL on failure.
+ */
+struct machine *machine__new_kallsyms(void);
+
+/**
+ * machine__new_live() - Allocate and initialize a struct machine for live
+ *                       inspection of @pid on the host.
+ * @kernel_maps: Whether to create kernel maps on the machine.
+ * @pid: Process ID whose mmap events should be synthesized.
+ *
+ * Return: Pointer to the newly allocated struct machine, or NULL on failure.
+ */
+struct machine *machine__new_live(bool kernel_maps, pid_t pid);
 int machine__init(struct machine *machine, const char *root_dir, pid_t pid);
 void machine__exit(struct machine *machine);
 void machine__delete_threads(struct machine *machine);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f3ba70d4f76b..5ca6b93d8a2a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -583,13 +583,8 @@ size_t default_breakpoint_len(void)
 #if defined(__i386__)
 	static int len;
 
-	if (len == 0) {
-		struct perf_env env = {};
-
-		perf_env__init(&env);
-		len = perf_env__kernel_is_64_bit(&env) ? sizeof(u64) : sizeof(long);
-		perf_env__exit(&env);
-	}
+	if (len == 0)
+		len = perf_env__kernel_is_64_bit(host_env()) ? sizeof(u64) : sizeof(long);
 	return len;
 #elif defined(__aarch64__)
 	return 4;
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 1534280c0c1d..d042d8f69f59 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -74,14 +74,12 @@ int e_snprintf(char *str, size_t size, const char *format, ...)
 }
 
 static struct machine *host_machine;
-static struct perf_env host_env;
 
 /* Initialize symbol maps and path of vmlinux/modules */
 int init_probe_symbol_maps(bool user_only)
 {
 	int ret;
 
-	perf_env__init(&host_env);
 	symbol_conf.allow_aliases = true;
 	ret = symbol__init(NULL);
 	if (ret < 0) {
@@ -95,7 +93,7 @@ int init_probe_symbol_maps(bool user_only)
 	if (symbol_conf.vmlinux_name)
 		pr_debug("Use vmlinux: %s\n", symbol_conf.vmlinux_name);
 
-	host_machine = machine__new_host(&host_env);
+	host_machine = machine__new_host();
 	if (!host_machine) {
 		pr_debug("machine__new_host() failed.\n");
 		symbol__exit();
@@ -112,7 +110,6 @@ void exit_probe_symbol_maps(void)
 	machine__delete(host_machine);
 	host_machine = NULL;
 	symbol__exit();
-	perf_env__exit(&host_env);
 }
 
 static struct ref_reloc_sym *kernel_get_ref_reloc_sym(struct map **pmap)
diff --git a/tools/perf/util/rwsem.h b/tools/perf/util/rwsem.h
index b102d8143181..d2bf722e409c 100644
--- a/tools/perf/util/rwsem.h
+++ b/tools/perf/util/rwsem.h
@@ -18,6 +18,12 @@ struct LOCKABLE rw_semaphore {
 #endif
 };
 
+#if RWS_ERRORCHECK
+#define __PERF_RWSEM_INITIALIZER { .mtx = { .lock = __PERF_MUTEX_INITIALIZER } }
+#else
+#define __PERF_RWSEM_INITIALIZER { .lock = PTHREAD_RWLOCK_INITIALIZER }
+#endif
+
 int init_rwsem(struct rw_semaphore *sem);
 int exit_rwsem(struct rw_semaphore *sem);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f35d6867e816..6ff8d97dcf7d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -151,8 +151,7 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 
 struct perf_session *__perf_session__new(struct perf_data *data,
 					 struct perf_tool *tool,
-					 bool trace_event_repipe,
-					 struct perf_env *host_env)
+					 bool trace_event_repipe)
 {
 	int ret = -ENOMEM;
 	struct perf_session *session = zalloc(sizeof(*session));
@@ -206,8 +205,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);
 		}
 	} else  {
-		assert(host_env != NULL);
-		session->machines.host.env = host_env;
+		session->machines.host.env = host_env();
 	}
 	if (session->evlist)
 		evlist__set_session(session->evlist, session);
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index ac5803d5fb4e..1e0bef9951d1 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -107,15 +107,31 @@ struct decomp {
 
 struct perf_tool;
 
+/**
+ * __perf_session__new() - Allocate and initialize a new struct perf_session.
+ * @data: Input/output perf_data descriptor, or NULL for a live host session.
+ * @tool: Event processing callbacks, or NULL.
+ * @trace_event_repipe: Whether to repipe trace event records to stdout.
+ *
+ * When @data is NULL, associates the session's host machine with host_env().
+ *
+ * Return: Pointer to the new session, or an ERR_PTR() on failure.
+ */
 struct perf_session *__perf_session__new(struct perf_data *data,
 					 struct perf_tool *tool,
-					 bool trace_event_repipe,
-					 struct perf_env *host_env);
+					 bool trace_event_repipe);
 
+/**
+ * perf_session__new() - Allocate and initialize a new struct perf_session.
+ * @data: Input/output perf_data descriptor, or NULL for a live host session.
+ * @tool: Event processing callbacks, or NULL.
+ *
+ * Return: Pointer to the new session, or an ERR_PTR() on failure.
+ */
 static inline struct perf_session *perf_session__new(struct perf_data *data,
 						     struct perf_tool *tool)
 {
-	return __perf_session__new(data, tool, /*trace_event_repipe=*/false, /*host_env=*/NULL);
+	return __perf_session__new(data, tool, /*trace_event_repipe=*/false);
 }
 
 void perf_session__delete(struct perf_session *session);
-- 
2.56.1.703.gf848ed807c-goog

