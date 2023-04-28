Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12EFC77B60
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 07:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345762AbjD1Ho3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 03:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345576AbjD1Hnw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 03:43:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0DE59FC
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:43:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7e76b32bso1859750276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667736; x=1685259736;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=feNyjAPtIUSUDrmLxKNanb31JNx+5xcJ7s4SppqU3s8=;
        b=hH/JONcIz/Sxa4JK6cKm731ZQR6WixuVsX5a2X5vPOrediJ6J2CgtmvhnR6hDlbyVj
         hjgstqfGe1gk1KvPZYe0enJkBj2yrwzm2MEKbYitM4tiXuee24Lld8th/r0rRjP0Rfxl
         MZpjrMQ7HGgyzVCocdRwK5DNmRxv0mC3dmh9i3RG92tt6E+fRI3fUNzY6hzFeqwe+e6A
         d5KY4aTMbi5VvEFcVZ5m94N8vH0v9Ug7Ne7dXm9bSr3jS5mCa84YI8LXE1dODCDMMf8E
         kNcOlQGBNWroRFCvc+8mZ0wSOD75g7Zj3HLaWFe8vJT2C9qFXL4Uv51bnnINh9s6oLk+
         E28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667736; x=1685259736;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feNyjAPtIUSUDrmLxKNanb31JNx+5xcJ7s4SppqU3s8=;
        b=NY0ed9wphQ6Q8fSvxlpJxgFpztRreEuumpuIk0F6Fxd2BkwJP4+Qv6glqsdra7cIuI
         hClA3eFZjvJaEnM2pLGrZ0szSwCzPlNvDBgv0uQ5KFvAuyDVBCZH9yDblfK/mLMBUVt2
         O6vUa0WjoN5GuqfkzBk2ZerZIXP2U/0qZ7lCAHrJB3LMIEbh9U3v7r4R8Rt3iOspdgEt
         Qh41A7ASJIfJwNLoltSDxUzCx+J2NG4dV/eztwyCyVYUvHGc1f4GXgOws1EXcrZTNL54
         tuwMHro9MBuRxMNSfrK5CRvD5+AbAeCNEoy94JbHKE55HL57XEo896eplHeOUPiHJr5f
         /R1g==
X-Gm-Message-State: AC+VfDyAj85cyarLn3FYpOKw71J/a2xty9FtcU1yyyRbQGK0lisfRUCB
        1/mrFawBfEldQc7C9S5TewZR5rW+Z8+r
X-Google-Smtp-Source: ACHHUZ7c+0svYVPzyWJLKK2BKR/byiojSYBgb//g9R6qmrDYI2LRX12HDRHrAckjw83j3WR00SeufT6wNx8e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1003:b0:b8f:54f5:89ff with SMTP
 id w3-20020a056902100300b00b8f54f589ffmr2585972ybt.11.1682667735962; Fri, 28
 Apr 2023 00:42:15 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:37:53 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-28-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 27/43] perf parse-events: Minor type safety cleanup
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

