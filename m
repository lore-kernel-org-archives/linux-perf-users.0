Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C7C77B75
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjEBWpf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjEBWpW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:45:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090AD30FD
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:45:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e65b34aso7803320276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067417; x=1685659417;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5la9qJcqL6gBH6h4UORwyXdD/ZlzmqtItJD5+R0Siw=;
        b=o+yo5QO2m0Arr3Ssf8bJlRG++UZNEHFNdoC52cVkU6VcrPtyd85tgK2ep2b4NIR1F7
         svxp4QSwm/55im0KW8ePdCqUQNIqdMYhEfFhoWAmhXQ3nQHIpCJZhm1DnKcGq7swhlbL
         TYIbA/aX+U5TLZl5eyVfKQF97J1Saf9gw+MaR6S33C7d25zbuWJjOdocSz2DR+AHbij0
         NWpmhzTFaAbQYMqMunjTlnqbLKs95kiXbWB52wUS559hByrHHYdvLq8haSpSnPSDVw2R
         GJPg8BfZSgpGrprpblYrBHWyWQAgyP9VKEyuhBCAlLErW3VTrcUkvFe4R+t+eHcI2DRi
         mxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067417; x=1685659417;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5la9qJcqL6gBH6h4UORwyXdD/ZlzmqtItJD5+R0Siw=;
        b=CWkYIXWilhGa4wuFs1ENeV+TYQW9nq6VcYZtz8zcZO+GxMs8PBWgaSrbjv+bjkQXED
         8aXQ1HRabYYcuiaqH9zqK98TBmBwIpyL3BPUUp8DW9Y6EL6IqJkrgYxKxpAvxpMZpt8P
         OChQG6LGfbXK6S5N+kVg/OieUZIwfqz/5bFUD61/hic/EYvG6pk49f45qccDwPdtXqZi
         mHYM9o1yy8jKrUgYX28KEXnreyep1ALVYyGfM/M0LnEbUGxq3R1XkgxfIYPsuVnrayow
         nkzr8ED4i9NpsaiJej4/on8SjEvhTRtX3VS3G+H3anlZVjyO+jmpicuij5/8M/vAvu1/
         kQ6w==
X-Gm-Message-State: AC+VfDyaVLqcus6C+KsKSXtVz339I0Nh0o0Jq7H+waLjDVE45DjluvCl
        sHHF1KmdYXIl7M7wtirfX72LLrI/KyKs
X-Google-Smtp-Source: ACHHUZ7R624gU7PAQPBwrYcf7FXoTBGq+e/cbUC9fM+4MWzco4gFBqz9uOkKNurXZKUOfK60Mtf/IBgIVwfT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a25:13c1:0:b0:b39:b0d3:9a7f with SMTP id
 184-20020a2513c1000000b00b39b0d39a7fmr7344538ybt.7.1683067417109; Tue, 02 May
 2023 15:43:37 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:44 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-38-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 37/44] perf parse-events: Don't reorder atom cpu events
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

