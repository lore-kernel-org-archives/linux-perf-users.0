Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2049.outbound.protection.outlook.com [40.107.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C94116F0E4;
	Wed, 29 May 2024 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969901; cv=fail; b=UQ6vvSUTFXJh1AEE5iifvfY/6NQx3gyPJvq2cmaWlmjbtLxoauWfq51HUMFMjO4in9S5YsLH38wdkZW/0KqMRpxME8zvDg0FppM6/qpvijYkINKqNZ42svyUeeERunKXo5aizxignjpkSDw0NjfXc2BnmFGoFsMjmnB7lKSqvKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969901; c=relaxed/simple;
	bh=hVkq5jnH5lyoKbHTgAmm+HYAKxoJBVv/N7tg0mCJe44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uDSobDpK/IZUCHQsanp9NqguvRCvaArJjVYEyAa50MN6HH/vaqO06kbTSm4VTb20TwlKpmpPTq77huxLJkIxAgv1YlRONnwhsYIUgpb9LoJ3/b5y4CLxsgamJ5Gr4GD+jjUV9ddGzd4VIMUFQh1ah265ed7HJ4m/MYGy/OnhJtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oG5+nbrv; arc=fail smtp.client-ip=40.107.6.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oG5+nbrv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuQzdlCY0BUQ736QHDiAclMNN+mXg4gcmg9zgvIEjobo1Jn+x/qSBF4LVOE0xcIzpUWML1E6gs9k3N03T0zhSmcSWmjFwQwMDisP0rKUB0URNpgVn8ril97ZsBuVH3JDEE1Vbj2pEkgZvx9mvdzYAYJb5qM/pvb0ooCBlMm8u4eplmoz8pWrXib5Bjp5zidrA5GHtqXl+4bvaLVwWcRuYWmz3VetPvYkUFWs0wlX3uvrjmQWQ7v4F6cUEiS3FvqPOt4TrcmPDgfJzNEqYc5hae3ZY/ms+6EVncSsPZVGPrSl/sbYAf+s2s4/woDYDlxjuDuckDfsWhpIXeDPxaaoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HlNRVi51ytSJRRbUx2kPMORXnn0TepzkzMmj4A9uO0=;
 b=XP4IAhIQCuhhrlPfmYyjKmIOtPWtTyDIDvzBFJqrZxj9jvkcikSTvtBuY/mK+nMCNZWOUelf27udfM2BR6WDY0uT35Buea3G+vURY7NucMfsRGYndcWzwa1BLa+ognU7GbRkNMhgjNx25G+YBXp6PmkFwZ+GlHdWgnFhC9GuHLnKVdl9uH4XRjsIHN8Ehw5F2fTgbJwiB3l+caCABHtWjTD8IQySjWnXrugSMihOIp+MBiL8ITku930/JWur0daDuvkJZJR5GtLDyrWVx46CH/140FjmEvy/0S2ZfCjNWaqMPlQkKxbmOoVmqH1osd2yB1y0uva8pLTVEhysBJ4bEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HlNRVi51ytSJRRbUx2kPMORXnn0TepzkzMmj4A9uO0=;
 b=oG5+nbrv7rr5L+SUgwRWRodU5vRCfXGRKNRRrchInOnSTOmDOgzJBKPJlc5vPVRnpqyJuSF3H0SEkn2aztJud88WjP+9ZUJMIMLoHffUnHwnc+bfRBVyFHocfKgA8EYTydUiwf3uQ0BLPUOAVEnPJcSzMxt/JcCZEq96rRoNJPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 08:04:55 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 08:04:55 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v12 4/8] perf: imx_perf: refactor driver for imx93
Date: Wed, 29 May 2024 16:03:54 +0800
Message-Id: <20240529080358.703784-4-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529080358.703784-1-xu.yang_2@nxp.com>
References: <20240529080358.703784-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS1PR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: a98cea31-4945-4aff-915b-08dc7fb606d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?usBuMYScOqhLLInenyT0B1i2fBVNyjXgZd8Cy8iRKw76gw78ywOzr3RPwpV7?=
 =?us-ascii?Q?FXsY8k1k6O3prI25gbSCBthejQ9OU/vjslPakFHONiLFHcFw7BD1bAOk0Xus?=
 =?us-ascii?Q?YGyN03EA+8rVNb+WMq65XkrLDGVTCtXV5QotUh8dUutf85148Mm2Ugqy4wrS?=
 =?us-ascii?Q?WrxuLo0saqDQ2GS4tpd+vKtpzJOvEFJzjcz2a6P15NmpaOkRhyF90WFBxjy4?=
 =?us-ascii?Q?F+xE+TT3y4Pwk8RQTKwDjLr0/5IZ4uUEQoDMqddCGg8Yb8ZaM+tCjGfi3XDo?=
 =?us-ascii?Q?jNK/bN0uUmC1gWiWWof9ZFuYMRtitqrLKV8UxdqCXk8Y/R3D/1EM0B1UnU/J?=
 =?us-ascii?Q?Vh6R5XtYn4mZ46E9zx0p2Hul9XhbO8NV8WSu80SQlQ0a4migPwWa/cl5CDH2?=
 =?us-ascii?Q?KIzvKpSdTvdOTVZB5c1PolONg5tSVgsIRDw1TLKD7rr/oYXXrWpNIfSsg61S?=
 =?us-ascii?Q?flE8JC4WmmaTVFuUOoqS05bJCBeu1AHKa2P97wO6J92ldsgH+cfZO50MpTwE?=
 =?us-ascii?Q?VmNT3WMvVSWAeX1xYhwxQhD1RZDTKChiZb/uX3/S0go0nS0z/MK6v2U8GUAK?=
 =?us-ascii?Q?XLmkECK3nTR3AhhbiR9OFHWox7NqztwZp1G3xyNujXe8ntfzusSFYOigttOX?=
 =?us-ascii?Q?HoPEaa2180btfCKXE1BUbOzB2Kb+dGO8jvsVrxY0sD23vAD6U4EZ/XYb1dLZ?=
 =?us-ascii?Q?R37tawb9T9/H2Kxfeo2hE2cXPz/9DXKoL+OYJbsEdwty+NpovzyaV9Kb4YEx?=
 =?us-ascii?Q?d99/h04LXiLCPQuLVwFheOHgWreEKg6n3AQC+D00hepoN+y6dWgZYAAK9yTg?=
 =?us-ascii?Q?i0jFPyYzVISmL0JksTdOmmI8NABxwzllxF2MZym4lev7NkscUyTm6Fla6vTo?=
 =?us-ascii?Q?f6+4aj8vfO5RCvmBh3xu36B1MY8X6jo3ROrKKcoH44RDpv3GI5z4+0fNEHy9?=
 =?us-ascii?Q?wgHj58mOe+QVnSH/NYxKtWCbEGdayrZ8KMtWlB1N7PTs9IT4Bs1mn5Dir2UO?=
 =?us-ascii?Q?AkEz/M29vLGzxrr7Bf5QndzAdOhE1lK2CXh5KtsynX+nJW2WxYLtiLU6TgZ+?=
 =?us-ascii?Q?5hZM+l+94EW7Ka+az3fFe7iEs/aMU3/rVypjJu6GqGDzwdN0d4by/7jZ4Eh0?=
 =?us-ascii?Q?MGXHYnmeB0uka+PojIgv51ZUq7Y9A7UrMfLdnbfbimABqA1Ocm9U2JQip4yk?=
 =?us-ascii?Q?EfS77sYYvqWOu/Bh1a3bkH5iaP8EHcKHcVmzRZgTFmmJPLpAHbbkmddczuaP?=
 =?us-ascii?Q?xoK/9Y8VU1a1n3AET1SgXUvm5XyC7j5aTN+x/c4xN2PZocTw9DLaLElO00Ny?=
 =?us-ascii?Q?polQYBIrooV6+4tfWcZi6cg1Z9lK9hh2I4gysOEYKgncFHswTjPyJU/OjP3C?=
 =?us-ascii?Q?rw32PLg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CYHZlIST78SpFxAsDamPxd9oCJEM5T+IWe8JTsZ3Dzj01EMFmNf4d4b8NteU?=
 =?us-ascii?Q?qnjkYs5cBpGa7xTfSWgrwY5epzCzHYzcym79tXstK9etccSPsQAukzqo5ORQ?=
 =?us-ascii?Q?RBPoTZEsllGAfShfJpu0JAbbCxbfSN2OuPGcA0nJSpVGsrI0YqG8M/eVaJOR?=
 =?us-ascii?Q?gtKYx4vflcG6D5p7V7tfsE/3tYNt8J73BGQN75twBKbTGD+C/PwzjyiXoH94?=
 =?us-ascii?Q?Obnc5keUCnJSarM/HNpnv4wRj8C8zzOR8GlR/vdbW1QJVvfpmXLQnM83Q8AG?=
 =?us-ascii?Q?viN1TqqxHCBMI1CfswdaakpdcWxXOhQ0WtMn3W5YGBHgh+y+ohdWSKlTMSOy?=
 =?us-ascii?Q?TpystPwKKIsAbRMpxHUQFYV9uDrm2yoELWJ88CCJtKpZ5hm0M2FkJwMbR4NE?=
 =?us-ascii?Q?OKuKn1Z1H86iDEj15Q8pEvvjefeKmJJHb7cXWfsqw+H371yx9bL4SzMA+qfc?=
 =?us-ascii?Q?pizSTEnJG29fLm3BUXzJLdQnkPsaPFmpAR3I3h8UzNlfbA69LCBuVSrQRKll?=
 =?us-ascii?Q?dnWLhrYfNDzk9dzMilCpfZgszUh0d0gpy4uxLRKqKtS9VZfJCfOzYoS2vzvT?=
 =?us-ascii?Q?H/LCYz5xZn/jedCSqyJrytHS+EpfWpJeT2DaUYM3/f8udfKTF4YvuD19CVte?=
 =?us-ascii?Q?z2evk8sh1v2jHOhq03TmpfaD+VR3SulIIyq0szmQoUaxPOWYm2YNVbKCwGLq?=
 =?us-ascii?Q?6KaH2e15mYPkoHx300cF84No7TF4ti3IDa2Paqh0Geg0zD7v6UUg8JerJ0al?=
 =?us-ascii?Q?ZFDUm1zxMu+usdvGgyLJdPXXRIBieKfhmTN6sJCWiLa7Cbn2mZi5aQHV/X+C?=
 =?us-ascii?Q?c0jB0oDzyt+OpmZt9rNwPkOILjfrbTWsTe+bGNWpKcmO8c1UgOSC20dcbsSt?=
 =?us-ascii?Q?r23hjvOOT4ObAGWdIppNTmmzEzcKGw0QO9Xns6dlgCNmm2lb7lXBtnFrrkOq?=
 =?us-ascii?Q?hqadRzjCVca/2uObNwZpGEXe8sp6zWy1OI+5dhWVlSWHn0AhZJL3afaFJQtA?=
 =?us-ascii?Q?dGctzgVBA+iuI+1OY0lP6Jeh6Q668GxRziP68B79dWHx45VVTYYoM8kEln98?=
 =?us-ascii?Q?lk61yMs2gvRiYEWbsLn9L3mDUFz5hgtU1GwgZxXcD8ovF2wfsFfkdOSNo7Nt?=
 =?us-ascii?Q?650+YdzNE3EU5pSA635pMiTKaV9m2l3ZRDRHORKN0KEZsYRCtGr/ChM2FlsL?=
 =?us-ascii?Q?MaW5KD7niWVYCGF5keE/ovPZe+1VSFVcagoTnSGfdUnguWKPvtIeuvzztu3S?=
 =?us-ascii?Q?jZYifOgwIIUu6pCXpFx3Ygq8gSJnC875Ez2WNs19oVdid2/wvKVS8qM47ES7?=
 =?us-ascii?Q?mAQnrZAQqBlNLdgViHOuolJhPMQW5FnbYhDETpdKGpq4SXMGju1MLm76Ae3j?=
 =?us-ascii?Q?eE8m7OQKLP5nPe/5eSTRdwXoDzhZQox7BlCbVGHsZhbFdsHbQEZxXxN24Hbg?=
 =?us-ascii?Q?ltMVSKFChLbz2y2hHG9bUWBsa1G8BP/pEQFoKilDMqYB+SvlHyiqHNUb3oz7?=
 =?us-ascii?Q?emjH36cf/CrHQiqn6unLZ/yx6+d1OihWX32PaZWh5O2HpcpA6IVqI8lDgTWw?=
 =?us-ascii?Q?faaVDnu3W3zTVRGmFxSK9mManZkF0RgHTD+wOgVV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98cea31-4945-4aff-915b-08dc7fb606d2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:04:55.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X95dD1Wz8h+KD8Js+p5RiaXRRD24NheiffC18Y0br+L0zOAy8ovReJ1Mtqywy5L03X68oKkz3paYNmpTDUDWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

This driver is initinally used to support imx93 Soc and now it's time to
add support for imx95 Soc. However, some macro definitions and events are
different on these two Socs. For preparing imx95 supports, this will
refactor driver for imx93.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
Changes in v5:
 - use is_visible to hide unwanted attributes as suggested by Will
Changes in v6:
 - improve imx93_ddr_perf_monitor_config()
Changes in v7:
 - improve imx93_ddr_perf_monitor_config() as suggested by Frank
Changes in v8:
 - adjust is_visable() as suggested by Frank
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
Changes in v11:
 - no changes
Changes in v12:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 106 ++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 38 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 08cb1bfb09de..5433c52a9872 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -11,14 +11,14 @@
 #include <linux/perf_event.h>
 
 /* Performance monitor configuration */
-#define PMCFG1  			0x00
-#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
-#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
-#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
-#define PMCFG1_ID_MASK  		GENMASK(17, 0)
+#define PMCFG1				0x00
+#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
+#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
+#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
+#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
 
-#define PMCFG2  			0x04
-#define PMCFG2_ID			GENMASK(17, 0)
+#define PMCFG2				0x04
+#define MX93_PMCFG2_ID			GENMASK(17, 0)
 
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
@@ -75,6 +75,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.identifier = "imx93",
 };
 
+static inline bool is_imx93(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx93_devtype_data;
+}
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
 	{ /* sentinel */ }
@@ -122,24 +127,37 @@ static const struct attribute_group ddr_perf_cpumask_attr_group = {
 	.attrs = ddr_perf_cpumask_attrs,
 };
 
+struct imx9_pmu_events_attr {
+	struct device_attribute attr;
+	u64 id;
+	const void *devtype_data;
+};
+
 static ssize_t ddr_pmu_event_show(struct device *dev,
 				  struct device_attribute *attr, char *page)
 {
-	struct perf_pmu_events_attr *pmu_attr;
+	struct imx9_pmu_events_attr *pmu_attr;
 
-	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	pmu_attr = container_of(attr, struct imx9_pmu_events_attr, attr);
 	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
 #define COUNTER_OFFSET_IN_EVENT	8
 #define ID(counter, id) ((counter << COUNTER_OFFSET_IN_EVENT) | id)
 
-#define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
-	(&((struct perf_pmu_events_attr[]) {				\
+#define DDR_PMU_EVENT_ATTR_COMM(_name, _id, _data)			\
+	(&((struct imx9_pmu_events_attr[]) {				\
 		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
-		  .id = _id, }						\
+		  .id = _id,						\
+		  .devtype_data = _data, }				\
 	})[0].attr.attr)
 
+#define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
+	DDR_PMU_EVENT_ATTR_COMM(_name, _id, NULL)
+
+#define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)				\
+	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx93_devtype_data)
+
 static struct attribute *ddr_perf_events_attrs[] = {
 	/* counter0 cycles event */
 	IMX9_DDR_PMU_EVENT_ATTR(cycles, 0),
@@ -185,7 +203,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
+	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -197,7 +215,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
+	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -209,7 +227,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
+	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -244,9 +262,29 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	NULL,
 };
 
+static umode_t
+ddr_perf_events_attrs_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int unused)
+{
+	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
+	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
+	struct imx9_pmu_events_attr *eattr;
+
+	eattr = container_of(attr, typeof(*eattr), attr.attr);
+
+	if (!eattr->devtype_data)
+		return attr->mode;
+
+	if (eattr->devtype_data != ddr_pmu->devtype_data)
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group ddr_perf_events_attr_group = {
 	.name = "events",
 	.attrs = ddr_perf_events_attrs,
+	.is_visible = ddr_perf_events_attrs_is_visible,
 };
 
 PMU_FORMAT_ATTR(event, "config:0-7,16-23");
@@ -370,36 +408,28 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
-				    int counter, int axi_id, int axi_mask)
+static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+					  int counter, int axi_id, int axi_mask)
 {
 	u32 pmcfg1, pmcfg2;
+	u32 mask[] = {  MX93_PMCFG1_RD_TRANS_FILT_EN,
+			MX93_PMCFG1_WR_TRANS_FILT_EN,
+			MX93_PMCFG1_RD_BT_FILT_EN };
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
-	if (counter == 2 && event == 73)
-		pmcfg1 |= PMCFG1_RD_TRANS_FILT_EN;
-	else if (counter == 2 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_TRANS_FILT_EN;
-
-	if (counter == 3 && event == 73)
-		pmcfg1 |= PMCFG1_WR_TRANS_FILT_EN;
-	else if (counter == 3 && event != 73)
-		pmcfg1 &= ~PMCFG1_WR_TRANS_FILT_EN;
-
-	if (counter == 4 && event == 73)
-		pmcfg1 |= PMCFG1_RD_BT_FILT_EN;
-	else if (counter == 4 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
+	if (counter >= 2 && counter <= 4)
+		pmcfg1 = event == 73 ? pmcfg1 | mask[counter - 2] :
+				pmcfg1 & ~mask[counter - 2];
 
-	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
-	writel(pmcfg1, pmu->base + PMCFG1);
+	pmcfg1 &= ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
+	pmcfg1 |= FIELD_PREP(MX93_PMCFG1_ID_MASK, axi_mask);
+	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
-	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
-	writel(pmcfg2, pmu->base + PMCFG2);
+	pmcfg2 &= ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
+	pmcfg2 |= FIELD_PREP(MX93_PMCFG2_ID, axi_id);
+	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
 }
 
 static void ddr_perf_event_update(struct perf_event *event)
@@ -515,7 +545,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
-- 
2.34.1

