Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7232F8EB3
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303953; cv=none; b=PO2FaduXDt7jwR0Ca0Ulo4tXzfKLnlrimq4AHjus9qNmo3Buv4AZjWytsFh90iWhLUUwYRhqSveEHCmbjjSSvnMyvpZur048ikUVaHTVGrnm+taFUsN0CzOZMtPd3hlZKD4UfwGISIo3PSeuqeQonbIdEc8qyisB/Xio6HCUt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303953; c=relaxed/simple;
	bh=sVa6XkCqKTyPUh3P12uejKFJIjcesebPOuHFktxmH6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VM2k/iYE4C9FnMN/7GOxdYeYYQkwlBl6zWGtjO0Dm8au2gZSPAqnL47q4wiDyVWCX0Y4YJsG5fxZvkZUcLos1CZJBaq2LWOgLuHLqPCYMU99ZSuDBZ13qI9UxdOrqEquveEzyrISh7C/+mSV8e+qNgIXx6CvqMIfIYI5oShL2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qlheaav/; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qlheaav/"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135916eefa0so4934207c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303951; x=1779908751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXWHz0VDWKmAWtizv8oiF2z47/FgfBkmpN/8lLb9ot8=;
        b=Qlheaav/9nBBbkQuZd/n9jW/Z3C+t7Y5mjXkTMTgHRV7Y7GaZa4bep0d7wnrIx/gxL
         VIP7tazTx5bPq8FJB5S0AuuHmTptzZAu5erUxfwv333vkMYmtt2LLEqfCe1KeuetWpll
         cXu2hA28qQHJ+iPrUuiSZLzZou7dldmoUQmMDkBtPln21isflWFQlW7MNeKwD7wokXFp
         vJfeVWsaY4wqtlnd6Dc/J4QZCjFy6X27uDBobNFQEBeMHC4odwsYlQ8+eH9hx3lUqqem
         NouFvFbgEs8tAUEEiRhyj53FzsfupdsM08l42yC+R28PxsdD7dBNVPzPWKqiRyjX7lvo
         KVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303951; x=1779908751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXWHz0VDWKmAWtizv8oiF2z47/FgfBkmpN/8lLb9ot8=;
        b=C2Hywaj9JOmcV+UtQTB/GXIroPSf5uBCbrqM7g33+2gC7Yh6nPLE0QC7BR1AU7Ghmc
         LyAdXFhDO0WjVgH3fZARNqwqbk3zcXKM1rYlL/W5LbR8fqqYy30FkTy2uruEyDxYWaey
         qX89twDRCsKsfNYOByRbzz3saEN7r0GuxchsZ5FmdjLbnTDKSVHTrO4lG7EmLZm5JJYB
         Hvn+uaeQouNeIp0UkGebP/yuI0+icypG3ugagBgmbOWtQgaN/oenWSy+ka1+O2XuH+CJ
         AUn/gSowRLhCNu62Xp466eH8gJie8xJWXEwBM5bL4vNr+RLWV5q9tXG/C39iDnxRU/bw
         +Shw==
X-Forwarded-Encrypted: i=1; AFNElJ8e9JBEdX6HxItS04XfQIWEWcYCWPSu6uXz95d4L0nKHLcEWTWrfZtNUc+cMJZPz9WSrxA+H/D7Ks+1ccAvaCgV@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMavDNzFe+WMUt1CW8EsIGm4E0QkcsmHH/LXFXmg5QKtkKE7X
	WAFHB3IeWtA3Cf4+4jlNgn9ahPBpD3tq0nayhbVqh5KTMW4cHnU/csVgYGy0qcsOqkFkm69RHP2
	ECqX9AtNMJQ==
X-Received: from dltt15.prod.google.com ([2002:a05:701a:c96f:b0:135:bf99:14c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4393:b0:11b:1c7e:27d0
 with SMTP id a92af1059eb24-13503cedc7bmr13214138c88.0.1779303950946; Wed, 20
 May 2026 12:05:50 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:10 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-5-irogers@google.com>
Subject: [PATCH v14 04/32] perf trace: Don't pass evsel with sample
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
 tools/perf/builtin-trace.c | 55 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e8aabd7a72fe..eca578212def 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -536,12 +536,12 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
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
@@ -2749,8 +2749,8 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	return printed;
 }
 
-static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
-				 struct perf_sample *sample, struct thread *thread)
+static int trace__fprintf_sample(struct trace *trace, struct perf_sample *sample,
+				 struct thread *thread)
 {
 	int printed = 0;
 
@@ -2758,7 +2758,7 @@ static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
 		double ts = (double)sample->time / NSEC_PER_MSEC;
 
 		printed += fprintf(trace->output, "%22s %10.3f %s %d/%d [%d]\n",
-				   evsel__name(evsel), ts,
+				   evsel__name(sample->evsel), ts,
 				   thread__comm_str(thread),
 				   sample->pid, sample->tid, sample->cpu);
 	}
@@ -2813,7 +2813,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	void *args;
 	int printed = 0;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	int id = perf_evsel__sc_tp_uint(id, sample), err = -1;
 	int augmented_args_size = 0, e_machine;
 	void *augmented_args = NULL;
 	struct syscall *sc;
@@ -2828,9 +2828,9 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	trace__fprintf_sample(trace, evsel, sample, thread);
+	trace__fprintf_sample(trace, sample, thread);
 
-	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
+	args = perf_evsel__sc_tp_ptr(args, sample);
 
 	if (ttrace->entry_str == NULL) {
 		ttrace->entry_str = malloc(trace__entry_str_size);
@@ -2888,12 +2888,11 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
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
@@ -2903,7 +2902,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 	e_machine = thread__e_machine(thread, trace->host, /*e_flags=*/NULL);
-	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	sc = trace__syscall_info(trace, sample->evsel, e_machine, id);
 	if (sc == NULL)
 		goto out_put;
 	ttrace = thread__trace(thread, trace);
@@ -2914,7 +2913,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
+	args = perf_evsel__sc_tp_ptr(args, sample);
 	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
 	printed += syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%.*s", (int)printed, msg);
@@ -2924,10 +2923,11 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
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
@@ -2962,7 +2962,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	u64 duration = 0;
 	bool duration_calculated = false;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
+	int id = perf_evsel__sc_tp_uint(id, sample), err = -1, callchain_ret = 0, printed = 0;
 	int alignment = trace->args_alignment, e_machine;
 	struct syscall *sc;
 	struct thread_trace *ttrace;
@@ -2976,9 +2976,9 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	trace__fprintf_sample(trace, evsel, sample, thread);
+	trace__fprintf_sample(trace, sample, thread);
 
-	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
+	ret = perf_evsel__sc_tp_uint(ret, sample);
 
 	if (trace->summary)
 		thread__update_stats(thread, ttrace, id, sample, ret, trace);
@@ -3000,7 +3000,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out;
@@ -3217,9 +3217,10 @@ static void bpf_output__fprintf(struct trace *trace,
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
@@ -3302,7 +3303,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out;
@@ -3323,7 +3324,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		trace__fprintf_comm_tid(trace, thread, trace->output);
 
 	if (evsel == trace->syscalls.events.bpf_output) {
-		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
+		int id = perf_evsel__sc_tp_uint(id, sample);
 		int e_machine = thread
 			? thread__e_machine(thread, trace->host, /*e_flags=*/NULL)
 			: EM_HOST;
@@ -3331,7 +3332,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 		if (sc) {
 			fprintf(trace->output, "%s(", sc->name);
-			trace__fprintf_sys_enter(trace, evsel, sample);
+			trace__fprintf_sys_enter(trace, sample);
 			fputc(')', trace->output);
 			goto newline;
 		}
@@ -3351,13 +3352,13 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
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
@@ -3416,7 +3417,7 @@ static int trace__pgfault(struct trace *trace,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out_put;
-- 
2.54.0.746.g67dd491aae-goog

