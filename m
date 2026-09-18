Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AD495ACE
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740445; cv=none; b=ecWC+7pMkHwqqBLzHji4rAjo4u0rPbusESXkMqPiSgJ21E5W/JQgFc0iSGq0QEkGSFeLN/kLOJI/2E6hHFrA1avMjSFgLfJb6ErLP77OnAKGw72pSs7lbK1zXTUDfH0FbgPHvLw+sgLtVuZyIHsg9BrTgWQuPphgyp+NB0m+CNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740445; c=relaxed/simple;
	bh=jp24xT/i72n5k+vIan4FEGwLDKlFkNOKIvogBb2FOoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tYmBqFlYBTpUzQzyPKeDy3cRQRiv3HFHXEc6oY2pPSCVbt66HLVr0grAoyjDbFNVfVr4xuo/Tcgle8vqkheIr2zQ3tNBJXkOokSTOTKNWTyOE39z6q7eQZqhzD8HbVUMX3uSCkYw5tgblt84iogRT7IHgtOpQxo6SWkPrRbYU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyIZkflR; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyIZkflR"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so2488100a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740442; x=1790345242; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XeEGcjqkAzebPuFIuMaQhwZIV9meq/CR+QDf43PTNGI=;
        b=PyIZkflRjgnmPih0xgYJLfG/oS0k18sKs/Ef9Jxhztn70HZcQY3IvIrY/MzCA5HRb7
         O5oNKl7e50qjg1KuGgo0b15GU/MboiJ/6eFedjMmUonIJ/CQL8DqCE4Jpr7QqIsemnwh
         kVaRn89scFEnPS87gAFJP56BowyADdll1Ij43TPusJsQd1zRa7rIFB23fzevnArPLQb/
         EkIApzwOcW7yztPTBVjcih13p4mHu2uukcxp66KryzB9o5IU+ows/SFKnl1XHy7x+f6Q
         G7zzUGy8DCMBa/XZ7KqOoWBFOz+5lJqaY6b7qLuvgSGkepZZfH/9Ks4FmsI139lP6M9C
         UfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740442; x=1790345242;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XeEGcjqkAzebPuFIuMaQhwZIV9meq/CR+QDf43PTNGI=;
        b=2hewfjsedXIjgWUcE5z+Nk/EihggcAdR9xuiup+KpFudcoMcxtZk9fi82XAHzTWQMP
         miUARK5RlgNr4G29zhckBPdAosalDDLfHAh2BbZdc9VpRewAPxTGW/iTlzXQSwVQMTX4
         KA31e3uD/tNwjfi/LjFNBH63/yqgnTVs5Sk/3eDqMAKjW4rflpe7RkEbvapJQYb30jph
         9mny++m/Z91kUcbKdLFs3CltEmCLs9an0mN48atQef1QW1DJnchvP6MNEvADIlVuhiTR
         wkCoTLNTgDksFlRd7wJbeZUDa01Om41DOg+e67Wgk7kCeCuVA2L14ZoN/d75nmRiB9QF
         EQyg==
X-Forwarded-Encrypted: i=1; AKwUvByddN8Wg0UrFLAUOkKeJAioxwx3SLgwel1EW6kB5WVcASHAvrnsa1C2pJglowaUU1U7I8LMq6B1Hs/4CahPvjKP@vger.kernel.org
X-Gm-Message-State: AFuF++mS09E3CTmUe0NJY2H58yHrm87yOxi5JK6Phjbd56YhwpvVij31
	U3jNakALk+MkHL0+FMHLAN/a5jUo1vdP17WAE3hRablfqeUlbZceI1I38F/vy5zr3f9nnEAKFf2
	Z4nybjSQpwQ==
X-Received: from dldyq20-n2.prod.google.com ([2002:a05:701b:4554:20b0:143:88a3:3a89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5705:b0:39e:2faa:2e83
 with SMTP id 98e67ed59e1d1-39e54d1e044mr6105194a91.10.1789740441635; Fri, 18
 Sep 2026 07:07:21 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:49 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-7-irogers@google.com>
Subject: [PATCH v3 06/16] perf trace: Filter events in BPF and avoid
 tracepoint vetoes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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
   __augmented_syscalls__. Identify that evsel by comparing against
   trace.syscalls.events.sys_enter rather than by a strstr() of its
   name. The substring "syscalls:sys_enter" also matches the per
   syscall syscalls:sys_enter_SYSCALL tracepoints, which a user can ask
   for by name, and now that the match decides what is taken out of the
   evlist, claiming one of those would drop an event that was asked for
   and would describe __augmented_syscalls__ with its format rather
   than the raw one's. Restore tracking on the remaining evsel via
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

Report a failure to program the pid filters with the error that caused
it. trace__run() sent everything trace__set_filter_pids() returned to
out_error_mem, which prints "Not enough memory to run!". That was
already a guess, and becomes a wrong one now that the function also
writes BPF maps: the update fails with -E2BIG when the target has more
threads than pids_to_trace has room for, which has nothing to do with
memory and is not something the user can act on from that message.

Report a failure to program the syscall filters the same way. The
pr_err() in trace__set_ev_qualifier_filter() ran before trace__run()
reached out_errno and printed "%m", and anything called in between
could have changed errno by then, so the two did not have to agree.
The inner report becomes a pr_debug() and the caller prints the error
it was given, which leaves out_errno without a user and it is removed.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-trace.txt       |   5 +
 tools/perf/builtin-trace.c                    | 196 +++++++++++++++---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 133 ++++++++++--
 tools/perf/util/bpf_trace_augment.c           | 135 +++++++++++-
 tools/perf/util/trace_augment.h               |  34 +++
 5 files changed, 457 insertions(+), 46 deletions(-)

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
index 2c62d38b19ac..e3c3f301e0b1 100644
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
@@ -2060,6 +2061,23 @@ static int trace__process_event(struct trace *trace, struct machine *machine,
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
@@ -4049,7 +4067,7 @@ static int trace__add_syscall_newtp(struct trace *trace)
 
 static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 {
-	int err = -1;
+	int err = 0;
 	struct evsel *sys_exit;
 	char *filter = asprintf_expr_inout_ints("id", !trace->not_ev_qualifier,
 						trace->ev_qualifier_ids.nr,
@@ -4058,15 +4076,27 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
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
 	return err;
 out_enomem:
+	/*
+	 * err defaults to 0 because either tracepoint may legitimately be
+	 * absent, so the error has to be set explicitly here.
+	 */
+	err = -ENOMEM;
 	errno = ENOMEM;
 	goto out;
 }
@@ -4508,7 +4538,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace __maybe_
 
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
+			pr_debug("Failed to set the syscalls to trace in the BPF map: %d\n", err);
+			return err;
+		}
+	}
+
+	if (trace->syscalls.events.sys_enter || trace->syscalls.events.sys_exit)
 		return trace__set_ev_qualifier_tp_filter(trace);
 	return 0;
 }
@@ -4549,13 +4599,21 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 
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
@@ -4563,10 +4621,37 @@ static int trace__set_filter_pids(struct trace *trace)
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
 
@@ -4793,7 +4878,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	}
 
 	if (!trace->raw_augmented_syscalls) {
-		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
+		if (trace->trace_syscalls && !trace->syscalls.events.sys_enter &&
+		    trace__add_syscall_newtp(trace))
 			goto out_error_raw_syscalls;
 
 		if (trace->trace_syscalls)
@@ -4888,7 +4974,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	err = trace__set_filter_pids(trace);
 	if (err < 0)
-		goto out_error_mem;
+		goto out_error_filter_pids;
 
 	/*
 	 * TODO: Initialize for all host binary machine types, not just
@@ -4899,7 +4985,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->ev_qualifier_ids.nr > 0) {
 		err = trace__set_ev_qualifier_filter(trace);
 		if (err < 0)
-			goto out_errno;
+			goto out_error_ev_qualifier;
 
 		if (trace->syscalls.events.sys_exit) {
 			pr_debug("event qualifier tracepoint filter: %s\n",
@@ -5079,14 +5165,32 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		"Failed to set filter \"%s\" on event %s: %m\n",
 		evsel->filter, evsel__name(evsel));
 	goto out_put_evlist;
+
+out_error_filter_pids:
+	/*
+	 * Report what actually went wrong. Programming the pid filters
+	 * allocates, but it also writes BPF maps, which fails for reasons of
+	 * its own: -E2BIG when the target has more threads than pids_to_trace
+	 * has room for, say.
+	 */
+	fprintf(trace->output, "Failed to set the pid filters: %s\n",
+		str_error_r(-err, errbuf, sizeof(errbuf)));
+	goto out_put_evlist;
+
+out_error_ev_qualifier:
+	/*
+	 * Use the returned error, not errno. Reporting the failure on the way
+	 * out of trace__set_ev_qualifier_filter() goes through the formatted
+	 * output functions, which are free to leave errno describing
+	 * something else by the time it is read here.
+	 */
+	fprintf(trace->output, "Failed to set the syscall filters: %s\n",
+		str_error_r(-err, errbuf, sizeof(errbuf)));
+	goto out_put_evlist;
 }
 out_error_mem:
 	fprintf(trace->output, "Not enough memory to run!\n");
 	goto out_put_evlist;
-
-out_errno:
-	fprintf(trace->output, "%m\n");
-	goto out_put_evlist;
 }
 
 static int trace__replay(struct trace *trace)
@@ -5801,6 +5905,7 @@ int cmd_trace(int argc, const char **argv)
 		.show_arg_names = true,
 		.args_alignment = 70,
 		.trace_syscalls = false,
+		.syscall_augment = true,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
 		.max_events = ULONG_MAX,
@@ -5856,6 +5961,8 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK_DEFAULT('F', "pf", &trace.trace_pgfaults, "all|maj|min",
 		     "Trace pagefaults", parse_pagefaults, "maj"),
 	OPT_BOOLEAN(0, "syscalls", &trace.trace_syscalls, "Trace syscalls"),
+	OPT_BOOLEAN(0, "syscall-augment", &trace.syscall_augment,
+		    "Augment syscalls with BPF"),
 	OPT_BOOLEAN('f', "force", &trace.force, "don't complain, do it"),
 	OPT_CALLBACK(0, "call-graph", &trace.opts,
 		     "record_mode[,record_size]", record_callchain_help,
@@ -5978,7 +6085,7 @@ int cmd_trace(int argc, const char **argv)
 				       "cgroup monitoring only available in system-wide mode");
 	}
 
-	if (!trace.trace_syscalls)
+	if (!trace.trace_syscalls || !trace.syscall_augment)
 		goto skip_augmentation;
 
 	if ((argc >= 1) && (strcmp(argv[0], "record") == 0)) {
@@ -6003,8 +6110,19 @@ int cmd_trace(int argc, const char **argv)
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
@@ -6060,7 +6178,9 @@ int cmd_trace(int argc, const char **argv)
 	 * syscall.
 	 */
 	if (trace.syscalls.events.bpf_output) {
-		evlist__for_each_entry(trace.evlist, evsel) {
+		struct evsel *n;
+
+		evlist__for_each_entry_safe(trace.evlist, n, evsel) {
 			bool raw_syscalls_sys_exit = evsel__name_is(evsel, "raw_syscalls:sys_exit");
 
 			if (raw_syscalls_sys_exit) {
@@ -6068,28 +6188,44 @@ int cmd_trace(int argc, const char **argv)
 				goto init_augmented_syscall_tp;
 			}
 
-			if (trace.syscalls.events.bpf_output->priv == NULL &&
-			    strstr(evsel__name(evsel), "syscalls:sys_enter")) {
+			/*
+			 * Match the evsel trace__add_syscall_newtp() made by
+			 * identity rather than by name. It is called
+			 * raw_syscalls:sys_enter, or syscalls:sys_enter on
+			 * kernels too old to have the raw variant, and a
+			 * substring test for the latter also matches the
+			 * per syscall syscalls:sys_enter_SYSCALL tracepoints
+			 * a user can ask for by name. Claiming one of those
+			 * here would take the event the user asked for out of
+			 * the evlist below and describe __augmented_syscalls__
+			 * with the wrong tracefs format.
+			 */
+			if (evsel == trace.syscalls.events.sys_enter) {
 				struct evsel *augmented = trace.syscalls.events.bpf_output;
 				if (evsel__init_augmented_syscall_tp(augmented, evsel) ||
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
index ebb26225fb04..3a1f6e8b5d78 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -1,5 +1,6 @@
 #include <assert.h>
 #include <bpf/libbpf.h>
+#include <errno.h>
 #include <internal/xyarray.h>
 #include <string.h>
 
@@ -12,6 +13,23 @@
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
@@ -37,11 +55,35 @@ int augmented_syscalls__prepare(void)
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
@@ -100,6 +142,96 @@ int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids)
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
@@ -142,4 +274,5 @@ struct bpf_program *augmented_syscalls__find_by_title(const char *name)
 void augmented_syscalls__cleanup(void)
 {
 	augmented_raw_syscalls_bpf__destroy(skel);
+	skel = NULL;
 }
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
index a1cd9a5e0213..5702eda3b469 100644
--- a/tools/perf/util/trace_augment.h
+++ b/tools/perf/util/trace_augment.h
@@ -2,6 +2,7 @@
 #define TRACE_AUGMENT_H
 
 #include <linux/compiler.h>
+#include <stdbool.h>
 #include <sys/types.h>
 
 struct bpf_program;
@@ -13,6 +14,11 @@ int augmented_syscalls__prepare(void);
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
@@ -40,6 +46,34 @@ static inline int augmented_syscalls__set_filter_pids(unsigned int nr __maybe_un
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

