Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B93F99FB
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413984; cv=none; b=gq+ASSR8o8dkwn5CmE2XfauyXQlDSJQaHu85A2Ue58XvSq7yIU8fH7VSmkgpexiLZS2vU6KDnJXwES9fezhxRzUl5qQnz99EyC4/xMqK0qaq09e7+xSfrvxmG727lAmODYJT2vV6XjxjcJzE8ydSzAVe0zndGHVFqMzNL8dsxdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413984; c=relaxed/simple;
	bh=IELIlmNvVvIt3AL/nzEPMhdDrA1nwKMzWpu8GcZtdps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PWT/qHNTQHKkre00ky9HsXHxoQPExdu752wcMyi1IvXykSugQrMikLdF8SBpdUNg3TEgT4/h8Ptm49KeOGDBvtil8ZsBg0hQ2HOk9zFlbEgjK0nnsxffRXvqdar+o6SWM8pV4EGGjeCH0U8JMrZBq2lZBKIXnE+NZBAHb6HTtK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O7m7accz; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O7m7accz"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137e49e896aso1269262c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780413980; x=1781018780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7iB2IkCiPQWyvpQ1QBll6VQTrbjQBhFOeCn5EJNQ4TY=;
        b=O7m7accz3lt3KsweqIdhFuCS44IMezmr7HoRfRaFFphm/543HB7ohFLep1wdDRNeNQ
         T/v8alqL+GDc1fzGes/W1TfGyPzB/FY9R3uGtSoyXiDDZh+JNNX5CBf/Juf0Gjb2jgZd
         4500hvL2KXfxkTbZvaX64iJQFA9TecURPQuT2my+Ow7BqC5+joKZLOJIvFxduVDf7s7h
         5pAA/GA7RMzdGSiUu5ECa1xl4y3/kjYtIIV9sXTpi0wNAtAcPhkBT1GvXGGNfz8LUE9I
         q5EzNQHwmSAg3LS8tb+An2ENCqfb3ml2dGwOIYyecuvfnARAOFXHQvBPlDyp+9RunqPH
         YWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413980; x=1781018780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iB2IkCiPQWyvpQ1QBll6VQTrbjQBhFOeCn5EJNQ4TY=;
        b=NOrRLWcUaDgK1SXbOd5NlsOeiXGo4piWRvebOgohDTiu4U4jD85FDeRL7kvtAPffYn
         eFZ1R1x0aIdgERpchWAhEUIzbzQ2Lmhk1YyyuuRin99Ph3EHSYs26PkMjGoeBjlKyKix
         GNI5VY4P+fDQ9llWb/85bD6Hf4opEd9EdsjM9x1ovyT3k7k921B4xLQiB5k3AeFnzpkT
         Mc94bNTJkQ+qLyH29H89FqgTgd7a2Fgwr4DPKxvVU+Vp80oxGh47Loc33fgbw3c4Gt/n
         G43RFXyRFEUdp4WmBF0Yx1pW9tQPfoW9VjkwNUTAXez8uOLt1BPkCapgS9tpXG5hn2ww
         O7BQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YinJXMisXzsFSqU2zoDmsz2F2v0GHdDnGhFQW1pD/+pIskmMz6FtayE/nTSLYDQptO95MJg96xKoLdgHFLLvA@vger.kernel.org
X-Gm-Message-State: AOJu0YyzI3WJUBEzvZkrVMGQHpe+pEDNDobj1G7evIIjgrQ3Q01+m1qS
	QAwB0PMMiSv1Lrc8JCfUKopr3FQlhZBWnIN40B5DeazaIOKSaQTgy7tFjpPydrQ04hPYv8rfHAl
	2Qu/cIjICLA==
X-Received: from dlak10.prod.google.com ([2002:a05:701b:290a:b0:137:ef14:6ec7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f207:b0:12c:1288:ce63
 with SMTP id a92af1059eb24-137ee2f9aadmr1486105c88.13.1780413979700; Tue, 02
 Jun 2026 08:26:19 -0700 (PDT)
Date: Tue,  2 Jun 2026 08:25:14 -0700
In-Reply-To: <20260602152516.2831152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602062452.2583619-1-irogers@google.com> <20260602152516.2831152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602152516.2831152-18-irogers@google.com>
Subject: [PATCH v12 17/19] perf env: Add helper to lazily compute the os_release
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In live mode the os_release isn't being initialized, make a lazy
initialization helper that assumes when the os_release isn't
initialized this is live mode.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data-convert-bt.c   |  2 +-
 tools/perf/util/data-convert-json.c |  6 +++--
 tools/perf/util/env.c               | 38 +++++++++++++++++++++++++++++
 tools/perf/util/env.h               |  1 +
 tools/perf/util/header.c            | 16 ++++++++----
 tools/perf/util/symbol.c            |  4 +--
 6 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index b3f745cff2a7..cc51b8677c8e 100644
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
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index a7da93a7ff0e..c71dfb77c697 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -16,6 +16,7 @@
 #include "linux/err.h"
 #include "util/auxtrace.h"
 #include "util/debug.h"
+#include "util/env.h"
 #include "util/dso.h"
 #include "util/event.h"
 #include "util/evsel.h"
@@ -272,7 +273,7 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 {
 	struct stat st;
 	const struct perf_header *header = &session->header;
-	const struct perf_env *env = perf_session__env(session);
+	struct perf_env *env = perf_session__env(session);
 	int ret;
 	int fd = perf_data__fd(session->data);
 	int i;
@@ -296,7 +297,8 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
 	output_json_key_format(out, true, 2, "feat-offset", "%" PRIu64, header->feat_offset);
 
 	output_json_key_string(out, true, 2, "hostname", env->hostname);
-	output_json_key_string(out, true, 2, "os-release", env->os_release);
+	output_json_key_string(out, true, 2, "os-release",
+			       perf_env__os_release(env));
 	output_json_key_string(out, true, 2, "arch", env->arch);
 
 	if (env->cpu_desc)
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 03d90a45992c..c0e2b9d5f0b2 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -361,6 +361,44 @@ bool perf_arch_is_big_endian(const char *arch)
 	return false;
 }
 
+const char *perf_env__os_release(struct perf_env *env)
+{
+	struct utsname uts;
+	int ret;
+	const char *release;
+
+	if (!env)
+		return perf_version_string;
+
+	mutex_lock(&env->lock);
+	if (env->os_release) {
+		release = env->os_release;
+		goto out;
+	}
+
+	/*
+	 * If env->arch is set, this is an offline target environment.
+	 * If the os_release is not populated in the file, we do not want
+	 * to poison it with the host's release which would break guest checks.
+	 */
+	if (env->arch) {
+		release = NULL;
+		goto out;
+	}
+
+	/*
+	 * The os_release is being accessed but wasn't initialized from a data
+	 * file, assume this is 'live' mode and use the release from uname. If
+	 * uname or strdup fails then use the current perf tool version.
+	 */
+	ret = uname(&uts);
+	env->os_release = strdup(ret < 0 ? perf_version_string : uts.release);
+	release = env->os_release ?: perf_version_string;
+out:
+	mutex_unlock(&env->lock);
+	return release;
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 6aaf80c640bd..7621d1f73b83 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -176,6 +176,7 @@ void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
 bool perf_arch_is_big_endian(const char *arch);
+const char *perf_env__os_release(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ecdac427d9c4..d7f41db7322c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -432,13 +432,19 @@ static int write_osrelease(struct feat_fd *ff,
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
index 2ce512f08a1d..077d19af5240 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2225,7 +2225,7 @@ static int vmlinux_path__init(struct perf_env *env)
 {
 	struct utsname uts;
 	char bf[PATH_MAX];
-	char *kernel_version;
+	const char *kernel_version;
 	unsigned int i;
 
 	vmlinux_path = malloc(sizeof(char *) * (ARRAY_SIZE(vmlinux_paths) +
@@ -2242,7 +2242,7 @@ static int vmlinux_path__init(struct perf_env *env)
 		return 0;
 
 	if (env) {
-		kernel_version = env->os_release;
+		kernel_version = perf_env__os_release(env);
 	} else {
 		if (uname(&uts) < 0)
 			goto out_fail;
-- 
2.54.0.929.g9b7fa37559-goog

