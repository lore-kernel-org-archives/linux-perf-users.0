Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2161B142D
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832772; cv=none; b=mitWLkV0xVjC+W2DfJw6Mgyo075OAUu+MtZCIAcANLRwisYEW1WgAD9sbltzXwQzDobLy7b+txzAOl7kL1YRfbp9vKDmXIc7duA3UWBx9QC6AJkVbYc6Waj4tRPq2RDfX4F0fEn04Xqxe3akKtWK3LhOmM/nLjrkAyxNmrjSYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832772; c=relaxed/simple;
	bh=bf0KPRTxWBWEbxEGZYyMJx5UJ/6K15V7dQsd1A4xOrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWPlS1jzvm8b8ew/hRmhgQ3UlYECADS+EkY03IIQWASZka837Xq477VMBn65FVmFgUxpiDBLToqiDBuyk4DXbpBqglF9Fmn1zNuKzoAQqW2HiSZbqy5Huj7rNeZEklRFOLpBYge0Et2EKETkqnmVsoVKebJuD+nu5V9BdG4alpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XK6wQ+M+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XK6wQ+M+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBEF22F27;
	Tue, 30 Jun 2026 08:19:25 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56BF03F66F;
	Tue, 30 Jun 2026 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782832770; bh=bf0KPRTxWBWEbxEGZYyMJx5UJ/6K15V7dQsd1A4xOrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XK6wQ+M+n3hRTIXfGmt24WKEds+XFb94ozZ0lCezQ7QcEyfGYbL6w1OHzHWc/sHqF
	 YhIKydSiVDKRwio7hOcnqdmJYeM4guUmHMBF0yh6jBDAM9iwopWi6pnE+rAd+gZBEB
	 k6GpUqf2gKpVfESMKpBWGJ0XR3mlVJyd/3ZGdpAM=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH 2/5] perf/arm-cmn: Refactor event filter programming
Date: Tue, 30 Jun 2026 16:19:17 +0100
Message-ID: <204a29eff358ffd2c6c248738c5e272dbc678990.1782830759.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
In-Reply-To: <cover.1782830759.git.robin.murphy@arm.com>
References: <cover.1782830759.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're soon going to need to cope with events having multiple filters,
plus the filter fields themselves moving around, wherein any more inline
if/else logic will struggle to scale. Add a more general abstraction for
the node-specific filter controls, and rejig the pmu_event_sel filter
programming around it in a more extensible manner.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 139 ++++++++++++++++++++++++++++++-----------
 1 file changed, 101 insertions(+), 38 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 2a8a67da72c3..14c267d2e2f9 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -278,8 +278,8 @@ enum cmn_node_type {
 };
 
 enum cmn_filter_select {
-	SEL_NONE = -1,
-	SEL_OCCUP1ID,
+	SEL_NONE,
+	SEL_OCCUP1_ID,
 	SEL_CLASS_OCCUP_ID,
 	SEL_CBUSY_SNTHROTTLE_SEL,
 	SEL_HBT_LBT_SEL,
@@ -599,6 +599,57 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id)
 static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
 #endif
 
+enum cmn_filter_type {
+	FILT_NONE,
+	FILT_OCCUP1_ID,
+	FILT_HNF_700,
+	FILT_HNS,
+};
+#define CMN_FILTER(_sel)	[SEL_##_sel] = CMN__PMU_##_sel
+
+static const u64 arm_cmn_filters[][SEL_MAX] = {
+	[FILT_NONE] = {},
+	/* DVM etc. */
+	[FILT_OCCUP1_ID] = {
+		CMN_FILTER(OCCUP1_ID)
+	},
+	/* Newer HN-F */
+	[FILT_HNF_700] = {
+		CMN_FILTER(OCCUP1_ID),
+		CMN_FILTER(CLASS_OCCUP_ID),
+		CMN_FILTER(CBUSY_SNTHROTTLE_SEL)
+	},
+	/* HN-S */
+	[FILT_HNS] = {
+		CMN_FILTER(OCCUP1_ID),
+		CMN_FILTER(CLASS_OCCUP_ID),
+		CMN_FILTER(CBUSY_SNTHROTTLE_SEL),
+		CMN_FILTER(HBT_LBT_SEL),
+		CMN_FILTER(SN_HOME_SEL)
+	},
+};
+
+static enum cmn_filter_type arm_cmn_filter(enum cmn_node_type node,
+					   enum cmn_model model)
+{
+	switch (node) {
+	default:
+		return FILT_NONE;
+	case CMN_TYPE_DVM:
+	case CMN_TYPE_CXRA:
+	case CMN_TYPE_CXHA:
+	case CMN_TYPE_CCRA:
+	case CMN_TYPE_CCHA:
+		return FILT_OCCUP1_ID;
+	case CMN_TYPE_HNF:
+		if (model < CMN700)
+			return FILT_OCCUP1_ID;
+		return FILT_HNF_700;
+	case CMN_TYPE_HNS:
+		return FILT_HNS;
+	};
+}
+
 struct arm_cmn_hw_event {
 	struct arm_cmn_node *dn;
 	union {
@@ -708,7 +759,7 @@ static ssize_t arm_cmn_event_show(struct device *dev,
 				  "type=0x%x,eventid=0x%x,wp_dev_sel=?,wp_chn_sel=?,wp_grp=?,wp_val=?,wp_mask=?\n",
 				  eattr->type, eattr->eventid);
 
-	if (eattr->fsel > SEL_NONE)
+	if (eattr->fsel)
 		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,filter=0x%x\n",
 				  eattr->type, eattr->eventid, eattr->filter);
 
@@ -832,16 +883,16 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 #define CMN_EVENT_DVM(_model, _name, _event)			\
 	_CMN_EVENT_DVM(_model, _name, _event, 0, SEL_NONE)
 #define CMN_EVENT_DVM_OCC(_model, _name, _event)			\
-	_CMN_EVENT_DVM(_model, _name##_all, _event, 0, SEL_OCCUP1ID),	\
-	_CMN_EVENT_DVM(_model, _name##_dvmop, _event, 1, SEL_OCCUP1ID),	\
-	_CMN_EVENT_DVM(_model, _name##_dvmsync, _event, 2, SEL_OCCUP1ID)
+	_CMN_EVENT_DVM(_model, _name##_all, _event, 0, SEL_OCCUP1_ID),	\
+	_CMN_EVENT_DVM(_model, _name##_dvmop, _event, 1, SEL_OCCUP1_ID),	\
+	_CMN_EVENT_DVM(_model, _name##_dvmsync, _event, 2, SEL_OCCUP1_ID)
 
 #define CMN_EVENT_HN_OCC(_model, _name, _type, _event)		\
-	_CMN_EVENT_ATTR(_model, _name##_all, _type, _event, 0, SEL_OCCUP1ID), \
-	_CMN_EVENT_ATTR(_model, _name##_read, _type, _event, 1, SEL_OCCUP1ID), \
-	_CMN_EVENT_ATTR(_model, _name##_write, _type, _event, 2, SEL_OCCUP1ID), \
-	_CMN_EVENT_ATTR(_model, _name##_atomic, _type, _event, 3, SEL_OCCUP1ID), \
-	_CMN_EVENT_ATTR(_model, _name##_stash, _type, _event, 4, SEL_OCCUP1ID)
+	_CMN_EVENT_ATTR(_model, _name##_all, _type, _event, 0, SEL_OCCUP1_ID), \
+	_CMN_EVENT_ATTR(_model, _name##_read, _type, _event, 1, SEL_OCCUP1_ID), \
+	_CMN_EVENT_ATTR(_model, _name##_write, _type, _event, 2, SEL_OCCUP1_ID), \
+	_CMN_EVENT_ATTR(_model, _name##_atomic, _type, _event, 3, SEL_OCCUP1_ID), \
+	_CMN_EVENT_ATTR(_model, _name##_stash, _type, _event, 4, SEL_OCCUP1_ID)
 #define CMN_EVENT_HN_CLS(_model, _name, _type, _event)			\
 	_CMN_EVENT_ATTR(_model, _name##_class0, _type, _event, 0, SEL_CLASS_OCCUP_ID), \
 	_CMN_EVENT_ATTR(_model, _name##_class1, _type, _event, 1, SEL_CLASS_OCCUP_ID), \
@@ -865,9 +916,9 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 
 #define CMN_EVENT_HNS_OCC(_name, _event)				\
 	CMN_EVENT_HN_OCC(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event),	\
-	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_rxsnp, CMN_TYPE_HNS, _event, 5, SEL_OCCUP1ID), \
-	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_lbt, CMN_TYPE_HNS, _event, 6, SEL_OCCUP1ID), \
-	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_hbt, CMN_TYPE_HNS, _event, 7, SEL_OCCUP1ID)
+	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_rxsnp, CMN_TYPE_HNS, _event, 5, SEL_OCCUP1_ID), \
+	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_lbt, CMN_TYPE_HNS, _event, 6, SEL_OCCUP1_ID), \
+	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_hbt, CMN_TYPE_HNS, _event, 7, SEL_OCCUP1_ID)
 #define CMN_EVENT_HNS_CLS( _name, _event)				\
 	CMN_EVENT_HN_CLS(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event)
 #define CMN_EVENT_HNS_SNT(_name, _event)				\
@@ -1547,27 +1598,20 @@ static void arm_cmn_event_read(struct perf_event *event)
 }
 
 static int arm_cmn_set_event_sel_hi(struct arm_cmn_node *dn,
-				    enum cmn_filter_select fsel, u8 filter)
+				    enum cmn_filter_select fsel, u8 val)
 {
-	u64 reg;
-
-	if (fsel == SEL_NONE)
-		return 0;
-
 	if (!dn->filter[fsel].count) {
-		dn->filter[fsel].val = filter;
-		reg = FIELD_PREP(CMN__PMU_CBUSY_SNTHROTTLE_SEL,
-				 dn->filter[SEL_CBUSY_SNTHROTTLE_SEL].val) |
-		      FIELD_PREP(CMN__PMU_SN_HOME_SEL,
-				 dn->filter[SEL_SN_HOME_SEL].val) |
-		      FIELD_PREP(CMN__PMU_HBT_LBT_SEL,
-				 dn->filter[SEL_HBT_LBT_SEL].val) |
-		      FIELD_PREP(CMN__PMU_CLASS_OCCUP_ID,
-				 dn->filter[SEL_CLASS_OCCUP_ID].val) |
-		      FIELD_PREP(CMN__PMU_OCCUP1_ID,
-				 dn->filter[SEL_OCCUP1ID].val);
+		const u64 *filter = arm_cmn_filters[dn->filter[SEL_NONE].val];
+		u64 reg = 0;
+
+		dn->filter[fsel].val = val;
+		for (int i = SEL_OCCUP1_ID; i < SEL_MAX; i++) {
+			if (filter[i])
+				reg |= field_prep(filter[i], dn->filter[i].val);
+		}
+
 		writel_relaxed(reg >> 32, dn->pmu_base + CMN_PMU_EVENT_SEL + 4);
-	} else if (dn->filter[fsel].val != filter) {
+	} else if (dn->filter[fsel].val != val) {
 		return -EBUSY;
 	}
 	dn->filter[fsel].count++;
@@ -1696,7 +1740,7 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 
 		val->dtm_count[dtm]++;
 
-		if (sel > SEL_NONE)
+		if (sel)
 			val->filter[dtm][sel] = CMN_EVENT_FILTER(event) + 1;
 
 		if (type != CMN_TYPE_WP)
@@ -1748,7 +1792,7 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 		if (val->dtm_count[dtm] == CMN_DTM_NUM_COUNTERS)
 			goto done;
 
-		if (sel > SEL_NONE && val->filter[dtm][sel] &&
+		if (sel && val->filter[dtm][sel] &&
 		    val->filter[dtm][sel] != CMN_EVENT_FILTER(event) + 1)
 			goto done;
 
@@ -1894,7 +1938,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 			dtm->wp_event[wp_idx] = -1;
 		}
 
-		if (hw->filter_sel > SEL_NONE)
+		if (hw->filter_sel)
 			hw->dn[i].filter[hw->filter_sel].count--;
 
 		dtm->pmu_config_low &= ~CMN__PMEVCNT_PAIRED(dtm_idx);
@@ -1906,6 +1950,17 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 		cmn->dtc[j].counters[idx] = NULL;
 }
 
+static int arm_cmn_set_event_filter(struct arm_cmn_node *dn, struct perf_event *event)
+{
+	enum cmn_filter_select fsel = to_cmn_hw(event)->filter_sel;
+	int ret = 0;
+
+	if (fsel)
+		ret = arm_cmn_set_event_sel_hi(dn, fsel, CMN_EVENT_FILTER(event));
+
+	return ret;
+}
+
 static int arm_cmn_event_add(struct perf_event *event, int flags)
 {
 	struct arm_cmn *cmn = to_cmn(event->pmu);
@@ -1981,7 +2036,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_DEV + dtm_idx +
 				    (nid.port << 4) + (nid.dev << 2);
 
-			if (arm_cmn_set_event_sel_hi(dn, hw->filter_sel, CMN_EVENT_FILTER(event)))
+			if (arm_cmn_set_event_filter(dn, event))
 				goto free_dtms;
 		}
 
@@ -2311,6 +2366,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	void __iomem *cfg_region, __iomem *xp_region;
 	struct arm_cmn_node cfg, *dn;
 	struct arm_cmn_dtm *dtm;
+	enum cmn_model model;
 	enum cmn_part part;
 	u16 child_count, child_poff;
 	u64 reg;
@@ -2342,12 +2398,14 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			 "Firmware binding mismatch: expected part number 0x%x, found 0x%x\n",
 			 cmn->part, part);
 	cmn->part = part;
-	if (!arm_cmn_model(cmn))
-		dev_warn(cmn->dev, "Unknown part number: 0x%x\n", part);
 
 	reg = readl_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_23);
 	cmn->rev = FIELD_GET(CMN_CFGM_PID2_REVISION, reg);
 
+	model = arm_cmn_model(cmn);
+	if (!model)
+		dev_warn(cmn->dev, "Unknown part number: 0x%x\n", part);
+
 	/*
 	 * With the device isolation feature, if firmware has neglected to enable
 	 * an XP port then we risk locking up if we try to access anything behind
@@ -2500,6 +2558,11 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 				dev_err(cmn->dev, "Node ID invalid for supported CMN versions: %d\n", dn->logid);
 				return -ENODEV;
 			}
+			/*
+			 * We can utilise the "wasted" filter array slot to store
+			 * the index for referencing the filter encodings later.
+			 */
+			dn->filter[SEL_NONE].val = arm_cmn_filter(dn->type, model);
 
 			switch (dn->type) {
 			case CMN_TYPE_DTC:
-- 
2.54.0.dirty

