Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739506;
	b=JIe7UN9fiZZ+8YCwviezWrTR8u3z+OYNqpNQa9iw8W89/Sqxdi6lx0v6R64kikxnObTk
	 /7WTbWGcG7l9lIgzT4nxg7O3PSXsOcw++mxd/40MC/UmLL1I7wQZjt2DFxHMXwGD/v9iW
	 jdzE7bTtp7OYEx2OG0TGiAyI0Ovacm0h55QCkEcKbR79j5pNuncBKWFc7G7AOZVgA9b4G
	 kWhdUkmz/FwSvwbE45nV137EoCry2yTYU0SnGEDYjGwWGis/YXPkaJPAz2TGPW5iaquJI
	 mXaAjT6C8nObnVY08Z8FEEEuiQIInIklBLklUVx2MBvDqeiFgIQqNTtbmfJq6xMSUWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739506;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NqJl+jTESTSoeRzH1cw0UFps42U8wHjB15kWvnxObb0=;
	b=33M4bXvMs0D7buNsOJvPSDv1aPp5fwoPZbdCzg9Qnv4E0c01ZFf2t7sFn/baW9qnO56m
	 gKaA/md2O0s6xujfgCrpl0JWrojyIKil0D9fY48/v5Smgxll2GtQFpy8T+pz6W+tDUcb5
	 gK4ZPHUzoe6cKxTdQEUPxufNaqSB1nAlND8z0P1GKrru/lo4AOfC1dzbqXrkW6PqUOHd7
	 rO5C4c5/Nxc0oiYRXC1oKcfrEXqQWmccO0tsQ776fmsljV/TjxXLTqEfqopUwZTJbW0h4
	 Rw5VXpQkyKhyAU6Ea9gzustfv0xExLijXSet3V4Xfwuxd8pFctfEXSaIjpWt73/5Biw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmFz47qi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF531606A330;
	Fri, 23 Oct 2026 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bmFz47qi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829C41F01829;
	Fri, 23 Oct 2026 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792739505;
	bh=NqJl+jTESTSoeRzH1cw0UFps42U8wHjB15kWvnxObb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bmFz47qiz/HhAGEDkWe066VabCAoyY95F/wDZ4lq0GmFZqHC+fyo7fw9RPz+EPxIK
	 9mXnS7R7qBlyQNiQRwkj1cyrFBBKgDv/1DJlQ3II4FRU9bIxlxvPQHkBTHO+AGvN0k
	 HLKIGWQJ7uasM4Jo5GeTWfWMS8M1gW/pnC56kYp1hKtZmhLEuqnO0Xoy7LlqnX/CPp
	 wyZqqxBaF78i3DDF1ftFXr+pdnJNsh7lzrxMmPD8ZljFDMDFOdo5vim2RrS974D6jF
	 seE/e+HmfpSX5rbIGqjySAlWHohbiiVVwega/H7IJn4RpYs9qzRmz35tOub+5xKCKX
	 9btHG+O16Myxw==
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
Subject: [PATCH v1 05/11] perf tools: Verify thread status and mount namespace inode
Date: Fri, 23 Oct 2026 00:11:35 -0700
Message-ID: <20261023071141.134149-6-namhyung@kernel.org>
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

Verify /proc/<pid>/task/<tid>/status exists and has Tgid == pid before
reading or entering a thread's namespaces to guard against PID/TID
recycling.

Also record the mount namespace inode (mntns_ino) during initialization
and verify via fstat() that the opened namespace file descriptor still
refers to the same mount namespace.

Assisted-by: LLM
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/namespaces.c | 120 +++++++++++++++++++++++++----------
 tools/perf/util/namespaces.h |   4 ++
 2 files changed, 91 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 843d075d30409029..bb119a6cc6064d89 100644
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
@@ -91,7 +93,7 @@ static int nsinfo__get_nspid(pid_t *tgid, pid_t *nstgid, bool *in_pidns, const c
 
 	fclose(f);
 	free(statln);
-	return 0;
+	return got_tgid ? 0 : -1;
 }
 
 int nsinfo__init(struct nsinfo *nsi)
@@ -103,17 +105,34 @@ int nsinfo__init(struct nsinfo *nsi)
 	struct stat new_stat;
 	int rv = -1;
 
-	if (!nsi)
+	if (!nsi || RC_CHK_ACCESS(nsi)->exited)
 		return -1;
 
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
+	rv = nsinfo__get_nspid(&RC_CHK_ACCESS(nsi)->tgid, &RC_CHK_ACCESS(nsi)->nstgid,
+			       &RC_CHK_ACCESS(nsi)->in_pidns, spath);
+	if (rv < 0 || RC_CHK_ACCESS(nsi)->tgid != nsinfo__pid(nsi)) {
+		nsinfo__set_exited(nsi);
+		rv = -1;
+		goto out;
+	}
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
@@ -127,19 +146,10 @@ int nsinfo__init(struct nsinfo *nsi)
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
@@ -147,7 +157,7 @@ int nsinfo__init(struct nsinfo *nsi)
 
 static void nsinfo__ensure_init(struct nsinfo *nsi)
 {
-	if (nsi && !RC_CHK_ACCESS(nsi)->inited)
+	if (nsi && !RC_CHK_ACCESS(nsi)->inited && !RC_CHK_ACCESS(nsi)->exited)
 		nsinfo__init(nsi);
 }
 
@@ -208,7 +218,9 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	RC_CHK_ACCESS(nnsi)->tid = nsinfo__tid(nsi);
 	RC_CHK_ACCESS(nnsi)->tgid = nsinfo__tgid(nsi);
 	RC_CHK_ACCESS(nnsi)->nstgid = nsinfo__nstgid(nsi);
+	RC_CHK_ACCESS(nnsi)->mntns_ino = RC_CHK_ACCESS(nsi)->mntns_ino;
 	RC_CHK_ACCESS(nnsi)->inited = RC_CHK_ACCESS(nsi)->inited;
+	RC_CHK_ACCESS(nnsi)->exited = RC_CHK_ACCESS(nsi)->exited;
 	RC_CHK_ACCESS(nnsi)->need_setns = RC_CHK_ACCESS(nsi)->need_setns;
 	RC_CHK_ACCESS(nnsi)->in_pidns = nsinfo__in_pidns(nsi);
 	if (nsinfo__mntns_path(nsi)) {
@@ -260,7 +272,7 @@ bool nsinfo__need_setns(const struct nsinfo *nsi)
 		return false;
 
 	nsinfo__ensure_init((struct nsinfo *)nsi);
-	return RC_CHK_ACCESS(nsi)->need_setns;
+	return !RC_CHK_ACCESS(nsi)->exited && RC_CHK_ACCESS(nsi)->need_setns;
 }
 
 void nsinfo__clear_need_setns(struct nsinfo *nsi)
@@ -273,15 +285,44 @@ void nsinfo__clear_need_setns(struct nsinfo *nsi)
 	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
 }
 
-void nsinfo__reset_init(struct nsinfo *nsi)
+void nsinfo__set_exited(struct nsinfo *nsi)
 {
 	if (!nsi)
 		return;
 
+	RC_CHK_ACCESS(nsi)->exited = true;
+	nsinfo__clear_need_setns(nsi);
+}
+
+void nsinfo__reset_init(struct nsinfo *nsi)
+{
+	if (!nsi || RC_CHK_ACCESS(nsi)->exited)
+		return;
+
 	nsinfo__clear_need_setns(nsi);
 	RC_CHK_ACCESS(nsi)->inited = false;
 }
 
+bool nsinfo__check_proc(struct nsinfo *nsi)
+{
+	char spath[64];
+	pid_t tgid = 0, nstgid = 0;
+	bool in_pidns = false;
+
+	if (!nsi || RC_CHK_ACCESS(nsi)->exited)
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
 pid_t nsinfo__tgid(const struct nsinfo  *nsi)
 {
 	nsinfo__ensure_init((struct nsinfo *)nsi);
@@ -328,10 +369,14 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 
 	nc->oldns = -1;
 	nc->newns = -1;
+	nc->oldcwd = NULL;
 
 	if (!nsi || !nsinfo__need_setns(nsi))
 		return;
 
+	if (!nsinfo__check_proc(nsi))
+		return;
+
 	if (!getcwd(curpath, sizeof(curpath)))
 		return;
 
@@ -339,16 +384,26 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (!oldcwd)
 		return;
 
-	oldns = open("/proc/self/ns/mnt", O_RDONLY);
-	if (oldns < 0)
-		goto errout;
+	if (RC_CHK_ACCESS(nsi)->need_setns) {
+		struct stat st;
+
+		oldns = open("/proc/self/ns/mnt", O_RDONLY | O_CLOEXEC);
+		if (oldns < 0)
+			goto errout;
 
-	newns = open(nsinfo__mntns_path(nsi), O_RDONLY);
-	if (newns < 0)
-		goto errout;
+		newns = open(nsinfo__mntns_path(nsi), O_RDONLY | O_CLOEXEC);
+		if (newns < 0)
+			goto errout;
 
-	if (setns(newns, CLONE_NEWNS) < 0)
-		goto errout;
+		if (fstat(newns, &st) < 0 ||
+		    st.st_ino != RC_CHK_ACCESS(nsi)->mntns_ino) {
+			nsinfo__set_exited(nsi);
+			goto errout;
+		}
+
+		if (setns(newns, CLONE_NEWNS) < 0)
+			goto errout;
+	}
 
 	nc->oldcwd = oldcwd;
 	nc->oldns = oldns;
@@ -365,17 +420,11 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 
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
@@ -384,6 +433,11 @@ void nsinfo__mountns_exit(struct nscookie *nc)
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
index 77fe6f0eaf2f0618..165e9c9994461595 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -35,7 +35,9 @@ DECLARE_RC_STRUCT(nsinfo) {
 	pid_t			tid;
 	pid_t			tgid;
 	pid_t			nstgid;
+	ino_t			mntns_ino;
 	bool			inited;
+	bool			exited;
 	bool			need_setns;
 	bool			in_pidns;
 	char			*mntns_path;
@@ -58,7 +60,9 @@ void nsinfo__put(struct nsinfo *nsi);
 
 bool nsinfo__need_setns(const struct nsinfo *nsi);
 void nsinfo__clear_need_setns(struct nsinfo *nsi);
+void nsinfo__set_exited(struct nsinfo *nsi);
 void nsinfo__reset_init(struct nsinfo *nsi);
+bool nsinfo__check_proc(struct nsinfo *nsi);
 pid_t nsinfo__tgid(const struct nsinfo  *nsi);
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
 pid_t nsinfo__pid(const struct nsinfo  *nsi);
-- 
2.56.0.257.gf7497c7d27-goog

