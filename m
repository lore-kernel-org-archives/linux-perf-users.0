Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CEAC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Sep 2021 02:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C539361090
	for <linux-perf-users@archiver.kernel.org>; Sun, 26 Sep 2021 02:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhIZCSd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 25 Sep 2021 22:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhIZCSd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 25 Sep 2021 22:18:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FD8C061570;
        Sat, 25 Sep 2021 19:16:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k17so12375639pff.8;
        Sat, 25 Sep 2021 19:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDTDNI4hUP1MqVt0nccZ7JttotmBsczDXF+BDCFJhk8=;
        b=obidVrG9+JqOCl/vfnoHCNS8400ftOh8dYnnHHDyJ25txVnP4T5xTFUmKsx/0N8MZ5
         vGqBu6eo1q98LGVTt5OOTlUiBbQ4v3vkiFEUQ+mhKz0QyPfxdbXWYEE/8uG9hdh4asBk
         eSrCdCkL+0sj3XwLT/LglguGipjW4htjw6FfNgTFo9ZCn4RBxltQ/ABKWRrxwnjXOF9X
         U47z+pEd6klbBaiIyWSxGLsYQFbRFBLYPfoy1jiY+XrYU8GvvG6MNgla23FVXakIWTkO
         P5X1p47IGwvnTTVk2RZrvUw0b3GHqtoC/Xdj+FclQ7RJCkVZuBJ4G/OPaKr5FjMmVCro
         /8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDTDNI4hUP1MqVt0nccZ7JttotmBsczDXF+BDCFJhk8=;
        b=BF77S9/moFuYFOU5FwzLpFmj7d6ogI4MW8n9oirMhN2x5uES5YzBuunFaeGIserLWc
         kKDJEEkItM+l+cRAJ6oB8do448NNWNKnaGE+SEcMXjq0xAiR4/pFibdoW22MAP/hcMRc
         1cPPZrN5miTwtJGcxoN53ubr2fjO9gHgX0iv16tSZ0s9kBcF+vkbv+soscbf1xvT5eoE
         ruKSwqIGPrZbrLvcrMpHS9jCG0qxgsgXw3Ge3GMZ2Ie/Z+q5rEf9u1ar/z+lHkodTWkv
         CVFvgGxkNHTv6BcCZLDA656FyOtHd4KTBDk2iE1PCunbyZVdX8fSlr0yoC6Ws7gsFb8H
         hXvA==
X-Gm-Message-State: AOAM532Fv8fBIC0dtoMTav/vxJaZxXwjoaua8xq3ljq3lNHgGhGdjUpU
        1YMwYW3ZycFOXB64lac0qFE=
X-Google-Smtp-Source: ABdhPJwC+kphnXVUMRQ5QDZemn3M8PaLKgPxvRx2pws2HDiYSCJs5uIf6hczNjQlndELZnY5KAEfKw==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr16641892pfj.15.1632622617299;
        Sat, 25 Sep 2021 19:16:57 -0700 (PDT)
Received: from titan.. ([2601:644:8300:136:a6bb:6dff:feb6:3500])
        by smtp.gmail.com with ESMTPSA id w8sm13166829pfc.93.2021.09.25.19.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 19:16:56 -0700 (PDT)
From:   Jinshan Xiong <jinshan.xiong@gmail.com>
To:     jolsa@redhat.com
Cc:     Jinshan Xiong <jinshan.xiong@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/lib/perf: add a flag to specify cgroup fd
Date:   Sat, 25 Sep 2021 19:15:25 -0700
Message-Id: <20210926021611.2312331-1-jinshan.xiong@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch adds an API perf_thread_map__set_flags() so that we can use
it to pass down a flag to specific cgroup fd in sys_perf_event_open().

This API can be used in the following way:
    int cgroup_fd = open("/sys/fs/cgroup/perf_event", O_RDONLY);
    struct thread_map *threadmap = perf_thread_map__new_dummy();
    perf_thread_map__set_pid(threadmap, 0, cgroup_fd);
    perf_thread_map__set_flags(threadmap, 0, PERF_FLAG_PID_CGROUP);

Therefore, we can only collect perf events in a specific docker
container.

Signed-off-by: Jinshan Xiong <jinshan.xiong@gmail.com>
---
 tools/lib/perf/evsel.c                      | 3 ++-
 tools/lib/perf/include/internal/threadmap.h | 1 +
 tools/lib/perf/include/perf/threadmap.h     | 1 +
 tools/lib/perf/threadmap.c                  | 5 +++++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 8441e3e1aaac..67f86513a816 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -153,7 +153,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
-						 cpus->map[cpu], group_fd, 0);
+						 cpus->map[cpu], group_fd,
+						 threads->map[thread].flags);
 
 			if (fd < 0)
 				return -errno;
diff --git a/tools/lib/perf/include/internal/threadmap.h b/tools/lib/perf/include/internal/threadmap.h
index df748baf9eda..5d7bd6968563 100644
--- a/tools/lib/perf/include/internal/threadmap.h
+++ b/tools/lib/perf/include/internal/threadmap.h
@@ -8,6 +8,7 @@
 
 struct thread_map_data {
 	pid_t	 pid;
+	int	 flags;
 	char	*comm;
 };
 
diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
index a7c50de8d010..5fea1a403e28 100644
--- a/tools/lib/perf/include/perf/threadmap.h
+++ b/tools/lib/perf/include/perf/threadmap.h
@@ -10,6 +10,7 @@ struct perf_thread_map;
 LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
 
 LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
+LIBPERF_API void perf_thread_map__set_flags(struct perf_thread_map *map, int thread, int flags);
 LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
 LIBPERF_API int perf_thread_map__nr(struct perf_thread_map *threads);
 LIBPERF_API pid_t perf_thread_map__pid(struct perf_thread_map *map, int thread);
diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
index e92c368b0a6c..3b8ec4f944b9 100644
--- a/tools/lib/perf/threadmap.c
+++ b/tools/lib/perf/threadmap.c
@@ -37,6 +37,11 @@ void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid
 	map->map[thread].pid = pid;
 }
 
+void perf_thread_map__set_flags(struct perf_thread_map *map, int thread, int flags)
+{
+	map->map[thread].flags = flags;
+}
+
 char *perf_thread_map__comm(struct perf_thread_map *map, int thread)
 {
 	return map->map[thread].comm;
-- 
2.30.2

