Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409145C71F;
	Fri, 31 Jul 2026 23:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540520; cv=none; b=heR18hUgVwro1AE76dflAcm5TToh/CcsfCoI2BKef6/3nwGDwaYnN8NBbsj6CwRBu4Zk6JgdmTgKqDx/qkvuqb15/4ivQzx6zSXcFjQNYfYVwRwseXY2Wdytt0dg90AP+sWhYJmR05W6C/TxRN6fokCyDhffnKViYO3dqmaefTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540520; c=relaxed/simple;
	bh=6NpCwBsgCjp2ykpqHTAtsAJUka4pEeJO3BbDfDyr9QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTFiVrXCvpA1B9Yyq6HKiX5QTe5tQlF3RfE4/qhmvJ2MdAHfVVGQ/5IuRHgoRms+WrJ4DKtWFme7PwyFqGxxNhVyYjmmHHcOlBs7kAFpohY0aVFiDDYVce6nzdW056fT07AU2oF+waLB5E0qADJid0YT59sWisWrD2Uwd4s61lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77FE1F00ACA;
	Fri, 31 Jul 2026 23:28:38 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	sashiko-bot@kernel.org
Subject: [PATCH v3 7/9] perf/cxl: Unfreeze counters after handling an overflow interrupt
Date: Fri, 31 Jul 2026 16:28:25 -0700
Message-ID: <20260731232827.401447-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731232827.401447-1-dave.jiang@intel.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The counters run with Freeze on Overflow set, so one overflow freezes every
counter in the block (CXL r4.0 8.2.7.2.1). cxl_pmu_irq() reads the
overflowed counters and clears the overflow status, but never unfreezes.
Everything stays frozen until the next pmu_enable(), and events in that
window are lost.

Unfreeze after clearing the status, unless the PMU has been disabled in the
meantime. cxl_pmu_disable() freezes the block deliberately, and
cxl_pmu_offline_cpu() migrates the context before it moves the interrupt's
affinity, so an overflow can still land on the old CPU while the new one
reprograms. Track the enabled state and leave the block frozen in that
case. pmu_enable() unfreezes anyway.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Don't unfreeze if the PMU has been disabled (Robin, Jonathan). Review tag
  dropped as the patch grew a hunk.
- Robin also asked whether this can release a counter that overflowed after
  the status read. It cannot. Global Freeze on Overflow stops every
  non-free-running counter and they stay frozen until software unfreezes
  them, so nothing the driver owns can advance, let alone newly overflow,
  between the readq and here. Two counters overflowing together both show
  up in the same pass. Only free-running counters move while frozen, and
  the driver never programs those.
- The enabled check is not a full exclusion, since the flag is read outside
  any lock. Say so in the comment rather than implying otherwise. A lock
  would buy nothing: pmu_disable() normally runs on the pinned CPU with
  interrupts off, and in the one window where it does not - the migration
  in cxl_pmu_offline_cpu() - event_stop() has already cleared Counter
  Enable, so a stray unfreeze resumes nothing (sashiko-bot).
---
 drivers/perf/cxl_pmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 6fdc66a01fb6..580a75bc9210 100644
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
@@ -803,6 +807,9 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 
 	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
 
+	if (READ_ONCE(info->enabled))
+		writeq(0, base + CXL_PMU_FREEZE_REG);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.55.0

