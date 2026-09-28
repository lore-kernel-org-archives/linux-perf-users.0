Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567CD38E5ED
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620013; cv=none; b=ULaybjnjdVjoSsTTHmMmfWr8UbYwwJNVY5/MQA3m/VFreQit087GdUsGsso+5ozJMshtIpAr/CWX1aC2hKN+9IslFsRgqiiXVv2kEkQHcO4zEXyEDz22pyMgxgqRAeij1RVJFOy/9fwDorW4sRcK+9FLbOqKyWQcKFxBbHntp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620013; c=relaxed/simple;
	bh=lWVd2CggzQyiTWpNkazpx6eVFQMJ/kQ58tk/mMuxWLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eSdIoxE/HRWMMXpQi9P2gWhjx6KRlxQV+rlizFkjHo5L8r6eVHfaDGaPSnZ84sZEeiWLgJ1F7UYpztG9AlzvP6r16LfXMf23NrxTG3oS/Vi5yG0/J5C5lONOgIYT/NhhZWWI36ni/jznNjxxEssuN7+JG8LGqCmc31syNGrciGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLLkkeVW; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLLkkeVW"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14a62326b51so766479c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620010; x=1791224810; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rPNzM7M7wWyRlYleu89x2W7LdzWaVZZ34y+cjdUCZvg=;
        b=eLLkkeVWIAvr2F6iEjQSXkKUrPsq1Mjvm8sLob06fA+Zk1R5WLS68mr0mIFm1r7AI/
         SkNCe4+i39BirOcGg7e0QdiW0a/gV5dLjGldZWr4s7arne5out+k3TZGwpHg7NhLsf/r
         n6CplYuhhqhzEPvat6C5fglUhavioJGVZuRI7yBzhV87P3VducrNsnAUEgoeCRcHyBXu
         Wbvt4ThiQJ6MKPMcHsNY1wdb9Zao9JFRAUiYANbntonevtF+s8dOs1rs4zyaomVz3Rg7
         Evr3h47oWpF9zRfa7qcuOvB9CjIwNALRH1kfBYv37x9N+cHT1RAW9GC2laTC/025cWE/
         CMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620010; x=1791224810;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rPNzM7M7wWyRlYleu89x2W7LdzWaVZZ34y+cjdUCZvg=;
        b=BpF1xH4e3bnN5OhcNcCvg3PubWcXzL7HocPkb98QSdxfaO+VJf6XDjKIR7G5rK23TR
         RndwDZNxvkneiZp7MyYx1TP4hVa4pAH0uDHYHZ/R0f9PK8eV5E5fQpGQRyBQRUUxAHaM
         +QGJZctmDdJh09EjCzPdkHSSrR7Qn2ATUtP1gclIJZgiFsum+SZMbDi+9yVsatWFT8hV
         3tp6Mw0BKSMxIiziwvQ/WEbqugt+dRNfR381EOB3HesMZvubslViOmib0pxB/lrZumeX
         z8dp1AfFJZlxJeOdAxl4eP1SFAhUPfZXVbsjcFykBlGOEmD1pnU9nauuhKs5KW+383GO
         ZfAg==
X-Forwarded-Encrypted: i=1; AKwUvBwDEBZdZKSZ7sSJzHsiMEcu+g+lwLhSbrdNcSTiUam9qJAA3YAk3t6LJ3n0uVnPYG5GEIsGz0QoKre49rngVzQA@vger.kernel.org
X-Gm-Message-State: AFuF++kmWa0qrQ99FAEuPhecBYnrGktvwMgLydd6Juf/MdPJ8dbB5IdK
	ZwYedSKv6oceJYZWRMtWgSRCsEOqiniif6CLs3pUTjza/Rnt0GiB8pGI/BVWuwRl3pEeWAP5gPR
	FNwq8mzdkUg==
X-Received: from dlbep24.prod.google.com ([2002:a05:7022:1098:b0:146:da66:cd8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b059:10b0:143:298e:459f
 with SMTP id a92af1059eb24-146d096cf16mr10822133c88.42.1790620009800; Mon, 28
 Sep 2026 11:26:49 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:56 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-18-irogers@google.com>
Subject: [PATCH v6 17/26] perf trace: Do not return 0 from syscall tracepoint BPF
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Namhyung Kim <namhyung@kernel.org>

Howard reported that returning 0 from the BPF resulted in affecting
global syscall tracepoint handling.  What we want to do is just to drop
syscall output in the current perf session.  So we need a different
approach.

Currently perf trace uses bpf-output event for augmented arguments and
raw_syscalls:sys_{enter,exit} tracepoint events for normal arguments.
But I think we can just use bpf-output in both cases and drop the trace
point events.

Then it needs to distinguish bpf-output data if it's for enter or exit.
Repurpose struct trace_entry.type which is common in both syscall entry
and exit tracepoints.

Closes: https://lore.kernel.org/r/20250529065537.529937-1-howardchu95@gmail.com
Suggested-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20250814071754.193265-4-namhyung@kernel.org
[ irogers: Use the local syscall_{enter,exit}_args, always return 1 from
  augmented__output(), output the unaugmented args when the perf_event_open
  augmenter fails, dispatch from a trace__bpf_output() handler, add a
  per-task tracking event and keep excluding kernel callchains. ]
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                    | 125 ++++++++++++++----
 .../bpf_skel/augmented_raw_syscalls.bpf.c     |  64 ++++++---
 tools/perf/util/bpf_skel/perf_trace_u.h       |  14 ++
 3 files changed, 157 insertions(+), 46 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/perf_trace_u.h

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ee844210e281..3dd40f3c3cbb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -21,6 +21,7 @@
 #include <bpf/libbpf.h>
 #include <bpf/btf.h>
 #endif
+#include "util/bpf_skel/perf_trace_u.h"
 #include "util/rlimit.h"
 #include "builtin.h"
 #include "util/cgroup.h"
@@ -555,6 +556,57 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 	return NULL;
 }
 
+static struct syscall_tp sys_enter_tp;
+static struct syscall_tp sys_exit_tp;
+
+static int evsel__init_bpf_output_tp(struct evsel *evsel)
+{
+	struct tep_event *event;
+	struct tep_format_field *field;
+	struct syscall_tp *sc;
+
+	if (evsel == NULL)
+		return 0;
+
+	event = trace_event__tp_format("raw_syscalls", "sys_enter");
+	if (event == NULL)
+		event = trace_event__tp_format("syscalls", "sys_enter");
+	if (event == NULL)
+		return -errno;
+
+	field = tep_find_field(event, "id");
+	if (field == NULL || tp_field__init_uint(&sys_enter_tp.id, field, evsel->needs_swap))
+		return -EINVAL;
+
+	__tp_field__init_ptr(&sys_enter_tp.args, sys_enter_tp.id.offset + sizeof(u64));
+
+	/* ID is at the same offset, use evsel sc for convenience */
+	sc = evsel__syscall_tp(evsel);
+	if (sc == NULL)
+		return -ENOMEM;
+
+	event = trace_event__tp_format("raw_syscalls", "sys_exit");
+	if (event == NULL)
+		event = trace_event__tp_format("syscalls", "sys_exit");
+	if (event == NULL)
+		return -errno;
+
+	field = tep_find_field(event, "id");
+	if (field == NULL || tp_field__init_uint(&sys_exit_tp.id, field, evsel->needs_swap))
+		return -EINVAL;
+
+	field = tep_find_field(event, "ret");
+	if (field == NULL || tp_field__init_uint(&sys_exit_tp.ret, field, evsel->needs_swap))
+		return -EINVAL;
+
+	/* Save the common part to the evsel sc */
+	if (sys_enter_tp.id.offset != sys_exit_tp.id.offset)
+		return -EINVAL;
+	sc->id = sys_enter_tp.id;
+
+	return 0;
+}
+
 #define perf_evsel__sc_tp_uint(name, sample) \
 	({ struct syscall_tp *fields = __evsel__syscall_tp(sample->evsel); \
 	   fields->name.integer(&fields->name, sample); })
@@ -3021,7 +3073,10 @@ static int trace__sys_enter(struct trace *trace,
 
 	trace__fprintf_sample(trace, sample, thread);
 
-	args = perf_evsel__sc_tp_ptr(args, sample);
+	if (evsel == trace->syscalls.events.bpf_output)
+		args = sys_enter_tp.args.pointer(&sys_enter_tp.args, sample);
+	else
+		args = perf_evsel__sc_tp_ptr(args, sample);
 
 	if (ttrace->entry_str == NULL) {
 		ttrace->entry_str = malloc(trace__entry_str_size);
@@ -3159,7 +3214,10 @@ static int trace__sys_exit(struct trace *trace,
 
 	trace__fprintf_sample(trace, sample, thread);
 
-	ret = perf_evsel__sc_tp_uint(ret, sample);
+	if (evsel == trace->syscalls.events.bpf_output)
+		ret = sys_exit_tp.ret.integer(&sys_exit_tp.ret, sample);
+	else
+		ret = perf_evsel__sc_tp_uint(ret, sample);
 
 	if (trace->summary)
 		thread__update_stats(thread, ttrace, id, sample, ret, trace);
@@ -3274,6 +3332,18 @@ errno_print: {
 	return err;
 }
 
+/* The BPF output event carries both entry and exit, tagged in common_type. */
+static int trace__bpf_output(struct trace *trace, union perf_event *event,
+			     struct perf_sample *sample)
+{
+	u16 type = *(u16 *)sample->raw_data;
+
+	if (type == SYSCALL_TRACE_ENTER)
+		return trace__sys_enter(trace, event, sample);
+
+	return trace__sys_exit(trace, event, sample);
+}
+
 static int trace__vfs_getname(struct trace *trace,
 			      union perf_event *event __maybe_unused,
 			      struct perf_sample *sample)
@@ -3585,27 +3655,6 @@ static int trace__event_handler(struct trace *trace,
 	if (thread)
 		trace__fprintf_comm_tid(trace, thread, trace->output);
 
-	if (evsel == trace->syscalls.events.bpf_output) {
-		int id = perf_evsel__sc_tp_uint(id, sample);
-		int e_machine = thread
-			? thread__e_machine(thread, trace->host, /*e_flags=*/NULL)
-			: EM_HOST;
-		struct syscall *sc = trace__syscall_info(trace, evsel, e_machine, id);
-
-		if (sc) {
-			fprintf(trace->output, "%s(", sc->name);
-			trace__fprintf_sys_enter(trace, sample);
-			fputc(')', trace->output);
-			goto newline;
-		}
-
-		/*
-		 * XXX: Not having the associated syscall info or not finding/adding
-		 * 	the thread should never happen, but if it does...
-		 * 	fall thru and print it as a bpf_output event.
-		 */
-	}
-
 	fprintf(trace->output, "%s(", evsel->name);
 
 	if (evsel__is_bpf_output(evsel)) {
@@ -3625,7 +3674,6 @@ static int trace__event_handler(struct trace *trace,
 		}
 	}
 
-newline:
 	fprintf(trace->output, ")\n");
 
 	if (callchain_ret > 0)
@@ -4791,6 +4839,16 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		bpf_output->core.system_wide = true;
 		/* Exec doesn't enable a CPU event, BPF waits for the exec instead. */
 		bpf_output->immediate = target__enable_on_exec(&trace->opts.target);
+		/* Track the target, and see it exit, with a per-task event. */
+		if (evlist__get_tracking_event(evlist) == bpf_output) {
+			struct evsel *tracking =
+				evlist__findnew_tracking_event(evlist, /*system_wide=*/false);
+
+			if (!tracking)
+				goto out_error_mem;
+			/* --sort-events can't queue events without a timestamp. */
+			evsel__set_sample_bit(tracking, TIME);
+		}
 	}
 
 create_maps:
@@ -4902,7 +4960,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	trace->multiple_threads = perf_thread_map__pid(evlist__core(evlist)->threads, 0) == -1 ||
 		perf_thread_map__nr(evlist__core(evlist)->threads) > 1 ||
-		evlist__first(evlist)->core.attr.inherit;
+		!trace->opts.no_inherit;
 
 	/*
 	 * Now that we already used evsel->core.attr to ask the kernel to setup the
@@ -5961,8 +6019,6 @@ int cmd_trace(int argc, const char **argv)
 	if (err < 0)
 		goto skip_augmentation;
 
-	trace__add_syscall_newtp(&trace);
-
 	err = augmented_syscalls__create_bpf_output(trace.evlist);
 	if (err == 0)
 		trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
@@ -5998,6 +6054,7 @@ int cmd_trace(int argc, const char **argv)
 
 	if (evlist__nr_entries(trace.evlist) > 0) {
 		bool use_btf = false;
+		struct evsel *augmented = trace.syscalls.events.bpf_output;
 
 		evlist__set_default_evsel_handler(trace.evlist, trace__event_handler);
 		if (evlist__set_syscall_tp_fields(trace.evlist, &use_btf)) {
@@ -6007,6 +6064,20 @@ int cmd_trace(int argc, const char **argv)
 
 		if (use_btf)
 			trace__load_vmlinux_btf(&trace);
+
+		if (augmented) {
+			if (evsel__init_bpf_output_tp(augmented) < 0) {
+				pr_err("Failed to initialize the BPF output event fields\n");
+				goto out;
+			}
+			augmented->handler = trace__bpf_output;
+			/* Just the user space callchain leading to the syscall. */
+			if (callchain_param.enabled && !trace.kernel_syscallchains)
+				augmented->core.attr.exclude_callchain_kernel = 1;
+			trace.raw_augmented_syscalls_args_size = sys_enter_tp.id.offset;
+			trace.raw_augmented_syscalls_args_size += (6 + 1) * sizeof(long);
+			trace.raw_augmented_syscalls = true;
+		}
 	}
 
 	/*
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index d9284a5c030d..d16e55706335 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -7,6 +7,7 @@
  */
 
 #include "vmlinux.h"
+#include "perf_trace_u.h"
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
@@ -62,13 +63,19 @@ struct syscalls_sys_exit {
 } syscalls_sys_exit SEC(".maps");
 
 struct syscall_enter_args {
-	unsigned long long common_tp_fields;
+	union {
+		unsigned long long common_tp_fields;
+		unsigned short	   common_type;
+	};
 	long		   syscall_nr;
 	unsigned long	   args[6];
 };
 
 struct syscall_exit_args {
-	unsigned long long common_tp_fields;
+	union {
+		unsigned long long common_tp_fields;
+		unsigned short	   common_type;
+	};
 	long		   syscall_nr;
 	long		   ret;
 };
@@ -169,10 +176,11 @@ static inline struct augmented_args_payload *augmented_args_payload(void)
 	return bpf_map_lookup_elem(&augmented_args_tmp, &key);
 }
 
-static inline int augmented__output(void *ctx, struct augmented_args_payload *args, int len)
+/* Returning 0 would drop the tracepoint for other perf sessions. */
+static inline int augmented__output(void *ctx, void *args, int len)
 {
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
+	bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
+	return 1;
 }
 
 static inline int augmented__beauty_output(void *ctx, void *data, int len)
@@ -211,12 +219,20 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
 SEC("tp/raw_syscalls/sys_enter")
 int sys_enter_unaugmented(struct syscall_enter_args *args)
 {
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
+
+	if (augmented_args)
+		augmented__output(args, &augmented_args->args, sizeof(augmented_args->args));
 	return 1;
 }
 
 SEC("tp/raw_syscalls/sys_exit")
 int sys_exit_unaugmented(struct syscall_exit_args *args)
 {
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
+
+	if (augmented_args)
+		augmented__output(args, &augmented_args->args, sizeof(struct syscall_exit_args));
 	return 1;
 }
 
@@ -408,7 +424,9 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
 
 	return augmented__output(args, augmented_args, len + size);
 failure:
-	return 1; /* Failure: don't filter */
+	if (augmented_args)
+		augmented__output(args, augmented_args, sizeof(augmented_args->args));
+	return 1;
 }
 
 SEC("tp/syscalls/sys_enter_clock_nanosleep")
@@ -590,6 +608,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 
 	/* copy the sys_enter header, which has the syscall_nr */
 	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
+	payload->args.common_type = SYSCALL_TRACE_ENTER;
 
 	if (bpf_ksym_exists(bpf_iter_num_new)) {
 		bpf_for(i, 0, 6) {
@@ -642,48 +661,55 @@ int sys_enter(struct syscall_enter_args *args)
 		return 1;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
-		return 0;
+		return 1;
 
 	augmented_args = augmented_args_payload();
 	if (augmented_args == NULL)
 		return 1;
 
 	bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_args->args), args);
+	augmented_args->args.common_type = SYSCALL_TRACE_ENTER;
 
 	/*
 	 * Jump to syscall specific augmenter, even if the default one,
-	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
-	 * unaugmented tracepoint payload.
+	 * "!raw_syscalls:unaugmented" that will just output the unaugmented
+	 * payload.
 	 */
 	if (augment_sys_enter(args, &augmented_args->args))
 		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
 
-	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
-	return 0;
+	return 1;
 }
 
 SEC("tp/raw_syscalls/sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
-	struct syscall_exit_args exit_args;
+	struct augmented_args_payload *augmented_args;
 
 	if (!task_traced())
 		return 1;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
-		return 0;
+		return 1;
+
+	augmented_args = augmented_args_payload();
+	if (augmented_args == NULL)
+		return 1;
+
+	bpf_probe_read_kernel(&augmented_args->args, sizeof(*args), args);
+	augmented_args->args.common_type = SYSCALL_TRACE_EXIT;
 
-	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
 	/*
 	 * Jump to syscall specific return augmenter, even if the default one,
-	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
-	 * unaugmented tracepoint payload.
+	 * "!raw_syscalls:unaugmented" that will just output the unaugmented
+	 * payload.
 	 */
-	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
+	bpf_tail_call(args, &syscalls_sys_exit, augmented_args->args.syscall_nr);
 	/*
-	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
+	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it
+	 * by not emitting bpf-output event.
 	 */
-	return 0;
+	return 1;
 }
 
 /* Trace the children of traced tasks, added before they can run. */
diff --git a/tools/perf/util/bpf_skel/perf_trace_u.h b/tools/perf/util/bpf_skel/perf_trace_u.h
new file mode 100644
index 000000000000..004ba96aaba9
--- /dev/null
+++ b/tools/perf/util/bpf_skel/perf_trace_u.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2025 Google */
+
+/* This file will be shared between BPF and userspace. */
+
+#ifndef __PERF_TRACE_U_H
+#define __PERF_TRACE_U_H
+
+enum syscall_trace_type {
+	SYSCALL_TRACE_ENTER = 0,
+	SYSCALL_TRACE_EXIT,
+};
+
+#endif /* __PERF_TRACE_U_H */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

