Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0DFC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiAEGPA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbiAEGOl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:41 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7399AC06139A
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:14:40 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x128-20020a627c86000000b004bcb2c85748so4490409pfc.14
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hhL79Wui00dZGSHTjWRVzw6lUcXgmSFmqf1bVRl6br0=;
        b=QQWIKuaAQV7OWXgNCSnzt+Y4XRNpzeM4L+ByfkwwC4PUgTSQLvUUrcseNc66BMqd74
         OXOrzB2aCKQJGTOxFDqHgXrnF/36ryX31nlIj7N025uWmL+jlEYu712JQY9SGJ+Ec5sB
         YPdgBjbibTd3DSDnSN9mwZVmZkSyiSE3pyBc/IuUDrSKCUEiijTRSW5Lgk1H4kvnf/iA
         JHCH7p1J1fIKKX/QjxyyQv8fwqNEFIo8lAaWqsozUKtgGP35ylJDHC71Div9p5LYmHa4
         V00tln/Dbiec7phK/NizcOEEQblCGWjavv/OM0JeZRgwi8l1G8c7RntYVMVunPWNXWyL
         a91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hhL79Wui00dZGSHTjWRVzw6lUcXgmSFmqf1bVRl6br0=;
        b=IXCWEpN+HVvJqsiCJqjILxyJtO8J0ZmjlzJw/9JF37E8DwIAJJJjwHuPBGcmGEonVh
         MGYNx6bDszDZPAuJflS2eASH4FNksBYlihsrJ6BjRC3xbfTa+tGqHCPHP8PDAbl9gwhU
         0ZIY+2NkWX2ihbZSgadL2Re697uCAR/ZH/hlw3fOVAyS3lYaP9DFfka0/Y4LLMvZ22Rq
         fNEMy79x6Srh5JfMw+sCjr/3FPbRzqTo6po694UA8sawbNg30KHJItMW4+Eonm5rGOTS
         wvODGaPn6p1LfZNUmUbQs16GyMUy5V31etuTVh4jiW5SS1BCgwWWJ0I8ADcUp7o/MnOp
         KqTA==
X-Gm-Message-State: AOAM533HRntyTJj6wOfNTvs/pmqFCHyGi7JjVjxHc4GiCxMgWt+TRrcO
        jE53wUwPhCnLKS0LDnQcV/XajaC2COsy
X-Google-Smtp-Source: ABdhPJy6psxdeEBYvd6ijaSaetGP32RibskvFVPWBcYnQl+kvABJM8R+CMks0kndvCEOhkxNVXnCdtByAJZW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a63:724b:: with SMTP id
 c11mr1059529pgn.576.1641363279910; Tue, 04 Jan 2022 22:14:39 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:20 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-18-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 17/48] perf cpumap: Remove cpu_map__cpu, use libperf function.
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

