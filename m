Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BE6C77B75
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 May 2023 14:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjEQO7Y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 May 2023 10:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbjEQO65 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2023 10:58:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B848690
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:58:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337a578dso1005357276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335531; x=1686927531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KA2y3jyQTsl7bjOICY6NhHPKj7ufhNOPyvMqFoPtgZA=;
        b=nljeFfxFSjqFfJqFStpIFN0yXSLDlIJAsXrvpuUvYrzfgwPDYXCv05IGjt8JAYLOMu
         GIWqE6phlYNkqkWg1UlvdP9uFzTnCLcKUhhQZhxm0Hpim9t+Z0kHz+ttA/5X72bOa/HG
         gIXZGSBzf9lnCHE0W2XP4S6w8Sqj0vZ+OnuTQAtK0jDwkc52avQEgxhjfSnwPT8NTkKm
         ZqGMOALc5jdW8KC/iXGwy2CMR5Xz/bEot5QGTbz3PBAgzvxOa/0U+N4xOxh07EgCnS1a
         hV4fKa3uvhrgW4ZWmwNZZGwysWZKpw8xHvj6xyvlf+wFUmfwd6vofN5SIYMFcd4Usfu+
         8YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335531; x=1686927531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KA2y3jyQTsl7bjOICY6NhHPKj7ufhNOPyvMqFoPtgZA=;
        b=UkHcAKQONPpYIobmaHWlga4S3gGc4bC8K8Kq6r1B9c+v5qzQISfvnmHABEAx4q8Y9Y
         Mx+ZQNCxIdmo1jq28UTgJSk9HwCvHddfrPFeORrgeayPSsBX+bL6cONggTjqeOwuy3l2
         g4fOjneKY47qUubypy/5+vnR0s5I/OauG9o/AdP/2gt2n/OS/ipvROSEej3zg7rKAeZD
         0vfCOt4a3J/suUbriVOXUeC40dG9FMHng2sMvhm3tRXX7wa6Ml6rwptO/nj5ifvJqGSO
         nowY5njEXvjGBdQpJ5F7R9EJM3ToCFUX7KSlWb6m9059xzt5gg11fgSra0JNjYwCPHD0
         d4og==
X-Gm-Message-State: AC+VfDwUHNArJshA4zsagFsqiJ1CJEdV6fpHQRImJp2N5Z/KYZOev6yT
        ehxzx6kPZYKwAcS3aZxs0s89KNd11I6G
X-Google-Smtp-Source: ACHHUZ7XjP/AcWyCffYYC9nXeJBjM5TS+YMrfsqU5e91nSKBzb1vGFoVNbDb5wbW3KyZZ72fzUAIER8KKBrj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:3211:0:b0:ba8:2415:f27c with SMTP id
 y17-20020a253211000000b00ba82415f27cmr3416215yby.3.1684335531452; Wed, 17 May
 2023 07:58:51 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:47 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-8-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 07/23] perf pmu: Add is_core to pmu
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
        Raul Silvera <rsilvera@google.com>,
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

Cache is_pmu_core in the pmu to avoid recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 7 ++++---
 tools/perf/util/pmu.h | 7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0fa451c60c77..930ec3786964 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -954,6 +954,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	}
 
 	pmu->type = type;
+	pmu->is_core = is_pmu_core(name);
 	pmu->is_uncore = pmu_is_uncore(dirfd, name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
@@ -1661,12 +1662,12 @@ bool is_pmu_hybrid(const char *name)
 
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name);
+	return pmu->is_core;
 }
 
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name);
+	return pmu->is_core;
 }
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
@@ -1725,7 +1726,7 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		bool is_cpu = is_pmu_core(pmu->name);
+		bool is_cpu = pmu->is_core;
 
 		list_for_each_entry(event, &pmu->aliases, list) {
 			aliases[j].event = event;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 99e0273027bf..af10d137e2b5 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -59,6 +59,13 @@ struct perf_pmu {
 	 * @selectable: Can the PMU name be selected as if it were an event?
 	 */
 	bool selectable;
+	/**
+	 * @is_core: Is the PMU the core CPU PMU? Determined by the name being
+	 * "cpu" or by the presence of
+	 * <sysfs>/bus/event_source/devices/<name>/cpus. There may be >1 core
+	 * PMU on systems like Intel hybrid.
+	 */
+	bool is_core;
 	/**
 	 * @is_uncore: Is the PMU not within the CPU core? Determined by the
 	 * presence of <sysfs>/bus/event_source/devices/<name>/cpumask.
-- 
2.40.1.606.ga4b1b128d6-goog

