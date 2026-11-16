Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808656;
	b=kc3S9LllVnRKLuFHHAeAzy1KPpelRAu2z3xZBvLNRC2TgDk4RzAf6czR60ASzpgHsEjd
	 edsi1rjrHgA3Nk341r4T4E4MY8Gwb3RQYz39BUQKE1f1Ke5PvnIs1vEWFXf/JuYG/GxTc
	 8kbLWZvqT7blz1/DSeHs8FdK1jfN0YEjQxA9qrrRTFCisukgUY2fXBzIx4Hh+tc00iP+/
	 DbWBHykVFV90N9Q8uExX7iWd70+YBE5tMIb424BRP0NRsCAYHv/qxqJO1LX3JZ7Eq9NqW
	 7WOR5BCoME08NUiSXapwYERdMg+3dF+9NzDJcfapT5CrxHuc5j3+7tdbhymVw4jKZVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808656;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lWHYzE56HB31oCOOOtBxdHVwyKuuLODF57Vd6oQ+N0o=;
	b=HqruNRDZkYTjFuTSRXhaVSs6wmgt2BtPiXXaBK3wizTC4NO27bTGB1vn41kQpjkeQFtz
	 hmlBlm9XP5z/my0JWny6/b+91bFZLewejRCnsut5vRDB3aiBOsmrZ38fDY+gb9/iNyE7O
	 NjjpJYXa6XwGiVRwLEK6b9x4iHOxY6jue20j3Y0UFVx2Trl99XQCgCnvMhqMoc5ppvQ8f
	 N3d/gJmIxwLh4H6r+DmA077kpSmzmtOzdlxbUUy1lX5DFo1MexStR/ADSMv3NVlNcCKUG
	 DdR03B4asChgNMhAGnowotxUwCnTdswajgDj/snb+cQ3LRp0q1bmRQd525MXR3DPwhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g1M6rI/6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4A606A89B;
	Mon, 16 Nov 2026 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1M6rI/6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC5B1F00925;
	Mon, 16 Nov 2026 05:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808656;
	bh=lWHYzE56HB31oCOOOtBxdHVwyKuuLODF57Vd6oQ+N0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g1M6rI/6qQ1Ub6mdIIFGyL3sdyN3iZoiAea4yC7sAgUcogmAZmFSUiLX/x2vwwfZw
	 cSN81RJQ3B2pFWDZ7Us0QKqRSOvs6bUlrrhjSQjLjO9KNHzrMeUllEZ1M7C8cp/ShA
	 JShWM8wcOOD/IasMjXGQ5lQG+1Jl79VnNjDowVDcQ0OEIwK7c/K0iiLRBjnN9vw1VJ
	 4XGyxMMydX/wsSPHAd5o7WSA2lL10xajG1zvCHkAervjZqIlCxh4+UQz4JZk47/Ny3
	 +TUvvYM47ca6Y9L/JDh+X9wS0Q7NiHjoiDRDOTN/va1YPaGQZO0loFX8ivH1dEkyV7
	 N7WyH/aNeS1nA==
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
Subject: [PATCH v2 06/11] perf tools: Verify thread status and mount namespace inode
Date: Sun, 15 Nov 2026 21:57:26 -0800
Message-ID: <20261116055731.707164-7-namhyung@kernel.org>
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

Verify /proc/<pid>/task/<tid>/status exists and has Tgid == pid before
reading or entering a thread's namespaces to guard against PID/TID
recycling.

Also record the mount namespace inode (mntns_ino) during initialization
and verify via fstat() that the opened namespace file descriptor still
refers to the same mount namespace.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/namespaces.c | 139 +++++++++++++++++++++++++++--------
 tools/perf/util/namespaces.h |   4 +
 2 files changed, 114 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index afd8ad7f843ec09d..860b90e8384ed1f2 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -65,6 +65,7 @@ static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const c
 	char *statln = NULL;
 	size_t linesz = 0;
 	char *nspid;
+	bool got_tgid = false;
 
 	f = fopen(path, "r");
 	if (f == NULL)
@@ -75,6 +76,7 @@ static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const c
 		if (strstr(statln, "Tgid:") != NULL) {
 			*tgid = (pid_t)strtol(strrchr(statln, '\t'), NULL, 10);
 			*nstgid = *tgid;
+			got_tgid = true;
 		}
 
 		if (strstr(statln, "NStgid:") != NULL) {
@@ -91,7 +93,20 @@ static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const c
 
 	fclose(f);
 	free(statln);
-	return 0;
+	return got_tgid ? 0 : -1;
+}
+
+static void nsinfo__clear_need_setns_locked(struct nsinfo *nsi)
+{
+	RC_CHK_ACCESS(nsi)->inited = true;
+	RC_CHK_ACCESS(nsi)->need_setns = false;
+	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+}
+
+static void nsinfo__set_exited_locked(struct nsinfo *nsi)
+{
+	RC_CHK_ACCESS(nsi)->exited = true;
+	nsinfo__clear_need_setns_locked(nsi);
 }
 
 static int nsinfo__init_locked(struct nsinfo *nsi)
@@ -101,16 +116,41 @@ static int nsinfo__init_locked(struct nsinfo *nsi)
 	char *newns = NULL;
 	struct stat old_stat;
 	struct stat new_stat;
+	pid_t tgid = 0, nstgid = 0;
+	bool in_pidns = false;
 	int rv = -1;
 
+	if (RC_CHK_ACCESS(nsi)->exited)
+		return -1;
+
 	RC_CHK_ACCESS(nsi)->inited = true;
 
+	/*
+	 * Verify that the thread (pid, tid) still exists in /proc and its Tgid
+	 * matches pid (guarding against PID/TID recycling), while resolving the
+	 * innermost tgid if the process is in a different PID namespace.
+	 */
+	if (snprintf(spath, PATH_MAX, "/proc/%d/task/%d/status",
+		     nsinfo__pid(nsi), nsinfo__tid(nsi)) >= PATH_MAX)
+		goto out;
+
+	rv = nsinfo__get_nspid(&tgid, &nstgid, &in_pidns, spath);
+	if (rv < 0 || tgid != nsinfo__pid(nsi)) {
+		nsinfo__set_exited_locked(nsi);
+		rv = -1;
+		goto out;
+	}
+
+	RC_CHK_ACCESS(nsi)->tgid = tgid;
+	RC_CHK_ACCESS(nsi)->nstgid = nstgid;
+	RC_CHK_ACCESS(nsi)->in_pidns = in_pidns;
+
 	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
-		return rv;
+		return -1;
 
 	if (asprintf(&newns, "/proc/%d/task/%d/ns/mnt",
 		     nsinfo__pid(nsi), nsinfo__tid(nsi)) == -1)
-		return rv;
+		return -1;
 
 	if (stat(oldns, &old_stat) < 0)
 		goto out;
@@ -124,19 +164,10 @@ static int nsinfo__init_locked(struct nsinfo *nsi)
 	if (old_stat.st_ino != new_stat.st_ino) {
 		RC_CHK_ACCESS(nsi)->need_setns = true;
 		RC_CHK_ACCESS(nsi)->mntns_path = newns;
+		RC_CHK_ACCESS(nsi)->mntns_ino = new_stat.st_ino;
 		newns = NULL;
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
 out:
 	free(newns);
 	return rv;
@@ -157,7 +188,7 @@ int nsinfo__init(struct nsinfo *nsi)
 
 static void nsinfo__ensure_init_locked(struct nsinfo *nsi)
 {
-	if (!RC_CHK_ACCESS(nsi)->inited)
+	if (!RC_CHK_ACCESS(nsi)->inited && !RC_CHK_ACCESS(nsi)->exited)
 		nsinfo__init_locked(nsi);
 }
 
@@ -219,7 +250,9 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	RC_CHK_ACCESS(nnsi)->tid = RC_CHK_ACCESS(nsi)->tid;
 	RC_CHK_ACCESS(nnsi)->tgid = RC_CHK_ACCESS(nsi)->tgid;
 	RC_CHK_ACCESS(nnsi)->nstgid = RC_CHK_ACCESS(nsi)->nstgid;
+	RC_CHK_ACCESS(nnsi)->mntns_ino = RC_CHK_ACCESS(nsi)->mntns_ino;
 	RC_CHK_ACCESS(nnsi)->inited = RC_CHK_ACCESS(nsi)->inited;
+	RC_CHK_ACCESS(nnsi)->exited = RC_CHK_ACCESS(nsi)->exited;
 	RC_CHK_ACCESS(nnsi)->need_setns = RC_CHK_ACCESS(nsi)->need_setns;
 	RC_CHK_ACCESS(nnsi)->in_pidns = RC_CHK_ACCESS(nsi)->in_pidns;
 	if (RC_CHK_ACCESS(nsi)->mntns_path) {
@@ -277,7 +310,7 @@ bool nsinfo__need_setns(const struct nsinfo *nsi)
 
 	mutex_lock(nsinfo__lock(nsi));
 	nsinfo__ensure_init_locked((struct nsinfo *)nsi);
-	ret = RC_CHK_ACCESS(nsi)->need_setns;
+	ret = !RC_CHK_ACCESS(nsi)->exited && RC_CHK_ACCESS(nsi)->need_setns;
 	mutex_unlock(nsinfo__lock(nsi));
 	return ret;
 }
@@ -288,12 +321,47 @@ void nsinfo__clear_need_setns(struct nsinfo *nsi)
 		return;
 
 	mutex_lock(nsinfo__lock(nsi));
-	RC_CHK_ACCESS(nsi)->inited = true;
-	RC_CHK_ACCESS(nsi)->need_setns = false;
-	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+	nsinfo__clear_need_setns_locked(nsi);
+	mutex_unlock(nsinfo__lock(nsi));
+}
+
+void nsinfo__set_exited(struct nsinfo *nsi)
+{
+	if (!nsi)
+		return;
+
+	mutex_lock(nsinfo__lock(nsi));
+	nsinfo__set_exited_locked(nsi);
 	mutex_unlock(nsinfo__lock(nsi));
 }
 
+bool nsinfo__check_proc(struct nsinfo *nsi)
+{
+	char spath[64];
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
+	scnprintf(spath, sizeof(spath), "/proc/%d/task/%d/status",
+		  nsinfo__pid(nsi), nsinfo__tid(nsi));
+	if (nsinfo__get_nspid(&tgid, &nstgid, &in_pidns, spath) < 0 ||
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
@@ -349,6 +417,8 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 {
 	char curpath[PATH_MAX];
 	char *mntns_path = NULL;
+	ino_t mntns_ino = 0;
+	struct stat st;
 	int oldns = -1;
 	int newns = -1;
 	char *oldcwd = NULL;
@@ -358,19 +428,26 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 
 	nc->oldns = -1;
 	nc->newns = -1;
+	nc->oldcwd = NULL;
 
 	if (!nsi)
 		return;
 
 	mutex_lock(&RC_CHK_ACCESS(nsi)->lock);
 	nsinfo__ensure_init_locked(nsi);
-	if (RC_CHK_ACCESS(nsi)->need_setns && RC_CHK_ACCESS(nsi)->mntns_path)
+	if (!RC_CHK_ACCESS(nsi)->exited && RC_CHK_ACCESS(nsi)->need_setns &&
+	    RC_CHK_ACCESS(nsi)->mntns_path) {
 		mntns_path = strdup(RC_CHK_ACCESS(nsi)->mntns_path);
+		mntns_ino = RC_CHK_ACCESS(nsi)->mntns_ino;
+	}
 	mutex_unlock(&RC_CHK_ACCESS(nsi)->lock);
 
 	if (!mntns_path)
 		return;
 
+	if (!nsinfo__check_proc(nsi))
+		goto out;
+
 	if (!getcwd(curpath, sizeof(curpath)))
 		goto out;
 
@@ -378,14 +455,19 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (!oldcwd)
 		goto out;
 
-	oldns = open("/proc/self/ns/mnt", O_RDONLY);
+	oldns = open("/proc/self/ns/mnt", O_RDONLY | O_CLOEXEC);
 	if (oldns < 0)
 		goto errout;
 
-	newns = open(mntns_path, O_RDONLY);
+	newns = open(mntns_path, O_RDONLY | O_CLOEXEC);
 	if (newns < 0)
 		goto errout;
 
+	if (fstat(newns, &st) < 0 || st.st_ino != mntns_ino) {
+		nsinfo__clear_need_setns(nsi);
+		goto errout;
+	}
+
 	if (setns(newns, CLONE_NEWNS) < 0)
 		goto errout;
 
@@ -407,17 +489,11 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 
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
@@ -426,6 +502,11 @@ void nsinfo__mountns_exit(struct nscookie *nc)
 		close(nc->newns);
 		nc->newns = -1;
 	}
+
+	if (nc->oldcwd) {
+		WARN_ON_ONCE(chdir(nc->oldcwd));
+		zfree(&nc->oldcwd);
+	}
 }
 
 char *nsinfo__realpath(const char *path, struct nsinfo *nsi)
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 42dcca13b002f153..7bba217aa3fde3d7 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -37,7 +37,9 @@ DECLARE_RC_STRUCT(nsinfo) {
 	pid_t			tid;
 	pid_t			tgid;
 	pid_t			nstgid;
+	ino_t			mntns_ino;
 	bool			inited;
+	bool			exited;
 	bool			need_setns;
 	bool			in_pidns;
 	char			*mntns_path;
@@ -60,6 +62,8 @@ void nsinfo__put(struct nsinfo *nsi);
 
 bool nsinfo__need_setns(const struct nsinfo *nsi);
 void nsinfo__clear_need_setns(struct nsinfo *nsi);
+void nsinfo__set_exited(struct nsinfo *nsi);
+bool nsinfo__check_proc(struct nsinfo *nsi);
 pid_t nsinfo__tgid(const struct nsinfo  *nsi);
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
 pid_t nsinfo__pid(const struct nsinfo  *nsi);
-- 
2.56.0.611.g1030f0b940-goog

