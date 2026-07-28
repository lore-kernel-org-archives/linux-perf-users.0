Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A873D9541
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254378; cv=none; b=a6+RD/CxJLbn7fFRnOtNHLbqPR/IYh/kfM9EqcQdjZkWxWn9KCFLaS0+H1myFClq7JcBZwzp/W2oYA2MxXVDGb8zKX/vdPlLFXBHXfn/42THBsWvkZ544xDUYUk1rNK80tDs4mx3TRpWaRLFQm9MRomquj2PWhZTYAUfYRxSkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254378; c=relaxed/simple;
	bh=oqHXvb2CwBep+mLsBYirdaNyiiOkhF0lioMwBfpzBx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4MUaFZcxZ+IIGA71cVRV+gyQd0x7fFcp5y8+0LhMdcMfhStoD2OsBLceQcD4F2Q/MC2b/JERkfdWXxkkFGOS67IBt6M0rJxiWhc4DbjvMJqET3UV0941Im+HyAXteBnrjK+osrGrc8xnRgv9zl3O8qUV8Gpqg/NZ/AVpNPv6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Gyd6C0e4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Gyd6C0e4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 648A7169E;
	Tue, 28 Jul 2026 08:59:30 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 797D33F66F;
	Tue, 28 Jul 2026 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785254374; bh=oqHXvb2CwBep+mLsBYirdaNyiiOkhF0lioMwBfpzBx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gyd6C0e4nV4GeSvVpW+yfOUdPXmYhjMKnaxHgf9bfplzV8lybopJn48PuQm0UnK+K
	 QiCh62PDsy3LBzLDdfBhg83deQlgBIyldW6PsTs7jigfRxYcOIfEvm+QrQb36dXcvz
	 aCldOFqYScnCO4oF5Zy2bylQ1/82ShhUmtFgTccM=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com,
	leo.yan@arm.com
Subject: [PATCH v2 1/5] perf/arm-cmn: Rename filter variables for clarity
Date: Tue, 28 Jul 2026 16:59:21 +0100
Message-ID: <ae87ea9530b3c2073874035a244f34baf7915def.1785252273.git.robin.murphy@arm.com>
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

CMN has already grown many more event-specific filters than the original
Occupancy ID, but since they are all independent of each other we've
just overloaded them onto the same name. Before we add yet more, and
they begin to overlap, rename all our "occupid" variables to "filter" so
that things can be a bit clearer and more consistent (but leaving the
format attribute itself, to avoid UAPI concerns).

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: No change

 drivers/perf/arm-cmn.c | 53 ++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 50402bc4a21d..2a8a67da72c3 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -163,13 +163,13 @@
 /* Event attributes */
 #define CMN_CONFIG_TYPE			GENMASK_ULL(15, 0)
 #define CMN_CONFIG_EVENTID		GENMASK_ULL(26, 16)
-#define CMN_CONFIG_OCCUPID		GENMASK_ULL(30, 27)
+#define CMN_CONFIG_FILTER		GENMASK_ULL(30, 27)
 #define CMN_CONFIG_BYNODEID		BIT_ULL(31)
 #define CMN_CONFIG_NODEID		GENMASK_ULL(47, 32)
 
 #define CMN_EVENT_TYPE(event)		FIELD_GET(CMN_CONFIG_TYPE, (event)->attr.config)
 #define CMN_EVENT_EVENTID(event)	FIELD_GET(CMN_CONFIG_EVENTID, (event)->attr.config)
-#define CMN_EVENT_OCCUPID(event)	FIELD_GET(CMN_CONFIG_OCCUPID, (event)->attr.config)
+#define CMN_EVENT_FILTER(event)		FIELD_GET(CMN_CONFIG_FILTER, (event)->attr.config)
 #define CMN_EVENT_BYNODEID(event)	FIELD_GET(CMN_CONFIG_BYNODEID, (event)->attr.config)
 #define CMN_EVENT_NODEID(event)		FIELD_GET(CMN_CONFIG_NODEID, (event)->attr.config)
 
@@ -301,7 +301,7 @@ struct arm_cmn_node {
 	struct {
 		u8 val : 4;
 		u8 count : 4;
-	} occupid[SEL_MAX];
+	} filter[SEL_MAX];
 	union {
 		u8 event[4];
 		__le32 event_sel;
@@ -672,7 +672,7 @@ struct arm_cmn_event_attr {
 	enum cmn_node_type type;
 	enum cmn_filter_select fsel;
 	u16 eventid;
-	u8 occupid;
+	u8 filter;
 };
 
 struct arm_cmn_format_attr {
@@ -681,13 +681,13 @@ struct arm_cmn_format_attr {
 	int config;
 };
 
-#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _occupid, _fsel)\
+#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _filter, _fsel)\
 	(&((struct arm_cmn_event_attr[]) {{				\
 		.attr = __ATTR(_name, 0444, arm_cmn_event_show, NULL),	\
 		.model = _model,					\
 		.type = _type,						\
 		.eventid = _eventid,					\
-		.occupid = _occupid,					\
+		.filter = _filter,					\
 		.fsel = _fsel,						\
 	}})[0].attr.attr)
 #define CMN_EVENT_ATTR(_model, _name, _type, _eventid)			\
@@ -709,8 +709,8 @@ static ssize_t arm_cmn_event_show(struct device *dev,
 				  eattr->type, eattr->eventid);
 
 	if (eattr->fsel > SEL_NONE)
-		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,occupid=0x%x\n",
-				  eattr->type, eattr->eventid, eattr->occupid);
+		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,filter=0x%x\n",
+				  eattr->type, eattr->eventid, eattr->filter);
 
 	return sysfs_emit(buf, "type=0x%x,eventid=0x%x\n", eattr->type,
 			  eattr->eventid);
@@ -1320,7 +1320,7 @@ static ssize_t arm_cmn_format_show(struct device *dev,
 static struct attribute *arm_cmn_format_attrs[] = {
 	CMN_FORMAT_ATTR(type, CMN_CONFIG_TYPE),
 	CMN_FORMAT_ATTR(eventid, CMN_CONFIG_EVENTID),
-	CMN_FORMAT_ATTR(occupid, CMN_CONFIG_OCCUPID),
+	CMN_FORMAT_ATTR(filter, CMN_CONFIG_FILTER),
 	CMN_FORMAT_ATTR(bynodeid, CMN_CONFIG_BYNODEID),
 	CMN_FORMAT_ATTR(nodeid, CMN_CONFIG_NODEID),
 
@@ -1333,6 +1333,9 @@ static struct attribute *arm_cmn_format_attrs[] = {
 	_CMN_FORMAT_ATTR(wp_val, 1, CMN_CONFIG1_WP_VAL),
 	_CMN_FORMAT_ATTR(wp_mask, 2, CMN_CONFIG2_WP_MASK),
 
+	/* Old name for UAPI compatibility */
+	CMN_FORMAT_ATTR(occupid, CMN_CONFIG_FILTER),
+
 	NULL
 };
 
@@ -1544,30 +1547,30 @@ static void arm_cmn_event_read(struct perf_event *event)
 }
 
 static int arm_cmn_set_event_sel_hi(struct arm_cmn_node *dn,
-				    enum cmn_filter_select fsel, u8 occupid)
+				    enum cmn_filter_select fsel, u8 filter)
 {
 	u64 reg;
 
 	if (fsel == SEL_NONE)
 		return 0;
 
-	if (!dn->occupid[fsel].count) {
-		dn->occupid[fsel].val = occupid;
+	if (!dn->filter[fsel].count) {
+		dn->filter[fsel].val = filter;
 		reg = FIELD_PREP(CMN__PMU_CBUSY_SNTHROTTLE_SEL,
-				 dn->occupid[SEL_CBUSY_SNTHROTTLE_SEL].val) |
+				 dn->filter[SEL_CBUSY_SNTHROTTLE_SEL].val) |
 		      FIELD_PREP(CMN__PMU_SN_HOME_SEL,
-				 dn->occupid[SEL_SN_HOME_SEL].val) |
+				 dn->filter[SEL_SN_HOME_SEL].val) |
 		      FIELD_PREP(CMN__PMU_HBT_LBT_SEL,
-				 dn->occupid[SEL_HBT_LBT_SEL].val) |
+				 dn->filter[SEL_HBT_LBT_SEL].val) |
 		      FIELD_PREP(CMN__PMU_CLASS_OCCUP_ID,
-				 dn->occupid[SEL_CLASS_OCCUP_ID].val) |
+				 dn->filter[SEL_CLASS_OCCUP_ID].val) |
 		      FIELD_PREP(CMN__PMU_OCCUP1_ID,
-				 dn->occupid[SEL_OCCUP1ID].val);
+				 dn->filter[SEL_OCCUP1ID].val);
 		writel_relaxed(reg >> 32, dn->pmu_base + CMN_PMU_EVENT_SEL + 4);
-	} else if (dn->occupid[fsel].val != occupid) {
+	} else if (dn->filter[fsel].val != filter) {
 		return -EBUSY;
 	}
-	dn->occupid[fsel].count++;
+	dn->filter[fsel].count++;
 	return 0;
 }
 
@@ -1649,7 +1652,7 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
 
 struct arm_cmn_val {
 	u8 dtm_count[CMN_MAX_DTMS];
-	u8 occupid[CMN_MAX_DTMS][SEL_MAX];
+	u8 filter[CMN_MAX_DTMS][SEL_MAX];
 	u8 wp[CMN_MAX_DTMS][4];
 	u8 wp_combine[CMN_MAX_DTMS][2];
 	int dtc_count[CMN_MAX_DTCS];
@@ -1694,7 +1697,7 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 		val->dtm_count[dtm]++;
 
 		if (sel > SEL_NONE)
-			val->occupid[dtm][sel] = CMN_EVENT_OCCUPID(event) + 1;
+			val->filter[dtm][sel] = CMN_EVENT_FILTER(event) + 1;
 
 		if (type != CMN_TYPE_WP)
 			continue;
@@ -1745,8 +1748,8 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 		if (val->dtm_count[dtm] == CMN_DTM_NUM_COUNTERS)
 			goto done;
 
-		if (sel > SEL_NONE && val->occupid[dtm][sel] &&
-		    val->occupid[dtm][sel] != CMN_EVENT_OCCUPID(event) + 1)
+		if (sel > SEL_NONE && val->filter[dtm][sel] &&
+		    val->filter[dtm][sel] != CMN_EVENT_FILTER(event) + 1)
 			goto done;
 
 		if (type != CMN_TYPE_WP)
@@ -1892,7 +1895,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 		}
 
 		if (hw->filter_sel > SEL_NONE)
-			hw->dn[i].occupid[hw->filter_sel].count--;
+			hw->dn[i].filter[hw->filter_sel].count--;
 
 		dtm->pmu_config_low &= ~CMN__PMEVCNT_PAIRED(dtm_idx);
 		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
@@ -1978,7 +1981,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_DEV + dtm_idx +
 				    (nid.port << 4) + (nid.dev << 2);
 
-			if (arm_cmn_set_event_sel_hi(dn, hw->filter_sel, CMN_EVENT_OCCUPID(event)))
+			if (arm_cmn_set_event_sel_hi(dn, hw->filter_sel, CMN_EVENT_FILTER(event)))
 				goto free_dtms;
 		}
 
-- 
2.54.0.dirty

