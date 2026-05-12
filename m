Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA683A4F58
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625033; cv=none; b=b9ryfdqBplQGv7WDuL1ZuxFjD30ZtCDn9/vGjr3di0U1BUvhZEzEXTtMcisQcC3tqwxyWLQPn/9DDvNG92voYj+CaFCOZLdW+Y1jFKXPq25mgVSYp0CC+eSuOQ6jiAPgJnGWxYjioYbNZdy2PWmbdglDcoXNcTDdhEP8pDo52Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625033; c=relaxed/simple;
	bh=QBgh72P5xvWIUb1yYgY3zYQOa7gEUxYwH5w4c23lkMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q/Es8LV6q+NjD5ie8ehkgxvfGmqQIhv6Wi04Xf0rs0/aXQsM3xGG+qZDVckDUbKlJQP3eP5+5sbnNhACuI64HesW05L++WQbdbMAnUaseCt+bWHCzTjgcsm2D0d+/oUpwWuqR1p0Y7SJ8Z+VZPJvVwdV6C6E92qGn4J+YKhlkt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJsDTbRE; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJsDTbRE"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312cff948so6735540c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625030; x=1779229830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9sKNLgtA1MIzv28MRw9zsWgUc2FhW4xS85IPLOlO9gU=;
        b=KJsDTbREXnDIC6Sri0+gQL9lxvXQs61N3P3xb29fOkd8RcS4OoVPoejhRQ7TXDEaCH
         /Mx9H1+90UaRVeYLRpYAj8HtcnVljgtIDqdXdL2L7uvDSmAQ4wTo3IoXIcb4XgWG8a/u
         OFCFGZEUoigHOGmjng5zxkzJVVzz7ktM5SqU3zjL3cnpaIK4GM4fI/fK72dTl8tFRAwK
         p20tfXzxHpGRSyONSBKXt8ldoIMVMLPKOu8/7IpEyE+bLPumyCmvOdW84XopsJkM/vOv
         K/ml/GxyCapdXreUmhx1J2pgae34RsnVKtOhXrjZRxPB+YD4s4gBJ4FUWe/+cdt1uAcK
         //gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625030; x=1779229830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sKNLgtA1MIzv28MRw9zsWgUc2FhW4xS85IPLOlO9gU=;
        b=jym8nUzi2c+nQ+5FuKwmGthmkDsPqz6n8jfeRiV0ve8knzaRks1aonT5brbJJPdd8p
         0kCIr0OFmYT+bE4cz6C5k3UedMuZLVyqPfUPe1rAKQHMprEz+hEteueB1zUrR6+qAKk0
         XdHCJFCNWFO4/W6ziOn7VOT8dLmxAfsl4D+jsSbwZsmfVXXeXbmlh4NrrWWiq8ZzjFwl
         VwXmhTjn0v7mIVfGc1tDdxIRtO21fRk/7kWxxdNF/a+ONvwJRvL5m7VUfTyBCG+UX7iW
         sp0MrK504uIaTOIj4WsQiwHuBjJDEQ3piCWQMIFsnT4nzz4KpiijmC2aFbrTP4ssFTYT
         qI+w==
X-Forwarded-Encrypted: i=1; AFNElJ/UkI0FreS+sYOvHCC+rX/I8s5t8Q94s7zB0yAAGx+W5B48hDk6WdLGKZ7rj3RjaFBy9khsPNe86F67qc7+BgGd@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQ1sPh2kQuRcJ7rZlR3HbkFNTBHYgRW2TRIKAZrAqPg/RV3ZJ
	Xz9cmC6lgRQWYyvUdlOLVCGlB8P0aj3o9JCV1MpBtCAvwF2pn3FN3wooTyqSkqs04SoyMhD+MsH
	mcSh3fndueQ==
X-Received: from dlboy14.prod.google.com ([2002:a05:7022:128e:b0:12b:fe5e:215])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e11:b0:130:9b78:b17b
 with SMTP id a92af1059eb24-13436babbacmr433454c88.38.1778625029693; Tue, 12
 May 2026 15:30:29 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:33 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-5-irogers@google.com>
Subject: [PATCH v13 04/32] perf trace: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample now contains the evsel and so don't unnecessarily pass the
evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 55 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f05782f03d6c..7f40cc81fd21 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -535,12 +535,12 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 	return NULL;
 }
 
-#define perf_evsel__sc_tp_uint(evsel, name, sample) \
-	({ struct syscall_tp *fields = __evsel__syscall_tp(evsel); \
+#define perf_evsel__sc_tp_uint(name, sample) \
+	({ struct syscall_tp *fields = __evsel__syscall_tp(sample->evsel); \
 	   fields->name.integer(&fields->name, sample); })
 
-#define perf_evsel__sc_tp_ptr(evsel, name, sample) \
-	({ struct syscall_tp *fields = __evsel__syscall_tp(evsel); \
+#define perf_evsel__sc_tp_ptr(name, sample) \
+	({ struct syscall_tp *fields = __evsel__syscall_tp(sample->evsel); \
 	   fields->name.pointer(&fields->name, sample); })
 
 size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_suffix, int val)
@@ -2721,8 +2721,8 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	return printed;
 }
 
-static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
-				 struct perf_sample *sample, struct thread *thread)
+static int trace__fprintf_sample(struct trace *trace, struct perf_sample *sample,
+				 struct thread *thread)
 {
 	int printed = 0;
 
@@ -2730,7 +2730,7 @@ static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
 		double ts = (double)sample->time / NSEC_PER_MSEC;
 
 		printed += fprintf(trace->output, "%22s %10.3f %s %d/%d [%d]\n",
-				   evsel__name(evsel), ts,
+				   evsel__name(sample->evsel), ts,
 				   thread__comm_str(thread),
 				   sample->pid, sample->tid, sample->cpu);
 	}
@@ -2785,7 +2785,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	void *args;
 	int printed = 0;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	int id = perf_evsel__sc_tp_uint(id, sample), err = -1;
 	int augmented_args_size = 0, e_machine;
 	void *augmented_args = NULL;
 	struct syscall *sc;
@@ -2800,9 +2800,9 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	trace__fprintf_sample(trace, evsel, sample, thread);
+	trace__fprintf_sample(trace, sample, thread);
 
-	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
+	args = perf_evsel__sc_tp_ptr(args, sample);
 
 	if (ttrace->entry_str == NULL) {
 		ttrace->entry_str = malloc(trace__entry_str_size);
@@ -2857,12 +2857,11 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	return err;
 }
 
-static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
-				    struct perf_sample *sample)
+static int trace__fprintf_sys_enter(struct trace *trace, struct perf_sample *sample)
 {
 	struct thread_trace *ttrace;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	int id = perf_evsel__sc_tp_uint(id, sample), err = -1;
 	struct syscall *sc;
 	char msg[1024];
 	void *args, *augmented_args = NULL;
@@ -2872,7 +2871,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 	e_machine = thread__e_machine(thread, trace->host, /*e_flags=*/NULL);
-	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	sc = trace__syscall_info(trace, sample->evsel, e_machine, id);
 	if (sc == NULL)
 		goto out_put;
 	ttrace = thread__trace(thread, trace);
@@ -2883,7 +2882,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
+	args = perf_evsel__sc_tp_ptr(args, sample);
 	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
 	printed += syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%.*s", (int)printed, msg);
@@ -2893,10 +2892,11 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	return err;
 }
 
-static int trace__resolve_callchain(struct trace *trace, struct evsel *evsel,
+static int trace__resolve_callchain(struct trace *trace,
 				    struct perf_sample *sample,
 				    struct callchain_cursor *cursor)
 {
+	struct evsel *evsel = sample->evsel;
 	struct addr_location al;
 	int max_stack = evsel->core.attr.sample_max_stack ?
 			evsel->core.attr.sample_max_stack :
@@ -2931,7 +2931,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	u64 duration = 0;
 	bool duration_calculated = false;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
+	int id = perf_evsel__sc_tp_uint(id, sample), err = -1, callchain_ret = 0, printed = 0;
 	int alignment = trace->args_alignment, e_machine;
 	struct syscall *sc;
 	struct thread_trace *ttrace;
@@ -2945,9 +2945,9 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	trace__fprintf_sample(trace, evsel, sample, thread);
+	trace__fprintf_sample(trace, sample, thread);
 
-	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
+	ret = perf_evsel__sc_tp_uint(ret, sample);
 
 	if (trace->summary)
 		thread__update_stats(thread, ttrace, id, sample, ret, trace);
@@ -2969,7 +2969,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out;
@@ -3184,9 +3184,10 @@ static void bpf_output__fprintf(struct trace *trace,
 	++trace->nr_events_printed;
 }
 
-static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
+static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *sample,
 				       struct thread *thread, void *augmented_args, int augmented_args_size)
 {
+	struct evsel *evsel = sample->evsel;
 	char bf[2048];
 	size_t size = sizeof(bf);
 	const struct tep_event *tp_format = evsel__tp_format(evsel);
@@ -3269,7 +3270,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out;
@@ -3287,7 +3288,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		trace__fprintf_comm_tid(trace, thread, trace->output);
 
 	if (evsel == trace->syscalls.events.bpf_output) {
-		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
+		int id = perf_evsel__sc_tp_uint(id, sample);
 		int e_machine = thread
 			? thread__e_machine(thread, trace->host, /*e_flags=*/NULL)
 			: EM_HOST;
@@ -3295,7 +3296,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 		if (sc) {
 			fprintf(trace->output, "%s(", sc->name);
-			trace__fprintf_sys_enter(trace, evsel, sample);
+			trace__fprintf_sys_enter(trace, sample);
 			fputc(')', trace->output);
 			goto newline;
 		}
@@ -3315,13 +3316,13 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		const struct tep_event *tp_format = evsel__tp_format(evsel);
 
 		if (tp_format && (strncmp(tp_format->name, "sys_enter_", 10) ||
-				  trace__fprintf_sys_enter(trace, evsel, sample))) {
+				  trace__fprintf_sys_enter(trace, sample))) {
 			if (trace->libtraceevent_print) {
 				event_format__fprintf(tp_format, sample->cpu,
 						      sample->raw_data, sample->raw_size,
 						      trace->output);
 			} else {
-				trace__fprintf_tp_fields(trace, evsel, sample, thread, NULL, 0);
+				trace__fprintf_tp_fields(trace, sample, thread, NULL, 0);
 			}
 		}
 	}
@@ -3380,7 +3381,7 @@ static int trace__pgfault(struct trace *trace,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out_put;
-- 
2.54.0.563.g4f69b47b94-goog

