Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C38C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbhL3HVd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbhL3HVW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AFAC061746
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v189-20020a2561c6000000b0060b5814a17eso26924028ybb.22
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hhL79Wui00dZGSHTjWRVzw6lUcXgmSFmqf1bVRl6br0=;
        b=W/fRAMC9kpPrEwbcvMgEXG7F9Cl6rN5fk2gbWiip8f1tvb35R7EkbWYsWtjKwnGx31
         6458ZpyDPuljmbZitSfAoDeLyp+L4gLiUJOR+kUTuZUBzuGyqKOyU8gwb/VUn1cfu5Xb
         bSavnCEULtqH35kSm5tKiIv+7db4/OxK1ovSNMRYFHH6jKCDnNHdejGLaK5HH2+iSOGs
         U0P5lZmaJb7bnm0Zr+VXBFILii+scZ56YZyh67ksndHuLTRM/LlgcQK+aTJw3FiFU95O
         eupdDGJba1WEO5ZyEk3Pv2W5n3y290I1yiYCoPphHpGJip/SG/QRBLeQxQwg/WiHR1uF
         HZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hhL79Wui00dZGSHTjWRVzw6lUcXgmSFmqf1bVRl6br0=;
        b=7BR0XuTDvspBXsIahafBbTj7hnhnhTiY3BEoJQDWPgLY8JPmQ1jRlWZyKSys699tai
         u/jg/MtwOKsTWxK98rbP73w5p2SjJrt5XHmUDLmF+LhkrxXj6MArpqbNzMugSjKrpYgk
         JPn26ymk46197E10T3MgcDDPuBY7xdvYvlmib9P8MP4x+/IkSokMHuHdCxoCzVqPpevQ
         +F+jKcfIJiYUaabYlKi9VIpSGuoM12p+/+054f+NqDZDlbrwYiEK745gq41gVaqfX5Yw
         M/fytxaSBU4VvEaxEyPO9uk+s4QTxCxrAgyrgXZi8jbVa1W2LgCp99rkj/t/s0h+pMB2
         YlDw==
X-Gm-Message-State: AOAM531Mu8adPyTjsciS0JVxlPNzhSDC9oweMzKR7FhehT63HMdAnKIK
        nHinT9wqSmJZ9CQfHPAcEJpxlC0wn3g1
X-Google-Smtp-Source: ABdhPJw354XwUZfwTBDRfRyvXFfv5WltLOFmo0PhT3He8ODD0IPkVaOuwJseB0/EjcNjYitQD/bT3pZWBsm1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:186:: with SMTP id 128mr17816765ybb.244.1640848880990;
 Wed, 29 Dec 2021 23:21:20 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:59 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-19-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 17/48] perf cpumap: Remove cpu_map__cpu, use libperf function.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Switch the remaining few users of cpu_map__cpu to perf_cpu_map__cpu and
remove the function.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c | 2 +-
 tools/perf/util/cpumap.c    | 9 ++-------
 tools/perf/util/cpumap.h    | 1 -
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 2b54e2ddc80a..f16c39a37a52 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -281,7 +281,7 @@ static int set_tracing_cpumask(struct perf_cpu_map *cpumap)
 	int ret;
 	int last_cpu;
 
-	last_cpu = cpu_map__cpu(cpumap, cpumap->nr - 1);
+	last_cpu = perf_cpu_map__cpu(cpumap, cpumap->nr - 1);
 	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
 	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index e0d7f1da5858..32f9fc2dd389 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -485,11 +485,6 @@ bool cpu_map__has(struct perf_cpu_map *cpus, int cpu)
 	return perf_cpu_map__idx(cpus, cpu) != -1;
 }
 
-int cpu_map__cpu(struct perf_cpu_map *cpus, int idx)
-{
-	return cpus->map[idx];
-}
-
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 {
 	int i, cpu, start = -1;
@@ -547,7 +542,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	int i, cpu;
 	char *ptr = buf;
 	unsigned char *bitmap;
-	int last_cpu = cpu_map__cpu(map, map->nr - 1);
+	int last_cpu = perf_cpu_map__cpu(map, map->nr - 1);
 
 	if (buf == NULL)
 		return 0;
@@ -559,7 +554,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	}
 
 	for (i = 0; i < map->nr; i++) {
-		cpu = cpu_map__cpu(map, i);
+		cpu = perf_cpu_map__cpu(map, i);
 		bitmap[cpu / 8] |= 1 << (cpu % 8);
 	}
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index a053bf31a3f0..87545bcd461d 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -80,7 +80,6 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 		       struct aggr_cpu_id (*f)(int cpu, void *data),
 		       void *data);
 
-int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
 
 bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
-- 
2.34.1.448.ga2b2bfdf31-goog

