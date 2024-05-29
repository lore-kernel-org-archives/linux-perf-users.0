Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2056.outbound.protection.outlook.com [40.107.7.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFF616EC00;
	Wed, 29 May 2024 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969892; cv=fail; b=o31JSXA6j9sa/KJyqNM+pGdUHcOno1jxZGRyTt5bhROl/dqoBVo9WnklpCavmPlebbejPeGGRsTwVemYlnx3pqIuEAHU6M+rsjPfLBNlW1x3RVou912U9BUe7GQ/wQjmqvsxWSc5WgN3AsoesbuhpjEn9RJ88H/6m9Xt/r0I0G4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969892; c=relaxed/simple;
	bh=tDbgPWBkgeCbwH+9L0zxQ+Th/wPWKtJh44Qs9kLpKXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GfliXW1oRTiHhfhBOfgyxiEqXV4N/ceu01GjbunHY6CanEVAmLuXm8sZDgFWeiZT4D2sNO/FZlLErmyo73vIQENy16niq1nncoPXAYV5RG6wfGIATeGhr65ZUzgqDdsMksZktevfjCxxJ8WHRL81B8S4GujFKMi9+eOSVj4x2hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fZ27x5lU; arc=fail smtp.client-ip=40.107.7.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fZ27x5lU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfskrCLnxhBMlWBGLyFffAT0b+1KrClAxLHBWRpml6/q9/8azu43mB6CqqCoa1/nWX8FqfjA26viwH4agnpjviN3qWrLnZz5GsnS3NpLBMZrNzXfI/nIWp7T2nZ3bwOyEDxVsdwcAwEjF3X+Ln/7+ZcjtELvm8sDbuCHlsiNDT54jsQJInN0Gv8cfs8IXA2igMBqg0oDJO8i1QXh4kKx9eey1YPxofb5c+vR5zIUlVSCt07clutDFQLC7tgMKfAJyu15gHCqklMK2hjNNhUlQ0tCECoLR1aLoIxemNCc1NbDfrVEVynJmnkIue7UAhzyODTpGvGxpRPFBxgogtxsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45WDZLIm4+/eUX1+9VQNKr7o+7MUFS86P9rwqwhOP5M=;
 b=g6ggkwKrxbAjXktE9gfQpqLZ0YoUPqf0NXA+ODETW8aPY0vrje/y6bPwA7Yd15IqZzN6kgnKF4JKrQmkIrJ7XXTQn3jau9I00sozI6Py/2D6PRkqG+pH6sJ7KmMgylf6M04rsSXi5FDyqN9RV0tGG1TWMxz8oX838Ua2GpJRWLQCT27Q9Ils/psVh2ccgFRjB4cjLw5GAGni5NTk3B8/ZIpKrtNdPC4F5+L6AGUq2KFq/L3crySXtV689g5gBHLF26gENkuU2uAzcMIzwmlnU4C0iTF3NU8xt0H7uwyu7XylFYwLl/Rav3A3has6+pZN87X+ynFEkwsqQ4uSxtIs5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45WDZLIm4+/eUX1+9VQNKr7o+7MUFS86P9rwqwhOP5M=;
 b=fZ27x5lU2wr1SEUBYggZoqX0QFJNXb/NgtGVNbNXIX3QO/j58j/lyQ/oHvsBvC4KRJlrXSDTqedNel06reNzLwWCdV8JeDE1AzWXKvj7Drfy+tR+jIx/8VIfdEWnfWuyMXEbwvyWhkhEx5jIRfbkglQ8pdlxt4qEl42yHxIoESA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 08:04:46 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 08:04:46 +0000
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
Subject: [PATCH v12 3/8] perf: imx_perf: let the driver manage the counter usage rather the user
Date: Wed, 29 May 2024 16:03:53 +0800
Message-Id: <20240529080358.703784-3-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26949178-5873-4d22-a556-08dc7fb60107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U7J9P9GvRgPW895mB4Uk1FFYms0S1MrxjsdzMjkKO0GOFM3Hs2RzVqSOWoQx?=
 =?us-ascii?Q?wSybB3ZeSwnw3bDN4fSPWkdM+AI2lTA7BM5Ib1mw8dQ+Cff2uKEs0A08Q8aE?=
 =?us-ascii?Q?45DdbHSbi5/DwAfr8e+OxTOVG4XF0e2ZrLqOTPf4P7pyrBGhlTkll4w/+ZRy?=
 =?us-ascii?Q?x/uBUGuirUmmThWta6XY3exgKObo//ZQoFjtREeXdTks5ovvojxUpLukYSSq?=
 =?us-ascii?Q?CWttEEdmTCIQuuSQvKoK9meW/cs4+m9/tuMVSjJffca7QF3B0LO9hb8/L3Xm?=
 =?us-ascii?Q?ynLx97tSzCPIQRBgrMLOiKv5rctubZVOjPTtB7swp+G1ogv7BQ4MEu4+86Eb?=
 =?us-ascii?Q?dNhoFOajaMvKHx0Fdn6wYA0IgN1a4zxgpuM+xgkQzk7OOj1RMC33G9waP8Q3?=
 =?us-ascii?Q?VMn8CpQ8XoHzJFYM3xkstGCuqQav2O7WSjvlz1eaoUDqf0ScIp+mXCuolDFt?=
 =?us-ascii?Q?gKTbvidOOndbmJ0FX171e4X5BnNz+K+50PZ6FoiCnNDd7r39nUvSGM8WglD3?=
 =?us-ascii?Q?hZa63akIjUsFLKIZZEHJu6V6UcsXCJDxGGCCPQVVsNlNfuO5Cjt2WZ6P+zuN?=
 =?us-ascii?Q?QMPQVGeJ4ZQZ3vFuL/bToZxxKipzrhz6tgjfDscyyLe1euiP9HnLiuZrzLnZ?=
 =?us-ascii?Q?aQLUBZE4IfAXCnlcxSbd/3n4rFxUm7yFtp/IVpGL9hqFkJEgPZ/LQn6cOZp9?=
 =?us-ascii?Q?M80DFOGK48W+hBAzYq6sbrhwAeZqicl56OD+2JPWnBuhLIr9Gr9f1D7laAEe?=
 =?us-ascii?Q?WFwk5VTb56uFG/WG8Pwwt2yXDH5RDl4sk7S/4gbEs30WehyCRRMhw0YFeXeM?=
 =?us-ascii?Q?Pk9cM6rzOqbyDrQ7xIw1+ENSiLizCA8jzpBLKNMUeXR7dU4/ZPMQq8yv0v/L?=
 =?us-ascii?Q?JBcdpzkarwPJ14MMYtM+77656xWSPAgVqBnqMRMVy9mIn4r/vMQvf17qUigN?=
 =?us-ascii?Q?iLCzbb/0udXp9LlgyKwQzS13emFqmheQX781oAN4+517k69zh5eedqrrNhFu?=
 =?us-ascii?Q?o/5LrShv2OL1rdpH/aldJ2hKWvmBAu7adJcc8iVhKWrV0MvjEYkIlWTGWySI?=
 =?us-ascii?Q?J5aQYEGO7vL+i+YIROXJ0eSWCWnTrQQle2LYtl+7+fCnQ6cDosQclv58Ve7J?=
 =?us-ascii?Q?Sw1lV6G9z2Bif//QWU/zP4O5vxM5DlbxMz/I3Myr7wRJE8b8imv4pr9U2I3s?=
 =?us-ascii?Q?8BuDDTjaL0ul5njRBxCD4cltqhxC0UPmW4clZ43P3yXAXX5UVtIDLhRduBeq?=
 =?us-ascii?Q?xI6Cp36XjUTcpjiCijmorV3B3hvHfNo3DrQ/dn1y2yPTKhZX002Mhxi49xUk?=
 =?us-ascii?Q?CtedrrBkny9kH0jPS2eBmvm+hsPhtVqiJpKIi2azULZy4RjoGicKuK9OKA/w?=
 =?us-ascii?Q?P3tR/O0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E60mebaSNyXwzu6HQS8UxaarNe1Rlz/duW6mJeHsM4SVe1UN9d2QiXRlB1Ic?=
 =?us-ascii?Q?8W4LA8bl7ei2q2Vb/alHkM32UZklQV4QPfLMJ9MTew1Si5gZB4GzLms5V64i?=
 =?us-ascii?Q?EqWmRSaHFy5L2eEnCq3EJengh+c9zEXLv6X6ZL+DvB1Rqz6hbEZURuN59w7C?=
 =?us-ascii?Q?IxrcT0F+KSl3pb0RaMNEiudXUynxOav2jIpE/J/V91e14y2OKehkrhCuuZ9b?=
 =?us-ascii?Q?VPiXaaNmBTYPpKpGP4aXj+LTsaEElpamJuj8ZRBxZ4RfY/gJsGpB6NS6WOUT?=
 =?us-ascii?Q?FPK9OEesYeVkUItZ/75rwc9iXUbSWhpiJtxx9YppOyfvTzvB046/inbO4LPr?=
 =?us-ascii?Q?KxIKI3QCevmoRc0tC8lk8gGS34XU1aFbYye+I5Q24bOl3h5mZSyC+p/1q9Pw?=
 =?us-ascii?Q?xO9oJTyiMFYUk4OOp6TBBdx3+eA0BVkXcpl419ZCxX0HdoRawzy6X0oG6rgk?=
 =?us-ascii?Q?XUtdvJnnbpTPEylFLTO6hGefxcwd/8l3Wq3QOqvEZ05FpVmpWjYf+Qr2nakR?=
 =?us-ascii?Q?FT8LsPP5cXH1wfsm1dRU6ufAAlLn3TAy9zgtCoInhhFIF67zdeOoKfeO9Jdu?=
 =?us-ascii?Q?+cyXR8hjuz/ZRlWTsf+HQWU0XVdJHeOM5Nl6Tziapy7cxtIgTGcmWdPVoSaH?=
 =?us-ascii?Q?L+jbz9Mqu73xjyXSHgXki+uB2d4C/3jOMycmHhelKh06xyDXmgpQWRUynDzL?=
 =?us-ascii?Q?NWyFMxGQC8GzYpG7Z7kmoM7CfvF+Mr3rCGUMnpGQG+seq7QmsxY23g37R+o0?=
 =?us-ascii?Q?sLoujhtSlA4FL7dPtfxDppudLbOarkNnHkAuMwPy61asLJai6yHISRAOgE8n?=
 =?us-ascii?Q?whS6kVJW51Muswrd/7VdZP5JA+6hMc0T0ijbC8jil65WmYDrxstHwyS2D1LP?=
 =?us-ascii?Q?wKfMQt+CadTbFK6hXlsB4kZWFOaeyz3vC9/kdsVXn6z12nd3+mg/p9HC1GUf?=
 =?us-ascii?Q?TB+Pytzco772z0Zb/hWndj6doqWNMqbJnQLuFokOXHkVlFvZoR1HS7QZlK8x?=
 =?us-ascii?Q?C+IUNHL51OlXWAgP8hlNJCmNEDGRUxhqS28bE1KDnCJhVHMcXo35ToBZ/y9J?=
 =?us-ascii?Q?4RUWJt5p8i17tFaCQxcDKQ+UcLp3FRvxlIapnAk9D7IW3HAX4y1GNfIcIdwi?=
 =?us-ascii?Q?NnK0K+R/uG5mfLT4UUi+t6CJzkHVOm/9PNIyfsWmEWRqcplzwhYfMtOTLFqv?=
 =?us-ascii?Q?ZwipZIM6Hu/eJnOR3l4ZXcXuSA0kG1XeuEntX8B8Xop5zKYWJgaWsnEiix82?=
 =?us-ascii?Q?pVmpP+0HBcYJtz0PEUKLyq0BwE11Jm+at1j8etfRLQZe7dMkRiQOEh1289mW?=
 =?us-ascii?Q?sjnC3r5p4ijz5OWzbDssJhRUVLigA8TvsL7tH9eKrmVMZNNwQmsVVqZiDlFh?=
 =?us-ascii?Q?iRHKT8igzWG5EM+ITXHc/YOYl6Gr900o3+bLpFY6w8wUNjw05HmUb/A6J1OZ?=
 =?us-ascii?Q?9vJE9AaGkrorT7rRPSLJwWAJ4DvUygtD5wdm0Gy0fJhOICFVrgtRPOVAxtm+?=
 =?us-ascii?Q?a6rDv7fQYXklmEPTYVlhdmLolOo3asf3YYfNrD5jxfAFlab2r3rT4aomc6bl?=
 =?us-ascii?Q?V6OK0py4+9lNRA20KnR5vlphyeKGc0eYqUFgjt3a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26949178-5873-4d22-a556-08dc7fb60107
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:04:46.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM4eYLKiOuWmqgzVIHXpMOqyDeAOs6lnFzOnjBsJe6vuag4YZ4C0hH0TJA0B+iPA36rh6JY//sHIl51mISx8Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

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
Changes in v12:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
 1 file changed, 100 insertions(+), 68 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index c4caeab7a9be..08cb1bfb09de 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -41,9 +41,10 @@
 
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
+#define CYCLES_EVENT_ID		0
 
 #define CONFIG_EVENT_MASK	GENMASK(7, 0)
-#define CONFIG_COUNTER_MASK	GENMASK(15, 8)
+#define CONFIG_COUNTER_MASK	GENMASK(23, 16)
 
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
-	event = FIELD_GET(CONFIG_EVENT_MASK, cfg);
-	counter = FIELD_GET(CONFIG_COUNTER_MASK, cfg);
 
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
 
+	event_id = FIELD_GET(CONFIG_EVENT_MASK, cfg);
 	counter = FIELD_GET(CONFIG_COUNTER_MASK, cfg);
 
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

