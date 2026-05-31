Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E732B13C;
	Sun, 31 May 2026 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780225497; cv=none; b=lfcEnfEc0lJWfFpQyK4cEB7ebRt3GRnlbXtqrbBeYHiGmPJgnIubjigfPjiNvs5NnyMacer1zaHAq2V+oCMhRvB6YM8XN6gwnTCAZhMs9jgpky1MYe0J7qIP0A1ETC5d88hMTKdziF72ocepzmNAmUwawVZyEfewFC+mRrHMK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780225497; c=relaxed/simple;
	bh=oCaC6c5CbUa9s/QA1iIE64KWcM1kwZErO8a7YIP2pmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSUbUQe7JYrUOFP3Y0YXzpXfkdbsDs9P1qB7RqOW/DJ/fEU6DsDkUZPfUY+bPlxW319hUxcMHroyBDvepGVyvADNO+E+esyCVSkpGM9DyMFhGHJFe162LMRMPVTQIMtxWzrMgkuk73Ek81B1XzjJf4tvyZDQYpd7pMsiUEomK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LoNqsCCx; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="LoNqsCCx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780225495; x=1811761495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+9EV4+N9OSTd9oy5C4EYdeYYRZJSTyZIZZaHeEx892Q=;
  b=LoNqsCCxt/E00Bm7ogxM6ASLYrysy9lsT/kw5X3cs9PnCblsnSxCi8Id
   8msL3FMSPLtp0m2EuK3aik3dqjwvlhI5SyD8QZRf5GO6+8YZEmedUk64D
   nWoIyLaPpZmgiNM89/w/ZZ64WZymljh7mYEjEuH25zRncL1TjiM+XUrFK
   Kjp6/B/UxbctVPTsKENy26VqUF19NMkvAz7kObRXVj2rSmM2npL4P871B
   fq0K0lXwf/xI2F89FizmCrQqLIuktPV8HV7zLFt+vjHdKpVc78FOwnlKu
   RiebXav+FPYPXnR6+1kqYIaVFeTeY6IPEoW08o2fcmlfYYdd07kVwmqoR
   w==;
X-CSE-ConnectionGUID: zDCrbvz+RYqHl/czSQDcfw==
X-CSE-MsgGUID: OUlMgk8pQc6ice2v+Wx7bQ==
X-IronPort-AV: E=Sophos;i="6.24,179,1774310400"; 
   d="scan'208";a="20678449"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 11:04:55 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:11253]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.88:2525] with esmtp (Farcaster)
 id 270f8ccc-515e-4118-877c-7f643db1a86a; Sun, 31 May 2026 11:04:55 +0000 (UTC)
X-Farcaster-Flow-ID: 270f8ccc-515e-4118-877c-7f643db1a86a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 31 May 2026 11:04:55 +0000
Received: from dev-dsk-avivb-1b-e28f450e.eu-west-1.amazon.com (10.15.33.9) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 31 May 2026 11:04:53 +0000
From: Aviv Bakal <avivb@amazon.com>
To: <robin.murphy@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<avivb@amazon.com>, <zeev@amazon.com>, <blakgeof@amazon.com>,
	<ilkka@os.amperecomputing.com>
Subject: [PATCH v4 2/2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Date: Sun, 31 May 2026 14:04:47 +0300
Message-ID: <20260531110447.10095-3-avivb@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531110447.10095-1-avivb@amazon.com>
References: <20260524153848.16334-1-avivb@amazon.com>
 <20260531110447.10095-1-avivb@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Graviton5 uses a customised CMN-S3 implementation where certain
discovery registers report zeroed fields. Add the following workarounds:

 - Introduce a dedicated ACPI HID to identify the Graviton5 CMN variant.
 - Derive the DTC domain from the XP node ID, since the unit info
   register reports it as zero.
 - Set the DTC logical ID from the XP's logical ID, since the node info
   register's logical ID field is also zeroed.

Signed-off-by: Aviv Bakal <avivb@amazon.com>
---
 drivers/perf/arm-cmn.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index f1978a53d1c1..3fb71d9a57eb 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -31,7 +31,8 @@
 #define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
 #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
 
-#define CMN_MAX_DIMENSION		12
+/* Some implementations use a mesh larger than the architectural max of 12 */
+#define CMN_MAX_DIMENSION		14
 #define CMN_MAX_XPS			(CMN_MAX_DIMENSION * CMN_MAX_DIMENSION)
 #define CMN_MAX_DTMS			(CMN_MAX_XPS + (CMN_MAX_DIMENSION - 1) * 4)
 
@@ -214,6 +215,8 @@ enum cmn_part {
 	PART_CMN700 = 0x43c,
 	PART_CI700 = 0x43a,
 	PART_CMN_S3 = 0x43e,
+	/* Synthetic part number, overridden to PART_CMN_S3 during discovery */
+	PART_GRAVITON5 = 0xa5,
 };
 
 /* CMN-600 r0px shouldn't exist in silicon, thankfully */
@@ -2250,6 +2253,18 @@ static unsigned int arm_cmn_dtc_domain(struct arm_cmn *cmn, void __iomem *xp_reg
 	return FIELD_GET(CMN_DTM_UNIT_INFO_DTC_DOMAIN, readl_relaxed(xp_region + offset));
 }
 
+static unsigned int arm_cmn_graviton5_dtc_domain(u16 xp_id)
+{
+	unsigned int x = (xp_id >> 7) & 0xf;
+	unsigned int y = (xp_id >> 3) & 0xf;
+
+	/*
+	 * The unit info register reads as zero; derive the DTC domain from
+	 * the XP's mesh coordinates over the 10x14 mesh.
+	 */
+	return (x / 5) + (y / 7) * 2;
+}
+
 static void arm_cmn_init_node_info(struct arm_cmn *cmn, u32 offset, struct arm_cmn_node *node)
 {
 	int level;
@@ -2295,6 +2310,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	u64 reg;
 	int i, j;
 	size_t sz;
+	bool graviton5_workaround = false;
 
 	arm_cmn_init_node_info(cmn, rgn_offset, &cfg);
 	if (cfg.type != CMN_TYPE_CFG)
@@ -2305,6 +2321,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	reg = readq_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_01);
 	part = FIELD_GET(CMN_CFGM_PID0_PART_0, reg);
 	part |= FIELD_GET(CMN_CFGM_PID1_PART_1, reg) << 8;
+
+	/* Graviton5 has a customised CMN-S3 which needs some fixups */
+	if (cmn->part == PART_GRAVITON5) {
+		cmn->part = PART_CMN_S3;
+		graviton5_workaround = true;
+	}
+
 	/* 600AE is close enough that it's not really worth more complexity */
 	if (part == PART_CMN600AE)
 		part = PART_CMN600;
@@ -2394,6 +2417,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 
 		if (cmn->part == PART_CMN600)
 			xp->dtc = -1;
+		else if (graviton5_workaround)
+			xp->dtc = arm_cmn_graviton5_dtc_domain(xp->id);
 		else
 			xp->dtc = arm_cmn_dtc_domain(cmn, xp_region);
 
@@ -2472,6 +2497,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 
 			switch (dn->type) {
 			case CMN_TYPE_DTC:
+				if (graviton5_workaround) {
+					/* Node info logical ID is zeroed; use the XP's */
+					dn->logid = xp->logid;
+				}
 				cmn->num_dtcs++;
 				dn++;
 				break;
@@ -2687,6 +2716,7 @@ static const struct acpi_device_id arm_cmn_acpi_match[] = {
 	{ "ARMHC650" },
 	{ "ARMHC700" },
 	{ "ARMHC003" },
+	{ "AMZN0070", PART_GRAVITON5 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);
-- 
2.47.3

