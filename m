Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2EDC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Feb 2022 10:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiBKKe7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:34:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348979AbiBKKeo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE939EA6
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 02:34:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m10-20020a25800a000000b0061daa5b7151so17828042ybk.10
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 02:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v/iVwWwVZ57NlyJcDZTSYN4OejpmhBwgHB1+GcNUvds=;
        b=SS4GGPur+8C8MhWOAfUpC++73BZ9x4vvPHZZvzTQ8+TevlAupjKwjyXhJQhlHRfhs5
         UPycDJ/IMAzAWlMGtZP9x1VNCODHQIKGk4OqBDTn96LxeDV65HSAk7VupIgcdLF/Af+u
         vQl22zYp2B44p0i1mrPqULatJPeo+50/U0YmcMNnizTsEAxrFIRx8bLzFp7UFNWPz41V
         89ME3ox7joS7WyicJSXOU/CFKuXeZZdknpDWkd8QNhhKzpr05y/kA3+rAep/vmpGwAKY
         fV+kfLdHQhYDh42Hl0NWrDMRhOxzSHh+3cewa5hBvTO2KazQMP1/tBbJcpFspHorxiMv
         hDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v/iVwWwVZ57NlyJcDZTSYN4OejpmhBwgHB1+GcNUvds=;
        b=0GJANgpkrUlO4QQwCM3wFDDE44oEsDth+R7vcj1NEya98I/b6zN1fcbI39ANc5Xn88
         Zill2PcSLzNSAyBiTimxtqTUjcGieMyaUi1s0auzrxpfzgt3iMsy2Rk3BdLU/ut496f+
         fML2OAG6ahuNDSa9TlH9O0jmFqE783Y4FbBXWpYuYnu1+pNCECcao4AoAWY2RKVu3jOd
         cmadboSoX2NTyi74fEF/leQ9KnXXdnu7gVL7w+QZEKMmVnVUP5hLG0OWI/0pgHMq0674
         Us+DbHYF750cP89Ijtu1y0u5WulG7vnlhuZnKMhTBZPy7ZTAUraA9OJ/zCgem5ZQJGT5
         2IeA==
X-Gm-Message-State: AOAM533P8JSPD4JxsfCFZLuj1hjsOdmJxlH8Tfgxx7xWXo+dS+TsCn/C
        ZvudBk8WaNLQAkHYsnChJ0PXS1XvnLZg
X-Google-Smtp-Source: ABdhPJwYNGXn+AssFsFdcI8ZqXlyNvl2Eh8f07LSi+lLqPFZ5RtMlLLP8Jv5Zzv/mrATVgq8k0FuiMjoP50x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a25:cb90:: with SMTP id
 b138mr674042ybg.33.1644575682916; Fri, 11 Feb 2022 02:34:42 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:34:02 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-10-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 09/22] perf map: Add const to map_ip and unmap_ip
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Functions purely determine a value from the map and don't need to modify
it. Move functions to C file as they are most commonly used via a
function pointer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.c | 15 +++++++++++++++
 tools/perf/util/map.h | 24 ++++++++----------------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 2cfe5744b86c..b98fb000eb5c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -563,3 +563,18 @@ struct maps *map__kmaps(struct map *map)
 	}
 	return kmap->kmaps;
 }
+
+u64 map__map_ip(const struct map *map, u64 ip)
+{
+	return ip - map->start + map->pgoff;
+}
+
+u64 map__unmap_ip(const struct map *map, u64 ip)
+{
+	return ip + map->start - map->pgoff;
+}
+
+u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip)
+{
+	return ip;
+}
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 973dce27b253..212a9468d5e1 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -29,9 +29,9 @@ struct map {
 	u64			reloc;
 
 	/* ip -> dso rip */
-	u64			(*map_ip)(struct map *, u64);
+	u64			(*map_ip)(const struct map *, u64);
 	/* dso rip -> ip */
-	u64			(*unmap_ip)(struct map *, u64);
+	u64			(*unmap_ip)(const struct map *, u64);
 
 	struct dso		*dso;
 	refcount_t		refcnt;
@@ -44,20 +44,12 @@ struct kmap *__map__kmap(struct map *map);
 struct kmap *map__kmap(struct map *map);
 struct maps *map__kmaps(struct map *map);
 
-static inline u64 map__map_ip(struct map *map, u64 ip)
-{
-	return ip - map->start + map->pgoff;
-}
-
-static inline u64 map__unmap_ip(struct map *map, u64 ip)
-{
-	return ip + map->start - map->pgoff;
-}
-
-static inline u64 identity__map_ip(struct map *map __maybe_unused, u64 ip)
-{
-	return ip;
-}
+/* ip -> dso rip */
+u64 map__map_ip(const struct map *map, u64 ip);
+/* dso rip -> ip */
+u64 map__unmap_ip(const struct map *map, u64 ip);
+/* Returns ip */
+u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
 
 static inline size_t map__size(const struct map *map)
 {
-- 
2.35.1.265.g69c8d7142f-goog

