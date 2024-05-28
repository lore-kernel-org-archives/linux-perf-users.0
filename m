Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F43073474;
	Tue, 28 May 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883056; cv=fail; b=bpjv8a42wp0mlSBJ09Gdet9pRTXpoG7CUFsfVhmFJvQJYe8FAkqm88hRsVAUbOXxU/Meg2Koeg8MDtFp5UQco9Gu2+9ioCRb252wwCNbgt5irKydojp1Ua6KsnhldzhSgA9oAHxhhtdrgQEq/c8Xf7Rz8yicXNLvugW9OFOeP+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883056; c=relaxed/simple;
	bh=ePIV0mAi2pkeYNNCBajHCnxJgDgHceruypeqgGDo75Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XY4qHo18BUYntM1txjJvydeWZ1AawzEPL/9UN3ZKJkGb2zaDeGOw1kI7OrnC/4f4qWU3N/KuxaF+WtPnw2ohfuLwCKnoMk/zABKTiQsahfY1xkGYI3ST8k3E5mEsnrsQjGQJ7wwdABIOFesfNrQw9/l7SNDIl6lEdtTofud4Yp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZfCytQtr; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZfCytQtr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZO9/f+zCpxxvCxG5rj8LMhV3M7LGRoJDOQtairBo8VoiATCcqGIM+YpDoHstA36uEXcjZl9vFGnDWBSibrpu+fRgBVRoQO+1otNgKckTWHOIV+pJxwZiKpgD4FATKRhZikMQHz75v5aV3nPyxPNzn7ypxtj1KMndEWBG6VvNLvI58NX8NEUydvO8/2z5pSzk+t7NNCGrX2l+4xe3HKLTgVwjhExJfoKSvyIRD/E0BNJdECI57zZFLOsWMro72L69atbd9u8SAxSIXG1HN2abH/zW/PxACJ/z8cpPKOGetnBy7LBZrubZ1QYTExVKtfSGPid9mSWBIpLl6HHM0dQ2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+g7qzMjIuB1QHMtgpqdQ5Ue8boQ3mKkVhHve+pHFwA=;
 b=aamc72Tl5oTrr8lPUlK8qbnpdPuS/ZDPSbscQ/a6Z4/iCwz7lYm3acaO3jvPJDZ6vDzRatMFvlvAeGcw4CnIhCNPpTAoiyMA0liyXxGtIO0QSwCDUYss9JnCdP2Ft5GEmiCJKX64WANmy928x4+0ipZxh5Rpnvh/a6MWxLdM/2PMx6ONmfn/3ci7/nrDwt6sLpqN9SbO1STHBydZybQE//pnkYfgbwKWdK/bYhD2VWrNK8mhXpg+R2MU18GtV0v1my9ZJlH8/tNFn25P7qdoJu/6kk/5kAZwST5Wmi+XKjSpaBoiVXQOaWejieGncUc0l3VUiGEP91MFgUFA3lQbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+g7qzMjIuB1QHMtgpqdQ5Ue8boQ3mKkVhHve+pHFwA=;
 b=ZfCytQtrwXT2ZfArEnCn01bRrfX9SEuhDYdnibzf8zO0c2qI60MD3puGtNbpnA33fWtxDkC9FQ6jQpaniD7QFzFuKGNYIn4cP26MexRI4VMckL32BZUqRZcgEZYr+V6bCmdKxKw1IV9ftrTNMkpBU/yWE0bG8U0+sJ+7zGBVfHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS5PR04MB10019.eurprd04.prod.outlook.com (2603:10a6:20b:67f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:57:31 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:57:31 +0000
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
Subject: [PATCH v11 2/8] perf: imx_perf: add macro definitions for parsing config attr
Date: Wed, 29 May 2024 00:05:17 +0800
Message-Id: <20240528160523.1695953-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528160523.1695953-1-xu.yang_2@nxp.com>
References: <20240528160523.1695953-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS5PR04MB10019:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a20b8b7-22ee-4c5a-dbaf-08dc7eebd3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|7416005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9dEtRMMrlr2QU+1EuNsQDGvuM4a7QCq6mZ1Q2tGZJvMVKd75WlOIlaJXPVhg?=
 =?us-ascii?Q?mzTs9OdUtGlxoydtzTGwkqjR8lsYkZ6LYYEpsMFDrCcu2KGyc3QNZe9r9iI9?=
 =?us-ascii?Q?vDuOGt98nMOG+dPDvrgNuwye6dLnpgPPkOL4KbYidU4gp65LiKD/TUw1sZd8?=
 =?us-ascii?Q?3MVDNsTXFewQ/6oHT/wAbPOscnPicBYh+RGm6MYCRXMI9raYpMuE8gvNFCYR?=
 =?us-ascii?Q?r6E/OPmrlc0r5PMZnT8TxOrgRDVrrmHg42GLwZ1frI2w9wGDLWrSM58Jct7n?=
 =?us-ascii?Q?N1jBh+yftWJQhUiqVIY87bmB8/f59IVIxtkVvRHqzq4fxUxFe5VueQhNT6wg?=
 =?us-ascii?Q?HDs4bX2IWjJnzLeMiHdVoI8tBdfek1PZiQUtKanVFiw/KZnaBs3lfAFo2Xrl?=
 =?us-ascii?Q?bO+w7F55PLaG3pl8ip9YCcr4KsAHL8boGBuf2tpBvfyxjowFkD/03kJYuMIf?=
 =?us-ascii?Q?geEXXjC+Ncwt/UeKB4LA+rYo15G8XeXs7AmOKvs4g6FeK9RjyrDnRnLlJQjJ?=
 =?us-ascii?Q?9TbXMZooY1C32DwszhUX3rGP4+RsDtaYFDB+KOh8HgjHzPrmhNkrU3j73pXj?=
 =?us-ascii?Q?91rjk5upp5Re3JHbsq/IRUzESqZqQTSZBnXnoHV0LfmB/WwBXG3s9AeyZXYE?=
 =?us-ascii?Q?KK80MTZEJ92BdBgiNLdZ5/gMKR6HWgPhcqn8qyqIqQ7svM5kjAE36trbq2Ea?=
 =?us-ascii?Q?Ou4yaFdjMTkabun5YOB1OHMX87ixZ7jacYU4DAiHT5J34ryKeFUapViMU6/t?=
 =?us-ascii?Q?e8bbzp4e1y3BZezwO2LXPf/gbdcIIP5zPEpctVkXMM6yBJlEbJ8Mpf3t7mmv?=
 =?us-ascii?Q?WuXurTHm7tMFt3MgWKuPHTsY4bJxkwHpEhmVgvVklrVy0Tcx9SBSba+iSz2i?=
 =?us-ascii?Q?SAWzKqpcSfE+g67cSiwHJ/T985okyzjnX48qiFPIEYfbyjyhFBgZ5SbD0Rt4?=
 =?us-ascii?Q?hSMjgctRGlNAB1f4LFrsQV6olFf144yhFw5VFDALjfVev22nnYWlLNF+K2WB?=
 =?us-ascii?Q?sMdTJOl23N7jdUqelm3e6DokDlAXhjq3hHC5eXkb5JMUX2DNEDZHNsMtUXUz?=
 =?us-ascii?Q?YiKS81Ukopavg3dHzSe/0anF+HQJVg/g/sZ/wH5GTeqaMyZvczaVCu15YuMs?=
 =?us-ascii?Q?S7CwUc9dHk93l4H0wQQTFvrVARi6xkG6RPTfXYKq6MUpmIl1DNmYkgrq0amd?=
 =?us-ascii?Q?+l5IychMTjRuu9dw62xMIgQ83ryr2K28+6G7YJ2nLAeHpErSW3302L0yzyWf?=
 =?us-ascii?Q?Q7ljacPDZTkseUORu2XjZJ27cHDyvz2a3htdL0xF+L/LmDw9+plHXUu1LScb?=
 =?us-ascii?Q?d/TMXeRw/cFw9meBF9tVAtTUbo+JQe9iWvjNDM/yEl2fL/vWlr962IbbhRgX?=
 =?us-ascii?Q?r1kynSw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bx6s5Btxxn0dCzFrfIgSLeFM4BZyVfbyVk4BvaK0JVXjLXvXa0/00MFwXhEc?=
 =?us-ascii?Q?0vyUuDfe46VDX/aErzydtEMpjKJ+QPERDiaFkhJx1zIrd2KBUAKK37iB2cbo?=
 =?us-ascii?Q?XsL4aMrIOrDX43muN4jBa+aU0AQUMcaogl78a+e+CboUHyKNaxYhcGhxQ9o7?=
 =?us-ascii?Q?kZXkCTX8haDOfLn4jTwLQpThdaE6uP0zXvZJ+MVA2o8DT017uaEdtFjxLJh9?=
 =?us-ascii?Q?gPEctBpSsOKIVVo4t3KTWLp1K1VF6SVeEASTrw6rtSQMUbf+G1/xu/DZgIHp?=
 =?us-ascii?Q?zqgTGnlvn4YRgqnHhvmZaVGFO+1u3TPvYu3u5AWVhBrLng9elmfjFcaeXojV?=
 =?us-ascii?Q?HucwmgX9fn7/iIxdMkYKHf7gQ19bybVbzvb/xbS7luEE/HxksRzlsu2MTpyl?=
 =?us-ascii?Q?erDuQvWGElXBWJrtG1a41q+OhdyXxxy4d+xmKkimAe6bcwc4LZBva8GbwjWQ?=
 =?us-ascii?Q?QK6AerSXvqDH/DszXBcmLK60I4O09nXx6sdUnCppL9tZYAxgxNirUnEJGPOs?=
 =?us-ascii?Q?r+gpW+HBO6XwmKbCW6ph9Nik0XmCDxbzYE7CNVqKlX20kT6DJprokLQuSTP+?=
 =?us-ascii?Q?zxmTUdhmwGLb1uSP+buIOooYTPoBlZTBlMfNhGJQq7+ZOkXRvb5NsorXeVGv?=
 =?us-ascii?Q?QVtlePE1BKvm1WylYp1zy+upPA0/1hJfUudVgujFz5r71VSDdD5vmy3/1mhr?=
 =?us-ascii?Q?dw9BExqU6I/QTYYxNkOGaiLymF8DdDZhtgcA7T47EqkhLThUo6SqWoW02Z6N?=
 =?us-ascii?Q?qme0rxCnHqPoKx2ng8mqN+KxHdhXo6LnXS9Adon1L/RXBjMfv9vPLjaFuKVf?=
 =?us-ascii?Q?JvZrwPgkPi6TmIHKs9m9AONn45p8/Dr6ctTKUYTBrUCzPMhcRnDEgorx2O/5?=
 =?us-ascii?Q?Ny8qRDLX915/n4E579koOXNtoLVRSQb55upGCQ0rCTAi/xtyqfUs9ubNLpv5?=
 =?us-ascii?Q?Hluem2NEWVRCEoTH4Oq/3hhU9SiR6oCfsU5vVCavR/H7xPHy/0oTfRIuXXa0?=
 =?us-ascii?Q?cT/jMM9vyWisIZHXDqYau0cs4Lrmfoh/uSHijsCKrH1LXOPKW+i4ZE5o7kGO?=
 =?us-ascii?Q?jnSgRsEMJ9qA3bGpEirgG/zUSuC3+JuTbDWvDJ8Spr92VnPS/2maCAdKliDp?=
 =?us-ascii?Q?Sxh/KrQPjKEVo7FfG6LhZMJjzAuTcX1pLGtUzbnn1N9p7DNzXLX8cMr/WExx?=
 =?us-ascii?Q?Kc3/YV1Y3gc4aZ2l/Oj5eDpIU+sZvXEjeRj+KrqxpemMpGR0DX9Lua2tLrrW?=
 =?us-ascii?Q?x9a1VjFZhtmlf/IDEfBysgtmVSj/a7odqfGU02EqFLQKlCX7qab5Zx0+gDGC?=
 =?us-ascii?Q?Rtm2dqs/sQyjQ71zwOoi6rdBekEpVektqWHSEtACt+DdqsA5SZi00g/Fu2+5?=
 =?us-ascii?Q?ybW2j3/A3vlBplmB7lW/tPMkeELBvOljcgyO9BiQVZG6Q8lOyCC5U5VTDGdH?=
 =?us-ascii?Q?a9Of55VyJr8UjGQYi8YpJHZ85FAhSms6QrhLQBQaonavCbqlUdgPwFNeiWJ7?=
 =?us-ascii?Q?H3eZl3EkCQD2SrK+JNUK1mDzWZDD4NqPeboP69Ado0yuIsCpvIz3cPxeS279?=
 =?us-ascii?Q?U4uIZjOVn3CKyxnYgW+r7xt6v5KAXysk9YrwS9jx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a20b8b7-22ee-4c5a-dbaf-08dc7eebd3a6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:57:31.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImBzFV7p/fH4L5iBAVNU1ZSLIlpPY0H9My7aWf1ENXGM6BYbXlC4eeCLwWskwDcUl9CzkjaS48yXPuQRxAb8JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10019

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
---
 drivers/perf/fsl_imx9_ddr_perf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 72c2d3074cde..0017f2c9ef91 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -42,6 +42,9 @@
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
 
+#define CONFIG_EVENT		GENMASK(7, 0)
+#define CONFIG_COUNTER		GENMASK(15, 8)
+
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
 #define DDR_PERF_DEV_NAME	"imx9_ddr"
@@ -339,8 +342,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 				    int counter, bool enable)
 {
 	u32 ctrl_a;
+	int event;
 
 	ctrl_a = readl_relaxed(pmu->base + PMLCA(counter));
+	event = FIELD_GET(CONFIG_EVENT, config);
 
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
+	event = FIELD_GET(CONFIG_EVENT, cfg);
+	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -469,7 +474,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg2 = event->attr.config2;
 	int counter;
 
-	counter = (cfg & 0x0000FF00) >> 8;
+	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
 	pmu->events[counter] = event;
 	pmu->active_events++;
-- 
2.34.1

