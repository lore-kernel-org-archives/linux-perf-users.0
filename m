Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A35C7618E
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Apr 2023 07:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbjDZHK2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Apr 2023 03:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbjDZHJ3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Apr 2023 03:09:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DC74694
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:07:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b922aa3725fso12915347276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682492796; x=1685084796;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMkOwzwif+XT0+nBV5mOmwMnUg0kBSArT43+8IsF+QA=;
        b=TUyKxSBBJc+RdtsM0Ipk1QAqXQ79rrp0vRDC3FEwlgTCwqqLPydawMNTsnW0gTK4N3
         48XHpnfBQ3hx8uJhkXefmyIXDz1RxgNEJ9BPoj6/cqdzbF/dAnXw92ZbTYvEFKJDe1Mi
         W5UljueUV9xRwFYxsh+bd9YxpefkIwAvcnaHt8eQn4yTg557+osTCe7g/ITNtKmgkEmB
         5iRMmjSwhPIjSZRoj5g9pcz6vxnOc+NK06r6hdFSC1nc9qYo1w5tdP+YOqKMg4Oyhj3z
         0mFsXen70PxG0g96Ts5sKRRZhaLTNb40/eLK5nxdAno6kjp4q2IF0vec/4UHY0ilQXob
         mtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682492796; x=1685084796;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMkOwzwif+XT0+nBV5mOmwMnUg0kBSArT43+8IsF+QA=;
        b=QXsQo/LgjoKbKrHD6/0Jalh57XbHWT2QZq9soZ12dVK1yeitI45rde0iBcGK9/r6vf
         gfyyLhUwD+A5Kk7cs+rPYc7oWJUewisChqEjgo1VWSQ+UCUHMCwrTbZCVmhYgth2ARZE
         b7q5Jyt1IlOYGPHGXHSQoUG3ppA2FhuV6LBVRHrBoWEylGC9ojl0QG8A1j9TbvHWYbid
         hkjhHlnXT42CA8moztZY6zJmXtqQttPVgrIdk1m/Fwl+g+l932G+9+BDF9YndQqQN9aV
         vrEx7e5HSwWOsXH2v2qAJIB8IA+8ux8Se4B51nOhlmC6WiUC5xRrlLg7acTXhV5E5mfn
         WU2Q==
X-Gm-Message-State: AAQBX9d7SShrmQaGdWXeQXPmiiZYOmFXX4j4JaL6XKt28qGiQww0PZ48
        SSyCQhDH8FpzIfNBPfpgOon6T7HXThVA
X-Google-Smtp-Source: AKy350bTJLOxcltCw5a6MXyD2IISezfFvAcGUVYrqdRXnBze4q7xvqgQDhzkkf95a6knq7Tm4DsBwtS33P3x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:144f:e890:2b29:48d9])
 (user=irogers job=sendgmr) by 2002:a25:d0c7:0:b0:b97:2ecf:ff6d with SMTP id
 h190-20020a25d0c7000000b00b972ecfff6dmr11084850ybg.5.1682492796043; Wed, 26
 Apr 2023 00:06:36 -0700 (PDT)
Date:   Wed, 26 Apr 2023 00:00:50 -0700
In-Reply-To: <20230426070050.1315519-1-irogers@google.com>
Message-Id: <20230426070050.1315519-41-irogers@google.com>
Mime-Version: 1.0
References: <20230426070050.1315519-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v1 40/40] perf metrics: Be PMU specific in event match
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

