Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606041163E
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962691; cv=none; b=SzDhvQPkBvnYM4BxtE8FVK9L25y4tW8zOsvHed/25F1HmAesF3B6SFIcUBUbbB5HomHCtSobo+wc8PB9IzGZddso6QOXjgMEFahlDi3tson+l0Irqpv+f+i0z+VZ6ugoFckYlAMp9c2GkzgL4J2/xFrg4ZKVLbLRT9lhS5fR1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962691; c=relaxed/simple;
	bh=3n96E9V/4QhhKs4hWAjfN7C8Br55p1AJ1VBaBO3fk2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g6kpiAuDoxCp/Ulb5Ne2iV2PaQCE1ym2lFac5fk9phXsrUUImmvmKMWXeJul7yteASX3ERGwllAWtFgX39nfUs8aZVDFTYaLvMarAybxqYA50E0ZT6xSewj8/nMXgq9vqhkJyBF/LjBusJL9pGHt8Hvqqc+dCbeeorJaCSl61gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+iGpN7h; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+iGpN7h"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so1737508c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962689; x=1774567489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=imsNgYZdY1tqbGGPfOlwwoZDMdJ12rSBPWNrXkSgWrs=;
        b=U+iGpN7h2qyyAmxey0iFQ6DNX58j3KvzAqWU4ttNO3B1Ov0V50q4D5XpBse5QLMWIf
         mLFqiisBsg3CkDMiTLbaqnPfT9vHFfRHiUZrmp1RYgcJQakimHeBzXLmDQL55U+BQceb
         PRmJoo+YX+YLBmtOMNoGCngtT03vt5/wzVVJzIFl+0QwOfRrWRQ2ilmWGJTioZmtsj16
         xPZoIcrpEpee9y4WfGLWqWVDu+ql1nEiuls1XQMOXxzV9tDYO6bVxcyKQUUtn7HZLEir
         EuU4j80Xqq9H3NS67mG65bn3pfiY6X1m/1QR17gl1p55S1gDS5B8/Xbh1QMRyLp4voul
         uSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962689; x=1774567489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imsNgYZdY1tqbGGPfOlwwoZDMdJ12rSBPWNrXkSgWrs=;
        b=h7DfMiMvEebaGclIBU+zuGJZ1lVtnm3ZluV9zjE07KUkrxdT07IFMKi4v8bWDm4XtF
         9vJp3BS+e7XOWVMlLByhjYzlsbUY0XWmlg6UAEhcD9rWMzwrFjqKIQOD80VB9E31aR9A
         Gjor0HrMUAymiXzRi0I717ytghOAY2xZiaElH3IHjcu4B6LJ1+Yl+WJgsfcryQCUNW2n
         HLm/avVBn7rlFa8o+iVh9BOZ7ueKq66Y6j8gbSkKB0ME+JzZiMEj8TPzGht26EcH+DZB
         eEEEwDwm5dKaIOawsrZbHuvKhEf2nqC+oWdQIDmGEDf6NKPf3N+4Z5NDDQDI2j+fmCXx
         CNog==
X-Forwarded-Encrypted: i=1; AJvYcCXCMlLeWZaGSzy2XDYA5N+T0Km+LttZbYxbj7co1ctbX7Puz7r5hNZfWrQ7S6+hxMEe6IgiG3E7puO2UIeo+f9W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5KiIhJ1QsPydix2wjGm4jJL8n64ee6XMOTkiW5McJUBEbK2yX
	o5VCJ5SgrUBqAmZ0uq6wCWKK2GMMYxRTsCep7y76h+cjaDhDT99T2PMRtDLxKFwahSJ8+90uF3y
	JarOPvMU5dA==
X-Received: from dyblf40.prod.google.com ([2002:a05:7301:a28:b0:2c0:e2b8:48ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3b0b:b0:2c0:be45:6811
 with SMTP id 5a478bee46e88-2c1097ae93bmr534509eec.32.1773962688847; Thu, 19
 Mar 2026 16:24:48 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:30 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-22-irogers@google.com>
Subject: [PATCH v2 21/25] perf trace: Don't pass evsel with sample
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
 tools/perf/builtin-trace.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 385a9ac2ae96..c4ec4f603d5f 100644
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
@@ -3622,14 +3624,16 @@ static void evlist__free_syscall_tp_fields(struct evlist *evlist)
 static void trace__handle_event(struct trace *trace, union perf_event *event, struct perf_sample *sample)
 {
 	const u32 type = event->header.type;
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
 
 	if (type != PERF_RECORD_SAMPLE) {
 		trace__process_event(trace, trace->host, event, sample);
 		return;
 	}
 
-	evsel = evlist__id2evsel(trace->evlist, sample->id);
+	if (evsel == NULL)
+		evsel = evlist__id2evsel(trace->evlist, sample->id);
+
 	if (evsel == NULL) {
 		fprintf(trace->output, "Unknown tp ID %" PRIu64 ", skipping...\n", sample->id);
 		return;
@@ -3638,7 +3642,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 	if (evswitch__discard(&trace->evswitch, evsel))
 		return;
 
-	trace__set_base_time(trace, evsel, sample);
+	trace__set_base_time(trace, sample);
 
 	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT &&
 	    sample->raw_data == NULL) {
@@ -3647,7 +3651,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 		       sample->cpu, sample->raw_size);
 	} else {
 		tracepoint_handler handler = evsel->handler;
-		handler(trace, evsel, event, sample);
+		handler(trace, event, sample);
 	}
 
 	if (trace->nr_events_printed >= trace->max_events && trace->max_events != ULONG_MAX)
-- 
2.53.0.959.g497ff81fa9-goog

