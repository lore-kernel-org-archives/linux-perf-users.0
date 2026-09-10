Received: from mail-m3284.qiye.163.com (mail-m3284.qiye.163.com [220.197.32.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D34BFE60;
	Thu, 10 Sep 2026 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041101; cv=none; b=ibk0UsNQLHpxrCk7laPP9EQpzam6mOil0Q4S7sL4j+6oC9dI+26GDKDgYMJ1CWMmD/LnjPBkyO0KA/gIiAZcrZZ8LKl9BNg/QqA+/orGcUcIN2O7WDD3Gn0pHAR8yYJEZxtX+5M8qbT9uDkn+9s8OPt9QvA/nFuRs1vpOM71dDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041101; c=relaxed/simple;
	bh=IcbK5OnRmor1GXU0aRmXmQZqa3x0nOC2ovckJmKEYz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTqvaiw6gdA3UBduZiLhYkkbqT1hD0tBolW3xGuEFdTLNrrJBrLyY0qMBeruCy7rHnNvudm1BN/upbGnjZ7Yv4Tr91Bn1ql9pbliDQWdF573+Yry1iQ4p6QAbnSujA/iJc3O2lhNf7tXkfVrq9fz0Kjpboqy/C6ep4c7uazUWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com; spf=pass smtp.mailfrom=hj-micro.com; dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b=eCDGr7su; arc=none smtp.client-ip=220.197.32.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hj-micro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hj-micro.com header.i=@hj-micro.com header.b="eCDGr7su"
Received: from localhost.localdomain (unknown [122.224.147.158])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d496048e;
	Thu, 10 Sep 2026 19:46:13 +0800 (GMT+08:00)
From: Shouping Wang <allen.wang@hj-micro.com>
To: robin.murphy@arm.com,
	will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.du@hj-micro.com,
	andy.xu@hj-micro.com,
	allen.wang@hj-micro.com
Subject: [PATCH v2] perf/arm-cmn: Fix wp_dev_sel2 setting for multi-DTM configurations
Date: Thu, 10 Sep 2026 19:46:01 +0800
Message-ID: <20260910114601.165237-1-allen.wang@hj-micro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2fb3bda7-cd64-4dc0-99f8-c0fda8d42cf9@arm.com>
References: <2fb3bda7-cd64-4dc0-99f8-c0fda8d42cf9@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa08b23c9a409d8kunm705001594eab80
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZH0kZVkoaTU5CSB1OSRpLSlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSUlVSUlPVUpPTFVKTkNZV1kWGg8SFR0UWUFZT0tIVU
	JCSU5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=eCDGr7sur2hFENqnVzpUbneaLM6v6XGlzZ9IlGCCuAhQXla7vsuVMdg1br0rpq6NvxqmyunxGvyKK5dpNP9F60rDT6u2UaTXABD4G8IZpYdKNGKvtWQHC/ePus3uc1fPABj6AQJLYjY21+8b1zNw4YLmHJfvaFPPka2k16PqRVw=; c=relaxed/relaxed; s=default; d=hj-micro.com; v=1;
	bh=JtP12fD9RNAVyfG5BtMp8f1T+aWMSPi7iFymj737lEo=;
	h=date:mime-version:subject:message-id:from;

When MXP_MULTIPLE_DTM_EN is TRUE, each DTM will monitor at most
two device ports. In this case, {wp_dev_sel2, wp_dev_sel} will
only use values 2'b00 and 2'b01 per DTM.

Previously the setting allowed values beyond the supported range
per DTM, which could cause each DTM to select invalid ports when
MXP_MULTIPLE_DTM_EN is TRUE.

Fix this by only setting CMN_DTM_WPn_CONFIG_WP_DEV_SEL2 when
!multi_dtm.

Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")
Signed-off-by: Shouping Wang <allen.wang@hj-micro.com>
---

Changes in v2:
- Made the setting of CMN_DTM_WPn_CONFIG_WP_DEV_SEL2 conditional on
  !multi_dtm, instead of clamping with dev %= 2.
- Refactored is_cmn600 to use cmn->part directly.
- Updated the commit message.

Link to v1: https://lore.kernel.org/lkml/20260819105443.668784-1-allen.wang@hj-micro.com/

 drivers/perf/arm-cmn.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 6e5cc4086a9e..7e7590381171 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1393,13 +1393,14 @@ static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
 
 static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
 {
+	struct arm_cmn *cmn = to_cmn(event->pmu);
 	u32 config;
 	u32 dev = CMN_EVENT_WP_DEV_SEL(event);
 	u32 chn = CMN_EVENT_WP_CHN_SEL(event);
 	u32 grp = CMN_EVENT_WP_GRP(event);
 	u32 exc = CMN_EVENT_WP_EXCLUSIVE(event);
 	u32 combine = CMN_EVENT_WP_COMBINE(event);
-	bool is_cmn600 = to_cmn(event->pmu)->part == PART_CMN600;
+	bool is_cmn600 = cmn->part == PART_CMN600;
 
 	/* CMN-600 supports only primary and secondary matching groups */
 	if (is_cmn600)
@@ -1407,8 +1408,11 @@ static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
 
 	config = FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL, dev) |
 		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_CHN_SEL, chn) |
-		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp) |
-		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL2, dev >> 1);
+		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp);
+
+	if (!cmn->multi_dtm)
+		config |= FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL2, dev >> 1);
+
 	if (exc)
 		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_EXCLUSIVE :
 				      CMN_DTM_WPn_CONFIG_WP_EXCLUSIVE;
-- 
2.43.0

