Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B123A345EC6;
	Wed, 22 Jul 2026 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741071; cv=none; b=B1WVPGXGzlBlhV0MxLc0J0JH2XlM0E4J0waxBW2Z/PHI2w4amUTWI6LKJvlWrbk/c6lN9RPlrFcsuMH8TLXqrFBiE68xz9JIplt9JxP93PHARHRXcviwCMTmnDI+ws0h5WUWYOr2Cb+kn6KaXaRyrbIYSi8CXrHTts2BvUMRR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741071; c=relaxed/simple;
	bh=nNGk27kIAJtnHvBM8Fw1MAPELdpkezDlDBUbqc5x9zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c15HWGeku8ivkV9Cp5Zz8jZdTXkcKQz/Jk73ZycIhOF3xUwzlWCJf189atxQ526ZPJbQ6Aprvzy1dcxM41WCAVsWjDY9sOQZgpX61ckB67az/pocPXNbJDOpKC17m/Iv90vn5E+A2CvY3D7rkqREa+Cw84TDvsMXcw3WTNy+gjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=q/TD1fPS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="q/TD1fPS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E47E61692;
	Wed, 22 Jul 2026 10:24:24 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D9263F66F;
	Wed, 22 Jul 2026 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784741069; bh=nNGk27kIAJtnHvBM8Fw1MAPELdpkezDlDBUbqc5x9zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/TD1fPS8vmH7tlcPu/5SzzX55V04ocZ5LnNC54yfODivGs1jr6ZVBWXEZISeeD/l
	 TESSGTyVrAR2+4cfGgFzNKWsD+RtPlZ8/S4T2COFY5uTTy0XcV0Chf3UmMdXMBsHwp
	 HCPfkprAUotagGA+dZSyfy5SJV/S8xImnErGRHMs=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf/arm-cmn: Switch to generic cpumask
Date: Wed, 22 Jul 2026 18:24:18 +0100
Message-ID: <fff3eca9886d2626a8be95a22629d8650fd45177.1784653319.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1784653319.git.robin.murphy@arm.com>
References: <cover.1784653319.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With perf core now providing appropriately-sequenced hotplug callbacks
via the new PMU scope, all the state management boilerplate can go,
while the cpumask also takes care of enforcing event affinity.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 96 ++++++++++--------------------------------
 1 file changed, 23 insertions(+), 73 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 6e5cc4086a9e..10243ac6217d 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -358,17 +358,12 @@ struct arm_cmn {
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
@@ -1322,17 +1317,6 @@ static const struct attribute_group arm_cmn_format_attrs_group = {
 	.attrs = arm_cmn_format_attrs,
 };
 
-static ssize_t arm_cmn_cpumask_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
-
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cmn->cpu));
-}
-
-static struct device_attribute arm_cmn_cpumask_attr =
-		__ATTR(cpumask, 0444, arm_cmn_cpumask_show, NULL);
-
 static ssize_t arm_cmn_identifier_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
@@ -1345,7 +1329,6 @@ static struct device_attribute arm_cmn_identifier_attr =
 		__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
 
 static struct attribute *arm_cmn_other_attrs[] = {
-	&arm_cmn_cpumask_attr.attr,
 	&arm_cmn_identifier_attr.attr,
 	NULL,
 };
@@ -1779,10 +1762,6 @@ static int arm_cmn_event_init(struct perf_event *event)
 	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
 		return -EINVAL;
 
-	event->cpu = cmn->cpu;
-	if (event->cpu < 0)
-		return -EINVAL;
-
 	type = CMN_EVENT_TYPE(event);
 	/* DTC events (i.e. cycles) already have everything they need */
 	if (type == CMN_TYPE_DTC)
@@ -2008,48 +1987,38 @@ static int arm_cmn_commit_txn(struct pmu *pmu)
 	return 0;
 }
 
-static void arm_cmn_migrate(struct arm_cmn *cmn, unsigned int cpu)
+static bool arm_cmn_migrate(struct arm_cmn *cmn, unsigned int cpu)
 {
-	unsigned int i;
-
-	perf_pmu_migrate_context(&cmn->pmu, cmn->cpu, cpu);
-	for (i = 0; i < cmn->num_dtcs; i++)
-		irq_set_affinity(cmn->dtc[i].irq, cpumask_of(cpu));
-	cmn->cpu = cpu;
+	cmn->pmu.cpumask = cpumask_of(cpu);
+	for (int i = 0; i < cmn->num_dtcs; i++)
+		irq_set_affinity(cmn->dtc[i].irq, cmn->pmu.cpumask);
+	return true;
 }
 
-static int arm_cmn_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+static bool arm_cmn_init_cpu(struct pmu *pmu, int cpu)
 {
-	struct arm_cmn *cmn;
-	int node;
+	struct arm_cmn *cmn = to_cmn(pmu);
+	int node = dev_to_node(cmn->dev);
 
-	cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
-	node = dev_to_node(cmn->dev);
-	if (cpu_to_node(cmn->cpu) != node && cpu_to_node(cpu) == node)
-		arm_cmn_migrate(cmn, cpu);
-	return 0;
+	if (!cpumask_intersects(pmu->cpumask, cpumask_of_node(node)) &&
+	    (cpu_to_node(cpu) == node || cpumask_empty(pmu->cpumask)))
+		return arm_cmn_migrate(cmn, cpu);
+	return false;
 }
 
-static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+static bool arm_cmn_exit_cpu(struct pmu *pmu, int cpu)
 {
-	struct arm_cmn *cmn;
+	struct arm_cmn *cmn = to_cmn(pmu);
+	int node = dev_to_node(cmn->dev);
 	unsigned int target;
-	int node;
-
-	cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
-	if (cpu != cmn->cpu)
-		return 0;
-
-	node = dev_to_node(cmn->dev);
 
 	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		target = cpumask_any_but(cpu_online_mask, cpu);
 
 	if (target < nr_cpu_ids)
-		arm_cmn_migrate(cmn, target);
-
-	return 0;
+		return arm_cmn_migrate(cmn, target);
+	return false;
 }
 
 static irqreturn_t arm_cmn_handle_irq(int irq, void *dev_id)
@@ -2101,15 +2070,12 @@ static int arm_cmn_init_irqs(struct arm_cmn *cmn)
 				goto next;
 			}
 		}
+		/* Affinity will get set during PMU registration */
 		err = devm_request_irq(cmn->dev, irq, arm_cmn_handle_irq,
 				       IRQF_NOBALANCING | IRQF_NO_THREAD,
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
@@ -2565,7 +2531,6 @@ static int arm_cmn_probe(struct platform_device *pdev)
 
 	cmn->dev = &pdev->dev;
 	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
-	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	platform_set_drvdata(pdev, cmn);
 
 	cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -2610,6 +2575,9 @@ static int arm_cmn_probe(struct platform_device *pdev)
 		.start_txn = arm_cmn_start_txn,
 		.commit_txn = arm_cmn_commit_txn,
 		.cancel_txn = arm_cmn_end_txn,
+		.scope = PERF_PMU_SCOPE_CPUMASK,
+		.init_cpu = arm_cmn_init_cpu,
+		.exit_cpu = arm_cmn_exit_cpu,
 	};
 
 	this_id = atomic_fetch_inc(&id);
@@ -2617,14 +2585,8 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	if (!name)
 		return -ENOMEM;
 
-	err = cpuhp_state_add_instance(arm_cmn_hp_state, &cmn->cpuhp_node);
-	if (err)
-		return err;
-
 	err = perf_pmu_register(&cmn->pmu, name, -1);
-	if (err)
-		cpuhp_state_remove_instance_nocalls(arm_cmn_hp_state, &cmn->cpuhp_node);
-	else
+	if (!err)
 		arm_cmn_debugfs_init(cmn, this_id);
 
 	return err;
@@ -2637,7 +2599,6 @@ static void arm_cmn_remove(struct platform_device *pdev)
 	writel_relaxed(0, cmn->dtc[0].base + CMN_DT_DTC_CTL);
 
 	perf_pmu_unregister(&cmn->pmu);
-	cpuhp_state_remove_instance_nocalls(arm_cmn_hp_state, &cmn->cpuhp_node);
 	debugfs_remove(cmn->debug);
 }
 
@@ -2679,28 +2640,17 @@ static int __init arm_cmn_init(void)
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
 	return ret;
 }
 
 static void __exit arm_cmn_exit(void)
 {
 	platform_driver_unregister(&arm_cmn_driver);
-	cpuhp_remove_multi_state(arm_cmn_hp_state);
 	debugfs_remove(arm_cmn_debugfs);
 }
 
-- 
2.54.0.dirty

