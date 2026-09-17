Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC83932E6
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627379; cv=none; b=OILrDeQpVppjWfqjlPyhxHlacUGchtufKnizRCi035ulhqp89C9fyeyPLG4rFZGDJa6y97b2g6FZmgjN3e2CdaycAG3UT13I+ejX7sgpBVd0HAc6pAvZ+Po2etCfX+7eEaWMY1fyyHYtoScQfUNsGvhwd96vnb4pNLysnjrbuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627379; c=relaxed/simple;
	bh=0UaIZcn5Up9teKUUH0KGsftFAImOdwDrtfA/UmQ4Ox0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bgFI3HkgdnlCHqOo2A6oJO8x/Brr7SFxPKMfNEdi2WPU6RYQxjYW0kPWWVXG+c/5d3iMrisKZ4NChTTqQFRcAJjljNkRwZDOF6UMxVA47+hAPoe1fHmXmbTlZJ4e69fGte+HPYNyu3MgYAxiy5wPsM9g8SRTWLny1p5HOi/0C3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eyWp3Vt1; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyWp3Vt1"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc489e7a701so790485a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627376; x=1790232176; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HG/rJfvlu+ZVWRRlWPs7VziMtPNTB20fH3aBvPtdRcI=;
        b=eyWp3Vt1X2+6afjQspbZeHA92TU8aCDzR6F01CQezYh/58O8g+4NIXIOeRp8bxw+tm
         3p02+2wa0RpzO+MBUYdoQ7GA8EWmk1xJUxlDPAaNj7zKCPwucIT6wLP4J97K00srgLHF
         /ni87twdn49CRelKDMnyRtAIwJyF82clF2i6emyLo7GXDK8jsXbSGFf7H9buAPoqbWik
         5NFV9llYxx586A1jZuMKDLb7nOuwtyvY0Y4CpEgh6GdIWJY6Fxilg9eUpmZjYD7bZn4R
         WT6cLyt2UDInWxfFaYl6BzJRAFXlZGODXuB6e4pt8/qtmn4PfjaMPmgfCu+C96gkLIc5
         +oYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627376; x=1790232176;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HG/rJfvlu+ZVWRRlWPs7VziMtPNTB20fH3aBvPtdRcI=;
        b=vEKhiti00yKHDmcfjftzQ8XHoucICScxqAZMl4zGwxrp58YwjjIUB55Afsppqoqalv
         ahctmApL9hRn9qVI8J9UzLmX39JaUYV4VZl3JwgCzz0m5vJ1J5E+cN9YsPGGATpAashg
         neG2vXA6HeVVqTFbvXsCoPSm70x2LTFuWiUOQsoG39He4QenVZ8SdXaJEsGMH2VVx75l
         /TrnybqFHjviwzidtTl9tD97a/BMZwLxFrDqhZ/Evr0fLa/Ds+pEsSjdTAUT9IhFrNtV
         z9r+NFS1qtBnsjFJWwA0N2Sluv8IRKKRY6eERYLfoMapxCvRMjrFXWSGV699iHGLAVKZ
         sUbg==
X-Forwarded-Encrypted: i=1; AKwUvBzwf6iYfl8A9SQBGOdBKxzbN/EniApdYO5nZ+KuiHmYXSuOjf7EITCTvLCx6Xv39Ggr75nwTNEjL1/CPo/ExDzC@vger.kernel.org
X-Gm-Message-State: AFuF++mmZn/mDh5+7T8apvP1EHMqSz8Joa1A1UUwMZfQUPCcAujIPCFg
	TFPx30FPJHv/LyZzB/+t8XxtlwQaGyMK5Zl9PsT1tfUJ1A+nTwiLTC86rb23OYLw+fHLZUlS0Cq
	BwTPW4YNAaQ==
X-Received: from dldnz11.prod.google.com ([2002:a05:701a:ca0b:b0:143:8cae:a783])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4c81:b0:3b4:61f:1fec
 with SMTP id adf61e73a8af0-3dd5f3c1abcmr13732655637.2.1789627375781; Wed, 16
 Sep 2026 23:42:55 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:26 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <36cdb33f86d7c1d349fb0554f6ee6c3bc621b051.1789626978.git.irogers@google.com>
Subject: [PATCH v1 04/13] perf trace: Filter events in BPF and avoid
 tracepoint vetoes
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The BPF augmented_raw_syscalls sys_enter and sys_exit programs returned
0 for syscalls that were not of interest. Returning 0 from a tracepoint
BPF program vetoes the event for the whole system, so an unrelated
concurrent perf trace, perf record or ftrace session listening to
raw_syscalls would silently lose events. This is a cross-session side
effect and shows up as flaky failures when perf tests run in parallel.

Furthermore, syscall_unaugmented previously returned 1 without writing
anything to the __augmented_syscalls__ ring buffer. This forced
userspace perf trace to listen to both raw_syscalls:sys_enter and
__augmented_syscalls__ in its evlist, requiring userspace event
deduplication.

Address these issues:
1. In augmented_raw_syscalls.bpf.c, never return 0 from tracepoint
   handlers: return 1 so non-traced syscalls pass through without
   vetoing other concurrent listeners.
2. Introduce pids_to_trace and syscalls_to_trace BPF hash maps to
   perform targeted filtering directly in BPF. Unselected syscalls or
   PIDs return 1 immediately without writing to the buffer.
3. In syscall_unaugmented, output the unaugmented enter payload into
   __augmented_syscalls__ and return 1. Change its section from
   SEC("tp/raw_syscalls/sys_enter") to
   SEC("tp/syscalls/sys_enter_unaugmented") so libbpf does not attempt
   to auto-attach it to raw_syscalls:sys_enter.
4. In bpf_trace_augment.c, add helpers to configure target PIDs and
   syscalls in the BPF maps, setting the activation flags
   (has_pids_to_trace, has_syscalls_to_trace) only after the maps are
   fully populated so already-attached BPF programs do not filter against
   a half-filled map. Explicitly attach only sys_enter and sys_exit via
   an attach_prog() helper that saves -errno before calling pr_debug()
   or bpf_link__destroy().

   Destroy the skeleton on every failure path. Leaving a loaded but
   unusable skeleton behind is not inert: the setters called later from
   trace__run() would program its maps, and a partial attach would leave
   a BPF program live on raw_syscalls for a session that never starts.
   Since augmented_syscalls__{prepare,create_bpf_output}() failures fall
   back to unaugmented tracing rather than aborting, those setters have
   to become no-ops, which they only do once skel is NULL again.

   errno is used directly here, so include <errno.h> rather than relying
   on it arriving via another header, which it does not under musl.
5. In builtin-trace.c, hook trace__set_ev_qualifier_filter() and PID
   filtering into the BPF maps. When __augmented_syscalls__ is active,
   remove raw_syscalls:sys_enter from trace.evlist since all traced enter
   events (both augmented and unaugmented) are now emitted by BPF into
   __augmented_syscalls__. Restore tracking on the remaining evsel via
   evlist__set_tracking_event() so PERF_RECORD_COMM and tracking events
   continue to be recorded. Errors from
   augmented_syscalls__set_target_syscalls() are reported and
   propagated, the tracepoint filter string is freed on every exit path,
   and an allocation failure in trace__set_filter_pids() now returns
   -ENOMEM instead of being silently ignored.

   Note that in trace__set_filter_pids() the target pids and the filtered
   pids are two independent axes and both have to be programmed. Naming
   pids to leave out with --filter-pids does not widen -p/-t or a workload
   to the whole system, and a BPF tracepoint program is attached system
   wide rather than to the target's file descriptors, so pids_to_trace is
   the only thing keeping other tasks out.
6. Add --syscall-augment option (defaulting to true) to allow users to
   explicitly use --no-syscall-augment to run perf trace in the classic
   unaugmented tracepoint mode without BPF. When BPF is unavailable or
   disabled, ensure the non-augmented tracepoint path cleanly configures
   sys_enter and sys_exit without duplicate entries.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-trace.txt       |   5 +
 tools/perf/builtin-trace.c                    | 146 +++++++++++++++---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 133 ++++++++++++++--
 tools/perf/util/bpf_trace_augment.c           | 135 +++++++++++++++-
 tools/perf/util/trace_augment.h               |  33 ++++
 5 files changed, 414 insertions(+), 38 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index d20b43ea3d37..4680c69160d7 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -260,6 +260,11 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	Maximum number of lines in the summary mode.  Note that this applies to
 	each entry (thread or cgroup).
 
+--syscall-augment::
+	Augment syscalls with BPF. Enabled by default when BPF support is available.
+	Use --no-syscall-augment to disable BPF augmentation and fall back to the
+	unaugmented tracepoint approach.
+
 
 PAGEFAULTS
 ----------
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a68d34256996..e21b2b4a8794 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -200,6 +200,7 @@ struct trace {
 	int			max_summary;
 	int			raw_augmented_syscalls_args_size;
 	bool			raw_augmented_syscalls;
+	bool			syscall_augment;
 	bool			fd_path_disabled;
 	bool			sort_events;
 	bool			not_ev_qualifier;
@@ -2054,6 +2055,23 @@ static int trace__process_event(struct trace *trace, struct machine *machine,
 			      "LOST %" PRIu64 " events!\n", (u64)event->lost.lost);
 		ret = machine__process_lost_event(machine, event, sample);
 		break;
+	case PERF_RECORD_FORK:
+		if (trace->raw_augmented_syscalls &&
+		    (augmented_syscalls__has_target_pid(event->fork.ppid) ||
+		     augmented_syscalls__has_target_pid(event->fork.ptid))) {
+			augmented_syscalls__add_target_pid(event->fork.pid);
+		}
+		ret = machine__process_fork_event(machine, event, sample);
+		break;
+	case PERF_RECORD_EXIT:
+		if (trace->raw_augmented_syscalls) {
+			if (event->fork.pid == event->fork.tid)
+				augmented_syscalls__del_target_pid(event->fork.pid);
+			else
+				augmented_syscalls__del_target_pid(event->fork.tid);
+		}
+		ret = machine__process_exit_event(machine, event, sample);
+		break;
 	default:
 		ret = machine__process_event(machine, event, sample);
 		break;
@@ -4043,7 +4061,7 @@ static int trace__add_syscall_newtp(struct trace *trace)
 
 static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 {
-	int err = -1;
+	int err = 0;
 	struct evsel *sys_exit;
 	char *filter = asprintf_expr_inout_ints("id", !trace->not_ev_qualifier,
 						trace->ev_qualifier_ids.nr,
@@ -4052,10 +4070,17 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 	if (filter == NULL)
 		goto out_enomem;
 
-	if (!evsel__append_tp_filter(trace->syscalls.events.sys_enter, filter)) {
-		sys_exit = trace->syscalls.events.sys_exit;
+	/*
+	 * With BPF augmentation sys_enter is filtered in BPF and removed from
+	 * the evlist, so only apply the tracepoint filter to the events that
+	 * are actually present.
+	 */
+	if (trace->syscalls.events.sys_enter)
+		err = evsel__append_tp_filter(trace->syscalls.events.sys_enter, filter);
+
+	sys_exit = trace->syscalls.events.sys_exit;
+	if (!err && sys_exit)
 		err = evsel__append_tp_filter(sys_exit, filter);
-	}
 
 	free(filter);
 out:
@@ -4502,7 +4527,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace __maybe_
 
 static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
-	if (trace->syscalls.events.sys_enter)
+	/*
+	 * Synchronize syscall filter with BPF augmenter map:
+	 * Pass trace->not_ev_qualifier to indicate blacklist mode ('!' prefix,
+	 * e.g., -e !open,close) vs whitelist mode (-e open,close).
+	 *
+	 * A failure here would leave the BPF program filtering on a partially
+	 * populated map, silently dropping or emitting the wrong syscalls, so
+	 * propagate the error rather than continuing.
+	 */
+	if (trace->ev_qualifier_ids.nr > 0) {
+		int err = augmented_syscalls__set_target_syscalls(trace->ev_qualifier_ids.nr,
+								  trace->ev_qualifier_ids.entries,
+								  trace->not_ev_qualifier);
+
+		if (err) {
+			pr_err("Failed to set the syscalls to trace in the BPF map: %d\n", err);
+			return err;
+		}
+	}
+
+	if (trace->syscalls.events.sys_enter || trace->syscalls.events.sys_exit)
 		return trace__set_ev_qualifier_tp_filter(trace);
 	return 0;
 }
@@ -4543,13 +4588,21 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 
 static int trace__set_filter_pids(struct trace *trace)
 {
-	int err = 0;
+	struct perf_thread_map *threads = evlist__core(trace->evlist)->threads;
 	/*
 	 * Better not use !target__has_task() here because we need to cover the
 	 * case where no threads were specified in the command line, but a
 	 * workload was, and in that case we will fill in the thread_map when
 	 * we fork the workload in evlist__prepare_workload.
 	 */
+	bool has_target = perf_thread_map__pid(threads, 0) != -1;
+	int err = 0;
+
+	/*
+	 * The exclusion list: --filter-pids names tasks to never report, and
+	 * with no target at all we instead exclude perf itself so that tracing
+	 * does not feed back into itself.
+	 */
 	if (trace->filter_pids.nr > 0) {
 		err = evlist__append_tp_filter_pids(trace->evlist, trace->filter_pids.nr,
 						    trace->filter_pids.entries);
@@ -4557,10 +4610,37 @@ static int trace__set_filter_pids(struct trace *trace)
 			err = augmented_syscalls__set_filter_pids(trace->filter_pids.nr,
 						       trace->filter_pids.entries);
 		}
-	} else if (perf_thread_map__pid(evlist__core(trace->evlist)->threads, 0) == -1) {
+	} else if (!has_target) {
 		err = trace__set_filter_loop_pids(trace);
 	}
 
+	if (err)
+		return err;
+
+	/*
+	 * The inclusion list, which is a separate axis from the exclusion list
+	 * above and so must be programmed even when --filter-pids was given:
+	 * naming tasks to leave out does not widen -p/-t or a workload to the
+	 * whole system.
+	 *
+	 * This matters more than it does on the tracepoint only path. A BPF
+	 * tracepoint program is attached system wide rather than to the
+	 * target's file descriptors, so pids_to_trace is the only thing
+	 * keeping other tasks out.
+	 */
+	if (has_target) {
+		int nr = perf_thread_map__nr(threads);
+		pid_t *pids = malloc(nr * sizeof(pid_t));
+
+		if (pids == NULL)
+			return -ENOMEM;
+
+		for (int i = 0; i < nr; i++)
+			pids[i] = perf_thread_map__pid(threads, i);
+		err = augmented_syscalls__set_target_pids(nr, pids);
+		free(pids);
+	}
+
 	return err;
 }
 
@@ -4787,7 +4867,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	}
 
 	if (!trace->raw_augmented_syscalls) {
-		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
+		if (trace->trace_syscalls && !trace->syscalls.events.sys_enter &&
+		    trace__add_syscall_newtp(trace))
 			goto out_error_raw_syscalls;
 
 		if (trace->trace_syscalls)
@@ -5795,6 +5876,7 @@ int cmd_trace(int argc, const char **argv)
 		.show_arg_names = true,
 		.args_alignment = 70,
 		.trace_syscalls = false,
+		.syscall_augment = true,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
 		.max_events = ULONG_MAX,
@@ -5850,6 +5932,8 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK_DEFAULT('F', "pf", &trace.trace_pgfaults, "all|maj|min",
 		     "Trace pagefaults", parse_pagefaults, "maj"),
 	OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls"),
+	OPT_BOOLEAN(0, "syscall-augment", &trace.syscall_augment,
+		    "Augment syscalls with BPF"),
 	OPT_BOOLEAN('f', "force", &trace.force, "don't complain, do it"),
 	OPT_CALLBACK(0, "call-graph", &trace.opts,
 		     "record_mode[,record_size]", record_callchain_help,
@@ -5972,7 +6056,7 @@ int cmd_trace(int argc, const char **argv)
 				       "cgroup monitoring only available in system-wide mode");
 	}
 
-	if (!trace.trace_syscalls)
+	if (!trace.trace_syscalls || !trace.syscall_augment)
 		goto skip_augmentation;
 
 	if ((argc >= 1) && (strcmp(argv[0], "record") == 0)) {
@@ -5997,8 +6081,19 @@ int cmd_trace(int argc, const char **argv)
 	trace__add_syscall_newtp(&trace);
 
 	err = augmented_syscalls__create_bpf_output(trace.evlist);
-	if (err == 0)
+	if (err == 0) {
 		trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
+	} else {
+		/*
+		 * augmented_syscalls__prepare() already attached sys_enter and
+		 * sys_exit, which are system wide. Falling through to
+		 * skip_augmentation without undoing that would run a BPF
+		 * program for every syscall on the machine, for the whole
+		 * session, with nothing consuming the output.
+		 */
+		pr_debug("Failed to create the augmented syscalls bpf-output event, disabling augmentation\n");
+		augmented_syscalls__cleanup();
+	}
 
 skip_augmentation:
 	err = -1;
@@ -6054,7 +6149,9 @@ int cmd_trace(int argc, const char **argv)
 	 * syscall.
 	 */
 	if (trace.syscalls.events.bpf_output) {
-		evlist__for_each_entry(trace.evlist, evsel) {
+		struct evsel *n;
+
+		evlist__for_each_entry_safe(trace.evlist, n, evsel) {
 			bool raw_syscalls_sys_exit = evsel__name_is(evsel, "raw_syscalls:sys_exit");
 
 			if (raw_syscalls_sys_exit) {
@@ -6069,21 +6166,26 @@ int cmd_trace(int argc, const char **argv)
 				    evsel__init_augmented_syscall_tp_args(augmented))
 					goto out;
 				/*
-				 * Augmented is __augmented_syscalls__ BPF_OUTPUT event
+				 * Augmented is __augmented_syscalls__ BPF_OUTPUT event.
 				 * Above we made sure we can get from the payload the tp fields
 				 * that we get from syscalls:sys_enter tracefs format file.
+				 * Since BPF outputs all enter events (both augmented and
+				 * unaugmented) into __augmented_syscalls__, we remove the raw
+				 * sys_enter evsel from evlist so that perf trace only listens
+				 * to __augmented_syscalls__, avoiding duplicate events and
+				 * avoiding kernel tracepoint vetoes.
+				 *
+				 * Because evlist__remove() removes the first evsel (which had
+				 * tracking=true by default), re-designate the tracking event
+				 * so PERF_RECORD_COMM and fork tracking continue to be enabled.
 				 */
 				augmented->handler = trace__sys_enter;
-				/*
-				 * Now we do the same for the *syscalls:sys_enter event so that
-				 * if we handle it directly, i.e. if the BPF prog returns 0 so
-				 * as not to filter it, then we'll handle it just like we would
-				 * for the BPF_OUTPUT one:
-				 */
-				if (evsel__init_augmented_syscall_tp(evsel, evsel) ||
-				    evsel__init_augmented_syscall_tp_args(evsel))
-					goto out;
-				evsel->handler = trace__sys_enter;
+				evlist__remove(trace.evlist, evsel);
+				evsel__put_and_free_priv(evsel);
+				trace.syscalls.events.sys_enter = NULL;
+				evlist__set_tracking_event(trace.evlist,
+					trace.syscalls.events.sys_exit ?: augmented);
+				continue;
 			}
 
 			if (strstarts(evsel__name(evsel), "syscalls:sys_exit_")) {
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 3bc9e28a9b8a..6ca9507ecc02 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -114,6 +114,41 @@ struct pids_filtered {
 	__uint(max_entries, 64);
 } pids_filtered SEC(".maps");
 
+/*
+ * Optional hash map containing specific PIDs/TGIDs to trace (e.g., when
+ * attached to a process with -p or tracing a specific command workload).
+ *
+ * has_pids_to_trace: Set to true if target PID filtering is active.
+ *                    When false, all processes are eligible for tracing.
+ */
+struct pids_to_trace {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, bool);
+	__uint(max_entries, 1024);
+} pids_to_trace SEC(".maps");
+
+bool has_pids_to_trace;
+
+/*
+ * Hash map storing syscall IDs for filtering (via 'perf trace -e ...').
+ *
+ * has_syscalls_to_trace: Set to true if any syscall filter is active.
+ * not_syscalls_to_trace: Inverts matching when '!' prefix is used in -e
+ *                        (e.g., -e !open,close means trace everything EXCEPT
+ *                        open and close; an exclusion blacklist rather than
+ *                        an inclusion whitelist).
+ */
+struct syscalls_to_trace {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, int);
+	__type(value, bool);
+	__uint(max_entries, 1024);
+} syscalls_to_trace SEC(".maps");
+
+bool has_syscalls_to_trace;
+bool not_syscalls_to_trace;
+
 struct augmented_args_payload {
 	struct syscall_enter_args args;
 	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
@@ -154,8 +189,8 @@ static inline struct augmented_args_payload *augmented_args_payload(void)
 
 static inline int augmented__output(void *ctx, struct augmented_args_payload *args, int len)
 {
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
+	bpf_perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
+	return 1;
 }
 
 static inline int augmented__beauty_output(void *ctx, void *data, int len)
@@ -191,10 +226,21 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
 	return augmented_len;
 }
 
-SEC("tp/raw_syscalls/sys_enter")
+/*
+ * Default sys_enter program for syscalls without pointer argument augmentation.
+ * Writes the raw struct syscall_enter_args payload into __augmented_syscalls__
+ * and returns 1 so the tracepoint is never vetoed in the kernel.
+ */
+SEC("tp/syscalls/sys_enter_unaugmented")
 int syscall_unaugmented(struct syscall_enter_args *args)
 {
-	return 1;
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
+
+	if (augmented_args == NULL)
+		return 1;
+
+	bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_args->args), args);
+	return augmented__output(args, augmented_args, sizeof(augmented_args->args));
 }
 
 /*
@@ -424,11 +470,41 @@ static pid_t getpid(void)
 	return bpf_get_current_pid_tgid();
 }
 
+/*
+ * Returns true if a PID is explicitly excluded/filtered out (e.g., via --filter-pids).
+ */
 static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 {
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
+/*
+ * Checks if the current task (thread PID or process TGID) is targeted for tracing.
+ * Checks both PID (thread ID) and TGID (process ID) so that all threads of a
+ * target process match.
+ */
+static inline bool pid_to_trace__has(pid_t pid)
+{
+	pid_t tgid = bpf_get_current_pid_tgid() >> 32;
+
+	return bpf_map_lookup_elem(&pids_to_trace, &pid) != NULL ||
+	       bpf_map_lookup_elem(&pids_to_trace, &tgid) != NULL;
+}
+
+/*
+ * Determines if a syscall should be traced based on the filter map:
+ * - When not_syscalls_to_trace is true: blacklist mode (trace if NOT in map).
+ * - When not_syscalls_to_trace is false: whitelist mode (trace ONLY if IN map).
+ */
+static inline bool syscall_to_trace__enabled(int id)
+{
+	bool in_map = bpf_map_lookup_elem(&syscalls_to_trace, &id) != NULL;
+
+	if (not_syscalls_to_trace)
+		return !in_map;
+	return in_map;
+}
+
 u64 ZERO = 0;
 
 /*
@@ -562,6 +638,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
 }
 
+/*
+ * Main raw_syscalls:sys_enter tracepoint handler.
+ * Always returns 1 so the tracepoint is never vetoed in the kernel for
+ * other concurrent listeners. Filtered events simply do not output to the ring buffer.
+ */
 SEC("tp/raw_syscalls/sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
@@ -576,8 +657,11 @@ int sys_enter(struct syscall_enter_args *args)
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
 
+	if (has_pids_to_trace && !pid_to_trace__has(getpid()))
+		return 1;
+
 	if (pid_filter__has(&pids_filtered, getpid()))
-		return 0;
+		return 1;
 
 	augmented_args = augmented_args_payload();
 	if (augmented_args == NULL)
@@ -585,25 +669,41 @@ int sys_enter(struct syscall_enter_args *args)
 
 	bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_args->args), args);
 
+	if (has_syscalls_to_trace && !syscall_to_trace__enabled(augmented_args->args.syscall_nr))
+		return 1;
+
 	/*
-	 * Jump to syscall specific augmenter, even if the default one,
-	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
-	 * unaugmented tracepoint payload.
+	 * Jump to syscall specific augmenter. If augmented, augment_sys_enter()
+	 * outputs the payload to __augmented_syscalls__ and returns 0.
+	 * Return 1 so we never veto the kernel tracepoint for other listeners.
 	 */
-	if (augment_sys_enter(args, &augmented_args->args))
-		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
+	if (augment_sys_enter(args, &augmented_args->args) == 0)
+		return 1;
 
-	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
-	return 0;
+	bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
+
+	/*
+	 * If not found on the PROG_ARRAY syscalls map, return 1 so we
+	 * don't veto the tracepoint event system-wide for other concurrent
+	 * listeners.
+	 */
+	return 1;
 }
 
+/*
+ * Main raw_syscalls:sys_exit tracepoint handler.
+ * Always returns 1 so the tracepoint is never vetoed in the kernel.
+ */
 SEC("tp/raw_syscalls/sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
 	struct syscall_exit_args exit_args;
 
+	if (has_pids_to_trace && !pid_to_trace__has(getpid()))
+		return 1;
+
 	if (pid_filter__has(&pids_filtered, getpid()))
-		return 0;
+		return 1;
 
 	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
 	/*
@@ -613,9 +713,12 @@ int sys_exit(struct syscall_exit_args *args)
 	 */
 	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
 	/*
-	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
+	 * If not found on the PROG_ARRAY syscalls map, return 1 so we
+	 * don't veto the tracepoint event system-wide for other concurrent
+	 * listeners. perf trace's own evsel filter will discard non-matching
+	 * syscalls.
 	 */
-	return 0;
+	return 1;
 }
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index a9cf2a77ded1..b9d1208e50f2 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -1,4 +1,5 @@
 #include <bpf/libbpf.h>
+#include <errno.h>
 #include <internal/xyarray.h>
 
 #include "bpf_skel/augmented_raw_syscalls.skel.h"
@@ -10,6 +11,23 @@
 static struct augmented_raw_syscalls_bpf *skel;
 static struct evsel *bpf_output;
 
+/* Set by attach_prog() so the first failure is what gets reported. */
+static int attach_err;
+
+static int attach_prog(struct bpf_link **link, struct bpf_program *prog, const char *name)
+{
+	*link = bpf_program__attach(prog);
+	if (*link)
+		return 0;
+	/*
+	 * Save errno before pr_debug(), which formats and writes output and so
+	 * can overwrite it.
+	 */
+	attach_err = -errno;
+	pr_debug("Failed to attach %s BPF program\n", name);
+	return attach_err;
+}
+
 int augmented_syscalls__prepare(void)
 {
 	struct bpf_program *prog;
@@ -35,11 +53,35 @@ int augmented_syscalls__prepare(void)
 	if (err < 0) {
 		libbpf_strerror(err, buf, sizeof(buf));
 		pr_debug("Failed to load augmented syscalls BPF skeleton: %s\n", buf);
+		/*
+		 * Tear the skeleton down rather than leaving a half initialized
+		 * one behind. The caller falls back to unaugmented tracing and
+		 * still calls the setters below, which must then do nothing
+		 * instead of failing against a skeleton with no maps.
+		 */
+		augmented_syscalls__cleanup();
 		return err;
 	}
 
-	augmented_raw_syscalls_bpf__attach(skel);
+	/*
+	 * Only sys_enter and sys_exit are attached, the remaining programs are
+	 * reached by tail calls. Attach them explicitly and, on failure, undo
+	 * any partial attachment: leaving sys_enter live on
+	 * raw_syscalls:sys_enter would keep running a BPF program for every
+	 * syscall on the system for a perf trace session that never starts.
+	 */
+	if (attach_prog(&skel->links.sys_enter, skel->progs.sys_enter, "sys_enter"))
+		goto out_cleanup;
+	if (attach_prog(&skel->links.sys_exit, skel->progs.sys_exit, "sys_exit"))
+		goto out_cleanup;
+
 	return 0;
+
+out_cleanup:
+	err = attach_err;
+	/* Destroys every link attached above along with the skeleton. */
+	augmented_syscalls__cleanup();
+	return err;
 }
 
 int augmented_syscalls__create_bpf_output(struct evlist *evlist)
@@ -98,6 +140,96 @@ int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids)
 	return err;
 }
 
+/*
+ * Populate target PIDs in the BPF pids_to_trace map (e.g., for -p <PID> or
+ * when tracing a specified command workload).
+ */
+int augmented_syscalls__set_target_pids(unsigned int nr, pid_t *pids)
+{
+	bool value = true;
+	int err = 0;
+
+	if (skel == NULL || nr == 0)
+		return 0;
+
+	for (size_t i = 0; i < nr; ++i) {
+		err = bpf_map__update_elem(skel->maps.pids_to_trace, &pids[i],
+					   sizeof(*pids), &value, sizeof(value),
+					   BPF_ANY);
+		if (err)
+			return err;
+	}
+	/*
+	 * Set the flag only once every target is in the map. The BPF programs
+	 * are attached by this point, so flipping it first would have them
+	 * filter against a partially populated map and drop syscalls made by
+	 * the targets that had not been added yet.
+	 */
+	skel->bss->has_pids_to_trace = true;
+	return 0;
+}
+
+int augmented_syscalls__add_target_pid(pid_t pid)
+{
+	bool value = true;
+
+	if (skel == NULL || !skel->bss->has_pids_to_trace || skel->maps.pids_to_trace == NULL)
+		return 0;
+
+	return bpf_map__update_elem(skel->maps.pids_to_trace, &pid, sizeof(pid),
+				    &value, sizeof(value), BPF_ANY);
+}
+
+int augmented_syscalls__del_target_pid(pid_t pid)
+{
+	if (skel == NULL || !skel->bss->has_pids_to_trace || skel->maps.pids_to_trace == NULL)
+		return 0;
+
+	return bpf_map__delete_elem(skel->maps.pids_to_trace, &pid, sizeof(pid), 0);
+}
+
+bool augmented_syscalls__has_target_pid(pid_t pid)
+{
+	bool value;
+
+	if (skel == NULL || !skel->bss->has_pids_to_trace || skel->maps.pids_to_trace == NULL)
+		return false;
+
+	return bpf_map__lookup_elem(skel->maps.pids_to_trace, &pid, sizeof(pid),
+				    &value, sizeof(value), 0) == 0;
+}
+
+/*
+ * Populate syscalls in the BPF syscalls_to_trace map:
+ * - not_syscalls: true if '!' prefix was specified (blacklist mode: trace
+ *   all syscalls EXCEPT these).
+ *   false if whitelist mode (trace ONLY these syscalls).
+ */
+int augmented_syscalls__set_target_syscalls(unsigned int nr, int *syscall_ids, bool not_syscalls)
+{
+	bool value = true;
+	int err = 0;
+
+	if (skel == NULL || nr == 0)
+		return 0;
+
+	skel->bss->not_syscalls_to_trace = not_syscalls;
+	for (size_t i = 0; i < nr; ++i) {
+		err = bpf_map__update_elem(skel->maps.syscalls_to_trace, &syscall_ids[i],
+					   sizeof(int), &value, sizeof(value),
+					   BPF_ANY);
+		if (err)
+			return err;
+	}
+	/*
+	 * As for the pid maps, publish the filter only once it is complete:
+	 * in whitelist mode a half filled map would drop syscalls that were
+	 * asked for but not added yet.
+	 */
+	skel->bss->has_syscalls_to_trace = true;
+	return 0;
+}
+
 int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd)
 {
 	if (skel == NULL)
@@ -140,4 +272,5 @@ struct bpf_program *augmented_syscalls__find_by_title(const char *name)
 void augmented_syscalls__cleanup(void)
 {
 	augmented_raw_syscalls_bpf__destroy(skel);
+	skel = NULL;
 }
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
index 4f729bc67753..56f4dbab7d4b 100644
--- a/tools/perf/util/trace_augment.h
+++ b/tools/perf/util/trace_augment.h
@@ -12,6 +12,11 @@ int augmented_syscalls__prepare(void);
 int augmented_syscalls__create_bpf_output(struct evlist *evlist);
 void augmented_syscalls__setup_bpf_output(void);
 int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids);
+int augmented_syscalls__set_target_pids(unsigned int nr, pid_t *pids);
+int augmented_syscalls__add_target_pid(pid_t pid);
+int augmented_syscalls__del_target_pid(pid_t pid);
+bool augmented_syscalls__has_target_pid(pid_t pid);
+int augmented_syscalls__set_target_syscalls(unsigned int nr, int *syscall_ids, bool not_syscalls);
 int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd);
 struct bpf_program *augmented_syscalls__find_by_title(const char *name);
 struct bpf_program *augmented_syscalls__unaugmented(void);
@@ -39,6 +44,34 @@ static inline int augmented_syscalls__set_filter_pids(unsigned int nr __maybe_un
 	return 0;
 }
 
+static inline int augmented_syscalls__set_target_pids(unsigned int nr __maybe_unused,
+						      pid_t *pids __maybe_unused)
+{
+	return 0;
+}
+
+static inline int augmented_syscalls__add_target_pid(pid_t pid __maybe_unused)
+{
+	return 0;
+}
+
+static inline int augmented_syscalls__del_target_pid(pid_t pid __maybe_unused)
+{
+	return 0;
+}
+
+static inline bool augmented_syscalls__has_target_pid(pid_t pid __maybe_unused)
+{
+	return false;
+}
+
+static inline int augmented_syscalls__set_target_syscalls(unsigned int nr __maybe_unused,
+							  int *syscall_ids __maybe_unused,
+							  bool not_syscalls __maybe_unused)
+{
+	return 0;
+}
+
 static inline int augmented_syscalls__get_map_fds(int *enter_fd __maybe_unused,
 						  int *exit_fd __maybe_unused,
 						  int *beauty_fd __maybe_unused)
-- 
2.55.0.1082.g2b9226bbc0-goog

