Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FDD3F9278
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408261; cv=none; b=N4MoCE15cu5MLv0ZeLMXyPvL/2/p1sJsKViF1TTVl7V86lVv5w3dePCVg7xSZYlnBCCq4kxysYVT7CDyRHrKVhRY1B5Mzot4zP6IJe4NueEt8cTFlCRXzbgIg7yZ61fqchE9dzSzT/dqqZ/fxwiH5vdTIvq7Gvwzmazf2oEEA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408261; c=relaxed/simple;
	bh=zm/j76/97qiIdP6ShSYrPWyYaeSdqWYJP6/PCBkTMQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBlsVBaB/sD5XA2M8nCiTo0FdfRX4vrFceRxrRK1UcMt868/O0y3vfZ3Qpj2UrWmdh4xYjZdKpMt71k7HeX/QQLkMPqt4pfrRqWCPYl8NPFVHboLlEKmyJI9mSjX3Yx0SOyruOnP3/ivV2M0EBLQYCVAxpmsIEKyUIiy2z/YasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cGQ9sgAC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cGQ9sgAC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BB78152B;
	Mon, 14 Sep 2026 10:50:55 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB0AA3F882;
	Mon, 14 Sep 2026 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789408258; bh=zm/j76/97qiIdP6ShSYrPWyYaeSdqWYJP6/PCBkTMQo=;
	h=From:To:Cc:Subject:Date:From;
	b=cGQ9sgACYMNU212IVt1Wa8aURU2hDz0Ba6t4Y+8h2Tp/2/Bjfh5hWPPcCq2PS6FSj
	 LEvI0ZJ6fsqohdFzc+QUCHgN5a6t8DqsrmCAh2uRkLCjPGzORrj+0zKdXXZdtuudHO
	 Dm4yncToH9nozJaAgikj1mmEK4VyCyTXlCN39gNs=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	ilkka@os.amperecomputing.com,
	leo.yan@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf/arm-cmn: Fix multi-filter encoding
Date: Mon, 14 Sep 2026 18:50:53 +0100
Message-ID: <03f15158e4c0a036f41cb4ab34c138a265c0730c.1789408253.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current special-case for EVICT_STATE_SEL filtering effectively
assigns the "filter" and "filter2" controls in the opposite order from
how the CMN S3 r2 TRM states "Filtering is programmed in pmu_hbt_lbt_sel
and pmu_evict_state_sel". On reflection, not only does this seem
unnecessarily non-obvious to users, but it's also likely to be a problem
for scaling to a full multi-filter abstraction in future. There is a
logical order to filters based on their bitfield positions in the
pmu_event_sel register, which the TRM descriptions allude to, and the
cmn_filter_select enum already (almost) follows, so let's fix the UABI
to follow suit while it's still unreleased.

Fixes: 09178f536bb9 ("perf/arm-cmn: Plumb in new filter types")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 54 ++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index b162de3d9d16..6464b815bd3b 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -305,9 +305,9 @@ enum cmn_filter_select {
 	SEL_NONE,
 	SEL_OCCUP1_ID,
 	SEL_CLASS_OCCUP_ID,
-	SEL_CBUSY_SNTHROTTLE_SEL,
 	SEL_HBT_LBT_SEL,
 	SEL_SN_HOME_SEL,
+	SEL_CBUSY_SNTHROTTLE_SEL,
 	SEL_SNP_VC_SEL,
 	SEL_ENHANCED_HBT_LBT_SEL,
 	SEL_EVICT_STATE_SEL,
@@ -978,10 +978,14 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 	_CMN_EVENT_HNS(_model, _name##_all, _event, _sel, 0),		\
 	_CMN_EVENT_HNS(_model, _name##_hbt, _event, _sel, 1),		\
 	_CMN_EVENT_HNS(_model, _name##_lbt, _event, _sel, 2)
-#define _CMN_EVENT_HNS_HBT2(_model, _name, _event, _fsel1, f1)		\
-	_CMN_EVENT_HNS(_model, _name##_all, _event, _fsel1, f1, SEL_HBT_LBT_SEL, 0), \
-	_CMN_EVENT_HNS(_model, _name##_hbt, _event, _fsel1, f1, SEL_HBT_LBT_SEL, 1), \
-	_CMN_EVENT_HNS(_model, _name##_lbt, _event, _fsel1, f1, SEL_HBT_LBT_SEL, 2)
+#define _CMN_EVENT_HNS_EVICT(_model, _name, _event, _fsel1, f1)			\
+	_CMN_EVENT_HNS(_model, _name##_all, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 0), \
+	_CMN_EVENT_HNS(_model, _name##_eu, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 1), \
+	_CMN_EVENT_HNS(_model, _name##_en, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 2), \
+	_CMN_EVENT_HNS(_model, _name##_su, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 3), \
+	_CMN_EVENT_HNS(_model, _name##_sn, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 4), \
+	_CMN_EVENT_HNS(_model, _name##_mu, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 5), \
+	_CMN_EVENT_HNS(_model, _name##_mn, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 6)
 
 #define CMN_EVENT_HNS_OCC(_model, _name, _event)			\
 	CMN_EVENT_HN_OCC(_model, hns_##_name, CMN_TYPE_HNS, _event),	\
@@ -1014,13 +1018,9 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 	_CMN_EVENT_HNS(CMNS3R2, _name##_ccglcn, _event, SEL_ENHANCED_HBT_LBT_SEL, 5), \
 	_CMN_EVENT_HNS(CMNS3R2, _name##_ccgrn, _event, SEL_ENHANCED_HBT_LBT_SEL, 6)
 #define CMN_EVENT_HNS_EVICT(_model, _name, _event)			\
-	_CMN_EVENT_HNS_HBT2(_model, _name##_all, _event, SEL_EVICT_STATE_SEL, 0), \
-	_CMN_EVENT_HNS_HBT2(_model, _name##_eu, _event, SEL_EVICT_STATE_SEL, 1), \
-	_CMN_EVENT_HNS_HBT2(_model, _name##_en, _event, SEL_EVICT_STATE_SEL, 2), \
-	_CMN_EVENT_HNS_HBT2(_model, _name##_su, _event, SEL_EVICT_STATE_SEL, 3), \
-	_CMN_EVENT_HNS_HBT2(_model, _name##_sn, _event, SEL_EVICT_STATE_SEL, 4), \
-	_CMN_EVENT_HNS_HBT2(_model, _name##_mu, _event, SEL_EVICT_STATE_SEL, 5), \
-	_CMN_EVENT_HNS_HBT2(_model, _name##_mn, _event, SEL_EVICT_STATE_SEL, 6)
+	_CMN_EVENT_HNS_EVICT(_model, _name##_all, _event, SEL_HBT_LBT_SEL, 0), \
+	_CMN_EVENT_HNS_EVICT(_model, _name##_hbt, _event, SEL_HBT_LBT_SEL, 1), \
+	_CMN_EVENT_HNS_EVICT(_model, _name##_lbt, _event, SEL_HBT_LBT_SEL, 2)
 
 #define CMN_EVENT_HNSR0_HBT(_name, _event)				\
 	_CMN_EVENT_HNS_HBT(CMN700 | CMNS3R01, _name, _event, SEL_HBT_LBT_SEL)
@@ -1856,10 +1856,12 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
 
 		val->dtm_count[dtm]++;
 
+		if (sel == SEL_EVICT_STATE_SEL) {
+			val->filter[dtm][sel] = CMN_EVENT_FILTER2(event) + 1;
+			sel = SEL_HBT_LBT_SEL;
+		}
 		if (sel)
 			val->filter[dtm][sel] = CMN_EVENT_FILTER(event) + 1;
-		if (sel == SEL_EVICT_STATE_SEL)
-			val->filter[dtm][SEL_HBT_LBT_SEL] = CMN_EVENT_FILTER2(event) + 1;
 
 		if (type != CMN_TYPE_WP)
 			continue;
@@ -1910,14 +1912,17 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
 		if (val->dtm_count[dtm] == CMN_DTM_NUM_COUNTERS)
 			goto done;
 
+		if (sel == SEL_EVICT_STATE_SEL) {
+			if (val->filter[dtm][sel] &&
+			    val->filter[dtm][sel] != CMN_EVENT_FILTER2(event) + 1)
+				goto done;
+			sel = SEL_HBT_LBT_SEL;
+		}
+
 		if (sel && val->filter[dtm][sel] &&
 		    val->filter[dtm][sel] != CMN_EVENT_FILTER(event) + 1)
 			goto done;
 
-		if (sel == SEL_EVICT_STATE_SEL && val->filter[dtm][SEL_HBT_LBT_SEL] &&
-		    val->filter[dtm][SEL_HBT_LBT_SEL] != CMN_EVENT_FILTER2(event) + 1)
-			goto done;
-
 		if (type != CMN_TYPE_WP)
 			continue;
 
@@ -2077,16 +2082,19 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 static int arm_cmn_set_event_filter(struct arm_cmn_node *dn, struct perf_event *event)
 {
 	enum cmn_filter_select fsel = to_cmn_hw(event)->filter_sel;
+	bool evict_state = fsel == SEL_EVICT_STATE_SEL;
 	int ret = 0;
 
+	if (evict_state) {
+		ret = arm_cmn_set_event_sel_hi(dn, fsel, CMN_EVENT_FILTER2(event));
+		fsel = SEL_HBT_LBT_SEL;
+	}
 	if (fsel)
 		ret = arm_cmn_set_event_sel_hi(dn, fsel, CMN_EVENT_FILTER(event));
 
-	if (fsel == SEL_EVICT_STATE_SEL && !ret) {
-		ret = arm_cmn_set_event_sel_hi(dn, SEL_HBT_LBT_SEL, CMN_EVENT_FILTER2(event));
-		if (ret)
-			dn->filter[fsel].count--;
-	}
+	if (ret && evict_state)
+		dn->filter[SEL_EVICT_STATE_SEL].count--;
+
 	return ret;
 }
 
-- 
2.54.0.dirty

