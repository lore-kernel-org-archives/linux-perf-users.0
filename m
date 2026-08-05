Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B181388377
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945315; cv=none; b=plLIGFKDvPmiDvp4W9x0OPa3QJaUvAI3UKnVYY0JwLDRW6dioUrnbWypuNSiaF9dU+iK2km7r8oeLIL456rdvtoVLszOG8ZU41BtTjTOZiK+EbkIciLAOiQn34dDhKR0O6xIa0kOXx9hlqzKTQlAKQG8c8DoDU0zW5r3Xy7Xl64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945315; c=relaxed/simple;
	bh=xqppkqDa4D5NSYqovy6DGgBakb+xo50YG5zXJdQu848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOihOHGw1uBlmEC4Ux1d3VlXQWDhAreI0vHTPnsDr+iLvu4AzTrvXsjVoHLBIBHku2M8oAYIko26hQLw/6wf1/YQPm3fVAHzvSxtURwD/ZZ0c3F6tZWs2uL9q/oelnIWmFR0nuLy1aR8TUoShSc6UIHgeb9VC8o7uvHxvT5BSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2745C1F00A3A;
	Wed,  5 Aug 2026 15:55:14 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: inux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 07/11] perf/cxl: Don't share the overflow interrupt, and keep it pinned
Date: Wed,  5 Aug 2026 08:54:57 -0700
Message-ID: <20260805155501.1294472-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805155501.1294472-1-dave.jiang@intel.com>
References: <20260805155501.1294472-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMU pins its overflow interrupt to info->on_cpu in the hotplug
callbacks, but requests it with only IRQF_SHARED | IRQF_NO_THREAD. Without
IRQF_NOBALANCING, irqbalance or a userspace smp_affinity write can move it
elsewhere, and cxl_pmu_irq() then runs local64_cmpxchg() and local64_add()
on hwc->prev_count and event->count at the same time as the managing CPU.
local64_t is only atomic against same-CPU access, so the counts corrupt.

The flag alone does not fix that while the line is shared. __setup_irq()
only acts on it for the first action on a line, and a co-owner has no
reason to want our affinity - it would keep taking the interrupt wherever
its own points, running our handler on the wrong CPU.

Drop IRQF_SHARED and add IRQF_NOBALANCING. The spec only recommends a
distinct Interrupt Message Number per CPMU instance (CXL r4.0 8.2.7.1.1),
so a device may put several on one vector, or share with the mailbox or
event log. Such a device now loses a PMU rather than silently miscounting -
and only the PMU, since the preceding patch adds the CPMUs after the event
configuration.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 481d32d0c1b0..448e1da3d59f 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -783,7 +783,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
 
 	overflowed = readq(base + CXL_PMU_OVERFLOW_REG);
 
-	/* Interrupt may be shared, so maybe it isn't ours */
+	/* Nothing overflowed, so the device did not raise this */
 	if (!overflowed)
 		return IRQ_NONE;
 
@@ -886,7 +886,14 @@ static int cxl_pmu_probe(struct device *dev)
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
2.54.0

