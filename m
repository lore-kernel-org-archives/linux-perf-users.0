Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA33634CFA7
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522089; cv=none; b=dMRy7KxzuEnxc2E9PzAccio2vMZ4L4SLvzM0CW6eqs2XMUXllQiqD4C5UV8LqXxNsffiO1b+CTww7ddlKvzX7B4fehbTioiDf+P654i6BIeVXUsn8HO/pkMO4N3x0VpU+/r7RA9kaFPb5vLBh1u+S+k9LGw8lG5SjvmLM1uoV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522089; c=relaxed/simple;
	bh=FJyXVo02Wg+wNJakUtDwld5rbmRLPnBML/uX1/k67x4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VB9WeEBbmATqzL3EbCldlGai/CiWnI1KgMfCSpo8m/xu/ilAB+K0Qzgdb+etRZpWFo4AQtWygsh7h1dn3kb4HU+yUh1DmgXgZXR08EXco6xwhhOIq5HasM+p57/Vk07Z7N44uoyP9VoEI56OdtkFx2386Q39ttV/WCH+Pn2sRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00D46339;
	Thu, 19 Feb 2026 09:27:54 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CC603F7D8;
	Thu, 19 Feb 2026 09:27:59 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com,
	James Morse <james.morse@arm.com>
Subject: [PATCH] perf/arm-cmn: Stop claiming entire iomem region
Date: Thu, 19 Feb 2026 17:27:53 +0000
Message-Id: <b6275655818f5af7e5fb07a9e18d1451b08b7e05.1771522073.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far, the PMU has been the only thing of interest in the vast mass
of CMN registers, so we've gotten away with simply claiming the entire
iomem region. However, now that we can support other features like MPAM
controllers for the system caches, the PMU driver needs to stop being
selfish and learn to share. Similarly to arm-ni, requesting just the
DTC node(s) should suffice for staking our exclusive claim to the PMU
features, as requesting hundreds of tiny regions for all the individual
pmu_event_sel registers is definitely not worth the considerable bother.

As a consequence, we can also streamline the annoying CMN-600 special
cases even more. The ACPI binding has in fact always specified a strict
order for all resources, so we can reasonably drop the ancient pretence
of swapping base and cfg, which IIRC was more just a moment of doubt on
my part than anything else.

Cc: James Morse <james.morse@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 70 +++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 364a4fd8f2c0..6a5eba0be347 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2132,6 +2132,8 @@ static void arm_cmn_init_dtm(struct arm_cmn_dtm *dtm, struct arm_cmn_node *xp, i
 static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int idx)
 {
 	struct arm_cmn_dtc *dtc = cmn->dtc + idx;
+	const struct resource *cfg;
+	resource_size_t base, size;
 
 	dtc->pmu_base = dn->pmu_base;
 	dtc->base = dtc->pmu_base - arm_cmn_pmu_offset(cmn, dn);
@@ -2139,6 +2141,13 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
 	if (dtc->irq < 0)
 		return dtc->irq;
 
+	cfg = platform_get_resource(to_platform_device(cmn->dev), IORESOURCE_MEM, 0);
+	base = dtc->base - cmn->base + cfg->start;
+	size = cmn->part == PART_CMN600 ? SZ_16K : SZ_64K;
+	if (!devm_request_mem_region(cmn->dev, base, size, dev_name(cmn->dev)))
+		return dev_err_probe(cmn->dev, -EBUSY,
+				     "Failed to request DTC region 0x%llx\n", base);
+
 	writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
 	writel_relaxed(CMN_DT_PMCR_PMU_EN | CMN_DT_PMCR_OVFL_INTR_EN, CMN_DT_PMCR(dtc));
 	writeq_relaxed(0, CMN_DT_PMCCNTR(dtc));
@@ -2525,43 +2534,26 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	return 0;
 }
 
-static int arm_cmn600_acpi_probe(struct platform_device *pdev, struct arm_cmn *cmn)
-{
-	struct resource *cfg, *root;
-
-	cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!cfg)
-		return -EINVAL;
-
-	root = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!root)
-		return -EINVAL;
-
-	if (!resource_contains(cfg, root))
-		swap(cfg, root);
-	/*
-	 * Note that devm_ioremap_resource() is dumb and won't let the platform
-	 * device claim cfg when the ACPI companion device has already claimed
-	 * root within it. But since they *are* already both claimed in the
-	 * appropriate name, we don't really need to do it again here anyway.
-	 */
-	cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
-	if (!cmn->base)
-		return -ENOMEM;
-
-	return root->start - cfg->start;
-}
-
-static int arm_cmn600_of_probe(struct device_node *np)
+static int arm_cmn_get_root(struct arm_cmn *cmn, const struct resource *cfg)
 {
+	const struct device_node *np = cmn->dev->of_node;
+	const struct resource *root;
 	u32 rootnode;
 
-	return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
+	if (cmn->part != PART_CMN600)
+		return 0;
+
+	if (np)
+		return of_property_read_u32(np, "arm,root-node", &rootnode) ?: rootnode;
+
+	root = platform_get_resource(to_platform_device(cmn->dev), IORESOURCE_MEM, 1);
+	return root ? root->start - cfg->start : -EINVAL;
 }
 
 static int arm_cmn_probe(struct platform_device *pdev)
 {
 	struct arm_cmn *cmn;
+	const struct resource *cfg;
 	const char *name;
 	static atomic_t id;
 	int err, rootnode, this_id;
@@ -2575,16 +2567,16 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	platform_set_drvdata(pdev, cmn);
 
-	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
-		rootnode = arm_cmn600_acpi_probe(pdev, cmn);
-	} else {
-		rootnode = 0;
-		cmn->base = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(cmn->base))
-			return PTR_ERR(cmn->base);
-		if (cmn->part == PART_CMN600)
-			rootnode = arm_cmn600_of_probe(pdev->dev.of_node);
-	}
+	cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!cfg)
+		return -EINVAL;
+
+	/* Map the whole region now, claim the DTCs once we've found them */
+	cmn->base = devm_ioremap(cmn->dev, cfg->start, resource_size(cfg));
+	if (IS_ERR(cmn->base))
+		return PTR_ERR(cmn->base);
+
+	rootnode = arm_cmn_get_root(cmn, cfg);
 	if (rootnode < 0)
 		return rootnode;
 
-- 
2.39.2.101.g768bb238c484.dirty

