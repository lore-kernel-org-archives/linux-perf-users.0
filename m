Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B318045D5F9;
	Fri, 31 Jul 2026 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540518; cv=none; b=hu6/ch5NL2GyD74j37RgkaKO8qJdtXct1St5jGlJ/OanyVGXFf9WuYum5LqUQ+wz6zeKTtnA3o7mfHGQ6mDVNYqcyxqTTag4NepQ5dF9GHEet5ti51+1fDrZ53yaUEYu51Oz+ENphlFkPYTRpx3TKJd/tltkLIkiw/dN9GXYtoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540518; c=relaxed/simple;
	bh=8qiH9z9im/dKVaPDtsICqEsLg66G/Er9EPiC3um45qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPfUvacL9EQoZ0aqr0gbZ/RQzBVed/aKD5giNP+ExHupjs9891iJ/XZMoMmio8sXSkThFO5ebAa/lUVgk8M5/B+zvOJqyMl3z4t8k5SKbJfyskkT64d3AhJEb2on7yeaQFa03oDjeUMLQFhPn2yitCJUxNlC+VwRO84bOoIOvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833CA1F00AC4;
	Fri, 31 Jul 2026 23:28:37 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	sashiko-bot@kernel.org
Subject: [PATCH v3 6/9] perf/cxl: Don't share the overflow interrupt, and keep it pinned
Date: Fri, 31 Jul 2026 16:28:24 -0700
Message-ID: <20260731232827.401447-7-dave.jiang@intel.com>
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

The PMU pins its overflow interrupt to info->on_cpu in the hotplug
callbacks, but requests it with only IRQF_SHARED | IRQF_NO_THREAD. Without
IRQF_NOBALANCING, irqbalance or a userspace smp_affinity write can move the
interrupt to another CPU. cxl_pmu_irq() then runs local64_cmpxchg() and
local64_add() on hwc->prev_count and event->count there, at the same time
as the managing CPU. local64_t is only atomic against same-CPU access, so
the counts get corrupted.

IRQF_NOBALANCING on its own does not fix that while the line is shared.
__setup_irq() only acts on the flag for the first action on a line, and a
co-owner has no reason to want our affinity. It would keep taking the
interrupt wherever its own affinity points, running our handler on the
wrong CPU.

Drop IRQF_SHARED and add IRQF_NOBALANCING. The spec only recommends that a
component give each CPMU instance a distinct Interrupt Message Number (CXL
r4.0 8.2.7.1.1), so a device may put several on one vector. Such a device
now fails to add the second CPMU instead of silently miscounting both.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Drop IRQF_SHARED as well, and retitle (Jonathan, Robin).
---
 drivers/perf/cxl_pmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index c9e30cb149df..6fdc66a01fb6 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -784,7 +784,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 
 	overflowed = readq(base + CXL_PMU_OVERFLOW_REG);
 
-	/* Interrupt may be shared, so maybe it isn't ours */
+	/* Nothing overflowed, so the device did not raise this */
 	if (!overflowed)
 		return IRQ_NONE;
 
@@ -887,7 +887,14 @@ static int cxl_pmu_probe(struct device *dev)
 	if (!irq_name)
 		return -ENOMEM;
 
-	rc = devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREAD,
+	/*
+	 * The handler must run on info->on_cpu, so the interrupt cannot be
+	 * shared - IRQF_NOBALANCING is only honoured for the first action on a
+	 * line, and a co-owner would keep taking the interrupt wherever its own
+	 * affinity points.
+	 */
+	rc = devm_request_irq(dev, irq, cxl_pmu_irq,
+			      IRQF_NO_THREAD | IRQF_NOBALANCING,
 			      irq_name, info);
 	if (rc)
 		return rc;
-- 
2.55.0

