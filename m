Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190A3C77B73
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbjEZVyz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243817AbjEZVyp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:54:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6489D1B6
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:54:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bad0f5d6a7dso2466859276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138072; x=1687730072;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Augb3j/jljgyjV1KGpr82Z0gyjkQotdR/6uQepIkE7U=;
        b=2kB3hJaQUgcEcaVDXNq/fd3gWdE2bSBqcIL0t1IGnwV28LbcccROJklvngJeFV4DSq
         DufbTJ6/obrK8AhJrpMqL+XNuQmA06Avd4EHY87ZAOSlNYz3P8jqh8ujdXyqvxWOD6oT
         HVHoOwHoHvlyWmr/ArSlJeVgBFTbnUVTL6MW00xvMB349pRYplMeGvpg1Nm965u1sBid
         efvKaDXKZrijDyU9jIyvnlcEoeV5Dj2yo8ZtLt9ewIiMR6ZD+5WmT7YMIkSAyBr6QIbX
         dl4kDKcouAq6ZfyDZjGoSUDivoA53h8d8tr2otGAoSiVcHTTDFqyvRrvZdX0w1EdZ74T
         O48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138072; x=1687730072;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Augb3j/jljgyjV1KGpr82Z0gyjkQotdR/6uQepIkE7U=;
        b=XHcuVoF27Xeu/5U2e38EHYjoMQ4H3os0bIIku4PxTKc07qfnqgjMhRyMyUXUoRjpyi
         52s4mroxt7tWZnX5cnkiA5gbuvAmNb82z+jfi44TWlrTg2ByQcen4sn4meB+eEIFntDo
         q22F2zEX2C/sF527K3qCQIhaI1VpbpHSyHtNxjMyaEhUCh1vVUUVo2nBxywER60pZuM4
         1PoAr67ga105bWbLd0cGR3mdFRwhudXhusq8xvJJTcxJLfGY5YsS+risDnqxFDtUdji/
         6nW74+cU4yQG6W7KcDMB3WFhnXkHXlifz0fyjN2SDB6JHudazCVRww7LNEmIM05XPDTx
         c2CA==
X-Gm-Message-State: AC+VfDxZ9uftf58me046hCDfMoChuzwqPIF9VaaZBE9x8+fEQhgk2MEs
        n+LmZJ+4iz41S9jOOfclO2VOZsgGMtrT
X-Google-Smtp-Source: ACHHUZ5Nc508/25y5ajVWer0jZNeXKoT9lajVUzrqi2/BXoSY3vyyg0yHWgTWVWgkvFow+yWC1Tg5DfwgH5c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:d690:0:b0:bad:4bb:c440 with SMTP id
 n138-20020a25d690000000b00bad04bbc440mr1706799ybg.10.1685138072366; Fri, 26
 May 2023 14:54:32 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:43 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-9-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 08/35] perf pmu: Add CPU map for "cpu" PMUs
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

A typical "cpu" PMU has no "cpus" or "cpumask" file meaning the CPU
map is set to NULL, which also encodes an empty CPU map. Update
pmu_cpumask so that if the "cpu" PMU fails to load a CPU map, use a
default of all online PMUs.

Remove const from cpu_map__online for the sake of reference counting.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/cpumap.c | 4 ++--
 tools/perf/util/cpumap.h | 4 ++--
 tools/perf/util/pmu.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 75d9c73e0184..75c5bed37805 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -663,9 +663,9 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	return ptr - buf;
 }
 
-const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
+struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 {
-	static const struct perf_cpu_map *online = NULL;
+	static struct perf_cpu_map *online;
 
 	if (!online)
 		online = perf_cpu_map__new(NULL); /* from /sys/devices/system/cpu/online */
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index e3426541e0aa..05201b31810c 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -48,7 +48,7 @@ struct perf_cpu_map *cpu_map__new_data(const struct perf_record_cpu_map_data *da
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
-const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
+struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
 int cpu__setup_cpunode_map(void);
 
@@ -59,7 +59,7 @@ struct perf_cpu cpu__max_present_cpu(void);
 /**
  * cpu_map__is_dummy - Events associated with a pid, rather than a CPU, use a single dummy map with an entry of -1.
  */
-static inline bool cpu_map__is_dummy(struct perf_cpu_map *cpus)
+static inline bool cpu_map__is_dummy(const struct perf_cpu_map *cpus)
 {
 	return perf_cpu_map__nr(cpus) == 1 && perf_cpu_map__cpu(cpus, 0).cpu == -1;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e8c0762c311a..d992f5242d99 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -610,7 +610,7 @@ static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name)
 			return cpus;
 	}
 
-	return NULL;
+	return !strcmp(name, "cpu") ? perf_cpu_map__get(cpu_map__online()) : NULL;
 }
 
 static bool pmu_is_uncore(int dirfd, const char *name)
-- 
2.41.0.rc0.172.g3f132b7071-goog

