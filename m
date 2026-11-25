Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642138;
	b=xWo+gTD0lQ3itCqi5ilXm7byyQGm9/EG7lY1Z28d94elKsSB0oy/SYPcnOJCDa955KCZ
	 0oFGCD2Gsm7zjhyh8vPFCoDhNFH4nJ/AAcZtU4BAVUcxSxCk4Ju5yNo/2cUataEQASITn
	 LT9qg73eKpuB2RtKk3k2a15cXAwBX20LDiCZGb9ZNb++fR65bf9nNfShVWfARD6tBxIUM
	 haSFmT0th/ecRvEeTU2wNYg5I6kfF5MGkC5C/dZ4visZ9Udg81keoR65E1lFwCqgVi9Ln
	 OH5O2a81QWHHcc8jfu1NhZBYjv+1XNR2aVxumRNjqur4vC/TFiABxbFu9a9p0PcxwbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642138;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yTi7JrQjlF5tsoiU/FXBxmVA02MnoZcfU3wqIjdgDzs=;
	b=Bbf9Eai5a5HWDXm6VULeYuZcn/FS+pRjNnA+HT9lcH1lGamW47ICLLpW06ebtavcHVl+
	 WMeUa/SSfMw4Rq+y0Ph2I+Dl21T+daDj5I9ufUjH+TmFoLoRnhXzZpzIXOgT+KjNoedSs
	 ih3IYCRbylyVZ2R6YiBnSJLsNnAcDy5rqwarr6mZDTyEL5ttWB7v9mpTiNISqBsJFdCME
	 TWUDg4TmrsdKx3PkvAvEQaLUZyaB+eGy4Dc0gQycvVRFJmlKZV8ylCy+VcLN0cpzMwzou
	 SjTfFwNEic1ZewoSjIEsKSU4Yh9wKiOYIPVTCTKZdqNHVexl5Bq5FpO4pPiyrQOXF1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3zJ1yQg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97060A2622;
	Wed, 25 Nov 2026 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3zJ1yQg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E8C1F01570;
	Wed, 25 Nov 2026 21:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642138;
	bh=yTi7JrQjlF5tsoiU/FXBxmVA02MnoZcfU3wqIjdgDzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3zJ1yQgo2r5yRS1aiiliaeXfntfZgB/YSU7cPl2Fn/LwvTjQFv58cWmqp3nLoth5
	 CnyKZHL01qASz17MOaiVCkLAU9Z+wvCF1TEdnQfNShC2qc4ttn4P3l+Jtz/7hUqXyo
	 O83m0opN/qZQ6Egz1dTjr/wc+k6O5qWmVFx3l+vNo1kgMVyx+z3NQ6DqYpIN463LVp
	 eC3qm+8n0aLDWHYy/9k6Xfe8uyKznZRhmeapLiM5PIOvR0vvcXAGmlecnlBadyOA01
	 BiZc4OBo5f+vpCKuu51qP6GzaClmVc6yQztLgnoMvwrllHuMNWDSCpvR53hwlNNlPf
	 fmmi1kTojBYBg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v4 07/11] perf tools: Check thread liveness when accessing /proc
Date: Wed, 25 Nov 2026 13:28:47 -0800
Message-ID: <20261125212851.1792988-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261125212851.1792988-1-namhyung@kernel.org>
References: <20261125212851.1792988-1-namhyung@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add thread__exited() and thread__is_alive(), and mark threads as exited
on PERF_RECORD_EXIT, replaced parent and child threads on
PERF_RECORD_FORK, and perf_event__exit_del_thread().

Propagate thread exit and boot ID mismatch to thread->nsinfo, guard
/proc accesses with thread__is_alive() and nsinfo__check_proc() (for
dso__filename_with_chroot(), while skipping chroot fallback when
nsinfo__need_setns() is set), read /proc/<pid>/root via
nsinfo__proc_readlink() in filename_with_chroot(), and avoid
synthesizing a live parent thread in thread__e_machine_endian() when a
sub-thread is no longer alive.

Also process PERF_RECORD_HEADER_FEATURE events in perf-inject so
pipe-mode sessions populate session->header.env (including boot_id) for
perf_env__is_same_boot().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 14 +++++++-
 tools/perf/builtin-trace.c  |  2 +-
 tools/perf/util/dso.c       |  7 +++-
 tools/perf/util/event.c     |  1 +
 tools/perf/util/machine.c   | 17 +++++++---
 tools/perf/util/thread.c    | 65 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/thread.h    |  7 ++--
 tools/perf/util/util.c      |  7 ++--
 8 files changed, 103 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 05bf1aae61778952..de3a74d2bab9220f 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -208,6 +208,18 @@ static int perf_event__repipe_op2_synth(const struct perf_tool *tool,
 	return perf_event__repipe_synth(tool, event);
 }
 
+static int perf_event__repipe_feature(const struct perf_tool *tool,
+				      struct perf_session *session,
+				      union perf_event *event)
+{
+	int ret = perf_event__process_feature(tool, session, event);
+
+	if (ret)
+		return ret;
+
+	return perf_event__repipe_synth(tool, event);
+}
+
 static int perf_event__repipe_op4_synth(const struct perf_tool *tool,
 					struct perf_session *session __maybe_unused,
 					union perf_event *event,
@@ -2853,7 +2865,7 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.stat_config		= perf_event__repipe_op2_synth;
 	inject.tool.stat		= perf_event__repipe_op2_synth;
 	inject.tool.stat_round		= perf_event__repipe_op2_synth;
-	inject.tool.feature		= perf_event__repipe_op2_synth;
+	inject.tool.feature		= perf_event__repipe_feature;
 	inject.tool.finished_init	= perf_event__repipe_op2_synth;
 	inject.tool.compressed		= perf_event__repipe_op4_synth;
 	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c08f2c3a8128bc91..101511c79c639fb3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1858,7 +1858,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 		return NULL;
 
 	if ((fd > ttrace->files.max || ttrace->files.table[fd].pathname == NULL)) {
-		if (!trace->live)
+		if (!trace->live || !thread__is_alive(thread))
 			return NULL;
 		++trace->stats.proc_getname;
 		if (thread__read_fd_path(thread, fd))
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 287f6812139c59ab..dafd5acd6be41908 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -567,7 +567,12 @@ static int do_open(char *name) __must_hold(&dso__data_open_lock)
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
 {
-	return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filename);
+	struct nsinfo *nsi = (struct nsinfo *)dso__nsinfo_const(dso);
+
+	if (nsinfo__need_setns(nsi) || !nsinfo__check_proc(nsi))
+		return NULL;
+
+	return filename_with_chroot(nsinfo__pid(nsi), filename);
 }
 
 char *dso__get_filename(struct dso *dso, const char *root_dir, bool *decomp,
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2f80e364659fea71..ae0ebda42fa47e8c 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -447,6 +447,7 @@ int perf_event__exit_del_thread(const struct perf_tool *tool __maybe_unused,
 		    event->fork.ppid, event->fork.ptid);
 
 	if (thread) {
+		thread__set_exited(thread, /*exited=*/true);
 		machine__remove_thread(machine, thread);
 		thread__put(thread);
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 62f3ee8488548ef6..2750d507aecc29d0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -518,8 +518,14 @@ static void machine__update_thread_pid(struct machine *machine,
 		return;
 
 	thread__set_pid(th, pid);
-	nsinfo__zput(RC_CHK_ACCESS(th)->nsinfo);
-	RC_CHK_ACCESS(th)->nsinfo = nsinfo__new_thread(pid, thread__tid(th));
+	thread__reset_nsinfo(th);
+	if (thread__exited(th) || !machine__is_host(machine) ||
+	    !perf_env__is_same_boot(machine->env)) {
+		struct nsinfo *nsi = thread__get_nsinfo(th);
+
+		nsinfo__set_exited(nsi);
+		nsinfo__put(nsi);
+	}
 
 	if (thread__pid(th) == thread__tid(th))
 		return;
@@ -1978,6 +1984,7 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 	    thread__pid(parent) != (pid_t)event->fork.ppid) {
 		dump_printf("removing erroneous parent thread %d/%d\n",
 			    thread__pid(parent), thread__tid(parent));
+		thread__set_exited(parent, /*exited=*/true);
 		machine__remove_thread(machine, parent);
 		thread__put(parent);
 		parent = machine__findnew_thread(machine, event->fork.ppid,
@@ -1986,6 +1993,7 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 
 	/* if a thread currently exists for the thread id remove it */
 	if (thread != NULL) {
+		thread__set_exited(thread, /*exited=*/true);
 		machine__remove_thread(machine, thread);
 		thread__put(thread);
 	}
@@ -2033,9 +2041,8 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
 	/* There is no context switch out before exit, so we decrement here. */
 	machine->parallelism--;
 	if (thread != NULL) {
-		if (symbol_conf.keep_exited_threads)
-			thread__set_exited(thread, /*exited=*/true);
-		else
+		thread__set_exited(thread, /*exited=*/true);
+		if (!symbol_conf.keep_exited_threads)
 			machine__remove_thread(machine, thread);
 	}
 	thread__put(thread);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index c03c739e47191d1e..8fa5fac9a8e7114f 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -37,6 +37,16 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 		}
 	}
 
+	if (thread__pid(thread) != 0 || thread__tid(thread) != 0) {
+		if (!machine || !machine__is_host(machine) ||
+		    !perf_env__is_same_boot(machine->env)) {
+			struct nsinfo *nsi = thread__get_nsinfo(thread);
+
+			nsinfo__set_exited(nsi);
+			nsinfo__put(nsi);
+		}
+	}
+
 	return thread__maps(thread) ? 0 : -1;
 }
 
@@ -196,9 +206,17 @@ static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 static void __thread__reset_nsinfo(struct thread *thread)
 	__must_hold(thread__namespaces_lock(thread))
 {
+	struct maps *maps = thread__maps(thread);
+	struct machine *machine = maps ? maps__machine(maps) : NULL;
+	struct nsinfo *nsi;
+
 	nsinfo__zput(RC_CHK_ACCESS(thread)->nsinfo);
-	RC_CHK_ACCESS(thread)->nsinfo = nsinfo__new_thread(thread__pid(thread),
-							   thread__tid(thread));
+	nsi = nsinfo__new_thread(thread__pid(thread), thread__tid(thread));
+	if (nsi && (thread__exited(thread) ||
+		    (machine && (!machine__is_host(machine) ||
+				 !perf_env__is_same_boot(machine->env)))))
+		nsinfo__set_exited(nsi);
+	RC_CHK_ACCESS(thread)->nsinfo = nsi;
 }
 
 void thread__reset_nsinfo(struct thread *thread)
@@ -319,6 +337,39 @@ int __thread__set_comm(struct thread *thread, const char *str, u64 timestamp,
 	return ret;
 }
 
+void thread__set_exited(struct thread *thread, bool exited)
+{
+	RC_CHK_ACCESS(thread)->exited = exited;
+	if (exited) {
+		struct nsinfo *nsi = thread__get_nsinfo(thread);
+
+		nsinfo__set_exited(nsi);
+		nsinfo__put(nsi);
+	}
+}
+
+bool thread__is_alive(struct thread *thread)
+{
+	struct maps *maps;
+	struct machine *machine;
+	struct nsinfo *nsi;
+	bool ret;
+
+	if (!thread || thread__exited(thread))
+		return false;
+
+	maps = thread__maps(thread);
+	machine = maps ? maps__machine(maps) : NULL;
+	if (machine && (!machine__is_host(machine) ||
+			!perf_env__is_same_boot(machine->env)))
+		return false;
+
+	nsi = thread__get_nsinfo(thread);
+	ret = nsinfo__check_proc(nsi);
+	nsinfo__put(nsi);
+	return ret;
+}
+
 int thread__set_comm_from_proc(struct thread *thread)
 {
 	char path[64];
@@ -326,6 +377,9 @@ int thread__set_comm_from_proc(struct thread *thread)
 	size_t sz;
 	int err = -1;
 
+	if (!thread__is_alive(thread))
+		return -1;
+
 	if (!(snprintf(path, sizeof(path), "%d/task/%d/comm",
 		       thread__pid(thread), thread__tid(thread)) >= (int)sizeof(path)) &&
 	    procfs__read_str(path, &comm, &sz) == 0) {
@@ -544,7 +598,10 @@ uint16_t thread__e_machine_endian(struct thread *thread, struct machine *machine
 	tid = thread__tid(thread);
 	pid = thread__pid(thread);
 	if (pid != tid) {
-		struct thread *parent = machine__findnew_thread(machine, pid, pid);
+		struct thread *parent = machine__find_thread(machine, pid, pid);
+
+		if (!parent && thread__is_alive(thread))
+			parent = machine__findnew_thread(machine, pid, pid);
 
 		if (parent) {
 			e_machine = thread__e_machine_endian(parent, machine, &local_e_flags,
@@ -571,7 +628,7 @@ uint16_t thread__e_machine_endian(struct thread *thread, struct machine *machine
 			is_live = !session || !session->data;
 		}
 		/* Read from /proc/pid/exe if live. */
-		if (is_live) {
+		if (is_live && thread__is_alive(thread)) {
 			e_machine = read_proc_e_machine_for_pid(pid, &local_e_flags,
 								&args.is_big_endian);
 		} else if (machine && machine->env) {
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 68d63f9c37cc4240..11b4731d345ab5e1 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -205,11 +205,14 @@ static inline refcount_t *thread__refcnt(struct thread *thread)
 	return &RC_CHK_ACCESS(thread)->refcnt;
 }
 
-static inline void thread__set_exited(struct thread *thread, bool exited)
+static inline bool thread__exited(const struct thread *thread)
 {
-	RC_CHK_ACCESS(thread)->exited = exited;
+	return RC_CHK_ACCESS(thread)->exited;
 }
 
+void thread__set_exited(struct thread *thread, bool exited);
+bool thread__is_alive(struct thread *thread);
+
 static inline bool thread__comm_set(const struct thread *thread)
 {
 	return RC_CHK_ACCESS(thread)->comm_set;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 8f7cd32f524dc10e..b513a049417ca0fe 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -22,6 +22,7 @@
 #include <linux/overflow.h>
 #include <unistd.h>
 #include "cap.h"
+#include "namespaces.h"
 #include "strlist.h"
 #include "string2.h"
 
@@ -460,10 +461,10 @@ char *filename_with_chroot(int pid, const char *filename)
 	char buf[PATH_MAX];
 	char proc_root[32];
 	char *new_name = NULL;
-	int ret;
+	ssize_t ret;
 
-	scnprintf(proc_root, sizeof(proc_root), "/proc/%d/root", pid);
-	ret = readlink(proc_root, buf, sizeof(buf) - 1);
+	scnprintf(proc_root, sizeof(proc_root), "%d/root", pid);
+	ret = nsinfo__proc_readlink(proc_root, buf, sizeof(buf) - 1);
 	if (ret <= 0)
 		return NULL;
 
-- 
2.56.1.831.g720f3f5937-goog

