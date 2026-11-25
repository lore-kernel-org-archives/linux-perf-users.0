Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642136;
	b=fSknR7U0dRLHj3pBGun0D/2dDbDwKMekApL3XjdrYF3rtJKC8BV+xivJRd7Bc0TpN7k2
	 NlGzREzCrTmXPOzbEWvEYL22VoOtVXTIz0ELYrkLM9MkbWVrnoDel5d+vXhVruVXeOI84
	 EUjc1M7dMdA2bzYJa9wv83Kl5Y7qeWGh1GMuUp/Y1pM4KrF9hiXBB52sgZiBZLzYXDpTY
	 pMQ8r2PaQDHG60fK0B/F/P3RU6SR80hWYBxCDbuLDO0Ggm+isjX1+I2if4m1ccMgZVOFZ
	 6n14VCcZjHdLBj3jpoNM0IHUSgOFlPl3YKxb/YrRzeRODqbzLPUNBGaneSWbBtKimhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642136;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WzMYT5u8R/PxI8KgUp7RM0Q4WDZdOzqM1dnSpQB2c60=;
	b=Axg75n4vAoj3eTYNUI53bTXqrobSI1Ad3fOk1/t/pCh7q4UixS+AnWfJHyxdixjJn+yT
	 UiglJ50/2fC1J8HmuqKSIPU9R++kCFowMwhLPInbhhv4PKNTpfZ9MFmyqH7obFQ45SDrW
	 tgk2MTECO/On+73/zy8Kse6ORbtcDQf7lcetBcYHLKsXk6bIkanrdD99q8zMfhDFtpOnZ
	 gn3SVGHpfRJr4TKvgDjsvdGnwO2iK2+VbyPH32/GCpHqXm2yHuFjDTtwHRrHFXpWp+V1N
	 sCYOGkHyG1bfbQBLCbcPCdl/aAcEOcyk63k6X2GzKbfrTfaVdcjMJszQ/zK5GRuvYEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNRhrufR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB50E606A680;
	Wed, 25 Nov 2026 21:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNRhrufR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7E11F0156B;
	Wed, 25 Nov 2026 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642136;
	bh=WzMYT5u8R/PxI8KgUp7RM0Q4WDZdOzqM1dnSpQB2c60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iNRhrufRCZ700IHasnTFf0RtTVDwKUnIFI1ZfOPX+2r5yTMf7IA6KXfsIGmy63i78
	 608j1Czr4SdtrK7euZzkBjGXvli75RDKl04R7uyO2Jsg/n1Z6ZL0Pd8sRkGKu+KDsH
	 ZaZvgSCrmK3AL4IiydhDjd1xX+qcPFSgfNlMBx4I2m4s+mQ8NJl8A5F1pygn59LNk4
	 MVTTX2rTaXKS/aqZ8/X+61KX44M8zibkOSZoqmiBNQECn8glJFKZOiAHZCGSdUhuWF
	 /H4vZIb74gUU9uz13er51VzrmJuTumqaK2bV+mxlGpKzYv2H+qkSf9/XBKtCLaZUOl
	 L0TN1mS/HPncw==
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
Subject: [PATCH v4 05/11] perf tools: Defer /proc lookup until nsinfo is used
Date: Wed, 25 Nov 2026 13:28:45 -0800
Message-ID: <20261125212851.1792988-6-namhyung@kernel.org>
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
 tools/perf/util/namespaces.c | 28 ++++++++++++++++++----------
 tools/perf/util/namespaces.h |  1 +
 tools/perf/util/thread.c     | 34 +++++++++++++++++++++++++++++++++-
 tools/perf/util/thread.h     |  8 +++-----
 7 files changed, 58 insertions(+), 19 deletions(-)

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
index 38b116d230d0b913..496aab188bd549ef 100644
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
index 75c2b0ec778ab25b..940132d3458be4c7 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -110,6 +110,8 @@ static int nsinfo__init_locked(struct nsinfo *nsi)
 	struct stat new_stat;
 	int rv = -1;
 
+	RC_CHK_ACCESS(nsi)->inited = true;
+
 	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
 		return rv;
 
@@ -160,6 +162,13 @@ int nsinfo__init(struct nsinfo *nsi)
 	return rv;
 }
 
+static void nsinfo__ensure_init_locked(struct nsinfo *nsi)
+	__must_hold(nsinfo__lock(nsi))
+{
+	if (!RC_CHK_ACCESS(nsi)->inited)
+		nsinfo__init_locked(nsi);
+}
+
 static struct nsinfo *nsinfo__alloc(void)
 {
 	struct nsinfo *res;
@@ -190,16 +199,7 @@ struct nsinfo *nsinfo__new_thread(pid_t pid, pid_t tid)
 	mutex_lock(nsinfo__lock(nsi));
 	RC_CHK_ACCESS(nsi)->tgid = pid;
 	RC_CHK_ACCESS(nsi)->nstgid = pid;
-	RC_CHK_ACCESS(nsi)->in_pidns = false;
 	mutex_unlock(nsinfo__lock(nsi));
-	nsinfo__clear_need_setns(nsi);
-	/* Init may fail if the process exits while we're trying to look at its
-	 * proc information. In that case, save the pid but don't try to enter
-	 * the namespace.
-	 */
-	if (nsinfo__init(nsi) == -1)
-		nsinfo__clear_need_setns(nsi);
-
 	return nsi;
 }
 
@@ -212,7 +212,7 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
 	pid_t pid, tid, tgid, nstgid;
-	bool need_setns, in_pidns;
+	bool inited, need_setns, in_pidns;
 	char *mntns_path = NULL;
 
 	if (nsi == NULL)
@@ -227,6 +227,7 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	tid = RC_CHK_ACCESS(nsi)->tid;
 	tgid = RC_CHK_ACCESS(nsi)->tgid;
 	nstgid = RC_CHK_ACCESS(nsi)->nstgid;
+	inited = RC_CHK_ACCESS(nsi)->inited;
 	need_setns = RC_CHK_ACCESS(nsi)->need_setns;
 	in_pidns = RC_CHK_ACCESS(nsi)->in_pidns;
 	if (RC_CHK_ACCESS(nsi)->mntns_path) {
@@ -244,6 +245,7 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	mutex_lock(nsinfo__lock(nnsi));
 	RC_CHK_ACCESS(nnsi)->tgid = tgid;
 	RC_CHK_ACCESS(nnsi)->nstgid = nstgid;
+	RC_CHK_ACCESS(nnsi)->inited = inited;
 	RC_CHK_ACCESS(nnsi)->need_setns = need_setns;
 	RC_CHK_ACCESS(nnsi)->in_pidns = in_pidns;
 	RC_CHK_ACCESS(nnsi)->mntns_path = mntns_path;
@@ -295,6 +297,7 @@ bool nsinfo__need_setns(const struct nsinfo *nsi)
 		return false;
 
 	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
 	ret = RC_CHK_ACCESS(nsi)->need_setns;
 	mutex_unlock(nsinfo__lock(nsi));
 	return ret;
@@ -306,6 +309,7 @@ void nsinfo__clear_need_setns(struct nsinfo *nsi)
 		return;
 
 	mutex_lock(nsinfo__lock(nsi));
+	RC_CHK_ACCESS(nsi)->inited = true;
 	RC_CHK_ACCESS(nsi)->need_setns = false;
 	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
 	mutex_unlock(nsinfo__lock(nsi));
@@ -316,6 +320,7 @@ pid_t nsinfo__tgid(const struct nsinfo *nsi)
 	pid_t ret;
 
 	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
 	ret = RC_CHK_ACCESS(nsi)->tgid;
 	mutex_unlock(nsinfo__lock(nsi));
 	return ret;
@@ -326,6 +331,7 @@ pid_t nsinfo__nstgid(const struct nsinfo *nsi)
 	pid_t ret;
 
 	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
 	ret = RC_CHK_ACCESS(nsi)->nstgid;
 	mutex_unlock(nsinfo__lock(nsi));
 	return ret;
@@ -346,6 +352,7 @@ bool nsinfo__in_pidns(const struct nsinfo *nsi)
 	bool ret;
 
 	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
 	ret = RC_CHK_ACCESS(nsi)->in_pidns;
 	mutex_unlock(nsinfo__lock(nsi));
 	return ret;
@@ -377,6 +384,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 		return;
 
 	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__ensure_init_locked(nsi);
 	if (RC_CHK_ACCESS(nsi)->need_setns && RC_CHK_ACCESS(nsi)->mntns_path)
 		mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
 	mutex_unlock(nsinfo__lock(nsi));
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index c76090f54a819284..4e30b015db40caf5 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -37,6 +37,7 @@ DECLARE_RC_STRUCT(nsinfo) {
 	pid_t			tid;
 	pid_t			tgid __guarded_by(&lock);
 	pid_t			nstgid __guarded_by(&lock);
+	bool			inited __guarded_by(&lock);
 	bool			need_setns __guarded_by(&lock);
 	bool			in_pidns __guarded_by(&lock);
 	char			*mntns_path __guarded_by(&lock);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 8d8427b561ddde11..c03c739e47191d1e 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -108,6 +108,7 @@ void thread__delete(struct thread *thread)
 		list_del_init(&namespaces->list);
 		namespaces__free(namespaces);
 	}
+	nsinfo__zput(RC_CHK_ACCESS(thread)->nsinfo);
 	up_write(thread__namespaces_lock(thread));
 
 	down_write(thread__comm_lock(thread));
@@ -117,7 +118,6 @@ void thread__delete(struct thread *thread)
 	}
 	up_write(thread__comm_lock(thread));
 
-	nsinfo__zput(RC_CHK_ACCESS(thread)->nsinfo);
 	srccode_state_free(thread__srccode_state(thread));
 
 	exit_rwsem(thread__namespaces_lock(thread));
@@ -193,6 +193,34 @@ static int __thread__set_namespaces(struct thread *thread, u64 timestamp,
 	return 0;
 }
 
+static void __thread__reset_nsinfo(struct thread *thread)
+	__must_hold(thread__namespaces_lock(thread))
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
@@ -200,6 +228,8 @@ int thread__set_namespaces(struct thread *thread, u64 timestamp,
 
 	down_write(thread__namespaces_lock(thread));
 	ret = __thread__set_namespaces(thread, timestamp, event);
+	if (!ret && event)
+		__thread__reset_nsinfo(thread);
 	up_write(thread__namespaces_lock(thread));
 	return ret;
 }
@@ -284,6 +314,8 @@ int __thread__set_comm(struct thread *thread, const char *str, u64 timestamp,
 	down_write(thread__comm_lock(thread));
 	ret = ____thread__set_comm(thread, str, timestamp, exec);
 	up_write(thread__comm_lock(thread));
+	if (!ret && exec)
+		thread__reset_nsinfo(thread);
 	return ret;
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index a7850eebce4eb83e..68d63f9c37cc4240 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -56,7 +56,7 @@ DECLARE_RC_STRUCT(thread) {
 
 	void			*priv;
 	struct thread_stack	*ts;
-	struct nsinfo		*nsinfo;
+	struct nsinfo		*nsinfo __guarded_by(&namespaces_lock);
 	struct srccode_state	srccode_state;
 	bool			filter;
 	int			filter_entry_depth;
@@ -292,10 +292,8 @@ static inline void thread__set_ts(struct thread *thread, struct thread_stack *ts
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
2.56.1.831.g720f3f5937-goog

