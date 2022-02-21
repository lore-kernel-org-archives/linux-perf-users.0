Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3875AC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Feb 2022 10:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351753AbiBUK5q (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:57:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355941AbiBUK5C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 05:57:02 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B638C300
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 02:26:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c6so25524155edk.12
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 02:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSsQgrFy7n/SK9xXJ4yKcEiTx0keRwChtVG0UGDeMo4=;
        b=mS8qw1spo8zNaQyO+2oFtcbodiGTx0vjr4lN8STKlSHVnjqwKIx2AO9kxFRR5bZdnE
         b26NV26uMNEcO9ScUQ9SsP9HE7xrbfax25tvIBbNe2BRcbB5H9tgWf/KZ8h2Nf+haW1c
         vpNRIR+1LFe92zGAhDSZa1xMXNwn2UwaPePqX1GO47KvTAaUpRQ27vpo8S3pVZMfDz/v
         FXVJFdrn/2fjZh13FRAA9mMH3/jWgRMjm33UFb1NtCNgrAFBgQZvP8jXY0p+vCvpSfhD
         9q3uyIG2nRARhl+IPf88KlzkCkTKWqWmZMOR64ThabPt44A8ZqD/dgZ7maE+/k4tA5Pf
         kImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSsQgrFy7n/SK9xXJ4yKcEiTx0keRwChtVG0UGDeMo4=;
        b=7T8c1NncpNHRyiNbLT32oYxuXSIUAefS2ChzUF21PrFDDoNLmO5n17HndL3W+cSCzu
         L3firA3SPJBmILzQyH/Z5GMCSK7rIlyULMO7/YkIcpu7W8NxYD/XtZuzrxmlDnWlz44Q
         sMe0rl+47a4DeXvNZFDU8bw0NxFqrgCyz5AH8MODVDWCEqWdyCLL1TVBmS6TmJtTdeh9
         s80fUMbeIoLP4At4vRb44s1i8u/KzWLPNaNkULghCpfSx5Q8/vPopI99RVTwWR9oC0J4
         pwcaprFsTUcyBBGUFS8Ku8HUIJlNndLBhOG2+JoWoo+NnD97vAM9pZ77iiRt/75ntGsH
         IR4g==
X-Gm-Message-State: AOAM530tK2wFmsQmlxQfnIZa1JTWif079Ua6Si/cERX404YVjL1CTaha
        ZgABBAtTpUUPH8C/WPHVNkE=
X-Google-Smtp-Source: ABdhPJwojytGno+vyldkgqbHiwrezFLJ41PApB8XVentWVeLUzV9IWP/YuqIWABjTUKIr1oo4apUcA==
X-Received: by 2002:a50:f686:0:b0:410:e352:e61a with SMTP id d6-20020a50f686000000b00410e352e61amr19979936edn.23.1645439189841;
        Mon, 21 Feb 2022 02:26:29 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id 18sm4945953ejj.1.2022.02.21.02.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:26:29 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     acme@kernel.org, olsajiri@gmail.com, irogers@google.com
Cc:     linux-perf-users@vger.kernel.org
Subject: [PATCH v2] libperf: Add API for allocating new thread map
Date:   Mon, 21 Feb 2022 12:26:28 +0200
Message-Id: <20220221102628.43904-1-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The existing API perf_thread_map__new_dummy() allocates new thread map
for one thread. I couldn't find a way to reallocate the map with more
threads, or to allocate a new map for more than one thread. Having
multiple threads in a thread map is essential for some use cases.
That's why a new API is proposed, which allocates a new thread map
for given number of threads:
 perf_thread_map__new_array()

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
v2 changes:
 - Changed the new API as Arnaldo suggested - get number of threads in the
   map and array with initial values (optional).

 tools/lib/perf/Documentation/libperf.txt |  1 +
 tools/lib/perf/include/perf/threadmap.h  |  1 +
 tools/lib/perf/libperf.map               |  1 +
 tools/lib/perf/tests/test-threadmap.c    | 41 ++++++++++++++++++++++++
 tools/lib/perf/threadmap.c               | 24 ++++++++++----
 5 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index a21f733b95b1..a8f1a237931b 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -62,6 +62,7 @@ SYNOPSIS
   struct perf_thread_map;
 
   struct perf_thread_map *perf_thread_map__new_dummy(void);
+  struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array);
 
   void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
   char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
index 58f7fbdce446..8b40e7777cea 100644
--- a/tools/lib/perf/include/perf/threadmap.h
+++ b/tools/lib/perf/include/perf/threadmap.h
@@ -8,6 +8,7 @@
 struct perf_thread_map;
 
 LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
+LIBPERF_API struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array);
 
 LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
 LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 6fa0d651576b..190b56ae923a 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__empty;
 		perf_cpu_map__max;
 		perf_cpu_map__has;
+		perf_thread_map__new_array;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
 		perf_thread_map__comm;
diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
index 5e2a0291e94c..f728ad7002bb 100644
--- a/tools/lib/perf/tests/test-threadmap.c
+++ b/tools/lib/perf/tests/test-threadmap.c
@@ -11,9 +11,43 @@ static int libperf_print(enum libperf_print_level level,
 	return vfprintf(stderr, fmt, ap);
 }
 
+static int test_threadmap_array(int nr, pid_t *array)
+{
+	struct perf_thread_map *threads;
+	int i;
+
+	threads = perf_thread_map__new_array(nr, array);
+	__T("Failed to allocate new thread map", threads);
+
+	__T("Unexpected number of threads", perf_thread_map__nr(threads) == nr);
+
+	for (i = 0; i < nr; i++) {
+		__T("Unexpected initial value of thread",
+		    perf_thread_map__pid(threads, i) == (array ? array[i] : -1));
+	}
+
+	for (i = 1; i < nr; i++)
+		perf_thread_map__set_pid(threads, i, i * 100);
+
+	__T("Unexpected value of thread 0",
+	    perf_thread_map__pid(threads, 0) == (array ? array[0] : -1));
+
+	for (i = 1; i < nr; i++) {
+		__T("Unexpected thread value",
+		    perf_thread_map__pid(threads, i) == i * 100);
+	}
+
+	perf_thread_map__put(threads);
+
+	return 0;
+}
+
+#define THREADS_NR	10
 int test_threadmap(int argc, char **argv)
 {
 	struct perf_thread_map *threads;
+	pid_t thr_array[THREADS_NR];
+	int i;
 
 	__T_START;
 
@@ -27,6 +61,13 @@ int test_threadmap(int argc, char **argv)
 	perf_thread_map__put(threads);
 	perf_thread_map__put(threads);
 
+	test_threadmap_array(THREADS_NR, NULL);
+
+	for (i = 0; i < THREADS_NR; i++)
+		thr_array[i] = i + 100;
+
+	test_threadmap_array(THREADS_NR, thr_array);
+
 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
 }
diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index 84fa07c79d00..07968f3ea093 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -42,18 +42,28 @@ char *perf_thread_map__comm(struct perf_thread_map *map, int idx)
 	return map->map[idx].comm;
 }
 
-struct perf_thread_map *perf_thread_map__new_dummy(void)
+struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array)
 {
-	struct perf_thread_map *threads = thread_map__alloc(1);
+	struct perf_thread_map *threads = thread_map__alloc(nr_threads);
+	int i;
+
+	if (!threads)
+		return NULL;
+
+	for (i = 0; i < nr_threads; i++)
+		perf_thread_map__set_pid(threads, i, array ? array[i] : -1);
+
+	threads->nr = nr_threads;
+	refcount_set(&threads->refcnt, 1);
 
-	if (threads != NULL) {
-		perf_thread_map__set_pid(threads, 0, -1);
-		threads->nr = 1;
-		refcount_set(&threads->refcnt, 1);
-	}
 	return threads;
 }
 
+struct perf_thread_map *perf_thread_map__new_dummy(void)
+{
+	return perf_thread_map__new_array(1, NULL);
+}
+
 static void perf_thread_map__delete(struct perf_thread_map *threads)
 {
 	if (threads) {
-- 
2.34.1

