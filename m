Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7F2C433E0
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 02:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3137D20848
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 02:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbhASC7g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 21:59:36 -0500
Received: from mail-eopbgr10060.outbound.protection.outlook.com ([40.107.1.60]:4855
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389429AbhASC7f (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 21:59:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1vAs85zM97OLnnodBxi5jq97UapEZd5snNHPDRI6o6xXEnqvNiYNG87JsZoFfF3fZi7YhoUJjFHO5locVvDqfvBafGloTq3NN1BvBqwyOxKbeEp095WFZhgEb1krkXl5UzTugEAQxkXiOgJYliL4t2+Rikg3p8Q+0S8C+EHKdjd3JuSQPPUnEbUejJO+DADqNnwWx6ZbJis+KseZgQt5r2ce9llVl9qCcmTTIkVa46/Tkzh+K2JgSpO1yXocBoHhoh/aLjqlPLRJqkvkZZdYmXccWYQ0SGzRFkolKrk5rWc4M7xoIY56LPUh6iVUpu4UZ+Redk23AnLZLM3bCJ22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il4Y0TQnZZsP+aTxfvHxeH5iae3+B3+Rqf/s3CeGIDQ=;
 b=iwMhK3y6mWBgQFwMy0svYNHH78yAmo4UciLWwK0t8XBqtXuFFqlHS+aexEb5o2S9OQ21Nx8PlttfBVxqQ8Wnjs9ghbpEw04SvFmscnGzAlBEPJGaboAj5pR8ayZNPBpIkD/4OntZt3mXn98Og/d5YegozvptoOGzNgP+Hvd0iL/OBGRWrrAwnkH6ziQV8zPcFGGkn6UsxDlJy11oI8sRM3cNpZD0gJ6mpskxVAXzi4nsprp9ZPWMqBtKmy8s+RxxlTF0FVWZ4C5cV8LFrUF+YxPRU2UuQnvTxYpUpBZfZdbZFRdk/Yrof4IXO77WpCrzWoLkSxt282aKY9QkORhdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il4Y0TQnZZsP+aTxfvHxeH5iae3+B3+Rqf/s3CeGIDQ=;
 b=SXCvQn49czyZiKeUzKEuWiILk9WlhP9jEfdZrsxihIIGV3i0YwWpKvQH04yGK2GEfUonRRGJkjogMZAT/oU4WnNQwY5QUAdvFigYXfusuHG+Ao3VgmWuXJmg2IgXE11m7KE2VVI4XIqHuS+hg5vi3bXenQIL3A53VfqLIBxHQEI=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR04MB3208.eurprd04.prod.outlook.com (2603:10a6:6:3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.14; Tue, 19 Jan 2021 02:58:18 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 02:58:18 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, acme@kernel.org, jolsa@redhat.com
Cc:     will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-imx@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V1 4/4] perf vendor events: Add JSON metrics for imx8mp DDR Perf
Date:   Tue, 19 Jan 2021 10:56:47 +0800
Message-Id: <20210119025647.12569-5-qiangqing.zhang@nxp.com>
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
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0231.apcprd06.prod.outlook.com (2603:1096:4:ac::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 02:58:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5565028a-92b4-4a9d-d65d-08d8bc261259
X-MS-TrafficTypeDiagnostic: DB6PR04MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB320863E89DC11E8372E055ECE6A30@DB6PR04MB3208.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOxCpeqxL92WQ+77yM29EtmXDciIHbkuPlWQQrSCuK8xi5XJxK1Lmq2FWrgTX1tkM/mkvJ75B4j3mLWJpVxfZsi+X31raSG1DIIClUsCGSYXYgN1XjkTRJFXmtI0KREoxHvjYc31mGp1aPvWaN864Bz7n50B4CT52Hnpke76TxgpSCk2reVqNE60Z421nznnr5EmR7nXSYK9oRV6g3qGJCvqg72iOeINr6ikdTYPZh2lt8CtQtHIGVt2wc0k4VSf/oeZPxcU4vUBfkoNlTgLg+80rsYPnc9BAlhAdvFoC/7D2LKt8vflPUd1053HSXO+GTsyEoNhG7fQh4H8hUGMJjmoXgqMq8k/GLhYPjBzQlIJdj/Qu6Nxg5T12YMsGMfp5hxet95xanqO/vQR2sUTYurMmpOwkXYEqoAl0lQ5+E0CIP3xFNdwtcoCw0Qo11tN+l+SsVPN2nRxPkIXqDA1rapfVkQ7DKjdcVz7mZHlmUdoXxUgxPGIRCaK7fsq5CWNMApYH0vXdx+zOZgqESvrtJyOElIxcreJPUthK6oXF0P+VFaIZd4r5jICHT/uMHbZ/GoX4uWDzhprTZD71CD7guP4cEk61k9lamj2GOaQzr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(36756003)(1076003)(6506007)(956004)(30864003)(2616005)(66556008)(26005)(16526019)(8936002)(5660300002)(186003)(52116002)(6512007)(66946007)(69590400011)(8676002)(66476007)(6486002)(4326008)(6666004)(2906002)(478600001)(86362001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?I8Yj6V78Xq1mTyPlQYU6sipBX1e0itMwWXG3thEDibns4w1ImTXZ9X+fz4c9?=
 =?us-ascii?Q?mHA4U/2rV7nBmwy+kicWx7fJwu8NrTtWvcxdrnnZqBsnHG0V0yT2BkQDpYhR?=
 =?us-ascii?Q?z4augifCKtHuXG7Epxjx7RJScMFKzA0ssooRRxg7qu2x6SI40on8Sv7MTDE/?=
 =?us-ascii?Q?fa/cHqG4irRLtAqv0AqIO0HWhtU2rIpumugiIgsRWUFSKGiewIWFXbgFVUig?=
 =?us-ascii?Q?DJIf5dpCko7owVWyl2ETrBfRIQGIAQpbw+24rV1lB4tzVkGr/gsbuy9tXdTc?=
 =?us-ascii?Q?nsoQmNPCG1dwTWO/vlnrfH09WGLX/MVFrDt87rDcJ7SzTSDZGpoOmoCvYvzO?=
 =?us-ascii?Q?YSBU0hWL81Acr+BRsBYGqXI+QNNnPxOxayLO5FeSFK/WcaMRTWzptUtl0hrD?=
 =?us-ascii?Q?yRo2ArsE+98yNyeeIvizp87JQ6w2OSc6a+W5L9KvLlys91Pg5woqkAz3Okvo?=
 =?us-ascii?Q?uaqXmSuz9AOaFsXPyJgaUa60AVYsLN3LsrFDN/faIjxjnbnXxw+rNm705ML8?=
 =?us-ascii?Q?bAqN+bgydEtfYmCgBk6bn7BIUU+8MEjMr76/ckJ+cqf3VPSwbUrOajghqJd5?=
 =?us-ascii?Q?cajkgJIWERWgCR4/vR1bMVVSaz915Ea2ENSvxT9qicqCgxYFCEUwUs4JP2/p?=
 =?us-ascii?Q?+G2O8fYsPTZYFEPckft/y+gD6djJ4kpbMXr41+zmjGOrwzO0ZrwfbzkrIHb1?=
 =?us-ascii?Q?5tqEi2pB+lKbPs+4TXnOGCKg5VYoOup6Z8JlvDgQjn1diWCRsZIUdv7f+Ndm?=
 =?us-ascii?Q?msHqte3kwi+ZiwhGUL1aNA1Hk6SqecynaoW2plqY8Cl2IXy/7RZLRkdPFcwn?=
 =?us-ascii?Q?DSOhLoofMEpM7uSHvwm8OUdYPE7tauGBG8+fan3Zawp6W6wI8uRZHyXFe1U+?=
 =?us-ascii?Q?vwfeOlWAVBMdslgCAB8Mt3RXBIwK6DV/W+AQ4Vvb+mf4Uu9VZENq1HOK8pHH?=
 =?us-ascii?Q?cOX0xFiNbpH9MTIbb3E/Pp9wQVgRZiYE8UsWNBbFSj3EjWatgtLejSO4/wnL?=
 =?us-ascii?Q?a7tn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5565028a-92b4-4a9d-d65d-08d8bc261259
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 02:58:17.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiLJTJbAPRS8yBAz9lelI8o3RZGrnyPbtq0CmEPSYYicOgVFYriB98RgUNCoJ3El4v1MlGQq5PfGuRnIb8LlAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3208
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add JSON metrics for imx8mp DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../arch/arm64/freescale/imx8mp/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mp/sys/metrics.json   | 474 ++++++++++++++++++
 2 files changed, 511 insertions(+)
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
index 000000000000..862a45c4dbf5
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
@@ -0,0 +1,474 @@
+[
+   {
+	    "BriefDescription": "bandwidth usage for lpddr4 evk board",
+	    "MetricName": "imx8mp_bandwidth_usage.lpddr4",
+	    "MetricExpr": "(( imx8_ddr0@axid\\-read\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@ + imx8_ddr0@axid\\-write\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@ ) / duration_time) / (1000 * 1000000 * 4 * 4)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes all masters read from ddr based on read-cycles event",
+	    "MetricName": "imx8mp_ddr_read.all",
+	    "MetricExpr": "imx8mp_ddr.read_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MP"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
+	    "MetricName": "imx8mp_ddr_write.all",
+	    "MetricExpr": "imx8mp_ddr.write_cycles * 4 * 4",
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

