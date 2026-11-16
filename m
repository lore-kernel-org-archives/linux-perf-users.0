Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808655;
	b=oFXsmMvfOqUyCMN3/jW24twue+Ttxq0/Pp3Z03DaOgOvKLe776srO/6Kd5GU2dygpgLO
	 95z2rjB9+bidNKsDX9QfAfD2N7C+Nu0XSEWw9H1CrbMdaqtaAofokWCD2dUZ5sRjWBba0
	 2rvN5FNaEtSPT6RWpsDGMZSuIezxL8O/IDpgPk/p2laTi37vD6k5h6dJ6Oc3kpwKDQlWX
	 LOjjUMm/Ki8WfkDY/oxaw7EoA+yh+WKA2ZroM/gx6sPkUHN+XdI9Qvm5BxIYLR99PETw6
	 EwbNs2Auf9NaDSkvohjc3n8H3Aw4PsgIiVuWQbhBi/X0B2fHWse+8i6RhD9uWgNyqdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808655;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=G8rXf+h8WUMtPAC0MUhDh4O+jWYG9SKgNMIAa1dqtD4=;
	b=zOCGcC/qsxY8YzO9D+y5aU3VJeIOmWZ2Bw/ZKH9Wzrzv3F2k/UhlKa+DysOcoG+tE+v9
	 9ARNCuX4BFGS0iGT50isjlK/0nV26UzC6hxc3AR3o1WeLzvXxKvxropkTjWF0TxxsnIwj
	 Dn2jWVitk9gyqGZej8/9AhAe/N082PbRcv+lZIaG/5vvcgmmBXa5RNXFwvALUMOPaJHIC
	 h0T0TR/Ua/a2LxZ11uuQKlsTV4ae14XPkJsvtAZ6WS8nhY5gbcDGwgVqGFCpjoeOzuNtc
	 Stbjod5IijKoBObcwlwIzWJE8mhHh+fKiWxHDrkoAop4B7FBqeq+jqTwvCfSzaHhosQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vnlargau;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B9606A886;
	Mon, 16 Nov 2026 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vnlargau
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A788F1F000D1;
	Mon, 16 Nov 2026 05:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808655;
	bh=G8rXf+h8WUMtPAC0MUhDh4O+jWYG9SKgNMIAa1dqtD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vnlargau2J+nBaXzk/EcnHow/2XzLVMCXHgwXdPHUG0UemLyN0aUTirr4IYVYRkxP
	 QeGolk8URTWT/zBjNIDuNsaa3Dzifsc4W5sLspalqkzGapNzPGJM/GR9Mh25XgRfYi
	 7Fjr0bA3k6In3nNfL2WE4aGmP6IgpN2FwCk6zsYatrDFIO0WooSmw1cTQMMukYVFKg
	 Qv+LHWZe6yklGUBYj4Awtox/YSEp/bDGQoh4rTNn7q7+vQBeeOvF2lp6+vD8EdL/dR
	 ksyZgne9B2lSYAMY876sU8/MgNQrbPK0yshRWjPwuqXH2zHrX8dwYOqn48MRe9LRFL
	 OM1pmF/lGUqwA==
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
Subject: [PATCH v2 04/11] perf tools: Add lock to struct nsinfo
Date: Sun, 15 Nov 2026 21:57:24 -0800
Message-ID: <20261116055731.707164-5-namhyung@kernel.org>
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

A struct nsinfo instance can be shared across threads via
thread->nsinfo and dso->nsinfo.  Add a mutex lock inside struct nsinfo
to synchronize access to its fields, initialization, copying, and mount
namespace path duplication in nsinfo__mountns_enter().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/namespaces.c | 106 +++++++++++++++++++++++++++--------
 tools/perf/util/namespaces.h |   2 +
 2 files changed, 86 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index f426eba04d6ef449..845a62045405c80a 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -94,7 +94,7 @@ static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const c
 	return 0;
 }
 
-int nsinfo__init(struct nsinfo *nsi)
+static int nsinfo__init_locked(struct nsinfo *nsi)
 {
 	char oldns[PATH_MAX];
 	char spath[PATH_MAX];
@@ -140,14 +140,29 @@ int nsinfo__init(struct nsinfo *nsi)
 	return rv;
 }
 
+int nsinfo__init(struct nsinfo *nsi)
+{
+	int rv;
+
+	if (!nsi)
+		return -1;
+
+	mutex_lock(&RC_CHK_ACCESS(nsi)->lock);
+	rv = nsinfo__init_locked(nsi);
+	mutex_unlock(&RC_CHK_ACCESS(nsi)->lock);
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
@@ -184,9 +199,9 @@ struct nsinfo *nsinfo__new(pid_t pid)
 	return nsinfo__new_thread(pid, pid);
 }
 
-static const char *nsinfo__mntns_path(const struct nsinfo *nsi)
+static struct mutex *nsinfo__lock(const struct nsinfo *nsi)
 {
-	return RC_CHK_ACCESS(nsi)->mntns_path;
+	return (struct mutex *)&RC_CHK_ACCESS(nsi)->lock;
 }
 
 struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
@@ -200,19 +215,22 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
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
+	mutex_lock(nsinfo__lock(nsi));
+	RC_CHK_ACCESS(nnsi)->pid = RC_CHK_ACCESS(nsi)->pid;
+	RC_CHK_ACCESS(nnsi)->tid = RC_CHK_ACCESS(nsi)->tid;
+	RC_CHK_ACCESS(nnsi)->tgid = RC_CHK_ACCESS(nsi)->tgid;
+	RC_CHK_ACCESS(nnsi)->nstgid = RC_CHK_ACCESS(nsi)->nstgid;
+	RC_CHK_ACCESS(nnsi)->need_setns = RC_CHK_ACCESS(nsi)->need_setns;
+	RC_CHK_ACCESS(nnsi)->in_pidns = RC_CHK_ACCESS(nsi)->in_pidns;
+	if (RC_CHK_ACCESS(nsi)->mntns_path) {
+		RC_CHK_ACCESS(nnsi)->mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
 		if (!RC_CHK_ACCESS(nnsi)->mntns_path) {
+			mutex_unlock(nsinfo__lock(nsi));
 			nsinfo__put(nnsi);
 			return NULL;
 		}
 	}
+	mutex_unlock(nsinfo__lock(nsi));
 
 	return nnsi;
 }
@@ -227,6 +245,7 @@ static void nsinfo__delete(struct nsinfo *nsi)
 	if (nsi) {
 		WARN_ONCE(refcount_read(nsinfo__refcnt(nsi)) != 0, "nsinfo refcnt unbalanced\n");
 		zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+		mutex_destroy(&RC_CHK_ACCESS(nsi)->lock);
 		RC_CHK_FREE(nsi);
 	}
 }
@@ -251,22 +270,46 @@ void nsinfo__put(struct nsinfo *nsi)
 
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
@@ -281,18 +324,26 @@ pid_t nsinfo__tid(const struct nsinfo  *nsi)
 
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
+	mutex_lock(&RC_CHK_ACCESS(nsi)->lock);
 	RC_CHK_ACCESS(nsi)->in_pidns = true;
+	mutex_unlock(&RC_CHK_ACCESS(nsi)->lock);
 }
 
 void nsinfo__mountns_enter(struct nsinfo *nsi,
 				  struct nscookie *nc)
 {
 	char curpath[PATH_MAX];
+	char *mntns_path = NULL;
 	int oldns = -1;
 	int newns = -1;
 	char *oldcwd = NULL;
@@ -303,27 +354,36 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	nc->oldns = -1;
 	nc->newns = -1;
 
-	if (!nsi || !nsinfo__need_setns(nsi))
+	if (!nsi)
+		return;
+
+	mutex_lock(&RC_CHK_ACCESS(nsi)->lock);
+	if (RC_CHK_ACCESS(nsi)->need_setns && RC_CHK_ACCESS(nsi)->mntns_path)
+		mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
+	mutex_unlock(&RC_CHK_ACCESS(nsi)->lock);
+
+	if (!mntns_path)
 		return;
 
 	if (!getcwd(curpath, sizeof(curpath)))
-		return;
+		goto out;
 
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
@@ -335,6 +395,8 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 		close(oldns);
 	if (newns > -1)
 		close(newns);
+out:
+	free(mntns_path);
 }
 
 void nsinfo__mountns_exit(struct nscookie *nc)
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index ea645954944de4be..bbb47a6f9e8323f2 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -14,6 +14,7 @@
 #include <linux/refcount.h>
 #include <linux/types.h>
 #include <internal/rc_check.h>
+#include "mutex.h"
 
 #ifndef HAVE_SETNS_SUPPORT
 int setns(int fd, int nstype);
@@ -31,6 +32,7 @@ struct namespaces *namespaces__new(struct perf_record_namespaces *event);
 void namespaces__free(struct namespaces *namespaces);
 
 DECLARE_RC_STRUCT(nsinfo) {
+	struct mutex		lock;
 	pid_t			pid;
 	pid_t			tid;
 	pid_t			tgid;
-- 
2.56.0.611.g1030f0b940-goog

