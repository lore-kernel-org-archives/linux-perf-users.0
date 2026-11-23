Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476031;
	b=R1EFSbXPbHIh6tI6gSyt+XY7X5lzghXdLOMokJHiylSXA8/qBJ8Z/xxHdKkG2FeCMapM
	 odCFZs+/C+VGLR/RLmkWQaxr5vlf/rY76WRJBuakKGuAa7JY4R/UoAtQvc2avYw3jthSe
	 9VWaSl/shOAzaUfqUVYEM+Z/Y3U9k0sRYtjRQsFhglzEbTgadyi0sQugBWSlztuyUCDKF
	 RPIc4imNlRZbXGH0uAM+Ey+Y30r5mbTqrlb5//6D0QZ+e9BQ+LQzIxibBsL1Axu2saHIL
	 1xx2gDdnXtM2kPAz50MpypOszVGNNJzcg8zAoaH3YS6X/1etiX+qd3cFYmlK2U6ca5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476031;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s/tcAdDTKiUKKYw+cM/Iz7lXNPmxpgl9ywFpwYi+Hd8=;
	b=ZAJ8NZA7lsgQZ4PzqziZCIUqb4JrXQ9mSHUWu/q/yHAAcm+G2hm9AdYvskUpHLSey9K4
	 hZ2EOSb+vAulVU0UBJajHmaaUobDqyqtBXVQyv0ej73jGdqYnzbIFe3fFrHnSXrZJpnDs
	 x4qv5vKhUJZW98SLfXaECt93Inx8B/c3jk73dg9TxpOK+lv/Kus2qGyh3frpJYEJ5dsNM
	 sX6UxMFWiHiw/MQrgH2WnB38qOzuE5mfHQKvduOvbk49Qpihb2yOHdBMytSAth72H/8yz
	 sFw4Bj4fsfQwPa4RUZDM4PW3iv24ut2Pw2muMuxK530gxuhKOCYuGH70LubEqdMe6dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCluMRP6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC879606A31E;
	Mon, 23 Nov 2026 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCluMRP6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D823B1F000E1;
	Mon, 23 Nov 2026 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795476031;
	bh=s/tcAdDTKiUKKYw+cM/Iz7lXNPmxpgl9ywFpwYi+Hd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VCluMRP6GNcftSUt1BOvZZpV7AX9/UfnCDBoyf09aTUJ66K6KX0o/T7nvBbLr3mbb
	 lgV6SJN++0dsDNsfNUiSa5VSZ69Ahjt9Ea5R+WgxUtu7MIX+hjY0iMOUwobZRD+8kw
	 mxrJHKHQpq/mclgD66Zx2we9IMTq7luSIAyxsPw+SEjsvrSElKuzC9i2oF5bIxzbUV
	 034L4JUaDPiG9jGWOwQ27XcivVlZ/33jfS/72Z9mLsY6C8QpxdFKN7BjX8NbM3u2KV
	 QVappCV3eiSoGoupRrjZQb+l+TNHAGAMhtlxTvGTTMmniNkjh8/p81HHlo7kd3v0KY
	 t6In1CiDEw5Hw==
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
Subject: [PATCH v3 06/11] perf tools: Verify thread status and mount namespace inode
Date: Mon, 23 Nov 2026 15:20:20 -0800
Message-ID: <20261123232025.1406560-7-namhyung@kernel.org>
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

Verify /proc/<pid>/task/<tid>/status exists and has Tgid == pid before
reading or entering a thread's namespaces to guard against PID/TID
recycling.  Pin a reference-counted host /proc file descriptor across
nsinfo__mountns_enter()/exit() and access relative /proc paths through
nsinfo__proc_open(), nsinfo__proc_stat(), and nsinfo__proc_readlink()
using stack buffers instead of heap-allocating mntns_path or keeping a
permanent /proc descriptor open.

Also record the mount namespace inode (mntns_ino) during initialization,
mark nsinfo exited if stating ns/mnt fails with ENOENT or ESRCH, and
verify via fstat() that the opened namespace file descriptor still
refers to the same mount namespace before calling setns().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/namespaces.c | 330 +++++++++++++++++++++++++++--------
 tools/perf/util/namespaces.h |   9 +-
 2 files changed, 267 insertions(+), 72 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 940132d3458be4c7..704f69663129d113 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -6,6 +6,7 @@
 
 #include "namespaces.h"
 #include "event.h"
+#include <errno.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -59,22 +60,102 @@ void namespaces__free(struct namespaces *namespaces)
 	free(namespaces);
 }
 
-static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const char *path)
+static DEFINE_MUTEX(host_proc_lock);
+static int host_proc_fd __guarded_by(&host_proc_lock) = -1;
+static unsigned int host_proc_refcnt __guarded_by(&host_proc_lock);
+
+static void nsinfo__host_proc_get(void)
+{
+	mutex_lock(&host_proc_lock);
+	if (host_proc_refcnt++ == 0)
+		host_proc_fd = open("/proc", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	mutex_unlock(&host_proc_lock);
+}
+
+static void nsinfo__host_proc_put(void)
+{
+	mutex_lock(&host_proc_lock);
+	if (host_proc_refcnt > 0 && --host_proc_refcnt == 0 &&
+	    host_proc_fd >= 0) {
+		close(host_proc_fd);
+		host_proc_fd = -1;
+	}
+	mutex_unlock(&host_proc_lock);
+}
+
+static int nsinfo__proc_open(const char *rel_path, int flags)
+{
+	char path[64];
+	int ret;
+
+	mutex_lock(&host_proc_lock);
+	if (host_proc_fd >= 0) {
+		ret = openat(host_proc_fd, rel_path, flags);
+	} else {
+		scnprintf(path, sizeof(path), "/proc/%s", rel_path);
+		ret = open(path, flags);
+	}
+	mutex_unlock(&host_proc_lock);
+	return ret;
+}
+
+static int nsinfo__proc_stat(const char *rel_path, struct stat *st)
+{
+	char path[64];
+	int ret;
+
+	mutex_lock(&host_proc_lock);
+	if (host_proc_fd >= 0) {
+		ret = fstatat(host_proc_fd, rel_path, st, 0);
+	} else {
+		scnprintf(path, sizeof(path), "/proc/%s", rel_path);
+		ret = stat(path, st);
+	}
+	mutex_unlock(&host_proc_lock);
+	return ret;
+}
+
+ssize_t nsinfo__proc_readlink(const char *rel_path, char *buf, size_t size)
+{
+	char path[64];
+	ssize_t ret;
+
+	mutex_lock(&host_proc_lock);
+	if (host_proc_fd >= 0) {
+		ret = readlinkat(host_proc_fd, rel_path, buf, size);
+	} else {
+		scnprintf(path, sizeof(path), "/proc/%s", rel_path);
+		ret = readlink(path, buf, size);
+	}
+	mutex_unlock(&host_proc_lock);
+	return ret;
+}
+
+static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns,
+			     const char *rel_path)
 {
 	FILE *f = NULL;
 	char *statln = NULL;
 	size_t linesz = 0;
 	char *nspid;
+	int fd;
+	bool got_tgid = false;
 
-	f = fopen(path, "r");
-	if (f == NULL)
+	fd = nsinfo__proc_open(rel_path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
 		return -1;
+	f = fdopen(fd, "r");
+	if (f == NULL) {
+		close(fd);
+		return -1;
+	}
 
 	while (getline(&statln, &linesz, f) != -1) {
 		/* Use tgid if CONFIG_PID_NS is not defined. */
 		if (strstr(statln, "Tgid:") != NULL) {
 			*tgid = (pid_t)strtol(strrchr(statln, '\t'), NULL, 10);
 			*nstgid = *tgid;
+			got_tgid = true;
 		}
 
 		if (strstr(statln, "NStgid:") != NULL) {
@@ -91,7 +172,17 @@ static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const c
 
 	fclose(f);
 	free(statln);
-	return 0;
+	return got_tgid ? 0 : -1;
+}
+
+static int nsinfo__get_task_nspid(const struct nsinfo *nsi,
+				  pid_t *tgid, pid_t *nstgid, bool *in_pidns)
+{
+	char spath[64];
+
+	scnprintf(spath, sizeof(spath), "%d/task/%d/status",
+		  nsinfo__pid(nsi), nsinfo__tid(nsi));
+	return nsinfo__get_nspid(tgid, nstgid, in_pidns, spath);
 }
 
 static struct mutex *nsinfo__lock(const struct nsinfo *nsi)
@@ -100,53 +191,69 @@ static struct mutex *nsinfo__lock(const struct nsinfo *nsi)
 	return (struct mutex *)&RC_CHK_ACCESS(nsi)->lock;
 }
 
+static void nsinfo__clear_need_setns_locked(struct nsinfo *nsi)
+	__must_hold(nsinfo__lock(nsi))
+{
+	RC_CHK_ACCESS(nsi)->inited = true;
+	RC_CHK_ACCESS(nsi)->need_setns = false;
+}
+
+static void nsinfo__set_exited_locked(struct nsinfo *nsi)
+	__must_hold(nsinfo__lock(nsi))
+{
+	RC_CHK_ACCESS(nsi)->exited = true;
+	nsinfo__clear_need_setns_locked(nsi);
+}
+
 static int nsinfo__init_locked(struct nsinfo *nsi)
 	__must_hold(nsinfo__lock(nsi))
 {
-	char oldns[PATH_MAX];
-	char spath[PATH_MAX];
-	char *newns = NULL;
+	char newns[64];
 	struct stat old_stat;
 	struct stat new_stat;
-	int rv = -1;
+	pid_t tgid = 0, nstgid = 0;
+	bool in_pidns = false;
+
+	if (RC_CHK_ACCESS(nsi)->exited)
+		return -1;
 
 	RC_CHK_ACCESS(nsi)->inited = true;
 
-	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
-		return rv;
+	/*
+	 * Verify that the thread (pid, tid) still exists in /proc and its Tgid
+	 * matches pid (guarding against PID/TID recycling), while resolving the
+	 * innermost tgid if the process is in a different PID namespace.
+	 */
+	if (nsinfo__get_task_nspid(nsi, &tgid, &nstgid, &in_pidns) < 0 ||
+	    tgid != nsinfo__pid(nsi)) {
+		nsinfo__set_exited_locked(nsi);
+		return -1;
+	}
 
-	if (asprintf(&newns, "/proc/%d/task/%d/ns/mnt",
-		     nsinfo__pid(nsi), nsinfo__tid(nsi)) == -1)
-		return rv;
+	RC_CHK_ACCESS(nsi)->tgid = tgid;
+	RC_CHK_ACCESS(nsi)->nstgid = nstgid;
+	RC_CHK_ACCESS(nsi)->in_pidns = in_pidns;
 
-	if (stat(oldns, &old_stat) < 0)
-		goto out;
+	if (nsinfo__proc_stat("self/ns/mnt", &old_stat) < 0)
+		return -1;
 
-	if (stat(newns, &new_stat) < 0)
-		goto out;
+	scnprintf(newns, sizeof(newns), "%d/task/%d/ns/mnt",
+		  nsinfo__pid(nsi), nsinfo__tid(nsi));
+	if (nsinfo__proc_stat(newns, &new_stat) < 0) {
+		if (errno == ENOENT || errno == ESRCH)
+			nsinfo__set_exited_locked(nsi);
+		return -1;
+	}
 
 	/* Check if the mount namespaces differ, if so then indicate that we
 	 * want to switch as part of looking up dso/map data.
 	 */
 	if (old_stat.st_ino != new_stat.st_ino) {
 		RC_CHK_ACCESS(nsi)->need_setns = true;
-		RC_CHK_ACCESS(nsi)->mntns_path = newns;
-		newns = NULL;
+		RC_CHK_ACCESS(nsi)->mntns_ino = new_stat.st_ino;
 	}
 
-	/* If we're dealing with a process that is in a different PID namespace,
-	 * attempt to work out the innermost tgid for the process.
-	 */
-	if (snprintf(spath, PATH_MAX, "/proc/%d/task/%d/status",
-		     nsinfo__pid(nsi), nsinfo__tid(nsi)) >= PATH_MAX)
-		goto out;
-
-	rv = nsinfo__get_nspid(&RC_CHK_ACCESS(nsi)->tgid, &RC_CHK_ACCESS(nsi)->nstgid,
-			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
-
-out:
-	free(newns);
-	return rv;
+	return 0;
 }
 
 int nsinfo__init(struct nsinfo *nsi)
@@ -165,7 +272,7 @@ int nsinfo__init(struct nsinfo *nsi)
 static void nsinfo__ensure_init_locked(struct nsinfo *nsi)
 	__must_hold(nsinfo__lock(nsi))
 {
-	if (!RC_CHK_ACCESS(nsi)->inited)
+	if (!RC_CHK_ACCESS(nsi)->inited && !RC_CHK_ACCESS(nsi)->exited)
 		nsinfo__init_locked(nsi);
 }
 
@@ -212,8 +319,8 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
 	pid_t pid, tid, tgid, nstgid;
-	bool inited, need_setns, in_pidns;
-	char *mntns_path = NULL;
+	ino_t mntns_ino;
+	bool inited, exited, need_setns, in_pidns;
 
 	if (nsi == NULL)
 		return NULL;
@@ -227,17 +334,11 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	tid = RC_CHK_ACCESS(nsi)->tid;
 	tgid = RC_CHK_ACCESS(nsi)->tgid;
 	nstgid = RC_CHK_ACCESS(nsi)->nstgid;
+	mntns_ino = RC_CHK_ACCESS(nsi)->mntns_ino;
 	inited = RC_CHK_ACCESS(nsi)->inited;
+	exited = RC_CHK_ACCESS(nsi)->exited;
 	need_setns = RC_CHK_ACCESS(nsi)->need_setns;
 	in_pidns = RC_CHK_ACCESS(nsi)->in_pidns;
-	if (RC_CHK_ACCESS(nsi)->mntns_path) {
-		mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
-		if (!mntns_path) {
-			mutex_unlock(nsinfo__lock(nsi));
-			nsinfo__put(nnsi);
-			return NULL;
-		}
-	}
 	mutex_unlock(nsinfo__lock(nsi));
 
 	RC_CHK_ACCESS(nnsi)->pid = pid;
@@ -245,10 +346,11 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	mutex_lock(nsinfo__lock(nnsi));
 	RC_CHK_ACCESS(nnsi)->tgid = tgid;
 	RC_CHK_ACCESS(nnsi)->nstgid = nstgid;
+	RC_CHK_ACCESS(nnsi)->mntns_ino = mntns_ino;
 	RC_CHK_ACCESS(nnsi)->inited = inited;
+	RC_CHK_ACCESS(nnsi)->exited = exited;
 	RC_CHK_ACCESS(nnsi)->need_setns = need_setns;
 	RC_CHK_ACCESS(nnsi)->in_pidns = in_pidns;
-	RC_CHK_ACCESS(nnsi)->mntns_path = mntns_path;
 	mutex_unlock(nsinfo__lock(nnsi));
 
 	return nnsi;
@@ -263,9 +365,6 @@ static void nsinfo__delete(struct nsinfo *nsi)
 {
 	if (nsi) {
 		WARN_ONCE(refcount_read(nsinfo__refcnt(nsi)) != 0, "nsinfo refcnt unbalanced\n");
-		mutex_lock(nsinfo__lock(nsi));
-		zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
-		mutex_unlock(nsinfo__lock(nsi));
 		mutex_destroy(&RC_CHK_ACCESS(nsi)->lock);
 		RC_CHK_FREE(nsi);
 	}
@@ -289,6 +388,46 @@ void nsinfo__put(struct nsinfo *nsi)
 		RC_CHK_PUT(nsi);
 }
 
+bool nsinfo__inited(const struct nsinfo *nsi)
+{
+	bool ret;
+
+	if (!nsi)
+		return false;
+
+	mutex_lock(nsinfo__lock(nsi));
+	ret = RC_CHK_ACCESS(nsi)->inited;
+	mutex_unlock(nsinfo__lock(nsi));
+	return ret;
+}
+
+bool nsinfo__exited(const struct nsinfo *nsi)
+{
+	bool ret;
+
+	if (!nsi)
+		return false;
+
+	mutex_lock(nsinfo__lock(nsi));
+	ret = RC_CHK_ACCESS(nsi)->exited;
+	mutex_unlock(nsinfo__lock(nsi));
+	return ret;
+}
+
+ino_t nsinfo__mntns_ino(const struct nsinfo *nsi)
+{
+	ino_t ret;
+
+	if (!nsi)
+		return 0;
+
+	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
+	ret = RC_CHK_ACCESS(nsi)->mntns_ino;
+	mutex_unlock(nsinfo__lock(nsi));
+	return ret;
+}
+
 bool nsinfo__need_setns(const struct nsinfo *nsi)
 {
 	bool ret;
@@ -298,7 +437,7 @@ bool nsinfo__need_setns(const struct nsinfo *nsi)
 
 	mutex_lock(nsinfo__lock(nsi));
 	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
-	ret = RC_CHK_ACCESS(nsi)->need_setns;
+	ret = !RC_CHK_ACCESS(nsi)->exited && RC_CHK_ACCESS(nsi)->need_setns;
 	mutex_unlock(nsinfo__lock(nsi));
 	return ret;
 }
@@ -309,12 +448,44 @@ void nsinfo__clear_need_setns(struct nsinfo *nsi)
 		return;
 
 	mutex_lock(nsinfo__lock(nsi));
-	RC_CHK_ACCESS(nsi)->inited = true;
-	RC_CHK_ACCESS(nsi)->need_setns = false;
-	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+	nsinfo__clear_need_setns_locked(nsi);
 	mutex_unlock(nsinfo__lock(nsi));
 }
 
+void nsinfo__set_exited(struct nsinfo *nsi)
+{
+	if (!nsi)
+		return;
+
+	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__set_exited_locked(nsi);
+	mutex_unlock(nsinfo__lock(nsi));
+}
+
+bool nsinfo__check_proc(struct nsinfo *nsi)
+{
+	pid_t tgid = 0, nstgid = 0;
+	bool in_pidns = false;
+	bool exited;
+
+	if (!nsi)
+		return false;
+
+	mutex_lock(nsinfo__lock(nsi));
+	exited = RC_CHK_ACCESS(nsi)->exited;
+	mutex_unlock(nsinfo__lock(nsi));
+	if (exited)
+		return false;
+
+	if (nsinfo__get_task_nspid(nsi, &tgid, &nstgid, &in_pidns) < 0 ||
+	    tgid != nsinfo__pid(nsi)) {
+		nsinfo__set_exited(nsi);
+		return false;
+	}
+
+	return true;
+}
+
 pid_t nsinfo__tgid(const struct nsinfo *nsi)
 {
 	pid_t ret;
@@ -369,7 +540,10 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 				  struct nscookie *nc)
 {
 	char curpath[PATH_MAX];
-	char *mntns_path = NULL;
+	char mntns_path[64];
+	ino_t mntns_ino = 0;
+	bool need_setns = false;
+	struct stat st;
 	int oldns = -1;
 	int newns = -1;
 	char *oldcwd = NULL;
@@ -379,66 +553,74 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 
 	nc->oldns = -1;
 	nc->newns = -1;
+	nc->oldcwd = NULL;
 
 	if (!nsi)
 		return;
 
 	mutex_lock(nsinfo__lock(nsi));
 	nsinfo__ensure_init_locked(nsi);
-	if (RC_CHK_ACCESS(nsi)->need_setns && RC_CHK_ACCESS(nsi)->mntns_path)
-		mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
+	if (!RC_CHK_ACCESS(nsi)->exited && RC_CHK_ACCESS(nsi)->need_setns) {
+		need_setns = true;
+		mntns_ino = RC_CHK_ACCESS(nsi)->mntns_ino;
+	}
 	mutex_unlock(nsinfo__lock(nsi));
 
-	if (!mntns_path)
+	if (!need_setns)
+		return;
+
+	if (!nsinfo__check_proc(nsi))
 		return;
 
 	if (!getcwd(curpath, sizeof(curpath)))
-		goto out;
+		return;
 
 	oldcwd = strdup(curpath);
 	if (!oldcwd)
-		goto out;
+		return;
+
+	/* Pin host /proc before entering any target mount namespace. */
+	nsinfo__host_proc_get();
 
-	oldns = open("/proc/self/ns/mnt", O_RDONLY);
+	oldns = nsinfo__proc_open("self/ns/mnt", O_RDONLY | O_CLOEXEC);
 	if (oldns < 0)
 		goto errout;
 
-	newns = open(mntns_path, O_RDONLY);
+	scnprintf(mntns_path, sizeof(mntns_path), "%d/task/%d/ns/mnt",
+		  nsinfo__pid(nsi), nsinfo__tid(nsi));
+	newns = nsinfo__proc_open(mntns_path, O_RDONLY | O_CLOEXEC);
 	if (newns < 0)
 		goto errout;
 
+	if (fstat(newns, &st) < 0 || st.st_ino != mntns_ino) {
+		nsinfo__clear_need_setns(nsi);
+		goto errout;
+	}
+
 	if (setns(newns, CLONE_NEWNS) < 0)
 		goto errout;
 
-	free(mntns_path);
 	nc->oldcwd = oldcwd;
 	nc->oldns = oldns;
 	nc->newns = newns;
 	return;
 
 errout:
+	nsinfo__host_proc_put();
 	free(oldcwd);
 	if (oldns > -1)
 		close(oldns);
 	if (newns > -1)
 		close(newns);
-out:
-	free(mntns_path);
 }
 
 void nsinfo__mountns_exit(struct nscookie *nc)
 {
-	if (nc == NULL || nc->oldns == -1 || nc->newns == -1 || !nc->oldcwd)
+	if (nc == NULL || !nc->oldcwd)
 		return;
 
-	setns(nc->oldns, CLONE_NEWNS);
-
-	if (nc->oldcwd) {
-		WARN_ON_ONCE(chdir(nc->oldcwd));
-		zfree(&nc->oldcwd);
-	}
-
 	if (nc->oldns > -1) {
+		setns(nc->oldns, CLONE_NEWNS);
 		close(nc->oldns);
 		nc->oldns = -1;
 	}
@@ -447,6 +629,12 @@ void nsinfo__mountns_exit(struct nscookie *nc)
 		close(nc->newns);
 		nc->newns = -1;
 	}
+
+	if (nc->oldcwd) {
+		WARN_ON_ONCE(chdir(nc->oldcwd));
+		zfree(&nc->oldcwd);
+	}
+	nsinfo__host_proc_put();
 }
 
 char *nsinfo__realpath(const char *path, struct nsinfo *nsi)
@@ -478,6 +666,6 @@ bool nsinfo__is_in_root_namespace(void)
 	pid_t tgid = 0, nstgid = 0;
 	bool in_pidns = false;
 
-	nsinfo__get_nspid(&tgid, &nstgid, &in_pidns, "/proc/self/status");
+	nsinfo__get_nspid(&tgid, &nstgid, &in_pidns, "self/status");
 	return !in_pidns;
 }
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 4e30b015db40caf5..441cab597ae45e80 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -37,10 +37,11 @@ DECLARE_RC_STRUCT(nsinfo) {
 	pid_t			tid;
 	pid_t			tgid __guarded_by(&lock);
 	pid_t			nstgid __guarded_by(&lock);
+	ino_t			mntns_ino __guarded_by(&lock);
 	bool			inited __guarded_by(&lock);
+	bool			exited __guarded_by(&lock);
 	bool			need_setns __guarded_by(&lock);
 	bool			in_pidns __guarded_by(&lock);
-	char			*mntns_path __guarded_by(&lock);
 	refcount_t		refcnt;
 };
 
@@ -58,8 +59,14 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi);
 struct nsinfo *nsinfo__get(struct nsinfo *nsi);
 void nsinfo__put(struct nsinfo *nsi);
 
+bool nsinfo__inited(const struct nsinfo *nsi);
+bool nsinfo__exited(const struct nsinfo *nsi);
+ino_t nsinfo__mntns_ino(const struct nsinfo *nsi);
 bool nsinfo__need_setns(const struct nsinfo *nsi);
 void nsinfo__clear_need_setns(struct nsinfo *nsi);
+void nsinfo__set_exited(struct nsinfo *nsi);
+bool nsinfo__check_proc(struct nsinfo *nsi);
+ssize_t nsinfo__proc_readlink(const char *rel_path, char *buf, size_t size);
 pid_t nsinfo__tgid(const struct nsinfo  *nsi);
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
 pid_t nsinfo__pid(const struct nsinfo  *nsi);
-- 
2.56.1.809.ga0b61035b5-goog

