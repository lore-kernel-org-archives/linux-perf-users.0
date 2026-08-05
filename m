Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738D47D45B
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945308; cv=none; b=EouItfSuwpQ6wE/pbxpw27YsKmQ+uDyJ844Thg8k86aCFks4SqlQe7/Ij+RiPKhM+r9if9AFKAAcAEzhHgN9uWJzEILmvDpXU4Euyf8xNRv4uKNiRChlG9cHqh1ty+X07Ytd6qFhWFUUcNN4x2nXAW+r0eRWKRa18kskAcpM8EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945308; c=relaxed/simple;
	bh=bjLcb+MyAKKsr3Oq18bxc4PSNRozRBpV7VEUZwsmFQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4c2xCGXS27dcpyy++Emngg6jqDQKmrB+Ul05H6gcT4HHSjSP+VkYbkVmYAdnVHkICTA460O+yzKqH6aI0ko8Z4Rm2J4PTdgWK/j+2C+UERKolGeaPXgnDRCw7l8BFmBYfTwvKPOOr6V73SG6Uwu6Nv8wyBLEZ3BA8HSIJ1kIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B791F000E9;
	Wed,  5 Aug 2026 15:55:07 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: inux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	sashiko-bot@kernel.org
Subject: [PATCH v4 02/11] perf/cxl: Clear stale event fields before reprogramming a counter
Date: Wed,  5 Aug 2026 08:54:52 -0700
Message-ID: <20260805155501.1294472-3-dave.jiang@intel.com>
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

cxl_pmu_event_start() ORs the event group id, event mask, edge and invert
selections into a configurable counter's config register without clearing
them first, and cxl_pmu_event_stop() leaves them set. Reuse the counter for
another event and the new selection lands on top of the old one, so the
counter counts the wrong events with stale edge and invert behaviour.

Use FIELD_MODIFY() so each field is replaced rather than accumulated.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
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
2.54.0

