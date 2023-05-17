Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA90C7EE23
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 May 2023 14:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjEQO66 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 May 2023 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjEQO6v (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2023 10:58:51 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1944F3AB0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:58:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a37bf6fd0so13537777b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335529; x=1686927529;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7JvoC3iLPsTar91Pn3VOoDH0ua0dyX+PVCo/jOZfiM=;
        b=SR1oODanQJ57O3lCwCzldhf40RyfzaHFodbuZ4dyCVKH5c90WuytcRyDMFZG6JI14X
         ofT0rA60mNO8JN+Zlzow+H0ZMNq42GIvgIiEJM57kunHKqrGy5Hnn2vqg3scdF646ivM
         pRrvg/mJng7FgnydwyaR0PCuTDsYdYqpcBF+5/FLeR8qkKHxDupiq25hONltK0YMz7fQ
         Vdue9njw5Y6DOsnIsAceuTnmVgWlnRP4ILzBMNo77/3k73GHUXZ3tTeb6OFJrDZ8ulHG
         k9Ei5w+1MuplvLBtfnx0wEHwyn89Cn/i8YktgQgTEK8ub4BbUPjyxJnGgFSLU7QLxXbg
         a8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335529; x=1686927529;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7JvoC3iLPsTar91Pn3VOoDH0ua0dyX+PVCo/jOZfiM=;
        b=KlCBM+s4JuEASVtyCgJcbHmmcJ3tOnIvoAR2ai3ry7JzjlSug2obeV0TuKdIx6j5k/
         JKG8SaxXOnVNbhcSpcOCGAYH/yiC7NnECzH7HTuOGoLp3NtGIykDfityaWFQOdu2ykZh
         PccEvXun4PdfgdHS9yB7sFaBrZzsuXS1sCil6o4szqvQTkNdPzUHmGp9zihyxi4Fo0vc
         ZZbpWqff2Yr+wLJXTQskngdPMQtcc59oR8dcT8UFDTpfDOpGl3forI7rk8dvXj3Ie3i2
         695aWum8n3l9bMHvgorVuWRQSo5HZQSQsnOIBEwcri8N/kS5/TBidjcJMUsq/MFQ6GKJ
         w99w==
X-Gm-Message-State: AC+VfDyPUecliPCcN0IGKlaifZDwlRl1+7y9XwQFG60raaFghWOqjBSv
        gJW8JDSODepcKOUXapLx2WpwEFfec2U4
X-Google-Smtp-Source: ACHHUZ44pWiXmYrxWRfX2o7cQvQA6ozXCf7evHZDMWgVIRN82ipaAcPs0zIRQlrgCV4Lo0MxXcqAdZzYuVPJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a81:c402:0:b0:55d:ea61:d8e9 with SMTP id
 j2-20020a81c402000000b0055dea61d8e9mr20859476ywi.7.1684335529254; Wed, 17 May
 2023 07:58:49 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:46 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-7-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 06/23] perf pmu: Detect ARM and hybrid PMUs with sysfs
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

is_arm_pmu_core detects a core PMU via the presence of a "cpus" file
rather than a "cpumask" file. This pattern holds for hybrid PMUs so
rename the function and remove redundant perf_pmu__is_hybrid
tests.

Add a new helper is_pmu_hybrid similar to is_pmu_core.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 29 ++++++++++++++++++-----------
 tools/perf/util/pmu.h |  1 +
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 729b1f166f80..0fa451c60c77 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -640,12 +640,14 @@ static char *pmu_id(const char *name)
 	return str;
 }
 
-/*
- *  PMU CORE devices have different name other than cpu in sysfs on some
- *  platforms.
- *  Looking for possible sysfs files to identify the arm core device.
+/**
+ * is_sysfs_pmu_core() - PMU CORE devices have different name other than cpu in
+ *         sysfs on some platforms like ARM or Intel hybrid. Looking for
+ *         possible the cpus file in sysfs files to identify whether this is a
+ *         core device.
+ * @name: The PMU name such as "cpu_atom".
  */
-static int is_arm_pmu_core(const char *name)
+static int is_sysfs_pmu_core(const char *name)
 {
 	char path[PATH_MAX];
 
@@ -811,7 +813,7 @@ void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
 	struct pmu_add_cpu_aliases_map_data data = {
 		.head = head,
 		.name = pmu->name,
-		.cpu_name = is_arm_pmu_core(pmu->name) ? pmu->name : "cpu",
+		.cpu_name = is_sysfs_pmu_core(pmu->name) ? pmu->name : "cpu",
 		.pmu = pmu,
 	};
 
@@ -1649,22 +1651,27 @@ static int cmp_sevent(const void *a, const void *b)
 
 bool is_pmu_core(const char *name)
 {
-	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
+	return !strcmp(name, "cpu") || is_sysfs_pmu_core(name);
+}
+
+bool is_pmu_hybrid(const char *name)
+{
+	return !strcmp(name, "cpu_atom") || !strcmp(name, "cpu_core");
 }
 
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+	return is_pmu_core(pmu->name);
 }
 
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu)
 {
-	return is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+	return is_pmu_core(pmu->name);
 }
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 {
-	return !perf_pmu__is_hybrid(pmu->name);
+	return !is_pmu_hybrid(pmu->name);
 }
 
 static bool pmu_alias_is_duplicate(struct sevent *alias_a,
@@ -1718,7 +1725,7 @@ void print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
 	pmu = NULL;
 	j = 0;
 	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		bool is_cpu = is_pmu_core(pmu->name) || perf_pmu__is_hybrid(pmu->name);
+		bool is_cpu = is_pmu_core(pmu->name);
 
 		list_for_each_entry(event, &pmu->aliases, list) {
 			aliases[j].event = event;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 49033bb134f3..99e0273027bf 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -220,6 +220,7 @@ void perf_pmu__del_formats(struct list_head *formats);
 struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
 
 bool is_pmu_core(const char *name);
+bool is_pmu_hybrid(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
 bool perf_pmu__supports_wildcard_numeric(const struct perf_pmu *pmu);
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu);
-- 
2.40.1.606.ga4b1b128d6-goog

