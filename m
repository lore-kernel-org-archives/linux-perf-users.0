Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585073FE379
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034947; cv=none; b=Yjyn6pY9JLgXppQpM4+h1oxMpMxkAc+Q5SadW2kE8X2TILAzwTGGXBfh1gr9SChiM4h+vFQSkUaHYll2CAaJ+onb8/uV1ybzjfFRMw0ZM+vtKpXg6IU6y9IZialfevJ3GRFd2fV7VopPj8bYGUDs+A/gEPQd1Qy6UiZV5a14tPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034947; c=relaxed/simple;
	bh=7go6KH1f3MRrSV2N10nQTQvGj7EcQvDoUUi6BghuVA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ufyQWzEgM1fbKSANXX3OGO32BJdlKQJYa5j6ITLUOlu9kWgHbM/+NO5DoI9kB5h1/2/m0SeLNChZ4DIjFmk1J8YwVqWtfnxHvZRlNVWlYhOd0bD1d4YCio1tLJCEC0++0fz6Tg64I1+5nFYGXZUI74BlCTlvDqIQIXYmHclemXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ji8lCGY7; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ji8lCGY7"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12711ec96fbso1213899c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034943; x=1774639743; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5uGW7BmleBXHu5cFW50MFeLRqZwmLQ6nuaMrUqXSvvk=;
        b=Ji8lCGY7Y0fk1lzmo5rQiGU9lXL3+JGtZ/0hfEGZR9AeyKL4tdvALnM9xWIjDafP6q
         yf3AtXUObrRD5g74UkCUBa1lLl0ECOk+1aCZtYWvXk0f9oNWTLc/cf46HqrDug9WeItl
         TKNyWaBTeG63Zm2IwNZGAhtnrDIjUdB6tT+MeWtYwqkefgT17/SYdyY2kusQEi4VoW3p
         ixWAWszVEphfZbsacO7r9GQL5zwXsunokAj71Nd+Tj8yR9y3NgQZV2g3pHhxlKeRTBuv
         50k/i5tYdObe04Cf9lmb0nm6WY0wxPVyqlZOVmY+uvi5+Yv19tceuZhzSSy6l4ngu+e5
         b2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034943; x=1774639743;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uGW7BmleBXHu5cFW50MFeLRqZwmLQ6nuaMrUqXSvvk=;
        b=pZmQUKFNhOg/G6/6M1vAA19N2ISE9ezYo0xhhqsdp2+odcJcimwwVg/9NMTo5ugNGX
         5lmnsZg3LyGHlKD8mRWQpKS2GVfzK3nBKEBM2gqxeUluvEytCy0lKRZV3RWeR9gACKvy
         ocNCUYiHzitUAsm9ITVRv4crHV8DPsbYkOYXNlCtkqscIu5C/XR0BodfOJz9oFHGyUSp
         nLcRbfpeJpdFvEHh5QYypl68wAMb5AFxOTe/zqbRvhuS6/CUIkfIPREEZxlzZjDAMYWN
         Dqs1+H6Nlk4RRnsXOgRnl/4dyKH4ITuqJzOYnhylkOzMF7OdL+RSPoqU2AmWawLQ7WE3
         D/WA==
X-Forwarded-Encrypted: i=1; AJvYcCWQkLeBSpqz08HQZrRMNW/qnNI6NDxItYtge1Q8dXxONvQtnyI24Ko0DL94mUaZ8YlQroPRzOa/A0/lzFnFVmIb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KNHaArXy7YutJeU2O4LQxxl0S1OCw6TUAAXEds0mk4Z1yXgP
	EIfL8T4TaHL5f8QKnNaaPqoaboN2vE0IumfHER72JHBFYcT1MnUZJO4xnfUfbEjwgURRmrdbuk/
	EV0p69eJjXA==
X-Received: from dlaj14.prod.google.com ([2002:a05:701b:280e:b0:128:d50c:936e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec17:b0:127:3915:76b2
 with SMTP id a92af1059eb24-12a726abb8fmr1946084c88.27.1774034942857; Fri, 20
 Mar 2026 12:29:02 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:23 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-22-irogers@google.com>
Subject: [PATCH v4 21/25] perf trace: Don't pass evsel with sample
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

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. In trace__handle_event try to use the evsel from the
sample to avoid recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 51 ++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 385a9ac2ae96..6fbdb5799e81 100644
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
2.53.0.959.g497ff81fa9-goog

