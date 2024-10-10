Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD81C5796;
	Thu, 10 Oct 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546275; cv=none; b=rvAaTSNq9JtC4XNSydIN2NPd6V5IkYaZ7xBHxdwr0OQ9aSIbngAI8vONRZSHM2N5/CK8VcHHzMGJTV+zyg8zT89GuohJt3hDBdjLCR/2r0sjGiKvRq9kTL7Kk24PhNa5RBnM9oBvosjw5IIc6MIrYxrWFu68k/ue5nutprQHcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546275; c=relaxed/simple;
	bh=xW9Aem4bT3xdvCkS27khxSn+XWTR/JYMW/swhyA+2fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XqYWSU9YXC6zE9Rr/CW09j+05R6LlHRl19bgS+Xx95tzQuTb146O/Efrv2yZM9RqJU5cpM8ZYLhv7hUsZh365veCgvoQni2Ukut1VtBm9lxMuSY6YMyR2gPvlJhRgvzpfAJ8AmkZc78EMjChAAQD4dgLzlBlv5QhUocqvS9Ocmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XPMF63p3Zz2DcwW;
	Thu, 10 Oct 2024 15:43:22 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (unknown [7.185.36.158])
	by mail.maildlp.com (Postfix) with ESMTPS id E2C611400D2;
	Thu, 10 Oct 2024 15:44:28 +0800 (CST)
Received: from ubuntu.huawei.com (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 15:44:28 +0800
From: Junhao He <hejunhao3@huawei.com>
To: <irogers@google.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH v2] perf metrics: Support parsing metrics if platforms only have json table of system PMU
Date: Thu, 10 Oct 2024 15:44:30 +0800
Message-ID: <20241010074430.16685-1-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500002.china.huawei.com (7.185.36.158)

The system PMUs don't depend on the certain CPUs and we don't need a CPUID
to metric table mapping to match the json event for generating the metric
table. For example HiSilicon HIP09 only have json events table of system
PMUs in the "sys/" subdirectory.

Currently for this case the struct of system metric table
"pmu_metrics__hisilicon_hip09_sys" generating works fine and metrics
display as expected by using `perf list`. But `perf stat` doesn't work
for such metrics.

  $ perf list metric
  Metrics:
    cpa_p0_avg_bw
         [Average bandwidth of CPA Port 0]
    cpa_p1_avg_bw
         [Average bandwidth of CPA Port 1]
  $ perf stat -M cpa_p0_avg_bw --timeout 1000 --> No error messages output
  $ echo $?
  234

The metricgroup__parse_groups() expects to find an cpu metric table, but
the hisilicon/hip09 doesn't uses CPUID to map json events and metrics, so
pmu_metrics_table__find() will return NULL, than the cmd run failed.

But in metricgroup__add_metric(), the function parse for each sys metric
and add it to metric_list, which also will get an valid sys metric table.
So, we can ignore the NULL result of pmu_metrics_table__find() and to use
the sys metric table.

metricgroup__parse_groups
 -> parse_groups
     -> metricgroup__add_metric_list
         -> metricgroup__add_metric
	     -> pmu_for_each_sys_metric   --> parse for each sys metric

Testing:
  $ perf stat -M cpa_p0_avg_bw --timeout 1000

 Performance counter stats for 'system wide':

     4,004,863,602      cpa_cycles                #     0.00 cpa_p0_avg_bw
                 0      cpa_p0_wr_dat
                 0      cpa_p0_rd_dat_64b
                 0      cpa_p0_rd_dat_32b

       1.001306160 seconds time elapsed

Signed-off-by: Junhao He <hejunhao3@huawei.com>
Tested-by: Yicong Yang <yangyicong@hisilicon.com>
---
v1 --> v2:
 -Add some comments to explain the table is null.
 -Modify the patch commit.
 -Add Yicong Test-by.
v1:https://lore.kernel.org/all/20240807040002.47119-1-hejunhao3@huawei.com/
---
 tools/perf/util/metricgroup.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 69f6a46402c3..cb428eabd485 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1123,7 +1123,7 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_metric *pm,
 
 	ret = add_metric(d->metric_list, pm, d->modifier, d->metric_no_group,
 			 d->metric_no_threshold, d->user_requested_cpu_list,
-			 d->system_wide, d->root_metric, d->visited, d->table);
+			 d->system_wide, d->root_metric, d->visited, d->table ?: table);
 	if (ret)
 		goto out;
 
@@ -1226,7 +1226,8 @@ static int metricgroup__add_metric_callback(const struct pmu_metric *pm,
  * @system_wide: Are events for all processes recorded.
  * @metric_list: The list that the metric or metric group are added to.
  * @table: The table that is searched for metrics, most commonly the table for the
- *       architecture perf is running upon.
+ *       architecture perf is running upon. This value could be NULL if no core
+ *       metrics matches the architecture and we'll try to use the table of system PMUs.
  */
 static int metricgroup__add_metric(const char *pmu, const char *metric_name, const char *modifier,
 				   bool metric_no_group, bool metric_no_threshold,
@@ -1239,7 +1240,8 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 	int ret;
 	bool has_match = false;
 
-	{
+	/* Add core metrics to the metric list */
+	if (table) {
 		struct metricgroup__add_metric_data data = {
 			.list = &list,
 			.pmu = pmu,
@@ -1263,6 +1265,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 		has_match = data.has_match;
 	}
 	{
+		/* Parse metrics table of system PMUs */
 		struct metricgroup_iter_data data = {
 			.fn = metricgroup__add_metric_sys_event_iter,
 			.data = (void *) &(struct metricgroup_add_iter_data) {
@@ -1697,7 +1700,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 
 	if (!table)
-		return -EINVAL;
+		pr_debug("The core metric table not found, continue to parse system metric table\n");
+
 	if (hardware_aware_grouping)
 		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
 
-- 
2.33.0

