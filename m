Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E177C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Feb 2022 10:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355346AbiBUK52 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 05:57:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355832AbiBUK4P (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 05:56:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7531410B8
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 02:26:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d10so31940280eje.10
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 02:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDxZPOwC4MYDIkKbyf+wAMEFDTvTNWzwfUl48bCWCSg=;
        b=g0vtYT2qxuZHsAEgg12k8DlU7FxXKSV6pvaZZ6ktDrhj82IyzzJqSfh2H+mCqF/dHL
         aDwnqRLqkbmOFdf8cA64UNuuhgOGjdH9H8VYIrF0vl4R9qfucHxI1c279+cTYnhd9nqH
         dSgdG8hQXFIGU4BQ7vFFCaF9pJZQfPau2VdmSZpmbDvgYVqcAHKNRkesmPCn4YMwCsMq
         H9rWuo2KZ00VfEvxEbcFryGt4AbUiGDwFd6d7ZElouidDKZt6j7ZmNGyX8fBmyZ8di/Q
         FDK6uHXXVzHCVyr4fhiH0LxbTx92z0cfbxJnPOyt1yBRAk4Kef0UhtlPtuVvQP2LRLGV
         mxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nDxZPOwC4MYDIkKbyf+wAMEFDTvTNWzwfUl48bCWCSg=;
        b=VujgR16vvG3tQ4bz/+U5A3V2QdEz+4jGa/hJcActgMKIU+vnMrdhf6p2N3Bqi752mk
         Il5vUf8U1WU6w4x9rKKsRW1PxbpiEwp3aE2Hjw130f6Ujr5fI7QM6jUa0Wndruiv/s7j
         xDV1S+X0V+m0ceY/Dhacn5bm0BzzeiF8lQAPVUBH6WKklhVx6C2OjHwXJ0T1nCcmH7iz
         TDT3BD2iRdMLRdi9mgnsqxxogYTs59bvr9GOY3r4vA2N5jMTM79FIJhIPkG8KBP1OEpw
         Mmrb7Z5eNK4zeOkxXxvZffTUVytEthG6BgNy4+mBn7/H6l1f5e+0gZMVc5ihJaTo6x3e
         +E2w==
X-Gm-Message-State: AOAM531gInHFsFHoADKbqTCFniRdbS49tcfkHNrAQDwQMJFZg7tBtMZK
        21g1413JkWSLddfTEI/VN/g1V43ozh0=
X-Google-Smtp-Source: ABdhPJxojOmvuNNbkVyPCXaidd5dMF+lwseCCJOLwKnIH4YB0Z4NhGJxpU6ZUErLO/CPrP6jADqBjA==
X-Received: by 2002:a17:906:af79:b0:6ce:61d3:7e9b with SMTP id os25-20020a170906af7900b006ce61d37e9bmr15422622ejb.191.1645439174964;
        Mon, 21 Feb 2022 02:26:14 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id b3sm5004617ejl.67.2022.02.21.02.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:26:14 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     acme@kernel.org, olsajiri@gmail.com, irogers@google.com
Cc:     linux-perf-users@vger.kernel.org
Subject: [PATCH] libperf: Rename arguments of perf_thread_map APIs
Date:   Mon, 21 Feb 2022 12:26:12 +0200
Message-Id: <20220221102612.43879-1-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The "int thread" input arguments of some perf_thead_map APIs are index
of the thread in the thread map. In order to avoid confusion and to
make the APIs consistent with perf_cpu_map APIs, those arguments are
renamed to "int idx".

Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 tools/lib/perf/Documentation/libperf.txt |  6 +++---
 tools/lib/perf/include/perf/threadmap.h  |  6 +++---
 tools/lib/perf/threadmap.c               | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 32c5051c24eb..a21f733b95b1 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -63,10 +63,10 @@ SYNOPSIS
 
   struct perf_thread_map *perf_thread_map__new_dummy(void);
 
-  void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
-  char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
+  void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
+  char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
   int perf_thread_map__nr(struct perf_thread_map *threads);
-  pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
+  pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx);
 
   struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
   void perf_thread_map__put(struct perf_thread_map *map);
diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
index a7c50de8d010..58f7fbdce446 100644
--- a/tools/lib/perf/include/perf/threadmap.h
+++ b/tools/lib/perf/include/perf/threadmap.h
@@ -9,10 +9,10 @@ struct perf_thread_map;
 
 LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
 
-LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
-LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
+LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
+LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
 LIBPERF_API int perf_thread_map__nr(struct perf_thread_map *threads);
-LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
+LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx);
 
 LIBPERF_API struct perf_thread_map *perf_thread_map__get(struct perf_thread_map *map);
 LIBPERF_API void perf_thread_map__put(struct perf_thread_map *map);
diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index e92c368b0a6c..84fa07c79d00 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -32,14 +32,14 @@ struct perf_thread_map *perf_thread_map__realloc(struct perf_thread_map *map, in
 
 #define thread_map__alloc(__nr) perf_thread_map__realloc(NULL, __nr)
 
-void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid)
+void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid)
 {
-	map->map[thread].pid = pid;
+	map->map[idx].pid = pid;
 }
 
-char *perf_thread_map__comm(struct perf_thread_map *map, int thread)
+char *perf_thread_map__comm(struct perf_thread_map *map, int idx)
 {
-	return map->map[thread].comm;
+	return map->map[idx].comm;
 }
 
 struct perf_thread_map *perf_thread_map__new_dummy(void)
@@ -85,7 +85,7 @@ int perf_thread_map__nr(struct perf_thread_map *threads)
 	return threads ? threads->nr : 1;
 }
 
-pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread)
+pid_t perf_thread_map__pid(struct perf_thread_map *map, int idx)
 {
-	return map->map[thread].pid;
+	return map->map[idx].pid;
 }
-- 
2.34.1

