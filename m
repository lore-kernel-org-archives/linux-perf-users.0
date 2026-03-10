Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7AC3A785F;
	Tue, 10 Mar 2026 04:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773115578; cv=none; b=B3yvWU1j5IX75H7neie3d2mZpSdzb4ASaVOS21Xa2I0vMESsy98pKOeaucC87qwmvSwbjmmf3R7tS6pAK+BQ3LyJA6a8L6ECRYf4FRqy+SPC2jFTJUgMpm3bkWZi2KDmTkqVBwP/BCUPRdTSdCXWWJHUAC3AzhyRgTtCu3VUyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773115578; c=relaxed/simple;
	bh=9K++Md/MjH3xmXm7C56VANAqYK/MiIVgFmlgdnFSmo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQKd2Yx1uwK2YhLZeMJDv507WqGiC4NQ8zcew4rrYd6dFfphvcpxYZi9GaOIHxzioAz/EY9/Gwy/yChSwde+o2WremLKrI1KxA4rjpDG9fWKuxORKIHjmztxaEV9YlMKwBg9gOkKW8g3RuzxXJ4IodivuHrYLTg6TxLqMZFCmuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=McFMh+f4; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="McFMh+f4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Fbjjlmiz5ZApf0Q+rqPuA7UgQQGuX/gPvGaAJQO5+Mc=;
	b=McFMh+f4hGy8IXxc6kwDTSfAMeEBahCrcocJhkFJpYcSiBEkqc+GV/Wmq5HmQR3kddUwpduLY
	mkxdXmtJikPqDYG2albAnj2o1t7M6qqKETnjzXcijlsmSiEFkgZObKNuUF9Q3mBxR8eHS9T0Zch
	24BDwjaf9gfp54d/gMcPQP0=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fVKt90MJvzcbS0;
	Tue, 10 Mar 2026 12:00:49 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 26C6F40538;
	Tue, 10 Mar 2026 12:06:13 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 12:06:12 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <namhyung@kernel.org>, <irogers@google.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <wangyushan12@huawei.com>,
	<hejunhao3@h-partners.com>, <jonathan.cameron@huawei.com>,
	<xiaqinxin@huawei.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<linuxarm@huawei.com>
Subject: [PATCH v2 1/1] perf: Add --pmu-filter option for filtering PMUs
Date: Tue, 10 Mar 2026 12:06:07 +0800
Message-ID: <20260310040607.1780971-2-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260310040607.1780971-1-xiaqinxin@huawei.com>
References: <20260310040607.1780971-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200003.china.huawei.com (7.202.194.15)

This patch adds a new --pmu-filter option to perf-stat command to allow
filtering events on specific PMUs. This is useful when there are
multiple PMUs with same type (e.g. hisi_sicl2_cpa0 and hisi_sicl0_cpa0).

[root@localhost tmp]# perf stat -M cpa_p0_avg_bw
 Performance counter stats for 'system wide':

    19,417,779,115      hisi_sicl0_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
                 0      hisi_sicl0_cpa0/cpa_p0_wr_dat/
                 0      hisi_sicl0_cpa0/cpa_p0_rd_dat_64b/
                 0      hisi_sicl0_cpa0/cpa_p0_rd_dat_32b/
    19,417,751,103      hisi_sicl10_cpa0/cpa_cycles/     #     0.00 cpa_p0_avg_bw
                 0      hisi_sicl10_cpa0/cpa_p0_wr_dat/
                 0      hisi_sicl10_cpa0/cpa_p0_rd_dat_64b/
                 0      hisi_sicl10_cpa0/cpa_p0_rd_dat_32b/
    19,417,730,679      hisi_sicl2_cpa0/cpa_cycles/      #     0.31 cpa_p0_avg_bw
        75,635,749      hisi_sicl2_cpa0/cpa_p0_wr_dat/
        18,520,640      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
                 0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
    19,417,674,227      hisi_sicl8_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
                 0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
                 0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
                 0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/

      19.417734480 seconds time elapsed

[root@localhost tmp]# perf stat --pmu-filter hisi_sicl2_cpa0 -M cpa_p0_avg_bw
 Performance counter stats for 'system wide':

     6,234,093,559      cpa_cycles                       #     0.60 cpa_p0_avg_bw
        50,548,465      cpa_p0_wr_dat
         7,552,182      cpa_p0_rd_dat_64b
                 0      cpa_p0_rd_dat_32b

       6.234139320 seconds time elapsed

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 tools/perf/Documentation/perf-stat.txt |  4 ++++
 tools/perf/builtin-stat.c              | 19 +++++++++++++++++++
 tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
 tools/perf/util/parse-events.c         |  2 +-
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 7cccc3a847d1..b72a29c9223c 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -578,6 +578,10 @@ $ perf config stat.no-csv-summary=true
 Only enable events on applying cpu with this type for hybrid platform
 (e.g. core or atom)"
 
+--pmu-filter::
+Only enable events on applying pmu with specified for multiple
+pmus with same type (e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)
+
 EXAMPLES
 --------
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 73c2ba7e3076..69c83a5beb71 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1214,6 +1214,21 @@ static int parse_cputype(const struct option *opt,
 	return 0;
 }
 
+static int parse_pmu_filter(const struct option *opt,
+			   const char *str,
+			   int unset __maybe_unused)
+{
+	struct evlist *evlist = *(struct evlist **)opt->value;
+
+	if (!list_empty(&evlist->core.entries)) {
+		fprintf(stderr, "Must define pmu-filter before events/metrics\n");
+		return -1;
+	}
+
+	parse_events_option_args.pmu_filter = str;
+	return 0;
+}
+
 static int parse_cache_level(const struct option *opt,
 			     const char *str,
 			     int unset __maybe_unused)
@@ -2561,6 +2576,10 @@ int cmd_stat(int argc, const char **argv)
 			"Only enable events on applying cpu with this type "
 			"for hybrid platform (e.g. core or atom)",
 			parse_cputype),
+		OPT_CALLBACK(0, "pmu-filter", &evsel_list, "pmu",
+			"Only enable events on applying pmu with specified "
+			"for multiple pmus with same type(e.g. hisi_sicl2_cpa0 or hisi_sicl0_cpa0)",
+			parse_pmu_filter),
 #ifdef HAVE_LIBPFM
 		OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
 			"libpfm4 event selector. use 'perf list' to list available events",
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 46bf4dfeebc8..89b83ca38483 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -387,8 +387,13 @@ static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const char *p
 				      const char *metric_or_groups)
 {
 	const char *pm_pmu = pm->pmu ?: "cpu";
+	struct perf_pmu *perf_pmu = NULL;
 
-	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
+	if (pm->pmu)
+		perf_pmu = perf_pmus__find(pm->pmu);
+
+	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
+	   (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
 		return false;
 
 	return match_metric_or_groups(pm->metric_group, metric_or_groups) ||
@@ -1259,7 +1264,8 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 static int parse_ids(bool metric_no_merge, bool fake_pmu,
 		     struct expr_parse_ctx *ids, const char *modifier,
 		     bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
-		     struct evlist **out_evlist)
+		     struct evlist **out_evlist,
+		     const char *filter_pmu)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
@@ -1313,7 +1319,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	}
 	pr_debug("Parsing metric events '%s'\n", events.buf);
 	parse_events_error__init(&parse_error);
-	ret = __parse_events(parsed_evlist, events.buf, /*pmu_filter=*/NULL,
+	ret = __parse_events(parsed_evlist, events.buf, filter_pmu,
 			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
 			     /*fake_tp=*/false);
 	if (ret) {
@@ -1416,7 +1422,8 @@ static int parse_groups(struct evlist *perf_evlist,
 					/*modifier=*/NULL,
 					/*group_events=*/false,
 					tool_events,
-					&combined_evlist);
+					&combined_evlist,
+					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
 		}
 		if (combined)
 			expr__ctx_free(combined);
@@ -1471,7 +1478,8 @@ static int parse_groups(struct evlist *perf_evlist,
 		}
 		if (!metric_evlist) {
 			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
-					m->group_events, tool_events, &m->evlist);
+					m->group_events, tool_events, &m->evlist,
+					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
 			if (ret)
 				goto out;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b9efb296bba5..789ff4d15e47 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -429,7 +429,7 @@ bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 	if (parse_state->pmu_filter == NULL)
 		return false;
 
-	return strcmp(parse_state->pmu_filter, pmu->name) != 0;
+	return perf_pmu__wildcard_match(pmu, parse_state->pmu_filter) == 0;
 }
 
 static int parse_events_add_pmu(struct parse_events_state *parse_state,
-- 
2.33.0

