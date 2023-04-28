Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698BC77B61
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Apr 2023 07:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345867AbjD1HqU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Apr 2023 03:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345720AbjD1Hps (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Apr 2023 03:45:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3DD59FD
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:44:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a2abd8f7bso6109738276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Apr 2023 00:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682667824; x=1685259824;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9J7avGu03QLF3OzvxpAd+rFmIiyVUKJL1J9REWiEeQ0=;
        b=WkuzWHPyPiNlGAeiwQK08JMfsOkb7agN+SMcqKL/XvQdcejPX4610ZTQ54WefYECfV
         PdIWXSxmAS5lTIneaDo6m5lg4XshsMifErIez2fdygC+XJ8/GzEiBNY6ofahzsWIrss9
         Kpwuaq/JopFHKcXH4M4DmbYsCKPoSQIcYA/m1uJxEbFgFC2nwtZFPD6CsUrONq0CEgWk
         o3NuatjH/HItKa+Ej8feqLtkDdM3woSD0fE6RR0JHrZUvwjww67JqjlkIw3GbQBlPuaH
         4/q7IbCtVteKDYy+9kew2cjxt0cTTjSqmi0fIQgNSlv4PD2EmuZffPvmBmGajqWz9/2+
         xeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667824; x=1685259824;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9J7avGu03QLF3OzvxpAd+rFmIiyVUKJL1J9REWiEeQ0=;
        b=BybxzV0MQL7GDNr9CyRFKOUWlfTOANRSlk8c33IKoPdAGZipiYtNgNUOCb9ONnoLw0
         RLbD+IknaJy5rQi9tOjEkzH9RMhE349fSJu55gAi0cMTbgtIzxpMJycqN18BH1gxqKJ4
         M5B+m2AdE3T79iWyqy8SRrR1Z22ctSFxvCpNnN8pFIomu9oish/UvePV+iQRXWcoIpah
         uN91L96N8+bYakarJUm5JV94AF7iSIOOkgiVVyW3MJazIrP9GK3p0NOqZF58sn6H3FNr
         mqIkw/nDP51fwoekjm/bG2qCIuIFjaKETG9hbGjVczlkrphHk0GfPOv0+hbzE0kvwpMe
         MMaA==
X-Gm-Message-State: AC+VfDzSxyCb7jUxP6D0tL2a9OaBxbU1YvI8Oeq1QR5O1qk0Fq5fnBC8
        k4m7NJpj/RVyvb/VrrmdJdrl8etiCTD5
X-Google-Smtp-Source: ACHHUZ4yyUTiXtU7C5etvtQ7AFAquH2SO1IK++295goKnQafUfcRT1GEGI4oi5FKWdfsBaARCFnUfZkB1FSg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:24a7:aeb5:5de4:c29b])
 (user=irogers job=sendgmr) by 2002:a25:1388:0:b0:b95:ecc5:5796 with SMTP id
 130-20020a251388000000b00b95ecc55796mr1542247ybt.12.1682667824191; Fri, 28
 Apr 2023 00:43:44 -0700 (PDT)
Date:   Fri, 28 Apr 2023 00:38:04 -0700
In-Reply-To: <20230428073809.1803624-1-irogers@google.com>
Message-Id: <20230428073809.1803624-39-irogers@google.com>
Mime-Version: 1.0
References: <20230428073809.1803624-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v2 38/43] perf stat: Command line PMU metric filtering
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

Wire up the --cputype value to limit which metrics are parsed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 20 ++++++++++++--------
 tools/perf/util/metricgroup.c |  3 ++-
 tools/perf/util/metricgroup.h |  1 +
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bb1a4ecd7558..f4e572f9de6b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1783,6 +1783,7 @@ static int add_default_attributes(void)
 };
 
 	struct perf_event_attr default_null_attrs[] = {};
+	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
 
 	/* Set attrs if no event is selected and !null_run: */
 	if (stat_config.null_run)
@@ -1794,11 +1795,11 @@ static int add_default_attributes(void)
 		 * will use this approach. To determine transaction support
 		 * on an architecture test for such a metric name.
 		 */
-		if (!metricgroup__has_metric("all", "transaction")) {
+		if (!metricgroup__has_metric(pmu, "transaction")) {
 			pr_err("Missing transaction metrics");
 			return -1;
 		}
-		return metricgroup__parse_groups(evsel_list, "transaction",
+		return metricgroup__parse_groups(evsel_list, pmu, "transaction",
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
@@ -1823,7 +1824,7 @@ static int add_default_attributes(void)
 			smi_reset = true;
 		}
 
-		if (!metricgroup__has_metric("all", "smi")) {
+		if (!metricgroup__has_metric(pmu, "smi")) {
 			pr_err("Missing smi metrics");
 			return -1;
 		}
@@ -1831,7 +1832,7 @@ static int add_default_attributes(void)
 		if (!force_metric_only)
 			stat_config.metric_only = true;
 
-		return metricgroup__parse_groups(evsel_list, "smi",
+		return metricgroup__parse_groups(evsel_list, pmu, "smi",
 						stat_config.metric_no_group,
 						stat_config.metric_no_merge,
 						stat_config.metric_no_threshold,
@@ -1864,7 +1865,8 @@ static int add_default_attributes(void)
 				"Please print the result regularly, e.g. -I1000\n");
 		}
 		str[8] = stat_config.topdown_level + '0';
-		if (metricgroup__parse_groups(evsel_list, str,
+		if (metricgroup__parse_groups(evsel_list,
+						pmu, str,
 						/*metric_no_group=*/false,
 						/*metric_no_merge=*/false,
 						/*metric_no_threshold=*/true,
@@ -1903,14 +1905,14 @@ static int add_default_attributes(void)
 		 * caused by exposing latent bugs. This is fixed properly in:
 		 * https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
 		 */
-		if (metricgroup__has_metric("all", "TopdownL1") && !perf_pmu__has_hybrid()) {
+		if (metricgroup__has_metric(pmu, "TopdownL1") && !perf_pmu__has_hybrid()) {
 			struct evlist *metric_evlist = evlist__new();
 			struct evsel *metric_evsel;
 
 			if (!metric_evlist)
 				return -1;
 
-			if (metricgroup__parse_groups(metric_evlist, "TopdownL1",
+			if (metricgroup__parse_groups(metric_evlist, pmu, "TopdownL1",
 							/*metric_no_group=*/false,
 							/*metric_no_merge=*/false,
 							/*metric_no_threshold=*/true,
@@ -2434,7 +2436,9 @@ int cmd_stat(int argc, const char **argv)
 	 * knowing the target is system-wide.
 	 */
 	if (metrics) {
-		metricgroup__parse_groups(evsel_list, metrics,
+		const char *pmu = parse_events_option_args.pmu_filter ?: "all";
+
+		metricgroup__parse_groups(evsel_list, pmu, metrics,
 					stat_config.metric_no_group,
 					stat_config.metric_no_merge,
 					stat_config.metric_no_threshold,
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 17478eb33bdc..4245b23d8efe 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1648,6 +1648,7 @@ static int parse_groups(struct evlist *perf_evlist,
 }
 
 int metricgroup__parse_groups(struct evlist *perf_evlist,
+			      const char *pmu,
 			      const char *str,
 			      bool metric_no_group,
 			      bool metric_no_merge,
@@ -1661,7 +1662,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 	if (!table)
 		return -EINVAL;
 
-	return parse_groups(perf_evlist, "all", str, metric_no_group, metric_no_merge,
+	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/NULL, metric_events, table);
 }
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 08e9b9e953ec..bf18274c15df 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -67,6 +67,7 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
 					 bool create);
 int metricgroup__parse_groups(struct evlist *perf_evlist,
+			      const char *pmu,
 			      const char *str,
 			      bool metric_no_group,
 			      bool metric_no_merge,
-- 
2.40.1.495.gc816e09b53d-goog

