Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C953C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbhL3HUs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhL3HUr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:20:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DDC06173F
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:20:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s127-20020a252c85000000b0060be2b7b8e9so24391079ybs.8
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HQ0F4Wkpc2hZGLs9o4VVEd71gbRETuZn+IEXms79S7Y=;
        b=FD7ZPImddyL2cAMf3QezttcpbIzDG2J9TwTaFHD3Ruo2dwTWNKkd0Rk3IM7BiKFLlj
         H8VJPHGgAB+zmaij4pvzxfZaRiSM5VtLO6B+rAJYuzuYfFA9B+bpRODDbGbqHsPdUeik
         JpToHcLcRG4IusO6rxUxZd8yjkhEBjfFf20SHdgp3wpNbIBtz6vs26epU6ckOpQ/UcIS
         9MA6dPnFgqp0+Tc83Xi/mWAsFXUQ8Y4jawSqtzba5jj5zkFbL+ue/lnj7vQWRqeNix8n
         L36jLP7y2ciGmq6/IaAzgWEsrPk1+K+o78N+KAdNdvmihM5jboVIdbSd+/HoOO2W4Bee
         dIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HQ0F4Wkpc2hZGLs9o4VVEd71gbRETuZn+IEXms79S7Y=;
        b=xbR2ECgbIZB16r3bLtlYM76Dl38TLAItEQnOlERJodC+UTBgcZXNpa9Q3/qtOgYTOU
         25HurC0U9s9QQ7iUnEHtZsfGrKeY2fI6BeRwkIDpGepI7YNZOYjl3LsJDeDhbDpFBRMa
         e44nMETkSYL0KoylZz+8Ic+27SSZFTZus2w/6gc3mQycWfDicUwnBz6ifNzYlo2a6hRT
         Kv4VFHr2iiepH/xvzN9qFyIF9lmNJTFewmBUFQa/wvBFazRGdFEVCNTn7hEWhywQiWuF
         jvmIo2KSal+Y7O1VQfPgB0i4Z0BD5fpcRUj9CA8RNdr7E6zX4Zlnr8LIeLoeiFtTrydP
         ivXA==
X-Gm-Message-State: AOAM530GhIOYXcnvw1lLT8T785a57H44//K5hcRtabxJ2tdtDRvpVDeZ
        DgZ2B6X6HsfCJxJI3RWEzthmOlx5cJQS
X-Google-Smtp-Source: ABdhPJwYc6sI6/tU+488uQ6TPKBQHt6h6pGnihwygMdw5SVRUcXB7K6/76412r9nXLTCLzEk+BdjcwqsuW62
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:d78f:: with SMTP id
 o137mr21538140ybg.19.1640848846260; Wed, 29 Dec 2021 23:20:46 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:45 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-5-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 03/48] perf stat: Correct aggregation CPU map
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

Switch the perf_cpu_map in aggr_update_shadow from
the evlist to the counter's cpu map, so the index is appropriate. This
addresses a problem where uncore counts, with a cpumap like:
$ cat /sys/devices/uncore_imc_0/cpumask
0,18
Don't aggregate counts in CPUs based on the index of those values in the
cpumap (0 and 1) but on the actual CPU (0 and 18). Thereby correcting
metric calculations in per-socket mode for counters without a full
cpumask.

On a SkylakeX with a tweaked DRAM_BW_Use metric, to remove unnecessary
scaling, this gives:

Before:
$ /perf stat --per-socket -M DRAM_BW_Use -I 1000
     1.001102293 S0        1              27.01 MiB  uncore_imc/cas_count_write/ #   103.00 DRAM_BW_Use
     1.001102293 S0        1              30.22 MiB  uncore_imc/cas_count_read/
     1.001102293 S0        1      1,001,102,293 ns   duration_time
     1.001102293 S1        1              20.10 MiB  uncore_imc/cas_count_write/ #     0.00 DRAM_BW_Use
     1.001102293 S1        1              32.74 MiB  uncore_imc/cas_count_read/
     1.001102293 S1        0      <not counted> ns   duration_time
     2.003517973 S0        1              83.04 MiB  uncore_imc/cas_count_write/ #   920.00 DRAM_BW_Use
     2.003517973 S0        1             145.95 MiB  uncore_imc/cas_count_read/
     2.003517973 S0        1      1,002,415,680 ns   duration_time
     2.003517973 S1        1             302.45 MiB  uncore_imc/cas_count_write/ #     0.00 DRAM_BW_Use
     2.003517973 S1        1             290.99 MiB  uncore_imc/cas_count_read/
     2.003517973 S1        0      <not counted> ns   duration_time

After:
$ perf stat --per-socket -M DRAM_BW_Use -I 1000
     1.001080840 S0        1              24.96 MiB  uncore_imc/cas_count_write/ #    54.00 DRAM_BW_Use
     1.001080840 S0        1              33.64 MiB  uncore_imc/cas_count_read/
     1.001080840 S0        1      1,001,080,840 ns   duration_time
     1.001080840 S1        1              42.43 MiB  uncore_imc/cas_count_write/ #    84.00 DRAM_BW_Use
     1.001080840 S1        1              47.05 MiB  uncore_imc/cas_count_read/
     1.001080840 S1        0      <not counted> ns   duration_time

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 588601000f3f..b0fa81ffce61 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -526,7 +526,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
 			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
-				s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);
+				s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
 				if (!cpu_map__compare_aggr_cpu_id(s2, id))
 					continue;
 				val += perf_counts(counter->counts, cpu, 0)->val;
-- 
2.34.1.448.ga2b2bfdf31-goog

