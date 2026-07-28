Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF833E34B
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254383; cv=none; b=BccWUXVH0/3pRSx7ss86Nl/57R+Mpcqkt/8NYPsYBu7EnJhugQgU6viPTtMfbnx1xV2ogI0fxnW7ERDNcpeVqWfjIl4r/0Fuv78iZUyez4YagxL1N4eSVCGB+Cv6g8knXppA5HSwy/VAuWI/WE1RLnsjAv9xl3ucChdVAfkdrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254383; c=relaxed/simple;
	bh=+kq4KKsOSG6ZTo6MRYPtFWnwOcIH/szLlJq7PhuJnWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRle4JuNUe3YSAn/kMBr+uUibh9En5tJaPbExB7Ahl5YbKRo8f9ELu0HZPSjd8RCs0xh/W1B2pwBdwiP/XrKgC6brPqMAudjJ4BeXHepNOOtaETAeA3Cgq1oH0CIwRJyWy6vltmKANGNN8HfBcmp4Hs7iTSs/x5eyemP4SQ5S7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vz5Hj97w; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vz5Hj97w"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 131C61E7D;
	Tue, 28 Jul 2026 08:59:35 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 549043F66F;
	Tue, 28 Jul 2026 08:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785254379; bh=+kq4KKsOSG6ZTo6MRYPtFWnwOcIH/szLlJq7PhuJnWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vz5Hj97wWTsilkyrGybho5yfs5LgfOESvEy1s6R3QQUUN8UmVCJspNolG+7XZc6gP
	 uzbQeg92T9GrVbPVs/4TUY6hoo78SO2XCmZczGk7V78Glg3JfN7ZpJEfKH4V4jjlUE
	 2fHGu0ZSAcyTWigCSh87fOH5EuP5ZSQVGBNUxOQs=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com,
	leo.yan@arm.com
Subject: [PATCH v2 4/5] perf/arm-cmn: Plumb in new filter types
Date: Tue, 28 Jul 2026 16:59:24 +0100
Message-ID: <90465c737b71be5d39c3662c7ba07ab6a1326009.1785252273.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1785252273.git.robin.murphy@arm.com>
References: <cover.1785252273.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the logic to handle events with the upcoming new filter controls.
Since for now we will have the sole invariant of all EVICT_STATE_SEL
events having HBT_LBT_SEL as a secondary filter, for the sake of
simplicity we can just special-case that, and save the complication
of a full multi-filter abstraction until unavoidably necessary.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Tweak commit message

 drivers/perf/arm-cmn.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 74bc2aae4a06..e25f46c38c23 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -166,12 +166,14 @@
 #define CMN_CONFIG_FILTER		GENMASK_ULL(30, 27)
 #define CMN_CONFIG_BYNODEID		BIT_ULL(31)
 #define CMN_CONFIG_NODEID		GENMASK_ULL(47, 32)
+#define CMN_CONFIG_FILTER2		GENMASK_ULL(51, 48)
 
 #define CMN_EVENT_TYPE(event)		FIELD_GET(CMN_CONFIG_TYPE, (event)->attr.config)
 #define CMN_EVENT_EVENTID(event)	FIELD_GET(CMN_CONFIG_EVENTID, (event)->attr.config)
 #define CMN_EVENT_FILTER(event)		FIELD_GET(CMN_CONFIG_FILTER, (event)->attr.config)
 #define CMN_EVENT_BYNODEID(event)	FIELD_GET(CMN_CONFIG_BYNODEID, (event)->attr.config)
 #define CMN_EVENT_NODEID(event)		FIELD_GET(CMN_CONFIG_NODEID, (event)->attr.config)
+#define CMN_EVENT_FILTER2(event)	FIELD_GET(CMN_CONFIG_FILTER2, (event)->attr.config)
 
 #define CMN_CONFIG_WP_COMBINE		GENMASK_ULL(30, 27)
 #define CMN_CONFIG_WP_DEV_SEL		GENMASK_ULL(50, 48)
@@ -284,6 +286,9 @@ enum cmn_filter_select {
 	SEL_CBUSY_SNTHROTTLE_SEL,
 	SEL_HBT_LBT_SEL,
 	SEL_SN_HOME_SEL,
+	SEL_SNP_VC_SEL,
+	SEL_ENHANCED_HBT_LBT_SEL,
+	SEL_EVICT_STATE_SEL,
 	SEL_MAX
 };
 
@@ -1377,6 +1382,7 @@ static struct attribute *arm_cmn_format_attrs[] = {
 	CMN_FORMAT_ATTR(filter, CMN_CONFIG_FILTER),
 	CMN_FORMAT_ATTR(bynodeid, CMN_CONFIG_BYNODEID),
 	CMN_FORMAT_ATTR(nodeid, CMN_CONFIG_NODEID),
+	CMN_FORMAT_ATTR(filter2, CMN_CONFIG_FILTER2),
 
 	CMN_FORMAT_ATTR(wp_dev_sel, CMN_CONFIG_WP_DEV_SEL),
 	CMN_FORMAT_ATTR(wp_chn_sel, CMN_CONFIG_WP_CHN_SEL),
@@ -1745,6 +1751,8 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 
 		if (sel)
 			val->filter[dtm][sel] = CMN_EVENT_FILTER(event) + 1;
+		if (sel == SEL_EVICT_STATE_SEL)
+			val->filter[dtm][SEL_HBT_LBT_SEL] = CMN_EVENT_FILTER2(event) + 1;
 
 		if (type != CMN_TYPE_WP)
 			continue;
@@ -1799,6 +1807,10 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 		    val->filter[dtm][sel] != CMN_EVENT_FILTER(event) + 1)
 			goto done;
 
+		if (sel == SEL_EVICT_STATE_SEL && val->filter[dtm][SEL_HBT_LBT_SEL] &&
+		    val->filter[dtm][SEL_HBT_LBT_SEL] != CMN_EVENT_FILTER2(event) + 1)
+			goto done;
+
 		if (type != CMN_TYPE_WP)
 			continue;
 
@@ -1943,6 +1955,8 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 
 		if (hw->filter_sel)
 			hw->dn[i].filter[hw->filter_sel].count--;
+		if (hw->filter_sel == SEL_EVICT_STATE_SEL)
+			hw->dn[i].filter[SEL_HBT_LBT_SEL].count--;
 
 		dtm->pmu_config_low &= ~CMN__PMEVCNT_PAIRED(dtm_idx);
 		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
@@ -1961,6 +1975,11 @@ static int arm_cmn_set_event_filter(struct arm_cmn_node *dn, struct perf_event *
 	if (fsel)
 		ret = arm_cmn_set_event_sel_hi(dn, fsel, CMN_EVENT_FILTER(event));
 
+	if (fsel == SEL_EVICT_STATE_SEL && !ret) {
+		ret = arm_cmn_set_event_sel_hi(dn, SEL_HBT_LBT_SEL, CMN_EVENT_FILTER2(event));
+		if (ret)
+			dn->filter[fsel].count--;
+	}
 	return ret;
 }
 
-- 
2.54.0.dirty

