Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BE5C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jan 2021 09:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02BD22472
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jan 2021 09:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbhAYJYC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jan 2021 04:24:02 -0500
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:17073
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbhAYJXM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jan 2021 04:23:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHjDBMcRMAjIyGWV8Qk1dqo9f2ngsjZtH3UmehjrKrQvlLH3WqEW1CWs+fJ7ICZKgqR5opTqGV3n8t0DfVP9PYFNryJverPjW3vmxRiHj+j3FhqY2zkfbSMi1Bercz8mbMuD8tN3kw1KHETHdow+qxhXbk9twH2umhJ0nm4koh9TSN2zM9Ian9dJT+7F6K9venpa7cwT7sGAt5pWL6e/mus2EHU8M7kFGzGvxFlP19ZRuVcidYYGJhwPZqLax3hj21iifoXk46v1SClrj6hadXh8yxFhbWvSaUfX3uM/zxUTUGt2Q2ChUPypfxAx+EqwVxY/73siWJpg32PIujEarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDVComvxyjOcsJX613xHydIROC/9QYDaMdvBp3rMkyQ=;
 b=Jot7MjRIQK/NKvzxUi2AdkMOWWjvY02z623vdJzmvILvSCYdgWA/6RrT4Hq3tVCavMiX9tvewfirGLcQZksVucw3DxMFVv0sspo6lEL9lOLtk0Q4DueJlqAwTq1AQcWBfXPou1R3G1bGxi0Gxk9i5jFdFAItsSIPvlbzWidhCnlP6k1LyhFCqVOMslvT8Upb5J/macDvVb8/8tXTNOZ+U5Q26ogH6axAWkrCYUzHO4q+KYjHkeX2/XZnqJsH0tK6geAJXqJUsy3DBm+/CxrMdUEI2JQJgMjGV83SbYOujvcy5XO63LPXHMT6gfpb7D+eXo3qghJHM+CIl556bdg38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDVComvxyjOcsJX613xHydIROC/9QYDaMdvBp3rMkyQ=;
 b=BUIQPT4jILLycVEbyyjulmHaxRAo+C7w3OT3DfI5pa/LZW/yF3byQjSBJvWLTmChCetg0HQf7n6jsq7k9WQpgkicaC/CAaWytIYPGB52QIqIISvotILuxfKG18VV//Wjx7bauzv8eXT9NDeZlZu2qn02xoQLiYpzuuRsOrc18Z4=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 09:00:20 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%4]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 09:00:20 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, acme@kernel.org, jolsa@redhat.com
Cc:     will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-imx@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 4/4] perf vendor events: Add JSON metrics for imx8mp DDR Perf
Date:   Mon, 25 Jan 2021 16:59:27 +0800
Message-Id: <20210125085927.27322-5-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210125085927.27322-1-qiangqing.zhang@nxp.com>
References: <20210125085927.27322-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0135.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 09:00:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8285f54c-400c-41b0-6196-08d8c10fa484
X-MS-TrafficTypeDiagnostic: DBAPR04MB7366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB7366FD1C4388D9ED6F9F27F0E6BD0@DBAPR04MB7366.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqqbLH5AlDg3MBDr/BL4JkopD4OgJ2NC6sBcVepFQqYcbEgKQ9rSrVodp+2zvbNPEbRspDkMuy4JP+IVQGRS9QVjV7sEWo7ZABeeloZ4wyMLjVGzndnR+ngvlCJvn/Drl3Ektnux8v+vgV6aQU7wlpZB0BGCUr4j3/SXcC+covDN/jXEcPsMVTiEp5RWUA0KBO1mBRD68+sbKGNH+WJs99SwVt2AQDs9MohJrzjAJ5RCvNGpsKKIMOXPvHIBuE3awO8q40dk8PMmXCzCOFKyjHv5zXO5Le+SzYtLj+fMre1mV7zHqSFp16sBCZ9Jwv1Xamjch42aCS6NsV0Jhy1GHa1X12WuWzRzugRXaCic+TaYYTpj4E1QZPqBoe+Fkop0UAhsDgIHy/ZoJBoPJQoqilU1VmZUO0oINSTWApFNalnm6WwahNxVdka1Ziw/NYwZsJkfEzAynIbcYUE78Tz753dQ1AJ1YT4pB1mNowVKQJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(956004)(2616005)(36756003)(52116002)(86362001)(2906002)(6506007)(6666004)(6486002)(6512007)(66946007)(5660300002)(8676002)(1076003)(30864003)(316002)(478600001)(16526019)(66556008)(66476007)(186003)(8936002)(26005)(69590400011)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MpHE6ujkep457zq2AWNmEMucyf2DRNWQ6hwxSm5RY5195oCZP9VT5msSGcS/?=
 =?us-ascii?Q?Tfgcbaos9xaxQbn0pQsQ1Rpi91Lm64CeWeIif/z5K1kqlBViMv/JSrCRK33N?=
 =?us-ascii?Q?TRNgO8dfG16a8wrcsV0IIpm7Dn6CviJaR24HSIZ/hrDE/TCl9W2J9P2CHEGP?=
 =?us-ascii?Q?a2+dkqio8ld53fQdxN+SxpzxKKgDD+4BX8TTxLxuq+eQb0eq2OVIkoLm7yFH?=
 =?us-ascii?Q?5aovcgG/YGjiUsx6i6nyHnTQxBccV0geobceQGPlxjfH470gz6Yv9ju5bU3n?=
 =?us-ascii?Q?ak994PDixXaOoyjkMlX15/7KrfRB1HSMXGiT/6DKOANFv/TBFxQIiCLMtgcx?=
 =?us-ascii?Q?lgmROvNfb3ZCf6G72WN6InyAmwTDbI8LcP6BV/LHGL2rOJi1agUQTN21qUMP?=
 =?us-ascii?Q?YZKV4/+kuz90Ln0dXCx6Xahv/13nbNmLRy+16EY4FRSUxbeM9Af0WBN3T04o?=
 =?us-ascii?Q?TfoNoum5TGzgqyBf87RkKGW4N+vGQwMvEf9C6REZQ2MdPvev2pRfzLKAPzKw?=
 =?us-ascii?Q?h1/BEwaSTKL32LTRje1H+th5nXTIj6IZ8s4lblKDQkwZzsfSEdKB/ZJsa9Qo?=
 =?us-ascii?Q?jp0sH1AGHWl4erJj9K5nulFOjhl1x/mgBBi0mW38pTwu5LvYkgNTV4EXlpSS?=
 =?us-ascii?Q?giqQ0G2IwTvaL9ZcNcX/e65hZa/dR+xH3NUCseGzfD/88qmeXdyFSk8Exwni?=
 =?us-ascii?Q?+0S5pBrdLTDHTUBuZtN5PKw6JdeKSQzL4ct4Cxmfz+SABzKTZokNldWuFpx3?=
 =?us-ascii?Q?TFktQkgprUiNbR/AqGJWPXOY1WR6rkZWqICxTTK+ZASwo6ohNhtek20gmbZf?=
 =?us-ascii?Q?tACDjMaegMNN32f3PL0QrtWKzoY2t8MLVOzpeCPfxJg3ul/EA1XqPCtR3xJq?=
 =?us-ascii?Q?1ploUIVyxYrX1cXvXMol2S4RASdoaIBNJeYpt7Qjy3zsMGTL3sFX/dkRhqPE?=
 =?us-ascii?Q?UWeaoMNUdgOyXBlhjZYWy+vAbQ+T67KQKYxDOpRvQganITb0IXbp7sSaWESk?=
 =?us-ascii?Q?Z16saigWBmSn1FYY/XGk0ANTZzVpG0Vl1S/DSpMW95C/yuGDBJq1qsDYJxAn?=
 =?us-ascii?Q?K1FLAJ1e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8285f54c-400c-41b0-6196-08d8c10fa484
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 09:00:20.5587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0NKWhQynCWLav6lqYwtj9KkxdkSo35JUKEla7WxNyGt+xb3dkqkl6iVzU7GDZDugV1C3r5v/J5oLFRv6IbXaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add JSON metrics for imx8mp DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../arch/arm64/freescale/imx8mp/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mp/sys/metrics.json   | 466 ++++++++++++++++++
 2 files changed, 503 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
new file mode 100644
index 000000000000..f9a89efc9b24
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
@@ -0,0 +1,37 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx8mp_ddr.cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MP"
+   },
+   {
+           "BriefDescription": "ddr read-cycles event",
+           "EventCode": "0x2a",
+           "EventName": "imx8mp_ddr.read_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MP"
+   },
+   {
+           "BriefDescription": "ddr write-cycles event",
+           "EventCode": "0x2b",
+           "EventName": "imx8mp_ddr.write_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MP"
+   },
+   {
+           "BriefDescription": "ddr read event",
+           "EventCode": "0x35",
+           "EventName": "imx8mp_ddr.read",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MP"
+   },
+   {
+           "BriefDescription": "ddr write event",
+           "EventCode": "0x38",
+           "EventName": "imx8mp_ddr.write",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MP"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
new file mode 100644
index 000000000000..e999e7b59261
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
@@ -0,0 +1,466 @@
+[
+   {
+	    "BriefDescription": "bytes of all masters read from ddr",
+	    "MetricName": "imx8mp_ddr_read.all",
+	    "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of all masters write to ddr",
+	    "MetricName": "imx8mp_ddr_write.all",
+	    "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of a53 core read from ddr",
+	    "MetricName": "imx8mp_ddr_read.a53",
+	    "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0000@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of a53 core write to ddr",
+	    "MetricName": "imx8mp_ddr_write.a53",
+	    "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0000@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of supermix(m7) core read from ddr",
+	    "MetricName": "imx8mp_ddr_read.supermix",
+	    "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x000f\\,axi_id\\=0x0020@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of supermix(m7) write to ddr",
+	    "MetricName": "imx8mp_ddr_write.supermix",
+	    "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x000f\\,axi_id\\=0x0020@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of gpu 3d read from ddr",
+	    "MetricName": "imx8mp_ddr_read.3d",
+	    "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0070@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of gpu 3d write to ddr",
+	    "MetricName": "imx8mp_ddr_write.3d",
+	    "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0070@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of gpu 2d read from ddr",
+	    "MetricName": "imx8mp_ddr_read.2d",
+	    "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0071@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of gpu 2d write to ddr",
+	   "MetricName": "imx8mp_ddr_write.2d",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0071@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display lcdif1 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.lcdif1",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0068@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display lcdif1 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.lcdif1",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0068@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display lcdif2 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.lcdif2",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0069@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display lcdif2 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.lcdif2",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0069@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isi1 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.isi1",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006a@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes of display isi1 write to ddr",
+	    "MetricName": "imx8mp_ddr_write.isi1",
+	    "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006a@",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isi2 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.isi2",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006b@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isi2 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.isi2",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006b@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isi3 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.isi3",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006c@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isi3 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.isi3",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006c@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isp1 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.isp1",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006d@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isp1 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.isp1",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006d@",
+	   "MetricGroup": "imx8_ddr_DDR_MON",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isp2 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.isp2",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006e@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display isp2 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.isp2",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006e@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display dewarp read from ddr",
+	   "MetricName": "imx8mp_ddr_read.dewarp",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006f@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of display dewarp write to ddr",
+	   "MetricName": "imx8mp_ddr_write.dewarp",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006f@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu1 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.vpu1",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x007c@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu1 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.vpu1",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x007c@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu2 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.vpu2",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x007d@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu2 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.vpu2",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x007d@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu3 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.vpu3",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x007e@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of vpu3 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.vpu3",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x007e@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of npu read from ddr",
+	   "MetricName": "imx8mp_ddr_read.npu",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0073@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of npu write to ddr",
+	   "MetricName": "imx8mp_ddr_write.npu",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0073@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio usb1 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.usb1",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0078@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio usb1 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.usb1",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0078@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio usb2 read from ddr",
+	   "MetricName": "imx8mp_ddr_read.usb2",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0079@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio usb2 write to ddr",
+	   "MetricName": "imx8mp_ddr_write.usb2",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0079@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio pci read from ddr",
+	   "MetricName": "imx8mp_ddr_read.pci",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x007a@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hsio pci write to ddr",
+	   "MetricName": "imx8mp_ddr_write.pci",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x007a@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx hrv_mwr read from ddr",
+	   "MetricName": "imx8mp_ddr_read.hdmi_hrv_mwr",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0074@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx hrv_mwr write to ddr",
+	   "MetricName": "imx8mp_ddr_write.hdmi_hrv_mwr",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0074@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx lcdif read from ddr",
+	   "MetricName": "imx8mp_ddr_read.hdmi_lcdif",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0075@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx lcdif write to ddr",
+	   "MetricName": "imx8mp_ddr_write.hdmi_lcdif",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0075@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx tx_hdcp read from ddr",
+	   "MetricName": "imx8mp_ddr_read.hdmi_hdcp",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0076@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of hdmi_tx tx_hdcp write to ddr",
+	   "MetricName": "imx8mp_ddr_write.hdmi_hdcp",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0076@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio dsp read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_dsp",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0041@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio dsp write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_dsp",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0041@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma2_per read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_sdma2_per",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0062@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma2_per write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_sdma2_per",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0062@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma2_burst read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_sdma2_burst",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0063@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma2_burst write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_sdma2_burst",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0063@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma3_per read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_sdma3_per",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0064@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma3_per write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_sdma3_per",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0064@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma3_burst read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_sdma3_burst",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0065@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma3_burst write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_sdma3_burst",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0065@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma_pif read from ddr",
+	   "MetricName": "imx8mp_ddr_read.audio_sdma_pif",
+	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x0066@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   },
+   {
+	   "BriefDescription": "bytes of audio sdma_pif write to ddr",
+	   "MetricName": "imx8mp_ddr_write.audio_sdma_pif",
+	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x0066@",
+	   "ScaleUnit": "9.765625e-4KB",
+	   "Unit": "imx8_ddr",
+	   "Compat": "i.MX8MP"
+   }
+]
-- 
2.17.1

