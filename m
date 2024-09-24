Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6ED2FF
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727147243; cv=fail; b=HmbFHGy/zZP6KVB0rkUqwhqFhvE0NlFl4j0H1BERXgf6TPUuLUePxxXKZEsB/AsxIWJCYGUqYDga/YUDnWMMGiegupZ4IJCkJqJmW/FUlIbWGyc/kkWRey/C1xs2fZYt4OwiISqtSw1oGbljleKYDXANXdReUANPH3Y4M3dBMlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727147243; c=relaxed/simple;
	bh=9QKhKaBhsTI8bcZcytL+tUZb4QlcS/1S+ZYsOP/58Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uHmNs21tVLmpaudeIJOoRjSKw8PRV3A5+drXyUFNdDsExPpI3Dsm3CKklElbD+TClUoJ9fAvw1kc3LVkeW2HAetkcZO7Ug3LVhjoSLxYrKmAopcN3B2f20BUdBGGnlk+Ihq/TtCcCjkHDFISIYI/UhhIlAi3soIFbch9zj2mo8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cXZHvfU2; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cXZHvfU2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=av3HWZji/rHMxqscbL9tzLOdpk+nuL+6UTs7u+mMrUE806xLvKSPIWikvGzruzPSsd1fJg7V4kLr1eskTEOJJlCnvtsssD63ILZdkLu4ILK3PFunhK7WsveTLnZhwRFKvzhoxXO0KunFmz4dLC0Kjnly47Ymq3TLn1Ctf+KFexvcnLTNwfvj27TpP8WolepysbhV3vgPxM4m8Nsj94zxwas7p63nntYWh6pTezZQA+7jmEB99xq4xAfiQ1cszlzIsi3s6KZHbwc5Qtqk/wAlYlgRoUc+mTaasczCA50mR3yoC/xVYUL7ou3lIkY4NDOHtv7vW2ApSFMKqJxjObliaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHStDYWAg5owrt+TtL+gx6i1PEMwQbQHhvdtSp77Z8s=;
 b=Fhj4wcuibfilVZNCtuYeSWzGCpYIiwRgz6s0Rm44Jz0DQqGxvdMbsEgYvt9j+VqNkJnLHjsRRURzsFRwCS3WCaGURkUoF2cgdAHeJJn40DgAuUmaVhxCGIba/sY2TTnwQK466gajOnYAJvHKkAaxB9DMtq29tTL/HQlQCRFDjmj1EbyR8B6zQYggaljuBEjQJj7G8JjX7k1SrOdDh4U9ZUYnbCfHiMI69V3VzzaKS7TWTyqgdGmAbBmsf+CbQ5ySYRt41wBkjCcGjkacc9EUejaDVQHDMYiJeogfDBAyDVaQCpap0Urx9A0CuoOdjZt+332EyuxQxWm0AapxUp99+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHStDYWAg5owrt+TtL+gx6i1PEMwQbQHhvdtSp77Z8s=;
 b=cXZHvfU2JC7y71mO9ka3fRr01TZcx3R0j8gXJh2SzsvFR04kPLWJYKuMX/AD7Z4L7VRYSUe+dtluT74QhoNhtmQR0YaO6lEA16Gc8fQJx+u660g6g3gT6+po/jsvZyWzaxMM0CyOwaeefexff0+W3zqsx5ZB0DMxqW+9bn204yNuXIzLPoSW9IdEM5bDHu19/1WXmKXFt66JzhUNaRndCEz7BuEK7jwyl9SsxS3s42KGRqxdJUm8G6JitDxZCVbtwhQ2WUX1Gz2ocYUdUPwuXFW5anHMZKJOVJKH6pv605A0BoTh+cJs0FX+yjB0hgH8CF/cV0e8caI+AFK3H5OGWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8312.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 03:07:14 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7918.024; Tue, 24 Sep 2024
 03:07:13 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: john.g.garry@oracle.com,
	will@kernel.org,
	james.clark@linaro.org,
	mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] perf vendor events arm64: imx95: add imx95_bandwidth_usage.lpddr4x metric
Date: Tue, 24 Sep 2024 11:08:12 +0800
Message-Id: <20240924030812.3211029-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 465d5a0b-5dac-4722-178e-08dcdc45fcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i98xlpMOBXhgQc4NCng6wHxO3tc60V3ME/In1S7GutOlqTkqJQasFQdhlPHZ?=
 =?us-ascii?Q?JrSRYLgBscPv70UP1dFfzIOSSp8a9yE4LUTwc/0ye1L5BKIb/L/efcETFCUR?=
 =?us-ascii?Q?l8I/FdTTR4zT8/xXQuMLfOsr0e6XlIirXoHT54Rtu2vrmuuYOrmfB4MZZbG3?=
 =?us-ascii?Q?pzkly0J/fKZVGPArlUxlPuG0MhBdBYP0uYdtBBlI5Pr+Kxe+eto3NfmszamT?=
 =?us-ascii?Q?vpUx1O+PEaQaXilb7jGseEpV+xFMc1NLVGQFYCyRG9qaMLsSwG780Su/1lEL?=
 =?us-ascii?Q?caLAxr39UJT9VEtH/Gn5tOgBv5Vuv8SVuNsJVVm9UPyptfXdtnJlFTmdHcSd?=
 =?us-ascii?Q?dU+eUPBEbogVXZuZytAJ7tN+O7BvKhZWzrmAIOCyLdlwntEHFyOYtlbZsjpT?=
 =?us-ascii?Q?4k+bOjlLUyblKMD51imYEj17/F9ccjr1hhpLEQAgCULhLH5geamPznWi9q5m?=
 =?us-ascii?Q?LoE7UxzobWSp6ewo/eoOIH3Uwpj5jnUzN+CXfSpTKJmicb2ZDnqWcztu3yzK?=
 =?us-ascii?Q?IAs7ObWv/9D14VdSSGeoyFsBfDdfuG4zt2rZHmrNbCT/kBwX5s4QTryGrgiW?=
 =?us-ascii?Q?pe6FNv1i4eBc5fOJ0Re2Ud4cwEROdeAMJP2tBY7OSdsyoYB44jPi85SKoz78?=
 =?us-ascii?Q?kW9/1IMtQLYB6J3KM2mqh/qN6vhj77hr9XDCmmxVdgoG1e+TIz4KglVXZtJU?=
 =?us-ascii?Q?fPh77Vd6u3aGwYtWmxlan5uvxgDvuGgWHbcDQ8MQB3AHDLGfjGEisb63ThTC?=
 =?us-ascii?Q?EwnYq66OtI2KO4+3QvsSdUeOUVXwqmMB95gtlPR15hufEzZGE0UI/3Pl7Ouv?=
 =?us-ascii?Q?fRHE6xLpQgFD08AjWz80gHticGWwQPxECTnib20hyktBHmVwgK7MLbt6GTfo?=
 =?us-ascii?Q?D4DgRVc9gvwNOKrJh1IEaSv1wQfp+XFz8LRtGEo8WQ3ioTd5AQZM+4h4quQ2?=
 =?us-ascii?Q?7HHVP697ZY/Ts7w01ZvVmMlLlYxOWQtXuZr4SgtoRONQUoTCfLDVC/GjIc6J?=
 =?us-ascii?Q?mGfOMRqAjvrChZ9ggz0NIPutvBHrA81JYIZuI4o+qPtl81lCqn3prlny9FOC?=
 =?us-ascii?Q?r8/7FoFQQAg0pzgMf5oLvVWKACwcvF332gpUe2alzwGyjUNgXphwEdRJ/TRQ?=
 =?us-ascii?Q?QdXnQ16sKorOiWsMHtRLJTLM5Eg+UWITsp+RHPeJR8VIC65DhvxAEq4CIJyp?=
 =?us-ascii?Q?BbPQNA9mGV0hm7sWN9wCVc17NFxnjmoMyaB486JoKfUBrWfHGcBVPzyH2fPY?=
 =?us-ascii?Q?jnwLDbKTyhQi9Hl4jeLQERyMaEMdB1P/ujO216NH/CCP70IXHHvXtkHwFAEt?=
 =?us-ascii?Q?GXmVbc7x2zMyG7jHRIJcpFVzcZVePcaqDKi01ePdWjrkRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HlErynZAdA/6nSG7G9SAWeXwievQeSoYlwWK9zqHk/I1BeMGVPpRtb0kNioT?=
 =?us-ascii?Q?niULYnQtRLNjCFCeayWn/YamntWzoC0WmAAwFcD18buZ+8cLWPGlsnaaBJqv?=
 =?us-ascii?Q?tixiph9aBOyV3VX/bvf99SQ9Cbb0Zh+xLfU+B3oA+QBi4aBU2q/vqMv2jFkL?=
 =?us-ascii?Q?1FhySnbs8AVqaZnwMmUZFCMN5nOHQnbSD8wEMu3nspjTpQKKYEdWaQ+vNrs9?=
 =?us-ascii?Q?TXyFVppmRsOZr15P60th+SIbMDWAyPB1kVbG7Prxf4vtrHMUVoLiKK4rmeRV?=
 =?us-ascii?Q?rB4VFwqT+1mZ7N1jhB8n+d70xnI/EcU0ucf7cP6wEYG6jLnRzXjvrZcu/PI5?=
 =?us-ascii?Q?q7LUvo6COr+Fhku7QtZmdwBblF5yIWZKLEYSbA/pvuTYwq90Fty4UdRmTV3c?=
 =?us-ascii?Q?j1edd8F7kBGxI9/ZAIpvCTzWG7TxONemUr6UIE14cOsrhFeomVvHVvlBRV4b?=
 =?us-ascii?Q?o6Q6hQrKWkdvK6JvvdAhqhS4YhYGZ46GefZWgx1KQZ8YWX4jxkKqv27Io9GH?=
 =?us-ascii?Q?ExmgoqXTGVoOsORK/uzo5A3Cv+OYtJ+eBYdtajI4t1J0FO1of//XKRBUZdXL?=
 =?us-ascii?Q?P0MGA6M3TkvzZBo8BuP96f8nseWoJuhklQJ74buK3lUSRaTYnpL7SJTuR98Y?=
 =?us-ascii?Q?C8vMdaSW10QVL/3jko2ezQxnyorvDzv1dCWaMHK6dQLhzkbRI1VyHpma6J9r?=
 =?us-ascii?Q?T4DDxuWIBIBsTqJEFLE5tRoDt95JhDn26ZnFcCxIl/frK708cPQ/kRQmITk4?=
 =?us-ascii?Q?ubdeAV8Zv82FR6wf152vbunYJitNMcYLejjMhl7PO7CqlrWSjSv7iG89vluF?=
 =?us-ascii?Q?akI233V7o/NYY+fRx+ZXbMZDbXctUEtiIlGkvPd7NBSe/29PQSZH+owH6+93?=
 =?us-ascii?Q?tp1ImSnnwy0g7UkUYP7DYxNCtHmtBfRUqyYGA0lTkiMYkHGn6/kXtX1C1+hZ?=
 =?us-ascii?Q?871pBYx1gsOOk0Q5a6b+SyHylcKK5F1SgLMSGYkhpzrtq7R81cYhNIie/DbU?=
 =?us-ascii?Q?WcnnTH2tD8ICUpwUZhy33LtWFmlue5SZ9Ku9WZrDdnl4QQmJBqDTcuPG1/3D?=
 =?us-ascii?Q?G6qKeg7JzFZubXDNo2Kvj8XX1xn4Tu15i4NKXoEZaGuvnsmjWhw+YyQFDSsS?=
 =?us-ascii?Q?US7NoRHQLZD+lW8urp9d42YN4pPHKacc0mpwFqb1FBNeEwYNuoHHOAlOsuI8?=
 =?us-ascii?Q?vbBligYRWE74L5mjjVheEPYwpzNyk5YKbkKHI89hVyRptG3imxZ3K5GmrOD2?=
 =?us-ascii?Q?1qP9DWQx5YZ4T+Y9XIv8IFQJyfOiHBUSkERevnkzVdsfCI1+u2swUz0k8ot3?=
 =?us-ascii?Q?YevUlsf9tLoaHtozFGr+18prJAhWWQGbP3LmlOaIPi17n08jfjnoPcIyKXVg?=
 =?us-ascii?Q?I4WsHVIRQU48fpo1ccssZIap84yU3/kfbUUGMCbcXxyzo0psWmL6ZcnHd3SF?=
 =?us-ascii?Q?GAKfdL+2qvmWm2h7mR+Xh1AWANzoXyj0yTUgfIXoCMu6arMu792Aii2qKkoj?=
 =?us-ascii?Q?NbJD+RAvMeVToXYHol5r62WLumxoLsW5lIv8Q3zmA43D3gKInskSA/1OmcCT?=
 =?us-ascii?Q?dyeaY+go5+gA2zt9MTiWnhoX5ZdAqBMYrtgGusPl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 465d5a0b-5dac-4722-178e-08dcdc45fcfb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 03:07:13.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cblJVQlNqLMgIh/NOe1R4ivPSPUXSOTEuxLr5jp31uFugROAP/d9USN1zmxGlqUAtLnl9KlHc1SRtPh/88pxzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8312

Except lpddr5, i.MX95 also support lpddr4x. This will add a metric for
lpddr4x.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 .../arch/arm64/freescale/imx95/sys/metrics.json           | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
index 126ce980f6f2..45a0d51dfb63 100644
--- a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
@@ -7,6 +7,14 @@
 		"Unit": "imx9_ddr",
 		"Compat": "imx95"
 	},
+	{
+		"BriefDescription": "bandwidth usage for lpddr4x evk board",
+		"MetricName": "imx95_bandwidth_usage.lpddr4x",
+		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (4000 * 1000000 * 4)",
+		"ScaleUnit": "1e2%",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
 	{
 		"BriefDescription": "bytes of all masters read from ddr",
 		"MetricName": "imx95_ddr_read.all",
-- 
2.34.1

