Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC748167D;
	Wed,  5 Aug 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945576; cv=none; b=p5d0IQ0rpT3R4QMvRy9XFnVn3PJrNkeKM89MMjoSWNSQZ/Jx2NzW/TR5l5ctaDX2G64UYgnc8tcy3AZp+zPk0MLs56uIZ0VZNisMdZuxURLx9mIts8uNM/0HfsWXIhN0rYpv8rjN8613DQ/Mb5+tocbMzhSlvRVxjVBXGFR7aHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945576; c=relaxed/simple;
	bh=T8WfvzXUzauzJmhoGA6zbeU/y0neBFbWMSs6gOSbfUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCHoW47CB77eCUg95WiNnTGclvGbyabG2a8i5pjSl4IM3/PBJA8PQ5c6FegkRsE4fiN6izO/rSKEaWnqnfGEsx1BJIQUwcBl6m88pF8Fy2ItWEZ/joYEHhj+jq5Pon3J3bDWFTVU1K4IxerepgIYSfxPBknOuYc3fqYsIOCIXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18201F00A3A;
	Wed,  5 Aug 2026 15:59:24 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [RESEND PATCH v4 08/11] perf/cxl: Unfreeze counters after handling an overflow interrupt
Date: Wed,  5 Aug 2026 08:59:08 -0700
Message-ID: <20260805155911.1304807-9-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805155911.1304807-1-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The counters run with Freeze on Overflow set, so one overflow freezes every
counter in the block (CXL r4.0 8.2.7.2.1), and a frozen counter "remains
frozen until explicitly unfrozen by software" (8.2.7.1.3, Table 8-183).
cxl_pmu_irq() reads the overflowed counters and clears the overflow status
but never unfreezes, so everything stays frozen until the next pmu_enable()
and events in that window are lost.

Unfreeze after clearing the status, unless the PMU has been disabled in the
meantime - cxl_pmu_disable() freezes the block deliberately. Track the
enabled state and leave it frozen in that case.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 448e1da3d59f..a081fcba6991 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -108,6 +108,8 @@ struct cxl_pmu_info {
 	bool filter_hdm;
 	int msi_vec;
 	int irq;
+	/* Set between pmu_enable() and pmu_disable(), read by the IRQ handler */
+	bool enabled;
 };
 
 #define pmu_to_cxl_pmu_info(_pmu) container_of(_pmu, struct cxl_pmu_info, pmu)
@@ -596,6 +598,7 @@ static void cxl_pmu_enable(struct pmu *pmu)
 	void __iomem *base = info->base;
 
 	/* Can assume frozen at this stage */
+	WRITE_ONCE(info->enabled, true);
 	writeq(0, base + CXL_PMU_FREEZE_REG);
 }
 
@@ -604,6 +607,7 @@ static void cxl_pmu_disable(struct pmu *pmu)
 	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(pmu);
 	void __iomem *base = info->base;
 
+	WRITE_ONCE(info->enabled, false);
 	/*
 	 * Whilst bits above number of counters are RsvdZ
 	 * they are unlikely to be repurposed given
@@ -802,6 +806,21 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 
 	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
 
+	/*
+	 * An overflow freezes every counter in the CPMU, so unfreeze once the
+	 * overflowed ones have been read and their status cleared. Otherwise
+	 * they stay frozen until the next pmu_enable() and events are lost.
+	 *
+	 * Not while the PMU is disabled, so as not to undo an intentional freeze.
+	 * The check is advisory, not exclusive: pmu_disable() normally runs on
+	 * info->on_cpu with interrupts off, where the pinned handler cannot
+	 * preempt it. In the one window where it does not - the migration in
+	 * cxl_pmu_offline_cpu() - the counters are legitimately running again,
+	 * so unfreezing is correct there anyway.
+	 */
+	if (READ_ONCE(info->enabled))
+		writeq(0, base + CXL_PMU_FREEZE_REG);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.54.0

