Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF673AE1AD
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740449; cv=none; b=TUITcTdLslYCH4j2RhZMnVsHEDZAOmam4/N9u8hobcy+7KUP9XnXhJwxYafqEGxY8giWBhbNl5U/VwBiVCbvUSaK/WDfV/xlv9erOy8ay71T2aceSy5LL1+GE9WgQml4T/5lw9f60kDW315qvgzxAkDvy8Y+HfhmtRS0/N3a2qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740449; c=relaxed/simple;
	bh=ABJTZ9kbf0neppFKbV0rghwQD+kL3LHCZ0idZdJ0nGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kN17FKMvj9VF/v5THYyaelsOBchD5WRYD5FV7Vt+8FnuZZZRKNDWtdA5pmfZPZdZHCA/H9t9r2yWBctWFepq+GtMg8nyM1fb6qx9INxGTj3ca2kCh8ufzhTvJfgMYseKSkoXpWzcDx8NwQY3iDP0McYSBTlUmGRiZsreNY+S1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvJZgjBF; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvJZgjBF"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso1029651a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740444; x=1790345244; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kjg0VGvP8GLgt/ndu7WrqZ8qBjfLoAUX7+gvFPB6aA=;
        b=GvJZgjBF9BcvaIVd35xPy//FWU2MxKGq/TFrBh9I1uqZ0SxOLdiNs62Lo5QVzVOVyK
         tdLpvWj1Oa0/32MbrWk6bvSbd+VL9ltc3A5K2IYvXfb6RU2E5kWLIgoMoP/PcHjNj1SI
         VHuhypHepHqlUOJmSbq9tKVXkZqjy6oHhxtxYo/+gSRKh0FQayFoH8A1b67l17/OlsxM
         rTKIb1WgXRV70lWxz7aU5Lkaa+EKRdNwQu8HB3c6LIPm1M44+cFgqTfF/EqLiwUuoYqg
         8xPGp9YmdfqUoZtq4LBSQd5DdZ+jlN/VTkloZnhdsUUNIUlEUot3C7urh1yq5pGsWbQe
         6rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740444; x=1790345244;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4kjg0VGvP8GLgt/ndu7WrqZ8qBjfLoAUX7+gvFPB6aA=;
        b=puxs0j5WKMRxS/ppVlNs6dxqd+h8zrT0H+FLfdWAFxgSczl7oiXVM0HwxadYZbRbo0
         57UR95a8z3BWY8UqVZtVtLIDiCTgEkZZ5Kr+SPPnBC5AJeP0jhbX/QZaCxPgyeEmy7xV
         px5d3HPDJtDXJziDusCA8X8Zo2VKUcTZe/qAqedP4htJeY5PS70sci3EVj3Mt+rO9oIm
         82dh2gVtPxrtPgrY/N4lNdJytoIFgxj9+Mvh5ysk6z71A8wc/yI2g2z3Cj7JutFxB+rA
         RU5/5Rard0czgKUJUqQqbsYzhg/UKmrLqWFqNk3kU/uA/i7cXY6/DD0dfc0r+fjsaiS7
         hN8A==
X-Forwarded-Encrypted: i=1; AKwUvBzVLCD3g2lDUnzVp2Yip/70DY3UEtxwa8q/hQu9Tyiumhx8wh5YTR5KYblQPVSHQuJ3QaXgXpJrW3gKbNGglsnx@vger.kernel.org
X-Gm-Message-State: AFuF++lRiVQNRnJ9qxrdebDaGV5ivBaXeVr0CQwZSk9JF9OA9e26lEd5
	1qXqCwthtpEZh/6GsJ2Jp7kT6G89czIugSj+bGW435+lzUfjdr/R0myl0RqYI77wHYs8oCjJOtN
	VIi0gy/40eQ==
X-Received: from dybtk5.prod.google.com ([2002:a05:7300:d945:b0:33c:2cf5:c43e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cb:b0:38e:57a3:f218
 with SMTP id 98e67ed59e1d1-39e54d13343mr6142813a91.13.1789740443435; Fri, 18
 Sep 2026 07:07:23 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:50 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-8-irogers@google.com>
Subject: [PATCH v3 07/16] perf trace: Handle fork and exit directly in BPF
 filter maps
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Updating target or filtered PIDs in userspace upon processing
PERF_RECORD_FORK and PERF_RECORD_EXIT events introduces latency between
event occurrence and userspace BPF map updates. If a newly forked child
executes system calls before userspace processes PERF_RECORD_FORK, those
syscalls may be dropped by BPF PID filtering. Conversely, if userspace
evicts PIDs asynchronously on PERF_RECORD_EXIT, the kernel may recycle a
PID before userspace processes the exit event, causing the late eviction
to silently drop a newly created task that received the recycled PID.

Address this by attaching BTF-typed raw tracepoint BPF programs directly
to the scheduler task lifetime tracepoints:

1. Attach SEC("tp_btf/sched_process_fork") (sched_process_fork), which
   runs in copy_process() in the parent's context before
   wake_up_new_task() wakes the child. Using tp_btf rather than
   SEC("tp/sched/sched_process_fork") receives the stable TP_PROTO
   arguments (struct task_struct *parent, struct task_struct *child)
   rather than the tracepoint ring-buffer record (TP_STRUCT__entry),
   whose layout changed in Linux 6.16 when parent_comm and child_comm
   were converted from 16-byte arrays to 4-byte __data_loc strings.
   When inherit is enabled and the pid of the thread that called
   clone() is in pids_to_trace or pids_filtered, insert child->pid into
   the corresponding map immediately. Because child->pid is task_struct.pid
   (the global initial-namespace PID), this works accurately across PID
   namespaces without aliasing host PIDs, and covers both new processes
   and CLONE_THREAD threads without needing real_parent CO-RE walks or
   syscall-return heuristics.
2. Attach SEC("tp_btf/sched_process_exit") (sched_process_exit), which
   runs in do_exit() for every task in its own context, including tasks
   killed by signals (SIGKILL, SIGSEGV, etc.) and secondary threads torn
   down implicitly by exit_group. Delete the dying task's PID from
   pids_to_trace and pids_filtered immediately in kernel space,
   eliminating both map leaks and any asynchronous userspace eviction
   window where PID recycling could occur.
3. Attach SEC("tp_btf/sched_process_exec") (sched_process_exec) to
   follow the one case where a live task's pid changes underneath the
   maps. When a thread that is not the group leader execs, de_thread()
   kills the leader and hands the leader's pid, which is the tgid, to
   the exec'ing thread. The leader dies first, so sched_process_exit()
   has already dropped exactly the pid the survivor now holds, and the
   survivor's old entry would be stranded in the map for good. Move the
   entry from old_pid to p->pid. old_pid is sampled in bprm_execve()
   before de_thread() runs, so the ordinary group leader exec is a
   no-op here. Drop the old key before inserting the new one:
   the move is only a rename, but holding both keys at once needs a
   spare slot, and on a full map the insert would fail with -E2BIG
   while the delete still succeeded, losing the task instead of
   moving it.
4. With every live task registered before its first syscall and evicted
   in do_exit(), simplify pid_to_trace__has() and pid_filter__has() to
   single BPF hash map lookups, and move bpf_probe_read_kernel() in
   sys_exit back after the PID filter checks.
5. Pass the inherit flag from userspace to BPF .rodata via
   augmented_syscalls__prepare(!trace.opts.no_inherit), and split
   attaching out of it into augmented_syscalls__attach(), called from
   trace__run() once the pid, syscall and program array maps have all
   been programmed. These are system wide programs, so from the instant
   they attach they alone decide what is traced: attaching at load time,
   as before, left a window in which a target could fork without
   sched_process_fork() knowing the parent was a target, and with the
   userspace fork handling gone there was nothing left to recover it.
   The scheduler programs are attached ahead of sys_enter and sys_exit
   for the same reason. Set has_pids_filtered only after populating
   pids_filtered. A failure to attach ends the session, reporting the
   error that caused it. There is no falling back to unaugmented
   tracing by that point: cmd_trace() built the evlist around
   __augmented_syscalls__ and dropped the sys_enter evsel, so a session
   that carried on would report nothing at all. Neither did the code
   this replaces, which ignored the result of
   augmented_raw_syscalls_bpf__attach() altogether and ran on with
   programs that had never been attached.
6. Remove the userspace BPF map updates from PERF_RECORD_FORK and
   PERF_RECORD_EXIT in trace__process_event(), and delete the now-unused
   augmented_syscalls__{add,del,has}_target_pid() helpers. No coverage
   is lost with them: those records only come into being once the ring
   buffers are mapped by evlist__do_mmap() and the events are switched
   on by evlist__enable(), both of which run after
   augmented_syscalls__attach() in trace__run(), and they are then acted
   on later still, whenever the poll loop gets round to them. The
   scheduler programs therefore go live strictly earlier than the
   userspace path could ever have reacted.
7. Gate pid_filter__has() on a has_pids_filtered flag in .bss so the
   common case without --filter-pids performs no map lookups, and size
   pids_to_trace and pids_filtered at 16384 entries. pids_filtered is
   grown from 64 because it is no longer just the handful of pids
   userspace names: sched_process_fork() adds every descendant of those,
   so a --filter-pids target that forks or is heavily threaded needs the
   same headroom as a traced one.

A fork or exit is still not seen if it happens before the programs are
attached, that is between evlist__create_maps() scanning /proc for a -p
target and augmented_syscalls__attach(). Such a window is inherent in
programming a system wide filter before switching it on, and as above
the userspace handling did not cover it either. The cost is not small
though. Once the bpf-output event exists cmd_trace() removes the
sys_enter evsel from the evlist, so __augmented_syscalls__ is the only
source of enter events and a pid that is missing from pids_to_trace is
not reported at all. sys_enter returning 1 keeps the kernel tracepoint
alive for other subscribers, it does not give perf trace a second path
to the event. A target that forks during perf trace's own startup can
therefore have that child, and in turn everything the child forks, go
untraced for the whole run.

The tgid fallback that pid_to_trace__has() used to have would have
masked part of this, since a thread missed in the window still shares
the tgid of a target userspace did insert. It is not kept because it
would also re-admit tasks that sched_process_fork() deliberately
skipped: under --no-inherit a new thread of the target is not added to
the map, yet it shares the target's tgid and a tgid test cannot tell it
apart from one that was.

sched_process_fork() does not consult the parent's tgid either, for the
same reason. Every thread of a -p target is enumerated from
/proc/<pid>/task and inserted under its own pid, and -t names a single
thread, so a tgid test adds no reach. What it would add is a child
inheriting from a thread that is not traced itself: a sibling of the
thread -t selected, or one missed in the attach window whose own
syscalls go unreported. Inheritance keys off the pid of the thread that
called clone(), exactly as the lookups do.

Two of the three ways of selecting what to trace are unaffected:
'perf trace -- cmd' cannot hit this because evlist__prepare_workload()
leaves the child blocked on a pipe until evlist__start_workload(), well
after the attach, and 'perf trace -a' never sets has_pids_to_trace so
it does not filter at all. It is 'perf trace -p' against an already
running target that is exposed. Closing that too needs the descendants
of the target re-enumerated from /proc after the attach, which the next
change does.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                    |  55 +++--
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 199 +++++++++++++++++-
 tools/perf/util/bpf_trace_augment.c           | 116 ++++++----
 tools/perf/util/trace_augment.h               |  28 +--
 4 files changed, 299 insertions(+), 99 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e3c3f301e0b1..914e6e4b34f8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2061,23 +2061,6 @@ static int trace__process_event(struct trace *trace, struct machine *machine,
 			      "LOST %" PRIu64 " events!\n", (u64)event->lost.lost);
 		ret = machine__process_lost_event(machine, event, sample);
 		break;
-	case PERF_RECORD_FORK:
-		if (trace->raw_augmented_syscalls &&
-		    (augmented_syscalls__has_target_pid(event->fork.ppid) ||
-		     augmented_syscalls__has_target_pid(event->fork.ptid))) {
-			augmented_syscalls__add_target_pid(event->fork.pid);
-		}
-		ret = machine__process_fork_event(machine, event, sample);
-		break;
-	case PERF_RECORD_EXIT:
-		if (trace->raw_augmented_syscalls) {
-			if (event->fork.pid == event->fork.tid)
-				augmented_syscalls__del_target_pid(event->fork.pid);
-			else
-				augmented_syscalls__del_target_pid(event->fork.tid);
-		}
-		ret = machine__process_exit_event(machine, event, sample);
-		break;
 	default:
 		ret = machine__process_event(machine, event, sample);
 		break;
@@ -4993,6 +4976,22 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		}
 	}
 
+	/*
+	 * Everything the BPF programs filter on is now in their maps, so it is
+	 * safe to let them run. They are attached system wide, so anything
+	 * before this point would have been filtered against a map that was
+	 * still being built up.
+	 *
+	 * Falling back to unaugmented tracing is no longer possible here: the
+	 * evlist was built around __augmented_syscalls__ back in cmd_trace(),
+	 * which is where that decision is taken and where the sys_enter evsel
+	 * was dropped. Fail the session rather than run one that can report
+	 * nothing.
+	 */
+	err = augmented_syscalls__attach();
+	if (err < 0)
+		goto out_error_attach;
+
 	/*
 	 * If the "close" syscall is not traced, then we will not have the
 	 * opportunity to, in syscall_arg__scnprintf_close_fd() invalidate the
@@ -5187,6 +5186,16 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	fprintf(trace->output, "Failed to set the syscall filters: %s\n",
 		str_error_r(-err, errbuf, sizeof(errbuf)));
 	goto out_put_evlist;
+
+out_error_attach:
+	/*
+	 * Use the returned error rather than errno: the failing attach is
+	 * unwound before returning, and the libbpf calls that does can leave
+	 * errno describing something else entirely.
+	 */
+	fprintf(trace->output, "Failed to attach the augmented syscalls BPF programs: %s\n",
+		str_error_r(-err, errbuf, sizeof(errbuf)));
+	goto out_put_evlist;
 }
 out_error_mem:
 	fprintf(trace->output, "Not enough memory to run!\n");
@@ -6103,7 +6112,7 @@ int cmd_trace(int argc, const char **argv)
 			goto skip_augmentation;
 	}
 
-	err = augmented_syscalls__prepare();
+	err = augmented_syscalls__prepare(!trace.opts.no_inherit);
 	if (err < 0)
 		goto skip_augmentation;
 
@@ -6114,11 +6123,11 @@ int cmd_trace(int argc, const char **argv)
 		trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
 	} else {
 		/*
-		 * augmented_syscalls__prepare() already attached sys_enter and
-		 * sys_exit, which are system wide. Falling through to
-		 * skip_augmentation without undoing that would run a BPF
-		 * program for every syscall on the machine, for the whole
-		 * session, with nothing consuming the output.
+		 * Drop the loaded skeleton before falling back to unaugmented
+		 * tracing. Otherwise the setters called from trace__run() would
+		 * still program its maps, and augmented_syscalls__attach() would
+		 * then put system wide BPF programs on raw_syscalls for a
+		 * session with nothing consuming their output.
 		 */
 		pr_debug("Failed to create the augmented syscalls bpf-output event, disabling augmentation\n");
 		augmented_syscalls__cleanup();
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 6ca9507ecc02..af04c4b3f445 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -9,6 +9,7 @@
 #include "vmlinux.h"
 
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include <linux/limits.h>
 
 #define PERF_ALIGN(x, a)        __PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
@@ -107,25 +108,48 @@ struct augmented_arg {
 	};
 };
 
+/*
+ * Hash map of PIDs/TGIDs whose events must be discarded, e.g. perf trace's own
+ * pid, so that tracing doesn't feed back on itself.
+ *
+ * has_pids_filtered: set to true only when the map is populated. Checking a
+ *                    boolean is much cheaper than a map lookup, and sys_enter
+ *                    runs for every syscall on the system, so the common
+ *                    "no pids filtered" case must stay on a fast path.
+ *
+ * max_entries matches pids_to_trace: userspace only ever names a handful of
+ * pids here, but sched_process_fork() below adds every descendant of those,
+ * so a --filter-pids target that forks or is heavily threaded needs the same
+ * headroom as a traced one.
+ */
 struct pids_filtered {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, pid_t);
 	__type(value, bool);
-	__uint(max_entries, 64);
+	__uint(max_entries, 16384);
 } pids_filtered SEC(".maps");
 
+bool has_pids_filtered;
+
 /*
  * Optional hash map containing specific PIDs/TGIDs to trace (e.g., when
  * attached to a process with -p or tracing a specific command workload).
  *
  * has_pids_to_trace: Set to true if target PID filtering is active.
  *                    When false, all processes are eligible for tracing.
+ *
+ * max_entries bounds how many tasks can be tracked at once. sched_process_exit
+ * below evicts a task as it dies, whatever it died of, so the map holds live
+ * tasks rather than growing without bound. It is sized well
+ * above the thread count of realistic traced workloads; should a workload
+ * still exceed it, bpf_map_update_elem() fails with -E2BIG and the extra
+ * tasks are simply not traced rather than anything being corrupted.
  */
 struct pids_to_trace {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, pid_t);
 	__type(value, bool);
-	__uint(max_entries, 1024);
+	__uint(max_entries, 16384);
 } pids_to_trace SEC(".maps");
 
 bool has_pids_to_trace;
@@ -149,6 +173,9 @@ struct syscalls_to_trace {
 bool has_syscalls_to_trace;
 bool not_syscalls_to_trace;
 
+/* Inherit tracing for child tasks (set to false if --no-inherit is specified) */
+const volatile bool inherit = true;
+
 struct augmented_args_payload {
 	struct syscall_enter_args args;
 	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
@@ -471,24 +498,35 @@ static pid_t getpid(void)
 }
 
 /*
- * Returns true if a PID is explicitly excluded/filtered out (e.g., via --filter-pids).
+ * Checks if a PID is explicitly excluded/filtered out (e.g., via --filter-pids).
+ *
+ * Children of a filtered task are added to the map by sched_process_fork()
+ * below, so a plain lookup is all that is needed here.
  */
 static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 {
+	/*
+	 * Fast path: this runs for every syscall on the system, so when no pid
+	 * is filtered do no work at all rather than failing a lookup.
+	 */
+	if (!has_pids_filtered)
+		return false;
+
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
 /*
- * Checks if the current task (thread PID or process TGID) is targeted for tracing.
- * Checks both PID (thread ID) and TGID (process ID) so that all threads of a
- * target process match.
+ * Checks if the current task is targeted for tracing.
+ *
+ * Every thread that existed when tracing started was named by the target and
+ * inserted from userspace, and every task created since was inserted by
+ * sched_process_fork() below, before it was able to run. So there is nothing
+ * to derive here, and in particular no need to consult the tgid or walk to the
+ * parent: a task is traced if and only if it is in the map.
  */
 static inline bool pid_to_trace__has(pid_t pid)
 {
-	pid_t tgid = bpf_get_current_pid_tgid() >> 32;
-
-	return bpf_map_lookup_elem(&pids_to_trace, &pid) != NULL ||
-	       bpf_map_lookup_elem(&pids_to_trace, &tgid) != NULL;
+	return bpf_map_lookup_elem(&pids_to_trace, &pid) != NULL;
 }
 
 /*
@@ -706,6 +744,7 @@ int sys_exit(struct syscall_exit_args *args)
 		return 1;
 
 	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
+
 	/*
 	 * Jump to syscall specific return augmenter, even if the default one,
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
@@ -721,4 +760,144 @@ int sys_exit(struct syscall_exit_args *args)
 	return 1;
 }
 
+/*
+ * Propagate tracing to a newly created task.
+ *
+ * tp_btf/sched_process_fork is raised by copy_process(), in the parent's
+ * context and before the child is woken, so the child is in the maps before it
+ * can issue its first syscall. That removes the need to inspect real_parent
+ * when a syscall is seen from an unknown task, which could neither tell a
+ * genuine descendant from a task merely reparented to a traced init, nor keep
+ * following a descendant whose parent had already exited.
+ *
+ * Using tp_btf rather than tp/sched/sched_process_fork avoids depending on the
+ * tracepoint ring-buffer record layout (TP_STRUCT__entry), which changed in
+ * Linux 6.16 when parent_comm and child_comm were converted from fixed 16-byte
+ * arrays to 4-byte __data_loc strings (shrinking the tracepoint context from
+ * 48 to 24 bytes and causing BPF_PROG_TYPE_TRACEPOINT attachment to fail with
+ * -EACCES when accessing higher offsets). Instead, tp_btf receives the stable
+ * TP_PROTO arguments (struct task_struct *parent, struct task_struct *child)
+ * directly.
+ *
+ * child->pid is task_struct.pid, i.e. the pid in the initial namespace, which
+ * is what the maps are keyed by. A clone() return value, in contrast, is the
+ * pid in the caller's namespace and would alias an unrelated host task when a
+ * containerised workload is traced.
+ *
+ * CLONE_THREAD needs no special handling: a new thread arrives here like any
+ * other task and is inserted under its own pid.
+ */
+SEC("tp_btf/sched_process_fork")
+int BPF_PROG(sched_process_fork, struct task_struct *parent, struct task_struct *child)
+{
+	pid_t parent_pid, child_pid;
+	bool val = true;
+
+	if (!inherit)
+		return 0;
+
+	/*
+	 * Inherit from the thread that called clone() and from nothing else.
+	 * The maps name individual tasks: pid_to_trace__has() and
+	 * pid_filter__has() look up a task's own pid and nothing more, and
+	 * every thread of a -p target is enumerated from /proc/<pid>/task and
+	 * inserted in its own right, so a traced thread is always here under
+	 * its own key. Consulting the parent's tgid as well would let a child
+	 * inherit from a thread that is not itself traced, which is precisely
+	 * what 'perf trace -t <tid>' asked to leave out, and would re-admit
+	 * descendants of a thread that sched_process_fork() skipped or that
+	 * was missed while the programs were being attached, while still not
+	 * tracing that thread itself.
+	 */
+	parent_pid = parent->pid;
+	child_pid = child->pid;
+
+	if (has_pids_to_trace &&
+	    bpf_map_lookup_elem(&pids_to_trace, &parent_pid) != NULL)
+		bpf_map_update_elem(&pids_to_trace, &child_pid, &val, BPF_ANY);
+
+	if (has_pids_filtered &&
+	    bpf_map_lookup_elem(&pids_filtered, &parent_pid) != NULL)
+		bpf_map_update_elem(&pids_filtered, &child_pid, &val, BPF_ANY);
+
+	return 0;
+}
+
+/*
+ * Drop a dying task from the maps.
+ *
+ * tp_btf/sched_process_exit is raised by do_exit() for every task, in its own
+ * context, so unlike hooking the exit and exit_group syscalls this also covers
+ * tasks killed by a signal and threads torn down implicitly by exit_group.
+ *
+ * Doing it here rather than from the userspace PERF_RECORD_EXIT handler also
+ * means there is no window between the task dying and the map being updated,
+ * during which the kernel could recycle the pid and the late eviction silently
+ * stop tracing whichever new task received it.
+ *
+ * Each thread is reported separately, including the group leader, whose pid is
+ * the thread group's tgid, so one delete per map covers both uses of the key.
+ */
+SEC("tp_btf/sched_process_exit")
+int BPF_PROG(sched_process_exit, struct task_struct *p)
+{
+	pid_t pid = p->pid;
+
+	bpf_map_delete_elem(&pids_to_trace, &pid);
+	bpf_map_delete_elem(&pids_filtered, &pid);
+
+	return 0;
+}
+
+/*
+ * Follow a task whose pid changed under it.
+ *
+ * When a thread that is not the thread group leader execs, de_thread() kills
+ * the rest of the group and then hands the leader's pid, which is the tgid, to
+ * the exec'ing thread. The leader dies first, so sched_process_exit() above
+ * has already dropped that pid from the maps, and the survivor is now keyed by
+ * a pid nothing knows about while its original entry is left behind for good.
+ *
+ * Move the entry across so the task stays tracked and nothing is leaked.
+ * old_pid is sampled in bprm_execve() before de_thread() runs, so for the
+ * common case of the group leader exec'ing it simply equals p->pid and there
+ * is nothing to do.
+ */
+SEC("tp_btf/sched_process_exec")
+int BPF_PROG(sched_process_exec, struct task_struct *p, pid_t old_pid)
+{
+	pid_t pid = p->pid;
+	bool val = true;
+
+	if (pid == old_pid)
+		return 0;
+
+	/*
+	 * Drop the old key before adding the new one. The maps are bounded and
+	 * the move is only ever a rename, but inserting first needs a spare
+	 * slot for as long as both keys are present: on a full map that insert
+	 * fails with -E2BIG while the delete still succeeds, which would lose
+	 * the task rather than move it. Deleting first frees the slot the
+	 * insert goes on to use. The task is mid exec and issues no syscalls in
+	 * between, so the gap is not observable.
+	 *
+	 * There is no atomic rename for a hash map, so on a map that is exactly
+	 * full this narrows the window rather than closing it: a fork on
+	 * another CPU can still take the freed slot before the insert below
+	 * runs, and the task is then dropped just as any other task is once the
+	 * map is full.
+	 */
+	if (bpf_map_lookup_elem(&pids_to_trace, &old_pid) != NULL) {
+		bpf_map_delete_elem(&pids_to_trace, &old_pid);
+		bpf_map_update_elem(&pids_to_trace, &pid, &val, BPF_ANY);
+	}
+
+	if (bpf_map_lookup_elem(&pids_filtered, &old_pid) != NULL) {
+		bpf_map_delete_elem(&pids_filtered, &old_pid);
+		bpf_map_update_elem(&pids_filtered, &pid, &val, BPF_ANY);
+	}
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index 3a1f6e8b5d78..87c866d0365f 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -30,7 +30,7 @@ static int attach_prog(struct bpf_link **link, struct bpf_program *prog, const c
 	return attach_err;
 }
 
-int augmented_syscalls__prepare(void)
+int augmented_syscalls__prepare(bool inherit)
 {
 	struct bpf_program *prog;
 	char buf[128];
@@ -42,12 +42,18 @@ int augmented_syscalls__prepare(void)
 		return -errno;
 	}
 
+	skel->rodata->inherit = inherit;
+
 	/*
-	 * Disable attaching the BPF programs except for sys_enter and
-	 * sys_exit that tail call into this as necessary.
+	 * Disable attaching the BPF programs other than those attached
+	 * explicitly by augmented_syscalls__attach(), the rest are reached by
+	 * tail calls.
 	 */
 	bpf_object__for_each_program(prog, skel->obj) {
-		if (prog != skel->progs.sys_enter && prog != skel->progs.sys_exit)
+		if (prog != skel->progs.sys_enter && prog != skel->progs.sys_exit &&
+		    prog != skel->progs.sched_process_fork &&
+		    prog != skel->progs.sched_process_exit &&
+		    prog != skel->progs.sched_process_exec)
 			bpf_program__set_autoattach(prog, /*autoattach=*/false);
 	}
 
@@ -65,13 +71,42 @@ int augmented_syscalls__prepare(void)
 		return err;
 	}
 
+	return 0;
+}
+
+int augmented_syscalls__attach(void)
+{
+	int err;
+
+	if (skel == NULL)
+		return 0;
+
 	/*
-	 * Only sys_enter and sys_exit are attached, the remaining programs are
-	 * reached by tail calls. Attach them explicitly and, on failure, undo
-	 * any partial attachment: leaving sys_enter live on
-	 * raw_syscalls:sys_enter would keep running a BPF program for every
-	 * syscall on the system for a perf trace session that never starts.
+	 * Attaching is deliberately separate from, and a lot later than,
+	 * loading: these are system wide tracepoint programs, so from the
+	 * moment they are attached they are the only thing deciding which
+	 * tasks and syscalls are traced. Going live before the pid and
+	 * syscall maps are populated would mean a target that forked in the
+	 * meantime was never picked up by sched_process_fork() below.
+	 *
+	 * Attach explicitly, so that a failure part way through can undo what
+	 * came before it: leaving sys_enter live on raw_syscalls:sys_enter
+	 * would keep running a BPF program for every syscall on the system for
+	 * a perf trace session that never starts.
+	 *
+	 * The scheduler programs maintain the pid maps, and are attached first
+	 * so that no fork, exit or exec can be missed between sys_enter going
+	 * live and the maps being maintained.
 	 */
+	if (attach_prog(&skel->links.sched_process_fork, skel->progs.sched_process_fork,
+			"sched_process_fork"))
+		goto out_cleanup;
+	if (attach_prog(&skel->links.sched_process_exit, skel->progs.sched_process_exit,
+			"sched_process_exit"))
+		goto out_cleanup;
+	if (attach_prog(&skel->links.sched_process_exec, skel->progs.sched_process_exec,
+			"sched_process_exec"))
+		goto out_cleanup;
 	if (attach_prog(&skel->links.sys_enter, skel->progs.sys_enter, "sys_enter"))
 		goto out_cleanup;
 	if (attach_prog(&skel->links.sys_exit, skel->progs.sys_exit, "sys_exit"))
@@ -83,6 +118,13 @@ int augmented_syscalls__prepare(void)
 	err = attach_err;
 	/* Destroys every link attached above along with the skeleton. */
 	augmented_syscalls__cleanup();
+	/*
+	 * Tearing the skeleton down closes file descriptors and frees memory,
+	 * either of which may overwrite errno. Restore it so that a caller
+	 * reporting this with "%m" describes the attach failure rather than
+	 * whatever the teardown happened to do last.
+	 */
+	errno = -err;
 	return err;
 }
 
@@ -129,17 +171,29 @@ int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids)
 	bool value = true;
 	int err = 0;
 
-	if (skel == NULL)
+	if (skel == NULL || nr == 0)
 		return 0;
 
+	/*
+	 * Tell the BPF program that the pids_filtered map is in use. Without
+	 * this it would have to look up every task in an empty map, on every
+	 * syscall on the system, to find out that nothing is filtered.
+	 */
 	for (size_t i = 0; i < nr; ++i) {
 		err = bpf_map__update_elem(skel->maps.pids_filtered, &pids[i],
 					   sizeof(*pids), &value, sizeof(value),
 					   BPF_ANY);
 		if (err)
-			break;
+			return err;
 	}
-	return err;
+	/*
+	 * Publish the filter only now that the map is fully populated.
+	 * augmented_syscalls__attach() has not run yet, so nothing is reading
+	 * either of them, but keeping the flag and the map consistent means
+	 * the ordering stays correct however the callers are rearranged.
+	 */
+	skel->bss->has_pids_filtered = true;
+	return 0;
 }
 
 /*
@@ -162,45 +216,15 @@ int augmented_syscalls__set_target_pids(unsigned int nr, pid_t *pids)
 			return err;
 	}
 	/*
-	 * Set the flag only once every target is in the map. The BPF programs
-	 * are attached by this point, so flipping it first would have them
-	 * filter against a partially populated map and drop syscalls made by
-	 * the targets that had not been added yet.
+	 * Set the flag only once every target is in the map, so that the two
+	 * are never inconsistent. Publishing it first would, once the
+	 * programs are attached, have them filter against a partially
+	 * populated map and drop syscalls made by targets not yet added.
 	 */
 	skel->bss->has_pids_to_trace = true;
 	return 0;
 }
 
-int augmented_syscalls__add_target_pid(pid_t pid)
-{
-	bool value = true;
-
-	if (skel == NULL || !skel->bss->has_pids_to_trace || skel->maps.pids_to_trace == NULL)
-		return 0;
-
-	return bpf_map__update_elem(skel->maps.pids_to_trace, &pid, sizeof(pid),
-				    &value, sizeof(value), BPF_ANY);
-}
-
-int augmented_syscalls__del_target_pid(pid_t pid)
-{
-	if (skel == NULL || !skel->bss->has_pids_to_trace || skel->maps.pids_to_trace == NULL)
-		return 0;
-
-	return bpf_map__delete_elem(skel->maps.pids_to_trace, &pid, sizeof(pid), 0);
-}
-
-bool augmented_syscalls__has_target_pid(pid_t pid)
-{
-	bool value;
-
-	if (skel == NULL || !skel->bss->has_pids_to_trace || skel->maps.pids_to_trace == NULL)
-		return false;
-
-	return bpf_map__lookup_elem(skel->maps.pids_to_trace, &pid, sizeof(pid),
-				    &value, sizeof(value), 0) == 0;
-}
-
 /*
  * Populate syscalls in the BPF syscalls_to_trace map:
  * - not_syscalls: true if '!' prefix was specified (blacklist mode: trace
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
index 5702eda3b469..ad992f5fa726 100644
--- a/tools/perf/util/trace_augment.h
+++ b/tools/perf/util/trace_augment.h
@@ -10,14 +10,12 @@ struct evlist;
 
 #ifdef HAVE_BPF_SKEL
 
-int augmented_syscalls__prepare(void);
+int augmented_syscalls__prepare(bool inherit);
+int augmented_syscalls__attach(void);
 int augmented_syscalls__create_bpf_output(struct evlist *evlist);
 void augmented_syscalls__setup_bpf_output(void);
 int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids);
 int augmented_syscalls__set_target_pids(unsigned int nr, pid_t *pids);
-int augmented_syscalls__add_target_pid(pid_t pid);
-int augmented_syscalls__del_target_pid(pid_t pid);
-bool augmented_syscalls__has_target_pid(pid_t pid);
 int augmented_syscalls__set_target_syscalls(unsigned int nr, int *syscall_ids, bool not_syscalls);
 int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd);
 struct bpf_program *augmented_syscalls__find_by_title(const char *name);
@@ -26,11 +24,16 @@ void augmented_syscalls__cleanup(void);
 
 #else /* !HAVE_BPF_SKEL */
 
-static inline int augmented_syscalls__prepare(void)
+static inline int augmented_syscalls__prepare(bool inherit __maybe_unused)
 {
 	return -1;
 }
 
+static inline int augmented_syscalls__attach(void)
+{
+	return 0;
+}
+
 static inline int augmented_syscalls__create_bpf_output(struct evlist *evlist __maybe_unused)
 {
 	return -1;
@@ -52,21 +55,6 @@ static inline int augmented_syscalls__set_target_pids(unsigned int nr __maybe_un
 	return 0;
 }
 
-static inline int augmented_syscalls__add_target_pid(pid_t pid __maybe_unused)
-{
-	return 0;
-}
-
-static inline int augmented_syscalls__del_target_pid(pid_t pid __maybe_unused)
-{
-	return 0;
-}
-
-static inline bool augmented_syscalls__has_target_pid(pid_t pid __maybe_unused)
-{
-	return false;
-}
-
 static inline int augmented_syscalls__set_target_syscalls(unsigned int nr __maybe_unused,
 							  int *syscall_ids __maybe_unused,
 							  bool not_syscalls __maybe_unused)
-- 
2.55.0.1082.g2b9226bbc0-goog

