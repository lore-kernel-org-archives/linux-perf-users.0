Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C114255F26
	for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747079193; cv=none; b=gVQ7k+pra600861GHEuyAyUWn7fB9nQHLq4VtqMQ3tHYwKrgazG3IZNnw84lYSVgouS4PPSQojian9SkLAdY8OW3k4AbLIEon2saVA2FUJlAAMZyviFru694e8jW9t6JGvbP306L7OzealNI7a3XyYl/cywN0yZ+iZgOZXY1i1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747079193; c=relaxed/simple;
	bh=H8wmlkybuyRNgIjko9condU2hcvyNOwK+IcMQr5hzcI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qPgC2w7Ac5ZW8bAgzjqL9blT7MJ3mviJfsn/TJueUsezdsX+arpEMHudYg0jbR2MSxnU145xcyqfAlvDj2kl1pBMFt0SkTKNVaG6q4SyZOI0AmP5pPsa8jikV8DgFoAcWFa5vxuTKXbRd5ydf7YFIjd1ZXr8qdZ/46KGbM5JZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2hxaQSIL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2hxaQSIL"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22e5a558bfaso109744155ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 May 2025 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747079191; x=1747683991; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XU6UfA2WeHkiiF81WFUDai0gldv4UGsTw49aTIuK2Iw=;
        b=2hxaQSILD+8wv2ynV1EI0L2fh8ZY06q9uZ8teRsYMbcduWWjR4023RNzg7G2eVPhGb
         TLpPR7HR+zhNDMVqxvYsEZVCGGLkDx6FxhBoBQ2VaKfeqkKhjN8J7ALIJ1DugsZMedyK
         g6VWupH6yHu43eUEtj3c4bGo8Im/rElY7IOxdI6v4Wo4IuyXn/CZqbhYrZXPBHBAJWAd
         j7x+C/ctIV8BcrzmwWTgVVQ/cUnhCQ8Dh5jQ0Jd+2jvyQCsHVN88/qH6RAQigwErpdml
         LX6XLCICclmA+N9kr/Hmh6bQZFNya2kasTrMjdxOPKJjAWdAB+P7w0/ynlPzlndENJOl
         LT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747079191; x=1747683991;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XU6UfA2WeHkiiF81WFUDai0gldv4UGsTw49aTIuK2Iw=;
        b=FfrKqsX3WVe2TrvNCRLPboUtkq85WKZB9VQBeoMCgK+6h2L/h6z/5TYpGqfQ+z3ZDK
         fNvnWXWPIgoQq4KJjN28vsmbkTG3EHQ/jdOUVQEV2svzmMqDGAXV5/zOneIA7pGQ1xdT
         FM4DG29NDO/w5sDP1sx6MJtfq+0Gc2xARSAQ5+m+3LlulrZtxyoez/mHNgwNiV+fRPjU
         M2aHo9NV+zzshvPbVETqCyovq3e+cHtdgC4sbgu2qhOhUJUZUAKPkO51H2Z2V259PcCV
         Pzemgb6DtpBnycnvMLOkDoG8pWg5pNJ+1o7R0Q7LLWJ7daj4YAtQT4N4h/yIdUGWTNBx
         zYEg==
X-Forwarded-Encrypted: i=1; AJvYcCU348yjz0cAQA++LXbuiCp9YZw35tOmhwG9J1O1HNDb4rSYouS2fteKo2nHZdbBm+9TUczksdvRF1VNrIZ3Nyw6@vger.kernel.org
X-Gm-Message-State: AOJu0YxNcYW4yNho01/zgsMOt/m6i/Cmn9LflzeBkRFnUmc4qGJf3CTF
	3sJvszJXZ6aTrak9xPaqOd4y70KvLl8rYa5AUwCp3SenIKMTPA+A1vDvnSVcD2jSzEGUet46wkb
	+I2qo7A==
X-Google-Smtp-Source: AGHT+IGiJhnOWvskRyOedJpWLyi0SwiQRmmUy3W/gJ/dq1ajxD6hnxUUcIwzGnkK49P5rS0XESZPwPuX6TWO
X-Received: from plgi6.prod.google.com ([2002:a17:902:cf06:b0:22e:4956:ff79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54f:b0:22e:3b65:9286
 with SMTP id d9443c01a7336-22fc91a84edmr224460635ad.49.1747079191212; Mon, 12
 May 2025 12:46:31 -0700 (PDT)
Date: Mon, 12 May 2025 12:46:20 -0700
In-Reply-To: <20250512194622.33258-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512194622.33258-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512194622.33258-2-irogers@google.com>
Subject: [PATCH v2 1/3] perf fncache: Switch to using hashmap
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The existing fncache can get large in testing situations. As the
bucket array is a fixed size this leads to it degrading to O(n)
performance. Use a regular hashmap that can dynamically reallocate its
array.

Before:
```
$ time perf test "Parsing of PMU event table metrics"
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

real    0m14.132s
user    0m17.806s
sys     0m0.557s
```

After:
```
$ time perf test "Parsing of PMU event table metrics"
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

real    0m13.287s
user    0m13.026s
sys     0m0.532s
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/fncache.c | 69 +++++++++++++++++++++------------------
 tools/perf/util/fncache.h |  1 -
 tools/perf/util/srccode.c |  4 +--
 3 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
index 6225cbc52310..bf9559c55c63 100644
--- a/tools/perf/util/fncache.c
+++ b/tools/perf/util/fncache.c
@@ -1,53 +1,58 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Manage a cache of file names' existence */
+#include <pthread.h>
 #include <stdlib.h>
-#include <unistd.h>
 #include <string.h>
-#include <linux/list.h>
+#include <unistd.h>
+#include <linux/compiler.h>
 #include "fncache.h"
+#include "hashmap.h"
 
-struct fncache {
-	struct hlist_node nd;
-	bool res;
-	char name[];
-};
+static struct hashmap *fncache;
 
-#define FNHSIZE 61
+static size_t fncache__hash(long key, void *ctx __maybe_unused)
+{
+	return str_hash((const char *)key);
+}
 
-static struct hlist_head fncache_hash[FNHSIZE];
+static bool fncache__equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return strcmp((const char *)key1, (const char *)key2) == 0;
+}
 
-unsigned shash(const unsigned char *s)
+static void fncache__init(void)
 {
-	unsigned h = 0;
-	while (*s)
-		h = 65599 * h + *s++;
-	return h ^ (h >> 16);
+	fncache = hashmap__new(fncache__hash, fncache__equal, /*ctx=*/NULL);
+}
+
+static struct hashmap *fncache__get(void)
+{
+	static pthread_once_t fncache_once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&fncache_once, fncache__init);
+
+	return fncache;
 }
 
 static bool lookup_fncache(const char *name, bool *res)
 {
-	int h = shash((const unsigned char *)name) % FNHSIZE;
-	struct fncache *n;
-
-	hlist_for_each_entry(n, &fncache_hash[h], nd) {
-		if (!strcmp(n->name, name)) {
-			*res = n->res;
-			return true;
-		}
-	}
-	return false;
+	long val;
+
+	if (!hashmap__find(fncache__get(), name, &val))
+		return false;
+
+	*res = (val != 0);
+	return true;
 }
 
 static void update_fncache(const char *name, bool res)
 {
-	struct fncache *n = malloc(sizeof(struct fncache) + strlen(name) + 1);
-	int h = shash((const unsigned char *)name) % FNHSIZE;
-
-	if (!n)
-		return;
-	strcpy(n->name, name);
-	n->res = res;
-	hlist_add_head(&n->nd, &fncache_hash[h]);
+	char *old_key = NULL, *key = strdup(name);
+
+	if (key) {
+		hashmap__set(fncache__get(), key, res, &old_key, /*old_value*/NULL);
+		free(old_key);
+	}
 }
 
 /* No LRU, only use when bounded in some other way. */
diff --git a/tools/perf/util/fncache.h b/tools/perf/util/fncache.h
index fe020beaefb1..b6a0f209493e 100644
--- a/tools/perf/util/fncache.h
+++ b/tools/perf/util/fncache.h
@@ -1,7 +1,6 @@
 #ifndef _FCACHE_H
 #define _FCACHE_H 1
 
-unsigned shash(const unsigned char *s);
 bool file_available(const char *name);
 
 #endif
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
index 476e99896d5e..0f4907843ac1 100644
--- a/tools/perf/util/srccode.c
+++ b/tools/perf/util/srccode.c
@@ -16,7 +16,7 @@
 #include "srccode.h"
 #include "debug.h"
 #include <internal/lib.h> // page_size
-#include "fncache.h"
+#include "hashmap.h"
 
 #define MAXSRCCACHE (32*1024*1024)
 #define MAXSRCFILES     64
@@ -92,7 +92,7 @@ static struct srcfile *find_srcfile(char *fn)
 	struct srcfile *h;
 	int fd;
 	unsigned long sz;
-	unsigned hval = shash((unsigned char *)fn) % SRC_HTAB_SZ;
+	size_t hval = str_hash(fn) % SRC_HTAB_SZ;
 
 	hlist_for_each_entry (h, &srcfile_htab[hval], hash_nd) {
 		if (!strcmp(fn, h->fn)) {
-- 
2.49.0.1045.g170613ef41-goog

