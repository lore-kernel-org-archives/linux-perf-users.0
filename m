Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41A539763;
	Tue, 13 Oct 2026 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917801; cv=none; b=bC5pqRagqNlPwM+Hm/T+VJVnCwaihnYGsJ3rVSozUQAJBooszGNZZeT2LT9hhrRjW3lTE4zdXtXsN4lSa3IGMFjld/q4wRf8hK360WJQGQlWD3IcqfFWuNMnkruf+DS696Cpm6VI0wdDjRe9bH88vH05ue6u87lBJCp7f0pOeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917801; c=relaxed/simple;
	bh=xx7Bblt8qiKvgcx0nKyJwYc/tFIgAQ9Hbe1NWoBcKzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLRnE2NcWk19WEvnNZrs/rDAvFncphYSqUIVYpaUymVoyLrY2kfpk4puenYCFhdAm9bROj6atKoY42457xcXVY7l1ilHcJ0teOeYYWlXlKuDwaancZiVm/xUPexMQ5Fc/SznbSZp0huHoh+nzD2ykDAvEARoW1Ov0t7FWESRNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rdr7SzH8; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rdr7SzH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1791917799; x=1823453799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=19JxaAG8/HI6lbc9IVe7CO4geNuRT0i/vZopAR0ANuU=;
  b=Rdr7SzH8ca1O1QD9P15AxyxspdNVdC/VGx181Oynm8v4f7kF1FPqrxKN
   MU6RJwRxkx56Pa9REv+T9KNXpv6uN2h5oO8YfB6dPq+dRS+MzztOcisUd
   6jiCQqVUGB9TW59Euj6q4lXEZAzjJvnK4fM+sdxBADdPUow0yOgnd3I0L
   MWb5V8SvMH5cCdq3pInJBhVk/6Y9CrQJnMIVT94gOiMqefiTpIQmSQMIz
   u18SNE/qpBCmm0QyI+NaBzdgpp2y8vhfYA29lP0O1oQp+77g7bzC1Xcgh
   8YLpXD3AMtv58BlP4+mUhgzB6PvhzGqyfVUh1iWYr7LqdmnsoVlPWuJKM
   Q==;
X-CSE-ConnectionGUID: IP7drwJ6TR6VbYrPP3OiCA==
X-CSE-MsgGUID: ITnK4KjjR9m0aQE1cBlYvg==
X-IronPort-AV: E=Sophos;i="6.27,156,1787011200"; 
   d="scan'208";a="30939256"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 18:56:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:5287]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.108:2525] with esmtp (Farcaster)
 id fe19b1d2-d3af-451c-9f56-1f65b7499215; Tue, 13 Oct 2026 18:56:39 +0000 (UTC)
X-Farcaster-Flow-ID: fe19b1d2-d3af-451c-9f56-1f65b7499215
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 18:56:39 +0000
Received: from u34cccd802f2d52.amazon.com (10.187.170.30) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 18:56:37 +0000
From: Haris Okanovic <harisokn@amazon.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <harisokn@amazon.com>
Subject: [PATCH 4/4] perf/arm-cmn: Convert to PERF_PMU_SCOPE_DEVICE
Date: Tue, 13 Oct 2026 13:56:03 -0500
Message-ID: <20261013185603.1347265-5-harisokn@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013185603.1347265-1-harisokn@amazon.com>
References: <20261013185603.1347265-1-harisokn@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Set pmu::scope to PERF_PMU_SCOPE_DEVICE and remove the driver-tracked cpu,
hotplug hooks, and the 'cpumask' attribute, since perf core does this
for device scope PMUs.

Define a filter_allowed_cpus() callback to keep preference for CPUs local
to the interconnect's NUMA node, and a migrate_cpu() callback to update
DTC interrupt affinity on migration.

Signed-off-by: Haris Okanovic <harisokn@amazon.com>
---
 drivers/perf/arm-cmn.c | 104 +++++++++--------------------------------
 1 file changed, 22 insertions(+), 82 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 5378fba916cf5..997ee5adf3f8e 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -388,17 +388,12 @@ struct arm_cmn {
 	struct arm_cmn_dtc *dtc;
 	unsigned int num_dtcs;
 
-	int cpu;
-	struct hlist_node cpuhp_node;
-
 	struct pmu pmu;
 	struct dentry *debug;
 };
 
 #define to_cmn(p)	container_of(p, struct arm_cmn, pmu)
 
-static int arm_cmn_hp_state;
-
 struct arm_cmn_nodeid {
 	u8 port;
 	u8 dev;
@@ -1511,17 +1506,6 @@ static const struct attribute_group arm_cmn_format_attrs_group = {
 	.attrs = arm_cmn_format_attrs,
 };
 
-static ssize_t arm_cmn_cpumask_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
-
-	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(cmn->cpu)));
-}
-
-static struct device_attribute arm_cmn_cpumask_attr =
-		__ATTR(cpumask, 0444, arm_cmn_cpumask_show, NULL);
-
 static ssize_t arm_cmn_identifier_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
@@ -1534,7 +1518,6 @@ static struct device_attribute arm_cmn_identifier_attr =
 		__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
 
 static struct attribute *arm_cmn_other_attrs[] = {
-	&arm_cmn_cpumask_attr.attr,
 	&arm_cmn_identifier_attr.attr,
 	NULL,
 };
@@ -1981,11 +1964,7 @@ static int arm_cmn_event_init(struct perf_event *event)
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
 
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
-		return -EINVAL;
-
-	event->cpu = cmn->cpu;
-	if (event->cpu < 0)
+	if (is_sampling_event(event))
 		return -EINVAL;
 
 	type = CMN_EVENT_TYPE(event);
@@ -2243,48 +2222,26 @@ static int arm_cmn_commit_txn(struct pmu *pmu)
 	return 0;
 }
 
-static void arm_cmn_migrate(struct arm_cmn *cmn, unsigned int cpu)
+static int arm_cmn_filter_allowed_cpus(struct pmu *pmu, struct cpumask *allowed_cpus)
 {
-	unsigned int i;
+	struct arm_cmn *cmn = to_cmn(pmu);
+	int node = dev_to_node(cmn->dev);
 
-	perf_pmu_migrate_context(&cmn->pmu, cmn->cpu, cpu);
-	for (i = 0; i < cmn->num_dtcs; i++)
-		irq_set_affinity(cmn->dtc[i].irq, cpumask_of(cpu));
-	cmn->cpu = cpu;
-}
+	/* Any CPU can drive the CMN, but prefer local ones */
+	if (node != NUMA_NO_NODE &&
+	    cpumask_intersects(allowed_cpus, cpumask_of_node(node)))
+		cpumask_and(allowed_cpus, allowed_cpus, cpumask_of_node(node));
 
-static int arm_cmn_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
-{
-	struct arm_cmn *cmn;
-	int node;
-
-	cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
-	node = dev_to_node(cmn->dev);
-	if (cpu_to_node(cmn->cpu) != node && cpu_to_node(cpu) == node)
-		arm_cmn_migrate(cmn, cpu);
-	return 0;
+	return cpumask_empty(allowed_cpus) ? -ENODEV : 0;
 }
 
-static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+static void arm_cmn_migrate_cpu(struct pmu *pmu, unsigned int cpu)
 {
-	struct arm_cmn *cmn;
-	unsigned int target;
-	int node;
-
-	cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
-	if (cpu != cmn->cpu)
-		return 0;
-
-	node = dev_to_node(cmn->dev);
-
-	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
-	if (target >= nr_cpu_ids)
-		target = cpumask_any_but(cpu_online_mask, cpu);
-
-	if (target < nr_cpu_ids)
-		arm_cmn_migrate(cmn, target);
+	struct arm_cmn *cmn = to_cmn(pmu);
+	unsigned int i;
 
-	return 0;
+	for (i = 0; i < cmn->num_dtcs; i++)
+		WARN_ON_ONCE(irq_set_affinity(cmn->dtc[i].irq, cpumask_of(cpu)));
 }
 
 static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
@@ -2341,10 +2298,6 @@ static int arm_cmn_init_irqs(struct arm_cmn *cmn)
 				       dev_name(cmn->dev), &cmn->dtc[i]);
 		if (err)
 			return err;
-
-		err = irq_set_affinity(irq, cpumask_of(cmn->cpu));
-		if (err)
-			return err;
 	next:
 		; /* isn't C great? */
 	}
@@ -2843,7 +2796,6 @@ static int arm_cmn_probe(struct platform_device *pdev)
 
 	cmn->dev = &pdev->dev;
 	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
-	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	platform_set_drvdata(pdev, cmn);
 
 	cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -2877,6 +2829,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 		.attr_groups = arm_cmn_attr_groups,
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 		.task_ctx_nr = perf_invalid_context,
+		.scope = PERF_PMU_SCOPE_DEVICE,
 		.pmu_enable = arm_cmn_pmu_enable,
 		.pmu_disable = arm_cmn_pmu_disable,
 		.event_init = arm_cmn_event_init,
@@ -2888,6 +2841,8 @@ static int arm_cmn_probe(struct platform_device *pdev)
 		.start_txn = arm_cmn_start_txn,
 		.commit_txn = arm_cmn_commit_txn,
 		.cancel_txn = arm_cmn_end_txn,
+		.filter_allowed_cpus = arm_cmn_filter_allowed_cpus,
+		.migrate_cpu = arm_cmn_migrate_cpu,
 	};
 
 	this_id = atomic_fetch_inc(&id);
@@ -2895,17 +2850,13 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	if (!name)
 		return -ENOMEM;
 
-	err = cpuhp_state_add_instance(arm_cmn_hp_state, &cmn->cpuhp_node);
+	err = perf_pmu_register(&cmn->pmu, name, -1);
 	if (err)
 		return err;
 
-	err = perf_pmu_register(&cmn->pmu, name, -1);
-	if (err)
-		cpuhp_state_remove_instance_nocalls(arm_cmn_hp_state, &cmn->cpuhp_node);
-	else
-		arm_cmn_debugfs_init(cmn, this_id);
+	arm_cmn_debugfs_init(cmn, this_id);
 
-	return err;
+	return 0;
 }
 
 static void arm_cmn_remove(struct platform_device *pdev)
@@ -2915,7 +2866,6 @@ static void arm_cmn_remove(struct platform_device *pdev)
 	writel_relaxed(0, cmn->dtc[0].base + CMN_DT_DTC_CTL);
 
 	perf_pmu_unregister(&cmn->pmu);
-	cpuhp_state_remove_instance_nocalls(arm_cmn_hp_state, &cmn->cpuhp_node);
 	debugfs_remove(cmn->debug);
 }
 
@@ -2958,28 +2908,18 @@ static int __init arm_cmn_init(void)
 {
 	int ret;
 
-	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
-				      "perf/arm/cmn:online",
-				      arm_cmn_pmu_online_cpu,
-				      arm_cmn_pmu_offline_cpu);
-	if (ret < 0)
-		return ret;
-
-	arm_cmn_hp_state = ret;
 	arm_cmn_debugfs = debugfs_create_dir("arm-cmn", NULL);
 
 	ret = platform_driver_register(&arm_cmn_driver);
-	if (ret) {
-		cpuhp_remove_multi_state(arm_cmn_hp_state);
+	if (ret)
 		debugfs_remove(arm_cmn_debugfs);
-	}
+
 	return ret;
 }
 
 static void __exit arm_cmn_exit(void)
 {
 	platform_driver_unregister(&arm_cmn_driver);
-	cpuhp_remove_multi_state(arm_cmn_hp_state);
 	debugfs_remove(arm_cmn_debugfs);
 }
 
-- 
Haris Okanovic
AWS Graviton

