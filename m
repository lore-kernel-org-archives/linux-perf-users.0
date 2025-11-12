Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848212D8DC4
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933238; cv=none; b=cQLnmmaJot+lVSVHJXTD/oYncC4TOYvr866maVZL+5A2SU4c1d3pUsOFQJE6X9yVsKyGs/SRHLZ5jFJbp2UEiD2WYlLPHG2VTrwXUSSVD0KVStsE/waZNTaAulW9xsJFMMl7CsjOYJI4E+p5H4xAtPO4TwAEETYfNzEY1EVBAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933238; c=relaxed/simple;
	bh=4SALSKbCmgX/8BOof2Zi1l+NvRGR0X15IZnZc2+XiB4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=KMoruYVAm59G/pCeGxsaGH+qnFYlzitP+Wabrqp3W643M7/yps7vVC/llC0E1Z1QEffo2UJarkuVeC2yFUrOeNwbNyzv6rsopdsqfrH3gMAlmvSfqr9cP51rVrWJwhn1ymNsRt0dHNU5iZhKZVN9wvacJBo6q1sNoxaWPCLwOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dPRMm8Ie; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPRMm8Ie"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso1211776a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 23:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762933236; x=1763538036; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b4j12ALBms7hTL30MK6vG9oB8izvbJzE18Mhy1cM3lQ=;
        b=dPRMm8IeM8v7ZHg44ZxHO9eBhYxqB6CKGQSO0x52AtARpoJTX1LJ+hl3kD5qzUW5Pw
         Nl9OW4DOKBuX87Qi0hUeQJkqzEdGT6U7E7jpqdyY7kRc6GSfEd8q6TjF+7t49LHAM2eg
         Dk2ZwKnRsOyK3i8iYwQBBJu2wZoPRMXnOUv2pTqxIP/XCjwt4MHTGffXpixIkR1PagDC
         1cE8jPM4NEX7AJrkPZ6STXG4/IoZOHqz9GSEepIIj/gF+rJtvVASQxt/BHFvoCTjvrHe
         s35pu9NJ33Jmi07d9vXYjEsBtKr2G6SJ70xkUuagqFYSahnUTx9UooiUkLPnV1KuoJDo
         eUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933236; x=1763538036;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4j12ALBms7hTL30MK6vG9oB8izvbJzE18Mhy1cM3lQ=;
        b=w2fCzdjwCxljcdwANFna9EWKP4pNPvExHW6uz5eLIoxhtd5ym2En16niOSCMshPpH5
         Db/X27P+pJcQyWt/UUT5I4q2K4adWgT0fYSh+8lqZxvzURIW13B4XQlFr9J6FzG+JNph
         qu5vuIzmi/qB6peYvXdDvYD+t1Tz5Lg4NhAckGOs9g5hVAMgXJugMgMjNV+iSZnsM0R5
         1GTm9oBiGa+s+vScdgWgr5eEkX0olYNTf1y7IIawOeQD3hecsu03Et3Xo8viuemsODig
         qXIUoWnjEfnn93GzAmjWpyZI2wFyXP//oe6C+k8MSzkqhBXrJaVck06hygszSVF/rBEA
         +naw==
X-Forwarded-Encrypted: i=1; AJvYcCVN28Sv/Ws0Qor5QsNr2CJMRP537BvGxMU3udDLCQwWq+tJNHeTO6350zp7mbexRC4DYcFvZseRkeBlKqM8EIne@vger.kernel.org
X-Gm-Message-State: AOJu0YwXcrwGteCtXsj40xCKaTu27J7ex79S8jIBAjcVfU5U+OJINHT3
	4LkAZA7CeCWYhGP6Ts/KN4ZqKO9wpd1x9pkNAJQTYLJViQ9DIF64YdsZ/1a/KsDsTCNVnc3fjiH
	d3PGPX0uCFA==
X-Google-Smtp-Source: AGHT+IHfhIMW+Y2tjkl213sKicyatqbA81t/2MTS7BpCHBXOS8ZJ+7k32EHIntIqbQvPQ9zP1brPBmH33+Sg
X-Received: from dycrq20.prod.google.com ([2002:a05:693c:2c14:b0:2a4:74cb:b0ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e788:b0:295:70b1:edc8
 with SMTP id d9443c01a7336-2984ed79fd7mr28105145ad.2.1762933235823; Tue, 11
 Nov 2025 23:40:35 -0800 (PST)
Date: Tue, 11 Nov 2025 23:40:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112074031.1436415-1-irogers@google.com>
Subject: [PATCH v1] perf libbfd: Ensure libbfd is initialized prior to use
From: Ian Rogers <irogers@google.com>
To: Guilherme Amadio <amadio@gentoo.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Multiple threads may be creating and destroying BFD objects in
situations like `perf top`. Without appropriate initialization crashes
may occur during libbfd's cache management. BFD's locks require
recursive mutexes, add support for these.

Reported-by: Guilherme Amadio <amadio@gentoo.org>
Closes: https://lore.kernel.org/lkml/aQt66zhfxSA80xwt@gentoo.org/
Fixes: 95931d9a594d ("perf libbfd: Move libbfd functionality to its own file")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/libbfd.c | 39 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/mutex.c  | 14 ++++++++++----
 tools/perf/util/mutex.h  |  2 ++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 01147fbf73b3..42edb3191d7d 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -19,6 +19,7 @@
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <unistd.h>
 #define PACKAGE "perf"
 #include <bfd.h>
 
@@ -38,6 +39,39 @@ struct a2l_data {
 	asymbol **syms;
 };
 
+static bool perf_bfd_lock(void *bfd_mutex)
+{
+	mutex_lock(bfd_mutex);
+	return true;
+}
+
+static bool perf_bfd_unlock(void *bfd_mutex)
+{
+	mutex_unlock(bfd_mutex);
+	return true;
+}
+
+static void perf_bfd_init(void)
+{
+	static struct mutex bfd_mutex;
+
+	mutex_init_recursive(&bfd_mutex);
+
+	if (bfd_init() != BFD_INIT_MAGIC) {
+		pr_err("Error initializing libbfd\n");
+		return;
+	}
+	if (!bfd_thread_init(perf_bfd_lock, perf_bfd_unlock, &bfd_mutex))
+		pr_err("Error initializing libbfd threading\n");
+}
+
+static void ensure_bfd_init(void)
+{
+	static pthread_once_t bfd_init_once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&bfd_init_once, perf_bfd_init);
+}
+
 static int bfd_error(const char *string)
 {
 	const char *errmsg;
@@ -132,6 +166,7 @@ static struct a2l_data *addr2line_init(const char *path)
 	bfd *abfd;
 	struct a2l_data *a2l = NULL;
 
+	ensure_bfd_init();
 	abfd = bfd_openr(path, NULL);
 	if (abfd == NULL)
 		return NULL;
@@ -288,6 +323,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	bfd *abfd;
 	u64 start, len;
 
+	ensure_bfd_init();
 	abfd = bfd_openr(debugfile, NULL);
 	if (!abfd)
 		return -1;
@@ -393,6 +429,7 @@ int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block
 	if (fd < 0)
 		return -1;
 
+	ensure_bfd_init();
 	abfd = bfd_fdopenr(filename, /*target=*/NULL, fd);
 	if (!abfd)
 		return -1;
@@ -421,6 +458,7 @@ int libbfd_filename__read_debuglink(const char *filename, char *debuglink,
 	asection *section;
 	bfd *abfd;
 
+	ensure_bfd_init();
 	abfd = bfd_openr(filename, NULL);
 	if (!abfd)
 		return -1;
@@ -480,6 +518,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
 	memset(tpath, 0, sizeof(tpath));
 	perf_exe(tpath, sizeof(tpath));
 
+	ensure_bfd_init();
 	bfdf = bfd_openr(tpath, NULL);
 	if (bfdf == NULL)
 		abort();
diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
index bca7f0717f35..7aa1f3f55a7d 100644
--- a/tools/perf/util/mutex.c
+++ b/tools/perf/util/mutex.c
@@ -17,7 +17,7 @@ static void check_err(const char *fn, int err)
 
 #define CHECK_ERR(err) check_err(__func__, err)
 
-static void __mutex_init(struct mutex *mtx, bool pshared)
+static void __mutex_init(struct mutex *mtx, bool pshared, bool recursive)
 {
 	pthread_mutexattr_t attr;
 
@@ -27,21 +27,27 @@ static void __mutex_init(struct mutex *mtx, bool pshared)
 	/* In normal builds enable error checking, such as recursive usage. */
 	CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK));
 #endif
+	if (recursive)
+		CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE));
 	if (pshared)
 		CHECK_ERR(pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED));
-
 	CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
 	CHECK_ERR(pthread_mutexattr_destroy(&attr));
 }
 
 void mutex_init(struct mutex *mtx)
 {
-	__mutex_init(mtx, /*pshared=*/false);
+	__mutex_init(mtx, /*pshared=*/false, /*recursive=*/false);
 }
 
 void mutex_init_pshared(struct mutex *mtx)
 {
-	__mutex_init(mtx, /*pshared=*/true);
+	__mutex_init(mtx, /*pshared=*/true, /*recursive=*/false);
+}
+
+void mutex_init_recursive(struct mutex *mtx)
+{
+	__mutex_init(mtx, /*pshared=*/false, /*recursive=*/true);
 }
 
 void mutex_destroy(struct mutex *mtx)
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 38458f00846f..70232d8d094f 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -104,6 +104,8 @@ void mutex_init(struct mutex *mtx);
  * process-private attribute.
  */
 void mutex_init_pshared(struct mutex *mtx);
+/* Initializes a mutex that may be recursively held on the same thread. */
+void mutex_init_recursive(struct mutex *mtx);
 void mutex_destroy(struct mutex *mtx);
 
 void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
-- 
2.51.2.1041.gc1ab5b90ca-goog

