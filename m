Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEBE16DED3;
	Wed, 29 May 2024 08:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969882; cv=fail; b=Y6i6m2MzJC6KNMC/b7/Pte2nkhgmGzLsUiTxEK9H61Y6y/2RDW8WqiAv36ZqKH6fxzA7vIBzfFRMOjlt5z39tsltcA3u1iUClfg2/HzYR2V463kq4kQlcj1Ca3waXmfWHmStxThztXk8ZUswN0R+fmkFwC0vdocTdwjr5Z1nmBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969882; c=relaxed/simple;
	bh=xrV8CoQE6s+hjKS3mhJJcuLHCI/TVS4gxz0thLNJDZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9hQX5GY8POhruH8ErLpq/LdbO0M69cz31iocfejo4jvtMmCfWRgyOC4YWKK0wJ716GxGFyJICydotPuw0HcAgWTa7FG2kFE+lQIRvVpeBSESuGuHK4P0HlXBl/+Cd4E/rNuD5OVEzJaGqqmEdJ1HARdEDw4eXIwSlQO94CaQcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VQYvyvka; arc=fail smtp.client-ip=40.107.22.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VQYvyvka"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cK6FOwBoHhRT4U1tCmnBdisPst89+qj/uELnIkGtteoiYPW7Yrom0wPYZa37ymUE2tyXwj/m02//2rQ6om6xZndH2LmCIETKwDDmFXl42AGcV1df8T9SCDfnaBNY9PJbj9oYA8zpMNuAHuVNw/LHWvoj4NIHEqQU6BrSWiGTvv3fXjDGrKQvqTAOJEArtIc+jtNEDXXRdpYVO70RsGXkam3x8SLKwDQJo/Na9chLL80eXu3psjpHnoMtJTLo9UkxOLO9lP+rXwVQ9frzj7oktcnICCJMT8tFi03zINLMH007R4ixm9lQcC0J7nAoVqv7op34WtRu3rhe/2sggDg6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgjbABisDP3gRdYq/T7zQX5HLpKMoQ8ELqZNhLllngU=;
 b=FR0XaRmYrLh5QZ050jV/fAI/k6a8htQm+2RmWuSyw4VtuUTl0ooz1crSJ7q+KEudH+Fc7dm/KWyQSVFSFymNJMZDviKipiG7DUAisuLC0lvh1+B3nkbA5r89A8Kiq2NMy4a42KpE//RaTvjiTsO98tRrWRvOY/QpQubv2LS/kW1Jg45mTRN8bDoFvMWmUqPpfKidIsVCflH/Jf2rssBXFJOvpzQJoFExZYwy7VVwBarAxDBK9P0/rwC2MW0EbwURR7+jodwhRLH16Yexf+4Awy9ZnejZD43rFOva0okWZciRn9dFHMZNdRmEdU/nKL0QVJqAlkhUGc+1zcfEiI7w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgjbABisDP3gRdYq/T7zQX5HLpKMoQ8ELqZNhLllngU=;
 b=VQYvyvkaue/ZeyrXPAJuB3Z2dDVsT7uURU3GfKJI2HZQi7MT9m6HbJBYhC3V36BZ9uxrr5yEqnsNly7qXZY5QiyedIVXjvoY6TVdru2rdSvh7ewFWiHroyVS7nPs1ODU6uKFSDDVg4x5pqPfPwN0eH89ZmhhqwNuJju7F2tMmdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 08:04:37 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 08:04:37 +0000
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
Subject: [PATCH v12 2/8] perf: imx_perf: add macro definitions for parsing config attr
Date: Wed, 29 May 2024 16:03:52 +0800
Message-Id: <20240529080358.703784-2-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7f1a1f5-b54d-4f40-c0b1-08dc7fb5fb40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CGxZb05vDTa+3YZw9Zwf6fIc7BXl22TIhH5/3Ji557jZBecngITsYTB4UiLf?=
 =?us-ascii?Q?Nf4kpPG/E41Zbz+xZy3ypcdFuXp7rOY8gMQZ6eyjaLEpnUg0irnX0nowgAfR?=
 =?us-ascii?Q?oLyzP0v1hh2qc5akphKKn4/guU/UNBk1DAxVDqbafigBjMuQ+nurA1NO6sET?=
 =?us-ascii?Q?iGVhi2Gt6OlMxajzZwhKNbZLx7zY7h105GXqG7Cf7fWuNig9fvu6Z3PHDfko?=
 =?us-ascii?Q?NPXzjkXZvxLF8CtYDOsDjsM1yWxf/g2b2ex5zx3MQVfTPXEysIVzZMJ2NFU8?=
 =?us-ascii?Q?YLf+ksA1a1FTAu4d7FshjqwqXzHOJrsdUdEg4XESoNsa7+P9OhyLBHIC8dvc?=
 =?us-ascii?Q?NKJXpTA+bIe9JfupbBzB9cabgtsKMu+Ivm27bi8+9nqY4Kr56wtucaHRFzQ2?=
 =?us-ascii?Q?6NKpPrNHZfmJc8lRgsz3YbqjvIG/nI8u6GtcyIcqplRIOlboxkHr06l8rMaU?=
 =?us-ascii?Q?c+jZISbXRH++IP+GlBRP7TbsRm1BC5V4R861O2q+zQVozmt2BCDmHbwBYwsw?=
 =?us-ascii?Q?eTCw7bK0SoUN+zryOLwgirsARNVG/f0T31n2eIvmtL4TvcAk1pOghnu42age?=
 =?us-ascii?Q?CeSduKvOXjmHz6MAILUpOcBmAHFt0Lo4+O5TDY/j28QlWkpVofI9rlBlNHoU?=
 =?us-ascii?Q?PAtxia7m/LJuBL4LLdLGhf7mM4k7HjEpHFajYmGabcD1/Yo3NtHV+vQAQVrV?=
 =?us-ascii?Q?kfPmrQjw46HFFy9vRSLWLaMAcNEDtQt+egP9z4v2xo5x6Mmtdf3B9enWpB2N?=
 =?us-ascii?Q?rZiE1te3AFOgtz6KiBiKuEOlYJnOwI0nElR2xNiBDS2pPC0w6kOA8gAs6ifL?=
 =?us-ascii?Q?XDcwrlmzY/K2xp28MuTSSIbZLSwp7yKwTzgkNKYXFs+Ckjku7RdS8HaTJHiK?=
 =?us-ascii?Q?MIhLruyLm7+vs3gIhTUhpegkfq/iziYyyzgezph/Hb3XO9/jCyvqh+hQ1ENs?=
 =?us-ascii?Q?C993zwJ6+OSp6BwhWdJw6MvCDR4kEslTzFh9PgaklSUvT7yUyWneFfa2WObj?=
 =?us-ascii?Q?jGCeLZCUjNegLRbbKF5uL9xAoj9UsHSP9BzoOlvGl98NaiofopNiIJNEBPzW?=
 =?us-ascii?Q?bCmTKr6gjyHjKeIAY9jHVxREYsS0Yv6B1prPB/xggsVkRX++f2dwyTiTtFsI?=
 =?us-ascii?Q?b96svpXv1dP8kueOPyGaJTPaENVaQ3erlN5hxCFPRnchTpcLXVQ3kZoBn6qT?=
 =?us-ascii?Q?fLydyen6zjElWF7RBdiBXceWNJoNtNwwifh+ouREPzeNsncSpgaHdzB+HoqE?=
 =?us-ascii?Q?68W8gPgbJZF2vs9LmSyRj63TDnsdZmKuvmJ28FpA+7hjyayUFrJizlgj67Nz?=
 =?us-ascii?Q?PT76g/iq0mT/P96tuHiLApUadATlQJqYQB6RiTKFy7/I5pK6U2y8jPzSfaBN?=
 =?us-ascii?Q?K0XcLuY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9P7BIuxPZ1cKhj/LoLPDxFuPvFIwXU7gnJgFZrLAsfNNtVgZAgKK3Zyq4xz2?=
 =?us-ascii?Q?AvjfGrrZAfoovgGl3MCzpXtMm6Y7HtPqp8lxtTZYysdHxyZNAaVlf/MIWDXU?=
 =?us-ascii?Q?F6DVKKT5xVLTibqVL8JQa/RFasog2buZzYimtOKUA39V0dhlABwOUvFz4L5Y?=
 =?us-ascii?Q?YbPJsy/u9j+cpc/vfDXofAP3KVLcqZtxm3jZQYMw+cvgrU6kFoy8EVWHXgsK?=
 =?us-ascii?Q?lJHx3YQzHZcGxvPMLaDddNtpy4xT8clMrwGvbbq6/sGqYMjygFCw+RpO01hy?=
 =?us-ascii?Q?4Cq+hHgcuN2YEGN5MdlbyI+Rw4bhkj/hisN6OUFBdGU82BTpBUaBpBRHqk76?=
 =?us-ascii?Q?kQBM1LnWeHDb+dpwcYxegCX31c+zBu/NgZGR4OVqeWBDTRsuxM8xmDiIp3Ce?=
 =?us-ascii?Q?/09oMD+N+bfqMr1tgMWwY4LKaph+YDY44E/2sOYgte4+vfFgwBNShraWSj/u?=
 =?us-ascii?Q?ogoqzxhzH9lN3zp90hGN8/+7iM9NbRWNlz6qW0d/pLw3+zFYQD7g1SUDj4ng?=
 =?us-ascii?Q?1Q+R8Gx3e8x03HCqKHfwZL/8dxl2WaZqcI13tpG8xcV4dWFZ/m0rUokIVWjB?=
 =?us-ascii?Q?DKtohtcW4gqkfiMbNNPsNUEXSHm/MZlyXg+T/2sRnIG1yRJ1tvwAIixY7Kjz?=
 =?us-ascii?Q?rjcDQ15uxjhc+IXpw1NU4tlup/Vvym2VWiH2NU0m2esHY50geksWwlL6M+Wm?=
 =?us-ascii?Q?jmNO2w4X1N2WlmTzJq/+NKUkv02WXUovC8OrQSjoeG5NtWAy6ee3Y+dQiEzr?=
 =?us-ascii?Q?kJ0rTwuHF6rnpvJPEB3Dq8WGtXDrnTzI3t5VTm688D5oCcYMuU6BRFp0GTu7?=
 =?us-ascii?Q?Au2TzPRJqc331hI3Nq8hcbqKiL1KDExmwpxFpGy1CbHlveijzimaTBpw39to?=
 =?us-ascii?Q?q0KjN+iWf0Dwvo7phKQJQwycFKKoe5HPMVoDWpWFYAUloTq9bn/1mM6Yq2zp?=
 =?us-ascii?Q?RqpQpdKJAa8P+eyr95Y2Pj7n5kSs/nRvJutsnGiG3leLOxNwdmjigsgGkruY?=
 =?us-ascii?Q?L27kqbotV2Ea8/QSt4OmFfOVDgk37hnVIiN00ke8/HpanTomuntCs0eji+2V?=
 =?us-ascii?Q?Q4Kw0XLekiFkjQT7eVayzPVDtSTgSPfw8ASc9hOmzOGN9PHoMuhzyPvsmNwC?=
 =?us-ascii?Q?rrmAh+AZIkhF9NyT/ARWbsZvqNZmweROWsf3KEWe72pnqRQfjqKRq8juCXHE?=
 =?us-ascii?Q?sycHQpd62GtqUvbtGplTG6xWXF5r4lNEpqxkVSVO+OpOB/O0IIw+A/EIsoJx?=
 =?us-ascii?Q?J62RwSR1+VEbTTwROnJ8LMDm1V5/otc4E0VNWlghH46VGe1woKgUET5LL62L?=
 =?us-ascii?Q?yW6bQmwZtMqYVjEhrRfEnpTx2nu4aAVk+biO79WzkRuhxAKZcI2B+zsMHHto?=
 =?us-ascii?Q?mse51ZTMuV8w1Ay24/dEO4jcVA4Dm8dMY896fOeIoS4HSyi/UWm+o9GETaAd?=
 =?us-ascii?Q?X1i7lC2JbtbG6d/0e6YiS1apY2ZIH9Lq0v2Zv5VuiFOlZsdtx5O30jLChTqg?=
 =?us-ascii?Q?PL1wNv0r2RvkD+OerhRFTv27CxyzlNbVmuX610cDjbtJ3Kp+2Q5Cr/rELXfD?=
 =?us-ascii?Q?VFqPfqMnJfMNDBH3oc1ZbICerVikys6WOw/g6dDp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f1a1f5-b54d-4f40-c0b1-08dc7fb5fb40
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:04:37.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyTLCKZ7PhtsUEkA7TjIcjs1pBMleTuR3LodWfxLlH3skuTiC2Rsg1Czuly0619dA26cZmP3insWKTLzLWr1qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

The user can set event and counter in cmdline and the driver need to parse
it using 'config' attr value. This will add macro definitions to avoid
hard-code in driver.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
Changes in v5:
 - move this patch earlier
Changes in v6:
 - no changes
Changes in v7:
 - use FIELD_*
Changes in v8:
 - add Rb tag
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
Changes in v11:
 - no changes
Changes in v12:
 - rename CONFIG_EVENT/COUNTER to avoid conflict from Kbuild CONFIG_COUNTER
---
 drivers/perf/fsl_imx9_ddr_perf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 72c2d3074cde..c4caeab7a9be 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -42,6 +42,9 @@
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
 
+#define CONFIG_EVENT_MASK	GENMASK(7, 0)
+#define CONFIG_COUNTER_MASK	GENMASK(15, 8)
+
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
 #define DDR_PERF_DEV_NAME	"imx9_ddr"
@@ -339,8 +342,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 				    int counter, bool enable)
 {
 	u32 ctrl_a;
+	int event;
 
 	ctrl_a = readl_relaxed(pmu->base + PMLCA(counter));
+	event = FIELD_GET(CONFIG_EVENT_MASK, config);
 
 	if (enable) {
 		ctrl_a |= PMLCA_FC;
@@ -352,7 +357,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 		ctrl_a &= ~PMLCA_FC;
 		ctrl_a |= PMLCA_CE;
 		ctrl_a &= ~FIELD_PREP(PMLCA_EVENT, 0x7F);
-		ctrl_a |= FIELD_PREP(PMLCA_EVENT, (config & 0x000000FF));
+		ctrl_a |= FIELD_PREP(PMLCA_EVENT, event);
 		writel(ctrl_a, pmu->base + PMLCA(counter));
 	} else {
 		/* Freeze counter. */
@@ -366,8 +371,8 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
 
-	event = cfg & 0x000000FF;
-	counter = (cfg & 0x0000FF00) >> 8;
+	event = FIELD_GET(CONFIG_EVENT_MASK, cfg);
+	counter = FIELD_GET(CONFIG_COUNTER_MASK, cfg);
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -469,7 +474,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg2 = event->attr.config2;
 	int counter;
 
-	counter = (cfg & 0x0000FF00) >> 8;
+	counter = FIELD_GET(CONFIG_COUNTER_MASK, cfg);
 
 	pmu->events[counter] = event;
 	pmu->active_events++;
-- 
2.34.1

