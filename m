Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421071CA81
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150752; cv=none; b=FIFkWVgnKuay8ew6YsK/H+jDs9ZQfEL6q7QwKiOhVFHg4GOoaxHMk9Nc5+44jJ5ri1OzwWuHxiOiVyafwGbMmM15JdwFvrKfSPOFnMOhxuEwgc5VpuUggUdWGXSmH22FgJUwuCRUKXn7uHhqspdHVCw2qp9atrkQJvYIfAVKo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150752; c=relaxed/simple;
	bh=btpzknTs7aXySjZ4MGsJVR27qW/aTG1UBDjjRqYczqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oU94X+Ng/97d8ZU3cVbv53OHZb0Cpz3LjlXXvNa39QEBaTtDzbUAl5IbewMrirVEvp3VfY6Gi9vfzXaRyjhSdJTNo+Xw3CuP0b9LHOY86MgaillbCkQy5lmtX3A9L+IqDWm3LlCDdl0vTaxKbYGq93x6s97kDyl1KVycUb1SSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72887150C;
	Tue, 13 May 2025 08:38:59 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 546A13F63F;
	Tue, 13 May 2025 08:39:09 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	allen.wang@hj-micro.com,
	peter.du@hj-micro.com,
	andy.xu@hj-micro.com
Subject: [PATCH 2/3] perf/arm-ni: Consolidate CPU affinity handling
Date: Tue, 13 May 2025 16:38:59 +0100
Message-Id: <5b4ff1b8e41ddbc7fd2548f5da33d9788cf181fd.1747149165.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1747149165.git.robin.murphy@arm.com>
References: <cover.1747149165.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since overflow interrupts from the individual PMUs are infrequent and
unlikely to coincide, and we make no attempt to balance them across
CPUs anyway, there's really not much point tracking a separate CPU
affinity per PMU. Move the CPU affinity and hotplug migration up to
the NI instance level.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-ni.c | 74 ++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index 9396d243415f..168750e78fc4 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -104,8 +104,6 @@ struct arm_ni_cd {
 	u16 id;
 	int num_units;
 	int irq;
-	int cpu;
-	struct hlist_node cpuhp_node;
 	struct pmu pmu;
 	struct arm_ni_unit *units;
 	struct perf_event *evcnt[NI_NUM_COUNTERS];
@@ -117,13 +115,18 @@ struct arm_ni {
 	void __iomem *base;
 	enum ni_part part;
 	int id;
+	int cpu;
 	int num_cds;
+	struct hlist_node cpuhp_node;
 	struct arm_ni_cd cds[] __counted_by(num_cds);
 };
 
 #define cd_to_ni(cd) container_of((cd), struct arm_ni, cds[(cd)->id])
 #define pmu_to_cd(p) container_of((p), struct arm_ni_cd, pmu)
 
+#define ni_for_each_cd(n, c) \
+	for (struct arm_ni_cd *c = n->cds; c < n->cds + n->num_cds; c++) if (c->pmu_base)
+
 #define cd_for_each_unit(cd, u) \
 	for (struct arm_ni_unit *u = cd->units; u < cd->units + cd->num_units; u++)
 
@@ -218,9 +221,9 @@ static const struct attribute_group arm_ni_format_attrs_group = {
 static ssize_t arm_ni_cpumask_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct arm_ni_cd *cd = pmu_to_cd(dev_get_drvdata(dev));
+	struct arm_ni *ni = cd_to_ni(pmu_to_cd(dev_get_drvdata(dev)));
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cd->cpu));
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(ni->cpu));
 }
 
 static struct device_attribute arm_ni_cpumask_attr =
@@ -314,7 +317,7 @@ static int arm_ni_event_init(struct perf_event *event)
 	if (is_sampling_event(event))
 		return -EINVAL;
 
-	event->cpu = cd->cpu;
+	event->cpu = cd_to_ni(cd)->cpu;
 	if (NI_EVENT_TYPE(event) == NI_PMU)
 		return arm_ni_validate_group(event);
 
@@ -543,8 +546,7 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 	if (err)
 		return err;
 
-	cd->cpu = cpumask_local_spread(0, dev_to_node(ni->dev));
-	irq_set_affinity(cd->irq, cpumask_of(cd->cpu));
+	irq_set_affinity(cd->irq, cpumask_of(ni->cpu));
 
 	cd->pmu = (struct pmu) {
 		.module = THIS_MODULE,
@@ -566,32 +568,19 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 	if (!name)
 		return -ENOMEM;
 
-	err = cpuhp_state_add_instance_nocalls(arm_ni_hp_state, &cd->cpuhp_node);
-	if (err)
-		return err;
-
-	err = perf_pmu_register(&cd->pmu, name, -1);
-	if (err)
-		cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &cd->cpuhp_node);
-
-	return err;
+	return perf_pmu_register(&cd->pmu, name, -1);
 }
 
 static void arm_ni_remove(struct platform_device *pdev)
 {
 	struct arm_ni *ni = platform_get_drvdata(pdev);
 
-	for (int i = 0; i < ni->num_cds; i++) {
-		struct arm_ni_cd *cd = ni->cds + i;
-
-		if (!cd->pmu_base)
-			continue;
-
+	ni_for_each_cd(ni, cd) {
 		writel_relaxed(0, cd->pmu_base + NI_PMCR);
 		writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENCLR);
 		perf_pmu_unregister(&cd->pmu);
-		cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &cd->cpuhp_node);
 	}
+	cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &ni->cpuhp_node);
 }
 
 static void arm_ni_probe_domain(void __iomem *base, struct arm_ni_node *node)
@@ -611,7 +600,7 @@ static int arm_ni_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 	static atomic_t id;
-	int num_cds;
+	int ret, num_cds;
 	u32 reg, part;
 
 	/*
@@ -662,8 +651,13 @@ static int arm_ni_probe(struct platform_device *pdev)
 	ni->num_cds = num_cds;
 	ni->part = part;
 	ni->id = atomic_fetch_inc(&id);
+	ni->cpu = cpumask_local_spread(0, dev_to_node(ni->dev));
 	platform_set_drvdata(pdev, ni);
 
+	ret = cpuhp_state_add_instance_nocalls(arm_ni_hp_state, &ni->cpuhp_node);
+	if (ret)
+		return ret;
+
 	for (int v = 0; v < cfg.num_components; v++) {
 		reg = readl_relaxed(cfg.base + NI_CHILD_PTR(v));
 		arm_ni_probe_domain(base + reg, &vd);
@@ -671,8 +665,6 @@ static int arm_ni_probe(struct platform_device *pdev)
 			reg = readl_relaxed(vd.base + NI_CHILD_PTR(p));
 			arm_ni_probe_domain(base + reg, &pd);
 			for (int c = 0; c < pd.num_components; c++) {
-				int ret;
-
 				reg = readl_relaxed(pd.base + NI_CHILD_PTR(c));
 				arm_ni_probe_domain(base + reg, &cd);
 				ret = arm_ni_init_cd(ni, &cd, res->start);
@@ -714,42 +706,44 @@ static struct platform_driver arm_ni_driver = {
 	.remove = arm_ni_remove,
 };
 
-static void arm_ni_pmu_migrate(struct arm_ni_cd *cd, unsigned int cpu)
+static void arm_ni_pmu_migrate(struct arm_ni *ni, unsigned int cpu)
 {
-	perf_pmu_migrate_context(&cd->pmu, cd->cpu, cpu);
-	irq_set_affinity(cd->irq, cpumask_of(cpu));
-	cd->cpu = cpu;
+	ni_for_each_cd(ni, cd) {
+		perf_pmu_migrate_context(&cd->pmu, ni->cpu, cpu);
+		irq_set_affinity(cd->irq, cpumask_of(cpu));
+	}
+	ni->cpu = cpu;
 }
 
 static int arm_ni_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
 {
-	struct arm_ni_cd *cd;
+	struct arm_ni *ni;
 	int node;
 
-	cd = hlist_entry_safe(cpuhp_node, struct arm_ni_cd, cpuhp_node);
-	node = dev_to_node(cd_to_ni(cd)->dev);
-	if (cpu_to_node(cd->cpu) != node && cpu_to_node(cpu) == node)
-		arm_ni_pmu_migrate(cd, cpu);
+	ni = hlist_entry_safe(cpuhp_node, struct arm_ni, cpuhp_node);
+	node = dev_to_node(ni->dev);
+	if (cpu_to_node(ni->cpu) != node && cpu_to_node(cpu) == node)
+		arm_ni_pmu_migrate(ni, cpu);
 	return 0;
 }
 
 static int arm_ni_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
 {
-	struct arm_ni_cd *cd;
+	struct arm_ni *ni;
 	unsigned int target;
 	int node;
 
-	cd = hlist_entry_safe(cpuhp_node, struct arm_ni_cd, cpuhp_node);
-	if (cpu != cd->cpu)
+	ni = hlist_entry_safe(cpuhp_node, struct arm_ni, cpuhp_node);
+	if (cpu != ni->cpu)
 		return 0;
 
-	node = dev_to_node(cd_to_ni(cd)->dev);
+	node = dev_to_node(ni->dev);
 	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
 	if (target >= nr_cpu_ids)
 		target = cpumask_any_but(cpu_online_mask, cpu);
 
 	if (target < nr_cpu_ids)
-		arm_ni_pmu_migrate(cd, target);
+		arm_ni_pmu_migrate(ni, target);
 	return 0;
 }
 
-- 
2.39.2.101.g768bb238c484.dirty

