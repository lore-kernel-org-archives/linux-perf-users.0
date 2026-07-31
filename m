Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69745DF4B;
	Fri, 31 Jul 2026 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540523; cv=none; b=YaBzhuRBRPDVsNT+QT0ddjo041g886mxenn2Vcp+iBsPnJ0s2H/jsFEBmCuNxyN2FteMD85uGy87aGW3CpKsD+LcXu6JjZqmledMcOWPcm+RBMo90nU3E/eFrOKx7TbB0lnNicxyyZobvH875ura7U11ykFuZkhOuz5OW3cBFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540523; c=relaxed/simple;
	bh=Si+2IbyZr5DwcAODuS4rS50l5gS6BgXYead8EhBYFiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZWX1zSmnQvg21npaFq/LBUBnv7ydLv+WtnnxZFadjr9TLhrZ5a3rmwbMdBnjbk7hGRIwyH8+YXTUI/OFx6bAcyBkSMaK/sGgu5vND3fLD3vxgQgDbB+oNGMpBo+fyv9SK8mbBznPOCAxG5vMC8G/GEuBM3XRKrEtXB5HigOTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8048B1F00ACF;
	Fri, 31 Jul 2026 23:28:41 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	sashiko-bot@kernel.org
Subject: [PATCH v3 9/9] perf/cxl: Don't log through pmu.dev in the overflow interrupt handler
Date: Fri, 31 Jul 2026 16:28:27 -0700
Message-ID: <20260731232827.401447-10-dave.jiang@intel.com>
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

perf_pmu_unregister() frees pmu->dev without clearing the pointer, and
cxl_pmu_probe() registers its devm actions so that teardown runs
perf_pmu_unregister() first, then the hotplug instance removal, then
free_irq(). Nothing before free_irq() masks the interrupt, so the handler
stays live across a window where info->pmu.dev is freed and its dev_dbg()
walks that pointer.

Unsharing the interrupt does not close that window. cxl_pmu_event_stop()
leaves the counter's overflow status bit set, and only the handler clears
it, so an overflow taken just before teardown is still delivered and still
gets past the "did anything overflow" early-out. It lands in the !event
branch, where the dev_dbg() is.

Log through info->pmu.parent instead, which is devm-managed and outlives
every teardown action.

Clear the overflow status before requesting the interrupt too, since the
driver never touched it at probe and a counter left enabled with
INT_ON_OVRFLW by firmware or a previous kernel can raise an interrupt at
any point.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Clear CXL_PMU_OVERFLOW_REG at probe, before the handler is armed. A stale
  status bit from firmware can cause overflow interrupt. (Robin)
- Ack dropped as the patch grew a hunk.
- Drop the cxl_pmu_offline_cpu() hunk. That dev_err() cannot be reached.
---
 drivers/perf/cxl_pmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 37742ce43d9f..3683427fbb7e 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -806,7 +806,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 		struct perf_event *event = info->hw_events[i];
 
 		if (!event) {
-			dev_dbg(info->pmu.dev,
+			dev_dbg(info->pmu.parent,
 				"overflow but on non enabled counter %d\n", i);
 			continue;
 		}
@@ -903,6 +903,15 @@ static int cxl_pmu_probe(struct device *dev)
 	if (!irq_name)
 		return -ENOMEM;
 
+	/*
+	 * Clear any overflow status left set by firmware or a previous kernel
+	 * before the handler goes live, so it cannot mistake a stale bit for an
+	 * overflow on a counter no event owns yet. The register is RW1C, and
+	 * bits above the implemented counters are RsvdZ, so only write those.
+	 */
+	writeq(GENMASK_ULL(info->num_counters - 1, 0),
+	       info->base + CXL_PMU_OVERFLOW_REG);
+
 	/*
 	 * The handler must run on info->on_cpu, so the interrupt cannot be
 	 * shared - IRQF_NOBALANCING is only honoured for the first action on a
-- 
2.55.0

