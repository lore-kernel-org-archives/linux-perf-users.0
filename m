Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3438884A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658889; cv=none; b=qLx53JPEIvfqI9xpQ6Anl+Zi1yOL20Gu0Sw+CziFC3XlEVDAPRcVxX3uOKiGyiKiHEqUlz6U/nEXhzFP4M4XhFj7TH5oEDGrQXEJdaNbtvmjxhd1OFlYYn3D3PPr7jh/AKRht4cZC7+H+pxyGrsnDJfwwdR3cOBpQW+vl3YVKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658889; c=relaxed/simple;
	bh=ocuQx4XZuiRO8GRHqqD7nSksu0emgzMFKlbAu1B4fIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=t7qzD4SpFa2pw6lmy0g0yK6Hbh3bJD9OHFtMcW/+KnJ6baY+wmlSbLYtv1CWWayoyHxcArb3h5jJmd6zuixNEwOiv0QfhNKSPYBP7ZgKH91OJclMBoa2UeaeOKj0Wm0kYOGlBQYTmIIfCLwwC0v/tuCSs/USj4nib3oWNH+1XBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTUZetdO; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTUZetdO"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1270be4d176so2215594c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658889; x=1771263689; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KaiONckexinVenjREn7UXtQSsVVfjES5HZqD8w+j0WM=;
        b=pTUZetdO1WtPRHWuKALmlILxkfZiGNfXVmK1ykOWxcCMxMY7W8uL01lLa+Wq07aTJA
         PyNAlMbB0M/wxTNkIyc4ClDIGkpoRiYFnXUIqcXXUrUhDcwU4/FN8H+Vw6JjMHAVa/+p
         sU1rq0g3Vh8B21ndVWMc+AqBUREK2NI7I28PsgSk1OKgFHYB4H1Z9b88B6w6p8PTVdq4
         5aFxImYFxhI4rjQqBRREcfgsqjIjhaRHlIr4hoCprJr9QX4MHVKICCss5oPEL2Vyuqp8
         ynW4Iwn9xebdymoIBmSq5rigMtmp3afiPIM8+q16pPpWUFq+r+jypNXWqWzAx75g1iaw
         I4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658889; x=1771263689;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaiONckexinVenjREn7UXtQSsVVfjES5HZqD8w+j0WM=;
        b=e2YX5awpHKRfjkX61CIZppF4ePoh5WnzGGYB7DeYsrWlDm0xxoYcMlpglG75mAY7XP
         NoBhis6rqsctHVvvydINilzFBNOuLvyD60So5q4toOPgTErMxp5POqVte2lOTVuSteU0
         vYktEzlO2+MJrnJ/4elVZwKusrl9Fr4KfscwKtre+qNbvir35Z9EpooVTUU6Vjpglici
         VSVCsH+5ltEdvoWZnLOq9Dma0j1BoEMWcprgk+uUMuv5EfTCPqzGS1g67CudbO5R28sC
         gPN3Q8vhzcfyf1v4obrdZ8rkxqozFnFwPuTGj0aCq9KW1IlbG1hNolV/OFRFm/lSRX3p
         Nb1g==
X-Forwarded-Encrypted: i=1; AJvYcCXNgo2vO+HhMKF9JZKIAcgUahshK62EXa0MREwGIm2fTk8vb8ICFbQ/irM4pfttlf1p9rZGq9TW4KnxaFJFpqKs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1Ffv82hZOVrGs6tKLJL1QYM/jJVqLGZzMuE2bGgz9T+9NdTC
	L8wATe6DgQygohkwhDHpxqVdGrwAtnuVlXZmlFq+uC2wsN74yK5n3jroHB1urXvbmDn6BNoXhBZ
	SuEmq6rJw+w==
X-Received: from dlbdx36.prod.google.com ([2002:a05:7022:e24:b0:11f:36a2:78d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:670d:b0:119:e569:f25f
 with SMTP id a92af1059eb24-12703fd961cmr6328080c88.8.1770658888326; Mon, 09
 Feb 2026 09:41:28 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:28 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-22-irogers@google.com>
Subject: [PATCH v1 21/25] perf trace: Don't pass evsel with sample
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

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. In trace__handle_event try to use the evsel from the
sample to avoid recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b6e90ee53cbe..ff3c85144038 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2579,7 +2579,7 @@ static struct syscall *trace__find_syscall(struct trace *trace, int e_machine, i
 	return sc;
 }
 
-typedef int (*tracepoint_handler)(struct trace *trace, struct evsel *evsel,
+typedef int (*tracepoint_handler)(struct trace *trace,
 				  union perf_event *event,
 				  struct perf_sample *sample);
 
@@ -2774,10 +2774,11 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
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
@@ -2920,10 +2921,11 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
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
@@ -3058,7 +3060,7 @@ errno_print: {
 	return err;
 }
 
-static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_unused,
+static int trace__vfs_getname(struct trace *trace,
 			      union perf_event *event __maybe_unused,
 			      struct perf_sample *sample)
 {
@@ -3119,7 +3121,7 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel __maybe_u
 	return 0;
 }
 
-static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
+static int trace__sched_stat_runtime(struct trace *trace,
 				     union perf_event *event __maybe_unused,
 				     struct perf_sample *sample)
 {
@@ -3141,7 +3143,7 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
 
 out_dump:
 	fprintf(trace->output, "%s: comm=%s,pid=%u,runtime=%" PRIu64 ",vruntime=%" PRIu64 ")\n",
-	       evsel->name,
+	       sample->evsel->name,
 	       perf_sample__strval(sample, "comm"),
 	       (pid_t)perf_sample__intval(sample, "pid"),
 	       runtime,
@@ -3252,10 +3254,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
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
 
@@ -3443,7 +3446,6 @@ static int trace__pgfault(struct trace *trace,
 }
 
 static void trace__set_base_time(struct trace *trace,
-				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
 	/*
@@ -3455,7 +3457,7 @@ static void trace__set_base_time(struct trace *trace,
 	 * appears in our event stream (vfs_getname comes to mind).
 	 */
 	if (trace->base_time == 0 && !trace->full_time &&
-	    (evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
+	    (sample->evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
 		trace->base_time = sample->time;
 }
 
@@ -3475,11 +3477,11 @@ static int trace__process_sample(const struct perf_tool *tool,
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
@@ -3621,14 +3623,16 @@ static void evlist__free_syscall_tp_fields(struct evlist *evlist)
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
@@ -3637,7 +3641,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 	if (evswitch__discard(&trace->evswitch, evsel))
 		return;
 
-	trace__set_base_time(trace, evsel, sample);
+	trace__set_base_time(trace, sample);
 
 	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT &&
 	    sample->raw_data == NULL) {
@@ -3646,7 +3650,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 		       sample->cpu, sample->raw_size);
 	} else {
 		tracepoint_handler handler = evsel->handler;
-		handler(trace, evsel, event, sample);
+		handler(trace, event, sample);
 	}
 
 	if (trace->nr_events_printed >= trace->max_events && trace->max_events != ULONG_MAX)
-- 
2.53.0.239.g8d8fc8a987-goog

