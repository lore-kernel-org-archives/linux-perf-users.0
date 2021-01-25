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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D36C433DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10E322A84
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbhAZGDy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:03:54 -0500
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:12315
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbhAYJSE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jan 2021 04:18:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJlaq/Jam+XfDFLfIw/JBhnGln5b/LfJXbm7AjG+hi+LEXLtrQbiK7xww4/xY9R1D/vuutuH5RzkO01PQqxJ5xUU3fvb9F4C16+7P2ss9+evJQNcSYDF8pCYN5DHVRahrR+c8TI4OOY8RaBLsiZPwrUrYt+UIc3ahPLfLlRMSgbb1NooIfdrwg4khdqhE7C/9XcVN1XT7pxc6eeX6EhkM9IatGQT09sGDEjIjs5i53iI+l67iKTuIWOdxBPd/SHskt5lxDtoi4HCbfcgsDetI/dei2V8rhlwJ8uHOn4ZFnGxz0g1cXAntHGJAE4DaCnfe1yqxEXHhavC1wZSoqL6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3F7j9sr75mtrlnzrgG/sVqRSxCLXmOLum8l1RirD3A=;
 b=LMPYogrLAlMvimo/RvuhLRYOcGAdHH6U4CPdFCsDe+NSk/wWInVEAGtAGGpUhYqyHFe5vKq5XiaKV2Q4wKJX4RTWE1oxnTg4j55JJsLG16RkSwUPnx9FkNgIvdQqslUJ9V1xs4SK194zwt6twaHyaQjoLipPeCF0POm/ueRlOexgjXTXNWMa1HzJewxaEbh9epUDGeg6JA6MOsUO6I+m6+lxMzv1BQ9eWgS5iyBLkV9qan5IfENyZpVbE72qtJE1NPnQJMfdF5n0xFdjJ5w94az/6QPksUDbUBCIA/fhh8ewhxha/9ktwcF9TC75yNq91TuP8hLvlz/tPdmHITNRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3F7j9sr75mtrlnzrgG/sVqRSxCLXmOLum8l1RirD3A=;
 b=QmpPmW87OWaYOPZiwpRO0aHcb/RoQDNo32NX4KeMrJ0aGfpS7FoumLFKbvWHh0Wo2/6CU1Q9irFBgUo4MewaLYFlXhMTE5/ktg5eMBwAyN4T4pNLHzFPcmRI77T+LfBX/6+ECMp3mQfZCN+1Q4WzP14LWrd9n+yt0onmHUGLHTc=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 09:00:13 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%4]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 09:00:13 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, acme@kernel.org, jolsa@redhat.com
Cc:     will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-imx@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 2/4] perf vendor events: Add JSON metrics for imx8mn DDR Perf
Date:   Mon, 25 Jan 2021 16:59:25 +0800
Message-Id: <20210125085927.27322-3-qiangqing.zhang@nxp.com>
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
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0135.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 09:00:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3c323b5-bccf-472d-fa4c-08d8c10fa0a2
X-MS-TrafficTypeDiagnostic: DBAPR04MB7366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB73662284D8EB522149220179E6BD0@DBAPR04MB7366.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLSjxT+Lyj6gh0rlsqVMhEtPBCBVK+Ch8QjPhQwcAFWzhvLB2HHdVVV5czXungCYbb5GqabIiPE0nSiFuL5adjRSCV8Sdxx2Em16C/RIEg4TnnJBFyVN7RR1BHFr7g/1VPQYVJLHoxbhNV/x8rOKsglrgpKw+5GL/f/l2fDIq4PSF1eaWQVfGwiigyz0kAmNqKbeifbYEFT7NBIEDeumxEOtuyRxQvo9MUJvk9LjXgg42D4DaoWM+qBNOMQnAMPMI6AnfW/beLaO9u7H543hbhryzHX2ots3N9chKm8ENvuuCe/UJifZyOkEzrJLn5tGl5PmH3nT2vuVSh56rW57TOA1hOC/kSzwsrRZmUrE5vCiGVvR0fJ8Z9MQhtf45pYRsLGTTzCNvelT9VTzqQut5yfnC9Z4OD3DsFagWRRZE3Z9HVmk8ve8SFqu3OWSXrOuM91aB212fnRCvlYh3gUkng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(956004)(2616005)(36756003)(52116002)(86362001)(2906002)(6506007)(6666004)(6486002)(6512007)(66946007)(5660300002)(8676002)(1076003)(316002)(478600001)(16526019)(66556008)(66476007)(186003)(8936002)(26005)(69590400011)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?j73SRz9TGCzeZbnVZbkTBrYl+d1ntbY9nCPupXmuLgkTIEHdQDxTm7n0GbCw?=
 =?us-ascii?Q?mghg3yMWrdcBmov5OpUFpwvrfmhEhjXgNQG6wvXmzDTbDEbuKpzOjBnTjCfy?=
 =?us-ascii?Q?Wba7pyXdQ/TB75PEdPFJ3TbI2s5cHzrdOzYcSY30mFrzKhFMaqEwQ7MQ5MGa?=
 =?us-ascii?Q?8LLAuQx0jJU4a9xSi1ynJO3GGa+DzHEaTVs2BOibJNP0AqnQN+NRvIdIgu0X?=
 =?us-ascii?Q?iM6RMblTCAyH6weftfARJNBpiAR6SDG2MiDizbSfRzNLYlaQUsg+6ZFVRd4v?=
 =?us-ascii?Q?FaD/ULxCUjt0QPXgkzyTsa+psABB/z2058hUevjnfmVRZuuoYCGwk/QrfYGH?=
 =?us-ascii?Q?NI5R7XOKsmiPq5si6tVVmjoaNUvs5QXbx7kCi2bz2uGkAt9DwED55V4cAssd?=
 =?us-ascii?Q?Mydc/FjaVdhIWKZuboKyabAhakZ9CLwuh0I+SI+DCmUueiATA/m70N3eFywh?=
 =?us-ascii?Q?62+EOtT6F3dHT05IG+I1Ro3yRkrKZaTt7Bg0yTDpBZ2w3xT00B1hHNoy7tFJ?=
 =?us-ascii?Q?xy98p7JNxgi4UV+ZuUYTZe1Nz6RgDHuhomlorzx0mNWXYF+dcPFPqNEHUT8S?=
 =?us-ascii?Q?JgxEjjQSp5aGU73qHkuDa7+bYIm+bSYhrH/VYJAj/53cgDxkZ8KLYoE4r8FG?=
 =?us-ascii?Q?tLM2MG//JCCqDIIop2psxgdDpZkkv3C8RWJn5tS/uRuUtCap4O+kjtFvqODh?=
 =?us-ascii?Q?qmi70/D6dFK7JXJvNqfjXKv7rQZbnAedY+2nPYk35KAU0oVh9SaFouBIXXbT?=
 =?us-ascii?Q?LLpEdWxEpNu8SHIydb1LL7oBm+6YSaIXWmE3MRZSYAtMQN2mZTOCOm8cklBz?=
 =?us-ascii?Q?egps26FTEdJaHYE5qYy3ti++GYVIyV+FCWluP4ObrUhjzGnQxab7WO6herVM?=
 =?us-ascii?Q?uLC5wcBJnrYccWsFWPWBy05norqkL/3OI0BfLejDxTGzuMiGAzFACt6FMTOn?=
 =?us-ascii?Q?Nz7SlGGzzZQ8Lb+r648WDc5jxRqxiSEW4tTw12t6Yzt7v7pM34lhYT0CdAnN?=
 =?us-ascii?Q?aNfsSi2r647gFbwaW2I8fMnO0FBb2lDYyaern+fgkfAbkL2FmyU5z0TSethV?=
 =?us-ascii?Q?j7N4JnPy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c323b5-bccf-472d-fa4c-08d8c10fa0a2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 09:00:13.8492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCjbq+dLayEtsPrjtlpBg69fbanrQjelTvye0wLNlaoa0Jf0WhzuyaBItMPeipScxncqv5c3UMML25St5jrdgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add JSON metrics for imx8mn DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../arch/arm64/freescale/imx8mn/sys/ddrc.json | 37 +++++++++++++++++++
 .../arm64/freescale/imx8mn/sys/metrics.json   | 18 +++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
new file mode 100644
index 000000000000..8352e73d6d35
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
@@ -0,0 +1,37 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx8mn_ddr.cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MN"
+   },
+   {
+           "BriefDescription": "ddr read-cycles event",
+           "EventCode": "0x2a",
+           "EventName": "imx8mn_ddr.read_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MN"
+   },
+   {
+           "BriefDescription": "ddr write-cycles event",
+           "EventCode": "0x2b",
+           "EventName": "imx8mn_ddr.write_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MN"
+   },
+   {
+           "BriefDescription": "ddr read event",
+           "EventCode": "0x35",
+           "EventName": "imx8mn_ddr.read",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MN"
+   },
+   {
+           "BriefDescription": "ddr write event",
+           "EventCode": "0x38",
+           "EventName": "imx8mn_ddr.write",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MN"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
new file mode 100644
index 000000000000..2bbba4d8ea5b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
@@ -0,0 +1,18 @@
+[
+   {
+	    "BriefDescription": "bytes all masters read from ddr based on read-cycles event",
+	    "MetricName": "imx8mn_ddr_read.all",
+	    "MetricExpr": "imx8mn_ddr.read_cycles * 4 * 2",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MN"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
+	    "MetricName": "imx8mn_ddr_write.all",
+	    "MetricExpr": "imx8mn_ddr.write_cycles * 4 * 2",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MN"
+   }
+]
-- 
2.17.1

