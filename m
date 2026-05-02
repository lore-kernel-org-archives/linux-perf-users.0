Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793FC31A572
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777705225; cv=none; b=dW66OHyJDRm4ZLJx0K69HtuLvwuMf/4WnqSYzrbHbNg0ajEKhiCqB2slGq4FL1B1dUELgb+bxfLnLuRHrmjtr2mgJjcgGm1u7VW0Ses+KVq3EenDR1kw2WwacJsnhRc+XsL1HfajeH5fxT1l5QPgMSJ4dsDDko9XtS7GrcjaVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777705225; c=relaxed/simple;
	bh=0x1jZOU/SSy2Jra3FIlo1YicVHYFz7CVq678Xr4UmHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fcncaQDf4vvD8lA+BuBrTVVAQTTohr5XDibiZ/RJDnQILNAG5A49XakRKUsaiNqHURCxBQDWJ7yW9cA38GHtfNM60MQIVhheG3n7uQAOkoms/LHVNg/rrhmjarKLYB4m/TwiZIWR5F1kwaBBoubDXocQ6AIQvIcOCNafmuUD0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1Np0LHn; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1Np0LHn"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dfe9c058eso1392661c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 02 May 2026 00:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777705224; x=1778310024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=65M+lA5XSnXp7mSFaFqmQvgDaBfQgwqfvcgqjxbx5Bk=;
        b=s1Np0LHnFsfEBLr1mNdmMDQDqIs/f7ubILzqJLVwk2bz6Okaym5VifAyrtfc2QEsIJ
         wj1vXPh7VDORNk1wzVq9V/O9NAE7KQdNWmeJbi2UWx5m9MvFKpqOVOZZDHl0QJOOjZnA
         VHBTkDnj9oY0cIMCpKQjdttTqz51StHnlWVVa/AG1cnStrOYDgfq6+HYGWYNa4kZ+u3E
         Qt3RG/kzZS/0tON4zR2A39uVmUOKzeSh78KHsrbOIBZjITq1WecnLpkjXcuV4SsgwWBV
         whnQzWSqZSQju44Vq0m6tRz/2sAPzS1iV/nwWe1Nthtn92RfFBjzyxv/EJEqbmfASLCl
         iyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777705224; x=1778310024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65M+lA5XSnXp7mSFaFqmQvgDaBfQgwqfvcgqjxbx5Bk=;
        b=ZqtvsYUqpcO4FfiWXpPLMGLyBMqmngwSRaBh3qhabPszjecPqh+4C7DoFitlrw3nO2
         7dRMo1FpSX8kCfSaJ7koZzfAaLtQib05nPc3OoDyb6GeDc2ZPf69ficQknHdglPYbiej
         qF4oUAAbXRGFB6HmZ3Y29u0ANaXtsSJMxwmxIb62P+5IkW2iKQq7+I0Mu45o+jSkL5AP
         Utp+xxGpOHbVjE91g9XbiXDe/x1XoQsV7HuWs2py/UMDkbNhqLjj4pWndTmHFgxOSawC
         zSf+Cim2cygXxkvfrl7BpcrJUA728qSfDQAy6VOpd6pQVyhVS2lrsrWo5BFSElsmdzPD
         /4Aw==
X-Forwarded-Encrypted: i=1; AFNElJ8qhnwdG4iUE9GQF8qjeT7XudkN1ve09FibA7pRsQHKG8nM7m1F07SQFn0iO8LF2Y5BlxfqhhGn+tF5X+kUxDj0@vger.kernel.org
X-Gm-Message-State: AOJu0YxTwvMFD4AVhxK4b/y2XAgk+8T1wjefFh87IKqbDWTwXwqVl5VY
	M3R3U1ilLYTneI9X9sIVuHj/BNGcUu6HtcQDTzj/GV1GRsNy3moQeC1WqC+7qIyyf69cds8sokg
	EU84JRGEMmA==
X-Received: from dlbph19.prod.google.com ([2002:a05:7022:3713:b0:12d:d0a4:2ed9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4590:b0:12d:de3e:52c7
 with SMTP id a92af1059eb24-12dfd86a40dmr979219c88.43.1777705223414; Sat, 02
 May 2026 00:00:23 -0700 (PDT)
Date: Fri,  1 May 2026 23:59:33 -0700
In-Reply-To: <20260502065935.291960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260502065935.291960-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502065935.291960-16-irogers@google.com>
Subject: [PATCH v8 15/17] perf env: Add helper to lazily compute the os_release
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In live mode the os_release isn't being initialized, make a lazy
initialization helper that assumes when the os_release isn't
initialized this is live mode.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data-convert-bt.c |  2 +-
 tools/perf/util/env.c             | 21 +++++++++++++++++++++
 tools/perf/util/env.h             |  1 +
 tools/perf/util/header.c          | 16 +++++++++++-----
 tools/perf/util/symbol.c          |  4 ++--
 5 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 3b8f2df823a9..2c88420fe33e 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1414,7 +1414,7 @@ do {									\
 
 	ADD("host",    env->hostname);
 	ADD("sysname", "Linux");
-	ADD("release", env->os_release);
+	ADD("release", perf_env__os_release(env));
 	ADD("version", env->version);
 	ADD("machine", env->arch);
 	ADD("domain", "kernel");
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 5944acd28996..1090aaa2985f 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -339,6 +339,27 @@ int perf_env__kernel_is_64_bit(struct perf_env *env)
 	return env->kernel_is_64_bit;
 }
 
+const char *perf_env__os_release(struct perf_env *env)
+{
+	struct utsname uts;
+	int ret;
+
+	if (!env)
+		return perf_version_string;
+
+	if (env->os_release)
+		return env->os_release;
+
+	/*
+	 * The os_release is being accessed but wasn't initialized from a data
+	 * file, assume this is 'live' mode and use the release from uname. If
+	 * uname or strdup fails then use the current perf tool version.
+	 */
+	ret = uname(&uts);
+	env->os_release = strdup(ret < 0 ? perf_version_string : uts.release);
+	return env->os_release ?: perf_version_string;
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index a95fd7eb3524..989545a47798 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -172,6 +172,7 @@ void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version,
 void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
+const char *perf_env__os_release(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c6436269df4b..4867a932cb88 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -370,13 +370,19 @@ static int write_osrelease(struct feat_fd *ff,
 			   struct evlist *evlist __maybe_unused)
 {
 	struct utsname uts;
-	int ret;
+	const char *release = NULL;
 
-	ret = uname(&uts);
-	if (ret < 0)
-		return -1;
+	if (evlist->session)
+		release = perf_env__os_release(perf_session__env(evlist->session));
 
-	return do_write_string(ff, uts.release);
+	if (!release) {
+		int ret = uname(&uts);
+
+		if (ret < 0)
+			return -1;
+		release = uts.release;
+	}
+	return do_write_string(ff, release);
 }
 
 static int write_arch(struct feat_fd *ff, struct evlist *evlist)
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8aaaab0ad4b7..a70066d17729 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2226,7 +2226,7 @@ static int vmlinux_path__init(struct perf_env *env)
 {
 	struct utsname uts;
 	char bf[PATH_MAX];
-	char *kernel_version;
+	const char *kernel_version;
 	unsigned int i;
 
 	vmlinux_path = malloc(sizeof(char *) * (ARRAY_SIZE(vmlinux_paths) +
@@ -2243,7 +2243,7 @@ static int vmlinux_path__init(struct perf_env *env)
 		return 0;
 
 	if (env) {
-		kernel_version = env->os_release;
+		kernel_version = perf_env__os_release(env);
 	} else {
 		if (uname(&uts) < 0)
 			goto out_fail;
-- 
2.54.0.545.g6539524ca2-goog

