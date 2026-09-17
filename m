Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92E543E06B
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627381; cv=none; b=iUKJMsk5g2+G51KG8YJO2VGAG/X4a3syCzSUJ58EAThavQAJl0cU+B1j9pWlZXtTFRlvzXTl/ht9/9yrpZbJKmlf9l3z4psTFmqxdIkkLnnOR/C2i9Ml0lDS6xvyMGDal3MImlJLxIbWvSOJ5MDJbjh+i+V3gW1MSYrI3471G3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627381; c=relaxed/simple;
	bh=pCYthVdyoV3UBP/kkzGKJxv/qNQW2xgcg594NKZqa5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sSVGWLDYProDMkM7yJW/k1J+P/Wixo0kXv5MqMZP6iMxFxXvY4Yod75oBuZeYr3FvTDRhTII8zL/9xVmYm+hREqA7uY0jnaG9UPWIUccDzcgupX/PnaIQKfyALr1I+as0gIdPaGf4euKGUI2fw1UK2T1uJdhihFPIUm/f96y3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GN01iobb; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GN01iobb"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d63bad3d09so8508625ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627378; x=1790232178; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ejyoj3BGFDS1MG1F9xsynJcx/QiWcHBrmC+P3sRSEnQ=;
        b=GN01iobbRWYrBUnZycaD7KWbKv7F9hVD1TjNyzXPk3gul2rCmrM3mCB4FjcmXZbWck
         LISFBMtHlEQhxC7ALMYyKvhEhtQZfzcFBox63Dm8AmExMH3ZaXttEwzgxrD9SqPDryyL
         MCaYFm+3uNx1vXdknZvxosA3+tap4vbWuWczwQr9Arw3nKERegFYxRuT4xUZ2xKSEia+
         vYjrMGjJBd00HZChIGH7XKR6TolKvLVSwR5kSbzH1eaJhbk3NwpLOxSsWWGIjTTIUe+g
         tkE29FlGxInmml5GoKnZ+vlqLgAIlK3ZChhhuaexlnB9vdeYqVdlT5sTAwfcrOD7cYJf
         KNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627378; x=1790232178;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ejyoj3BGFDS1MG1F9xsynJcx/QiWcHBrmC+P3sRSEnQ=;
        b=KYKl4gt1Bj1dkOJWXswrYzAsknxU3W3y11MWz0cP+30LXrjCfnvKReD4XzGtAJY9I2
         sQopWcRblQGVT2bpLWQnVY1imFRWFCPew6gLS1PIkeJL7o29tjBNegiKWBAkU7B2/Ldw
         aie4YjQAHz4SeAX/GgA3lTUsbFQfxFCeLq9/9AfHZBRo3EppuEfHq5kkfsG79wcr2ihc
         tbOxvOYMZ6zHVukxHm02PcqJHS1zSipmNEYCNRCIZd35Zhq4WpfP4vktou7jZ6HdI4QM
         tEvSD0udxJXywX9shrRBZgAX4kyGZRN4qxyUxtiGrQPNxv2SZHPG3EcZXbU7yN1EjAEA
         XZqg==
X-Forwarded-Encrypted: i=1; AKwUvBzDvsJlfnG1ohtMWkhaFcMCIC+quUdOBAb+pcM7mJfP0Zbhsiz29gZOqiVzOeI9bO2mBEm58GNG+cgEyM7qGyQv@vger.kernel.org
X-Gm-Message-State: AFuF++kVjASgshi0MlWCMzPFPsVufmTK14T3jdlwW8U5nvXTDkdPSCot
	x7ARx9pVGMyC+5/O+TP+/1+4c5T/7Xglt3h2l5NpqyA7QtKRprl00AyrMysjDPNY5Q04ZyYbMnF
	VI6GRyWzx3Q==
X-Received: from dldnz11.prod.google.com ([2002:a05:701a:ca0b:b0:143:8cae:a783])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:10c1:b0:39e:1ec9:dc8d
 with SMTP id 98e67ed59e1d1-39e1ec9e479mr8502759a91.24.1789627377782; Wed, 16
 Sep 2026 23:42:57 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:27 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <301baf74713ea1b7ea6bce83d83edd8820b6f1d6.1789626978.git.irogers@google.com>
Subject: [PATCH v1 05/13] perf trace: Handle fork and exit directly in BPF
 filter maps
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
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
   When inherit is enabled and the parent's PID or TGID is in
   pids_to_trace or pids_filtered, insert child->pid into the
   corresponding map immediately. Because child->pid is task_struct.pid
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
   no-op here.
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
   pids_filtered.
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
the userspace handling did not cover it either. What it costs is small:
a child forked in the window is still traced through the tracepoints its
parent's events were inherited by, only unaugmented, because sys_enter
returns 1 for a pid that is not in the map rather than vetoing the
tracepoint. A workload started by 'perf trace -- cmd' cannot hit it at
all, as evlist__prepare_workload() leaves the child blocked on a pipe
until evlist__start_workload(), well after the attach.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                    |  39 ++--
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 178 +++++++++++++++++-
 tools/perf/util/bpf_trace_augment.c           | 116 +++++++-----
 tools/perf/util/trace_augment.h               |  28 +--
 4 files changed, 262 insertions(+), 99 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e21b2b4a8794..a30fe273f452 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2055,23 +2055,6 @@ static int trace__process_event(struct trace *trace, struct machine *machine,
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
@@ -4982,6 +4965,16 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		}
 	}
 
+	/*
+	 * Everything the BPF programs filter on is now in their maps, so it is
+	 * safe to let them run. They are attached system wide, so anything
+	 * before this point would have been filtered against a map that was
+	 * still being built up.
+	 */
+	err = augmented_syscalls__attach();
+	if (err < 0)
+		goto out_errno;
+
 	/*
 	 * If the "close" syscall is not traced, then we will not have the
 	 * opportunity to, in syscall_arg__scnprintf_close_fd() invalidate the
@@ -6074,7 +6067,7 @@ int cmd_trace(int argc, const char **argv)
 			goto skip_augmentation;
 	}
 
-	err = augmented_syscalls__prepare();
+	err = augmented_syscalls__prepare(!trace.opts.no_inherit);
 	if (err < 0)
 		goto skip_augmentation;
 
@@ -6085,11 +6078,11 @@ int cmd_trace(int argc, const char **argv)
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
index 6ca9507ecc02..7124ed3c39c8 100644
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
@@ -721,4 +760,123 @@ int sys_exit(struct syscall_exit_args *args)
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
+	pid_t parent_tgid, parent_pid, child_pid;
+	bool val = true;
+
+	if (!inherit)
+		return 0;
+
+	/*
+	 * The parent's own pid and tgid: the thread that called clone() may
+	 * itself only be tracked by the pid of its thread group leader.
+	 */
+	parent_pid = parent->pid;
+	parent_tgid = parent->tgid;
+	child_pid = child->pid;
+
+	if (has_pids_to_trace &&
+	    (bpf_map_lookup_elem(&pids_to_trace, &parent_pid) != NULL ||
+	     bpf_map_lookup_elem(&pids_to_trace, &parent_tgid) != NULL))
+		bpf_map_update_elem(&pids_to_trace, &child_pid, &val, BPF_ANY);
+
+	if (has_pids_filtered &&
+	    (bpf_map_lookup_elem(&pids_filtered, &parent_pid) != NULL ||
+	     bpf_map_lookup_elem(&pids_filtered, &parent_tgid) != NULL))
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
+	if (bpf_map_lookup_elem(&pids_to_trace, &old_pid) != NULL) {
+		bpf_map_update_elem(&pids_to_trace, &pid, &val, BPF_ANY);
+		bpf_map_delete_elem(&pids_to_trace, &old_pid);
+	}
+
+	if (bpf_map_lookup_elem(&pids_filtered, &old_pid) != NULL) {
+		bpf_map_update_elem(&pids_filtered, &pid, &val, BPF_ANY);
+		bpf_map_delete_elem(&pids_filtered, &old_pid);
+	}
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index b9d1208e50f2..41a867d60b37 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -28,7 +28,7 @@ static int attach_prog(struct bpf_link **link, struct bpf_program *prog, const c
 	return attach_err;
 }
 
-int augmented_syscalls__prepare(void)
+int augmented_syscalls__prepare(bool inherit)
 {
 	struct bpf_program *prog;
 	char buf[128];
@@ -40,12 +40,18 @@ int augmented_syscalls__prepare(void)
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
 
@@ -63,13 +69,42 @@ int augmented_syscalls__prepare(void)
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
@@ -81,6 +116,13 @@ int augmented_syscalls__prepare(void)
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
 
@@ -127,17 +169,29 @@ int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids)
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
@@ -160,45 +214,15 @@ int augmented_syscalls__set_target_pids(unsigned int nr, pid_t *pids)
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
index 56f4dbab7d4b..f9eecff7efad 100644
--- a/tools/perf/util/trace_augment.h
+++ b/tools/perf/util/trace_augment.h
@@ -8,14 +8,12 @@ struct evlist;
 
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
@@ -24,11 +22,16 @@ void augmented_syscalls__cleanup(void);
 
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
@@ -50,21 +53,6 @@ static inline int augmented_syscalls__set_target_pids(unsigned int nr __maybe_un
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

