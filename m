Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E8174ED4;
	Wed, 29 May 2024 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969915; cv=fail; b=ftnb2UcT6yCjZg55xXIyNA+CWbK+lH94ivUPth3zh09ZnhUc1D2d7uVX+hIITljrV92N21USuRRHbvvIi0kat+HdP6kp0NSWS0dSt+A0sz1ZEHNXC0zda2vbQxwlKMa9iMI4UtS9J3i+yu1EAbz6HzSMCEDqBy41+sPZ60XzoPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969915; c=relaxed/simple;
	bh=Sh3Oau0aY54g9LQIAAC5aIPhKbNRrmKQ98wTVc7Gvg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YN+J3m/etwbJm2Ic8x8mDPYVwrWDKW0l1wZN4wUc77NvbRON1cN3rjxsPCtyLi1TN0VCI3Vluzw000uKj4sR7rQUa10N+AX32y0JUSze2XwMeId1VIlDwtHYoCZelD/QI6kte7cmg8Dm2sIW0pripOsrntKvTJMRf2urWAkSabA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bDV48EZz; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bDV48EZz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjISoPEzzOCRF3h6gHG04e46IWjFsR93L2MeeL7YKkDJ8VC30uZ8jXthqwp5XttOhQOJ4Lyw3nXiuVbMD950zmcNXUxcUFdk0INkpxQVx024PTwSiI99TDW8hDiviimduMEQHpG/juy1Ek4Q50xLx0tAyfWCU4+gMsEyqnqkr/3xswbYyXFzp9t4RwsWn9T1u+sDMKPkCSUDdllITPHeEHCOY+SMRVwr5kKL2UMS+kRTzOp1bhvQsJVBVtrB4W4VYNZa7MJDlBJ0TEGh+Fjng2uxol0VFRXrRnytoOUAIuU9NgHQsKx/NxrmXfLfYmDKLrYT6Q1OSbIHbyaYJL8V6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIVC9q49Y15Eo1eTfe07H/cIjOoYuuo1u61ZEqfwFT8=;
 b=dKidtkHTIGBzHdiRUf/4m8KkssRhTMle0/ALh8blB6Nvaq0Tw5pisjTJfbwlSOgfN73HiyHacSnX5hDiF0mhIhp0WTP7E5K9P6By6JAqolW86BbZLgfz2ixvQGoMEWyb+JrVFQTJS7d7VzuG0QvGIioG+Tjyx6AM/gWAEG++9JTnElRD4s86CemQYJ4tEzln2ZGfTd3E0o8TTLLB9y6zX/t5bIMsBaL6xBZp+3jl2GchQ7hIgTHA9aNGbhpy2EJYmyOxfGTHQPO21qBmf7B6vYLo3bbDBmbj8q64zQ6O6wCFxU14+hSQWEBqtm2h1b7ffjvLr5vdiWLcFrcYN+Pa4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIVC9q49Y15Eo1eTfe07H/cIjOoYuuo1u61ZEqfwFT8=;
 b=bDV48EZzVQNyBexxVb/BBO1O1hg/VV9C+HJHOg2QJCE0Nwc+MN6hgxhe+NcwsthIACoAkD//q59fLOw0KX/6cDrQ59aXjtZ6jifPe0DBb1NwZHBH35Awl6ArhLm6K4Xa/xjiwK3w/tTNHi2FnSSto+MW1o2AigrYzQqNTaJnU0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 08:05:11 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.7611.025; Wed, 29 May 2024
 08:05:11 +0000
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
Subject: [PATCH v12 6/8] perf: imx_perf: add support for i.MX95 platform
Date: Wed, 29 May 2024 16:03:56 +0800
Message-Id: <20240529080358.703784-6-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 74614e21-2cb5-4cb9-0d07-08dc7fb61018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rdGtisgGDsH61WQ0nEnKEIbkGzatdMzAqMN7QT1cYEFTpJaC3/G9+XWLNYXZ?=
 =?us-ascii?Q?NTx4a8cjfU+hMbYKMshfqIUbSy1yCgi9p5md3IneQ+EDxUcstB8DZDh1MRIw?=
 =?us-ascii?Q?sc3z3zXV+s6yUGPIzfmEAV/9dxwuN/lKpGmGeONWPHBPZ+k0LcBakVtLdIGV?=
 =?us-ascii?Q?gfwn8GsyM7ugij7hvwbQOnjMx5aD0h7Hvj2tV06TWJjA+RyR9jRiKOnkPPhK?=
 =?us-ascii?Q?sSm7R2gwHeNrDu3EXi+lLD6+ELKU6psKmU8zV+B0p6uvIrZSW3vcCDZzjPm3?=
 =?us-ascii?Q?EFMHjMu+3mNhPxb5EM8ZE6eXLye+IcJXN0ntxtAjljeMP8NG8qs6L8SuAqcP?=
 =?us-ascii?Q?5aZKZkcl7I/R5ykWiImDT8ivoDpdBEuE3QA5TtLW6Hw0ccY9IUaMOovwCoKO?=
 =?us-ascii?Q?p8GoPMnROij01tj+IlmtFc+ypOxKH/NCsanJ8pLV3/++WaoqnfXstM+l/lNc?=
 =?us-ascii?Q?HCNWtF0uMSNEOmKG/edBo2mx4gdW3JGq1wYvzxeCaV5/GprNYf3iOv6R9+Mp?=
 =?us-ascii?Q?zTFJ0NK0XeJTN8oYCl4R63+eduSO7DZ0JeusXo/jfzweaB/5DZtcXu6M/FVt?=
 =?us-ascii?Q?Gf9jJbYbLpqbQfOC2FYVRRz9yo1yAzvw1AZJybo/pVNdg3wgiO+Mtf3p4YpO?=
 =?us-ascii?Q?6MLFHJ0zvGYNnktf1a6tIPZi9v0KBwQoDt96vp9fqMJZca5/O+HPTacO0YTk?=
 =?us-ascii?Q?wpoIBa//DF1gVhMhFDfxPGNzwfnSghNKt9HOoyX3cworFcqQ/+dfw0ma9NYF?=
 =?us-ascii?Q?cdTuqnIfNfoMHgPVlhT88t+NYAKfn0evrtxEkk4Re257V1i7V/GvzmKMkFST?=
 =?us-ascii?Q?iDUyr15xxASVmeGkxDKOYdyFG/B7dwRgIV6k9jYMk8yzoE8ZrvAf8NTNG38g?=
 =?us-ascii?Q?zB1I/feyIAg88kTEHwXgbemovvpPcNLn2+RIRmpx5Z4MvDgeQAKRjQbLGHgb?=
 =?us-ascii?Q?9iA0hmdpNL5bkCsoOVKE+aD/JdkK4wl+4M5dk4EmPR+HSlJTWJgUW7dbnoOm?=
 =?us-ascii?Q?kN0X8NLoMIeFFotBjZKZTNJfXBmLlUyhlEb/bwgA1ZN42iddQJvM73Hl2Onk?=
 =?us-ascii?Q?bVkxFxfJX8y1iBqAA6TZMlz6b69vFb/sp6kT05HBcP7QBONrEmKt8H70C8N/?=
 =?us-ascii?Q?U1E1JVSqf5DU2CMBmS2tPxoOnao5DBAMJXb18S2wQ7Z7S8EogQ9r86MCi2Kb?=
 =?us-ascii?Q?uByOmclbi1JqrQwsJBSdtb2YblduUAjgBuuaAgAZApqUvulICEfxzdMrjMt3?=
 =?us-ascii?Q?iC0/sZp/tBCumwMgPvISUIkoLW/djg4V2j83a6mslhCng0npruQbfCtc1QdH?=
 =?us-ascii?Q?4QP3+x7/cgBcqi7KbKRlM0JgfwQABDdj/gduTa1nbdv2qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?buCoGAu+G1tUuG2j5mCeV/+9uJOUvKyAmF0GL7VbHuUv0bywSXKSLiZqlq8c?=
 =?us-ascii?Q?HW46UBwGBfOa4T2+WokfYAUUhpPmdck22TqDQol+UKM80Wfs+i2sjCQ+bdei?=
 =?us-ascii?Q?LKjsAepg1LSNml8WMoWfVRXjVw65f4A4Aged2wSgzzzdCxZ3QDUB+9pUNBl1?=
 =?us-ascii?Q?MVVn1Mk/RWhCpY137I8nLyeIs1ogOaDkGJRFORmrDXtDM+MSc5p6NyGqce7X?=
 =?us-ascii?Q?R2kXKPhaxmgD1y/6PP1LX8MLq3e81hd/M9PynN54sEipbQQ8bB5fvq1sG+Ej?=
 =?us-ascii?Q?lhkjnJI52BCoGeg1HkF93GgA/eRBDXL2pqQu+SRSf6qgxd7Jm2hmBAs/k1jm?=
 =?us-ascii?Q?DpTu7U0dDzlAbI1UbvaIdupAMhx7ETuFy2h0COpRN4a7HrL8cETB39Vna2ly?=
 =?us-ascii?Q?HhJJ1cSK7Bsv6p/7VwHA1QcHIYSEp/k4XfB9KT490LGU1Kzz6VdF+dEn/BrJ?=
 =?us-ascii?Q?CXGRqjG5skES/e7E2cpnENNHmEUtNKzM87+ma8Yv2PCDrVEVEnaZow+QsUh8?=
 =?us-ascii?Q?FLpNBnECacyU860IUJ+w0a3JXyjcWbmNiqZ8ezZ2kfj4A7nnCMzf2Z6/IbnO?=
 =?us-ascii?Q?jwhGrZRsRoJeuySgtYfB23t+dodc7TP15veQ3MGajvEM72Fso5iS+q1aBHQ/?=
 =?us-ascii?Q?d+IbI6Gd526u1GTkeF/5c0sKuk+qNn5R1tkrhSjV8YWk/2Syr4TloCb25yQR?=
 =?us-ascii?Q?eXrJuS3V1r5d1y1dPy08wPi69Z3roi1Itq4Eb1jK3jV3XJO1IhVF6AupZVHY?=
 =?us-ascii?Q?Scj7V3qtRxGzDDiYEYEb9g/nByaKpXiA+wmREN3tz+fDTQyTuS1vdCbx0T8c?=
 =?us-ascii?Q?DeKAqOE/hyghy7OWDRB1RPZQkitaHnzipehv6tW5zBhtj32gDyNcKB/v8RhB?=
 =?us-ascii?Q?YxYlY3srrfA/j3wlyjarddwXv5hIlM5F6ViGpcEtM2rpqQNabqHzDq6QqlTv?=
 =?us-ascii?Q?YCi4K9DWVkYXRiLa3bo4cXInChZM5gtXHfQYvVl2uiQRm7WME5jopr2fCTR6?=
 =?us-ascii?Q?JppnmTnO0n4slUrRPhnLbNkq10vlnoJO31ikI2ljK8Emsnj+FEjJ2LQxg/B4?=
 =?us-ascii?Q?79KX6GTPOwx5ARP2IgGTrl81iqUwgEtG45LZ2JiVWRmgSsDHcnDXGZf2QXcH?=
 =?us-ascii?Q?o6Z6V/2Ntqojp/YgOprlL4VVw8vv5VQTq2yLuYqFv51NCgi6odWu+mCjQ3vG?=
 =?us-ascii?Q?IYp2mb9/mdKlmhm30OF1eUQdvwl/tK0ipMZw0VE02j0N12N2oaWdaT6YEbiA?=
 =?us-ascii?Q?NAMCBviroKS0wACK6lLzxKwvw3OemAOuUS7FocXtj93TEq1yeXU4mTWmWObN?=
 =?us-ascii?Q?5l9f3bR7Qjl5fx5ZUL+IGFeYwiSrrcppHgVRhL1+ug0uZh7LJMWtEX0LiZSQ?=
 =?us-ascii?Q?hWnDtCYQwpMtfDthGD6GcNgB2fjYwaACF3oHe2j96kzDXpZkM9sj9b3dkxNx?=
 =?us-ascii?Q?edQyX1jJMUZDCQl1PZ7S/EodgYwNY16JDxLqwWoL+v2mrm5iP2/OLws4TB9U?=
 =?us-ascii?Q?g2lTZaoCtAkOUFpXY6gDCJgcxYM2iMrb5F7n3ncAj8weEgIzuV4hQQuoVhG9?=
 =?us-ascii?Q?KjE5DMXd3Q3bD247fhBKa9a/JhTlnJhPb7yuW2cS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74614e21-2cb5-4cb9-0d07-08dc7fb61018
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:05:11.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyfBI3c0fo3NH5e+w865YGg0AXG787diEsIvaYOzx/BoK+gJHLz6LzopmOx4AQTIAtSXmVFJAUKRTyOMuGv7bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
read beat and write beat filter capabilities. This will add support for
i.MX95 and enhance the driver to support specific filter handling for it.

Usage:

For read beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=0x00f,axi_id=0x00c/

For write beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=0x00f,axi_id=0x00c/

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - put soc spefific axi filter events to drvdata according
   to Frank's suggestions.
 - adjust pmcfg axi_id and axi_mask config
Changes in v3:
 - no changes
Changes in v4:
 - only contain imx95 parts
Changes in v5:
 - improve imx95_ddr_perf_monitor_config()
 - use write_relaxed to pair read_relaxed
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - add definition IMX95_DDR_PMU_EVENT_ATTR
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
Changes in v11:
 - no changes
Changes in v12:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 89 ++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 7b43b54920da..69f920b1caf2 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -17,9 +17,19 @@
 #define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
 #define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
 
+#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
+#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
+
 #define PMCFG2				0x04
 #define MX93_PMCFG2_ID			GENMASK(17, 0)
 
+#define PMCFG3				0x08
+#define PMCFG4				0x0C
+#define PMCFG5				0x10
+#define PMCFG6				0x14
+#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
+#define MX95_PMCFG_ID			GENMASK(25, 16)
+
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
 /* Global control register bits */
@@ -75,13 +85,23 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.identifier = "imx93",
 };
 
+static const struct imx_ddr_devtype_data imx95_devtype_data = {
+	.identifier = "imx95",
+};
+
 static inline bool is_imx93(struct ddr_pmu *pmu)
 {
 	return pmu->devtype_data == &imx93_devtype_data;
 }
 
+static inline bool is_imx95(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx95_devtype_data;
+}
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
-	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
+	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
+	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
@@ -158,6 +178,9 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
 #define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)				\
 	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx93_devtype_data)
 
+#define IMX95_DDR_PMU_EVENT_ATTR(_name, _id)				\
+	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx95_devtype_data)
+
 static struct attribute *ddr_perf_events_attrs[] = {
 	/* counter0 cycles event */
 	IMX9_DDR_PMU_EVENT_ATTR(cycles, 0),
@@ -204,6 +227,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, ID(2, 73)),	/* imx95 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -216,6 +240,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, ID(3, 73)),	/* imx95 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -228,6 +253,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, ID(4, 73)),	/* imx95 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -239,6 +265,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, ID(5, 73)),	/* imx95 specific*/
 
 	/* counter6 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
@@ -432,6 +459,57 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
 	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
 }
 
+static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+					  int counter, int axi_id, int axi_mask)
+{
+	u32 pmcfg1, pmcfg, offset = 0;
+
+	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
+
+	if (event == 73) {
+		switch (counter) {
+		case 2:
+			pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
+			offset = PMCFG3;
+			break;
+		case 3:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG4;
+			break;
+		case 4:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG5;
+			break;
+		case 5:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG6;
+			break;
+		}
+	} else {
+		switch (counter) {
+		case 2:
+			pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
+			break;
+		case 3:
+		case 4:
+		case 5:
+			pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+			break;
+		}
+	}
+
+	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
+
+	if (offset) {
+		pmcfg = readl_relaxed(pmu->base + offset);
+		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
+			   FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
+		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, axi_mask) |
+			  FIELD_PREP(MX95_PMCFG_ID, axi_id));
+		writel_relaxed(pmcfg, pmu->base + offset);
+	}
+}
+
 static void ddr_perf_event_update(struct perf_event *event)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -541,8 +619,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	/* read trans, write trans, read beat */
-	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+	if (is_imx93(pmu))
+		/* read trans, write trans, read beat */
+		imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+
+	if (is_imx95(pmu))
+		/* write beat, read beat2, read beat1, read beat */
+		imx95_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	if (flags & PERF_EF_START)
 		ddr_perf_event_start(event, flags);
-- 
2.34.1

