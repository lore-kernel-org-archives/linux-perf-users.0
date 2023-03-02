Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E42FC6FA8E
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 22:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCBW3E (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjCBW3D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 17:29:03 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6EF17CD6
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Mar 2023 14:29:02 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k17-20020a170902d59100b0019abcf45d75so347744plh.8
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 14:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677796142;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLp16thdoL8gYxkkfhRZgItEDw/VHlYRuSQJ2A/KjWw=;
        b=i8Og79catj1OlIBUEL9S1MIBSf1IAd1tzHRKwUw7koailbxBx3f8qmxAEqiijFPvYL
         eRT84euiOjnGZfUOnyWKNpvM0/6KF6IK/+ofEohgIOrD9G0iJ6KWjJbpHsiFr78SQ6pw
         M9qo/xTEU0ps5/qu3WmmOxMky/Vkt/u/kHlwZrICNKW0Gu1N/SsPP99zsxNn5DDgOG3L
         YjTPbT4LWUgi4EMPNb5bRYX5Oxg6YAfbU3xR+gehL7J8FCe3Kfq4D6clFJ44gz3fogbn
         QK4UUHKeaRziqz8bEglUEUrJoOP2Ws7YtfyQonWSDVHhmhWkKJ6EOZ8PgQd3JWPMT+xT
         ipMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677796142;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLp16thdoL8gYxkkfhRZgItEDw/VHlYRuSQJ2A/KjWw=;
        b=e8pYuAcLHfyWuKljRYXPsnr2YdHMp+JpQ3zPrhnhkZjWr4tueH3ybRUI+rVS1TeKz+
         aVSvfDp5T/8J8J6GaBSSnycI/Jnm8MzixJwGw62gUULc9esuvI1CE2gVaHS2YP1/0WwX
         RwCv0lS66Nzqh8lDJT3elJ3dsCIyExUjUe4rJ4R9jhH6SIY7b8N6dmBX8TiM1sGnhDdm
         el2GjjKuDDBDhxEubi7z90oypduMQESKnoJC7rfjWWizd67ZbIDrzv7AFCKWIUldxiqQ
         /RoXJlqollQiOOTGfPLQaxvYLMIp0YdRGNYMs4ZvYVs3scZd/cOtsgfyIM3mdbzfT+Wv
         0G2Q==
X-Gm-Message-State: AO0yUKXIY29lcYmdw0a6s1UcnMZs3AiinelA0z7EzLJ8XIT+Kw5j6fww
        +c+mlrjBVfJHbN0fv37T4G+APpPnPQtu
X-Google-Smtp-Source: AK7set8IDse27H7uhs55+lpktQZD5WFfNUIFhEks3/sxyTroAWqTYmsTORr1cgwGdzOx42qWESc0pbtFHcKQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a25:9112:0:b0:9fe:1493:8bb with SMTP id
 v18-20020a259112000000b009fe149308bbmr4926485ybl.13.1677792371865; Thu, 02
 Mar 2023 13:26:11 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:24 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-4-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 03/10] perf record: Early auxtrace initialization before
 event parsing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/auxtrace.c | 17 +++++++++++++----
 tools/perf/builtin-record.c         |  6 ++++++
 tools/perf/util/auxtrace.h          |  2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/util/auxtrace.c b/tools/perf/arch/x86/util/auxtrace.c
index 3da506e13f49..de1e4842ea2e 100644
--- a/tools/perf/arch/x86/util/auxtrace.c
+++ b/tools/perf/arch/x86/util/auxtrace.c
@@ -15,6 +15,19 @@
 #include "../../../util/intel-bts.h"
 #include "../../../util/evlist.h"
 
+void auxtrace__early_init(void)
+{
+	struct perf_pmu *intel_pt_pmu;
+	struct perf_pmu *intel_bts_pmu;
+
+	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
+	if (intel_pt_pmu)
+		intel_pt_pmu->auxtrace = true;
+	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
+	if (intel_bts_pmu)
+		intel_bts_pmu->auxtrace = true;
+}
+
 static
 struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 						    int *err)
@@ -26,11 +39,7 @@ struct auxtrace_record *auxtrace_record__init_intel(struct evlist *evlist,
 	bool found_bts = false;
 
 	intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
-	if (intel_pt_pmu)
-		intel_pt_pmu->auxtrace = true;
 	intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
-	if (intel_bts_pmu)
-		intel_bts_pmu->auxtrace = true;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (intel_pt_pmu && evsel->core.attr.type == intel_pt_pmu->type)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8374117e66f6..a0870c076dc0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3940,6 +3940,10 @@ static int record__init_thread_masks(struct record *rec)
 	return ret;
 }
 
+__weak void auxtrace__early_init(void)
+{
+}
+
 int cmd_record(int argc, const char **argv)
 {
 	int err;
@@ -3985,6 +3989,8 @@ int cmd_record(int argc, const char **argv)
 	if (err)
 		return err;
 
+	auxtrace__early_init();
+
 	argc = parse_options(argc, argv, record_options, record_usage,
 			    PARSE_OPT_STOP_AT_NON_OPTION);
 	if (quiet)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 29eb82dff574..49a86aa6ac94 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -457,6 +457,8 @@ struct addr_filters {
 
 struct auxtrace_cache;
 
+void auxtrace__early_init(void);
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 
 u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

