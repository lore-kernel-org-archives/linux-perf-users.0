Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808655;
	b=PK+OENBdIrPbdtUt6/dtDLiUI+/ZM/fkpv88FaE6srvKismJxuzDZruLqFbHjAp7MGZJ
	 u/j9y4cHdpWvtbiSxQwJ4zgbuj+jEieiLPkh+rzAGEdjJV0ZMu41juvwR4ZoZ/lkXeIhi
	 LBtkqurukq1pmDrbb+MIUV28H8EXIRge8TTdHzghpUtOsyiXEgewxlDjZOMz8cf5DqvMX
	 LSk4Q8VMCZFT0stigy0fzeiom1S26UcfUTvRitdl+RKwf3VUHDxfkmONXhRYgEZer2+LO
	 kxzx4NBQ4d4m28TUkHsKJbrLuws6ES+T5SxUtSooFTmBmes6CvMMkY9FFuvYXKzCbbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808655;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8yjK6L4RtykI+kjiKfC8FQgsqr5AeW7XPn3PvfqA8RM=;
	b=JZGaqdToPw14xa4eEq6KQmk7ngDUavKLhkfp+pDEue70RwR4p3n429IjO94tM0hJWhie
	 ScGWIuJ5buOaIj6I6bvGTZS4LnNg2CbXCc0oL1GkVquMrd5kBeEmrFnPI9x7YaZtDIGZR
	 4MIt6I+oea32X9v6Yn9oSFW7bGWfxFf364lrrrqmdHTgQXkjoYG7vrZf504yxgHJoDBAu
	 34fKsiWCZtOpVdR6OxclAjr3ZOPeDdj1QQyBkodrWmK8bDBjrHw99rQp2fhbZFHOBpKw4
	 nsz7zYskv19wYdF2RXggkTzFMaIIgB3HnRJDL5/BbBBGnHlXgpq01PuU7hM0KKFJwYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRmx+5gM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960D606A33E;
	Mon, 16 Nov 2026 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRmx+5gM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAEC1F000C8;
	Mon, 16 Nov 2026 05:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808655;
	bh=8yjK6L4RtykI+kjiKfC8FQgsqr5AeW7XPn3PvfqA8RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YRmx+5gMsrYV6iBE4BpVcz005Ub/2fUkiaXVLsXe6a2oyWqezim/LdhVeFO2Q2QtR
	 oadUOgqXOV7nSr/EWDpjN/U+UkxDbriEt8JZCbj1dYGGKDLEyzAF7EydTuaTiQUW+W
	 ROhs6wbigVWO8xlLJSjc8Tm2qENe7PpgX7hufY3MVBZf5GbPA8CUXvRVSY7+BAdRdt
	 U+3SvKvIZl3kJ3MFRQFDQ3Z/9abm9oAj9Bi7Trl9rKwfNolICGUHffl6oeJMPQGTod
	 5Ze7xRLcMJxz8xA8Gjh092g7q0X2kZk8JlGuxAXwFuq70XOQpDgZovADrkO07u7W9W
	 4aISY7C4dK6EA==
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
Subject: [PATCH v2 05/11] perf tools: Defer /proc lookup until nsinfo is used
Date: Sun, 15 Nov 2026 21:57:25 -0800
Message-ID: <20261116055731.707164-6-namhyung@kernel.org>
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

Do not read /proc/<pid>/task/<tid>/ eagerly in nsinfo__new_thread().
Instead, initialize struct nsinfo on demand via
nsinfo__ensure_init_locked() when namespace information is queried or
entered, protected by nsinfo->lock.

Replace thread__nsinfo() with thread__get_nsinfo() and add
thread__reset_nsinfo() to replace thread->nsinfo safely under
thread->namespaces_lock on exec and PERF_RECORD_NAMESPACES events so
namespace changes are picked up without racing existing readers.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c  |  2 +-
 tools/perf/util/jitdump.c    |  2 +-
 tools/perf/util/map.c        |  2 +-
 tools/perf/util/namespaces.c | 24 +++++++++++++++---------
 tools/perf/util/namespaces.h |  1 +
 tools/perf/util/thread.c     | 32 ++++++++++++++++++++++++++++++++
 tools/perf/util/thread.h     |  6 ++----
 7 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 0e01b14fa51676ab..05bf1aae61778952 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -626,7 +626,7 @@ static struct dso *findnew_dso(int pid, int tid, const char *filename,
 	}
 
 	vdso = is_vdso_map(filename);
-	nsi = nsinfo__get(thread__nsinfo(thread));
+	nsi = thread__get_nsinfo(thread);
 
 	if (vdso) {
 		/* The vdso maps are always on the host and not the
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 45a05316b3ca65b7..95a08ead1f380747 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -985,7 +985,7 @@ jit_process(struct perf_session *session,
 		return 0;
 	}
 
-	nsi = nsinfo__get(thread__nsinfo(thread));
+	nsi = thread__get_nsinfo(thread);
 	thread__put(thread);
 
 	/*
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d5319ffa88a7477c..91c1fbeff9d2446f 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -139,7 +139,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		anon = is_anon_memory(filename) || flags & MAP_HUGETLB;
 		vdso = is_vdso_map(filename);
 		no_dso = is_no_dso_memory(filename);
-		nsi = nsinfo__get(thread__nsinfo(thread));
+		nsi = thread__get_nsinfo(thread);
 
 		if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
 			snprintf(newfilename, sizeof(newfilename),
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 845a62045405c80a..afd8ad7f843ec09d 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -103,6 +103,8 @@ static int nsinfo__init_locked(struct nsinfo *nsi)
 	struct stat new_stat;
 	int rv = -1;
 
+	RC_CHK_ACCESS(nsi)->inited = true;
+
 	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
 		return rv;
 
@@ -153,6 +155,12 @@ int nsinfo__init(struct nsinfo *nsi)
 	return rv;
 }
 
+static void nsinfo__ensure_init_locked(struct nsinfo *nsi)
+{
+	if (!RC_CHK_ACCESS(nsi)->inited)
+		nsinfo__init_locked(nsi);
+}
+
 static struct nsinfo *nsinfo__alloc(void)
 {
 	struct nsinfo *res;
@@ -182,15 +190,6 @@ struct nsinfo *nsinfo__new_thread(pid_t pid, pid_t tid)
 	RC_CHK_ACCESS(nsi)->tid = tid;
 	RC_CHK_ACCESS(nsi)->tgid = pid;
 	RC_CHK_ACCESS(nsi)->nstgid = pid;
-	nsinfo__clear_need_setns(nsi);
-	RC_CHK_ACCESS(nsi)->in_pidns = false;
-	/* Init may fail if the process exits while we're trying to look at its
-	 * proc information. In that case, save the pid but don't try to enter
-	 * the namespace.
-	 */
-	if (nsinfo__init(nsi) == -1)
-		nsinfo__clear_need_setns(nsi);
-
 	return nsi;
 }
 
@@ -220,6 +219,7 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	RC_CHK_ACCESS(nnsi)->tid = RC_CHK_ACCESS(nsi)->tid;
 	RC_CHK_ACCESS(nnsi)->tgid = RC_CHK_ACCESS(nsi)->tgid;
 	RC_CHK_ACCESS(nnsi)->nstgid = RC_CHK_ACCESS(nsi)->nstgid;
+	RC_CHK_ACCESS(nnsi)->inited = RC_CHK_ACCESS(nsi)->inited;
 	RC_CHK_ACCESS(nnsi)->need_setns = RC_CHK_ACCESS(nsi)->need_setns;
 	RC_CHK_ACCESS(nnsi)->in_pidns = RC_CHK_ACCESS(nsi)->in_pidns;
 	if (RC_CHK_ACCESS(nsi)->mntns_path) {
@@ -276,6 +276,7 @@ bool nsinfo__need_setns(const struct nsinfo *nsi)
 		return false;
 
 	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
 	ret = RC_CHK_ACCESS(nsi)->need_setns;
 	mutex_unlock(nsinfo__lock(nsi));
 	return ret;
@@ -287,6 +288,7 @@ void nsinfo__clear_need_setns(struct nsinfo *nsi)
 		return;
 
 	mutex_lock(nsinfo__lock(nsi));
+	RC_CHK_ACCESS(nsi)->inited = true;
 	RC_CHK_ACCESS(nsi)->need_setns = false;
 	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
 	mutex_unlock(nsinfo__lock(nsi));
@@ -297,6 +299,7 @@ pid_t nsinfo__tgid(const struct nsinfo *nsi)
 	pid_t ret;
 
 	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
 	ret = RC_CHK_ACCESS(nsi)->tgid;
 	mutex_unlock(nsinfo__lock(nsi));
 	return ret;
@@ -307,6 +310,7 @@ pid_t nsinfo__nstgid(const struct nsinfo *nsi)
 	pid_t ret;
 
 	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
 	ret = RC_CHK_ACCESS(nsi)->nstgid;
 	mutex_unlock(nsinfo__lock(nsi));
 	return ret;
@@ -327,6 +331,7 @@ bool nsinfo__in_pidns(const struct nsinfo *nsi)
 	bool ret;
 
 	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
 	ret = RC_CHK_ACCESS(nsi)->in_pidns;
 	mutex_unlock(nsinfo__lock(nsi));
 	return ret;
@@ -358,6 +363,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 		return;
 
 	mutex_lock(&RC_CHK_ACCESS(nsi)->lock);
+	nsinfo__ensure_init_locked(nsi);
 	if (RC_CHK_ACCESS(nsi)->need_setns && RC_CHK_ACCESS(nsi)->mntns_path)
 		mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
 	mutex_unlock(&RC_CHK_ACCESS(nsi)->lock);
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index bbb47a6f9e8323f2..42dcca13b002f153 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -37,6 +37,7 @@ DECLARE_RC_STRUCT(nsinfo) {
 	pid_t			tid;
 	pid_t			tgid;
 	pid_t			nstgid;
+	bool			inited;
 	bool			need_setns;
 	bool			in_pidns;
 	char			*mntns_path;
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index d12eb6bc63313b00..5d1c886add3e61eb 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -191,6 +191,34 @@ static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 	return 0;
 }
 
+static void __thread__reset_nsinfo(struct thread *thread)
+	EXCLUSIVE_LOCKS_REQUIRED(thread__namespaces_lock(thread))
+{
+	nsinfo__zput(RC_CHK_ACCESS(thread)->nsinfo);
+	RC_CHK_ACCESS(thread)->nsinfo = nsinfo__new_thread(thread__pid(thread),
+							   thread__tid(thread));
+}
+
+void thread__reset_nsinfo(struct thread *thread)
+{
+	down_write(thread__namespaces_lock(thread));
+	__thread__reset_nsinfo(thread);
+	up_write(thread__namespaces_lock(thread));
+}
+
+struct nsinfo *thread__get_nsinfo(struct thread *thread)
+{
+	struct nsinfo *nsi;
+
+	if (!thread)
+		return NULL;
+
+	down_read(thread__namespaces_lock(thread));
+	nsi = nsinfo__get(RC_CHK_ACCESS(thread)->nsinfo);
+	up_read(thread__namespaces_lock(thread));
+	return nsi;
+}
+
 int thread__set_namespaces(struct thread *thread, u64 timestamp,
 			   struct perf_record_namespaces *event)
 {
@@ -198,6 +226,8 @@ int thread__set_namespaces(struct thread *thread, u64 timestamp,
 
 	down_write(thread__namespaces_lock(thread));
 	ret = __thread__set_namespaces(thread, timestamp, event);
+	if (!ret && event)
+		__thread__reset_nsinfo(thread);
 	up_write(thread__namespaces_lock(thread));
 	return ret;
 }
@@ -282,6 +312,8 @@ int __thread__set_comm(struct thread *thread, const char *str, u64 timestamp,
 	down_write(thread__comm_lock(thread));
 	ret = ____thread__set_comm(thread, str, timestamp, exec);
 	up_write(thread__comm_lock(thread));
+	if (!ret && exec)
+		thread__reset_nsinfo(thread);
 	return ret;
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index d82fce8173aefedc..36f2932422df8988 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -286,10 +286,8 @@ static inline void thread__set_ts(struct thread *thread, struct thread_stack *ts
 	RC_CHK_ACCESS(thread)->ts = ts;
 }
 
-static inline struct nsinfo *thread__nsinfo(struct thread *thread)
-{
-	return RC_CHK_ACCESS(thread)->nsinfo;
-}
+struct nsinfo *thread__get_nsinfo(struct thread *thread);
+void thread__reset_nsinfo(struct thread *thread);
 
 static inline struct srccode_state *thread__srccode_state(struct thread *thread)
 {
-- 
2.56.0.611.g1030f0b940-goog

