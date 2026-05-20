Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA65D3E00A2
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303981; cv=none; b=WDD8d0sX3acHGpKxhEl94pqp4Nq00whQ71PIpAaxDBGqZKpONYjuutolB6ce+wvGYWCZLlYzZg5VY/hcsrolhZdV+2hbQtcg7fUWwvo/vDyJBFF5b8RhkoIX9osyFTZZJWsv8YeWjJmNOlqJTmbGwJkPNbJxcwwpsdXjswypL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303981; c=relaxed/simple;
	bh=+Ne34XhUAkgH5Lm0UQnsUzGNRig+THV6NGlBDhI4O3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MGpCJ8XWVsdChzK/xg7IOabBFl1SqLdDEMgs/MoZ59MRuMcFOSyQCmcDq3PKc0+iI8NyQ2ppH84qrEJhlACMqw1eRXZij1XDmc4kYe9BqnKh9IS0HW9qZ+HJ5UHF/5CAWHCEQSPF44LTNuOyAC5314hd6zOj3bMkpMeifXy2BPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/vGs6Tp; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/vGs6Tp"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f525565b33so6538838eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303979; x=1779908779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18WwON7O2t33npHco2F9upUWp69yLWByrRPlpS+OZ+4=;
        b=c/vGs6Tpunql3+MGddqa0Tirq3CRtQhsGfrCnJb7DSXfv/HrV5hev6qIrCpYookUf9
         4Q9QGm6AGhFuVi36+BG2TDJPLQAZQO0A713pV0N39Ad16i56Z2K3ppOCMfFZfPcx4rjT
         /lZ9RMWaJ03phS1mHiPYPSwRxi2YG5XjGZuFnTOkKeFengPUowTmSYEEXpGofdDoU5q9
         PqoBnRK+ZBB3uVev0Yk1d/vboPDC+4mDBppdMBT7Dmzu02+7XEm6P92T3bn9avnR5wqr
         E7AAsLHOSxMXZHoKfqhfjvzsVbx40ZhYYur+tSrzWLvG8Ozg5BoREUA/SPbh9RnpADht
         OD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303979; x=1779908779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18WwON7O2t33npHco2F9upUWp69yLWByrRPlpS+OZ+4=;
        b=UhBSXUB45q2rlZdgqGvvvRiEdd4GW4C95csB4haMlgFh0GXXI2P+JBOIy2QAOVAzSk
         Dd3usQbYYPfMDfQZTy1wGglwsMZmi41j644+KnyncKxzILJjI36DqMho9SZHilxnnHnH
         GSlaggA7VltPZYb7JCur8V6hk/svqwv8sJkaDjGX5ujg5XkLBKiXuGxBS08TfB5Zd6xQ
         x75A6aI82zEN9FWDsoMjgTZm3hZNO5YOlIHUGsTW6MMcdLZtAVcHfypx3e8590XPUqcU
         1Xbl/hObVNa02u9DweuW4vrWRrJUO0AymFewEPwIfjID1YRzu6vQqHun3aWLt9aDO59K
         k4KA==
X-Forwarded-Encrypted: i=1; AFNElJ8mSWCrAbee0TEQk0QOlTrEvsRtZebZ0BXXCZug/3+zdVApcqLykoLAF66y3kjvG36BChqTKWq9S3rHuLDXVykL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49Y51aVv3MJ0sT8jl4T92ufxnfQFHKew5a0ltxDx88FEvuwYo
	ojaO0C/nnRHAcXEJwmjdbSfSgz83ulrpL1e0WnHTc1U3fLVgobv5LMavPUflzY2YnBK5wE8mQx3
	dJlJaA4jWUg==
X-Received: from dybvt8.prod.google.com ([2002:a05:7301:78c8:b0:2f0:f8f7:8376])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a984:b0:2f2:c336:7736
 with SMTP id 5a478bee46e88-303986712c8mr9317431eec.29.1779303978738; Wed, 20
 May 2026 12:06:18 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:23 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-18-irogers@google.com>
Subject: [PATCH v14 17/32] perf trace: Don't pass evsel with sample
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

Remove the redundant evsel parameter from trace-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c | 52 ++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4bc30ad8fb07..d4fafae853d4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2608,7 +2608,7 @@ static struct syscall *trace__find_syscall(struct trace *trace, int e_machine, i
 	return sc;
 }
 
-typedef int (*tracepoint_handler)(struct trace *trace, struct evsel *evsel,
+typedef int (*tracepoint_handler)(struct trace *trace,
 				  union perf_event *event,
 				  struct perf_sample *sample);
 
@@ -2805,10 +2805,11 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
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
@@ -2954,10 +2955,11 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
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
@@ -3094,7 +3096,7 @@ errno_print: {
 	return err;
 }
 
-static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_unused,
+static int trace__vfs_getname(struct trace *trace,
 			      union perf_event *event __maybe_unused,
 			      struct perf_sample *sample)
 {
@@ -3155,7 +3157,7 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_u
 	return 0;
 }
 
-static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
+static int trace__sched_stat_runtime(struct trace *trace,
 				     union perf_event *event __maybe_unused,
 				     struct perf_sample *sample)
 {
@@ -3177,7 +3179,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 
 out_dump:
 	fprintf(trace->output, "%s: comm=%s,pid=%u,runtime=%" PRIu64 ",vruntime=%" PRIu64 ")\n",
-	       evsel->name,
+	       sample->evsel->name,
 	       perf_sample__strval(sample, "comm"),
 	       (pid_t)perf_sample__intval(sample, "pid"),
 	       runtime,
@@ -3288,10 +3290,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
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
 
@@ -3400,7 +3403,6 @@ static void print_location(FILE *f, struct perf_sample *sample,
 }
 
 static int trace__pgfault(struct trace *trace,
-			  struct evsel *evsel,
 			  union perf_event *event __maybe_unused,
 			  struct perf_sample *sample)
 {
@@ -3429,7 +3431,7 @@ static int trace__pgfault(struct trace *trace,
 	if (ttrace == NULL)
 		goto out_put;
 
-	if (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ) {
+	if (sample->evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ) {
 		ttrace->pfmaj++;
 		trace->pfmaj++;
 	} else {
@@ -3446,7 +3448,7 @@ static int trace__pgfault(struct trace *trace,
 				  sample->cpu, trace->output);
 
 	fprintf(trace->output, "%sfault [",
-		evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
+		sample->evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
 		"maj" : "min");
 
 	print_location(trace->output, sample, &al, false, true);
@@ -3471,7 +3473,8 @@ static int trace__pgfault(struct trace *trace,
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
-		pr_err("Problem processing %s callchain, skipping...\n", evsel__name(evsel));
+		pr_err("Problem processing %s callchain, skipping...\n",
+		       evsel__name(sample->evsel));
 
 	++trace->nr_events_printed;
 out:
@@ -3483,7 +3486,6 @@ static int trace__pgfault(struct trace *trace,
 }
 
 static void trace__set_base_time(struct trace *trace,
-				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	/*
@@ -3495,7 +3497,7 @@ static void trace__set_base_time(struct trace *trace,
 	 * appears in our event stream (vfs_getname comes to mind).
 	 */
 	if (trace->base_time == 0 && !trace->full_time &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
+	    (sample->evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
 		trace->base_time = sample->time;
 }
 
@@ -3515,11 +3517,11 @@ static int trace__process_sample(const struct perf_tool *tool,
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
@@ -3661,32 +3663,34 @@ static void evlist__free_syscall_tp_fields(struct evlist *evlist)
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
+
+		handler(trace, event, sample);
 	}
 
 	if (trace->nr_events_printed >= trace->max_events && trace->max_events != ULONG_MAX)
-- 
2.54.0.746.g67dd491aae-goog

