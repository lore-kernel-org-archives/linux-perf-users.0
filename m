Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DE40759B
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659633; cv=none; b=PdvtRw+ZMYZbAuKVlTAX6baLc2q+cvTxdsbUI3fao5uHnfB/0aiR0NoTtABfKay4smWM+X2oW1PJuZ1y/+bP+UI8317Zdq2b7l1UKKqEjfKshk3JP0+iYd9n0CLvYXFgABbZyxXdDOuetjsmxynLSRuOpBjAw73ip3G0gmpw95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659633; c=relaxed/simple;
	bh=BDB2js4drqE6QfRtGJB3JwcQVzwBxzVRr/iaZN1OkTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n1C2EHWPIFiqlBD+qcJkp+XrDJ+ro+3Ks03Ydmx60cluAk1MyMpraxpZHDEpXOwsvx7KRNhVhyr7BKEOUa63BKF98ZIEFAEI9X7k9gMEDHbP4ShT71oltUWNQV/eFIeiBxpCRVLwfvPI3rego3hV7bKpDhLEpPPEd3brN8yO/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkAafez3; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkAafez3"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so3484143eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659631; x=1778264431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca7k0d6Hn6jB3V8PRr9BUGUU/CgyMEw9LXb9LFro2BA=;
        b=FkAafez3SAaT7ysrZA5JlGfYIIupLXO2sjt4t4/mh++WqqSt88iC36+Bl459AJ3SKp
         HlBGTv6VYoIeSbWhAeVd3zDpBC0LttRArFE1t2687gqKqAHZtq4x4ofzDRwZVdIWYs5z
         E3ugeb7Wmk/gkcrHxVGIfPpCaClkkqixeEg51NdUoLHts4P6F2Lun3euvzXaPpaoBPNG
         HxW2/JzrYw7j98kqIBo72tqL+T7LOFNn9NmsjE8/iUK3HwDeT1ecqBLMBkjrl775cMO7
         9Gr+xTQBB8awWtTQm90ZxSXCfWa0KjycN7oY3do7GPALyjpCMzD986Tr6PKVZqmgLa7Y
         zj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659631; x=1778264431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca7k0d6Hn6jB3V8PRr9BUGUU/CgyMEw9LXb9LFro2BA=;
        b=oSbe5UnrUFX0pktNTJACyZU+vTcakeX1SWqSpyb4rS9NgwHNpNNZ94SMjr6eZuSOri
         5XBHd/qEh5ttd7UqL/e/vP2DgKfdDT2nb/cQo3hNuIrFlZN6Rk7JzIcbzADQZO4fsB78
         zr1sDZYS72jIwsFzAJn/676y6JJagb525FPoqfAIIMlkVZPgInN0PVVxUB6bBMq5eIlO
         OIZnUPcNHxRQu3qshxiH7rB/GiIMiR8Bx4CCgVYHnBqo+HXtozOx3GnZyBeG/8ozyuQL
         AgVaejVqwJ5o74iK6CP7sh7S7Me5pGMG9MIYt0/gIiisnAq/U/VjwxLwgMTVTSY2UdZv
         TxbA==
X-Forwarded-Encrypted: i=1; AFNElJ+a+BvpHvJ5HjwWGlEJN1q1iiED67Yr3hZ0kqayM3tiFwvL5XVURF2hjneFBLRoxveWtk0ehDaNyOaPl7tM3yiT@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+M6AHJ0uv5HbA10mr4XGr5RIOhjh3VeHb5mJq81LI/ic8tqZ
	T2JjYMglLIZ92OmZi1mo7+WyKgu67InizJpInVa9QxOQOGG5cjy/QWp6zgIO6gAmgcHyImFOayp
	LWIiRVXMLtQ==
X-Received: from dycue4.prod.google.com ([2002:a05:7300:84:b0:2d1:6536:ac8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f194:b0:2e2:a4ba:84ae
 with SMTP id 5a478bee46e88-2efba28b2f0mr191995eec.25.1777659630551; Fri, 01
 May 2026 11:20:30 -0700 (PDT)
Date: Fri,  1 May 2026 11:20:19 -0700
In-Reply-To: <20260501182021.3651851-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409230620.4176210-2-irogers@google.com> <20260501182021.3651851-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501182021.3651851-3-irogers@google.com>
Subject: [PATCH v7 2/4] perf env: Add helper to lazily compute the os_release
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
index 1671769d4441..c3e464c6de2f 100644
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
index d36a0fb2cd04..56020f4381cd 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -175,6 +175,7 @@ void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version,
 void perf_env__exit(struct perf_env *env);
 
 int perf_env__kernel_is_64_bit(struct perf_env *env);
+const char *perf_env__os_release(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 8d5152bde25d..cfafed3cc69f 100644
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
2.54.0.545.g6539524ca2-goog

