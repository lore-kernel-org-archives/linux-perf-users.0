Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2A2BD00C;
	Wed, 25 Feb 2026 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771990910; cv=none; b=rRTByk+MABUuuuknQzD0JtJO7rtfQdOZOYo7Kjf3FRFIoawQFfBGebNY/PwnPZL9IE8sUTdJX57UgJhkFB11PKF6ogRXZsEIEndX/rPJCt0+DwTuFFXkTmkCZIAQROo0OYGsvT6RpkUNoT/u3ROgamDXCtkavYxZHs+500IvsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771990910; c=relaxed/simple;
	bh=5zSaQyLXwT7eATBFRVc0k/0DwLA0C4p4Y/lQU6cryi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6wl56rQYaOnGI66/f9stV3pkywqjTymJjaj3VIcnZp8DLrnGHSIgDjGozklGqIUW3ZRVf+Rq/hEYIgyPobtxx3yxvUbk6X9zrryCmhdhOcBvjiaLhxx/65o79b2AogGUIEnRo9L4n5Aad9hKNpSuJf3HwSsjSMywmVlAR49YDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0iOWW+UT; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0iOWW+UT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QTaK3J797ooLPfafRPzsW3EQZPBnbFtb290pFr12fBI=;
	b=0iOWW+UTLgimZ3VB44933YkASy9VdH5jNosc1SVixiMoR4Slwptt2p1vxerJppqrnMuEULFJX
	eRYW4MGEqMXz45eghxw4bnoH4b4b0pOTsDyAnyY5gBjgHWFwL9FnFQPT2CPy2BDqEIKWIwUhQUO
	6cENKPdifBryWENj6NetjrM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fLKyH4QPtzcZyP;
	Wed, 25 Feb 2026 11:36:39 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 0383920168;
	Wed, 25 Feb 2026 11:41:40 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Feb 2026 11:41:39 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <irogers@google.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <wangyushan12@huawei.com>,
	<hejunhao3@h-partners.com>, <jonathan.cameron@huawei.com>,
	<xiaqinxin@huawei.com>
CC: <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>,
	<"james.clark@linaro.org.linuxarm"@huawei.com>
Subject: [PATCH 1/1] perf: Add --pmu-filter option for filtering PMUs
Date: Wed, 25 Feb 2026 11:41:25 +0800
Message-ID: <20260225034125.2157622-2-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260225034125.2157622-1-xiaqinxin@huawei.com>
References: <20260225034125.2157622-1-xiaqinxin@huawei.com>
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

perf event:
[root@localhost tmp]# perf stat -e cpa_cycles
 Performance counter stats for 'system wide':

     3,005,509,659      hisi_sicl0_cpa0/cpa_cycles/
     3,005,502,319      hisi_sicl2_cpa0/cpa_cycles/

       3.005460970 seconds time elapsed

[root@localhost tmp]# perf stat --pmu-filter hisi_sicl0_cpa0 -e cpa_cycles
 Performance counter stats for 'system wide':

     3,003,899,571      cpa_cycles

       3.003864470 seconds time elapsed

perf metric:
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
 tools/perf/builtin-stat.c              | 26 ++++++++++++++++++++++++++
 tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
 3 files changed, 43 insertions(+), 5 deletions(-)

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
index 73c2ba7e3076..67fb91816c0b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1214,6 +1214,28 @@ static int parse_cputype(const struct option *opt,
 	return 0;
 }
 
+static int parse_pmu_filter(const struct option *opt,
+			   const char *str,
+			   int unset __maybe_unused)
+{
+	const struct perf_pmu *pmu;
+	struct evlist *evlist = *(struct evlist **)opt->value;
+
+	if (!list_empty(&evlist->core.entries)) {
+		fprintf(stderr, "Must define pmu-filter before events/metrics\n");
+		return -1;
+	}
+
+	pmu = perf_pmus__pmu_for_pmu_filter(str);
+	if (!pmu) {
+		fprintf(stderr, "--pmu-filter %s is not supported!\n", str);
+		return -1;
+	}
+	parse_events_option_args.pmu_filter = pmu->name;
+
+	return 0;
+}
+
 static int parse_cache_level(const struct option *opt,
 			     const char *str,
 			     int unset __maybe_unused)
@@ -2561,6 +2583,10 @@ int cmd_stat(int argc, const char **argv)
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
 
-- 
2.33.0

