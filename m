Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2503655D7
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187639; cv=none; b=uMt+zsHuK3zd23UoUy6KuaY4EEk7WxA00b2GU5jAyIJQ92/L2qP47zkAi2SCgmLpwfbz5JvkuPuMIGBTtG5Bg/V8izIYFeyAq+CTv6pOf2K48gheOTJL5k1lr62IPft+z1yED75cnO1hdt9CKS0BJKPwMGAZ4aseof7aOJ1PXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187639; c=relaxed/simple;
	bh=X32jELlMF94Xl0NmY7vypZygDvQes8I0SpcBi7a5U1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VqmuKwtYo/mvRgX2FvYAH32G2w+lVXzH4m2fMfAJJZjSd7UFV5W644W10ww6BmqOzrFC0Bn5JoyBBuF83VfLEd5xO0ZPU6EpENkvUFcwL6j8OYxZPCqfsIc+BT+ss2CyvbCaIaVgZFzE+hhZoJIGFybtF4lpZLFh59OByniJiCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXcp7yiv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXcp7yiv"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso15131750a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784187632; x=1784792432; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yE24h4tZ7G95OOIPOTLF1J84+Ri6r1nt8tkDTfpbhf0=;
        b=bXcp7yiv1899J+64f+8zwT1x8j3de+epXnrPXG/4WqAG1mQGbOimUmOwadxhfVl2Au
         M6si6OV48TdszTDbLjNIOy4zsRcV7Qbcq25eH8wknztpcXpG4G3bUuRKiz0bZqOcB9cF
         0RYxLQ4dukUAOYMfmBbsTympLTTnZzc4B8FDgTE1Wf+BBwwkJvWEl9DxSTNYiPMp5JrQ
         sScKW7Pxlin9W7FaM5SxFioaDvN+XVPlNFvqVlfhULF1xkTl+OrcslDiRqAJpnckCtid
         EH+kdPJsO0CanIJe47yUejVeg9sda7eAAS/jGBmh1WDKf/dL5ri7vPU0pmFXVlKpEDtd
         tiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784187632; x=1784792432;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yE24h4tZ7G95OOIPOTLF1J84+Ri6r1nt8tkDTfpbhf0=;
        b=OuQqejYyxT01JWSwHI6tAP6JLccHpGOWF1/zi52FxoiFdrXDlLSF6yVQxBnIi66Rry
         b6IljnV6nt/qzOtK4rU41Do+dBkNZJmzZMBrA7TEZDJwcgZJIcM+g9u6FpUM+Dr4Gnso
         AIdtAUEt6qdBgy8Np6FpY10M37NSuiHoDN1V8eZIhF2PjCYZG/kfVNJqnC7jr0nps+/9
         qMTiV3RPZ/JDoZQhxvfIRnzezGMc0M6fkRXCnWLJCy1OL2KrO+rivaoVxOgg/C0rB9Pt
         Jz16R6qmsIbvctAXnFTok0oOrYHPQhHvGC3gL7iZ8jpyZhmRp89/+L6K1+S/rthImDiM
         /kyQ==
X-Forwarded-Encrypted: i=1; AHgh+RoR2T/YU8LLuwWhER5vfNqL9HY1NqUrHdRELV/T6lxgh3PVQ9W3qBMDlPZoRWOt8hAyIhxm8HQnO582EMaSFQMR@vger.kernel.org
X-Gm-Message-State: AOJu0YwWUUcPjomLbi3F7a8G8GFXzBpqVux+efI0DCIRafAa268dcRsK
	WuPymPUBoSdjXtlZO+AS0awVcfDyqKhZJD27Z8EBCWgg7motfDcMyGipNGlVMfNCQQJhCAKmX4S
	l/51SBwKaRQ==
X-Received: from dybrt21.prod.google.com ([2002:a05:7301:4715:b0:313:d566:5bbb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7106:b0:3c3:94bb:ceb3
 with SMTP id adf61e73a8af0-3c394bbd03dmr690942637.10.1784187632131; Thu, 16
 Jul 2026 00:40:32 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:40:28 -0700
In-Reply-To: <alFxHPCouXNWkLie@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <alFxHPCouXNWkLie@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716074028.568999-1-irogers@google.com>
Subject: [PATCH v2] perf cap: Remove used_root parameter and simplify
 capability checks
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: abyssmystery@gmail.com, adrian.hunter@intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
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
2.55.0.141.g00534a21ce-goog

