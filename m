Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B12F2C4F
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Jul 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257737; cv=none; b=CuLNlWyUTOWfsQoAGzxdvf5MaNkr+lG0m3fJFaBaUeWjp4R20diQQxDQvPIG9As2RuQo8OVgk9vY6BWIwJwE1JxCP0K4sQlunGqq7iZGchhiFzETzE98KhSKfuTHI55a90EdfmyZYSKBbHdSTI2p9Vr+my+EL8GF1lz/4bZOSwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257737; c=relaxed/simple;
	bh=luBqKNXkwRCK4krkDNwnpeRHztWoBQondwfZdg6frLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esmAUvmj5QE5iQ7nYu9kEY6nFwhO06K3QztYRUHj9Ph/tdcADyjc9c2nGZsy3MQ5fnJ8NDzvL+GsDOPBCqDrCWxeoVpgJlUpkVXedltscUGRkdVuXAGwH05qTH6HyIevQh9yLljgJiXiSR8l26/1QAUIRPxPo8hpKQpOTyjzBlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C2BB16F8;
	Fri, 11 Jul 2025 11:15:24 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C07BD3F6A8;
	Fri, 11 Jul 2025 11:15:33 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	allen.wang@hj-micro.com,
	peter.du@hj-micro.com,
	andy.xu@hj-micro.com
Subject: [PATCH v2 2/2] perf/arm-ni: Support sharing IRQs within an NI instance
Date: Fri, 11 Jul 2025 19:15:17 +0100
Message-Id: <f62db639d3b54c959ec477db7b8ccecbef1ca310.1752256072.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1752256072.git.robin.murphy@arm.com>
References: <cover.1752256072.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shouping Wang <allen.wang@hj-micro.com>

NI-700 has a distinct PMU interrupt output for each Clock Domain,
however some integrations may still combine these together externally.
The initial driver didn't attempt to support this, in anticipation of a
more general solution for IRQ sharing between system PMU instances, but
that's still a way off, so let's make this intermediate step for now to
at least allow sharing IRQs within an individual NI instance.

Now that CPU affinity and migration are cleaned up, it's fairly
straightforward to adopt similar logic to arm-cmn, to identify CDs with
a common interrupt and loop over them directly in the handler.

Signed-off-by: Shouping Wang <allen.wang@hj-micro.com>
[ rm: Rework for affinity handling, cosmetics, new commit message ]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Delay enabling IRQs for the sake of reasoning

 drivers/perf/arm-ni.c | 82 +++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 27 deletions(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index 168750e78fc4..3c505352e302 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -102,6 +102,7 @@ struct arm_ni_unit {
 struct arm_ni_cd {
 	void __iomem *pmu_base;
 	u16 id;
+	s8 irq_friend;
 	int num_units;
 	int irq;
 	struct pmu pmu;
@@ -448,33 +449,37 @@ static irqreturn_t arm_ni_handle_irq(int irq, void *dev_id)
 {
 	struct arm_ni_cd *cd = dev_id;
 	irqreturn_t ret = IRQ_NONE;
-	u32 reg = readl_relaxed(cd->pmu_base + NI_PMOVSCLR);
 
-	if (reg & (1U << NI_CCNT_IDX)) {
-		ret = IRQ_HANDLED;
-		if (!(WARN_ON(!cd->ccnt))) {
-			arm_ni_event_read(cd->ccnt);
-			arm_ni_init_ccnt(cd);
+	for (;;) {
+		u32 reg = readl_relaxed(cd->pmu_base + NI_PMOVSCLR);
+
+		if (reg & (1U << NI_CCNT_IDX)) {
+			ret = IRQ_HANDLED;
+			if (!(WARN_ON(!cd->ccnt))) {
+				arm_ni_event_read(cd->ccnt);
+				arm_ni_init_ccnt(cd);
+			}
 		}
-	}
-	for (int i = 0; i < NI_NUM_COUNTERS; i++) {
-		if (!(reg & (1U << i)))
-			continue;
-		ret = IRQ_HANDLED;
-		if (!(WARN_ON(!cd->evcnt[i]))) {
-			arm_ni_event_read(cd->evcnt[i]);
-			arm_ni_init_evcnt(cd, i);
+		for (int i = 0; i < NI_NUM_COUNTERS; i++) {
+			if (!(reg & (1U << i)))
+				continue;
+			ret = IRQ_HANDLED;
+			if (!(WARN_ON(!cd->evcnt[i]))) {
+				arm_ni_event_read(cd->evcnt[i]);
+				arm_ni_init_evcnt(cd, i);
+			}
 		}
+		writel_relaxed(reg, cd->pmu_base + NI_PMOVSCLR);
+		if (!cd->irq_friend)
+			return ret;
+		cd += cd->irq_friend;
 	}
-	writel_relaxed(reg, cd->pmu_base + NI_PMOVSCLR);
-	return ret;
 }
 
 static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_start)
 {
 	struct arm_ni_cd *cd = ni->cds + node->id;
 	const char *name;
-	int err;
 
 	cd->id = node->id;
 	cd->num_units = node->num_components;
@@ -534,20 +539,11 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 		       cd->pmu_base + NI_PMCR);
 	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMCNTENCLR);
 	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMOVSCLR);
-	writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENSET);
 
 	cd->irq = platform_get_irq(to_platform_device(ni->dev), cd->id);
 	if (cd->irq < 0)
 		return cd->irq;
 
-	err = devm_request_irq(ni->dev, cd->irq, arm_ni_handle_irq,
-			       IRQF_NOBALANCING | IRQF_NO_THREAD,
-			       dev_name(ni->dev), cd);
-	if (err)
-		return err;
-
-	irq_set_affinity(cd->irq, cpumask_of(ni->cpu));
-
 	cd->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.parent = ni->dev,
@@ -593,6 +589,34 @@ static void arm_ni_probe_domain(void __iomem *base, struct arm_ni_node *node)
 	node->num_components = readl_relaxed(base + NI_CHILD_NODE_INFO);
 }
 
+static int arm_ni_init_irqs(struct arm_ni *ni)
+{
+	int err;
+
+	ni_for_each_cd(ni, cd) {
+		for (struct arm_ni_cd *prev = cd; prev-- > ni->cds; ) {
+			if (prev->irq == cd->irq) {
+				prev->irq_friend = cd - prev;
+				goto set_inten;
+			}
+		}
+		err = devm_request_irq(ni->dev, cd->irq, arm_ni_handle_irq,
+				       IRQF_NOBALANCING | IRQF_NO_THREAD | IRQF_NO_AUTOEN,
+				       dev_name(ni->dev), cd);
+		if (err)
+			return err;
+
+		irq_set_affinity(cd->irq, cpumask_of(ni->cpu));
+set_inten:
+		writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENSET);
+	}
+	/* Look Ma, no absurdly theoretical race conditions! */
+	ni_for_each_cd(ni, cd)
+		if (!cd->irq_friend)
+			enable_irq(cd->irq);
+	return 0;
+}
+
 static int arm_ni_probe(struct platform_device *pdev)
 {
 	struct arm_ni_node cfg, vd, pd, cd;
@@ -677,7 +701,11 @@ static int arm_ni_probe(struct platform_device *pdev)
 		}
 	}
 
-	return 0;
+	ret = arm_ni_init_irqs(ni);
+	if (ret)
+		arm_ni_remove(pdev);
+
+	return ret;
 }
 
 #ifdef CONFIG_OF
-- 
2.39.2.101.g768bb238c484.dirty

