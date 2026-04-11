Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B93290BA
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890656; cv=none; b=WhmeyWQenD8YTHhKNt80EZXALH0C/1J8g5N7rftTGT7QCaSuLUNelWu50ZMugyZ4c5fovwvtPFvJx0hLn1vaHtG9bJGX9d5Y0BCfrpYCh0m03LLiB2uO2azy67k5IdZ3CCp7mIyD9H1hJ0mzcLLLZC3JpjPF/c1yjEKP6faBOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890656; c=relaxed/simple;
	bh=+6/TgirLyVcX/Kq6q4L3ThQN7uhgHB3Eulb+wJXLUO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=euF+RKkF8TIxd1l+Ps1t5ZQGBuCu96dBw4DV5UNcw0gNKSshi9x7Y343iEPKFanpxkO7FhblffPLgZjUGG4jz+y0qZ0rK/YP97wS1Rzvryw0Aht7gYfsAD1Dq9OOcAoYS+NScRP+wo6fZO7pR2Y6viUDTAtqo6oCn7eSsUKNTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2P/X36Z; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2P/X36Z"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12711ec96fbso6615531c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890654; x=1776495454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=23XNRjKq0mKMLzG+gfCPZj6vfaGkX3d4v88eP/QjFIg=;
        b=d2P/X36ZnuzdtZqRck9Y5iyQXzt3+K6Y8pSZqOgmUMtHkO3pnDqbXjCk/qdBgvD6d5
         A0saTzlkJeD+EI8FYN9AAucLXJnkDRW7+bjTrKaUpZmepnGXOaK4nI9b76+Xk11/2iDF
         i6ifRBKWfPvpcoLYat7/AiHBNihT+P0gqfw+cbfUsYEFEl5PgrZMFBHf+dGIFD6drTp+
         TXQnYStkDhMIdV0ch+H/pwJKGCaO2TDCqihTHDcnPhIGHm4yww7dqSYV8NzykRzhOd8O
         xn36U3N2H6hBoQRKWkGM/2bLlsE6ByVQRZkpkBzVhA1siyxK96vorDBaSTKFKV66nhKG
         dW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890654; x=1776495454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23XNRjKq0mKMLzG+gfCPZj6vfaGkX3d4v88eP/QjFIg=;
        b=FyQPVBJRfIh94l8phUc/ODe3rFW2pu0dluFkTxoGBHXGOoySjw0RKmeLE+8B1c92Sx
         2cCL22OWgIvdOzmf+zVng8eGLbCcy6kO+TJwwm+neHdAG/lwDMx8JMQI2yHa+kSkYuf4
         oEU4ynL+djSwyOHyHYbekI3FrcNOADsLi7ofdYj8PjAwhYp80ag+NwlUnep0FWaqyprA
         alnoiXn4yrOCy3XQJOIJ4UKxOcKwpPy+l2gpt2ZPq3K8po3/elgUnz4uMvfSoFtnxZ6R
         bIEsQ3BerxJmb65/TBxgWUcdDeLsIGHSnrP78OM5c0TsvHQ2NIwwdn3HGQXuoTeCb5iv
         gIEw==
X-Forwarded-Encrypted: i=1; AJvYcCWr0330VY7gkyeQlFZHh6A0ZfdbuLx2vxixqTeLEFWPTJ0ctPYzEZF42ut+G6KgJj+gb5Tqyml9ZoKOWYaOtkHo@vger.kernel.org
X-Gm-Message-State: AOJu0YxNchX//XqnKqhHAvrxC+pTLZF5i8tEKjcA1scpG50Mh+VCLxRL
	nQgta/cSgNT6pGO0PhvSuHkAY6XGBeuubchcyDwMf0SoY81KKtJ6Ng34yt7ESQOf+hJXXuX+eIj
	ure5H7s15xA==
X-Received: from dlbrx1.prod.google.com ([2002:a05:7022:1701:b0:12b:fc6b:1d04])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fe08:b0:128:bac0:2edf
 with SMTP id a92af1059eb24-12c34f1b0c9mr3907906c88.34.1775890653657; Fri, 10
 Apr 2026 23:57:33 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:56:54 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-6-irogers@google.com>
Subject: [PATCH v8 05/29] perf trace: Don't pass evsel with sample
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
2.53.0.1213.gd9a14994de-goog

