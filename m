Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476029;
	b=gjjfg5YU14gjopVJA+3kIXZGkH2o6w96r5TUFITN6kqHMu/k0Naf/rJek0zoMjS0VB6L
	 UCB7lTtbRlMT6vC4XtcUY+0icX1s27sTpi8rXl8GuDX7Dy5F4EJeW+YoEhJkJpqR50ipI
	 26crZse+YqlvksiY98NLqSE5j2gMBfSCW68lZH6QD1Wsh7k6CfxrTH0iCWe/3unz+bpb/
	 3xge0/i7msxZYMdrk1fbSoDxfjUtlUcizuNbovmFGH6FD/KR4tmXy4B1/ZgXhGjF01ZKR
	 L1y6SE9MEZT4Ptx7qUwYzWqo+dDT7TPVtMHxn/iKrw8cic6ccLVnckCtKE/NMkt4+tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476029;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2nV6Pwe4KyMCUzXZTz3btMM6HejHFNSIy8FvzNgAtOU=;
	b=YtNBtLeuswg/FE62ZzruLi+iYa317XN7JWQS6NjpmYsNpGKSGXvHLG3UCptbFpqvjJ29
	 OtHR5xCSbJkOJXkIe/dKrQ3Y3IQwd7m3MXQ7dLpYx5p2noMTUmKTVgH0r1DqOt9bDYuUH
	 AjH+OJsCtS0BkaYn0DQzFbhe5yzNxhSR0Q0pgezxB5w+R5C4hZrT9dzzOw1k14JTeVZsb
	 OJWq+MC1tNqO6d+EPVeoL5ZhPn+0PrBjfYngG/TlUESgYHHFVphmsMa0ArNBZodhgTM83
	 xAbpPxlUZGdkkFuSBNe8FfbqdRFEK1k2y39t2b+pU7q9ndc/NgrtTMNFtcd/rqEU/Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luq+aUNS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C61606A337;
	Mon, 23 Nov 2026 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luq+aUNS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D501F000C0;
	Mon, 23 Nov 2026 23:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795476028;
	bh=2nV6Pwe4KyMCUzXZTz3btMM6HejHFNSIy8FvzNgAtOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=luq+aUNS75fy8CCF49Bh3wKna+7+0nOgggQxbViLSiaUsKDzNVFUZPWyUNeueQHH9
	 qurufk2YL8nbtfaAnaryUvTmgkCxjaNZVprg2gyEtvRP4i5jCZqFden2Y3TDRXJrDk
	 iuE5FVq45Ur+2ST1a46u3IwkHSpDIDitPRzQuqeqxVr2/ZuIJKnkueE0rhyVXxrH4f
	 wgiSkLKAWfpSINFn2kGaPTZYGTqsI4hBcbx7ZxvnaonZ8VqGjPcZDOZ+A+pyOlRU1X
	 9CfHJYFba26gnrVFme9rC/KEz3fL9C4YvlwOfdswWgsxaNkCwH4DkA7dJ4iXNj/9Mx
	 ThnOvFUD+TBhw==
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
Subject: [PATCH v3 03/11] perf tools: Add nsinfo__new_thread() to track tid
Date: Mon, 23 Nov 2026 15:20:17 -0800
Message-ID: <20261123232025.1406560-4-namhyung@kernel.org>
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

Record the thread ID (tid) in struct nsinfo via nsinfo__new_thread() and
access /proc/<pid>/task/<tid>/ status and ns/mnt paths instead of only
/proc/<pid>/.  Also recreate thread->nsinfo when the pid of the thread
is updated.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c    |  3 +++
 tools/perf/util/namespaces.c | 22 ++++++++++++++++++----
 tools/perf/util/namespaces.h |  3 +++
 tools/perf/util/thread.c     |  2 +-
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c206c26bd62163e..62f3ee8488548ef6 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -19,6 +19,7 @@
 #include "branch.h"
 #include "mem-events.h"
 #include "mem-info.h"
+#include "namespaces.h"
 #include "path.h"
 #include "srcline.h"
 #include "symbol.h"
@@ -517,6 +518,8 @@ static void machine__update_thread_pid(struct machine *machine,
 		return;
 
 	thread__set_pid(th, pid);
+	nsinfo__zput(RC_CHK_ACCESS(th)->nsinfo);
+	RC_CHK_ACCESS(th)->nsinfo = nsinfo__new_thread(pid, thread__tid(th));
 
 	if (thread__pid(th) == thread__tid(th))
 		return;
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index 01502570b32d02ab..f426eba04d6ef449 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -106,7 +106,8 @@ int nsinfo__init(struct nsinfo *nsi)
 	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
 		return rv;
 
-	if (asprintf(&newns, "/proc/%d/ns/mnt", nsinfo__pid(nsi)) == -1)
+	if (asprintf(&newns, "/proc/%d/task/%d/ns/mnt",
+		     nsinfo__pid(nsi), nsinfo__tid(nsi)) == -1)
 		return rv;
 
 	if (stat(oldns, &old_stat) < 0)
@@ -127,7 +128,8 @@ int nsinfo__init(struct nsinfo *nsi)
 	/* If we're dealing with a process that is in a different PID namespace,
 	 * attempt to work out the innermost tgid for the process.
 	 */
-	if (snprintf(spath, PATH_MAX, "/proc/%d/status", nsinfo__pid(nsi)) >= PATH_MAX)
+	if (snprintf(spath, PATH_MAX, "/proc/%d/task/%d/status",
+		     nsinfo__pid(nsi), nsinfo__tid(nsi)) >= PATH_MAX)
 		goto out;
 
 	rv = nsinfo__get_nspid(&RC_CHK_ACCESS(nsi)->tgid, &RC_CHK_ACCESS(nsi)->nstgid,
@@ -150,11 +152,11 @@ static struct nsinfo *nsinfo__alloc(void)
 	return res;
 }
 
-struct nsinfo *nsinfo__new(pid_t pid)
+struct nsinfo *nsinfo__new_thread(pid_t pid, pid_t tid)
 {
 	struct nsinfo *nsi;
 
-	if (pid == 0)
+	if (pid <= 0 || tid <= 0)
 		return NULL;
 
 	nsi = nsinfo__alloc();
@@ -162,6 +164,7 @@ struct nsinfo *nsinfo__new(pid_t pid)
 		return NULL;
 
 	RC_CHK_ACCESS(nsi)->pid = pid;
+	RC_CHK_ACCESS(nsi)->tid = tid;
 	RC_CHK_ACCESS(nsi)->tgid = pid;
 	RC_CHK_ACCESS(nsi)->nstgid = pid;
 	nsinfo__clear_need_setns(nsi);
@@ -176,6 +179,11 @@ struct nsinfo *nsinfo__new(pid_t pid)
 	return nsi;
 }
 
+struct nsinfo *nsinfo__new(pid_t pid)
+{
+	return nsinfo__new_thread(pid, pid);
+}
+
 static const char *nsinfo__mntns_path(const struct nsinfo *nsi)
 {
 	return RC_CHK_ACCESS(nsi)->mntns_path;
@@ -193,6 +201,7 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 		return NULL;
 
 	RC_CHK_ACCESS(nnsi)->pid = nsinfo__pid(nsi);
+	RC_CHK_ACCESS(nnsi)->tid = nsinfo__tid(nsi);
 	RC_CHK_ACCESS(nnsi)->tgid = nsinfo__tgid(nsi);
 	RC_CHK_ACCESS(nnsi)->nstgid = nsinfo__nstgid(nsi);
 	RC_CHK_ACCESS(nnsi)->need_setns = nsinfo__need_setns(nsi);
@@ -265,6 +274,11 @@ pid_t nsinfo__pid(const struct nsinfo  *nsi)
 	return RC_CHK_ACCESS(nsi)->pid;
 }
 
+pid_t nsinfo__tid(const struct nsinfo  *nsi)
+{
+	return RC_CHK_ACCESS(nsi)->tid;
+}
+
 bool nsinfo__in_pidns(const struct nsinfo *nsi)
 {
 	return RC_CHK_ACCESS(nsi)->in_pidns;
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index e95c79b80e27c8fc..ea645954944de4be 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -32,6 +32,7 @@ void namespaces__free(struct namespaces *namespaces);
 
 DECLARE_RC_STRUCT(nsinfo) {
 	pid_t			pid;
+	pid_t			tid;
 	pid_t			tgid;
 	pid_t			nstgid;
 	bool			need_setns;
@@ -48,6 +49,7 @@ struct nscookie {
 
 int nsinfo__init(struct nsinfo *nsi);
 struct nsinfo *nsinfo__new(pid_t pid);
+struct nsinfo *nsinfo__new_thread(pid_t pid, pid_t tid);
 struct nsinfo *nsinfo__copy(const struct nsinfo *nsi);
 
 struct nsinfo *nsinfo__get(struct nsinfo *nsi);
@@ -58,6 +60,7 @@ void nsinfo__clear_need_setns(struct nsinfo *nsi);
 pid_t nsinfo__tgid(const struct nsinfo  *nsi);
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
 pid_t nsinfo__pid(const struct nsinfo  *nsi);
+pid_t nsinfo__tid(const struct nsinfo  *nsi);
 bool nsinfo__in_pidns(const struct nsinfo  *nsi);
 void nsinfo__set_in_pidns(struct nsinfo *nsi);
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index af761b1fc5d57649..8d8427b561ddde11 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -71,7 +71,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		list_add(&comm->list, thread__comm_list(thread));
 		refcount_set(thread__refcnt(thread), 1);
 		/* Thread holds first ref to nsdata. */
-		RC_CHK_ACCESS(thread)->nsinfo = nsinfo__new(pid);
+		RC_CHK_ACCESS(thread)->nsinfo = nsinfo__new_thread(pid, tid);
 		srccode_state_init(thread__srccode_state(thread));
 	}
 
-- 
2.56.1.809.ga0b61035b5-goog

