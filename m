Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439F45D5F9;
	Fri, 31 Jul 2026 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540513; cv=none; b=B7nGlSDiZa3ZNOL/FqVG4dMRcbrzPLygzLE6thIXJoueYBw6v3x5NOim/xpkD8d45ER6EpAyqa1D+twnUYmtQM1V+Xx5HxFtdxoLR4b4GU4AwyS2rUjhdXS94CaMoqB+a2/jISp0DAhcgtBeQMYDDVQ+jG41WXb9n3hF338Orp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540513; c=relaxed/simple;
	bh=gh6RzpIHxkzvv5NtL0QlbpMQh/gO74NjKit2+4za1OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MuMbqSxL49dTvS7AAFO44RMeHwa2+KF5c9ZuVZ66rEbI4CoU4eN8DgZBsVxpu9qdFBNbatQyLjx+UW/th05g2wFzbRx2q8k4OHEUOTJ5iDTBL1l5qWYxaM7m4SC5XyOqa+eXxOgROWo9/jwjRFigkNr93aWZGR0AWShSWWTrWOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123681F00AC4;
	Fri, 31 Jul 2026 23:28:31 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	sashiko-bot@kernel.org
Subject: [PATCH v3 2/9] perf/cxl: Clear stale event fields before reprogramming a counter
Date: Fri, 31 Jul 2026 16:28:20 -0700
Message-ID: <20260731232827.401447-3-dave.jiang@intel.com>
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

cxl_pmu_event_start() ORs the event group id, event mask, edge and invert
selections into a configurable counter's config register without clearing
them first, and cxl_pmu_event_stop() leaves them set. Reuse the counter for
another event and the new selection lands on top of the old one, so the
counter counts the wrong events with stale edge and invert behaviour.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Use FIELD_MODIFY() instead of masking then ORing (Jonathan).
---
 drivers/perf/cxl_pmu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index ff01b658e1b4..b16e2e4090a3 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -646,17 +646,17 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_FREEZE_ON_OVRFLW, 1);
 	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_ENABLE, 1);
-	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EDGE,
-			  cxl_pmu_config1_get_edge(event) ? 1 : 0);
-	cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_INVERT,
-			  cxl_pmu_config1_get_invert(event) ? 1 : 0);
+	FIELD_MODIFY(CXL_PMU_COUNTER_CFG_EDGE, &cfg,
+		     cxl_pmu_config1_get_edge(event) ? 1 : 0);
+	FIELD_MODIFY(CXL_PMU_COUNTER_CFG_INVERT, &cfg,
+		     cxl_pmu_config1_get_invert(event) ? 1 : 0);
 
 	/* Fixed purpose counters have next two fields RO */
 	if (test_bit(hwc->idx, info->conf_counter_bm)) {
-		cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK,
-				  hwc->event_base);
-		cfg |= FIELD_PREP(CXL_PMU_COUNTER_CFG_EVENTS_MSK,
-				  cxl_pmu_config_get_mask(event));
+		FIELD_MODIFY(CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, &cfg,
+			     hwc->event_base);
+		FIELD_MODIFY(CXL_PMU_COUNTER_CFG_EVENTS_MSK, &cfg,
+			     cxl_pmu_config_get_mask(event));
 	}
 	cfg &= ~CXL_PMU_COUNTER_CFG_THRESHOLD_MSK;
 	/*
-- 
2.55.0

