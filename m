Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6948CC77B7D
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 May 2023 14:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjEQO7e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 May 2023 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjEQO7G (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 May 2023 10:59:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604349033
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:58:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba69d93a6b5so1621716276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 May 2023 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335533; x=1686927533;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJew5c6+Wqs3H0xvybKSYHiC9UyD346jsUjXmSkm68Q=;
        b=E8lhndMhmlxnQknUI5Dvjo+mrBhFisWj9VZveazhd506WZHGDpEpNTAA4Yddkqsl7k
         jfJyBqIDjPc4Peu1Z7l2PLIpT2OlwLN7k0yil0b3L0Xc6ftQVuWqwQVvJ927+frXyQsj
         il0XlcJNxtqmGmmJdQRikIaxVYSOSKzWndKRmHzkJ69L03cnjBBiarQPneD4eDyD0TCM
         zjVeMG3cFTWRp6JoHxnm7w1C4ofoTabe5R7ibfucFb4zvMJKtbsuhDGR54Ka+tvGrVNf
         rnr2fcH7a6n/tfx+ZH/tH/9efv5MVq39uvTuw1pr0TAIBTs2xJA1FPulheWN0xhen8jk
         XmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335533; x=1686927533;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJew5c6+Wqs3H0xvybKSYHiC9UyD346jsUjXmSkm68Q=;
        b=PMJEqMyAzoW+zuKNBGeSVwxLfaVTOOz3TUW3/L4bMB2ojc4WOtRMpb94mfEMWVXIaB
         F58TQvEwjNkt9nzDD9agiQ0129XNKHZxbKs3w79Aa5QRTNBB92wW+ioccDEOrwMC9zYR
         lGZmAdfTQgqa9kOUrWUnfc6wPhkjfKAsuG502OTIwC2vHHkAtEctKkjSBs+D0/E0AHRN
         SpznqwdA6FwfL6kPdnu0ehCZ1FysD0h4NSJ4PK9YfPGbDyMsOoU7CDI4uEIJAp3Jm6ON
         Pa9L13WlSMpy3Ym0vu5cvVcNW7WOxIXLPrXNH2RpiXP5fBXNreQFU3gAjcwm/iba5yWh
         cCrg==
X-Gm-Message-State: AC+VfDxXBi1p4W+ZEp4vO5RaJ0imWV89+tF6AfNZbZaC+ZJuW74gAq6g
        mRgK9TG8RV5yDdgLlUrs/ifcvT4JnD20
X-Google-Smtp-Source: ACHHUZ56HXknOGNqzw7/nwItcz7tOnm7evTpjMpIUjxB0+elX8F+7fCvpauDoNX6mFTOCbcf1NkWmM7mzMNu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a25:6542:0:b0:b95:4128:bff6 with SMTP id
 z63-20020a256542000000b00b954128bff6mr24731255ybb.1.1684335533487; Wed, 17
 May 2023 07:58:53 -0700 (PDT)
Date:   Wed, 17 May 2023 07:57:48 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-9-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 08/23] perf pmu: Rewrite perf_pmu__has_hybrid to avoid list
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

Rather than list empty on perf_pmu__hybrid_pmus, detect if any core
PMUs match the hybrid name. Computed values held in statics to avoid
recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 930ec3786964..2da28739e0d3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -60,8 +60,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-static bool hybrid_scanned;
-
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
 
 /*
@@ -2026,12 +2024,20 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 
 bool perf_pmu__has_hybrid(void)
 {
+	static bool hybrid_scanned, has_hybrid;
+
 	if (!hybrid_scanned) {
+		struct perf_pmu *pmu = NULL;
+
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+			if (pmu->is_core && is_pmu_hybrid(pmu->name)) {
+				has_hybrid = true;
+				break;
+			}
+		}
 		hybrid_scanned = true;
-		perf_pmu__scan(NULL);
 	}
-
-	return !list_empty(&perf_pmu__hybrid_pmus);
+	return has_hybrid;
 }
 
 int perf_pmu__match(char *pattern, char *name, char *tok)
-- 
2.40.1.606.ga4b1b128d6-goog

