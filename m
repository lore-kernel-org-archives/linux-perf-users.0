Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739506;
	b=0yVmVW35r/Y8orgVUXCxhTtOi2XRVvy22buzcK1uC5HdJxvCTdWJ/Cki/fCXMWHkd966
	 SWIYNoHfDt6IsgEJt3s7jMpWE91MIcf6DvhtqBKesS7P887Eexumcs/VHqnemI78eSvWE
	 mdiCVIE47U7nQrNuWJeqJMp+Zj+xDkUjtbAsEl/HiP0gaccQch23Pg3GTYchqr25XOfYM
	 tTAWBxej2h0J6nWHJJiitAUmdEmRlt2rlzhdgnjQn7fURKJk40JdGVoXMpu+IXt3lTJJo
	 9QyUMotHDD6Eq74o0CqK6IrIthMW1YpzV1gma52ruwiKK1q45Gy/eJvB+svmq0FwJIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739506;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cDVcu+su1cmp5GFQhFKax1T5uN00V10eq9vAYrC0zjk=;
	b=cCCxgrT50e9oksG5PUPWepyn4gD6EeLCtvtNKLGZx3zsOyEA+3vs3cesxJOOF1tzLc6E
	 OV7X+RKeW02jDO0EpBcv6D7kXSF726TOMJiRKN/kxPlbNz5ogX4h8nWhD6ND+UMEQYag3
	 HWunh6Sk/1tGLncTrGS1CPbc9E7IlPkeGplx1VuO7EJ6vjAAmB6BmpVJt3i3n3o0istvl
	 +uJ0lvJbMiVkA0NdUjAtzmlimCXk/CLzg5v0pkjzZQCc2IrDNpvsLHdzHSB9zabCnlJvU
	 068AyUIdN44OLIk/rc98ftcMUrlA8qZLM8kQpS9KZcn1k/Y5ZXkVN/Hmg34JXOPHkKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R/PvBhfG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35787606A33A;
	Fri, 23 Oct 2026 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/PvBhfG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7F91F031E0;
	Fri, 23 Oct 2026 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792739506;
	bh=cDVcu+su1cmp5GFQhFKax1T5uN00V10eq9vAYrC0zjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R/PvBhfGMB1JCyFrPY/8eFmkqz7NrAhoclZyzHyhFVbTVEVtxyYCKiuS/H66Ay/Ih
	 6lIUhH+g28Y7+Wb/xhPVdQYs+HfOYP/AFNk9vk/j7/1X/hrlDbwcg/M9CWZz73jyRx
	 g4HWTmqrUDWjQaTzFrPuNxSBFpHkn4tCWNnPee8utxBTaNrOHpekAj7ni2TvxipKjo
	 7HmZAJX6pMo7p262eieJYEqfVtBUEMWMajgXN7p6UV5lcPRG+tdrE4DBV8pRjHh7Ve
	 23+IOdqA5jleRmpV/9hc4AhZRpcwfYM5bmJwKRZezB2JpRHaBM2KH3nWMozcXJtYxk
	 +fgtL3M9ihEIA==
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
Subject: [PATCH v1 06/11] perf tools: Check thread liveness when accessing /proc
Date: Fri, 23 Oct 2026 00:11:36 -0700
Message-ID: <20261023071141.134149-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261023071141.134149-1-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
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
on PERF_RECORD_EXIT and replaced threads on PERF_RECORD_FORK.

Propagate thread exit and boot ID mismatch to thread->nsinfo, and guard
/proc accesses with thread__is_alive().

Assisted-by: LLM
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c |  2 +-
 tools/perf/util/machine.c  |  9 ++++++---
 tools/perf/util/thread.c   | 33 ++++++++++++++++++++++++++++++++-
 tools/perf/util/thread.h   |  7 +++++--
 4 files changed, 44 insertions(+), 7 deletions(-)

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
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 14f52234d4d99fb6..8f6298aff681f3fc 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -498,6 +498,9 @@ static void machine__update_thread_pid(struct machine *machine,
 	thread__set_pid(th, pid);
 	nsinfo__zput(RC_CHK_ACCESS(th)->nsinfo);
 	RC_CHK_ACCESS(th)->nsinfo = nsinfo__new_thread(pid, thread__tid(th));
+	if (thread__exited(th) || !machine__is_host(machine) ||
+	    !perf_env__is_same_boot(machine->env))
+		nsinfo__set_exited(thread__nsinfo(th));
 
 	if (thread__pid(th) == thread__tid(th))
 		return;
@@ -1954,6 +1957,7 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 
 	/* if a thread currently exists for the thread id remove it */
 	if (thread != NULL) {
+		thread__set_exited(thread, /*exited=*/true);
 		machine__remove_thread(machine, thread);
 		thread__put(thread);
 	}
@@ -2001,9 +2005,8 @@ int machine__process_exit_event(struct machine *machine, union perf_event *event
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
index 377c39ec624bb7bb..f75eafb25bfc06cd 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -37,6 +37,10 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 		}
 	}
 
+	if (!machine || !machine__is_host(machine) ||
+	    !perf_env__is_same_boot(machine->env))
+		nsinfo__set_exited(thread__nsinfo(thread));
+
 	return thread__maps(thread) ? 0 : -1;
 }
 
@@ -289,6 +293,30 @@ int __thread__set_comm(struct thread *thread, const char *str, u64 timestamp,
 	return ret;
 }
 
+void thread__set_exited(struct thread *thread, bool exited)
+{
+	RC_CHK_ACCESS(thread)->exited = exited;
+	if (exited)
+		nsinfo__set_exited(thread__nsinfo(thread));
+}
+
+bool thread__is_alive(struct thread *thread)
+{
+	struct maps *maps;
+	struct machine *machine;
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
+	return nsinfo__check_proc(thread__nsinfo(thread));
+}
+
 int thread__set_comm_from_proc(struct thread *thread)
 {
 	char path[64];
@@ -296,6 +324,9 @@ int thread__set_comm_from_proc(struct thread *thread)
 	size_t sz;
 	int err = -1;
 
+	if (!thread__is_alive(thread))
+		return -1;
+
 	if (!(snprintf(path, sizeof(path), "%d/task/%d/comm",
 		       thread__pid(thread), thread__tid(thread)) >= (int)sizeof(path)) &&
 	    procfs__read_str(path, &comm, &sz) == 0) {
@@ -541,7 +572,7 @@ uint16_t thread__e_machine_endian(struct thread *thread, struct machine *machine
 			is_live = !session || !session->data;
 		}
 		/* Read from /proc/pid/exe if live. */
-		if (is_live) {
+		if (is_live && thread__is_alive(thread)) {
 			e_machine = read_proc_e_machine_for_pid(pid, &local_e_flags,
 								&args.is_big_endian);
 		} else if (machine && machine->env) {
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index d82fce8173aefedc..d6edbe9a840454f1 100644
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
2.56.0.257.gf7497c7d27-goog

