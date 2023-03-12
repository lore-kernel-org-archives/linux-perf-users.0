Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CDFC61DA4
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Mar 2023 02:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCLCQf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 21:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCLCQe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 21:16:34 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CB0460B1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:16:18 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y31-20020a056a001c9f00b00623268e040dso584530pfw.7
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587378;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BT/x/3Eyz2BuEqpSdLzkRqcNHW14bzsOIxfh6FRlfxo=;
        b=lHkf3zlh1pVGSdM1GC3AxnylNDGWw4m4GJlJE4wRPSdCCUFN3He51cJPy0m5AyZ/zv
         /SzbVozvJfQqUfitexmgUsgWBFu/tkgmcX9cwlr0C6zKLYgTD7CUdX/9kFuEu8xRfD6R
         VJ6Jh2D0oe3Fhe67mGw5s3OOOHYfh8AsbdG0Y0kRrclYNzMovnQVtBqNXwD2Iv3gKZrY
         btWan+zTRIHcpSja+4FLQ3WkvJUYnWBExNjhJMbU5/XAOyZySYxySxWh0uVHd2Yut+VL
         6VvsruF/H1OzxW6rUp15I4kVz8EWLI9P6ijhJqbYhapqB4RPKk89sA8NKJOlPW3vPnqx
         HSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587378;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BT/x/3Eyz2BuEqpSdLzkRqcNHW14bzsOIxfh6FRlfxo=;
        b=fWexjRPJgQO8RCP/EnmRoMK+FFTU6BYJxug7cHRFPazpPmrAxSmuxLRIhfIkhQblBz
         +GmMbvY5XB3ZMPyJZ1zDxPohbXAFm79E9N5fO1Jw7vpUYPGIKrbbRfdCy6ReWiazH07w
         vmSkNtNZ72dGeVWhIqSqlWjpK4RHpUC2/cF84OTbHpipTkDYJBr75iHAQT5grFDkHC6w
         CjBynvfqbFSfma5ZnKuN4CSjotJZKfhX62TTVPc6RA4izJCkklWxTU8XH87KhywnesRb
         SIcQqKMNXVVcWSegTikQkQH4nw4ri4zGGaG3wCu28uss3L5KfO2MK8kiPkeIKMHv0k7x
         veoQ==
X-Gm-Message-State: AO0yUKWupGTPrj7uleEbXu1wunf7nXiSX6pG+LHEMLQysaY0HWlqLt/n
        klbzPm57DN2pFyXFu9gXVUb6oTMRYJQy
X-Google-Smtp-Source: AK7set+TQZtCja/vps9x30qK//1pOedYZ63oAHSdXRy5p5SUcpJFeG3+UZvcmc6a0VnbQm5HEOvgJz9CyaOl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a17:90b:46cf:b0:23b:517d:beca with SMTP id
 jx15-20020a17090b46cf00b0023b517dbecamr315230pjb.0.1678587378274; Sat, 11 Mar
 2023 18:16:18 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:35 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-4-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 03/11] perf pmu: Earlier PMU auxtrace initialization
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.40.0.rc1.284.g88254d51c5-goog

