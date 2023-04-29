Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB512C77B60
	for <linux-perf-users@archiver.kernel.org>; Sat, 29 Apr 2023 05:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjD2FoC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 29 Apr 2023 01:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjD2Fnm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 29 Apr 2023 01:43:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE574227
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 22:43:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54bfd2c7ad6so11937987b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 22:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682746896; x=1685338896;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMkOwzwif+XT0+nBV5mOmwMnUg0kBSArT43+8IsF+QA=;
        b=djqmOH2cNr/CtlHU+Lr9guxdpgrU0doVbrQm9KJ7AVfPJJoa7AIO2XwGLMAFCcc2kc
         6etG5s+fAsD8i9k7b7x4QXdHX3qD2LdCcJfM4DP7gnVV3TIMcmc5yDzObuuTsQviSUaf
         5bVrWHWUJAkav8LxSCMb4+agHiKK6QukeXTppgNgVMaFNfmDvgG3FxvpBzeLEMprkldU
         ZRNFrqVbChnk0yv4jrxkFuZp3WSXNE4r28jBR18z9ReepF0EDtzDS680EIC+8Z8R5RqE
         cn/r6PebJP9N+c8iAWcYi3dBcHCBP0NJ3KefX4C+RipKztL1GlmLPMEWjPM2liNsd2i8
         3IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682746896; x=1685338896;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMkOwzwif+XT0+nBV5mOmwMnUg0kBSArT43+8IsF+QA=;
        b=SK3SvV0XwL90jRL0jJSlzoCBQJI70/2XfHveJPq/fTzFcQi11gRCxl9vfWFUFL6lxy
         ieloNZcvYRTLztHaNVohC2msJbJTX14eEyBvXuTmusXoWeANoodyIw0uV3ys1hYpfaeX
         zqAfcW9spr9vi0Bvwr9qb73Ib3ZYVsru/rVtIk7tJEDkIJI9HvCIH2cTVbBpy60y/Zbo
         DSA4b+Iry+ZIRL3+hWbK6WsIumcahS0C6aeSgbdj7ydFoe7tF3D6FXiOWL6Vt8yBIQLi
         q/yCp8eqcTZa42zRlO5MSTITfKXLjsTEIS0xXalontUOz3+oFt4M9FEsHpbe9FnPIsg3
         907Q==
X-Gm-Message-State: AC+VfDwrsTejy+En5zhLmGz0No45U2A8f6s6aJtIGItm7NMfQDKK9l37
        oTUaPIN1Qit8Kr1ke6VWKQuxR45KqyRs
X-Google-Smtp-Source: ACHHUZ7iVRpOAv6Jg1Vma8iZuVlG+zdfL7J7g7bw3oYR/R9LDK/FtALGoLiR9lj+L4eL6dqGzgFW5l1YZK/T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c563:7e28:fb7c:bce3])
 (user=irogers job=sendgmr) by 2002:a81:c543:0:b0:546:63a:6e23 with SMTP id
 o3-20020a81c543000000b00546063a6e23mr4759391ywj.0.1682746895837; Fri, 28 Apr
 2023 22:41:35 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:35:04 -0700
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Message-Id: <20230429053506.1962559-45-irogers@google.com>
Mime-Version: 1.0
References: <20230429053506.1962559-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v3 44/46] perf metrics: Be PMU specific in event match
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

Ids/events from a metric are turned into an event string and parsed;
setup_metric_events matches the id back to the parsed evsel. With
hybrid the same event may exist on both PMUs with the same name and be
being used by metrics at the same time. A metric on cpu_core therefore
shouldn't match against evsels on cpu_atom, or the metric will compute
the wrong value. Make the matching sensitive to the PMU being parsed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4245b23d8efe..490561f430f2 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -274,7 +274,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	const char *metric_id;
 	struct evsel *ev;
 	size_t ids_size, matched_events, i;
-	bool all_pmus = !strcmp(pmu, "all");
+	bool all_pmus = !strcmp(pmu, "all") || !perf_pmu__is_hybrid(pmu);
 
 	*out_metric_events = NULL;
 	ids_size = hashmap__size(ids);
@@ -287,7 +287,10 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	evlist__for_each_entry(metric_evlist, ev) {
 		struct expr_id_data *val_ptr;
 
-		if (!all_pmus && strcmp(ev->pmu_name, pmu))
+		/* Don't match events for the wrong hybrid PMU. */
+		if (!all_pmus && ev->pmu_name &&
+		    perf_pmu__is_hybrid(ev->pmu_name) &&
+		    strcmp(ev->pmu_name, pmu))
 			continue;
 		/*
 		 * Check for duplicate events with the same name. For
@@ -304,6 +307,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		 * about this event.
 		 */
 		if (hashmap__find(ids, metric_id, &val_ptr)) {
+			pr_debug("Matched metric-id %s to %s\n", metric_id, evsel__name(ev));
 			metric_events[matched_events++] = ev;
 
 			if (matched_events >= ids_size)
@@ -1592,7 +1596,7 @@ static int parse_groups(struct evlist *perf_evlist,
 		ret = setup_metric_events(fake_pmu ? "all" : m->pmu, m->pctx->ids,
 					  metric_evlist, &metric_events);
 		if (ret) {
-			pr_debug("Cannot resolve IDs for %s: %s\n",
+			pr_err("Cannot resolve IDs for %s: %s\n",
 				m->metric_name, m->metric_expr);
 			goto out;
 		}
-- 
2.40.1.495.gc816e09b53d-goog

