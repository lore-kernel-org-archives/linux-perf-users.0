Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50EA2D63E5;
	Wed, 29 Jul 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336962; cv=none; b=hU+0MvEZ+zVFTKmfPmmZmpT5V1421WSLQ6G/iBzKr+zGRNIibxjpsDQecUXJBBbc83mcsBk95Qt2r0e0IVei6RVRLjZ3UPI/ofEalsYyTOckRg0vjoA2JDmCW2ruUdxRCQCqsO+I8IIV4pdq8wrVlaF+bPChmccBsSD5qF8L+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336962; c=relaxed/simple;
	bh=EvtJ8IANxm+2z3OWTx27rF5aD44B2rqSAcBoNY1ZTvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpEifAoOMlPpygJeVHviLIjjT7MJVqKraN8pM+x1Y5wdXj4duppx6piO7GqkXMn+65wBDfhLhM5jGMi97FQuMqqsRoi/MH7NcZNv3+e4m9mZFGeVnB34HqpwDlAwugpCiN0Iep0DPR8pHqzXKP/l8TaM1yJzK2iDUGbzUH7mUnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAFB1F00A3A;
	Wed, 29 Jul 2026 14:56:00 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH v2 2/9] perf/cxl: Clear stale event fields before reprogramming a counter
Date: Wed, 29 Jul 2026 07:55:48 -0700
Message-ID: <20260729145555.3919550-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729145555.3919550-1-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_pmu_event_start() ORs the event group id, event mask, edge and invert
selections into a configurable counter's config register without clearing
those fields first, and cxl_pmu_event_stop() leaves them set. Reusing a
counter for another event therefore ORs the new selection onto the old,
counting the wrong events with stale edge/invert behaviour.

Clear EVENT_GRP_ID_IDX, EVENTS, EDGE and INVERT before applying the new
values.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index e77c0650a7eb..3138514157cd 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -641,6 +641,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 	}
 
 	cfg = readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
+	cfg &= ~(CXL_PMU_COUNTER_CFG_EDGE | CXL_PMU_COUNTER_CFG_INVERT);
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_ENABLE, 1);
@@ -651,6 +652,8 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 
 	/* Fixed purpose counters have next two fields RO */
 	if (test_bit(hwc->idx, info->conf_counter_bm)) {
+		cfg &= ~(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK |
+			 CXL_PMU_COUNTER_CFG_EVENTS_MSK);
 		cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
 				  hwc->event_base);
 		cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,
-- 
2.55.0

