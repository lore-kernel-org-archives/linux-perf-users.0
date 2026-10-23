Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739505;
	b=h+gkocyAx8vhut+L4O+GkRYDPap2ieaFU7iyNs3lfK6JvoahNUv7fE+Hv1Rb/CucVSYn
	 6K48tUg5GzwGH90kvFkDxTkF142MERZIBFtqQujEsZL5Hf/XAKO+9OI1JYHKbDzSzBwdd
	 9kwwUF8wLNYUelqEVOLZ4RWmoKnARvUtRSZZvNtJx9pH8VtUo3jneZ9QYts/GfzGxmVrN
	 7BNg5uwaFMKYdQfT673Nj3Gr5TXemJavCH1e8HCHRPX/0Makr0SpaGAy/U+UNLgee16ky
	 jn4UtNiBQRg/R1ZibZjDULZoI4WECJl2IXs5MoEYcF1qBwEIYTUADXLVYruJVRBd6JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739505;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IwWZD9sHUSq7P87pCQy1Wdh+8Jv19KUXjSMxjy9Umy0=;
	b=Wjn5oMc5qj/qkXlNXuMqcVFTspJF9ucl/AAZKjmsnSQtTjQDiFySWT9AynRYc58nfW6G
	 zUMSwXxogg1jpOpx4QiGATTTbnhy51mpfFrza19nZyGyyx0J37CghVZ3OHMSjI1dIWpcy
	 MezKMJ6Q20KUohpO6iB6I+S0JTVbZVCAPFXPBr403BAiQqoZeJDzgN//C6A6uBQqoVIky
	 C8m/g4bu6uNLMkSMMG+eWvBcRosyGq0RfxsTG6WW8jYgfwtiRNuQpIgyY476i+YUAQgnR
	 lnvOJ8blh72G7wdi7NbVXWhVdnJGh4vd+6BYMr7EloHVuVIBibQnLt3W4fMiRZ37ksA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNwn5ZdL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76148606A323;
	Fri, 23 Oct 2026 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNwn5ZdL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C7F1F031E0;
	Fri, 23 Oct 2026 07:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792739505;
	bh=IwWZD9sHUSq7P87pCQy1Wdh+8Jv19KUXjSMxjy9Umy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MNwn5ZdLACJ3UEgzURI4TKXeM6yLpCriDy0fxpnTXfEVfQeV2n4kXFncdQARBcupI
	 x7Wwq5gJKZslwbolFSadwQL4E2kO7ZE5vGmyuVTLtcFFEB3+wWIAo2pXu01vnR7K/y
	 lOB+cyEuq6kN/XNSIG18kH+QHv9POGALrhJLZWzmO9k11YsXMRp28ZdIwm8WPcy1Yx
	 Y0Dw5ENBxkMVP3ujGzKxsVPLRNHZmFXVkLxnWp68UxOqC6op87cHiMxsRydIc9Tull
	 ZTC60PJqFYvpKb+tXz1QRTUsHCZzmtG93HY8in6lj7C+FoCH6aQQW1d+3shqBqrTGC
	 S3H1OK8L6wpcA==
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
Subject: [PATCH v1 04/11] perf tools: Defer /proc lookup until nsinfo is used
Date: Fri, 23 Oct 2026 00:11:34 -0700
Message-ID: <20261023071141.134149-5-namhyung@kernel.org>
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

Do not read /proc/<pid>/task/<tid>/ eagerly in nsinfo__new_thread().
Instead, initialize struct nsinfo on demand via nsinfo__ensure_init()
when namespace information is queried or entered.

Also reset the initialization state on exec and PERF_RECORD_NAMESPACES
events so namespace changes are picked up.

Assisted-by: LLM
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/namespaces.c | 46 ++++++++++++++++++++++++++++--------
 tools/perf/util/namespaces.h |  2 ++
 tools/perf/util/thread.c     |  4 ++++
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index f426eba04d6ef449..843d075d30409029 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -103,6 +103,11 @@ int nsinfo__init(struct nsinfo *nsi)
 	struct stat new_stat;
 	int rv = -1;
 
+	if (!nsi)
+		return -1;
+
+	RC_CHK_ACCESS(nsi)->inited = true;
+
 	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
 		return rv;
 
@@ -140,6 +145,12 @@ int nsinfo__init(struct nsinfo *nsi)
 	return rv;
 }
 
+static void nsinfo__ensure_init(struct nsinfo *nsi)
+{
+	if (nsi && !RC_CHK_ACCESS(nsi)->inited)
+		nsinfo__init(nsi);
+}
+
 static struct nsinfo *nsinfo__alloc(void)
 {
 	struct nsinfo *res;
@@ -167,15 +178,6 @@ struct nsinfo *nsinfo__new_thread(pid_t pid, pid_t tid)
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
 
@@ -196,6 +198,8 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	if (nsi == NULL)
 		return NULL;
 
+	nsinfo__ensure_init((struct nsinfo *)nsi);
+
 	nnsi = nsinfo__alloc();
 	if (!nnsi)
 		return NULL;
@@ -204,7 +208,8 @@ struct nsinfo *nsinfo__copy(const struct nsinfo *nsi)
 	RC_CHK_ACCESS(nnsi)->tid = nsinfo__tid(nsi);
 	RC_CHK_ACCESS(nnsi)->tgid = nsinfo__tgid(nsi);
 	RC_CHK_ACCESS(nnsi)->nstgid = nsinfo__nstgid(nsi);
-	RC_CHK_ACCESS(nnsi)->need_setns = nsinfo__need_setns(nsi);
+	RC_CHK_ACCESS(nnsi)->inited = RC_CHK_ACCESS(nsi)->inited;
+	RC_CHK_ACCESS(nnsi)->need_setns = RC_CHK_ACCESS(nsi)->need_setns;
 	RC_CHK_ACCESS(nnsi)->in_pidns = nsinfo__in_pidns(nsi);
 	if (nsinfo__mntns_path(nsi)) {
 		RC_CHK_ACCESS(nnsi)->mntns_path = strdup(nsinfo__mntns_path(nsi));
@@ -251,21 +256,41 @@ void nsinfo__put(struct nsinfo *nsi)
 
 bool nsinfo__need_setns(const struct nsinfo *nsi)
 {
+	if (!nsi)
+		return false;
+
+	nsinfo__ensure_init((struct nsinfo *)nsi);
 	return RC_CHK_ACCESS(nsi)->need_setns;
 }
 
 void nsinfo__clear_need_setns(struct nsinfo *nsi)
 {
+	if (!nsi)
+		return;
+
+	RC_CHK_ACCESS(nsi)->inited = true;
 	RC_CHK_ACCESS(nsi)->need_setns = false;
+	zfree(&RC_CHK_ACCESS(nsi)->mntns_path);
+}
+
+void nsinfo__reset_init(struct nsinfo *nsi)
+{
+	if (!nsi)
+		return;
+
+	nsinfo__clear_need_setns(nsi);
+	RC_CHK_ACCESS(nsi)->inited = false;
 }
 
 pid_t nsinfo__tgid(const struct nsinfo  *nsi)
 {
+	nsinfo__ensure_init((struct nsinfo *)nsi);
 	return RC_CHK_ACCESS(nsi)->tgid;
 }
 
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi)
 {
+	nsinfo__ensure_init((struct nsinfo *)nsi);
 	return RC_CHK_ACCESS(nsi)->nstgid;
 }
 
@@ -281,6 +306,7 @@ pid_t nsinfo__tid(const struct nsinfo  *nsi)
 
 bool nsinfo__in_pidns(const struct nsinfo *nsi)
 {
+	nsinfo__ensure_init((struct nsinfo *)nsi);
 	return RC_CHK_ACCESS(nsi)->in_pidns;
 }
 
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index ea645954944de4be..77fe6f0eaf2f0618 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -35,6 +35,7 @@ DECLARE_RC_STRUCT(nsinfo) {
 	pid_t			tid;
 	pid_t			tgid;
 	pid_t			nstgid;
+	bool			inited;
 	bool			need_setns;
 	bool			in_pidns;
 	char			*mntns_path;
@@ -57,6 +58,7 @@ void nsinfo__put(struct nsinfo *nsi);
 
 bool nsinfo__need_setns(const struct nsinfo *nsi);
 void nsinfo__clear_need_setns(struct nsinfo *nsi);
+void nsinfo__reset_init(struct nsinfo *nsi);
 pid_t nsinfo__tgid(const struct nsinfo  *nsi);
 pid_t nsinfo__nstgid(const struct nsinfo  *nsi);
 pid_t nsinfo__pid(const struct nsinfo  *nsi);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index d12eb6bc63313b00..377c39ec624bb7bb 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -199,6 +199,8 @@ int thread__set_namespaces(struct thread *thread, u64 timestamp,
 	down_write(thread__namespaces_lock(thread));
 	ret = __thread__set_namespaces(thread, timestamp, event);
 	up_write(thread__namespaces_lock(thread));
+	if (!ret && event)
+		nsinfo__reset_init(thread__nsinfo(thread));
 	return ret;
 }
 
@@ -282,6 +284,8 @@ int __thread__set_comm(struct thread *thread, const char *str, u64 timestamp,
 	down_write(thread__comm_lock(thread));
 	ret = ____thread__set_comm(thread, str, timestamp, exec);
 	up_write(thread__comm_lock(thread));
+	if (!ret && exec)
+		nsinfo__reset_init(thread__nsinfo(thread));
 	return ret;
 }
 
-- 
2.56.0.257.gf7497c7d27-goog

