Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E413A0B11
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775994; cv=none; b=URVIl79jj47HJXBScxdvi/Ib3EhdO4AUKTPd0bgFd248Z8n3l02vd/qW++7kMb8gAMBG4RLJ626SJ9mQpeLyRsiuo5SBSyTX7upf+xWvguWYDUrDoFpxK3P7xOhmQjF6CSidJfrL9pqyHClR5/Mm75N/c1yfqOdw8n5Jnd3B1RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775994; c=relaxed/simple;
	bh=YVhmmG8eYOHv1i++Ze774gQC92yjqq+2N46fILqgY2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fp2v7+6O5cPRSr19Sq740gFSCIT+3TpT0h6qcCh1IoXjF27GykpKq3cSYmZFTUsvHU9MsnqGkUvz1nMRifQdVhKE3gZ4ErZssEezG5hCqIwC22yWgNt1pj4Kvs9wkByjHgZI8ivB55nzPs+MIXv+aSnLTxCJwG1mpMTl0fE29k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPjDG2//; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPjDG2//"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ce1fe49225so1395702eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2026 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775775992; x=1776380792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6I83WFnRoUjFbCNJLWtgW/snAK9/jDfYYeQBO7N8LTg=;
        b=jPjDG2///+T2nhir6D05N4Kp9O3odBujO76O4Gn+VELgB7wjt0pyZDkiygq0DylMo4
         jOPNwD412PmGghLdGUT5OnHZywm+GqfeWpPFpDTv2V68SFJkSMkAutCQIbiuRsC9E1Qu
         2/ns6rzMHm7VlK3t+1XsKKn9+S2DMx45fXqLuM2tAGF5DlHU4BVJ7E8Ekk067n/F2hpl
         Y+3eGKZp9IvVIQxj0PwIhx1+ORL/F8niR26yW2ASQY+CwYqxiWq73i3GBnNUG6oXV23e
         jho777l9gwF1uy5u9hLEQ4rhZK6HRxD9q37SfQmZddh2ES7eFULVmOHOyKWSzow/6ris
         g40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775775992; x=1776380792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I83WFnRoUjFbCNJLWtgW/snAK9/jDfYYeQBO7N8LTg=;
        b=cxwQOiMmtSQ33B8ZpHKUNXu41vGVeMF4dpL53ahlKCeJk16k2egFjMX0IwitDEiyvw
         BaREp98QYVPgMylzGIFn49/4x7Lsy6C4UBUWDVwdiTGR4wllr3KOwDeKQQhPuysKYx5t
         YnaGw659Zp7xngbkArg9I5mbhq8iPLX8ERs5jctBMAn+h7HINmJOdiXgx40m/lbdfry0
         iMKupsl7kWlv2ozVjH2+3uqolhzwpiYMK/d5lByVxkShinNrfbsM8eA1iQF7FlH+n9VD
         xBk+A8pulj9wYa2MfEQsfTadQ2/40sriZMLfifTTWuBDkWbcyZWAZOT8yfstexF9S0C3
         HP+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMwsAAKtAP6Cua1OGaUqyV/ZsUk77Bjh7swXiP2vJQfha5E1IGSW1rlsXoXsWruIRbpQGbwO6N28ENfe6ClWLa@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCNmI5OPkF8WLOCiwFEMH5kExFWJegZYrZfCNJrhHA8B/tD/Q
	ig/2D6eVhVgfI9Ycx6YhiGk5+T3n5DP7gqtihAfsL4ICi/tBdm02SfFREdiDrGbY+Bt/KONCRks
	RfrQpGltjdQ==
X-Received: from dybqd6.prod.google.com ([2002:a05:7301:6406:b0:2d5:2d6a:465f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6589:b0:2c4:ec89:bc7
 with SMTP id 5a478bee46e88-2d586991a81mr600594eec.10.1775775992137; Thu, 09
 Apr 2026 16:06:32 -0700 (PDT)
Date: Thu,  9 Apr 2026 16:06:19 -0700
In-Reply-To: <20260409230620.4176210-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406170905.2614260-1-irogers@google.com> <20260409230620.4176210-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409230620.4176210-3-irogers@google.com>
Subject: [PATCH v6 2/3] perf env: Add helper to lazily compute the os_release
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, jameshongleiwang@126.com, 
	japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
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
index 339d62ca37bb..34b737950f73 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -330,6 +330,27 @@ int perf_env__kernel_is_64_bit(struct perf_env *env)
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
+	 * uname fails then use the current perf tool version.
+	 */
+	ret = uname(&uts);
+	env->os_release = strdup(ret < 0 ? perf_version_string : uts.release);
+	return env->os_release;
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d36a0fb2cd04..56020f4381cd 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -175,6 +175,7 @@ void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version,
 void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
+const char *perf_env__os_release(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9bb4a271b4f8..89115134f1d2 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -361,13 +361,19 @@ static int write_osrelease(struct feat_fd *ff,
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
index fcaeeddbbb6b..fd332db56157 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2209,7 +2209,7 @@ static int vmlinux_path__init(struct perf_env *env)
 {
 	struct utsname uts;
 	char bf[PATH_MAX];
-	char *kernel_version;
+	const char *kernel_version;
 	unsigned int i;
 
 	vmlinux_path = malloc(sizeof(char *) * (ARRAY_SIZE(vmlinux_paths) +
@@ -2226,7 +2226,7 @@ static int vmlinux_path__init(struct perf_env *env)
 		return 0;
 
 	if (env) {
-		kernel_version = env->os_release;
+		kernel_version = perf_env__os_release(env);
 	} else {
 		if (uname(&uts) < 0)
 			goto out_fail;
-- 
2.53.0.1213.gd9a14994de-goog

