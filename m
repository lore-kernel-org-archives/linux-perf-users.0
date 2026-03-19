Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10F402452
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962658; cv=none; b=Fq/zefqkYb37i1/tJ2HWtRuSJHM9LS+qEerNM5avQsnaX6l5Kpn2HiIIYCK7vmuL1hhWicKqt1Er13XXdUAeXKDw9W12onwiQBoJs8imHat5pzpm8MXKOUb42nuQf1TQPYftAKr3brae4RCbN0T+TnHbWb4jJAZKop9d6xYBfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962658; c=relaxed/simple;
	bh=SHgl0S6yaUi+Exc7QlYdhkS+eHNvrRlR5BNXe5kO8sM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c7Jc3JZ3wfY81+ZlKccCIRzz31ac/bKsrTBPs9/Zc2sEwPIdQO8yBhe5AQSaGjd9AE+MXhtzGU3nsj64u3KxG+pfo/ptEgXMf4W4DBhuey3joZ+sulzoU/n7o0OR4DQ3dDbzIx8HLK32j8oejioDtniyHHqk99AVbn0MoAHhJb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWYGyvrU; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWYGyvrU"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12711ec96fbso3108379c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962656; x=1774567456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqE8bLBlKRkSibRkc3EltsCtmi46Ix8f6FKqSyXSzZc=;
        b=kWYGyvrUuPK7QA8/00LS4nLwVIUtM4gUICmS9ZovRJ/Bc0ocsanxFNU8WSum5shQoA
         fwie8/e+WNdv2y/xlcxWliCVEu0Y1yachnhSFGYVdWiRrpBTgChFv7fZ+mqE/r65fOTi
         KR7dNR4EYQ3B1kmk3rTiIsVeIQY83J6d6YoQ3Gl6vrRcN6XCeML67i46ZJ9++GHykPrw
         9fsKRk0ihdgW/2ILEWnFV1gkuda4GwXFBiXCGcVVw0dd1ERZXVYY2o5kD0mBie8zmCOa
         dFCabWOkJais+H44vu3u3j1EQGN1A2v7xACG4t77QIIwE/CMZYbRv3uylIG7lfPchHlP
         Y9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962656; x=1774567456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqE8bLBlKRkSibRkc3EltsCtmi46Ix8f6FKqSyXSzZc=;
        b=rsi4jiIp02suzKHeOaomRaG3EdM9fvX7vW4AcU8Prou8wIDAEUrgsvFEP8yd8MN1b9
         sldyemRdJFZp4LOCnZPHi878HWqUCouklN/3ZpoukOP/RsRnFacV1acJTe4rYzjDrTEy
         L6j7BXovB/s33yVS8RV0i3qzrwcCvGltgJTLKL47p5IRlCChpAbIcGJQE/qfP/Jc1Xb9
         fArTWDc4EA/+yzYtZ9jo3fgspHTmkkVJTsvTTi5PrmEA70EVDWOmb/GwJfPg+BwbKRrT
         zPD8h+soGhcho+rnt/MyIgNmmV/11UVWnZ8oDCVqwVmDP1U8bwe/loKeleTav0q5nQ+K
         f5pA==
X-Forwarded-Encrypted: i=1; AJvYcCVOhtCN8RcE77vEe8/QrKOHxzoMYdDOD6P4YZ+1bzkmcWxziSVR7XvBAGZ7aqMpqkzW9VKLB0g6QOKBGrSRtzNJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx164WWtXs5TlEm4yh03lyjsBr2boz63jk44ZkHDoLveOiBk1PH
	aZcTlTAk3E/B6lUKn0jL483cCQYI/YZehs4XnUOQKc2K3kz5s4G/4cNQoryV2/EMmtmjzjJOoo5
	AvOz3kWeUZA==
X-Received: from dlea10-n1.prod.google.com ([2002:a05:701b:420a:10b0:128:cf1e:df72])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fd0c:b0:128:d4db:4464
 with SMTP id a92af1059eb24-12a726ab63amr516667c88.25.1773962655755; Thu, 19
 Mar 2026 16:24:15 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:16 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-8-irogers@google.com>
Subject: [PATCH v2 07/25] perf trace: Don't pass evsel with sample
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

The sample now contains the evsel and so don't unnecessarily pass the
evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 55 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 493eecf218b4..33199ff2bbfd 100644
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
@@ -2719,8 +2719,8 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	return printed;
 }
 
-static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
-				 struct perf_sample *sample, struct thread *thread)
+static int trace__fprintf_sample(struct trace *trace, struct perf_sample *sample,
+				 struct thread *thread)
 {
 	int printed = 0;
 
@@ -2728,7 +2728,7 @@ static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
 		double ts = (double)sample->time / NSEC_PER_MSEC;
 
 		printed += fprintf(trace->output, "%22s %10.3f %s %d/%d [%d]\n",
-				   evsel__name(evsel), ts,
+				   evsel__name(sample->evsel), ts,
 				   thread__comm_str(thread),
 				   sample->pid, sample->tid, sample->cpu);
 	}
@@ -2783,7 +2783,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	void *args;
 	int printed = 0;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	int id = perf_evsel__sc_tp_uint(id, sample), err = -1;
 	int augmented_args_size = 0, e_machine;
 	void *augmented_args = NULL;
 	struct syscall *sc;
@@ -2798,9 +2798,9 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	trace__fprintf_sample(trace, evsel, sample, thread);
+	trace__fprintf_sample(trace, sample, thread);
 
-	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
+	args = perf_evsel__sc_tp_ptr(args, sample);
 
 	if (ttrace->entry_str == NULL) {
 		ttrace->entry_str = malloc(trace__entry_str_size);
@@ -2855,12 +2855,11 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
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
@@ -2870,7 +2869,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 	e_machine = thread__e_machine(thread, trace->host, /*e_flags=*/NULL);
-	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	sc = trace__syscall_info(trace, sample->evsel, e_machine, id);
 	if (sc == NULL)
 		goto out_put;
 	ttrace = thread__trace(thread, trace);
@@ -2881,7 +2880,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
+	args = perf_evsel__sc_tp_ptr(args, sample);
 	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
 	printed += syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%.*s", (int)printed, msg);
@@ -2891,10 +2890,11 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
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
@@ -2929,7 +2929,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	u64 duration = 0;
 	bool duration_calculated = false;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
+	int id = perf_evsel__sc_tp_uint(id, sample), err = -1, callchain_ret = 0, printed = 0;
 	int alignment = trace->args_alignment, e_machine;
 	struct syscall *sc;
 	struct thread_trace *ttrace;
@@ -2943,9 +2943,9 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	trace__fprintf_sample(trace, evsel, sample, thread);
+	trace__fprintf_sample(trace, sample, thread);
 
-	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
+	ret = perf_evsel__sc_tp_uint(ret, sample);
 
 	if (trace->summary)
 		thread__update_stats(thread, ttrace, id, sample, ret, trace);
@@ -2967,7 +2967,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out;
@@ -3182,9 +3182,10 @@ static void bpf_output__fprintf(struct trace *trace,
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
@@ -3267,7 +3268,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out;
@@ -3285,7 +3286,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		trace__fprintf_comm_tid(trace, thread, trace->output);
 
 	if (evsel == trace->syscalls.events.bpf_output) {
-		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
+		int id = perf_evsel__sc_tp_uint(id, sample);
 		int e_machine = thread
 			? thread__e_machine(thread, trace->host, /*e_flags=*/NULL)
 			: EM_HOST;
@@ -3293,7 +3294,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 		if (sc) {
 			fprintf(trace->output, "%s(", sc->name);
-			trace__fprintf_sys_enter(trace, evsel, sample);
+			trace__fprintf_sys_enter(trace, sample);
 			fputc(')', trace->output);
 			goto newline;
 		}
@@ -3313,13 +3314,13 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
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
@@ -3378,7 +3379,7 @@ static int trace__pgfault(struct trace *trace,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out_put;
-- 
2.53.0.959.g497ff81fa9-goog

