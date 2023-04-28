Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE1CC77B61
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 07:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345843AbjD1H4m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345844AbjD1H4d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 03:56:33 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E353581
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:56:27 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id e9e14a558f8ab-32aff21222eso148696575ab.3
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682668586; x=1685260586;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=udIESTQJWghJ0eXfw1zjkQa1ohgrnaNqFMimydoVXZk=;
        b=6XwFRQ83uCy4BiI3/CEF/bZR0JIlZj5IjIO3W9NrkIP0A6YhM9bwabCmZINTPq0JCU
         DgWz7hxi2uVd5nuLrsLiRcjpw+qoet+BhCEgWXjk7grD4jisi9c/pEcA6IPCtQlobHoq
         bOzvolXQpmbhxAzJ4k8FiRxTDCDux3+BAozTz4DYaOcWhT7uH8LOXMTkQ+suWkIa4P3s
         aJV5aO5Z7LPXQKul0/lvH+T0xx2/WXb/fpe/oyyCRYi8sstHlW1SA7VYYxTDhCnnpJMk
         gqxuEm+MjnhobjjW/y9IZY/PoCXuRuJz1qGG/Zvs2zeZh3VKNe6coXFT4k2rxEUdRMlu
         riqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682668586; x=1685260586;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udIESTQJWghJ0eXfw1zjkQa1ohgrnaNqFMimydoVXZk=;
        b=Tsz/BAwuU0ZNZ7blKwvaqLoV8Y+IH882FcmeazIVAt/kV2mVitL+t1kJiVby7xo4qp
         Tx92phYaSCHdplvFBT5iYUQzVe9K/R0Q6A7sk2pwaGf2DjWXW7+ihYNh5GTSTcpYgugf
         gDzdotaADoxZsNN9zXhanyhiK3PjjFLN4+NDjodrM4dtySylp/Z2udENzncn68jh5/qO
         E0R74/1XC5BmbDyamLm1bobDQ6AoM2T4NJI6L/AKGqniQHBk/cEvIrn9t9Hy/iuuD3Ml
         NZ2n7p+DdiAuYXEy5iN+Wu9oTtXl0rwvqc27s6SUXh54WNrFE/zLkTRHO95k4Qo5Gqcg
         qSrw==
X-Gm-Message-State: AC+VfDwSs4UaTyvX4kbOvyrN0h6HTLs9rjd2nplfmnhMt+ftoTMI//P2
        zi457f2RJyzdlyAZQbKDAMduAou9ZH3e
X-Google-Smtp-Source: ACHHUZ4ZAIabklG4DQKE6HxUzEczGncaQD/83/qMjGwJet9u0/pQ7v2CcifHVbig50qNbhcqmYU5J+j0HNRG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:24d4:0:b0:b8f:53a2:a34f with SMTP id
 k203-20020a2524d4000000b00b8f53a2a34fmr1567466ybk.3.1682667855565; Fri, 28
 Apr 2023 00:44:15 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:38:08 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-43-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 42/43] perf stat: Don't disable TopdownL1 metric on hybrid
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

Now that hybrid bugs are fixed sufficient to run TopdownL1 metrics,
don't implicitly disable them for hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f4e572f9de6b..67dc69270ae4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1900,12 +1900,7 @@ static int add_default_attributes(void)
 		 * Add TopdownL1 metrics if they exist. To minimize
 		 * multiplexing, don't request threshold computation.
 		 */
-		/*
-		 * TODO: TopdownL1 is disabled on hybrid CPUs to avoid a crashes
-		 * caused by exposing latent bugs. This is fixed properly in:
-		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
-		 */
-		if (metricgroup__has_metric(pmu, "TopdownL1") && !perf_pmu__has_hybrid()) {
+		if (metricgroup__has_metric(pmu, "TopdownL1")) {
 			struct evlist *metric_evlist = evlist__new();
 			struct evsel *metric_evsel;
 
-- 
2.40.1.495.gc816e09b53d-goog

