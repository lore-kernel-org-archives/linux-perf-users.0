Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D5C433E0
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 02:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858AC206F1
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 02:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388693AbhASC7d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 21:59:33 -0500
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:25915
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728506AbhASC7a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 21:59:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxEiSYVlXa6BOiPlCvyrDPm3CNdgkavt+z20eo929PBt9lGNVK2mKZSq3ThrgOd4GX6WXwFIQHqIKuW/qI8nYFIr1GgNblkZBOnEfG412dq8YlSXKGxA1RC6xMKfVmy88aERirzUDya9/eCtK4XKkiI2/sc+EY54QeIz+tbNPyGFHF6PQhWyCeP0zw+jdwUmE3ZkZwS4iCkCDkfiivz7jTP0HC5lQf+D4aHoz0j4HgIvXgb1i18yM9p6bxNMNoJ0ukDJ6XkgCPJ3LPA6R8jZ0DatUjsBpQjCh8xvmrMEIdnytcZDG8V8olVgsvZE2rIlEjHKz+C9WiGHixyhlvP3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqdgHv3Wn1thkJFioUq3L6g9Oote1LH+IcQOmFEdHDE=;
 b=OTy9sVbYxTHt3Rhhiwx5WCyhTOksTGvz3ah34x+tSMgfYGlHnUptsZBqoNHiVD70v7YJxRGRMuTgiI4e5dw6PZZVmziWBlIsFImiya4Lz9CSY9RMiolvlELpm4/6HdeE32AvGU6sxLI3t9F7TrQgi6OsmiozjQD70UaUk9Di8YORzJx0HdjQsIKlhwPJUdsNTgetzQ3Y1sBEDQHfaQEcFj2R911WmUfStS9REcBV13yBk7j8SRABFs0OMwkHX+SFzvRGoiS6TSIO0ZJaMcmnBVSgLK2oRnj85dd2JcVjVcIWN7HAmDMyV9WFsHbs4+CYYUtDd+Wpk8Wu219F5fVKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqdgHv3Wn1thkJFioUq3L6g9Oote1LH+IcQOmFEdHDE=;
 b=PxcqkXFXOpnvVL9IknQz1rQDF9afGxf0Jkyvfn1JpTbRNdcwOr05HOFjH9BRDK+NMccSzW0ngppKTOesPUiFTrqssns5okNpoBLN4Druqk/rjgCOS4j2EYiFG7/hZ1MK/FDfbb4M9eHJ61IoOkewhBeUhvS9KLn5T04dSXX3RDE=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0402MB2903.eurprd04.prod.outlook.com (2603:10a6:4:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Tue, 19 Jan
 2021 02:58:08 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 02:58:08 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, acme@kernel.org, jolsa@redhat.com
Cc:     will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-imx@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V1 1/4] perf vendor events: Add bandwidth metric for imx8mm
Date:   Tue, 19 Jan 2021 10:56:44 +0800
Message-Id: <20210119025647.12569-2-qiangqing.zhang@nxp.com>
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
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0231.apcprd06.prod.outlook.com (2603:1096:4:ac::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 02:58:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e02b34c9-580b-4353-aab9-08d8bc260cdb
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2903613F04C8CE400346FD0AE6A30@DB6PR0402MB2903.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJYSrwqN3284Cqf+ib00JEdSrmLuIXOznfopwktfC8hJm6j40IFSu628fSV4ymorGwODFhSgNHDAhvo5ip6xMTunHDPEtjjkFov+qtVsgsQ7G3ANkW5aS8x0pZ5HCdHaUiSQCtE/cN+gHaArPKHTOFPUquS2TKQBfKYjSJCXNSrCc8i+mVgjZdgIkidvByh7tUVwLtZ98xMUdrMZBtPSj3wKnZPdFH+PZnrtpBUUDVF3qEzQL5V/H4M4qn/qsj4I4XtGVA9WElVBGpoO6pOR8ZISCMB5V+PxmkxhBKmg/QPlDAWA36twF5kxZVyjTZwPQpwKLgjhEXUHS4rWNNQwPI/3kkprU+58xrpBF5QeGL/vKa2v+5kG/ANWZjrOOQFZkb2PnGPYnLqydX2oEQin+vXcuypKPi279AC75p9ZJfMUwLib5HEBn3Ryic0suA1KMwddayXWHg+oy8zu65HhTbwTwez0mxt/iNbPiATTlFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(36756003)(8936002)(4326008)(6512007)(316002)(8676002)(2906002)(86362001)(66556008)(69590400011)(1076003)(6506007)(6666004)(6486002)(186003)(26005)(5660300002)(478600001)(16526019)(52116002)(83380400001)(2616005)(956004)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AnPxx0p9bbCTRTum3VtQL7mfgGo20dtrQfexP7ua4hejifuR/P2T0UaafMIZ?=
 =?us-ascii?Q?UVr+A7RLhPV76PZTYbV2FSK5UEiMcmR43CBZqCkfWcCTHtt1IL/oSZPS8Jpx?=
 =?us-ascii?Q?eL9CpXpvZMnObb3jWg75HJla7siXg8oaxb+UdXtrslsZCkfj4Ou04tPDNhlE?=
 =?us-ascii?Q?vNNy+H0sirtUtHP6l4mgD8bCnJTdVwzfaTYH06jP0lpmF0lgmXhA60ryje9V?=
 =?us-ascii?Q?Tw2iEMP6BvgvgPYKxrRyThXI/V4xIXLg8DWeR2XO5glLTbCwTlObwArHA6gF?=
 =?us-ascii?Q?2FIB4jHdS9GZPru6ZoUYa6drwb/nU8ZAa0hxdADn/LNiK6/9/9hkoxnRkQ3A?=
 =?us-ascii?Q?B0gOAyrDsnRIZzCsxsb7HPthH8GlHI+kTxJgL6ic6GDqsYKEjbwwht83ly1/?=
 =?us-ascii?Q?JtwFJofgdhTXc5h/LJMuSeCMv8D5O/ltWFuw/LaDiH+x4v4dZAntEq4KyC0O?=
 =?us-ascii?Q?aVJgkL+LLbQJYtxpFdVEXU6OWoA8kALNgJpneesm/JIjjxaVKdqYRwAbyw9d?=
 =?us-ascii?Q?2MndoNxg2w/kVt81ShpRq6PKcH/CZjGVksMr935ykMQd36rW6zs8JdwLLpyf?=
 =?us-ascii?Q?4SnyBxznFXVnOO7Ntf02Ijy5PFTnGRrK/+XxfXNXrHZyOvxlRZxd6Sqpmwtt?=
 =?us-ascii?Q?aWcqRQgC/lVt0DjkgWH1DJzIHQA2lZfV1eTzW9ZhBegnuS+bzReQg9Lyjafo?=
 =?us-ascii?Q?TNeNUxbl0XqjJQ6CEtKePsD7ybpG/J3O57yOB0Jwwhsn+mT1H7IzHrxmoh9I?=
 =?us-ascii?Q?xlX9sUE4xnxB26U6Y2t3ZJr1a1Pqk411dfTxPmNY1Hplbr9k/3usg6gqxpSm?=
 =?us-ascii?Q?VT46AMiRSCzXlNtTnhjZk2sW09+T+wxyjdgDgmLfI7RDiclDlD20C0w44nmi?=
 =?us-ascii?Q?GNUHyvDQWbuqqng90BQyRfAm3t7/u0D/U0N+uRmV2u9e6RWDv+SCkBjCuulh?=
 =?us-ascii?Q?WVRuwjLpucHj44r6OiH1XDTqKidN2wfCR8lcqvuuwV1qTYvncE420Kwrhc8p?=
 =?us-ascii?Q?zsf6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02b34c9-580b-4353-aab9-08d8bc260cdb
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 02:58:08.5159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOjzwCmDBQiEa67Fck/7dT+TIHL65uV697Ig3Fd3tPYtP9ZiEj4TtOtg5gvQ2klGJfdyCAMMAjAzGFMNxGCOfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2903
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add bandwidth metric for imx8mm.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../arm64/freescale/imx8mm/sys/metrics.json   | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
index 8e553b67cae6..615be286ecaf 100644
--- a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
@@ -1,4 +1,20 @@
 [
+   {
+	    "BriefDescription": "bandwidth usage for lpddr4 evk board",
+	    "MetricName": "imx8mm_bandwidth_usage.lpddr4",
+	    "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) * 4 * 4 / duration_time) / (750 * 1000000 * 4 * 4)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MM"
+   },
+   {
+	    "BriefDescription": "bandwidth usage for ddr4 evk board",
+	    "MetricName": "imx8mm_bandwidth_usage.ddr4",
+	    "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) * 4 * 4 / duration_time) / (600 * 1000000 * 4 * 4)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MM"
+   },
    {
 	    "BriefDescription": "bytes all masters read from ddr based on read-cycles event",
 	    "MetricName": "imx8mm_ddr_read.all",
@@ -6,7 +22,7 @@
 	    "ScaleUnit": "9.765625e-4KB",
 	    "Unit": "imx8_ddr",
 	    "Compat": "i.MX8MM"
-    },
+   },
    {
 	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
 	    "MetricName": "imx8mm_ddr_write.all",
@@ -14,5 +30,5 @@
 	    "ScaleUnit": "9.765625e-4KB",
 	    "Unit": "imx8_ddr",
 	    "Compat": "i.MX8MM"
-    }
+   }
 ]
-- 
2.17.1

