Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A49388E49
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620010; cv=none; b=cojAGtht8K8k4TKL9aHWKgGecnBurqIOa1plxLLZMRSXjorkvvoEc5M3hYPJZVgHNm5VWhNIOoMhXA+t44P/Tw2hj5Les1vDU+fw+9taqoXE4TtpCJVl1lEBZ9VwGMXBhJdfZllIT7G1aH/vRLPp6tkDlOTtu5XMDu+yBtMrPxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620010; c=relaxed/simple;
	bh=lYZr/EA2hUmhDvjtNm2j9PZJYkJo8XB22TsOTzXZc94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EHMqfFxUBOuC7B8Q9dygMuAIuSpLcCd7e2FJ3Z9okS4k612oHnqUVhG5lpI1X7WvIoxd0b7RUA4EpJql/dY12binom3ThZfrlGXuNlvHUrYMDVuR2JNhWiL1h1tgng/AJc1C+KWkX3M5rp0JAqWcdZs3OVxf6NawRnpWjqIcX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aVcGP4ev; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVcGP4ev"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14318be7d79so3367981c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620007; x=1791224807; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aC6HcIxYCaALM/aeyHEKGMakkZuS/lIvvdcSprT8dV0=;
        b=aVcGP4evTcISuWB6ztz0DSmsRopMMwBF5QP1pZ8FOd7LrIhhA3LpHqhqwvkDwpg3ca
         IxFEFYOiluiKuRX6A0wC0KFC/5KGCjHGBctmxeYKXjWinH4gFXCWDrhS5dGWAk7l4PDu
         grZ7wwhTgv6N/31t/N1CQRxhzPIbpBDB9x7FGBk+8XZKAaBzYS/ogmpaVoOJmUUy+8Uv
         3UIoZlItxtkmUCorNTrgIEecexuQjf/fDCwzuxkNZiTc9Op5RdckPi6IistgHUWpyaUv
         MXlUds1v6yrw1X6PNkF3b8Onop7pcu4iQxM2/f1fTKtTBTELuDvkiEf3p2IoeEDV2mLJ
         NYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620007; x=1791224807;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aC6HcIxYCaALM/aeyHEKGMakkZuS/lIvvdcSprT8dV0=;
        b=GgLTaebNFsQEE5d9AUMT0/TILNmYTuUeLejaeoYZ/20q4Oli3kPU3fstrAFoywwlqs
         1BBad0VHfBTd8IGmk1hCpt8DRciGcgJVMrG0e4vWqHDE8AfFaNX7SqXZCUXtacjglMfs
         RPXVQkk4M2PcuH4CZqGuWNwdsXvQQfq5UD5T935P0tkJ1AJT1wCkcNUuflrce7gX35Ki
         8BNyN7H09u1MGcK4wtMosYT5Mdl2n0MLFS23ljJKTU0LHYHOnDdvwpboUZJvHzRVG1Ap
         LF1LwzSz1Sj5P+KK2uFX/uFKP8yuWt77C6RkTuEXqRwgaZwhB5IX7MNgNkbzm3WiBToD
         oCLQ==
X-Forwarded-Encrypted: i=1; AKwUvByegX6HW2l4NhP8mJhbz8LXqAa0FfAb26EYjJGfXwLAsx0hmVyQMHa+rsgT6RrbaUDKoFlkpTAMTSqdUw8OCkOe@vger.kernel.org
X-Gm-Message-State: AFuF++lEWYr80FNQcz1y7ptqykVCkAx/qhtSbTJHbSPkgfzF36e8SU6u
	NsZb2McXfacIB0XmXMX6l46a6fCRw+2ek7ysqae71t6mT4goZMBeLZYP1U2JhCjzHbLOnPcYGpz
	U64GJc2/D7g==
X-Received: from dlbpt2.prod.google.com ([2002:a05:7022:e802:b0:144:db95:4a56])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4514:20b0:143:8274:1697
 with SMTP id a92af1059eb24-146cfcd7051mr9953662c88.29.1790620006517; Mon, 28
 Sep 2026 11:26:46 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:54 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-16-irogers@google.com>
Subject: [PATCH v6 15/26] perf trace: Filter the target's tasks in BPF
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The augmented syscalls BPF programs are attached to raw_syscalls system
wide, so they run for every task. To make the bpf-output event system
wide, and so augment the target's children, they need to know which
tasks are the target's.

Add a pids_to_trace map, seeded from the target's thread map, that
sys_enter and sys_exit check, leaving other tasks' events alone. tp_btf
programs add children on fork when inheriting, remove exited tasks and
follow a thread that exec gives the leader's pid. Tasks that don't fit
in the map, including when seeding, are counted and reported as lost.
Other forks drop any entry for the child's pid, seeded for a task that
had exited, such as a zombie. A workload waits for its exec, like
enable_on_exec.

When inheriting, unless given threads with -t, key the map by tgid,
like off-cpu's task_filter, so a process's threads share its entry. New
threads are then traced with their process, which is forgotten when its
last thread exits, and exec keeps the key.

The sched programs attach when the skeleton loads and the map is seeded
before the events are opened, so the forks and exits that follow are
seen. sys_enter and sys_exit now attach once the maps are populated,
rather than at load where the empty prog arrays made them veto every
raw_syscalls event.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                    |  36 ++++++-
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 100 ++++++++++++++++++
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   9 ++
 tools/perf/util/bpf_trace_augment.c           |  75 ++++++++++++-
 tools/perf/util/trace_augment.h               |  24 +++++
 5 files changed, 239 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 17e482ae02c9..81d660bc87b9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4488,6 +4488,22 @@ static int trace__set_filter_pids(struct trace *trace)
 	return err;
 }
 
+/* The BPF programs see every task, tell them which are the target's. */
+static void trace__set_target_pids(struct trace *trace)
+{
+	struct perf_thread_map *threads = evlist__core(trace->evlist)->threads;
+	struct target *target = &trace->opts.target;
+	bool inherit = !trace->opts.no_inherit;
+	/* Key by process when inheriting, unless given threads, noting -p also sets tid. */
+	bool uses_tgid = inherit && (target->pid || !target->tid);
+
+	if (perf_thread_map__pid(threads, 0) == -1)
+		return;
+
+	augmented_syscalls__set_target_pids(threads, inherit, uses_tgid,
+					    target__enable_on_exec(target));
+}
+
 static int __trace__deliver_event(struct trace *trace, union perf_event *event)
 {
 	struct evlist *evlist = trace->evlist;
@@ -4695,7 +4711,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 {
 	struct evlist *evlist = trace->evlist;
 	struct evsel *evsel, *pgfault_maj = NULL, *pgfault_min = NULL;
-	int err = -1, i;
+	int err = -1, i, lost_tasks;
 	unsigned long before;
 	const bool forks = argc > 0;
 	bool draining = false;
@@ -4798,6 +4814,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		workload_pid = evlist__workload_pid(evlist);
 	}
 
+	/* Seed before opening, so BPF follows new tasks as inherit would. */
+	trace__set_target_pids(trace);
+
 	err = evlist__open(evlist);
 	if (err < 0)
 		goto out_error_open;
@@ -4825,6 +4844,10 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		}
 	}
 
+	err = augmented_syscalls__attach();
+	if (err < 0)
+		goto out_error_bpf;
+
 	/*
 	 * If the "close" syscall is not traced, then we will not have the
 	 * opportunity to, in syscall_arg__scnprintf_close_fd() invalidate the
@@ -4941,6 +4964,12 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->sort_events)
 		ordered_events__flush(&trace->oe.data, OE_FLUSH__FINAL);
 
+	lost_tasks = augmented_syscalls__lost_tasks();
+	if (lost_tasks)
+		color_fprintf(trace->output, PERF_COLOR_RED,
+			      "LOST the syscalls of %d tasks, too many to trace at once!\n",
+			      lost_tasks);
+
 	if (!err) {
 		if (trace->summary) {
 			if (trace->summary_bpf)
@@ -4997,6 +5026,11 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		"Failed to set filter \"%s\" on event %s: %m\n",
 		evsel->filter, evsel__name(evsel));
 	goto out_put_evlist;
+
+out_error_bpf:
+	fprintf(trace->output, "Failed to set up the augmented syscalls BPF programs: %s\n",
+		str_error_r(-err, errbuf, sizeof(errbuf)));
+	goto out_put_evlist;
 }
 out_error_mem:
 	fprintf(trace->output, "Not enough memory to run!\n");
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 18835c7512ac..d9284a5c030d 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -9,6 +9,7 @@
 #include "vmlinux.h"
 
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 #include <linux/limits.h>
 
 #define PERF_ALIGN(x, a)        __PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
@@ -114,6 +115,22 @@ struct pids_filtered {
 	__uint(max_entries, 64);
 } pids_filtered SEC(".maps");
 
+/* With a target only its tasks are traced, those set false from their next exec. */
+struct pids_to_trace {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, pid_t);
+	__type(value, bool);
+	__uint(max_entries, 16384);
+} pids_to_trace SEC(".maps");
+
+bool has_pids_to_trace;
+/* Also trace the children of traced tasks. */
+bool inherit;
+/* Key pids_to_trace by tgid, so a process's threads share an entry. */
+bool uses_tgid;
+/* Tasks not traced as pids_to_trace was full. */
+int lost_tasks;
+
 struct augmented_args_payload {
 	struct syscall_enter_args args;
 	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
@@ -457,6 +474,19 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
+static bool task_traced(void)
+{
+	u64 pid_tgid = bpf_get_current_pid_tgid();
+	pid_t pid = uses_tgid ? pid_tgid >> 32 : (pid_t)pid_tgid;
+	bool *traced;
+
+	if (!has_pids_to_trace)
+		return true;
+
+	traced = bpf_map_lookup_elem(&pids_to_trace, &pid);
+	return traced && *traced;
+}
+
 u64 ZERO = 0;
 
 /*
@@ -608,6 +638,9 @@ int sys_enter(struct syscall_enter_args *args)
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
 
+	if (!task_traced())
+		return 1;
+
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
@@ -634,6 +667,9 @@ int sys_exit(struct syscall_exit_args *args)
 {
 	struct syscall_exit_args exit_args;
 
+	if (!task_traced())
+		return 1;
+
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
@@ -650,4 +686,68 @@ int sys_exit(struct syscall_exit_args *args)
 	return 0;
 }
 
+/* Trace the children of traced tasks, added before they can run. */
+SEC("tp_btf/sched_process_fork")
+int BPF_PROG(sched_process_fork, struct task_struct *parent, struct task_struct *child)
+{
+	pid_t parent_pid = parent->pid, child_pid = child->pid;
+	bool *traced = NULL, val;
+
+	if (uses_tgid) {
+		/* A new thread is traced with its process. */
+		if (child->tgid != child_pid)
+			return 0;
+		parent_pid = parent->tgid;
+	}
+	if (inherit)
+		traced = bpf_map_lookup_elem(&pids_to_trace, &parent_pid);
+	if (traced) {
+		val = *traced;
+		/* Not __sync_fetch_and_add(), as its fetch needs a 5.12 kernel. */
+		if (bpf_map_update_elem(&pids_to_trace, &child_pid, &val, BPF_ANY))
+			__atomic_fetch_add(&lost_tasks, 1, __ATOMIC_RELAXED);
+	} else {
+		/* A new pid, so any entry was seeded for an exited task, e.g. a zombie. */
+		bpf_map_delete_elem(&pids_to_trace, &child_pid);
+	}
+	return 0;
+}
+
+/* Forget exited tasks, as their pid may be reused. */
+SEC("tp_btf/sched_process_exit")
+int BPF_PROG(sched_process_exit, struct task_struct *task)
+{
+	pid_t pid = task->pid;
+
+	if (uses_tgid) {
+		/* A process exits with its last thread. */
+		if (task->signal->live.counter)
+			return 0;
+		pid = task->tgid;
+	}
+	bpf_map_delete_elem(&pids_to_trace, &pid);
+	return 0;
+}
+
+/* Start tracing waiting tasks, and follow a thread given the leader's pid by exec. */
+SEC("tp_btf/sched_process_exec")
+int BPF_PROG(sched_process_exec, struct task_struct *task, pid_t old_pid)
+{
+	pid_t pid = task->pid;
+	bool traced = true;
+
+	/* A process keeps its tgid, which pid now is. */
+	if (uses_tgid)
+		old_pid = pid;
+	if (!bpf_map_lookup_elem(&pids_to_trace, &old_pid))
+		return 0;
+
+	if (pid != old_pid)
+		bpf_map_delete_elem(&pids_to_trace, &old_pid);
+	/* A fork may have taken old_pid's entry, leaving the map full. */
+	if (bpf_map_update_elem(&pids_to_trace, &pid, &traced, BPF_ANY))
+		__atomic_fetch_add(&lost_tasks, 1, __ATOMIC_RELAXED);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index a59ce912be18..94e42b022ab1 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -47,6 +47,10 @@ enum {
 	NR_SOFTIRQS
 };
 
+typedef struct {
+	int	counter;
+} __attribute__((preserve_access_index)) atomic_t;
+
 typedef struct {
 	s64	counter;
 } __attribute__((preserve_access_index)) atomic64_t;
@@ -67,6 +71,10 @@ struct sighand_struct {
 	spinlock_t siglock;
 } __attribute__((preserve_access_index));
 
+struct signal_struct {
+	atomic_t live;
+} __attribute__((preserve_access_index));
+
 struct rw_semaphore {
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
@@ -103,6 +111,7 @@ struct task_struct {
 	pid_t		      pid;
 	pid_t		      tgid;
 	char		      comm[16];
+	struct signal_struct  *signal;
 	struct sighand_struct *sighand;
 	struct css_set	      *cgroups;
 } __attribute__((preserve_access_index));
diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index daa79a55c795..e590eb7a3d91 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -1,12 +1,15 @@
 #include <assert.h>
 #include <bpf/libbpf.h>
+#include <errno.h>
 #include <internal/xyarray.h>
+#include <perf/threadmap.h>
 #include <string.h>
 
 #include "bpf_skel/augmented_raw_syscalls.skel.h"
 #include "debug.h"
 #include "evlist.h"
 #include "parse-events.h"
+#include "thread_map.h"
 #include "trace_augment.h"
 
 static struct augmented_raw_syscalls_bpf *skel;
@@ -25,11 +28,13 @@ int augmented_syscalls__prepare(void)
 	}
 
 	/*
-	 * Disable attaching the BPF programs except for sys_enter and
-	 * sys_exit that tail call into this as necessary.
+	 * Attach just the programs maintaining pids_to_trace now. sys_enter and
+	 * sys_exit wait for augmented_syscalls__attach(), the rest are tail called.
 	 */
 	bpf_object__for_each_program(prog, skel->obj) {
-		if (prog != skel->progs.sys_enter && prog != skel->progs.sys_exit)
+		if (prog != skel->progs.sched_process_fork &&
+		    prog != skel->progs.sched_process_exit &&
+		    prog != skel->progs.sched_process_exec)
 			bpf_program__set_autoattach(prog, /*autoattach=*/false);
 	}
 
@@ -41,7 +46,30 @@ int augmented_syscalls__prepare(void)
 		return err;
 	}
 
-	augmented_raw_syscalls_bpf__attach(skel);
+	err = augmented_raw_syscalls_bpf__attach(skel);
+	if (err < 0) {
+		libbpf_strerror(err, buf, sizeof(buf));
+		pr_debug("Failed to attach augmented syscalls BPF skeleton: %s\n", buf);
+		augmented_syscalls__cleanup();
+		return err;
+	}
+	return 0;
+}
+
+/* Attach sys_enter and sys_exit, once the maps they use are populated. */
+int augmented_syscalls__attach(void)
+{
+	if (skel == NULL)
+		return 0;
+
+	skel->links.sys_enter = bpf_program__attach(skel->progs.sys_enter);
+	if (skel->links.sys_enter == NULL)
+		return -errno;
+
+	skel->links.sys_exit = bpf_program__attach(skel->progs.sys_exit);
+	if (skel->links.sys_exit == NULL)
+		return -errno;
+
 	return 0;
 }
 
@@ -100,6 +128,45 @@ int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids)
 	return err;
 }
 
+/* Trace just the target's tasks, or their processes, from their next exec if on_exec. */
+void augmented_syscalls__set_target_pids(struct perf_thread_map *threads, bool inherit,
+					 bool uses_tgid, bool on_exec)
+{
+	bool traced = !on_exec;
+	pid_t last = -1;
+
+	if (skel == NULL)
+		return;
+
+	skel->bss->uses_tgid = uses_tgid;
+	/* Before seeding, so the forks of tasks already added are followed. */
+	skel->bss->inherit = inherit;
+	for (int i = 0; i < perf_thread_map__nr(threads); i++) {
+		pid_t pid = perf_thread_map__pid(threads, i);
+
+		/* A process's threads are adjacent, add it once, skipping exited threads. */
+		if (uses_tgid) {
+			pid = thread_map__tgid(threads, i);
+			if (pid < 0 || pid == last)
+				continue;
+			last = pid;
+		}
+		/* Count a lost task atomically, as the BPF programs do too. */
+		if (bpf_map__update_elem(skel->maps.pids_to_trace, &pid, sizeof(pid),
+					 &traced, sizeof(traced), BPF_ANY))
+			__atomic_fetch_add(&skel->bss->lost_tasks, 1, __ATOMIC_RELAXED);
+	}
+	skel->bss->has_pids_to_trace = true;
+}
+
+int augmented_syscalls__lost_tasks(void)
+{
+	if (skel == NULL)
+		return 0;
+
+	return skel->bss->lost_tasks;
+}
+
 int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd)
 {
 	if (skel == NULL)
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
index 9c91e2569890..423f16221963 100644
--- a/tools/perf/util/trace_augment.h
+++ b/tools/perf/util/trace_augment.h
@@ -2,17 +2,23 @@
 #define TRACE_AUGMENT_H
 
 #include <linux/compiler.h>
+#include <stdbool.h>
 #include <sys/types.h>
 
 struct bpf_program;
 struct evlist;
+struct perf_thread_map;
 
 #ifdef HAVE_BPF_SKEL
 
 int augmented_syscalls__prepare(void);
+int augmented_syscalls__attach(void);
 int augmented_syscalls__create_bpf_output(struct evlist *evlist);
 void augmented_syscalls__setup_bpf_output(void);
 int augmented_syscalls__set_filter_pids(unsigned int nr, pid_t *pids);
+void augmented_syscalls__set_target_pids(struct perf_thread_map *threads, bool inherit,
+					 bool uses_tgid, bool on_exec);
+int augmented_syscalls__lost_tasks(void);
 int augmented_syscalls__get_map_fds(int *enter_fd, int *exit_fd, int *beauty_fd);
 struct bpf_program *augmented_syscalls__find_by_title(const char *name);
 struct bpf_program *augmented_syscalls__unaugmented_enter(void);
@@ -26,6 +32,11 @@ static inline int augmented_syscalls__prepare(void)
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
@@ -41,6 +52,19 @@ static inline int augmented_syscalls__set_filter_pids(unsigned int nr __maybe_un
 	return 0;
 }
 
+static inline void
+augmented_syscalls__set_target_pids(struct perf_thread_map *threads __maybe_unused,
+				    bool inherit __maybe_unused,
+				    bool uses_tgid __maybe_unused,
+				    bool on_exec __maybe_unused)
+{
+}
+
+static inline int augmented_syscalls__lost_tasks(void)
+{
+	return 0;
+}
+
 static inline int augmented_syscalls__get_map_fds(int *enter_fd __maybe_unused,
 						  int *exit_fd __maybe_unused,
 						  int *beauty_fd __maybe_unused)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

