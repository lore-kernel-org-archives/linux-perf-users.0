Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AEA3D8917
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248876; cv=none; b=jMwnGXUk6e10JQvOSXS3dVro+nMhczvBCAgNaB2waPpNj+AtyCSv1W4nu0z+z7SWEPprVzkKp5zLAZPf8x7o9j7qGgEPffnM/j3qoll/nWD2y0mu2JEOM4+/ODC0CJ/PhCiCNMTtg8OeD8DPkfn0oA030QIoiN1kWRqBR+ep2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248876; c=relaxed/simple;
	bh=DMva335Co4SJ5T4aexBmgvFAwe5lZa5RgB/TZ0G1IzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rI/q8Z+Snd+Fxctd8PULiN8RNGMuE3raBvx8N3qtuzXDp6jXoQqCLrS6jv38eHzaiiNWqc5q8ylBZkYMlh4pKi44jm8SrLxOOq6TaThmakpwwK35VgXAHRK2wZ3W1xTqsHexTiZE2XirB1lrf3AunUD0s6247VX0q/F9ksoU5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TcnZpSG9; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcnZpSG9"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1273dfdaf5dso2164221c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248874; x=1775853674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWh26oU1nkbVHiu8Aju0MEDFTjaq7PVSE7AultiAh+U=;
        b=TcnZpSG9/3yePh52mWy4ERbDKjUHRMtVq0OJwsrskPTzXz7KHCxK4R67ILBq+UQJ+i
         wjHg5cvrj25QkXSIwBhMclOg8xyirEUzJlP7N0kuPf0GX7JDK0Jc/orJdJSfb6D/Q2e2
         0NU7mvQNPgM94LEtOoVuRej4YfnI6PxkEAqj2GlrkXTr+BuDdrW0t9dQaMh5PcKfyR0j
         psP/ymleY9me7PIwQGTKA9YLRIuU87jULXajz12mbkpJJkh+gFeht+uXLqXXoSYvMeSP
         wzQ2Mys9ljfyuDX9FORIDb9u0N7yzVHu9FYuVfJKfMAV17gcZg0xTUW9RbA+F/TLKMf7
         7w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248874; x=1775853674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWh26oU1nkbVHiu8Aju0MEDFTjaq7PVSE7AultiAh+U=;
        b=oszN4fNIch/4OnEKnuNkS6MZpvMYcYquKfoNb28kD9HgzKU4XonS7CM/q7XNnhZzcL
         CCsy0guSXc7n1o4VqTlztskCUzfZN5bH7JzvdO51zJpwojmVuaD6tQ5Jd/drzaWaBBoD
         bhFweYSnd92F6JDdnqpZ8hu84emaTBQ3m7HefkKsXYCiKnfkV8FTDLbShfkICHtVTBd5
         4KH/piEMXZtzL4iOVorgqsB7M3l16mmUzMmby9iOVD8fL1mmZUfPcfwAAMs1cSJcsvSF
         betIX7VFaWxIBSdJfalVMKhnHGKCdu17NJ3uWdskokfaNPzedtwYZz6NJxJxUss63h4r
         u7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWGo/QAeXZM506CKbw8qB21I/P4HegFMQ1UKeI7mZBxnqtBbDfKf/NZWEFsrBKfCbqCOK6V3g0c8kyV2CzaClgs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ZAU078oGfG7/IuVV+Wpm59yqkkZkXI+80OFrg8ykldfD4aVt
	gbWZ1VXh83ikDfYkXc29Brqz2qkhCUT+PYaNedwa/4mpxm5MV+VUI/ERsbOxvv3w+TqZOdKFyYm
	sn9+hGdnXSQ==
X-Received: from dlah11.prod.google.com ([2002:a05:701b:260b:b0:127:82fc:dd48])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1609:b0:123:3301:a718
 with SMTP id a92af1059eb24-12bfac01230mr1754668c88.1.1775248873796; Fri, 03
 Apr 2026 13:41:13 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:13 -0700
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
Message-ID: <20260403204017.2919994-22-irogers@google.com>
Subject: [PATCH v5 21/25] perf trace: Don't pass evsel with sample
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
evsel as well. In trace__handle_event try to use the evsel from the
sample to avoid recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 51 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 161e2e62bf1e..d97d0b1b3762 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2580,7 +2580,7 @@ static struct syscall *trace__find_syscall(struct trace *trace, int e_machine, i
 	return sc;
 }
 
-typedef int (*tracepoint_handler)(struct trace *trace, struct evsel *evsel,
+typedef int (*tracepoint_handler)(struct trace *trace,
 				  union perf_event *event,
 				  struct perf_sample *sample);
 
@@ -2775,10 +2775,11 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
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
@@ -2921,10 +2922,11 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
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
@@ -3059,7 +3061,7 @@ errno_print: {
 	return err;
 }
 
-static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_unused,
+static int trace__vfs_getname(struct trace *trace,
 			      union perf_event *event __maybe_unused,
 			      struct perf_sample *sample)
 {
@@ -3120,7 +3122,7 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_u
 	return 0;
 }
 
-static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
+static int trace__sched_stat_runtime(struct trace *trace,
 				     union perf_event *event __maybe_unused,
 				     struct perf_sample *sample)
 {
@@ -3142,7 +3144,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 
 out_dump:
 	fprintf(trace->output, "%s: comm=%s,pid=%u,runtime=%" PRIu64 ",vruntime=%" PRIu64 ")\n",
-	       evsel->name,
+	       sample->evsel->name,
 	       perf_sample__strval(sample, "comm"),
 	       (pid_t)perf_sample__intval(sample, "pid"),
 	       runtime,
@@ -3253,10 +3255,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
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
 
@@ -3362,7 +3365,6 @@ static void print_location(FILE *f, struct perf_sample *sample,
 }
 
 static int trace__pgfault(struct trace *trace,
-			  struct evsel *evsel,
 			  union perf_event *event __maybe_unused,
 			  struct perf_sample *sample)
 {
@@ -3391,7 +3393,7 @@ static int trace__pgfault(struct trace *trace,
 	if (ttrace == NULL)
 		goto out_put;
 
-	if (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ) {
+	if (sample->evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ) {
 		ttrace->pfmaj++;
 		trace->pfmaj++;
 	} else {
@@ -3407,7 +3409,7 @@ static int trace__pgfault(struct trace *trace,
 	trace__fprintf_entry_head(trace, thread, 0, true, sample->time, trace->output);
 
 	fprintf(trace->output, "%sfault [",
-		evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
+		sample->evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
 		"maj" : "min");
 
 	print_location(trace->output, sample, &al, false, true);
@@ -3432,7 +3434,8 @@ static int trace__pgfault(struct trace *trace,
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
-		pr_err("Problem processing %s callchain, skipping...\n", evsel__name(evsel));
+		pr_err("Problem processing %s callchain, skipping...\n",
+		       evsel__name(sample->evsel));
 
 	++trace->nr_events_printed;
 out:
@@ -3444,7 +3447,6 @@ static int trace__pgfault(struct trace *trace,
 }
 
 static void trace__set_base_time(struct trace *trace,
-				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	/*
@@ -3456,7 +3458,7 @@ static void trace__set_base_time(struct trace *trace,
 	 * appears in our event stream (vfs_getname comes to mind).
 	 */
 	if (trace->base_time == 0 && !trace->full_time &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
+	    (sample->evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
 		trace->base_time = sample->time;
 }
 
@@ -3476,11 +3478,11 @@ static int trace__process_sample(const struct perf_tool *tool,
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
@@ -3622,32 +3624,33 @@ static void evlist__free_syscall_tp_fields(struct evlist *evlist)
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

