Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8FD391856
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633213; cv=none; b=ixsamCXfsILApwv0q7erlP2TUUJ4ckGAJhPyP1rCNvTu5k4YU5GgiLWu1ksq2VixCMaVmzjv4kjqYjD++sJbGItDsKMOyj53ejMyNgKzTavX6RZh/XpK+uNKgLp+OGKejobB0DQB9ZGcxROzv+oszG9oRUD8UyHVONFmoPeiSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633213; c=relaxed/simple;
	bh=k5i5sAO0y8qY7nlvkKW946Esrzoa6VEd6G/7Q2q0J3k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eMJ2nYTto2OYXqdOQPPZOIEPenZeetE8jf3YN2NjgwVz+x5VsvEWhdPV1B0O0FswO7+xk5mQSZggyrntojflALU7vc5trTeAeJU9yU9es6jY2D64pIGZdds75N9gJZ8NX4Z7LBewrfwfalf/zAiAV7BauiCy8ATrKmtCxD9xSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cR9u2aec; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cR9u2aec"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so8534073eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633210; x=1776238010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WKw7C0m5tQyiuT/6uQYS0H5P1XoW1hNm0eAI6Ck/fE=;
        b=cR9u2aecdmY/tWmNPcm4NZE2CFtvjs00onhzQYEhKDhyrDXbDA/DxsUwdprvcicCHN
         8iJPOterqXIsSY6XDGs7drruGKJBS51ANEG9dsO5yd/l5bWvJQsIP7lw583FAvY6rpSh
         3KmPvfibNySouG7vIUJRJHA+Cvwlc57d409Nc+TQGDoFxlpaNNFELMWnupo3MOGpJxWK
         cLIqkkzxR3NbYXZ9AQ876SvYWOPx2EViS2gQOi6/VeDf0AGZGj1YWxR9gKDHBwW1eaEp
         +yGehtg/AnxJT0gdJnRdEBkvOKBZDZ/WJfRq4NHAh8sU2LRHRc5YbxeyBmGQauWPcy0s
         YqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633210; x=1776238010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WKw7C0m5tQyiuT/6uQYS0H5P1XoW1hNm0eAI6Ck/fE=;
        b=kyz3vk08wHCMCotpM8HJpAcrKSyIHNOxEw4IOUTebM4CKrSFwdk32t7sDHLbvWLxeV
         l3LiyezChxNwP/bi32lOWl4JaK6v8Xg/Y6i3vyt8YtIb1uIPdGL3K7D3BIPTZXx6QFUo
         UGV9rwtYsWzL+p9+b0VqrS5ufLpHnoBkHJmtelAejo/FtNUgp6uNnB/Eu6B2nxEW3T8e
         vtFByUKhwk6tgEdbvvoleYnmkvbhJPqnPZUt+t4ggBBCSe9l46ZBUGwXDEV5JFY9zkZd
         CMkos3rGOTU3Z4e+a0IRk6oSHvGxpXcOKm03KgwyTdyeelTLE02GcvFw4TUM4u9dEg3M
         1kvA==
X-Forwarded-Encrypted: i=1; AJvYcCX/vuYnaugc9w0wfpJjfASlcjfyhuPuyT9mF7vbOWE5zSH7eyjtRh8lrzrZaoaw45rm7TNwEwLaGe/QO07rC7Oj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvgci7esEQa2nw5QxuUWSGRkjDhC9014cgSTKKdMob6Yl5sXNb
	dV7zu/DBGwsZSktij4MuonnNu1Lih/j65cdXVcwnNTPPhu5uWbOwYUXhflSRx2GEvz949gHsE0H
	w9Tzi1Bt2Pg==
X-Received: from dyx28.prod.google.com ([2002:a05:693c:821c:b0:2d1:6536:ac8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fe8a:b0:2cc:600d:2ffc
 with SMTP id 5a478bee46e88-2cc601c7d2bmr6087186eec.25.1775633209724; Wed, 08
 Apr 2026 00:26:49 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:25:57 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com> <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-20-irogers@google.com>
Subject: [PATCH v7 19/23] perf trace: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. In trace__handle_event try to use the evsel from the
sample to avoid recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 51 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b694e1219807..4d9459c0cce5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2584,7 +2584,7 @@ static struct syscall *trace__find_syscall(struct trace *trace, int e_machine, i
 	return sc;
 }
 
-typedef int (*tracepoint_handler)(struct trace *trace, struct evsel *evsel,
+typedef int (*tracepoint_handler)(struct trace *trace,
 				  union perf_event *event,
 				  struct perf_sample *sample);
 
@@ -2779,10 +2779,11 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
 	return NULL;
 }
 
-static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
+static int trace__sys_enter(struct trace *trace,
 			    union perf_event *event __maybe_unused,
 			    struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	char *msg;
 	void *args;
 	int printed = 0;
@@ -2925,10 +2926,11 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 	return sample__fprintf_callchain(sample, 38, print_opts, get_tls_callchain_cursor(), symbol_conf.bt_stop_list, trace->output);
 }
 
-static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
+static int trace__sys_exit(struct trace *trace,
 			   union perf_event *event __maybe_unused,
 			   struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	long ret;
 	u64 duration = 0;
 	bool duration_calculated = false;
@@ -3063,7 +3065,7 @@ errno_print: {
 	return err;
 }
 
-static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_unused,
+static int trace__vfs_getname(struct trace *trace,
 			      union perf_event *event __maybe_unused,
 			      struct perf_sample *sample)
 {
@@ -3124,7 +3126,7 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_u
 	return 0;
 }
 
-static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
+static int trace__sched_stat_runtime(struct trace *trace,
 				     union perf_event *event __maybe_unused,
 				     struct perf_sample *sample)
 {
@@ -3146,7 +3148,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 
 out_dump:
 	fprintf(trace->output, "%s: comm=%s,pid=%u,runtime=%" PRIu64 ",vruntime=%" PRIu64 ")\n",
-	       evsel->name,
+	       sample->evsel->name,
 	       perf_sample__strval(sample, "comm"),
 	       (pid_t)perf_sample__intval(sample, "pid"),
 	       runtime,
@@ -3257,10 +3259,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 	return fprintf(trace->output, "%.*s", (int)printed, bf);
 }
 
-static int trace__event_handler(struct trace *trace, struct evsel *evsel,
+static int trace__event_handler(struct trace *trace,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	struct thread *thread;
 	int callchain_ret = 0;
 
@@ -3366,7 +3369,6 @@ static void print_location(FILE *f, struct perf_sample *sample,
 }
 
 static int trace__pgfault(struct trace *trace,
-			  struct evsel *evsel,
 			  union perf_event *event __maybe_unused,
 			  struct perf_sample *sample)
 {
@@ -3395,7 +3397,7 @@ static int trace__pgfault(struct trace *trace,
 	if (ttrace == NULL)
 		goto out_put;
 
-	if (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ) {
+	if (sample->evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ) {
 		ttrace->pfmaj++;
 		trace->pfmaj++;
 	} else {
@@ -3411,7 +3413,7 @@ static int trace__pgfault(struct trace *trace,
 	trace__fprintf_entry_head(trace, thread, 0, true, sample->time, trace->output);
 
 	fprintf(trace->output, "%sfault [",
-		evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
+		sample->evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
 		"maj" : "min");
 
 	print_location(trace->output, sample, &al, false, true);
@@ -3436,7 +3438,8 @@ static int trace__pgfault(struct trace *trace,
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
-		pr_err("Problem processing %s callchain, skipping...\n", evsel__name(evsel));
+		pr_err("Problem processing %s callchain, skipping...\n",
+		       evsel__name(sample->evsel));
 
 	++trace->nr_events_printed;
 out:
@@ -3448,7 +3451,6 @@ static int trace__pgfault(struct trace *trace,
 }
 
 static void trace__set_base_time(struct trace *trace,
-				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	/*
@@ -3460,7 +3462,7 @@ static void trace__set_base_time(struct trace *trace,
 	 * appears in our event stream (vfs_getname comes to mind).
 	 */
 	if (trace->base_time == 0 && !trace->full_time &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
+	    (sample->evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
 		trace->base_time = sample->time;
 }
 
@@ -3480,11 +3482,11 @@ static int trace__process_sample(const struct perf_tool *tool,
 	if (thread && thread__is_filtered(thread))
 		goto out;
 
-	trace__set_base_time(trace, evsel, sample);
+	trace__set_base_time(trace, sample);
 
 	if (handler) {
 		++trace->nr_events;
-		handler(trace, evsel, event, sample);
+		handler(trace, event, sample);
 	}
 out:
 	thread__put(thread);
@@ -3626,32 +3628,33 @@ static void evlist__free_syscall_tp_fields(struct evlist *evlist)
 static void trace__handle_event(struct trace *trace, union perf_event *event, struct perf_sample *sample)
 {
 	const u32 type = event->header.type;
-	struct evsel *evsel;
 
 	if (type != PERF_RECORD_SAMPLE) {
 		trace__process_event(trace, trace->host, event, sample);
 		return;
 	}
 
-	evsel = evlist__id2evsel(trace->evlist, sample->id);
-	if (evsel == NULL) {
+	if (sample->evsel == NULL)
+		sample->evsel = evlist__id2evsel(trace->evlist, sample->id);
+
+	if (sample->evsel == NULL) {
 		fprintf(trace->output, "Unknown tp ID %" PRIu64 ", skipping...\n", sample->id);
 		return;
 	}
 
-	if (evswitch__discard(&trace->evswitch, evsel))
+	if (evswitch__discard(&trace->evswitch, sample->evsel))
 		return;
 
-	trace__set_base_time(trace, evsel, sample);
+	trace__set_base_time(trace, sample);
 
-	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT &&
+	if (sample->evsel->core.attr.type == PERF_TYPE_TRACEPOINT &&
 	    sample->raw_data == NULL) {
 		fprintf(trace->output, "%s sample with no payload for tid: %d, cpu %d, raw_size=%d, skipping...\n",
-		       evsel__name(evsel), sample->tid,
+		       evsel__name(sample->evsel), sample->tid,
 		       sample->cpu, sample->raw_size);
 	} else {
-		tracepoint_handler handler = evsel->handler;
-		handler(trace, evsel, event, sample);
+		tracepoint_handler handler = sample->evsel->handler;
+		handler(trace, event, sample);
 	}
 
 	if (trace->nr_events_printed >= trace->max_events && trace->max_events != ULONG_MAX)
-- 
2.53.0.1213.gd9a14994de-goog

