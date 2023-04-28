Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C9CC77B61
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 07:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbjD1HpA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 03:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345752AbjD1HoW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 03:44:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCC4658B
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:43:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e76b32bso1860776276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667808; x=1685259808;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5la9qJcqL6gBH6h4UORwyXdD/ZlzmqtItJD5+R0Siw=;
        b=t2TT5Gxsml5AkgJ+zQZNZ0aISC0WyTwE1jC3vk53NTm7pZCYB+XmCKhsyvZPe4qffk
         j1KeQTQLUaocVTCyJm0ryRDScbq4kiNpU91+3EnVk0+94/s2KrwEg2tQj4yBe3OAHnFC
         SacDwPF/pA1foDDaEcRrTmC2Zusjc+beAzFDpmTwnJtAjQwYEGd1Fi9/n982o/ghHMO6
         D7bebNDDWP7jmkgOAzdifS0JMDkwMwD5sBzBymybXwhcxx8I0wj3zPFORUS1NKfhSfO2
         +1RJzI25cVcTosxn0zAn7PTxPgUa/QB6K/QganTI1REWIhMH47oni/bqd13Y6anYA1Vh
         UptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667808; x=1685259808;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5la9qJcqL6gBH6h4UORwyXdD/ZlzmqtItJD5+R0Siw=;
        b=i2LNX1+5dH+iDdsWXsUeg2D7IWydXtLKDa+SZ7I/+XqBZJOz+5c/PujY5hhfiII9ij
         aItiFdinCToJT8q962r7eV22G8MQ/qEztJ6imFlY5RtyQmVL9QhVkAYr9Ia+BNfBtjum
         emB00wq+lGi38Q8HvxQcyv6V99dgiIfDly4UVCUnPlor9M6Pzj7V9OFQA5E7Fhvc1e5f
         hM3+I3qUYHcnLLKLWwsLQ1pSG/R44OqxTs+xN20hACTZDFcksGh0mp1Uj91Yl1LnC3sJ
         uL10NDfcUBpFFlh6HKPfvYV/djSAxetoWyqyVBdJIFhEFkLvWX13GmlnXIxJaNzuVQVF
         0Qfg==
X-Gm-Message-State: AC+VfDzzDawZbCZF6toGvfig1YhQ4L/Rnqvjm03KluzOLX1LN4JGBHBZ
        BtpbDe/aI/BFhc0haOdYoM0xMLlpxIgj
X-Google-Smtp-Source: ACHHUZ67AkVoOZU3GidDNOnx6F9iUQpJZNOEarQF4voDRT5m8HwdpWhJ4IvHvDaaMJ34o8kE0aUnJP1nNASw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:4201:0:b0:b96:7676:db4a with SMTP id
 p1-20020a254201000000b00b967676db4amr2604783yba.0.1682667808296; Fri, 28 Apr
 2023 00:43:28 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:38:02 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-37-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 36/43] perf parse-events: Don't reorder atom cpu events
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

On hybrid systems the topdown events don't share a fixed counter on
the atom core, so they don't require the sorting the perf metric
supporting PMUs do.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index d4193479a364..1b6065841fb0 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -6,6 +6,7 @@
 #include "util/event.h"
 #include "util/pmu-hybrid.h"
 #include "topdown.h"
+#include "evsel.h"
 
 static int ___evlist__add_default_attrs(struct evlist *evlist,
 					struct perf_event_attr *attrs,
@@ -67,8 +68,7 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
 
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
-	if (topdown_sys_has_perf_metrics() &&
-	    (!lhs->pmu_name || !strncmp(lhs->pmu_name, "cpu", 3))) {
+	if (topdown_sys_has_perf_metrics() && evsel__sys_has_perf_metrics(lhs)) {
 		/* Ensure the topdown slots comes first. */
 		if (strcasestr(lhs->name, "slots"))
 			return -1;
-- 
2.40.1.495.gc816e09b53d-goog

