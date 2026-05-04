Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1B3783CB;
	Mon,  4 May 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901987; cv=none; b=pKQpaUlovs+dzWeCESUe+4M4I1JkfjXyyo42+G9DPZkfoDv+BelHc1s17idC7W1lUsbEK/cQLKD4tKw39W1mRKOtCbhvch4GmxnWx+ZzH+RUqjjwoSwiu+eOIgJP6RaLMURx4gn3aF6xvpYtyU21cPiri+dp+JnG9JlzvYfnVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901987; c=relaxed/simple;
	bh=uKt6xa8IR7FtkbRoSAurvcw808TepNIpFvhgbskHwOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcE9ifs47L+01sAUhirJoGty0oBD9opRnIRDYh/KmOMBIvmxn8+5vCWJS+A38kpLqGuLsvhPg80uS+k42FhTrPL83CP+7x+y4khjn3aExINF7ythbMeD0juebKAtwKDPyeRsyo8woT4RdwZuarEPRGYTYL0brr97tVTz4HhFyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rbi9Deia; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rbi9Deia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777901983; x=1809437983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fNRJYDnePOIcF4F2ZoFB+uADc57hTs5TklnXfgahzhs=;
  b=rbi9DeiaSK8jCMfWA32MLq+ZfpuDclUokD2zgsL6emEpSW0gPGinyLIR
   8q0zOC2s500C1dERxZgFTWQVElqEbxEsersidkOC35jC6D7MCY10dh0XR
   qw94vnTbECZesDlrGRq/D0JSFSwUuGQdtlJaycSgai2s4aAIpQ7ZlwRkh
   A30tuRYB7YXa2hBOd2dFYk61Z7SU6VKMTu8mq6vLnxoPCnLp5VtnuW6SF
   fk5lj/+kcOmW+s/WFzFbdsBrv0RvFkp726CVbloXdvZ5VyyLmaTjugze2
   IjfLYA+A5WqJbrA/msG9eiKkYLqYHHD0lqa1qo68INgaWiDneUE3+yF49
   A==;
X-CSE-ConnectionGUID: VpwhKQgxQs6E7hUtzaK41A==
X-CSE-MsgGUID: G1BeTpFTTBi1xtSzBRkZRg==
X-IronPort-AV: E=Sophos;i="6.23,215,1770595200"; 
   d="scan'208";a="18776025"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 13:39:27 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:2843]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.153:2525] with esmtp (Farcaster)
 id d69adaeb-c0a2-4473-9423-34e4046ac0ae; Mon, 4 May 2026 13:39:27 +0000 (UTC)
X-Farcaster-Flow-ID: d69adaeb-c0a2-4473-9423-34e4046ac0ae
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 4 May 2026 13:39:27 +0000
Received: from dev-dsk-avivb-1b-e28f450e.eu-west-1.amazon.com (10.15.33.9) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 4 May 2026 13:39:25 +0000
From: Aviv Bakal <avivb@amazon.com>
To: <robin.murphy@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zeev@amazon.com>, <blakgeof@amazon.com>
Subject: [PATCH v2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
Date: Mon, 4 May 2026 16:39:23 +0300
Message-ID: <20260504133923.23373-1-avivb@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260503155118.16191-1-avivb@amazon.com>
References: <20260503155118.16191-1-avivb@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Graviton5 uses a customised CMN-S3 implementation where certain
discovery registers report zeroed fields. Add the following workarounds:

 - Introduce a dedicated ACPI HID to identify the Graviton5 CMN variant.
 - Derive the DTC domain from the XP node ID, since the unit info
   register reports it as zero.
 - Set the DTC logical ID from the computed domain ID, since the node
   info register's logical ID field is also zeroed.

Signed-off-by: Aviv Bakal <avivb@amazon.com>
---
v2:
 - Use computed domain ID (xp->dtc) instead of XP logical ID for DTC
   logical ID assignment.

 drivers/perf/arm-cmn.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index f5305c8fdca4..8ee3f8638602 100644
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
@@ -2221,6 +2224,18 @@ static unsigned int arm_cmn_dtc_domain(struct arm_cmn *cmn, void __iomem *xp_reg
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
@@ -2266,6 +2281,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 	u64 reg;
 	int i, j;
 	size_t sz;
+	bool graviton5_workaround = false;
 
 	arm_cmn_init_node_info(cmn, rgn_offset, &cfg);
 	if (cfg.type != CMN_TYPE_CFG)
@@ -2276,6 +2292,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
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
@@ -2365,6 +2388,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 
 		if (cmn->part == PART_CMN600)
 			xp->dtc = -1;
+		else if (graviton5_workaround)
+			xp->dtc = arm_cmn_graviton5_dtc_domain(xp->id);
 		else
 			xp->dtc = arm_cmn_dtc_domain(cmn, xp_region);
 
@@ -2443,6 +2468,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 
 			switch (dn->type) {
 			case CMN_TYPE_DTC:
+				if (graviton5_workaround) {
+					/* Node info logical ID is zeroed; use the domain ID */
+					dn->logid = xp->dtc;
+				}
 				cmn->num_dtcs++;
 				dn++;
 				break;
@@ -2658,6 +2687,7 @@ static const struct acpi_device_id arm_cmn_acpi_match[] = {
 	{ "ARMHC650" },
 	{ "ARMHC700" },
 	{ "ARMHC003" },
+	{ "AMZN0070", PART_GRAVITON5 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, arm_cmn_acpi_match);
-- 
2.47.3

