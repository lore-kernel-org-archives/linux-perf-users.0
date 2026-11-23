Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476029;
	b=tqMxdgNSBLJV5JzfT0O3vtarRORR0k0uoyY7fZ9wXdyV9mqS8UdjFEGovoFu4cGzn7lX
	 vUh3RC7T8Pihl6r2iXIoiChBf4lOLaAKrvZfNzcyLaV0fkaRXz403KdkATno/Y0VJaiiy
	 PSTJ/+1+KloKRcJ9EXNiz7yJsRVwGuObXgfCk4tK0/ByKqP6j8qnFjG6GlJaOnDrHy5cp
	 nf2cfzBebZyv7PJncaNht2AeY9cFoCB4YFW/BrXjEv1H+WAkvk0w4Hz1FJuu0haeMs2EE
	 W+GBZBJo5CCiPwWgz9GO2u7aJvZzYLDqKoRJwFjcwHVqHNBFR1nF9he5He9Hjn5jo7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476029;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EaQVmehXz9ne2OjZmcf6nldg7nsy17GoyXVWUOl9Imk=;
	b=p/JGi4ueuOCZ8/hU250AZyIg3K+ey/hlhaZCsQcTkp8hyvkdmBtue5kgwGvOTDhyjqnf
	 9MW9kyAb9f/Q0PuflJZrzE0P9UHGreMcjeezQaJ8YYzMthWkCNfufxQQPmt3ype/okmT2
	 V+4d42/QdE03R61urEG7AWn4STUWaxmN8JgwOQOS70b8IED3rvzCsUpdE+eGTTFermSJ+
	 XohshRt/nJ11pe2AywTpfI+i5PxgOvUCe2dh2e//1WLvPSLtNWbEWcKUHB3Hq8sLt1D/E
	 pWrSx/N9Eg/mgCzQEYK/g7BGS0HiSobRhIuV5p1fEAC4BN2t9L6/I310Mb9TTa8vjtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwZHHrQL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE89606A68B;
	Mon, 23 Nov 2026 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwZHHrQL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C69D1F000E1;
	Mon, 23 Nov 2026 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795476029;
	bh=EaQVmehXz9ne2OjZmcf6nldg7nsy17GoyXVWUOl9Imk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EwZHHrQLanXVMEKf8X1MWN7RCWOUOkn3Bbk2R6cKrhoxhBS56KHhIRK5nL6e/V8kW
	 OVhts+tiJAVwp589hvfRic4zB3/UpAIdGlgGXgzTcDFxCEAzAmnN7cPnfkGYs6yNQl
	 1ijx/dAGc48vHagLNztCFH/cuYULprHhS+35DT/VD4TIJ6KjBh+CAlfzKGUaqpqbl3
	 I5SJK7K2IQpl1MjQu0eVGrzeloLsbfhOdk6Fvlm0wuY/dUhx3Erss6iaIUhqxI2ou8
	 tQ5mnon8U3FuTbBT44fewZuZklL29TJ2DDoAzrNu1/WHpSbgiWVa+uRT92oCYcwwCZ
	 2SHlf1VPbtbZg==
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
Subject: [PATCH v3 04/11] perf tools: Add lock to struct nsinfo
Date: Mon, 23 Nov 2026 15:20:18 -0800
Message-ID: <20261123232025.1406560-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123232025.1406560-1-namhyung@kernel.org>
References: <20261123232025.1406560-1-namhyung@kernel.org>
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

A struct nsinfo instance can be shared across threads via
thread->nsinfo and dso->nsinfo.  Add a mutex lock inside struct nsinfo
to synchronize access to its fields, initialization, copying, and mount
namespace path duplication in nsinfo__mountns_enter().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/namespaces.c | 135 ++++++++++++++++++++++++++++-------
 tools/perf/util/namespaces.h |  12 ++--
 2 files changed, 115 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index f426eba04d6ef449..75c2b0ec778ab25b 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -94,7 +94,14 @@ static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const c
 	return 0;
 }
 
-int nsinfo__init(struct nsinfo *nsi)
+static struct mutex *nsinfo__lock(const struct nsinfo *nsi)
+	__returns_ctx_lock(&RC_CHK_ACCESS(nsi)->lock)
+{
+	return (struct mutex *)&RC_CHK_ACCESS(nsi)->lock;
+}
+
+static int nsinfo__init_locked(struct nsinfo *nsi)
+	__must_hold(nsinfo__lock(nsi))
 {
 	char oldns[PATH_MAX];
 	char spath[PATH_MAX];
@@ -140,14 +147,29 @@ int nsinfo__init(struct nsinfo *nsi)
 	return rv;
 }
 
+int nsinfo__init(struct nsinfo *nsi)
+{
+	int rv;
+
+	if (!nsi)
+		return -1;
+
+	mutex_lock(nsinfo__lock(nsi));
+	rv = nsinfo__init_locked(nsi);
+	mutex_unlock(nsinfo__lock(nsi));
+	return rv;
+}
+
 static struct nsinfo *nsinfo__alloc(void)
 {
 	struct nsinfo *res;
 	RC_STRUCT(nsinfo) *nsi;
 
 	nsi = calloc(1, sizeof(*nsi));
-	if (ADD_RC_CHK(res, nsi))
+	if (ADD_RC_CHK(res, nsi)) {
 		refcount_set(&nsi->refcnt, 1);
+		mutex_init(&nsi->lock);
+	}
 
 	return res;
 }
@@ -165,10 +187,12 @@ struct nsinfo *nsinfo__new_thread(pid_t pid, pid_t tid)
 
 	RC_CHK_ACCESS(nsi)->pid = pid;
 	RC_CHK_ACCESS(nsi)->tid = tid;
+	mutex_lock(nsinfo__lock(nsi));
 	RC_CHK_ACCESS(nsi)->tgid = pid;
 	RC_CHK_ACCESS(nsi)->nstgid = pid;
-	nsinfo__clear_need_setns(nsi);
 	RC_CHK_ACCESS(nsi)->in_pidns = false;
+	mutex_unlock(nsinfo__lock(nsi));
+	nsinfo__clear_need_setns(nsi);
 	/* Init may fail if the process exits while we're trying to look at its
 	 * proc information. In that case, save the pid but don't try to enter
 	 * the namespace.
@@ -184,14 +208,12 @@ struct nsinfo *nsinfo__new(pid_t pid)
 	return nsinfo__new_thread(pid, pid);
 }
 
-static const char *nsinfo__mntns_path(const struct nsinfo *nsi)
-{
-	return RC_CHK_ACCESS(nsi)->mntns_path;
-}
-
 struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
+	pid_t pid, tid, tgid, nstgid;
+	bool need_setns, in_pidns;
+	char *mntns_path = NULL;
 
 	if (nsi == NULL)
 		return NULL;
@@ -200,19 +222,32 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	if (!nnsi)
 		return NULL;
 
-	RC_CHK_ACCESS(nnsi)->pid = nsinfo__pid(nsi);
-	RC_CHK_ACCESS(nnsi)->tid = nsinfo__tid(nsi);
-	RC_CHK_ACCESS(nnsi)->tgid = nsinfo__tgid(nsi);
-	RC_CHK_ACCESS(nnsi)->nstgid = nsinfo__nstgid(nsi);
-	RC_CHK_ACCESS(nnsi)->need_setns = nsinfo__need_setns(nsi);
-	RC_CHK_ACCESS(nnsi)->in_pidns = nsinfo__in_pidns(nsi);
-	if (nsinfo__mntns_path(nsi)) {
-		RC_CHK_ACCESS(nnsi)->mntns_path = strdup(nsinfo__mntns_path(nsi));
-		if (!RC_CHK_ACCESS(nnsi)->mntns_path) {
+	mutex_lock(nsinfo__lock(nsi));
+	pid = RC_CHK_ACCESS(nsi)->pid;
+	tid = RC_CHK_ACCESS(nsi)->tid;
+	tgid = RC_CHK_ACCESS(nsi)->tgid;
+	nstgid = RC_CHK_ACCESS(nsi)->nstgid;
+	need_setns = RC_CHK_ACCESS(nsi)->need_setns;
+	in_pidns = RC_CHK_ACCESS(nsi)->in_pidns;
+	if (RC_CHK_ACCESS(nsi)->mntns_path) {
+		mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
+		if (!mntns_path) {
+			mutex_unlock(nsinfo__lock(nsi));
 			nsinfo__put(nnsi);
 			return NULL;
 		}
 	}
+	mutex_unlock(nsinfo__lock(nsi));
+
+	RC_CHK_ACCESS(nnsi)->pid = pid;
+	RC_CHK_ACCESS(nnsi)->tid = tid;
+	mutex_lock(nsinfo__lock(nnsi));
+	RC_CHK_ACCESS(nnsi)->tgid = tgid;
+	RC_CHK_ACCESS(nnsi)->nstgid = nstgid;
+	RC_CHK_ACCESS(nnsi)->need_setns = need_setns;
+	RC_CHK_ACCESS(nnsi)->in_pidns = in_pidns;
+	RC_CHK_ACCESS(nnsi)->mntns_path = mntns_path;
+	mutex_unlock(nsinfo__lock(nnsi));
 
 	return nnsi;
 }
@@ -226,7 +261,10 @@ static void nsinfo__delete(struct nsinfo *nsi)
 {
 	if (nsi) {
 		WARN_ONCE(refcount_read(nsinfo__refcnt(nsi)) != 0, "nsinfo refcnt unbalanced\n");
+		mutex_lock(nsinfo__lock(nsi));
 		zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+		mutex_unlock(nsinfo__lock(nsi));
+		mutex_destroy(&RC_CHK_ACCESS(nsi)->lock);
 		RC_CHK_FREE(nsi);
 	}
 }
@@ -251,22 +289,46 @@ void nsinfo__put(struct nsinfo *nsi)
 
 bool nsinfo__need_setns(const struct nsinfo *nsi)
 {
-	return RC_CHK_ACCESS(nsi)->need_setns;
+	bool ret;
+
+	if (!nsi)
+		return false;
+
+	mutex_lock(nsinfo__lock(nsi));
+	ret = RC_CHK_ACCESS(nsi)->need_setns;
+	mutex_unlock(nsinfo__lock(nsi));
+	return ret;
 }
 
 void nsinfo__clear_need_setns(struct nsinfo *nsi)
 {
+	if (!nsi)
+		return;
+
+	mutex_lock(nsinfo__lock(nsi));
 	RC_CHK_ACCESS(nsi)->need_setns = false;
+	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+	mutex_unlock(nsinfo__lock(nsi));
 }
 
-pid_t nsinfo__tgid(const struct nsinfo  *nsi)
+pid_t nsinfo__tgid(const struct nsinfo *nsi)
 {
-	return RC_CHK_ACCESS(nsi)->tgid;
+	pid_t ret;
+
+	mutex_lock(nsinfo__lock(nsi));
+	ret = RC_CHK_ACCESS(nsi)->tgid;
+	mutex_unlock(nsinfo__lock(nsi));
+	return ret;
 }
 
-pid_t nsinfo__nstgid(const struct nsinfo  *nsi)
+pid_t nsinfo__nstgid(const struct nsinfo *nsi)
 {
-	return RC_CHK_ACCESS(nsi)->nstgid;
+	pid_t ret;
+
+	mutex_lock(nsinfo__lock(nsi));
+	ret = RC_CHK_ACCESS(nsi)->nstgid;
+	mutex_unlock(nsinfo__lock(nsi));
+	return ret;
 }
 
 pid_t nsinfo__pid(const struct nsinfo  *nsi)
@@ -281,18 +343,26 @@ pid_t nsinfo__tid(const struct nsinfo  *nsi)
 
 bool nsinfo__in_pidns(const struct nsinfo *nsi)
 {
-	return RC_CHK_ACCESS(nsi)->in_pidns;
+	bool ret;
+
+	mutex_lock(nsinfo__lock(nsi));
+	ret = RC_CHK_ACCESS(nsi)->in_pidns;
+	mutex_unlock(nsinfo__lock(nsi));
+	return ret;
 }
 
 void nsinfo__set_in_pidns(struct nsinfo *nsi)
 {
+	mutex_lock(nsinfo__lock(nsi));
 	RC_CHK_ACCESS(nsi)->in_pidns = true;
+	mutex_unlock(nsinfo__lock(nsi));
 }
 
 void nsinfo__mountns_enter(struct nsinfo *nsi,
 				  struct nscookie *nc)
 {
 	char curpath[PATH_MAX];
+	char *mntns_path = NULL;
 	int oldns = -1;
 	int newns = -1;
 	char *oldcwd = NULL;
@@ -303,27 +373,36 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	nc->oldns = -1;
 	nc->newns = -1;
 
-	if (!nsi || !nsinfo__need_setns(nsi))
+	if (!nsi)
 		return;
 
-	if (!getcwd(curpath, sizeof(curpath)))
+	mutex_lock(nsinfo__lock(nsi));
+	if (RC_CHK_ACCESS(nsi)->need_setns && RC_CHK_ACCESS(nsi)->mntns_path)
+		mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
+	mutex_unlock(nsinfo__lock(nsi));
+
+	if (!mntns_path)
 		return;
 
+	if (!getcwd(curpath, sizeof(curpath)))
+		goto out;
+
 	oldcwd = strdup(curpath);
 	if (!oldcwd)
-		return;
+		goto out;
 
 	oldns = open("/proc/self/ns/mnt", O_RDONLY);
 	if (oldns < 0)
 		goto errout;
 
-	newns = open(nsinfo__mntns_path(nsi), O_RDONLY);
+	newns = open(mntns_path, O_RDONLY);
 	if (newns < 0)
 		goto errout;
 
 	if (setns(newns, CLONE_NEWNS) < 0)
 		goto errout;
 
+	free(mntns_path);
 	nc->oldcwd = oldcwd;
 	nc->oldns = oldns;
 	nc->newns = newns;
@@ -335,6 +414,8 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 		close(oldns);
 	if (newns > -1)
 		close(newns);
+out:
+	free(mntns_path);
 }
 
 void nsinfo__mountns_exit(struct nscookie *nc)
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index ea645954944de4be..c76090f54a819284 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -14,6 +14,7 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <internal/rc_check.h>
+#include "mutex.h"
 
 #ifndef HAVE_SETNS_SUPPORT
 int setns(int fd, int nstype);
@@ -31,13 +32,14 @@ struct namespaces *namespaces__new(struct perf_record_namespaces *event);
 void namespaces__free(struct namespaces *namespaces);
 
 DECLARE_RC_STRUCT(nsinfo) {
+	struct mutex		lock;
 	pid_t			pid;
 	pid_t			tid;
-	pid_t			tgid;
-	pid_t			nstgid;
-	bool			need_setns;
-	bool			in_pidns;
-	char			*mntns_path;
+	pid_t			tgid __guarded_by(&lock);
+	pid_t			nstgid __guarded_by(&lock);
+	bool			need_setns __guarded_by(&lock);
+	bool			in_pidns __guarded_by(&lock);
+	char			*mntns_path __guarded_by(&lock);
 	refcount_t		refcnt;
 };
 
-- 
2.56.1.809.ga0b61035b5-goog

