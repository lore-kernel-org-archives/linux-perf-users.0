Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5DDC7EE23
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbjEZV47 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244261AbjEZV42 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:56:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0802C10FF
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:55:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bad1c8dce48so1840679276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138119; x=1687730119;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWjpW1u76sBxbsm1hYEhA0qZQ3555o3L2cIJC7DUwoI=;
        b=Pqi2RY0gp1d4rWnKg5tMvNvJV+6YQ4Iv3/YfBY/0/ZxAHBiPmz7i8PVDcEFHsDKIpC
         1eXIrPALzIVeM6SgkajaJS3WDDYiDWK0igrzGok4XkRP9+KymLXeB4cx3VwfAeGTw/T0
         oizkz4/zJpAdYaXkVRPoDiGwExRFSz/PbVS6XErYXS6IOu31JtQXuJNmjtKp5Fm26Fxw
         HzgGexdvvdnHnhSywNOm0LXnY6L/EddF1ohOrGZzYypOf2NdjxbFfGOhO7ujZLZrnVip
         xPprjYgr/dR7EhPPVfYG+MqYZcIQXUE9djG6v9Dz63UYwEj8EESwaeWPukk/vYO4BCot
         0Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138119; x=1687730119;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWjpW1u76sBxbsm1hYEhA0qZQ3555o3L2cIJC7DUwoI=;
        b=hU/p8detF2n375X9q0WHT9J8LR+q3rXIQxJs4wJWKD3r1EGiCGvcNAT7T4uF04GApZ
         ofQlrmoD6NCaMPDOX58pLCBxld6dJmBiSwRBFoJYR1B7k1Gn+b2iydshage3okaUwHjA
         RtnO5UZhlxureKvdeUbgOplNiKiq9fHQ2sMaWWQWig/g+2S7u6VM6Q1d9SRc3XWT+scb
         435tUAkzsfqNVkLYopfq65X/wY2AO3n4d0G0IcJxYxsjX1w5B5RA0I5tOuCPYjNbbKuz
         7iRB+JnrzBa17h6+gJzXhBRxuPFoB7fWMY5zdHSlR31Ahj5FkKI2gh0ufYs+SVs2/6ey
         qhLw==
X-Gm-Message-State: AC+VfDzn8lhjfPoaG8GAEiXVfGjnTBYgGrmelIrgI7KhpJYwm853XxS3
        YTmsL7uNJ4UMBOOX9CRcexuJAEvhggic
X-Google-Smtp-Source: ACHHUZ4C3ngzT52VBFoUiSc1f/YidlmtHxZJbZ+IMGAvn52S50DrIorMenlPZjXaVLl1md5/rMj/AzEtanjq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a05:6902:1206:b0:bac:f387:735b with SMTP
 id s6-20020a056902120600b00bacf387735bmr1234872ybu.13.1685138118999; Fri, 26
 May 2023 14:55:18 -0700 (PDT)
Date:   Fri, 26 May 2023 14:54:04 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-30-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 29/35] perf pmus: Split pmus list into core and other
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

Split the pmus list into core and other. This will later allow for
the core and other pmus to be populated separately.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 58ff7937e9b7..4ef4fecd335f 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -12,13 +12,19 @@
 #include "pmu.h"
 #include "print-events.h"
 
-static LIST_HEAD(pmus);
+static LIST_HEAD(core_pmus);
+static LIST_HEAD(other_pmus);
 
 void perf_pmus__destroy(void)
 {
 	struct perf_pmu *pmu, *tmp;
 
-	list_for_each_entry_safe(pmu, tmp, &pmus, list) {
+	list_for_each_entry_safe(pmu, tmp, &core_pmus, list) {
+		list_del(&pmu->list);
+
+		perf_pmu__delete(pmu);
+	}
+	list_for_each_entry_safe(pmu, tmp, &other_pmus, list) {
 		list_del(&pmu->list);
 
 		perf_pmu__delete(pmu);
@@ -29,7 +35,12 @@ static struct perf_pmu *pmu_find(const char *name)
 {
 	struct perf_pmu *pmu;
 
-	list_for_each_entry(pmu, &pmus, list) {
+	list_for_each_entry(pmu, &core_pmus, list) {
+		if (!strcmp(pmu->name, name) ||
+		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
+			return pmu;
+	}
+	list_for_each_entry(pmu, &other_pmus, list) {
 		if (!strcmp(pmu->name, name) ||
 		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
 			return pmu;
@@ -53,7 +64,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
 		return pmu;
 
 	dirfd = perf_pmu__event_source_devices_fd();
-	pmu = perf_pmu__lookup(&pmus, dirfd, name);
+	pmu = perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &other_pmus, dirfd, name);
 	close(dirfd);
 
 	return pmu;
@@ -72,7 +83,7 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	if (pmu)
 		return pmu;
 
-	return perf_pmu__lookup(&pmus, dirfd, name);
+	return perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &other_pmus, dirfd, name);
 }
 
 /* Add all pmus in sysfs to pmu list: */
@@ -93,7 +104,7 @@ static void pmu_read_sysfs(void)
 	while ((dent = readdir(dir))) {
 		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
 			continue;
-		/* add to static LIST_HEAD(pmus): */
+		/* add to static LIST_HEAD(core_pmus) or LIST_HEAD(other_pmus): */
 		perf_pmu__find2(fd, dent->d_name);
 	}
 
@@ -104,24 +115,37 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 {
 	struct perf_pmu *pmu;
 
-	list_for_each_entry(pmu, &pmus, list)
+	list_for_each_entry(pmu, &core_pmus, list) {
 		if (pmu->type == type)
 			return pmu;
-
+	}
+	list_for_each_entry(pmu, &other_pmus, list) {
+		if (pmu->type == type)
+			return pmu;
+	}
 	return NULL;
 }
 
+/*
+ * pmu iterator: If pmu is NULL, we start at the begin, otherwise return the
+ * next pmu. Returns NULL on end.
+ */
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
 {
-	/*
-	 * pmu iterator: If pmu is NULL, we start at the begin,
-	 * otherwise return the next pmu. Returns NULL on end.
-	 */
+	bool use_core_pmus = !pmu || pmu->is_core;
+
 	if (!pmu) {
 		pmu_read_sysfs();
-		pmu = list_prepare_entry(pmu, &pmus, list);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	}
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list)
+			return pmu;
+
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
 	}
-	list_for_each_entry_continue(pmu, &pmus, list)
+	list_for_each_entry_continue(pmu, &other_pmus, list)
 		return pmu;
 	return NULL;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

