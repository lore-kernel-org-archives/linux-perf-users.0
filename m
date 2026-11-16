Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808656;
	b=b8IqhdCCmReN8ReFrYOEKT4H8w+VAYBKtERMyGt8iyh8pznQuYltAh7f4pxztejFFPl9
	 GXIUphWrHbhvUkEGcYqWP47m5bg72pSziEvjn/6nub+PIkY65O6RcjOzahyl+vsEoo3He
	 cxP/0/PbBxhqawbg7T8iZ8CtEG4SwD5o+sPWA2REMQCJQOeUMmMoB3rjkpef3rzynmpIy
	 EGKsXMHAbrC2bvf+B6T0+Z8xEePq9iP00Xbetq1TEakka9OX2LjVyC+sWV/gz8xFi8/j7
	 /pwjzbDDp12IPlSkaP4nU4/GwoWMeJoQOYzVHnHIjyOx5aYlimoWfBd7LbKxv3jh3yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808656;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uWbyshmTdblCGxoi1cbj5YzFnxvzENuUhEaTeIH+UE8=;
	b=Ws1dW8cOMrkX6he5wBgSznYorybEHf2c3f2XZ+OQH+LDgEnhSyspSPYMJmY4yZ9/Mtw/
	 9DeCAhQbdmaKPekwqnwK1wZe22n7uhlpGnZr/1pjCVVwApBXJNjWdZEpJfG4ui7e4CXhM
	 M0T8+5ThicnJyH2dETi/umwzvlKngFODDeLU1j2AD3yTsxXA7Y9Z9Bwz5Fgv4JLZ7TkDd
	 b7DxhoWdGre1M8s7dahun+0XLvIz2FmILzBPXemYr1DsuuxFocieM/JvGjggI+ZU47kfo
	 YNI/h7FkTsmhqB8w7A2u0+zvCL10y0gTVYoMXH1NguXv+1HLuy/vag1huEDkcStb+LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OIhmY/RK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5D606A8AB;
	Mon, 16 Nov 2026 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIhmY/RK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AB11F000D3;
	Mon, 16 Nov 2026 05:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808656;
	bh=uWbyshmTdblCGxoi1cbj5YzFnxvzENuUhEaTeIH+UE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OIhmY/RKN8DYAOJnPPP95qWk5Kg33y7IY15LVG8BVYREnlFsZRAdq9Ia1u4+O4xKd
	 WX5vLEfIESsoEFZaB32rY/b830I0kSPJubSyeivmfenaXPDlIpbjtR6Q5OdhSVmdzE
	 t3pOWKpjNLnogvGw9LlOu9WeVZU0YfEFOMlSLV/Aw6WZczQqRcyJdpnl/lUH0nI7D6
	 SHebstJRG/sQS8whZKnnXA9bV2SBRMSzvFKDBJ9N7O7mX91JbculKqvTQiCSugend2
	 0rdTZnfaoV2QDTeomTiQVgtPLXKS+jq3i++IF/NiIHggzXkbqbCOtCNKe+YZpO3qhh
	 k56wIFrV4EvIA==
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
Subject: [PATCH v2 07/11] perf tools: Check thread liveness when accessing /proc
Date: Sun, 15 Nov 2026 21:57:27 -0800
Message-ID: <20261116055731.707164-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
In-Reply-To: <20261116055731.707164-1-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
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
dso__filename_with_chroot()), and avoid synthesizing a live parent
thread in thread__e_machine_endian() when a sub-thread is no longer
alive.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c |  2 +-
 tools/perf/util/dso.c      |  7 +++-
 tools/perf/util/event.c    |  1 +
 tools/perf/util/machine.c  | 17 +++++++---
 tools/perf/util/thread.c   | 65 +++++++++++++++++++++++++++++++++++---
 tools/perf/util/thread.h   |  7 ++--
 6 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4094141461f91c32..a21bbf5926617633 100644
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
index e46cd614eb21184b..36e6c45dd0383073 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -587,7 +587,12 @@ static int do_open(char *name) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
 
 char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
 {
-	return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filename);
+	struct nsinfo *nsi = (struct nsinfo *)dso__nsinfo_const(dso);
+
+	if (!nsinfo__check_proc(nsi))
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
index ac857b395882f569..53cda0046d24799c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -517,8 +517,14 @@ static void machine__update_thread_pid(struct machine *machine,
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
@@ -1975,6 +1981,7 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 	    thread__pid(parent) != (pid_t)event->fork.ppid) {
 		dump_printf("removing erroneous parent thread %d/%d\n",
 			    thread__pid(parent), thread__tid(parent));
+		thread__set_exited(parent, /*exited=*/true);
 		machine__remove_thread(machine, parent);
 		thread__put(parent);
 		parent = machine__findnew_thread(machine, event->fork.ppid,
@@ -1983,6 +1990,7 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 
 	/* if a thread currently exists for the thread id remove it */
 	if (thread != NULL) {
+		thread__set_exited(thread, /*exited=*/true);
 		machine__remove_thread(machine, thread);
 		thread__put(thread);
 	}
@@ -2030,9 +2038,8 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
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
index 5d1c886add3e61eb..fda718ea5d7e6276 100644
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
 
@@ -194,9 +204,17 @@ static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 static void __thread__reset_nsinfo(struct thread *thread)
 	EXCLUSIVE_LOCKS_REQUIRED(thread__namespaces_lock(thread))
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
@@ -317,6 +335,39 @@ int __thread__set_comm(struct thread *thread, const char *str, u64 timestamp,
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
@@ -324,6 +375,9 @@ int thread__set_comm_from_proc(struct thread *thread)
 	size_t sz;
 	int err = -1;
 
+	if (!thread__is_alive(thread))
+		return -1;
+
 	if (!(snprintf(path, sizeof(path), "%d/task/%d/comm",
 		       thread__pid(thread), thread__tid(thread)) >= (int)sizeof(path)) &&
 	    procfs__read_str(path, &comm, &sz) == 0) {
@@ -542,7 +596,10 @@ uint16_t thread__e_machine_endian(struct thread *thread, struct machine *machine
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
@@ -569,7 +626,7 @@ uint16_t thread__e_machine_endian(struct thread *thread, struct machine *machine
 			is_live = !session || !session->data;
 		}
 		/* Read from /proc/pid/exe if live. */
-		if (is_live) {
+		if (is_live && thread__is_alive(thread)) {
 			e_machine = read_proc_e_machine_for_pid(pid, &local_e_flags,
 								&args.is_big_endian);
 		} else if (machine && machine->env) {
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 36f2932422df8988..927b2ddccfc8433d 100644
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
-- 
2.56.0.611.g1030f0b940-goog

