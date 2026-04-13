Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77701D798E
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043394; cv=none; b=EdmQMnFmlrDm8nduTzz5KpEY2vgywZe1Yb7QBUgVTturFgMsI7lIWMECMJVaqSaNsuyxzbghxqAURin26mgouu9YtYyk/qa3DsrRc7qCGZArz1bWRE/x3neB2KaYqEzP27rXdLVzgrzgQHdRcTTi1MQpFbTPTwqvH58Nx1YTZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043394; c=relaxed/simple;
	bh=ge8wARLhBMwexhRDGIWjn0ZcXZilIlhpkFC0+P8MGis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K3m23MN3FJDMg6EQDjGtYn9oRnUNuB6yPwCVciFFWl31DPnrEUkrNUeKzHytosZNNZtVIV8pQwM40zLICTRePpxCjcoV0tOJ0n6EOK3IkItDQY7nifHXH9uEZDXaJ6sUE0GTiAjZfU1sG5im0GEfYC2xqOLYHCy05LY/t6qw0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grhQcXc9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grhQcXc9"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso8102604a91.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043391; x=1776648191; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dApPHTKd9TWmg34UUEla0Pul7we/BjeRSMVVeuYijd4=;
        b=grhQcXc9t4zIinn9z3HfUWA0v5x8Jh6aDK2PrO5H4VNQWvJ7E+g3OzZ8CcX5sVpJgg
         F7xoeiNnkv9Pn5kSuNYf+A/6pgSnysJoPa1EHJyMBRTHz3pPgfDwJGIWWQLMN9A8kKhv
         fobbrvUsXT98SjR5ux3MpfzyEQUGOpH5cFiwCPiajeAZJMJ4NTLyn9sjkGeujMxqwMT+
         FxQa+PibuZoqE1h4E/LHgUfkjrhGJF0FrWX1sii+SeaGUfaRi4/tyYTKqsAtTovBOJjj
         yRgQbmL1jFeJfcbufU6DcGEpdfMj7jDSqH+TBWTYgTzoGNj/AZ3ZydleQyRRcmaXD5f+
         +s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043391; x=1776648191;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dApPHTKd9TWmg34UUEla0Pul7we/BjeRSMVVeuYijd4=;
        b=rXSttFDZ5rozJHvjN9dnLhZqDA/6FiTwGjUB1Uks94DrSR+FYXib+0CBexbBRrhTOC
         pzo2JP14RG0/VUmsTiBZrwlo7rEN8dafZH4cF1o4odStSjaZ3uNmlE8cn3KW3Yv9Z7GZ
         W2DXH7v/fuMVluSHpRhA7jfY7Rt4i07hu6dgKZqmvoP7dzcLT6zdHAH1JsNsgp2QQ4Am
         pVW8FD/fOKiO2E8rBHyzIc9xnArsyLFqDVBhzQcekuAQBJuSGL6K44EwXG7l/1fdqXE4
         LoNoP51Mwv0DkV129i4yxHNMTuuY6ce8ibNfJC/I3dJBzX67VT/7EIjwqWAhNpQKEo++
         /Cow==
X-Forwarded-Encrypted: i=1; AFNElJ9D5A6hPy0yaKEnDlGjzKK93h/Mo4V1IP12N6Us5dZeWPog7MWB2uXLbhdTCdKO2cMvHd7EVTqrzF+RjryUIRw/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+gGhwmBclE6RHtRQgqFUtl7wfQy8sLny8Glx2YxwtcCdPyWH7
	IJrMNa9NRst+EtloiTUeuTMAzMQDGrQHXNATGOR87Q/8iKzK0DNphAFiLqrkYixrdtGYUGiAXUm
	uNgTeofWlwg==
X-Received: from pjhk59.prod.google.com ([2002:a17:90a:4cc1:b0:35f:b313:d194])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e0c:b0:35d:a3b4:2f00
 with SMTP id 98e67ed59e1d1-35e427ea4c3mr12639233a91.8.1776043390780; Sun, 12
 Apr 2026 18:23:10 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:12 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-19-irogers@google.com>
Subject: [PATCH v11 18/33] perf trace: Don't pass evsel with sample
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

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. In trace__handle_event try to use the evsel from the
sample to avoid recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 52 ++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1fac167f7436..4e54e75d8ff0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2582,7 +2582,7 @@ static struct syscall *trace__find_syscall(struct trace *trace, int e_machine, i
 	return sc;
 }
 
-typedef int (*tracepoint_handler)(struct trace *trace, struct evsel *evsel,
+typedef int (*tracepoint_handler)(struct trace *trace,
 				  union perf_event *event,
 				  struct perf_sample *sample);
 
@@ -2777,10 +2777,11 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
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
@@ -2923,10 +2924,11 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
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
@@ -3061,7 +3063,7 @@ errno_print: {
 	return err;
 }
 
-static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_unused,
+static int trace__vfs_getname(struct trace *trace,
 			      union perf_event *event __maybe_unused,
 			      struct perf_sample *sample)
 {
@@ -3122,7 +3124,7 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_u
 	return 0;
 }
 
-static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
+static int trace__sched_stat_runtime(struct trace *trace,
 				     union perf_event *event __maybe_unused,
 				     struct perf_sample *sample)
 {
@@ -3144,7 +3146,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 
 out_dump:
 	fprintf(trace->output, "%s: comm=%s,pid=%u,runtime=%" PRIu64 ",vruntime=%" PRIu64 ")\n",
-	       evsel->name,
+	       sample->evsel->name,
 	       perf_sample__strval(sample, "comm"),
 	       (pid_t)perf_sample__intval(sample, "pid"),
 	       runtime,
@@ -3255,10 +3257,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
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
 
@@ -3364,7 +3367,6 @@ static void print_location(FILE *f, struct perf_sample *sample,
 }
 
 static int trace__pgfault(struct trace *trace,
-			  struct evsel *evsel,
 			  union perf_event *event __maybe_unused,
 			  struct perf_sample *sample)
 {
@@ -3393,7 +3395,7 @@ static int trace__pgfault(struct trace *trace,
 	if (ttrace == NULL)
 		goto out_put;
 
-	if (evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ) {
+	if (sample->evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ) {
 		ttrace->pfmaj++;
 		trace->pfmaj++;
 	} else {
@@ -3409,7 +3411,7 @@ static int trace__pgfault(struct trace *trace,
 	trace__fprintf_entry_head(trace, thread, 0, true, sample->time, trace->output);
 
 	fprintf(trace->output, "%sfault [",
-		evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
+		sample->evsel->core.attr.config == PERF_COUNT_SW_PAGE_FAULTS_MAJ ?
 		"maj" : "min");
 
 	print_location(trace->output, sample, &al, false, true);
@@ -3434,7 +3436,8 @@ static int trace__pgfault(struct trace *trace,
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
-		pr_err("Problem processing %s callchain, skipping...\n", evsel__name(evsel));
+		pr_err("Problem processing %s callchain, skipping...\n",
+		       evsel__name(sample->evsel));
 
 	++trace->nr_events_printed;
 out:
@@ -3446,7 +3449,6 @@ static int trace__pgfault(struct trace *trace,
 }
 
 static void trace__set_base_time(struct trace *trace,
-				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	/*
@@ -3458,7 +3460,7 @@ static void trace__set_base_time(struct trace *trace,
 	 * appears in our event stream (vfs_getname comes to mind).
 	 */
 	if (trace->base_time == 0 && !trace->full_time &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
+	    (sample->evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
 		trace->base_time = sample->time;
 }
 
@@ -3478,11 +3480,11 @@ static int trace__process_sample(const struct perf_tool *tool,
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
@@ -3624,32 +3626,34 @@ static void evlist__free_syscall_tp_fields(struct evlist *evlist)
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
2.53.0.1213.gd9a14994de-goog

