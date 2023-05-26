Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C5FC7EE23
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244213AbjEZVzn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244226AbjEZVzb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:55:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC01B4
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:54:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bacfa4eefcbso3029218276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138090; x=1687730090;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDuqTopdZxG/tZhzCpsOUxdl3hr1CdgTwDzFadwyJDk=;
        b=cN6RZVoMZUHPAfJbFWf90UK+o6yj3PXDnshig1R3nYUD5nhkJNhZaxPqedUgw2np0N
         mYqfYDOy7bbq5hWyQrqrSHs/B2URvS7pLYFNrGG1xp3OjLsunz0jHq3YCIlR+wUVQXlj
         nH0a5YpIyIi2C780sL6BfvqUiqhPvgURNdv/mtll4gchXtDsjiSWtzBuE1tmc+cgHvtt
         2pB4015qwzMtpIYO/YQjdWLYV9+frAcY2QMgEwhb1nwbXpndDckitvLd7WyjcPXT97B4
         EbBY2K32dtmSOIVh1SXS4d4yotcqKHb0IKvt9Lzr5QypBzni8xSrLtIEvlZRr7tyC0Kx
         E78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138090; x=1687730090;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDuqTopdZxG/tZhzCpsOUxdl3hr1CdgTwDzFadwyJDk=;
        b=TO+paTPKoMZ0si/bHIDM5R17v0JP8jBuv454NPeOowIA0pNbA34edlKz5/j5oC90Ah
         +1EvSP202BZ26XvZe3xMAByA5KSSArVWsfX8XHZrjpSegpywWaQokoibwaqzAMkO9B/A
         WE7VKE5IexHu8LAmpCL9cjwpmP/beY0VDkFg8FQhvHv9c5VLZzJ9frLA6OnYBSR+9meF
         XKbWd2p3o3IKAQcsP2F+YNj7MlzMEuGEog7EJRhLO4Rk862RVVpUVLwHGIFu1bS9e//B
         sQ0YTswlUcsQl/Gfb/kDOcQXj+5W89URgiOmwHjx9mZ4V97Dw2wOUAzUUoJI0UaCYQwT
         s17g==
X-Gm-Message-State: AC+VfDy2lIO4FUOdxxMDCFzx86ZkZrMhvmdJEPU4QsEUgfHVaAyYPWiP
        2X/c4uekcfu8Dc6XeDJG4UaIMnc/LQfT
X-Google-Smtp-Source: ACHHUZ7yTJwEXmiBP+wP6WIVEGmqKho+m3IBcST1HGYx7R+IJnfGD81e4GtwX9lmjT/JG9knJiEXMk4GWHtj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:dc81:0:b0:ba8:1e5f:8514 with SMTP id
 y123-20020a25dc81000000b00ba81e5f8514mr217351ybe.5.1685138090262; Fri, 26 May
 2023 14:54:50 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:51 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-17-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 16/35] perf pmu: Remove perf_pmu__hybrid_mounted
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

perf_pmu__hybrid_mounted is used to detect whether cpu_core or
cpu_atom is mounted with a non-empty cpus file by
pmu_lookup. Discussion [1] showed the empty cpus file check to be
redundant and so pmu_lookup needn't have a call to
perf_pmu__hybrid_mounted.

Checking hybrid_mounted in pmu_is_uncore is redundant as the next
cpumask read will fail returning false.

Reduce the scope of perf_pmu__find_hybrid_pmu by making it static.

[1] https://lore.kernel.org/lkml/20230524221831.1741381-17-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu-hybrid.c | 15 +--------------
 tools/perf/util/pmu-hybrid.h |  3 ---
 tools/perf/util/pmu.c        | 13 +------------
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index bc4cb0738c35..7fe943dd3217 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -18,20 +18,7 @@
 
 LIST_HEAD(perf_pmu__hybrid_pmus);
 
-bool perf_pmu__hybrid_mounted(const char *name)
-{
-	int cpu;
-	char pmu_name[PATH_MAX];
-	struct perf_pmu pmu = {.name = pmu_name};
-
-	if (strncmp(name, "cpu_", 4))
-		return false;
-
-	strlcpy(pmu_name, name, sizeof(pmu_name));
-	return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
-}
-
-struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
+static struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
 {
 	struct perf_pmu *pmu;
 
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
index 206b94931531..8dbcae935020 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -13,9 +13,6 @@ extern struct list_head perf_pmu__hybrid_pmus;
 #define perf_pmu__for_each_hybrid_pmu(pmu)	\
 	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
 
-bool perf_pmu__hybrid_mounted(const char *name);
-
-struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
 bool perf_pmu__is_hybrid(const char *name);
 
 static inline int perf_pmu__hybrid_pmu_num(void)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cd94abe7a87a..83c7eeb8abea 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -617,9 +617,6 @@ static bool pmu_is_uncore(int dirfd, const char *name)
 {
 	int fd;
 
-	if (perf_pmu__hybrid_mounted(name))
-		return false;
-
 	fd = perf_pmu__pathname_fd(dirfd, name, "cpumask", O_PATH);
 	if (fd < 0)
 		return false;
@@ -907,15 +904,8 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	LIST_HEAD(aliases);
 	__u32 type;
 	char *name = pmu_find_real_name(lookup_name);
-	bool is_hybrid = perf_pmu__hybrid_mounted(name);
 	char *alias_name;
 
-	/*
-	 * Check pmu name for hybrid and the pmu may be invalid in sysfs
-	 */
-	if (!strncmp(name, "cpu_", 4) && !is_hybrid)
-		return NULL;
-
 	/*
 	 * The pmu data we store & need consists of the pmu
 	 * type value and format definitions. Load both right
@@ -936,7 +926,6 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 
 	pmu->cpus = pmu_cpumask(dirfd, name);
 	pmu->name = strdup(name);
-
 	if (!pmu->name)
 		goto err;
 
@@ -967,7 +956,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
 
-	if (is_hybrid)
+	if (!strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom"))
 		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
 	else
 		INIT_LIST_HEAD(&pmu->hybrid_list);
-- 
2.41.0.rc0.172.g3f132b7071-goog

