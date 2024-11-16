Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645F18052;
	Sat, 16 Nov 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731772748; cv=none; b=VzrTzI7vzqxzvcpUoN8EaYQvNt2m3ysHx5fPmGwBQFqECPpgpnnR0zgpo9B1KrUwz8zgpy2gKAVSwqTZuimNrS6nIz4hG32rE1INnpbcu/kkTd0NBkGAeNUdsAlfXEWCndmtpJWQ6Tvvmm3dbETOHXc9GVPv0XNnzxvJUlButrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731772748; c=relaxed/simple;
	bh=R05vFOPyXSmK6aZ7AW65ol+f0LJtiZt+DUZUc+g3kzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+HmobUCDXVt8tWmfYC/wGIScPcOrHcqMPvE4VPaT+WzYtFlW8yTL4HLhWvzYe3oM9V6uTfgSEqiBOUbSbysPCg7nP2s+4us1jh2NqrAU+hIZ5tR5+7yYlMPELHfIqYwmfeo1/tDcikJoQyl8rjHbGC8j9nAbBfW53JGavM5Lew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=N3tDMao+; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="N3tDMao+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=y+Gjvmm+1/UVOH6BaJco0VpfVNGA24+a0m8sbQTS3XY=; b=N3tDMao+T2U2QYfP
	6IE2Zs1PXjHGzRZFWsDoGvbB/eWDojWUHbiCLI0VhJbtIHm4p3gVRGDst+/qqjvtErDBG5FiFffVN
	YRHVwG+anG9yXGe1sFTF/Py0PSYwW67/JVmroy8XXlJ72YYX6h07Yv3PaUFl4OFDHbJEomOX2RZ3D
	eJDYoCbe1KjgnJRd7CC95H3RIwCmbtxR3YirxA8rLbzccNTqaAIQzjMP8lvy1wU3nD1KAigouFwSV
	Y/PN7OQB5trfNaceew3apd/Qs4YOvvfYEvvYwlWuI8HZ6KDu3snNU+6gXFbtcqAE/Xc+vniBtJt+R
	VCsJKQ5OVqOtzNeP5w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tCLCF-000IdT-2w;
	Sat, 16 Nov 2024 15:58:51 +0000
From: linux@treblig.org
To: irogers@google.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf util: Remove kernel version deadcode
Date: Sat, 16 Nov 2024 15:58:50 +0000
Message-ID: <20241116155850.113129-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

fetch_kernel_version() has been unused since Ian's 2013
commit 3d6dfae88917 ("perf parse-events: Remove BPF event support")

Remove it, and it's helpers.
I noticed there are a bunch of kernel-version macros that are also
unused nearby.
Also remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/util.c | 85 ------------------------------------------
 tools/perf/util/util.h |  8 ----
 2 files changed, 93 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 9d55a13787ce..855aac5150a0 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -336,91 +336,6 @@ bool perf_event_paranoid_check(int max_level)
 	return perf_event_paranoid() <= max_level;
 }
 
-static int
-fetch_ubuntu_kernel_version(unsigned int *puint)
-{
-	ssize_t len;
-	size_t line_len = 0;
-	char *ptr, *line = NULL;
-	int version, patchlevel, sublevel, err;
-	FILE *vsig;
-
-	if (!puint)
-		return 0;
-
-	vsig = fopen("/proc/version_signature", "r");
-	if (!vsig) {
-		pr_debug("Open /proc/version_signature failed: %s\n",
-			 strerror(errno));
-		return -1;
-	}
-
-	len = getline(&line, &line_len, vsig);
-	fclose(vsig);
-	err = -1;
-	if (len <= 0) {
-		pr_debug("Reading from /proc/version_signature failed: %s\n",
-			 strerror(errno));
-		goto errout;
-	}
-
-	ptr = strrchr(line, ' ');
-	if (!ptr) {
-		pr_debug("Parsing /proc/version_signature failed: %s\n", line);
-		goto errout;
-	}
-
-	err = sscanf(ptr + 1, "%d.%d.%d",
-		     &version, &patchlevel, &sublevel);
-	if (err != 3) {
-		pr_debug("Unable to get kernel version from /proc/version_signature '%s'\n",
-			 line);
-		goto errout;
-	}
-
-	*puint = (version << 16) + (patchlevel << 8) + sublevel;
-	err = 0;
-errout:
-	free(line);
-	return err;
-}
-
-int
-fetch_kernel_version(unsigned int *puint, char *str,
-		     size_t str_size)
-{
-	struct utsname utsname;
-	int version, patchlevel, sublevel, err;
-	bool int_ver_ready = false;
-
-	if (access("/proc/version_signature", R_OK) == 0)
-		if (!fetch_ubuntu_kernel_version(puint))
-			int_ver_ready = true;
-
-	if (uname(&utsname))
-		return -1;
-
-	if (str && str_size) {
-		strncpy(str, utsname.release, str_size);
-		str[str_size - 1] = '\0';
-	}
-
-	if (!puint || int_ver_ready)
-		return 0;
-
-	err = sscanf(utsname.release, "%d.%d.%d",
-		     &version, &patchlevel, &sublevel);
-
-	if (err != 3) {
-		pr_debug("Unable to get kernel version from uname '%s'\n",
-			 utsname.release);
-		return -1;
-	}
-
-	*puint = (version << 16) + (patchlevel << 8) + sublevel;
-	return 0;
-}
-
 int perf_tip(char **strp, const char *dirpath)
 {
 	struct strlist *tips;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9966c21aaf04..b5e7becfc803 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -43,14 +43,6 @@ int sysctl__max_stack(void);
 
 bool sysctl__nmi_watchdog_enabled(void);
 
-int fetch_kernel_version(unsigned int *puint,
-			 char *str, size_t str_sz);
-#define KVER_VERSION(x)		(((x) >> 16) & 0xff)
-#define KVER_PATCHLEVEL(x)	(((x) >> 8) & 0xff)
-#define KVER_SUBLEVEL(x)	((x) & 0xff)
-#define KVER_FMT	"%d.%d.%d"
-#define KVER_PARAM(x)	KVER_VERSION(x), KVER_PATCHLEVEL(x), KVER_SUBLEVEL(x)
-
 int perf_tip(char **strp, const char *dirpath);
 
 #ifndef HAVE_SCHED_GETCPU_SUPPORT
-- 
2.47.0

