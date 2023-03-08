Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F19EC64EC4
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 23:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjCHXAH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjCHW7x (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 17:59:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5BBA85A
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 14:59:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g5-20020a25a485000000b009419f64f6afso265548ybi.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316385;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+qDX3jH1lOKTsdGbFp7R/2wFTjz3Q2IIuidM+9GQKA=;
        b=DFFk2xpNm9WphrNvajgxOoqstDHJTuE9tDsxET5XisIInEgApHSWTWI2G8pfhOhkdu
         auwV0TE5vJMAgqS6U8DDgig52deviZ29JLQ9KSOE3iibC1QnV7KFE/lN0+OcfG0Qxd8i
         rF3fJchSi9XRDLMFUk7RGnkFVfTgY4YzIbiKmnTOPkunRiy/jy2MDGPCVdSHV3mebj3Q
         0a6l1bZnJ1Y/qGf392eLQ4qwM39jdFKPPEtuwTWLWwayxOCWPTfGfEqDeqsv0g7Nm7rX
         KvZIJa7JdBmJAdimef0LByK6niiZIXUYoIkfOLDNv4ApsQUkviJNZnQJNFVfetgpX0LZ
         OAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316385;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+qDX3jH1lOKTsdGbFp7R/2wFTjz3Q2IIuidM+9GQKA=;
        b=ySksJQTaKrZr5Jie2sLkll6JS+Ay+gpyFA+5/ZZJkJPby1BxAJ4BcEiJlsX/f0jDVF
         r7TACKc7Uc0VlJ+vjwIEXusQY/mrSiQaA/a9CxgdWeK/UC/dhXma7tnsUf361pWQVRPP
         ElMahcc54Te/SKz3xGUyq/maHfitm2FwV5zriNzLfq7cOfRTqinBPpF9OrrM3IRskwiU
         mAasZrY/sNZOfJuFH6lZJvXZvWrwJZ6spWBV4piOZPmuVbAjmd4iqe26hm4crSskU+2a
         6z5SsgW1siB2OU8DfVZtghmjGnBQXo9ah/hGtTz9K0cwvudyZqDbWmwnbZvh7//VYktR
         LdSg==
X-Gm-Message-State: AO0yUKVAZ53/1zhKB8kcvhQLlnh2wat0Lpn559YsI7iaC5pmOh7MjTaD
        q1A3Obh/sBf0C/a8SqQDP+B4xvrla9TJ
X-Google-Smtp-Source: AK7set9ivQfkcqqArDa6b9pj3bzD8ySHcNeWzHOTdX28H2b1F3vYOgRZIjL2p1LBLr26+2ih1TnHkNCXx1Ct
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a0d:de41:0:b0:533:7e62:80a with SMTP id
 h62-20020a0dde41000000b005337e62080amr3ywe.448.1678316384620; Wed, 08 Mar
 2023 14:59:44 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:04 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-4-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 03/11] perf pmu: Earlier PMU auxtrace initialization
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This allows event parsing to use the evsel__is_aux_event function,
which is important when determining event grouping.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/auxtrace.c | 4 ----
 tools/perf/arch/x86/util/pmu.c      | 8 ++++++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 3da506e13f49..330d03216b0e 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -26,11 +26,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 	bool found_bts = false;
 
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
-	if (intel_pt_pmu)
-		intel_pt_pmu->auxtrace = true;
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
-	if (intel_bts_pmu)
-		intel_bts_pmu->auxtrace = true;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 358340b34243..f73b80dcd8bd 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -27,10 +27,14 @@ static bool cached_list;
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
 #ifdef HAVE_AUXTRACE_SUPPORT
-	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME))
+	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
+		pmu->auxtrace = true;
 		return intel_pt_pmu_default_config(pmu);
-	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME))
+	}
+	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
+		pmu->auxtrace = true;
 		pmu->selectable = true;
+	}
 #endif
 	return NULL;
 }
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

