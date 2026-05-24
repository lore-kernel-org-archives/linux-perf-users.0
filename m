Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238023A7D63;
	Sun, 24 May 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637148; cv=none; b=Gu8UmARN32mephA7dZD1AvIjUPyFuYi/pBDrJP3JnX24GHgJhxuIYJgWh6EKM0DPiczzus8KkmKaCwdPlA+vOIe3yiyEDHUpRTPpMoW9oji4UWFX2DeC8zMTdWxA4IiU9YhB3TnudVe8vjfVduvflEHJSMIOUIaY8Uu0EQkUKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637148; c=relaxed/simple;
	bh=kAPGHy8GRzJx5oNTSIDqbgV/Gu9LbAADVjkEK/TyySQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgZ22tYmNzfXh68vIJaI6YdgWexMRR1n/D5Sl3u49sqMUwLniGySe0BUOlGAQh/ixUYHOo7XEjdHP1sUn7/+SJ+e/pjh8moaTp2zmf2BoCKKJCxCZUMjZKMWDSddKG9ckni9t2PV2OtdljfDR+McYbSG/uLP5yGXXsRCkl1f1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=CBkULvrq; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="CBkULvrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779637147; x=1811173147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NM1d+x3ZEOkfi/top3uQVI3R3Gs2qSxV34vfqPt1/8E=;
  b=CBkULvrqqmEypJlhPuSa+IASwb0FPpTZ90giqKqn5izMUf3PKi1jgfpr
   bZBSBvuMKLvtodK3/RdMKcjzs89QgPYiXgvMVnz6YW9g9z6aT1o4ebKFk
   Xw7Stzl5KFgq3B8Af6hBzCpNUn6pK8k8QWiOz2TDQ4IJ+FjKhItDWZhRb
   ZEYU1FhxNKgpZk2+vZHOBMlTlHQWItVvk2Cz4Y1hAUU8UHaYejZnTrRXC
   NIDxW2XnCkT1ejAuGgirMSesS09eMByM8lQ9VjeaV3nFEtXuZPHG/NzW5
   3v3MNHPwzWtc4lW0eSj6xpp4m7z5M5RP64549FVetxgizU0pg/UI7Ej9g
   A==;
X-CSE-ConnectionGUID: 1M/LgooGTmWRFVaRNORNQw==
X-CSE-MsgGUID: OhByuXCaT3qYp/2APDOchg==
X-IronPort-AV: E=Sophos;i="6.24,166,1774310400"; 
   d="scan'208";a="20184346"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 15:39:04 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:6170]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.249:2525] with esmtp (Farcaster)
 id a00ae900-5922-41c7-bf0c-abb183f9615f; Sun, 24 May 2026 15:39:03 +0000 (UTC)
X-Farcaster-Flow-ID: a00ae900-5922-41c7-bf0c-abb183f9615f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 24 May 2026 15:39:02 +0000
Received: from dev-dsk-avivb-1b-e28f450e.eu-west-1.amazon.com (10.15.33.9) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 24 May 2026 15:39:00 +0000
From: Aviv Bakal <avivb@amazon.com>
To: <robin.murphy@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<avivb@amazon.com>, <zeev@amazon.com>, <blakgeof@amazon.com>
Subject: [PATCH v3 1/2] perf/arm-cmn: Move struct arm_cmn_hw_event into struct hw_perf_event
Date: Sun, 24 May 2026 18:38:47 +0300
Message-ID: <20260524153848.16334-2-avivb@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524153848.16334-1-avivb@amazon.com>
References: <20260504133923.23373-1-avivb@amazon.com>
 <20260524153848.16334-1-avivb@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In order to increase CMN_MAX_DIMENSION beyond 12 (required for meshes
larger than 12x12, such as Graviton5), the arm_cmn_hw_event struct must
grow. Since it is overlaid on the beginning of hw_perf_event via an
unsafe cast, increasing its size would violate the static_assert that
guards against overflowing into the 'target' field.

Resolve this by moving struct arm_cmn_hw_event into the hw_perf_event
union as a proper named member, eliminating the cast in to_cmn_hw() and
making the size reservation explicit. Set CMN_MAX_DIMENSION to 14 to
accommodate larger mesh topologies.

Signed-off-by: Aviv Bakal <avivb@amazon.com>
---
 drivers/perf/arm-cmn.c     | 26 +-------------------------
 include/linux/perf_event.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index f5305c8fdca4..3443b819afed 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -31,13 +31,8 @@
 #define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
 #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
 
-#define CMN_MAX_DIMENSION		12
-#define CMN_MAX_XPS			(CMN_MAX_DIMENSION * CMN_MAX_DIMENSION)
 #define CMN_MAX_DTMS			(CMN_MAX_XPS + (CMN_MAX_DIMENSION - 1) * 4)
 
-/* Currently XPs are the node type we can have most of; others top out at 128 */
-#define CMN_MAX_NODES_PER_EVENT		CMN_MAX_XPS
-
 /* The CFG node has various info besides the discovery tree */
 #define CMN_CFGM_PERIPH_ID_01		0x0008
 #define CMN_CFGM_PID0_PART_0		GENMASK_ULL(7, 0)
@@ -148,7 +143,6 @@
 #define CMN_DT_PMSRR_SS_REQ		BIT(0)
 
 #define CMN_DT_NUM_COUNTERS		8
-#define CMN_MAX_DTCS			4
 
 /*
  * Even in the worst case a DTC counter can't wrap in fewer than 2^42 cycles,
@@ -595,24 +589,6 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id)
 static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
 #endif
 
-struct arm_cmn_hw_event {
-	struct arm_cmn_node *dn;
-	u64 dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
-	s8 dtc_idx[CMN_MAX_DTCS];
-	u8 num_dns;
-	u8 dtm_offset;
-
-	/*
-	 * WP config registers are divided to UP and DOWN events. We need to
-	 * keep to track only one of them.
-	 */
-	DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
-
-	bool wide_sel;
-	enum cmn_filter_select filter_sel;
-};
-static_assert(sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event, target));
-
 #define for_each_hw_dn(hw, dn, i) \
 	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
 
@@ -622,7 +598,7 @@ static_assert(sizeof(struct arm_cmn_hw_event) <= offsetof(struct hw_perf_event,
 
 static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
 {
-	return (struct arm_cmn_hw_event *)&event->hw;
+	return &event->hw.cmn;
 }
 
 static void arm_cmn_set_index(u64 x[], unsigned int pos, unsigned int val)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..c38576a8e338 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -119,6 +119,7 @@ struct perf_branch_stack {
 };
 
 struct task_struct;
+struct arm_cmn_node;
 
 /*
  * extra PMU register associated with an event
@@ -200,6 +201,27 @@ struct hw_perf_event {
 			u64	conf;
 			u64	conf1;
 		};
+#ifdef CONFIG_ARM_CMN
+/* Some implementations use a mesh larger than the architectural max of 12 */
+#define CMN_MAX_DIMENSION		14
+#define CMN_MAX_XPS			(CMN_MAX_DIMENSION * CMN_MAX_DIMENSION)
+#define CMN_MAX_NODES_PER_EVENT		CMN_MAX_XPS
+#define CMN_MAX_DTCS			4
+		struct arm_cmn_hw_event { /* arm_cmn */
+			/*
+			 * CMN PMU event state overlaid on hw_perf_event.
+			 * Must fit before the 'target' field.
+			 */
+			struct arm_cmn_node	*dn;
+			u64			dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
+			s8			dtc_idx[CMN_MAX_DTCS];
+			u8			num_dns;
+			u8			dtm_offset;
+			DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
+			bool			wide_sel;
+			int			filter_sel;
+		} cmn;
+#endif
 	};
 	/*
 	 * If the event is a per task event, this will point to the task in
-- 
2.47.3

