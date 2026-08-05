Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922A388377
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945321; cv=none; b=dafFLDvyMJ84VZij7VN3bdo63CcjUWdU7wORF9b642ntE2Uo+ihtQM1ZZSW3Mo6IWR8v7zYmAAmquO2Dk0vlIOcgXC06BxOTVEzVv0Uov3ODAMqbTBUSCwL1lJHxvl+YeXSqMj1E6zxRsX5zFVv6nLLvidTQgZBCeRLIyhHUZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945321; c=relaxed/simple;
	bh=BYXags1N1egN3tHQQTDBLCpJZPeHytULIcgNhyUmV3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qvyte756BgvMSeYDE7UzTHY78BtILwq5JYPUnKA93G4W9oV1DS6jlrpVFCyUqQiVhO7dB0uLtTsQEPV8EUqraVMn7MEAW3qveyZiKIgYGo0c0DKlWrE6z7NzGYz8L1SlYfrVbwDD22/aXpIjuAYI/C5vERlqiLXPHEOTz7kcRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB23B1F00A3A;
	Wed,  5 Aug 2026 15:55:19 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: inux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com
Subject: [PATCH v4 11/11] perf/cxl: Clear stale overflow status before using a counter
Date: Wed,  5 Aug 2026 08:55:01 -0700
Message-ID: <20260805155501.1294472-12-dave.jiang@intel.com>
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

cxl_pmu_event_stop() leaves the counter's bit set in the overflow status
register and only cxl_pmu_irq() ever clears it, so a counter handed from
one event to the next starts with the previous owner's overflow pending.
The perf core stops and starts back to back with interrupts off, so an
interrupt latched over the handover lands on the new event. prev_count is 0
by then, so the read path adds a full period: 2^counter_width phantom
counts.

Clear the bit in cxl_pmu_event_start(), before the config write arms
Interrupt on Overflow. Clear the whole register at probe too, for counters
no event ever owns - the driver never touched it, so firmware or a previous
kernel can leave a bit set there.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: Richard Cheng <icheng@nvidia.com>
Closes: https://lore.kernel.org/linux-cxl/anAVpO--i5heVfz9@MWDK4CY14F/
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- New patch. The event_start() clear is Richard's; the probe clear was a
  second hunk on the pmu.dev patch in v3.
- Clear before the config write rather than after it, so the question of
  whether arming the interrupt over a set status bit can raise an MSI does
  not arise (sashiko-bot).
---
 drivers/perf/cxl_pmu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 45edef53a983..3ec8933b04e2 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -683,6 +683,15 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 	 */
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_THRESHOLD_MSK,
 			  cxl_pmu_config1_get_threshold(event));
+
+	/*
+	 * Drop any overflow the previous owner of this counter left pending;
+	 * cxl_pmu_event_stop() does not. Otherwise an interrupt latched over
+	 * the handover gets charged to this event. Do it before arming Interrupt
+	 * on Overflow below, and note RW1C leaves the other counters alone.
+	 */
+	writeq(BIT_ULL(hwc->idx), base + CXL_PMU_OVERFLOW_REG);
+
 	writeq(cfg, base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
 
 	local64_set(&hwc->prev_count, 0);
@@ -914,6 +923,14 @@ static int cxl_pmu_probe(struct device *dev)
 	if (!irq_name)
 		return -ENOMEM;
 
+	/*
+	 * Same for counters no event owns yet: clear whatever firmware or a
+	 * previous kernel left set before the handler goes live. Bits above the
+	 * implemented counters are reserved, so only write those.
+	 */
+	writeq(GENMASK_ULL(info->num_counters - 1, 0),
+	       info->base + CXL_PMU_OVERFLOW_REG);
+
 	/*
 	 * The handler must run on info->on_cpu, so the interrupt cannot be
 	 * shared - IRQF_NOBALANCING is only honoured for the first action on a
-- 
2.54.0

