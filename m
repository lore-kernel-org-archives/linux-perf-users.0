Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AF6C433DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 02:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4441120702
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 02:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbhASC7N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 21:59:13 -0500
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:4855
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbhASC7D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 21:59:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2TKDdjbQnC945kakWNmURZku+QADknED04J2L/67jgEe6Tty8uaj0pzLECphRdUpfO2BHtECoiaGj9I3nZfAmG5uPJyj0cDLquIkNSorl6ywPaYU2e0uya+AEWR0+SLPYt/qsnjQE2Kx3/xf5DwmM1mtcuX+GkC4ocxGGzFIAckEW7gLC2ywl4EEpmsUG1GLQzX5jrg7UnXlzompCLJSljNVQb3VE7XgNbdoUsoBUmbNicabJ4tfBYDCeJYGLYGooSgctZfL+p0w99G36kV4QniXXmkivMHiYw+s950UMGQ/gALr63GVU75XtrY+iqu3ChXYMu5pRqXKcgvuUqbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2/irs94rONu4l1lTGrbeawZx802h7ywLDN4IElNw3w=;
 b=BMsmaBgRAbat7IqtOf/ct/VbAVypzi17ggXT15DXGS0fACDTl90q+qG4Uy4ayGtK+LdkmBGagxLvV3df1tAsy/HI2Pj0BrUXvHtkEUKg4CQdn0WHSPzGTL/8iWwVJvwEvMQRth4r3QHx4YTWgO3vueappJslJcJmKvMdxu5ggjbg3iLbbhMZd3t1lr9ia5ghTyuMHJdhiCU+I/7Tqn/ltThZozMCJ2AMINjIjSnIVzRCgJAR3INeFfiek7vFo9yhqKkiuBA5JF+IR9f6CDppg7cFqpQpuQK/Q4iNhwiHF5vEjG3d+MaoyIUnM7dWb8ZG8l53mKL35OT0j5gra2zzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2/irs94rONu4l1lTGrbeawZx802h7ywLDN4IElNw3w=;
 b=Zv3HaOEuW35EovxUYoPfurY0egdLp+RXwFAMyCMzyTTg+2Pip+huhykcDuGO34ug9jydB8OFrhT0bIIVfBtZm3DIAGPUdxYzVwtA8eifNo5iqTwybKhYh0gwB/oxi9mXls2S3E7Tme2OaXK0jhG8FriiFZDPSnB/0nbc3Tj3Uv8=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR04MB3208.eurprd04.prod.outlook.com (2603:10a6:6:3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.14; Tue, 19 Jan 2021 02:58:11 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 02:58:11 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, acme@kernel.org, jolsa@redhat.com
Cc:     will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-imx@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V1 2/4] perf vendor events: Add JSON metrics for imx8mn DDR Perf
Date:   Tue, 19 Jan 2021 10:56:45 +0800
Message-Id: <20210119025647.12569-3-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210119025647.12569-1-qiangqing.zhang@nxp.com>
References: <20210119025647.12569-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0231.apcprd06.prod.outlook.com
 (2603:1096:4:ac::15) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0231.apcprd06.prod.outlook.com (2603:1096:4:ac::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 02:58:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eee10435-a9c7-442e-fc62-08d8bc260eb3
X-MS-TrafficTypeDiagnostic: DB6PR04MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB32080657F9ADAF9882267312E6A30@DB6PR04MB3208.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92mpDZvdeXsry/fRUbQiKsYst7OM+yEC/LyJxT5LJviAmdBlINOEqk76jSjvPtHDTwP5nejYYlILUFk3HMYpNl3TygIgq+KLNRiB3N5i1iBSYfO6v5+vIN3yBINbWexLonqhepbGL0LZAADqUrNcYfmTT6apK85yhHBK2EHPNR/lTgK4QbGXHjGpZbdlt5EhkjIl9hkJzoYx1KiXxErPpO5yPKLPhfcT9uGzy/1A9/WhiM6my/YSWPwu0ffuOq0eqRlOwzHCJHYR6gtaz6EOFLL3DuFqxH72PJZt23PPM2zgFEDi7FzClEb3CQmgBCkvDT+hywQbkgRk3t5yb3u/FeyWpojDkBomymRsgHxdhpt45fd1EkGiJltgxbVPBqnINAKgekLvXctsdqJ1JADkHfyrt392pgYscH52S7iN0Jqd2pxZxy8pQ/Eoqv/2G69jAivhSsH9qPc8JFPVSAhs0sJpukzZtlIW1nBHItLAQiz64wXGvGi6ZIlgxTOcqV+aoeGgl90LmoFSHhP5uEUwuB7/cqntXBQUJa+g4ptrmnCR8gPFNqE3uX2wNYaK6FpigV6QdjrPHgYagGn+75u/qXARTN78AtdLfYvaYkGVW+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(36756003)(1076003)(6506007)(956004)(2616005)(66556008)(26005)(16526019)(8936002)(5660300002)(186003)(52116002)(6512007)(66946007)(69590400011)(8676002)(66476007)(6486002)(4326008)(6666004)(2906002)(478600001)(86362001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wP/31k4VNatVPMfv7KlTbkGOukoqLcnqeW1PDI0DFaQe6jQX4xt8LHwNQ4A/?=
 =?us-ascii?Q?6Sq1hBLJvxqhEFSTGT37rd/QjS5jWadv1fC67gN3fk8SLOSfZx0Ndl/7gjH0?=
 =?us-ascii?Q?O3fZ882lZyBZaHMaoO3uTBgs4DaHvtj0W8CitI4fNbNNY5B9fEmBvX0lITps?=
 =?us-ascii?Q?+J3eiPrSRjfCAlBf90ElzCuD3LpphtWIkwhdPjiOsw0Vkf6ddmwansvWkzp7?=
 =?us-ascii?Q?O56mhlBja/1WbYTjpD85rc5DulDi1dUZwBbLJk77WdwEc/6O87DJcGr5MApH?=
 =?us-ascii?Q?Am62Q355L/SDGpBJTMhuln+KwGsOZdiPzOviQ1N2FTK+DGXXke3W0uBo5QTv?=
 =?us-ascii?Q?0YXsB7tWFrUoPkiZDZdPFmGzdIAzXUbc3aN8DKSzJPCkAHyT+/1SYKyJQNI9?=
 =?us-ascii?Q?iRSw5OrU+ZAY3VatmKQAKOq1RocMm4FZBslFCxyq8c9jolUkRiTsFOhYAbSw?=
 =?us-ascii?Q?1Dz/T/JS2A1wsqUINlEXN7lXohPROdaMuw6kFTIVshSHBI7UJmnYs4dL073C?=
 =?us-ascii?Q?hNkN3SuU5EZ+gftrtI3PJ7ahrxwHwxmEQpEODSDu91LSKA4jJsOzN0GvKLJu?=
 =?us-ascii?Q?moMuxTRhr6Aik0GgrJewLO/YIR0u178RWZXji+gX8A0z9KfbC2VtSiG/6gub?=
 =?us-ascii?Q?YSf22JjC7zUcCt9jlD5k4rNcUm37ur5f14ZURW54Q8epuVrm+0FVUrE5aVsQ?=
 =?us-ascii?Q?DmykoQ99kG5I6h/wGpMqPVnHFOAWPacbva5MgOYwKW252ify43q5i63ja8NH?=
 =?us-ascii?Q?A8gT3lQjtMgT3nuEzm/2DFmxSZ3GhCaI7iP7kTsAEQ8mYkEEX2DBite2YblN?=
 =?us-ascii?Q?69/t7XNkbQHwPUeUO/f420bll3Nk3IoCtbjUXF6wPha5UOawxx/CzxfiGcQx?=
 =?us-ascii?Q?EI/Q/r+bQuIYz1tMQ2V7o3jO0KT/9130o8BvHpI7LsUPWfwvZ3/2PjsCnHnt?=
 =?us-ascii?Q?IzYUVvUiEgB9NIMTjsG1T9bfw7oisj/kNhc0lfRSPl2lk1jALbl+cc9iXEI1?=
 =?us-ascii?Q?dgvK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee10435-a9c7-442e-fc62-08d8bc260eb3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 02:58:11.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0BL9B6u/AVIqccZhkjwE5eGdL3Xb4KFg+drCTByHabNNDnOK9kXgTltaOKedZl5M7VI9DVpq1QpCNwe+QmK9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3208
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add JSON metrics for imx8mn DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../arch/arm64/freescale/imx8mn/sys/ddrc.json | 37 +++++++++++++++++++
 .../arm64/freescale/imx8mn/sys/metrics.json   | 34 +++++++++++++++++
 2 files changed, 71 insertions(+)
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
index 000000000000..f71f6b0f3822
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
@@ -0,0 +1,34 @@
+[
+   {
+	    "BriefDescription": "bandwidth usage for lpddr4 evk board",
+	    "MetricName": "imx8mn_bandwidth_usage.lpddr4",
+	    "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) * 4 * 2 / duration_time) / (800 * 1000000 * 4 * 2)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MN"
+   },
+   {
+	    "BriefDescription": "bandwidth usage for ddr4 evk board",
+	    "MetricName": "imx8mn_bandwidth_usage.ddr4",
+	    "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) * 4 * 2 / duration_time) / (600 * 1000000 * 4 * 2)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MN"
+   },
+   {
+	    "BriefDescription": "bytes all masters read from ddr based on read-cycles event",
+	    "MetricName": "imx8mn_ddr_read.all",
+	    "MetricExpr": "imx8mn_ddr.read_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MN"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
+	    "MetricName": "imx8mn_ddr_write.all",
+	    "MetricExpr": "imx8mn_ddr.write_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MN"
+   }
+]
-- 
2.17.1

