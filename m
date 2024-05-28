Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4573474;
	Tue, 28 May 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883065; cv=fail; b=hOBEfdF1yH9mcImkyFfPqHg/LLOCBInY/ztBFpSoT6mn++70Nym1bzbYp1b7Rr5YtSuK2dOoGTABH9/nu1jtThJE/rDmeXgg0LVNPmn0LpJ6qKI+2cRahrG0srWoZ8D6itQVFfe/m8MLxsTaV0X6j8sfL1HwQuG2f2mvxPXws2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883065; c=relaxed/simple;
	bh=VkDC3MSLpSDLWj08SaKR0Y+tyCvZ04m60F5vwxwDLcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sf3zSuPUuflj1shqZN2S/8v9RCIicxPpVg6XYOpXptL7G62KguhhyrWV+O9V2/2pomso5w1NuiRzu91b9aZ2sbIfP97/nJuMjrMB/OQj8z7HG47gL3bA231tMwTXbT0zd1Yw21DiTOJ4rmQ905LwU/afPP57MoUwRjrxIadpcDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HmsuW96h; arc=fail smtp.client-ip=40.107.6.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HmsuW96h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2lvJxfpoHBVaJDPA0nMcqUSPT+PSk9XzrCbpi8njI9A3832/JNwFMqbtYGPsH7FJXbKPfhSUHV6s8RBS93M4Wd/bDRe9QVh1A8QhIJm7OhMCN5c1+8a8EKMGyaFR5EozXM++LYq3i5qizVhM085dDfiuB24RrvG9meMi3vwtQJZgp8SDfhDXNVOog7x7bum64QXfFKRHfxiUk/KNRjZftTh3/F+6Qsh2g3/9IxEmDd3Ddy3nPcHhfAmKHPZEbb3p0GvgQj0T2qYBwR6rCZ3X2tW0/DfBNYgki9/8gpQEbJ6E9MtW/JOMRkGg3H6aprSFhe1S/6yBUCiqV160nIYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fan9EJZR190lZKx1RpvR+lIMKpX8P8Nm17ib2Sv/Rn4=;
 b=aIxpXiNVxkZ6KO5ELTngYl10pkKQ5WpeXqDVXKCS/CQVsOBwmFe3XIl6PgGUOqn3bYEZHOlopeDWd5IW6nha+Bh8HTFSXm72KUFhGuN7SOEjhcc9G/X4EFScy9fjVKGbrBIGwcRY1rEpRyo0Bvj/4v+bG9SWmTbmR6d38o1dLvSS8PXrtbF0QNCLrZmD4LhXT5O4mjKKjqPfd6niVqI+BAsTRhmbWpSzu9WoSQoIOkUeW3HI3mmhZ6lWCmvHMXZX+Wa3JeDGRwAcKTiaR3RUBYmljxKjyH8zVZnfa68pxg1HwDNzf3qMEqGos4kFuWxRZB7pfdXX85lBOWV1XtAiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fan9EJZR190lZKx1RpvR+lIMKpX8P8Nm17ib2Sv/Rn4=;
 b=HmsuW96hlsOc3CiBePtiK8Hnhyt8qnS3jWjGwhP0PiLwXGWDTqOl8h4v7797gkkzXuQeW+oXXtRPo0H1XSumd+NPbsbqxVCE7gLXJCUldbs/yxRR6515w+U+WZ9iSP1TPi1RCY20SDz8NMGKsR0WJHkHAA/fx8bz91j5XaOfhQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS5PR04MB10019.eurprd04.prod.outlook.com (2603:10a6:20b:67f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 07:57:39 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:57:39 +0000
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
Subject: [PATCH v11 3/8] perf: imx_perf: let the driver manage the counter usage rather the user
Date: Wed, 29 May 2024 00:05:18 +0800
Message-Id: <20240528160523.1695953-3-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9883c74f-e816-4253-9c58-08dc7eebd882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|7416005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MQYalzxcqSvIYyFEY/gMa7XLiTkkshOmW2k2i39WHnmEDFuU0wBm5oE6vJAk?=
 =?us-ascii?Q?zNl6S9uJ2EXRgDvgCqpO9dGI5TE3nzo8H+etSnElCvqZXUl43vlOILnqcS6u?=
 =?us-ascii?Q?EzwMJejOFKjFewcrcJP23OF4E1/r7gr3f0Kn3+OJQYKUDufmrRR6DhzU9D61?=
 =?us-ascii?Q?dQdTbW2wLRReCc6FUOw2BG0YTq6JeaJ0CUFepf9LfRYmcBSxs5snHMOvRFvy?=
 =?us-ascii?Q?ivEIdfP/u9dZ3DGyb1LSu99xZlQfNPG5mdkiGk/64AjnfNuP7S13Zmhs2txl?=
 =?us-ascii?Q?IrxjJoJ8plNudu6nYmNY9uLPA6n/7HpkUTiCZjlM+Ko5rtUbEjz1xp8ZM0v2?=
 =?us-ascii?Q?tqYnfuSO4Wgx6EM8U5nEWN1Ft0v1OlZNbQcwaXA+5Ju+ZVx5Hg/KMm4cTRSv?=
 =?us-ascii?Q?1LKk7EzPWaOB/V1FLc+3OpMYivWmlYR0H+9XHZvrjUqGHHiatph6i1i9R7Rx?=
 =?us-ascii?Q?6Ne77ov86ZJcUxmothpGWaMrmJcg7p4qnvFUD2Kzvtu+Z3U7efMFz1C9ohij?=
 =?us-ascii?Q?Zc+Bu6pMDN+dXUcb8ytE8OZ92hEZzQlVm9wRRsEm2A4gFdwjvbxBhorw0QBB?=
 =?us-ascii?Q?zzu/yDYnUeXk1fPiCW+5FQv1RYvoK7qVwIOi6yeTrSVptY+ms6NeznO7P104?=
 =?us-ascii?Q?qr++kHYM+72dyRp3xT9tayWLGcXZ3gtgCWAUjWVJohX5TKiwQZ6h65yUKQHd?=
 =?us-ascii?Q?eTfEYRzF9KHZlyztJBc4LoIZ0Q82lEZpGs7gsgFot16SU+eU7Zf8YGeFPom8?=
 =?us-ascii?Q?AvED7fUyBz9yI8/9Yqhwwg7frAqagDYIqGLvMcKUEXZjPWA8iIzPmsUdj2yV?=
 =?us-ascii?Q?z+g+1g4KpmHcpyuGboRhWF6jgytIRDWnFKa2SAOqPCWMiKQKXMiaVslyY+4V?=
 =?us-ascii?Q?avjSBRaktLh7t40Vwb0ztHZZ0Q4sSaysVhC+lnisC7B04X1NzVqWRSrzmyze?=
 =?us-ascii?Q?3gdt8uZKbRcHSMh+Hb+kzyZtbTkeg/2XwLdYE7nc9X6QcDx7Hr3fkeyykLtk?=
 =?us-ascii?Q?abw9fTWPWDC4FqfnfZUdGo9v7PCHp5aWEVa/56aScjRJ6Qt8yNcSYXu2A0nx?=
 =?us-ascii?Q?ZEA/+j0f6rKoTWPdTaK3tME3Y/LtfI5bb7k0eKhqlcvFtJjxsnPOZvqASp2U?=
 =?us-ascii?Q?D5YPU/XNSLs7eYTrnY1V/Zx3nJwy2qpOAjPLcHa2qjD3XIP+8sX0Bp9HeYj1?=
 =?us-ascii?Q?S1Kx3vyCwIsad/an1Dkmh2yn5jYQhA76xw7s/XWjx35SqJ3INBZqS7us2GeZ?=
 =?us-ascii?Q?LAvZmbS0QqbTQnpCwRhw7E/iFMcoPfvOVRx0vsydtZQUmtyzvvKQteUh9CX6?=
 =?us-ascii?Q?sjqx/E0Sp3MDMVfTjqaWcdNCBZt5UoqW1IrROF2Xlnf5bi/NiYlmmTVl8bFA?=
 =?us-ascii?Q?finYZtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AR5EVgTh4i2+5Gb65mZqzsZCvKmY7mF+BPiv506mzGbZQDj8jjkeQ7ZDmRVu?=
 =?us-ascii?Q?fu7z9Cwbhifqke9CHFIR2YvQB0Jps6krdJMzjBl8nVhQclb5/NvcK/E0MaKr?=
 =?us-ascii?Q?Ncqd5+AzUpddXC2fU6HOGP+kEWMfHAnQeBArQRCNf2sxXETUIqrAOlUow0Pm?=
 =?us-ascii?Q?3Y5ZiQyMZx+e+KORp0kVMM07IsMWm7sQPOtlyLNxf/54yXU+E8N0K8QhZBi+?=
 =?us-ascii?Q?jzQqvcul9+jp6wqxTN8mJprvd67NpVts/iJrU0+UxSW0s+cA6tBQPue2DbIu?=
 =?us-ascii?Q?rx0CuoNUeEc9UKFGTWdlDtDd+Hwd+Nrxyzext6udKA+1mqEL/6FbOWOuVzmn?=
 =?us-ascii?Q?/ZOF+eK1KntK/M2+UZ5Ek9fI9IaPvPSmm1XDQHZMRQ8CjUmYhtlSY+7U5cjF?=
 =?us-ascii?Q?+oeW05Db30R2U1FSeKF0/F7uYSNkmJFk3iVSFDFNIzI8yJ9fPr7Dm+4V2wJ0?=
 =?us-ascii?Q?AmG29Xpi9vSi7IXq7CqnJ3MJ4ringVEtupU+eO/DuoDIrDC06b9mCQwlmv2c?=
 =?us-ascii?Q?QWRJhQV3dcDIcfxopu9VPXDy1I6/fqsErumgGEZRa514cEDJmNqMR7VNQImp?=
 =?us-ascii?Q?a3HZSR2orqgR/5Gu6SGYkqJoW0GXecadyu65WKMrBRMd+1ICUzB3Qk6b0GOX?=
 =?us-ascii?Q?tLHofENikd2cNfHcDcW5ufnaASn/affY4JLH3qNZKkry03S/OX/ur9Yy7elB?=
 =?us-ascii?Q?1AdSJfvYRH/Pw8gCczcORAhysFd3LCFEp1wxDUybxXrvaO5sU7LNR13Pa590?=
 =?us-ascii?Q?CP7wUohOiYgg6dO+YBes+KVq3/3Qo8XziF/aFiwfHXfVzGSBOTUUnh6KL36Z?=
 =?us-ascii?Q?rVB5U3H/ozZ5/hoEnpTymWYC/h84tJVj1uD6jovamNu9Zbeo0f/g0q+iZFte?=
 =?us-ascii?Q?nTFNHiFOcrdOBfINlEVXZxCec6A+zWQp03PYaalJTqL1pchhS6oXi9J9XmOh?=
 =?us-ascii?Q?DU/YsBrSNxUCmo9AkNyPdArAlQXhxwfs0SQ/GyGZP3iRn0ffWZwMyocwJdti?=
 =?us-ascii?Q?m7Y3yjzljn7Mgn80GUgv7YO88MxlqR+SRFwilcD+GDb4mokfOq7wPoKlDz3A?=
 =?us-ascii?Q?rzk0xctoitP7oH4e4Rtd8rcpp4K8TyJcT8XuJTYAg/gJBHAeVCAmDLYQEeOp?=
 =?us-ascii?Q?vPCj09jWoh5rFXgXwl3ZhTaTskeLhLBJMO3GE4tBzuoBLVmAMl1llSGo4Gsu?=
 =?us-ascii?Q?vwS1x7RaJC3umUKWreXPrhzCHk8b0lS95oIi1BfCQ28taU8oSm5dnaCCms4w?=
 =?us-ascii?Q?CTkWfbiHhSW2l4LrP/IlnQGOuKsiTHhHkO6jx/7ifdltRGh+yOjWKtEtn/WJ?=
 =?us-ascii?Q?/MsolzvkAXthTB1A4DvG0WLGlBjPvnVmdB9uNeklaOt5TpQRjlIo55XYWo2l?=
 =?us-ascii?Q?mRSSS/+xuHsY3zX88mT5kDm/MGWl8kriBCE+dBHAbOoG9hgc3SSbMWyoN17v?=
 =?us-ascii?Q?DoIuhoM1AYmVm5CYEDiyvbaGomlPoSDRiva1RMqWFZUqOTrurHve16y9EmO1?=
 =?us-ascii?Q?ywqgOQGxqj9sBPRFMRlslEnbnktuAW7kg2DOlKcykbjygNaDADA0JmiLYre4?=
 =?us-ascii?Q?usLrbd5MbjH2Z5q+fFBXTgABS/N7UqK7L2bdBXG+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9883c74f-e816-4253-9c58-08dc7eebd882
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:57:39.6360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrgBACAOELehRhflORQlc0VL/AuLlqzKGmFlJTqOzgDIQ65DwaODTnFnFOC0NLSZgKbBGY0nWuSmkAmn/NariA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10019

In current design, the user of perf app needs to input counter ID to count
events. However, this is not user-friendly since the user needs to lookup
the map table to find the counter. Instead of letting the user to input
the counter, let this driver to manage the counters in this patch.

This will be implemented by:
 1. allocate counter 0 for cycle event.
 2. find unused counter from 1-10 for reference events.
 3. allocate specific counter for counter-specific events.

In this patch, counter attr will be kept for back-compatible but all the
value passed down by counter=<n> will be ignored. To mark counter-specific
events, counter ID will be encoded into perf_pmu_events_attr.id.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v6:
 - new patch
Changes in v7:
 - no changes
Changes in v8:
 - add Rb tag
Changes in v9:
 - keep 'counter' attr for back-compatible
Changes in v10:
 - add some explanation about 'counter' attr in commit message
Changes in v11:
 - keep counter format "config:8-15"
 - use event format "config:0-7,16-23" as suggested by Frank
---
 drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
 1 file changed, 100 insertions(+), 68 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 0017f2c9ef91..15045fbfc685 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -41,9 +41,10 @@
 
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
+#define CYCLES_EVENT_ID		0
 
 #define CONFIG_EVENT		GENMASK(7, 0)
-#define CONFIG_COUNTER		GENMASK(15, 8)
+#define CONFIG_COUNTER		GENMASK(23, 16)
 
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
@@ -130,6 +131,9 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
 	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+#define COUNTER_OFFSET_IN_EVENT	8
+#define ID(counter, id) ((counter << COUNTER_OFFSET_IN_EVENT) | id)
+
 #define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
 	(&((struct perf_pmu_events_attr[]) {				\
 		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
@@ -162,81 +166,81 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_pm_29, 63),
 
 	/* counter1 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, 71),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, ID(1, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, ID(1, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, ID(1, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, ID(1, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, ID(1, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, ID(1, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, ID(1, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, ID(1, 71)),
 
 	/* counter2 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, ID(2, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, ID(2, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, ID(2, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, ID(2, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, ID(2, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, ID(2, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
 
 	/* counter3 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, ID(3, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, ID(3, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, ID(3, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, ID(3, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, ID(3, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
 
 	/* counter4 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, ID(4, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, ID(4, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, ID(4, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, ID(4, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, ID(4, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
 
 	/* counter5 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, 72),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, ID(5, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, ID(5, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, ID(5, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, ID(5, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, ID(5, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
 
 	/* counter6 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, 72),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, ID(6, 72)),
 
 	/* counter7 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, 65),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, ID(7, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, ID(7, 65)),
 
 	/* counter8 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, 65),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, ID(8, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, ID(8, 65)),
 
 	/* counter9 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, 66),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, ID(9, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, ID(9, 66)),
 
 	/* counter10 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, 66),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, ID(10, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, ID(10, 66)),
 	NULL,
 };
 
@@ -245,7 +249,7 @@ static const struct attribute_group ddr_perf_events_attr_group = {
 	.attrs = ddr_perf_events_attrs,
 };
 
-PMU_FORMAT_ATTR(event, "config:0-7");
+PMU_FORMAT_ATTR(event, "config:0-7,16-23");
 PMU_FORMAT_ATTR(counter, "config:8-15");
 PMU_FORMAT_ATTR(axi_id, "config1:0-17");
 PMU_FORMAT_ATTR(axi_mask, "config2:0-17");
@@ -366,13 +370,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+				    int counter, int axi_id, int axi_mask)
 {
 	u32 pmcfg1, pmcfg2;
-	int event, counter;
-
-	event = FIELD_GET(CONFIG_EVENT, cfg);
-	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -392,12 +393,12 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
 
 	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, cfg2);
+	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
 	writel(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
 	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, cfg1);
+	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
 	writel(pmcfg2, pmu->base + PMCFG2);
 }
 
@@ -465,6 +466,28 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 }
 
+static int ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event, int counter)
+{
+	int i;
+
+	if (event == CYCLES_EVENT_ID) {
+		// Cycles counter is dedicated for cycle event.
+		if (pmu->events[CYCLES_COUNTER] == NULL)
+			return CYCLES_COUNTER;
+	} else if (counter != 0) {
+		// Counter specific event use specific counter.
+		if (pmu->events[counter] == NULL)
+			return counter;
+	} else {
+		// Auto allocate counter for referene event.
+		for (i = 1; i < NUM_COUNTERS; i++)
+			if (pmu->events[i] == NULL)
+				return i;
+	}
+
+	return -ENOENT;
+}
+
 static int ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -472,10 +495,17 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg = event->attr.config;
 	int cfg1 = event->attr.config1;
 	int cfg2 = event->attr.config2;
-	int counter;
+	int event_id, counter;
 
+	event_id = FIELD_GET(CONFIG_EVENT, cfg);
 	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
+	counter = ddr_perf_alloc_counter(pmu, event_id, counter);
+	if (counter < 0) {
+		dev_dbg(pmu->dev, "There are not enough counters\n");
+		return -EOPNOTSUPP;
+	}
+
 	pmu->events[counter] = event;
 	pmu->active_events++;
 	hwc->idx = counter;
@@ -485,7 +515,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
@@ -506,9 +536,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
 
 	ddr_perf_event_stop(event, PERF_EF_UPDATE);
 
+	pmu->events[counter] = NULL;
 	pmu->active_events--;
 	hwc->idx = -1;
 }
-- 
2.34.1

