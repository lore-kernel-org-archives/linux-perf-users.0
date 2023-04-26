Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AEEC7618E
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Apr 2023 07:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbjDZHGj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Apr 2023 03:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239883AbjDZHGH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Apr 2023 03:06:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CEF49CA
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:04:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b92309d84c1so33258366276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492671; x=1685084671;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=feNyjAPtIUSUDrmLxKNanb31JNx+5xcJ7s4SppqU3s8=;
        b=E+SOnPbvLMhSx3vfiAPHcNOKyPNN4YgTfBFYZQgy3oai/RcemJIQkVdIHB1gEYEm0E
         AALHPZJqwqzXOG/1MXsJj9thuOwGceyi6gbQPqF+Mp5e5SHSD/I85E+XZkYPKRlmkL/q
         VfRXV/U++gYLzLgQqcKvpm8JXqD2WDIGJOxF4m7ZGmLTaUeicdd5usQdevYvRc2Z7OeC
         oDo2u2COuK+YBWclXLZfqIrA584ZuGH803Wr+9JevBe4Csw65RcZsZwRAg2zINfyWPrM
         YmhiFG2ZkAcnni7z57KOisiwAa1AX8BPG5eMvalB4lC7Z4G1S/Dx5iJ9D9xB9b9nDKYP
         7B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492671; x=1685084671;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feNyjAPtIUSUDrmLxKNanb31JNx+5xcJ7s4SppqU3s8=;
        b=U+PuxWyyjGl4GUHNnk2pvXS7nJnI+9yA0MI43Ytu9Z2d3h/ceJFMwBFzRh9KXhRoHu
         tC4vB2s+nsYtTdUcFpXDPt2QsvidLMlhxNEHdOtdoX/XRepGueca6NnCJhUNuNg1MOFe
         TLonVm1EVLAP7RH4xxTS8sGABMOEDVqHSprofR7B93GwsPHaC2yxraA4ZR+JJ88n7iX0
         6GHB1zCKrQwyC5jsBnG1SppsuD7OnYu8vt/cpPTZuSSY4wSgqtihoCfR0a+V23HNPi3G
         RvxVVHZt42gPAM26Mg9VReJIA20C56EJF1zzRjNNQuLorWO52W7CWm4fR8zpQmbqY5io
         EHXw==
X-Gm-Message-State: AC+VfDz/Kp6hctnf7S+MzClME1TYs/ffUsXAcTDf2yPh7VLmI2q4ZfB7
        U4u8lWPwKID/mIoASCYacPOXsIyP1r1p
X-Google-Smtp-Source: ACHHUZ4LQ7a9DjY8TaGd++wTnEhcClz9KFMnIxeABksRne+3OGPZwhpSsdQ5sUMB3ZeNgMD1SWv8jcEHqDgs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a05:690c:2f82:b0:54f:e2ca:3085 with SMTP
 id ew2-20020a05690c2f8200b0054fe2ca3085mr940938ywb.1.1682492671653; Wed, 26
 Apr 2023 00:04:31 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:35 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-26-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 25/40] perf parse-events: Minor type safety cleanup
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use the typed parse_state rather than void* _parse_state when
available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 5055a29a448f..e709508b1d6e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -301,7 +301,7 @@ PE_NAME opt_pmu_config
 	if (!list)
 		CLEANUP_YYABORT;
 	/* Attempt to add to list assuming $1 is a PMU name. */
-	if (parse_events_add_pmu(_parse_state, list, $1, $2, /*auto_merge_stats=*/false)) {
+	if (parse_events_add_pmu(parse_state, list, $1, $2, /*auto_merge_stats=*/false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 
@@ -319,7 +319,7 @@ PE_NAME opt_pmu_config
 			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					CLEANUP_YYABORT;
-				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms,
+				if (!parse_events_add_pmu(parse_state, list, pmu->name, terms,
 							  /*auto_merge_stats=*/true)) {
 					ok++;
 					parse_state->wild_card_pmus = true;
@@ -331,7 +331,7 @@ PE_NAME opt_pmu_config
 		if (!ok) {
 			/* Failure to add, assume $1 is an event name. */
 			zfree(&list);
-			ok = !parse_events_multi_pmu_add(_parse_state, $1, $2, &list);
+			ok = !parse_events_multi_pmu_add(parse_state, $1, $2, &list);
 			$2 = NULL;
 		}
 		if (!ok)
-- 
2.40.1.495.gc816e09b53d-goog

