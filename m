Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013059.outbound.protection.outlook.com [40.107.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBD3DD530;
	Fri, 17 Jul 2026 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284405; cv=fail; b=m7PSDbgiSW+h1Z7T3MqdodqTq5iOpDJXPaRa5cl/WUvOtLOKVQrd34bz2qltf1jDuulf0CeyaY8Z/sFkkUheoBiN9X5vBU+4fDbshV6EZikbNR5mjescX3dEMiO9FHo5MSaqCu7BFbZa76TGwrIyE7LZ4qYkAHwM4gfU9HGagVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284405; c=relaxed/simple;
	bh=bTWCCqpOSSff+f9XWZY4L8WUZNpmprQZqCd3DdLO/ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hVb6rtLbetKuJ2cKRISa8stwZADnt6vWWiYXaLHd2nlrCtTq0k8Jqxe5H+fIY8qjOkaqE8QWt9G1Oqcp7lcZ4+g+hwJC9kpnHSbcoBudvx17EZ5eX9t736vQcNYvjT6rNacQpMbERExg3//GX4upzhMq6btVdml1vdjsUuJB5S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XrQ4h+MW; arc=fail smtp.client-ip=40.107.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XrQ4h+MW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4nAhH7E0fJAfUMq/M2lADty3+KYJNvDrLQvBgrMPv7l4pM+W3m/8YQVHrb7VPqQdVMksRc4EgCtndkMQKACrLTDIa3W0jXATjTJc7N1vDOyAfwkBcwWsSnhLHxXu1b4+3OKozwiNycf0pLkM5HM4UIb63LwN00i3Mp+s5OEBActPLYgHonhEkiIk5dbVHC03ug8GxyEYYxEeSLhQ+qiIVMzwvybHrl/0ao13fKKFidUAZ3ixkSpL9KQ62zg/SUZ9+2MD9G2YdLQ7F1X8f8rYT1Bdq5Hra1j168UelaTy2HLuKCZEYkfaITXnhbGbLwhX34j+ybq/+21fhNSJSXKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZJhsxtfXmNDyCOSWmsurPxg1zibYRIvaLD3WuUi1yk=;
 b=FcYX83chG6t9j45hh2X8NQR4kAt3KESgxXk7RSYtuayX2K13pQwDHOwDEo9vrsUFUIzDZn4I1G1ZjwFgu7TFlQ+qFL2gwI9HWiBLwBM2OAzRKfzJ6SFjk55M/z2sRcnx0YQcPtuslTIIqF4gJLGgWAzw3df5ovOZv8//+RYJ4HZRbf5snVtZqB76c+brEkHj4I69zldgFHTBfXEF/YdSM/MpCEZlTdKNMDdf77Gu3dxrKfHt7AHjq/NiKA/fNIoLXpSlJEnjmJSuh2Le0vfDIvnnu2ALcbAUpAxxk8IFAYCTiSNqRsb3tuXTrR+PLd/Nne84/v+QuFwSlgskMq0a3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZJhsxtfXmNDyCOSWmsurPxg1zibYRIvaLD3WuUi1yk=;
 b=XrQ4h+MWoa7QMbIWKqVuKEGQ09yWJYRs82qvr/B9CGVSrVLw3TfxXTc8xR+VYi3kXRpSKBXoupclyaGs7xCt1+BJEiKxYjcE52+y7MnzJdXSzXZ/PyZ9UygVZK3MC63Ad8zHdSRzInnSVm6XtuLwg0yen7WF/MfWfL56a5uclamJ4DxGTQMYDIRyB0WLgyaak1fT2oAa0icNDZP5U7AKrX/QNA0PdocuJ8OVIYeCwp3pHhfHy4UdZLoEybxH0AhEzXUZdttGGZv4Mg+vEKgKxjTo6tuAyYQOdh6S4gRE/sdjWq/6lv6IKkGJV7xXOZvcLBpx0bTOGVKdLHlZInFaBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB5765.apcprd06.prod.outlook.com (2603:1096:101:ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 10:33:17 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 10:33:17 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Yushan Wang <wangyushan12@huawei.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING AND DEBUGGING),
	linux-perf-users@vger.kernel.org (open list:ARM PMU PROFILING AND DEBUGGING),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 3/3] drivers/perf: hisi: Remove redundant dev_err()/dev_err_probe()
Date: Fri, 17 Jul 2026 18:31:19 +0800
Message-Id: <20260717103123.34887-4-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717103123.34887-1-panchuang@vivo.com>
References: <20260717103123.34887-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ed3ca7-5946-4375-bc95-08dee3eed036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|23010399003|56012099006|11063799006|6133799003|10067099003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xeF9FnlfKtkHCQb+JfE5Fy9tP2sy/McUZZxyS2Zfw7th4pElM+h8vpaCKqUlOTCNTE22Bi6pTxyz4ZlFGVYgJQ6+0YwoAGW0pwvyY4MBER4Q6Bti4VNs202Cb4fctN0Lm3ycXGHxTZlbZNnEW/CgJ5n69JJ8djzxR89z/MTGuBK+HTK4VC8mZzFpgj50+4/va7xnT0AtHt4Rv09F5LsXOiir9sYmU2Tt+s2BjC0dxAJ1xzlwgC5KFEopMcL8Nt3GmQ+muuYf4KvOn35C0z5dCtAg2hGCy/QUJxfBqFX7SDJNly0gN18Jqhcj9Wngd7tZ5caNReTpPsSOA1W9s+sywQHrYUNu/mXqQpXKbClqPl1Vuy76djiwt2MjfIHXxpuE20Wzs27zvbnhKtrEgdh7DW1cBgj3ch15tF75Hq4jfWDHe4JOrM59J0kPP/M4x8inXgvtS4zCaPUjaNWPgkDppi6nnvpWULUKpvG3x0n015O2liaXvugvnRGVnHxlcrsRCpJkRfmXkULkPTC8/8VTQqmDIchgJQ+brY+b8l304dul/0DPA/RBMDcquQNp53bBKTsGrKYN6Iu9BPckvpQ82BJM/1DifBZa+nFku7KL4/FbruPYdLNk0nch4+KO4rOzECD51PbtN3u5xQhGxvShiKBCLuEsA9jPRUhia7frJiHhFImsRCzsgbRvgO0qdgAQgISsOIe4ayXlTIXXdMvXExjDAbfBUeSl2P3hl2ka6TU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(23010399003)(56012099006)(11063799006)(6133799003)(10067099003)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bRnL3Y0kAd0z6mvj0Q2ZKRZ2DQJMIxiM/A11QxW3DBdhQ+IBmFYmC6yPs2t+?=
 =?us-ascii?Q?4U3eSck1GDlnNtpePMtiWPLDW5PFju6VqmkWHgNNooRybhelQHP0br1IY26T?=
 =?us-ascii?Q?F0XjO0sHralRzrvIhhpfxdr6B80uYkLrELP7yOND+jbETyzkndExTmSUd8AE?=
 =?us-ascii?Q?wpp0sdUc2RWLLOEoMidgozYn2slILx++D2ez26sWGRxRtMXmB1y4cFdc3Klg?=
 =?us-ascii?Q?xnNzIDRBLw/W36XfJQ0Zv/MojtK5iVMhQ87I+vaQKoezXStXEkhNRMMyiOtc?=
 =?us-ascii?Q?5FZMOuHH4+Yd5eajhGtsmS6/6nUtMP2tpueA+erWzbqnw9D1HOl41upPbx7X?=
 =?us-ascii?Q?hNk3uqPycNq1Xq2H50DNFuJNr8anmvO1uS20jvrcO/Ivy//fTMkSdr+Jclo6?=
 =?us-ascii?Q?AIb8ENf9LIvoqIJ8FfyQhDLP61841voN4F1snXAuAWiUWZXqmrWA1clY+WvP?=
 =?us-ascii?Q?YuD6567z7NnQO6KGicWmKOn48QgAPeP7VSGZ0+15lmNHu8mjGQODSlbyajCn?=
 =?us-ascii?Q?uoBzaRT8m0Sb6AB8f30hDARPacvqZg4Ub5gTSM2ZyujwAifVGXdM2QNQxdYS?=
 =?us-ascii?Q?QDy++wWBISW8PyLqh205cK6npltiSawqwfyoSnnxKFwSD5sRCzJCIC7kUZZJ?=
 =?us-ascii?Q?0sZCwwT7Wa4X3zOPFj+TodXXqNS0ANiLkk6V5an+WmgFqU6qxvzfVMYcSXF4?=
 =?us-ascii?Q?tMh3YuQVtUNxBFNrezoOVQhQHQKlXfxhqSodt/JK53x0yuxlP9jyY7CXnwM5?=
 =?us-ascii?Q?EIQJH5fZKZAcitdn//DbTCAxNbYRI0XLAILqU87V91US7EgFCO45SHSM4JeG?=
 =?us-ascii?Q?PvhzyfwBFrkTxPNrXzkmBW5u5p0GdVls2S5OivtTjJ2LlPDBlbI+w4Il2EHX?=
 =?us-ascii?Q?MHa+/CF0pog1cLzwieWU+MAb0zRSsBzyKmv4zGin5wMS3ANjjxKZMEEARHVb?=
 =?us-ascii?Q?oUJmKMthqA1dTZqOk0XM2qnM7CcYJkE4pl7rCpSeT64pETjf/zh0DD42Kd7x?=
 =?us-ascii?Q?P2ONtxqzx8jHMS1WYc58xO58teaWhOMbV6L0F9LZDMDI6Jt/8YAWj0ygo1R0?=
 =?us-ascii?Q?+YtdxB1xAxm5G1mH+8N7fR7uYBrN6ZIwTWqmX7Puu7V7y9rGgVAwgC0rptGu?=
 =?us-ascii?Q?iEllzjgKiEdxrJP+Twd+Pe8DYie9n7/L6rgo5UQln02Wijq6WS14CtdVL8+c?=
 =?us-ascii?Q?87LLk9uvPS9kw5iIX+/JgnVykkmY7oFQEZsKwnJVGEaUI9lwGgkPbqk0GcBn?=
 =?us-ascii?Q?2ov5xJXYCSbVwV768eeZlerWc2gQX0BOvQ0ST5liDpBIUTOPZjczTTNCqVdx?=
 =?us-ascii?Q?ywwYNtd1sufQUG108cTAcWmxlMztKnL0wRbEckrRi2vno3zs7Cv8wGcvyHkZ?=
 =?us-ascii?Q?uMweRsPYaUFTlB3JT1wKxx6jZJrWGyA7b5rmOitS1+y2YCKeH6wbNqiqKjS+?=
 =?us-ascii?Q?GaTC8hmEVyD1Q+9AnjFnjCzKAey9PzIGb34lB3SsL9k7TaMgnmNQ+G/1nRl6?=
 =?us-ascii?Q?XhLNhbicU9J5uxmoFVbHPkklNcYjUZPfXDevz8QbBQwejr6g2zzecYnEa6XL?=
 =?us-ascii?Q?JOSvObQyFRCip8YeMmo1gofDTXjcXDr5Rfa2IfXzFvCQsGLSDRUyZQLWHbKr?=
 =?us-ascii?Q?sTD8fuUYvS98tK6p2y6rJo5Yd937wjeSC5tqeRITuhQpILgi0JpeyrF4jgYb?=
 =?us-ascii?Q?OYZXw1dPIbm/aeoUCoERSqnhqILbEQlmzD0er2tUcJKw5NhWoPzQNf5Ig6lc?=
 =?us-ascii?Q?r5QOe71vxg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ed3ca7-5946-4375-bc95-08dee3eed036
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 10:33:16.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEcqd/546K0Hnz1RfQI5V2poAZLtn1KPU/XKYo5bAekOagD33fDosrUTVfMDN+/lotIACeDvzItI0PB8ghv95A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5765

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() and dev_err_probe() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c | 3 +--
 drivers/perf/hisilicon/hisi_uncore_pmu.c     | 5 +----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index f963e4f9e552..56a88fb0d3c2 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -604,8 +604,7 @@ static int hisi_l3c_pmu_init_ext(struct hisi_pmu *l3c_pmu, struct platform_devic
 				       IRQF_NOBALANCING | IRQF_NO_THREAD,
 				       irqname, l3c_pmu);
 		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-				"Fail to request EXT IRQ: %d.\n", irq);
+			return ret;
 
 		hisi_l3c_pmu->ext_irq[i] = irq;
 	}
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 0ff2fdf4b3e2..77390d033d08 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -192,11 +192,8 @@ int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
 	ret = devm_request_irq(&pdev->dev, irq, hisi_uncore_pmu_isr,
 			       IRQF_NOBALANCING | IRQF_NO_THREAD,
 			       dev_name(&pdev->dev), hisi_pmu);
-	if (ret < 0) {
-		dev_err(&pdev->dev,
-			"Fail to request IRQ: %d ret: %d.\n", irq, ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	hisi_pmu->irq = irq;
 
-- 
2.34.1

