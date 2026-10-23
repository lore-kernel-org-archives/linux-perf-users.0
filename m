Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739506;
	b=q0ICKbaLOIdGWm1LphtE317yAylmkdZZ/XSrC8zsnU2MS6k9BGTTiWDf6ikmlPzc20I1
	 3EURyX0S+YMK07asWPe+QRIn1BBAMhBR21/KVjhNbYxO98BqG81E8rROUNFm3S1/pOALf
	 CxXNOPLF0ogTKoPZguPn49AiU2+Pr4h46rzRzyspcG+nL5D5HP4YN8JHOvK4eJPyNd+3N
	 ZNlAvmYxhsUBIs6LjkA5ROzEa2lz91MBlrjXIDvEvkLEPNLgl+44bzR3Olr4F0XC75o4Y
	 D6AMNK5QRTAp3Pthomcj5H/SToxMxOGa+CRnmqpXLAnz/S2Rv6wDXaXhl32dqSJOr+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739506;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CBhFesInQo6AwgVP391t6H+rj58+AqpJOgaeLasaGEM=;
	b=Zq3AJ/QwLVwVacr9wHYZi2+BNRMV0bYASqaYXuu9SqyrPL7IhFFSH9pb5TyyNSMsBSck
	 SIaHjS130HxUiiR7PAyLWTJ6lSJ6i7No1EDZ1MLacHNVR7pccP+v0ISyIcriyGjZ4hqpI
	 RZJRX5L/Ja3pS5jVhl9R40Km1m1aizjltAGqc5sXMM2iJ3/pjJBLeWUWL76JRpk/42esL
	 vhVzyqTGAlr+EqWZiSMAmKzsloYLJ9lH89umYdc8/48K5ZHE28rry6toeLWOkgI/91kes
	 0qfRGK3qhYqPdrcoY5piySUVemhRp9JBkJmwF1PEIxHo2LeYkFgeKs81yJULzkNKMGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kd6drMG1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E2606A321;
	Fri, 23 Oct 2026 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kd6drMG1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D161F01829;
	Fri, 23 Oct 2026 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792739506;
	bh=CBhFesInQo6AwgVP391t6H+rj58+AqpJOgaeLasaGEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kd6drMG1+lUm0b0BltI5UVfzzJwEIFDKEt5Zj2BrYzkDPlWROeoAxlfSchjLsvJey
	 +WFF/kVXc6cdSq31ZD+mtdkAdJy/v9Yv0mN/zXvzT+3/Dz3fS6Jx2YL+LcWs0mXN1e
	 eM/UqEoXDvT6KrZwdk8lRA6nDpLbo1nUtjEPTpxYHZr8w7Qx0osonFrLKh2xQRPLNb
	 79aaEg7eub58Em4sgpSOR8gnaS2wuStg4QV/29vnhqEDm0B27SRj1zvDojQLLjB3iZ
	 eJvUMP+b9lQtJ0MbDMMRM7mtwZOZCxUSI4TX2TOPLe4wWQeXVjKeIHmQHskJU46WKu
	 swe1H3Hlz7rww==
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
Subject: [PATCH v1 07/11] perf tools: Handle chroot inside nsinfo__mountns_enter()
Date: Fri, 23 Oct 2026 00:11:37 -0700
Message-ID: <20261023071141.134149-8-namhyung@kernel.org>
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

Read /proc/<pid>/task/<tid>/root in nsinfo__init() and enter/exit the
chroot directory alongside the mount namespace inside
nsinfo__mountns_enter() and nsinfo__mountns_exit().

Assisted-by: LLM
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/namespaces.c | 60 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/namespaces.h |  3 ++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index bb119a6cc6064d89..1ec6b1ed4db23109 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -100,10 +100,12 @@ int nsinfo__init(struct nsinfo *nsi)
 {
 	char oldns[PATH_MAX];
 	char spath[PATH_MAX];
+	char rpath[64];
 	char *newns = NULL;
 	struct stat old_stat;
 	struct stat new_stat;
 	int rv = -1;
+	ssize_t ret;
 
 	if (!nsi || RC_CHK_ACCESS(nsi)->exited)
 		return -1;
@@ -150,6 +152,19 @@ int nsinfo__init(struct nsinfo *nsi)
 		newns = NULL;
 	}
 
+	/* Check if the task is in a chroot directory. */
+	scnprintf(rpath, sizeof(rpath), "/proc/%d/task/%d/root",
+		  nsinfo__pid(nsi), nsinfo__tid(nsi));
+	ret = readlink(rpath, spath, sizeof(spath) - 1);
+	if (ret > 0) {
+		spath[ret] = '\0';
+		if (strcmp(spath, "/") && !strstr(spath, "(deleted)")) {
+			RC_CHK_ACCESS(nsi)->chroot = strdup(spath);
+			if (RC_CHK_ACCESS(nsi)->chroot)
+				RC_CHK_ACCESS(nsi)->in_chroot = true;
+		}
+	}
+
 out:
 	free(newns);
 	return rv;
@@ -201,6 +216,11 @@ static const char *nsinfo__mntns_path(const struct nsinfo *nsi)
 	return RC_CHK_ACCESS(nsi)->mntns_path;
 }
 
+static const char *nsinfo__chroot(const struct nsinfo *nsi)
+{
+	return RC_CHK_ACCESS(nsi)->chroot;
+}
+
 struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 {
 	struct nsinfo *nnsi;
@@ -222,6 +242,7 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	RC_CHK_ACCESS(nnsi)->inited = RC_CHK_ACCESS(nsi)->inited;
 	RC_CHK_ACCESS(nnsi)->exited = RC_CHK_ACCESS(nsi)->exited;
 	RC_CHK_ACCESS(nnsi)->need_setns = RC_CHK_ACCESS(nsi)->need_setns;
+	RC_CHK_ACCESS(nnsi)->in_chroot = RC_CHK_ACCESS(nsi)->in_chroot;
 	RC_CHK_ACCESS(nnsi)->in_pidns = nsinfo__in_pidns(nsi);
 	if (nsinfo__mntns_path(nsi)) {
 		RC_CHK_ACCESS(nnsi)->mntns_path = strdup(nsinfo__mntns_path(nsi));
@@ -230,6 +251,13 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 			return NULL;
 		}
 	}
+	if (nsinfo__chroot(nsi)) {
+		RC_CHK_ACCESS(nnsi)->chroot = strdup(nsinfo__chroot(nsi));
+		if (!RC_CHK_ACCESS(nnsi)->chroot) {
+			nsinfo__put(nnsi);
+			return NULL;
+		}
+	}
 
 	return nnsi;
 }
@@ -244,6 +272,7 @@ static void nsinfo__delete(struct nsinfo *nsi)
 	if (nsi) {
 		WARN_ONCE(refcount_read(nsinfo__refcnt(nsi)) != 0, "nsinfo refcnt unbalanced\n");
 		zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+		zfree(&RC_CHK_ACCESS(nsi)->chroot);
 		RC_CHK_FREE(nsi);
 	}
 }
@@ -272,7 +301,8 @@ bool nsinfo__need_setns(const struct nsinfo *nsi)
 		return false;
 
 	nsinfo__ensure_init((struct nsinfo *)nsi);
-	return !RC_CHK_ACCESS(nsi)->exited && RC_CHK_ACCESS(nsi)->need_setns;
+	return !RC_CHK_ACCESS(nsi)->exited &&
+	       (RC_CHK_ACCESS(nsi)->need_setns || RC_CHK_ACCESS(nsi)->in_chroot);
 }
 
 void nsinfo__clear_need_setns(struct nsinfo *nsi)
@@ -282,7 +312,9 @@ void nsinfo__clear_need_setns(struct nsinfo *nsi)
 
 	RC_CHK_ACCESS(nsi)->inited = true;
 	RC_CHK_ACCESS(nsi)->need_setns = false;
+	RC_CHK_ACCESS(nsi)->in_chroot = false;
 	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+	zfree(&RC_CHK_ACCESS(nsi)->chroot);
 }
 
 void nsinfo__set_exited(struct nsinfo *nsi)
@@ -362,6 +394,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	char curpath[PATH_MAX];
 	int oldns = -1;
 	int newns = -1;
+	int oldroot = -1;
 	char *oldcwd = NULL;
 
 	if (nc == NULL)
@@ -369,6 +402,7 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 
 	nc->oldns = -1;
 	nc->newns = -1;
+	nc->oldroot = -1;
 	nc->oldcwd = NULL;
 
 	if (!nsi || !nsinfo__need_setns(nsi))
@@ -405,13 +439,30 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 			goto errout;
 	}
 
+	if (RC_CHK_ACCESS(nsi)->in_chroot) {
+		oldroot = open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (oldroot < 0)
+			goto errout_setns;
+
+		if (chroot(nsinfo__chroot(nsi)) < 0)
+			goto errout_setns;
+	}
+
 	nc->oldcwd = oldcwd;
 	nc->oldns = oldns;
 	nc->newns = newns;
+	nc->oldroot = oldroot;
 	return;
 
+errout_setns:
+	if (oldns > -1) {
+		setns(oldns, CLONE_NEWNS);
+		WARN_ON_ONCE(chdir(oldcwd));
+	}
 errout:
 	free(oldcwd);
+	if (oldroot > -1)
+		close(oldroot);
 	if (oldns > -1)
 		close(oldns);
 	if (newns > -1)
@@ -423,6 +474,13 @@ void nsinfo__mountns_exit(struct nscookie *nc)
 	if (nc == NULL || !nc->oldcwd)
 		return;
 
+	if (nc->oldroot > -1) {
+		WARN_ON_ONCE(fchdir(nc->oldroot));
+		WARN_ON_ONCE(chroot("."));
+		close(nc->oldroot);
+		nc->oldroot = -1;
+	}
+
 	if (nc->oldns > -1) {
 		setns(nc->oldns, CLONE_NEWNS);
 		close(nc->oldns);
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 165e9c9994461595..640ce537295a88e5 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -39,14 +39,17 @@ DECLARE_RC_STRUCT(nsinfo) {
 	bool			inited;
 	bool			exited;
 	bool			need_setns;
+	bool			in_chroot;
 	bool			in_pidns;
 	char			*mntns_path;
+	char			*chroot;
 	refcount_t		refcnt;
 };
 
 struct nscookie {
 	int			oldns;
 	int			newns;
+	int			oldroot;
 	char			*oldcwd;
 };
 
-- 
2.56.0.257.gf7497c7d27-goog

