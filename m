Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4838759B
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658859; cv=none; b=RXVa1F6i3/8C4Qg4WPVbyzNNfO+mtflP0CgzMbIfaxbZ45rnJt+HY7Y8VVI3tQIzPlsxkjAu/wl4cIb0y31bzYqeMWGXqy1hLAjkzB33NsY+nTewhp04aZyUPDdKbqhywIDmXmBZmHz+5C5Osfm5M9YuwsS+flCPjeftevFN7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658859; c=relaxed/simple;
	bh=dxHa93PslZklWVkkyAQ7K6HkTaBVMQoUUV8a+BraVtk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TjojLT3VxJmsKk4nEkdBfc26zKW0bmy8IQ4Y8T72elij7Kn3qyodyrrvTT7sOHKUZWddRrj9FawT/nXpqtlj00vn8HaO5Q9IwqUOY5j3+HTCK4c+rpRUSE684YwsPBpXP7yQie4Zqy+/Dw0SqWx1uo5VFR/hcMp8aoe115MTnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WzlPQ7Uh; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzlPQ7Uh"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124a95b6f61so23134088c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658858; x=1771263658; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1tRJX7J5r1dPfFcNrmsO1GQ74CBF5h4ta5FV7G1gKM=;
        b=WzlPQ7UhUmOUEwqz1h89xbtah4MxoWuPflJjgJ/sSmLcqI880SIRtkGzXBGCLqqZyp
         Pxf7uU5B/OXkdLjQDTJmpulX56tMI7Ll9uw5ZnXekQ877ERFvZaEPoZot0CAReag1mh7
         BaFnG6IBishL/l+br3gDGEqIbSpshtaDXFd2m8A7yFUWufFTVgFoFdmOfugnGYHFSUpF
         Uxcqz4hEv2/Ly9RuMGo4+q8KZn33/82nz8kVWv0DLAh0kbYsOCsp48j2G7JSTuIWKeDJ
         UsnWNE2zsWnp0gXY8nNkX65GzMJPz7551TuIWYvLkGCHfhpH+Tt4BSiER6tKANlXSZ0u
         xuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658858; x=1771263658;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1tRJX7J5r1dPfFcNrmsO1GQ74CBF5h4ta5FV7G1gKM=;
        b=uYdhYC/ISJ24tata5rJacDv/xRPZMII6wrZOmBFkq59k3rt3B9JAF0YzAeWE113hjZ
         e6hig4bD3SkLIJ5LLwi+YOkeCRwKW9G7X/fotsHFti+DdvPbl+E9eZotQcyMN1LQP3ye
         Z+szlC0mUkBEbHZSr6wQru120wtLrI6Hcl4Ui11FVEpYliTazVybFyNDuExhKYghFL7a
         zuvjzZkNKsOYOxsmAuTC2LwR0GeuDCF6z6fZJEVexSpw2gMBj8XuHe/hKiyr333nW8Ov
         n8zrHdQbT/TnRWSOsBsq0g5aLnp8avtr1McjMeyhgge6WkS6qGw3pdwFzthCSrcSBbRa
         S+4g==
X-Forwarded-Encrypted: i=1; AJvYcCXDdR7IeK/Jmsn8V0zu03+P69JeyjV9QjfRy/uX2yCjTR5HxYYbrg0rwXXS1r9jcIchzHNArzM6ynhDXLbj5fwd@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHc+G2Ww6k4uHhHEPmTBn5tLhN2G1Fhvqdvm/dFhiJGa9jn//
	JoCDqa3u43drwZBM/6O/H5ioqfWyiozjvsuj29AU+CGhJYabLz0i6qRyPTcoDp8ZeIaeflqnN8K
	MrlG8LCm+lg==
X-Received: from dlii7.prod.google.com ([2002:a05:7022:4187:b0:124:a7b4:135d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:220b:b0:119:e56b:c74b
 with SMTP id a92af1059eb24-12704001542mr5701226c88.16.1770658858094; Mon, 09
 Feb 2026 09:40:58 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:14 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-8-irogers@google.com>
Subject: [PATCH v1 07/25] perf trace: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The sample now contains the evsel and so don't unnecessarily pass the
evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 55 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a092405e84aa..7a0913595943 100644
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
@@ -2718,8 +2718,8 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 	return printed;
 }
 
-static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
-				 struct perf_sample *sample, struct thread *thread)
+static int trace__fprintf_sample(struct trace *trace, struct perf_sample *sample,
+				 struct thread *thread)
 {
 	int printed = 0;
 
@@ -2727,7 +2727,7 @@ static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
 		double ts = (double)sample->time / NSEC_PER_MSEC;
 
 		printed += fprintf(trace->output, "%22s %10.3f %s %d/%d [%d]\n",
-				   evsel__name(evsel), ts,
+				   evsel__name(sample->evsel), ts,
 				   thread__comm_str(thread),
 				   sample->pid, sample->tid, sample->cpu);
 	}
@@ -2782,7 +2782,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	void *args;
 	int printed = 0;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	int id = perf_evsel__sc_tp_uint(id, sample), err = -1;
 	int augmented_args_size = 0, e_machine;
 	void *augmented_args = NULL;
 	struct syscall *sc;
@@ -2797,9 +2797,9 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	trace__fprintf_sample(trace, evsel, sample, thread);
+	trace__fprintf_sample(trace, sample, thread);
 
-	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
+	args = perf_evsel__sc_tp_ptr(args, sample);
 
 	if (ttrace->entry_str == NULL) {
 		ttrace->entry_str = malloc(trace__entry_str_size);
@@ -2854,12 +2854,11 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
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
@@ -2869,7 +2868,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 	e_machine = thread__e_machine(thread, trace->host, /*e_flags=*/NULL);
-	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	sc = trace__syscall_info(trace, sample->evsel, e_machine, id);
 	if (sc == NULL)
 		goto out_put;
 	ttrace = thread__trace(thread, trace);
@@ -2880,7 +2879,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
+	args = perf_evsel__sc_tp_ptr(args, sample);
 	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
 	printed += syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%.*s", (int)printed, msg);
@@ -2890,10 +2889,11 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
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
@@ -2928,7 +2928,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	u64 duration = 0;
 	bool duration_calculated = false;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
+	int id = perf_evsel__sc_tp_uint(id, sample), err = -1, callchain_ret = 0, printed = 0;
 	int alignment = trace->args_alignment, e_machine;
 	struct syscall *sc;
 	struct thread_trace *ttrace;
@@ -2942,9 +2942,9 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
-	trace__fprintf_sample(trace, evsel, sample, thread);
+	trace__fprintf_sample(trace, sample, thread);
 
-	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
+	ret = perf_evsel__sc_tp_uint(ret, sample);
 
 	if (trace->summary)
 		thread__update_stats(thread, ttrace, id, sample, ret, trace);
@@ -2966,7 +2966,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out;
@@ -3181,9 +3181,10 @@ static void bpf_output__fprintf(struct trace *trace,
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
@@ -3266,7 +3267,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out;
@@ -3284,7 +3285,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		trace__fprintf_comm_tid(trace, thread, trace->output);
 
 	if (evsel == trace->syscalls.events.bpf_output) {
-		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
+		int id = perf_evsel__sc_tp_uint(id, sample);
 		int e_machine = thread
 			? thread__e_machine(thread, trace->host, /*e_flags=*/NULL)
 			: EM_HOST;
@@ -3292,7 +3293,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 		if (sc) {
 			fprintf(trace->output, "%s(", sc->name);
-			trace__fprintf_sys_enter(trace, evsel, sample);
+			trace__fprintf_sys_enter(trace, sample);
 			fputc(')', trace->output);
 			goto newline;
 		}
@@ -3312,13 +3313,13 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
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
@@ -3377,7 +3378,7 @@ static int trace__pgfault(struct trace *trace,
 	if (sample->callchain) {
 		struct callchain_cursor *cursor = get_tls_callchain_cursor();
 
-		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
+		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
 		if (callchain_ret == 0) {
 			if (cursor->nr < trace->min_stack)
 				goto out_put;
-- 
2.53.0.239.g8d8fc8a987-goog

