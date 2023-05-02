Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5FEC77B75
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjEBWnt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjEBWn2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:43:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFFE3A94
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:43:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso565519276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067355; x=1685659355;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=feNyjAPtIUSUDrmLxKNanb31JNx+5xcJ7s4SppqU3s8=;
        b=REXrHwCTXLTnSbe1iZkuQgxh4N12mruI5ZipwMyoTVHW9B/m4ZTEC5/0pGb4jd0+0J
         aZgEUrG6P5DbICT9hQP3KqWH/5vqphaU9l9Bg3B4RWRoDuHjr8l15+/BZWGuoSdjTk3O
         +jNU4EVRImubU9+JS5RKb2Vf2wlF60uPxLouuaGQd5vkuH+GTtQI/sV/Tou0LKAgISkh
         iSJcmsNVJ9Y7G7KdVZhpPLaA5xX+ECe4eo67Ku3U+YK18BXhg08PnS0bMyHUq3DTrw9z
         QI1lnGjtn/sV9ZUJb6XUKrSdL03RTJowG/dBqZNzc+bC7nH31PwYpetaovAzR2Ih2vwJ
         rjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067355; x=1685659355;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feNyjAPtIUSUDrmLxKNanb31JNx+5xcJ7s4SppqU3s8=;
        b=jRb44fWYP4eLwaMQBZB5g42Gj0XAqb+DZl1v/5WQ+pw5BAfW9tUge9XX1HvOQE50FX
         lKY1oa7F7csw8NbEpMjaeYtM12YfKhkDRq2K7ZS0NSMAq0JGYM5CioZxGARM/F9h1TCr
         K5TbMRT9ozj+2TsRlnckVtHeFTB0VxxSVvcy7d+7z70no7UAoFBBAOtBQByQyZUdL4tH
         JsH+JtMPDk3P7cYmibyNzqDha6S6q2DbLLpSoSjhObrZ2IimyhWNcze134CisxKqC1Gn
         CB4033KM0nYSaPrb/gOTCY06pSySsHF0jvqICyxUiRUNQm3QuiKaPJjrxPR8rp+F9DnY
         K36Q==
X-Gm-Message-State: AC+VfDz06HtnqBuOWpuMWDfvc2aJyLrQJVlNFUEnL6tgNBwScUaX+s7b
        oempDXl9mmiCJp7nsENM32LIbBiSscYT
X-Google-Smtp-Source: ACHHUZ4ommsB49l5fRU7dRorIPbrQE2zo3ipn3gCL6a0IbyEM+FSgowB3hMePeNVeCLm9UotuDiZBImfPCHx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a25:5485:0:b0:b9e:5dbe:7535 with SMTP id
 i127-20020a255485000000b00b9e5dbe7535mr101773ybb.5.1683067355524; Tue, 02 May
 2023 15:42:35 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:35 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-29-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 28/44] perf parse-events: Minor type safety cleanup
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

