Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23578297;
	Tue, 24 Sep 2024 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158339; cv=fail; b=NJwtXJyGbS3Vuktxm+QYsSakmaF7k6QZ6MrZzf4jQJOrNyBvG46yaJGJTTbB9mOUCOApepnihxG4QB1YZY4i2PIi/NA7qNcKBVFfeRr5L+LbFvVWSMFlRQSa4uBxzVNof4UDEopqGkHP5nu/ejN/Oy4VIVAeAKdE7fuS+2YXG5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158339; c=relaxed/simple;
	bh=aOypdNejV1POxLfm7vikbXhq/9CGxsWYdP+amGBT86o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n5IfGOyuBBzCix90yoqKl0bi4xLFG09zc7dRW3ooSRyEbRvHS4BKm0RMj646nQTrV4DpCfGGxzuR1JCN3/ncb/CXmbM/knmbX68OuB2+1w5YK5I80lsxmq6VOAr6UuDLGJt3TO+A7PyjyFyzlKse7Q+qUBVu2A8oD2oPzV5kH+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PTTJvnph; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PTTJvnph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cB9Ck1dvUPKvm5Cv5iTSlxR+qdhbmfVcdo4gucnZGSSn9TMRSEcVtLD+579wGrJCmP2mYNcHsgI97BCg61pUMADp/VH3WJv6wBjqwPBlciLT6PpGi3bL+y7dZ1z1BsR0Zl4wAN1ogskvcFlF0V8GcK4e+erdjUcT0y151/yzgBfhPhYF6Rx8DVUa6f3D6VwmMlbVI3ZvXxkXe/qW1uKHmUHOHuiU7cdbS4hJEhkJksW1OdfWYwVY1yOWvhopIuz4+D9J3YeVx7wiAM+QuMgGHkgo/lh0FHMNy9yLIuWYKEmvJPiD+ITuDuVBg9jEQd7Yj7hgoXaMMGhvGrLd2h/MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK3VZ8AZA9nqGBifCQRVaIR3kLDnMTWxZfr7aS3MY9I=;
 b=FBnY/kxqSoPjgmMXsw5FINtCFYu4k86PRZ6sINYeJPIQKPK0hG9ff7EobA99x8S06341+6FMIwQSH3F8BxO/fBvBalu+jYqRT9p1T1a+NRWZdn8GURESk43S6TVz1//y1h0ZGeE0wPg4oGGzcPltrZB67lbHse9kfz2eXuKsM7J1AixGJw9C/KlKFHkZxjVZjUWMXjF1Wkn5ePkfFNfmThwoxKWBC2LAwaOAwNv+I5EkkAiBlsJ9VJgiP8+h/yXWmyl7T4K6gpUYDY1jjSBXW3SQATP3eCcQR4PIW32JFGb2bEo9NNuATev9XBpF78lixvdHruOC3p4amzY54+ci9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK3VZ8AZA9nqGBifCQRVaIR3kLDnMTWxZfr7aS3MY9I=;
 b=PTTJvnphKJxvofZk5ezq/a+xTidD8zRlgTfNWF0WbfOu76JP+6LTwkNApMICEWggSVcyn9INbW00gd/eVvZ9+42RIwXRG9vJZzC7epzWAbb3XxGTGB+ioeYLYNJqE0fyDMzBcP7u/jE16srwohQcTkZczEm4iZ+DYgD9ZwZ5WZ5Hvnu+xC8HEvyDno6Ezb09JRcAEgi2gm22spPSiCBAQcSAZEZucmze1AFI1Xn6pCKKoD3T3Jh2WjumGQsNyKsQ0iiUyjjseH7jSJhvkP0TD0jq+vpDm5176zNv5BxoYlTjL5KGgLblxKcuwQ5jUdL0O5j6XTkEJ08wKO2nGc9n7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 06:12:11 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7918.024; Tue, 24 Sep 2024
 06:12:11 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf vendor events arm64: Add i.MX91 DDR Performance Monitor metrics
Date: Tue, 24 Sep 2024 14:12:51 +0800
Message-Id: <20240924061251.3387850-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924061251.3387850-1-xu.yang_2@nxp.com>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc15725-983a-4fa7-a439-08dcdc5fd34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhK4RcscOSXXGUrTFmfnYQpHftl0RCDQWcnonbtCkuS0yDSto8PzIJnRFnUE?=
 =?us-ascii?Q?4ZVrLHdbjjR3NLvvn0fOXrT/kOOsUNWzquo12riLYTLGZ8i1KawPZPWbnorj?=
 =?us-ascii?Q?zKLwT0ElJOIzxA9G1kP9/WF50R3jqRQddQwOanjI4N3lLstH0Y7Eb80utCdt?=
 =?us-ascii?Q?xX6db+0TwBDokWvyjbRazdPcD/QnWyDUufLcyb5Nl+Y2JsVSYupK0nnYa/0D?=
 =?us-ascii?Q?sWpPytkPT4SW2OUDMGojiiN2qh7tL3lL3GLdtooBxF3Pm1KVaGvV3nXPmAbe?=
 =?us-ascii?Q?s/TdDFaMMR2kkiFmGO3ms4igC2wB6M4cCYiSEVdpFrRjsBpYmidd6NcFsSdB?=
 =?us-ascii?Q?u9Pz8ZCJoUtQi9Zv+DvXBJMJwmjIQ3ra/c6NTE9rBOktfAHSxnLyDimFHhoU?=
 =?us-ascii?Q?oO75rLVlR6lDj6Vg6ueDWaYQK2TaD7lhq2dqxbkyQKa8FAhSHRBvhu7v575u?=
 =?us-ascii?Q?MrWw7JoQ/guU6z4oI4fu8aL58OUEJk1qgbLBZsHiwL6iqCG2X4fkURN+oAwQ?=
 =?us-ascii?Q?M73gD9eR4lXKeBccfynGAeb+TF0+q/qMq+9hTHVJoboc/Ih/GWlPAAbetgQV?=
 =?us-ascii?Q?pKIQa18DBSGgghDr409wofk7ZvLlqxq7BOiISz4PYUHuX2DpGUe7pSQJ1UjX?=
 =?us-ascii?Q?PUh7lBgcJx1brHHFDRI+utrAE8ilYik4tThvy7ULyo4O60D54YL61+YK5t5S?=
 =?us-ascii?Q?3VL18M26sfkhkWGh+16iZLbZXHi9jIA4jZeAvV2NlTVOV3xBxKKnOIOHW0mC?=
 =?us-ascii?Q?5FeN9EML7R0oXOaNXW+wfS9vLQLkpA6sJ81e5nolglmbSvW7JRb+4u0oLwOd?=
 =?us-ascii?Q?85o2tYCsiZi0Bc6509vrPCvynl0Wc+Kbpt4COhrL90LyzR/3BilvwiZOvGAW?=
 =?us-ascii?Q?XrpijTYpnAzYM5np/AyBrKVihALpzGZjhVgBXJXSNrwtKaNXVeoxVQdY2K3O?=
 =?us-ascii?Q?dgF6+6id3zJTBocS/M2e8tB7AywdnER7DezZ4iO5Xfxwx6bIlNzuM0n3AG3F?=
 =?us-ascii?Q?jXOC9qlU3G99eCvp93r7Z+Z+lyXgrZI4wx30ndrW29zhIMdj6D/f9MkH3R00?=
 =?us-ascii?Q?ec9kJ581Fhx8D7GE6NVY6SNGzjyLxf9/R9TIWsjpmftg5YBTD1DN/P7G+cen?=
 =?us-ascii?Q?9v6/X2tY7h9ftwJqRXnzzerVsDMJ51+rUkz/Dm268Gi91rsGKHJ7IjiWunaQ?=
 =?us-ascii?Q?rArDyI03DxaAR90PkjPQinN2z1t0nptgLsWbl7Z45iD36sfsJ/wNb0gj0hg0?=
 =?us-ascii?Q?WWBUqIrG5+CzZf+KB+llUy3bATpToQ3pQLzlFXanxWWSbVyNDwJzVZvY11EV?=
 =?us-ascii?Q?e/fOG5eeubtlR7FQhayBdntVgfed+rlk+FXjZRJN9B7FjxFOExT5P4kVQKc4?=
 =?us-ascii?Q?ueh1S0ebf5QV5WWNDtwXJBp3Ab9cr6aXPMbAxk/+NPV2UFYLOCVKpOHDgglW?=
 =?us-ascii?Q?KpzpZoZioW8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?icIC4NK34/mmS2HlnvAi+VSJX7aYRSJdQn4pgwsmZT0z5zXXRk1Bpi1VeWtY?=
 =?us-ascii?Q?LHb5TGyREGmHhXwwLMZGOHzb7VMH5ulmytF99/4uMMDzOYcDUou8x3lgPXWh?=
 =?us-ascii?Q?8ih31G/VB5GXiEsyCTF/MBiPqNqxWhi/FPK7vZ6mzS6gWoqX4N7pR9WL3vc1?=
 =?us-ascii?Q?ZpRDTl4Q5Cvjl4Mn34SmYUCYYA8yt8U3+xwv1SAmrHm0YlpFpQuiBs0G2p+A?=
 =?us-ascii?Q?utGrcuUlXLcp5zkJthKI2bvWc5GHf6Y+j8hiVaxq+UU1ZPxjAo+SFAafw+Pm?=
 =?us-ascii?Q?+nw71fBFhvPqanIBKLeGWj7tK+Af6Cwpn1WUcduj0DObuR+enAwKCqLyLDZQ?=
 =?us-ascii?Q?E62t/RWF3GE6xPH+Mv1Rg49WQ/LKxtXGiB/evnlZXA08bN+G8wp5ppf1Bm9A?=
 =?us-ascii?Q?lvRhU6Df67SWpdkNUwjG7tQl0nRbcu0Kqe4mqrRBDgPBqY/dFyAu+16ZGgsQ?=
 =?us-ascii?Q?Ql2WOQXKmlyzk6Nj1649+6SSdZS90d6jAp3gLAq3L+Z+sAx2pyKcVJUo7bxQ?=
 =?us-ascii?Q?LWGD5zMohTLcDPzOr0+RvUR1GOcKxMR+Vc2WDrElMLuvANR2Nn/sX9csUmnY?=
 =?us-ascii?Q?Divh/CrrkQMjX61dcQHPnhOw3RtKXhkrAeMJgRJjtxQlR1qWZp+UCfRVC2mr?=
 =?us-ascii?Q?yOwc5QeFBbQPTXS+GSRHMebAmO+k8oND0cu9i1bEaw/GBuTSHhTSHAv5HA39?=
 =?us-ascii?Q?IowmYPwiYAs3gXplzzgs1s7BxSBN+HsLqcIKlGmHkexU3u1ruFp1ytKaXVWg?=
 =?us-ascii?Q?yu90Onrk06pkfUTAF6dv8ui7SXSwAFpRxXei9xCXSPMfvYH+X0MHa3E8T679?=
 =?us-ascii?Q?+PsbPe4fwEMG4AIsJGK99f2d0MpvYolmOq2/+aqCTsn9yfozWSdCK1p0zQRo?=
 =?us-ascii?Q?zC6TM6P59RJavT8HYpKADFTLZihornd+Mox1cVF7hk0dhCR+SkFHbGqz//zH?=
 =?us-ascii?Q?oLSXYYV987MNWzpviJkbq4wkxD6navxW1D/LpNlHmCI50uqIWrVjTG4Dph2y?=
 =?us-ascii?Q?/ttEgy2qHYtCGZt8hk6ZJHGJ8Efyti8ni/kwfjIdesYUem6yct0N9Y3d6BSm?=
 =?us-ascii?Q?YzEem0SdRXaY8xJZrQmB8G4dZ15oN2j8tqemdJt+MeIgNxugXLc4zHoreMa6?=
 =?us-ascii?Q?qgEVtz1Ktcy5VsKQUwV9XDdkB1n+EgmPN0zLgqPW5+4BEtHvHMe2VfxbBEhU?=
 =?us-ascii?Q?7SP7KVH/9/1i+JUQeuoQAqCBN8oJ9SutGnZm1ee8oieZLoTmIOf4AxvMqPSq?=
 =?us-ascii?Q?E7ylV6vr0zqyT1cmoUsAudQCw+JEkYz76MFBDEA4s8uCZImcTBlL9aeqAFUo?=
 =?us-ascii?Q?MKYv8mgNTR7NndsXgVVzmZBAEuBGB0viguEoa9uLEFkO15tretelyvnZzNKv?=
 =?us-ascii?Q?abetH3vBK3XAFghd/naeSSBfk8BhdLRbPel68HM9Oba2ac4hG7nPGmbU12A+?=
 =?us-ascii?Q?0XfJmPFZPC1s00Bsbb/3GzLx1bds7uSex/mh9C/SNI8mNoPm7bbfAmrEVwtT?=
 =?us-ascii?Q?OLjXdxkk4BNEQKoYfO4UIJxtR8yn8jSGwI74iD0gjw4lD2xgV5yF8A5i0/gP?=
 =?us-ascii?Q?ydK2smQZjMrSGlrDETmb0+DBYsJAhy5hv0UX5vdT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc15725-983a-4fa7-a439-08dcdc5fd34a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:12:11.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7LCvWtDtRt66VOYHpYxhY2WKV2glpO3leSTw+HCNRTfxEjOWehVbL3I/f02B9RzOg6z4xJlBoZ/acL/8i7iAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981

Add JSON metrics for i.MX91 DDR Performance Monitor.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 .../arch/arm64/freescale/imx91/sys/ddrc.json  |  9 +++++++
 .../arm64/freescale/imx91/sys/metrics.json    | 26 +++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
new file mode 100644
index 000000000000..74ac12660a29
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx91_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx91"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
new file mode 100644
index 000000000000..f0c5911eb2d0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
@@ -0,0 +1,26 @@
+[
+   {
+	    "BriefDescription": "bandwidth usage for lpddr4 evk board",
+	    "MetricName": "imx91_bandwidth_usage.lpddr4",
+	    "MetricExpr": "(((( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8 ) + (( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32 )) / duration_time) / (2400 * 1000000 * 2)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx91"
+   },
+   {
+	    "BriefDescription": "bytes all masters read from ddr",
+	    "MetricName": "imx91_ddr_read.all",
+	    "MetricExpr": "( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx91"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr",
+	    "MetricName": "imx91_ddr_write.all",
+	    "MetricExpr": "( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx9_ddr",
+	    "Compat": "imx91"
+   }
+]
-- 
2.34.1

