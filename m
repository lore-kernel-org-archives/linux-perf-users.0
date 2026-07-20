Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA03DE420
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544338; cv=none; b=f1cH0THbbdMdZriIeRFgU1XmC0defuviZYz5BbR8SyJRx1k7nkLUoHJpSJkgK477xN6C6BvQOlc/KySZvpti7OVs0ozqydw5u/dP5q5wtss/MNnHADi1FUkf+gTJpWcgUA2vNaFX5R+IvkVIIE1BrQrpXOfEyFtofFogU5elLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544338; c=relaxed/simple;
	bh=snidZyOIeDGaTUExDy+6L54FQxAo4Z/dGMvUlLQgnHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GcQKLalJrecVjEJER6Hq+Xv9UJgcOZit/vbrJWTbZITyHwcokj898hahZtSb43DnGtp741sDse8rmLr9OQ82b8cBIUKDX722b4r1poUO4coadqkLI/FwFDXCL2Vjt5cHJ45uaCctrZaM0fCRzxmsYWEbAje/2YPWOCTJsoLLG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BVCagt3i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BVCagt3i"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABrRD1908334;
	Mon, 20 Jul 2026 10:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hhx0/37FaNm9F+HZI
	d6yHahIuW3g3TmVDTstmAbuU1k=; b=BVCagt3i2A6haxjWtm2aJ7JzbFzBLmJWe
	XZ0lRlbsjdiqeJi3dIiYxplXJOZgNNx7AnR6GVmkk/TCeYP6eOckXLpTmajrkIsu
	x9Fl/OszhKTDGE5/FnVsidkAQGrISQxW7Y9gBKquMIdHm/Sxu21+Pk4n1aWJx+bN
	u8iS1/xgxHi0GOWotk/4HQLB72mueqmrH9r+ZpUgkIgWf2v/qhecEhwU6gIBqdLp
	woCK+UjJbhX+V0VeiT+4e1jAiwcLHsz4riptvVyBibpPu6sBbhWXtugOFtCYEbzx
	RczCErBqyPZ/itWTuSY1kYuuH8GbRt8Zl5r7fw53OjKJ9l0hfKyzw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7agxrat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAYdhq012601;
	Mon, 20 Jul 2026 10:45:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vwaj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAjFB515008200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:45:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD27E2004D;
	Mon, 20 Jul 2026 10:45:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7175C2004B;
	Mon, 20 Jul 2026 10:45:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:45:13 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V2 2/6] powerpc/perf: Reject duplicate HTM target reservations
Date: Mon, 20 Jul 2026 16:14:43 +0530
Message-Id: <20260720104447.11843-3-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260720104447.11843-1-atrajeev@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0NX0QYQMyHX0d26gpxnhFfAFv_EkaWWp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX7Dz9ZXw+UsM/
 g5rA6igVLTUYyWHPLJeAq6JsaUGolNOey67uPBwIgqNcJlWH93hwkrvSPrc3CLVQ7704FwOa4ns
 72HV0/DWi3i5ebUEfiFA6p4KOxRkuDKFQqtyIZeIkJApBFMJq6l+/BSFONJcKUWNUEn7pJqLPiU
 wIhk8u4gsOjcQSeWKIvZSJZ4ap4Vx5tLnI56qPfoBc7hCTUPWaAskGnXxj/BWAdmqVBoSCfOncj
 Aq7iW46cUKrgVMszJsxGWUV4sP/uNQ/iY50w/ranb+N5L0KZUf6WjSvWI79AL0sJwRK0y2Sb2dR
 upB0N9rjwsHviPHkK9j5JALJW1JulpcCqeVw+pu4/V1y3CHaR1U2SoFmL0582ru/53EUVs6lwot
 9adJiEKdyXE+Yzj8JOQsS5z/6/EnnFLY7JSvmG+RB2qpKyRTOZ8wA2vkJp2wvkV5oB0MgY52oab
 8JbvZtUkuMFwlJezu3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX1ocRlSihEomb
 hnGfIvK1ttj7t9YzDAbn4l0JsjjRgpB4evVTHpYIC7KHjV1xjuKhBuodfahAorqr3nGii7yb0X/
 TK1Csp0x0Ehe5h+WUtRszmNLmOtb4EQ=
X-Proofpoint-GUID: 0NX0QYQMyHX0d26gpxnhFfAFv_EkaWWp
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5dfc42 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=KhUW88Fx2FSJfNT8J3cA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119

HTM tracing is controlled through hypervisor calls and operates on a
system-scoped target identified by HTM type, node index, chip index,
and core index. When userspace opens a system-wide event such as via
'perf record -a', perf may initialize matching events on multiple CPUs
in parallel.

Without driver-side target tracking, concurrent event initialization for
the same HTM target can race and issue duplicate configure/start flows
for an identical tracing scope. This can lead to conflicts in the
underlying H_HTM operations.

Track reserved HTM targets globally and reject duplicate reservations
for the same target. The reservation is created during
htm_event_init() and released through the event destroy path. This
prevents concurrent duplicate opens while still allowing different HTM
targets to be used simultaneously on different CPUs.

Extend the existing per-event htm_target_id structure with a list node,
and use the stored htm_config in pmu_private for target comparison.

A cpumask-based approach was considered but not used: cpumask restricts
which CPUs an event may be opened on, but HTM operates on a hardware
target (node/chip/core) that is independent of the CPU opening the
event. A user may open an HTM event for a specific node/chip/core target
from any CPU in the system, not just CPUs that belong to that node. A
cpumask would therefore either over-restrict valid opens or require a
per-target mask that mirrors the target list anyway. The approach in
this patch handles the real constraint: the same hardware target cannot
be configured twice, regardless of which CPU does the event open.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V2:
- New patch.  V1 did not protect against concurrent duplicate opens of
  the same HTM target when 'perf record -a' initialises system-wide
  events in parallel on all CPUs.
- Adds a global reserved-targets list.  htm_event_init() rejects any
  open whose (node, chip, core, type) tuple is already reserved; the
  reservation is released through the event destroy path.
- Different targets can still be opened simultaneously on different CPUs.

 arch/powerpc/perf/htm-perf.c | 42 ++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index abecc9bb58dc..01c6bd2104cf 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -77,9 +77,13 @@ struct htm_config {
  * htm_event_start() and htm_event_stop() to make hcall decisions.
  * event->hw.state is kept in sync for the perf core only.
  */
+static LIST_HEAD(htm_active_targets_list);
+static DEFINE_MUTEX(htm_targets_lock);
+
 struct htm_target_id {
 	struct htm_config cfg;
 	int tracing_active;		/* HTM_TRACING_ACTIVE / HTM_TRACING_INACTIVE */
+	struct list_head list;
 };
 
 /* Helper to parse the 28-bit event config into distinct fields */
@@ -154,7 +158,17 @@ static ssize_t htm_return_check(int rc)
 
 static void reset_htm_active(struct perf_event *event)
 {
-	kfree(event->pmu_private);
+	struct htm_target_id *target = event->pmu_private;
+
+	if (!target)
+		return;
+
+	mutex_lock(&htm_targets_lock);
+	if (!list_empty(&target->list))
+		list_del(&target->list);
+	mutex_unlock(&htm_targets_lock);
+
+	kfree(target);
 	event->pmu_private = NULL;
 }
 
@@ -162,6 +176,7 @@ static int htm_event_init(struct perf_event *event)
 {
 	u64 config = event->attr.config;
 	struct htm_config cfg;
+	struct htm_target_id *target, *tmp;
 
 	if (event->attr.inherit)
 		return -EOPNOTSUPP;
@@ -188,11 +203,30 @@ static int htm_event_init(struct perf_event *event)
 	}
 
 	/* Allocate per-event private state; freed via event->destroy */
-	event->pmu_private = kzalloc(sizeof(struct htm_target_id), GFP_KERNEL);
-	if (!event->pmu_private)
+	target = kzalloc(sizeof(*target), GFP_KERNEL);
+	if (!target)
 		return -ENOMEM;
 
-	((struct htm_target_id *)event->pmu_private)->cfg = cfg;
+	target->cfg = cfg;
+	target->tracing_active = HTM_TRACING_INACTIVE;
+	INIT_LIST_HEAD(&target->list);
+
+	mutex_lock(&htm_targets_lock);
+	list_for_each_entry(tmp, &htm_active_targets_list, list) {
+		if (tmp->cfg.htmtype == cfg.htmtype &&
+			tmp->cfg.nodeindex == cfg.nodeindex &&
+			tmp->cfg.nodalchipindex == cfg.nodalchipindex &&
+			tmp->cfg.coreindexonchip == cfg.coreindexonchip) {
+			mutex_unlock(&htm_targets_lock);
+			kfree(target);
+			return -EBUSY;
+		}
+	}
+
+	list_add_tail(&target->list, &htm_active_targets_list);
+	mutex_unlock(&htm_targets_lock);
+
+	event->pmu_private = target;
 	event->destroy = reset_htm_active;
 	return 0;
 }
-- 
2.43.0

