Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E2299A82
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783206; cv=none; b=JO5mkCxkp+BtaFdFYT4PdXtv9M6bYffdihEh8nBZMqHyok7B7RSCfoBOOo25jGE2fNOurEwKz4VJvY2praKCQVBPbC2SsZvFrdf7Tw+A9sy/v5h16+oGTC+DcDeB7Tr5amlqN1/SDc7CI2toJqmB9NJMdo8Cw2CxYF0HdS2ONgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783206; c=relaxed/simple;
	bh=gLTE4DZC31stvfzFk0rJ0AhQQDaHhhhovurCRZcc4kE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sw2jQRj2YExLRqbAcAwvpBzXolPWkt2jFPdffbQU/BJmzdvor/AEnFfsw0VIbWfln+L641I0t1oT3D4qpVD1471JaMjICif5g+oVYf6F6QIR1lpKK+H8O2wJ2Q+gMIamyVndnDz+ouv0fsjNh63bh52F8n0iN6vvMfyAndQpqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWUh6LaF; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWUh6LaF"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381abcccbf4so273663a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 22:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784783204; x=1785388004; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wh3E9ADSLfM/RbLrnEzi8IbVmbhnH62MXBbll/5N1U=;
        b=lWUh6LaFhYF+xMI+D9W8cEaAuskNqxCNsCMEZDVWLi671/9Fnq6ayyXDtYKxO9uvtJ
         NXX4AGXLqh0ww9LZ9FeRBI1RkTKMXYa/G3Vn00jTUpLrXBuNdFJ71CpcGD8lTK12NdS9
         z8iyZ8gs3RLn4kbOBbppifYO8w4gg8ujcT+1uNWgmRDn+7kzyRk0VQgeN9jLgZEAn+fS
         VUeoKBxZz+SicWQ/osILbLiqH7GYZCxlhTknCrtLJSuu4jZXXtwkxSSz38xjPRaSbv/T
         ZO0+xYyf+zOLtWiOAZt9j/P9unZeSGBo4VOyWx7mihMT0FGrwDw7Oe54Mgw9q33M4vSq
         cODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783204; x=1785388004;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8wh3E9ADSLfM/RbLrnEzi8IbVmbhnH62MXBbll/5N1U=;
        b=kbl5tQwdYGDwXeA7DKkwLs9CWo/1OGJNnQ+l5dPZK00y44xlUG5BUJnQnsjc0VUZ4q
         mC8Ng8BX67sN0zwTTQG+uu/ryhPczuqBWSWmGpzUTND462O4t3GPWCjRs6gJ7vTfIefj
         NSeRvQsdDPo9JpN/AUhjxf8XfHpKrJ8I7iIq1dta7wnWoVo8tVqkkXGNAVrJjUk2fUUL
         3GvM9S6npXhejmf3+ljNsaCJST4gErK7vvB2CxGoFkwMtWAbFKamVetBaNdTnVf6vi7k
         fUIZRDW7u5mHdb/z0ydbDZlTu5HV/G3p6ouSpd5kITCogd5nOzT9ADuiYiCpPi3IkXJf
         xxuw==
X-Forwarded-Encrypted: i=1; AHgh+RoTvNkhjetxqqO5P5Qzy1MAPv5N/vciXEBczt6LFE53N+LJYnQXICtWK2I1CwCU/NYEq9lR3nMjpCSe0Khu9QIq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8pxj323rOS1dT+QMaKXXbxv2pTh4UtR5Cm4c2qaShUHsZXfkK
	sQT5VuHb2qeDvVfEo4BIY3RyMiHm0mkwW0+WD409+9qEcx/1Is7dtwDJC2h4oTZtpNxeizFX3b+
	+ob0BUMnVyQ==
X-Received: from dlxx25.prod.google.com ([2002:a05:7022:4099:b0:13c:e616:911a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b83:b0:38e:5e2:6dce
 with SMTP id 98e67ed59e1d1-38ec660b1f0mr1590154a91.39.1784783203503; Wed, 22
 Jul 2026 22:06:43 -0700 (PDT)
Date: Wed, 22 Jul 2026 22:06:40 -0700
In-Reply-To: <20260716074028.568999-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716074028.568999-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723050640.992865-1-irogers@google.com>
Subject: [PATCH v3] perf cap: Remove used_root parameter and simplify
 capability checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: abyssmystery@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Refactor perf_cap__capable() to completely remove the used_root out-parameter
as requested by the maintainer. Relying on an explicit used_root boolean
poisoned sequential capability checks (e.g. failing CAP_SYS_ADMIN checks
poisoning the flag for subsequent CAP_PERFMON evaluations for unprivileged
users) and created redundant complexity across check_ftrace_capable(),
symbol__read_kptr_restrict(), and perf_event_paranoid_check().

Streamline the capability API to perform a pure true/false boolean
evaluation. The function checks the Effective set using SYS_capget; if
the syscall is missing or fails on legacy kernels, it cleanly falls back
to checking EUID == 0. This perfectly preserves modern capability-aware host
sessions, guarantees transparent fallback for older kernels, and correctly
rejects privileged operations for containerized root processes that have
explicitly dropped their capability bounding and permitted sets.

Fixes: e25ebda78e23 ("perf cap: Tidy up and improve capability testing")
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c  | 13 +++----------
 tools/perf/util/bpf-filter.c | 22 +++++++++-------------
 tools/perf/util/cap.c        |  4 +---
 tools/perf/util/cap.h        |  3 +--
 tools/perf/util/symbol.c     |  3 +--
 tools/perf/util/util.c       | 12 +++---------
 6 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 9e4c5220d43c..f7126196b092 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -72,18 +72,11 @@ static void ftrace__workload_exec_failed_signal(int signo __maybe_unused,
 
 static bool check_ftrace_capable(void)
 {
-	bool used_root;
-
-	if (perf_cap__capable(CAP_PERFMON, &used_root))
-		return true;
-
-	if (!used_root && perf_cap__capable(CAP_SYS_ADMIN, &used_root))
+	if (perf_cap__capable(CAP_PERFMON) ||
+	    perf_cap__capable(CAP_SYS_ADMIN))
 		return true;
 
-	pr_err("ftrace only works for %s!\n",
-		used_root ? "root"
-			  : "users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
-		);
+	pr_err("ftrace only works for users with the CAP_PERFMON or CAP_SYS_ADMIN capability!\n");
 	return false;
 }
 
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 1a2e7b388d57..bcd81084e342 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -629,24 +629,20 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
 
 static bool check_bpf_filter_capable(void)
 {
-	bool used_root;
+	int fd;
 
-	if (perf_cap__capable(CAP_BPF, &used_root))
+	if (perf_cap__capable(CAP_BPF))
 		return true;
 
-	if (!used_root) {
-		/* Check if root already pinned the filter programs and maps */
-		int fd = get_pinned_fd("filters");
-
-		if (fd >= 0) {
-			close(fd);
-			return true;
-		}
+	/* Check if root already pinned the filter programs and maps */
+	fd = get_pinned_fd("filters");
+	if (fd >= 0) {
+		close(fd);
+		return true;
 	}
 
-	pr_err("Error: BPF filter only works for %s!\n"
-	       "\tPlease run 'perf record --setup-filter pin' as root first.\n",
-	       used_root ? "root" : "users with the CAP_BPF capability");
+	pr_err("Error: BPF filter only works for users with the CAP_BPF capability!\n"
+	       "\tPlease run 'perf record --setup-filter pin' as root first.\n");
 
 	return false;
 }
diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
index ac6d1d9a523d..272bd8255ff1 100644
--- a/tools/perf/util/cap.c
+++ b/tools/perf/util/cap.c
@@ -12,7 +12,7 @@
 
 #define MAX_LINUX_CAPABILITY_U32S _LINUX_CAPABILITY_U32S_3
 
-bool perf_cap__capable(int cap, bool *used_root)
+bool perf_cap__capable(int cap)
 {
 	struct __user_cap_header_struct header = {
 		.version = _LINUX_CAPABILITY_VERSION_3,
@@ -21,7 +21,6 @@ bool perf_cap__capable(int cap, bool *used_root)
 	struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S] = {};
 	__u32 cap_val;
 
-	*used_root = false;
 	while (syscall(SYS_capget, &header, &data[0]) == -1) {
 		/* Retry, first attempt has set the header.version correctly. */
 		if (errno == EINVAL && header.version != _LINUX_CAPABILITY_VERSION_3 &&
@@ -29,7 +28,6 @@ bool perf_cap__capable(int cap, bool *used_root)
 			continue;
 
 		pr_debug2("capget syscall failed (%m) fall back on root check\n");
-		*used_root = true;
 		return geteuid() == 0;
 	}
 
diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
index c1b8ac033ccc..bf09fb20c779 100644
--- a/tools/perf/util/cap.h
+++ b/tools/perf/util/cap.h
@@ -18,7 +18,6 @@
 #define CAP_BPF		39
 #endif
 
-/* Query if a capability is supported, used_root is set if the fallback root check was used. */
-bool perf_cap__capable(int cap, bool *used_root);
+bool perf_cap__capable(int cap);
 
 #endif /* __PERF_CAP_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a562702b4841..94f9c8faedda 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2452,8 +2452,7 @@ static bool symbol__read_kptr_restrict(void)
 {
 	bool value = false;
 	FILE *fp = fopen("/proc/sys/kernel/kptr_restrict", "r");
-	bool used_root;
-	bool cap_syslog = perf_cap__capable(CAP_SYSLOG, &used_root);
+	bool cap_syslog = perf_cap__capable(CAP_SYSLOG);
 
 	if (fp != NULL) {
 		char line[8];
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 2c2a5c449ffd..8f7cd32f524d 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -378,15 +378,9 @@ int perf_event_paranoid(void)
 
 bool perf_event_paranoid_check(int max_level)
 {
-	bool used_root;
-
-	if (perf_cap__capable(CAP_SYS_ADMIN, &used_root))
-		return true;
-
-	if (!used_root && perf_cap__capable(CAP_PERFMON, &used_root))
-		return true;
-
-	return perf_event_paranoid() <= max_level;
+	return perf_cap__capable(CAP_SYS_ADMIN) ||
+	       perf_cap__capable(CAP_PERFMON) ||
+	       perf_event_paranoid() <= max_level;
 }
 
 int perf_tip(char **strp, const char *dirpath)
-- 
2.55.0.229.g6434b31f56-goog

