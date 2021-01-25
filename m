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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECDCC433E9
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9A422A84
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbhAZGEe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:04:34 -0500
Received: from mail-am6eur05on2053.outbound.protection.outlook.com ([40.107.22.53]:61261
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbhAYJUM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jan 2021 04:20:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsZDyJHTtHrBWp/VItClK3AzoUB7YD7i+31qGE/CIb+IoV9rJvsKLHB33C2e6IBzOJD8Kww5Lc+2N7I3MJt+nV+9pymXEljgWxQkkQQi9hPTsXdQQP0oypS4u0W68g0lh6P+5U0IXvilJQVWoni5txRyGLhWzvL4VM0VxWPu6WYjCLa3wfLbSp5zvgf6B0OPKtUQ77U5m2X90XnkvKa3kTtjlsMUzYOGQZD61/Mg3kaaQlxDwiLYc8S3pils7WhIcNxQbR4c9a+1w6DyBrFYI/jRHx5z3BUzbYUEiv+6Paqvvr5pm9FqKbqgYZbgr+m9nIVDRzKEsxVnxHPHqe+68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtj79xuZInN6B+XVYTfqBLh9adH5iY7mutTyImwfCsE=;
 b=IS4tnOqtW10w6Ng3PC7plBlauR5YtWH8+3FuQkWhlzv7eAGQ/xyUaVpZk6Mu4+5h14H0bvuoSMv6e8rzXF6Fi9nxD4nEcIOPIxW8hZPHuimnkyhFeYD7YARRVK2YxQi1KDIVJpLKX7kDp9LPq/br9ydf0fF8LvYonth90T17fiMC103rs+ymGx3gxA+Qnr/KmzfjhUmaGpvCkjWUrNessQTmqhAMMXAmiY406Rx06zEwKweRSxKwKoi0sXLLEAdz+wWrthnB8MtTASLzWoJIFBHWJaAyloa8R+gf3C3WlIeMbYpfHrAXYKqrNs3GOd4S6+Jqtwm4zWjrhgh7xbT53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xtj79xuZInN6B+XVYTfqBLh9adH5iY7mutTyImwfCsE=;
 b=olA2fif3FrQ6haXi+Rv8tHb95LKmdCwVQn9ncLG6IfUu4jqpJFvpMB78T7ueHH86s0pltMCOcc/+VhRy6bHi4TUZxdwXcd+/Hn+jJkeM8J45pef5D99/yyGWr84CgW4hhZVWKPIJGekhdg9TeOzFcemzD4usdMqVpNHp/bISL/s=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 09:00:17 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%4]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 09:00:17 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, acme@kernel.org, jolsa@redhat.com
Cc:     will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-imx@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 3/4] perf vendor events: Add JSON metrics for imx8mq DDR Perf
Date:   Mon, 25 Jan 2021 16:59:26 +0800
Message-Id: <20210125085927.27322-4-qiangqing.zhang@nxp.com>
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
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0135.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 09:00:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffacfeec-7d9c-4380-092a-08d8c10fa2a2
X-MS-TrafficTypeDiagnostic: DBAPR04MB7366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB73666929F14E7B01D5B1D824E6BD0@DBAPR04MB7366.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NrCI+hyKk2wfAxhgZdfniR/MqJ+DCxC0HOy6wJDL/0dx716aS/z47KGbidpoqHBTs5qzwkX3SdotQAudqQut51IfqtvXiXUl1HuJMcfOijbEvl4Ac9pDBlq8O/78h13sGofyKDYtMryVe3asTBOsQW65FKc2aqZBA5ND5Q/PKFaRx0dqd5JDwQ2oz9JwgwZtj1dztn2C/Sh27QBua7DKE42d429XYC2zyWRwNsmCB9OR5250/m89FPy90hl89O7hS45vxwqLsZhaA5TsVJBxwkj0MbYvpBdG+gFyq/ozDWKwxppp+iHWsOi0EluKsxVAYiMW2uYlYZHlyCvxbsSHq5+2jRgWi0VaC58+YhbyJsQ9s4hOEC2Guu/vJEJt2juwBAfFxXLjN8fS6I7GHKaiyp01nFMBv/hFNAEr6jyAK5UZc8xnd3OXWFy8ro9ag+T0DT4ryX/EfNM26Jnj+7X0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(956004)(2616005)(36756003)(52116002)(86362001)(2906002)(6506007)(6666004)(6486002)(6512007)(66946007)(5660300002)(8676002)(1076003)(316002)(478600001)(16526019)(66556008)(66476007)(186003)(8936002)(26005)(69590400011)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0RMoLnvWmN7Sk9EAryK8C2XsbnVWjniMYWju1l2+2/CousFdr/w5uXg7PROr?=
 =?us-ascii?Q?Z4Ft9Lffr5HZP0zpaB+OHJBK6WmxxUN8q6Oc7C/RDD6RCLENLoMx+wYf8Rby?=
 =?us-ascii?Q?4sfH4r19hWg8h4bSxHWrtqaiolmj5VCo/gpQGUPxfDxxvno20uvV7SjgFTdQ?=
 =?us-ascii?Q?6pSWwqarlLKafRZu/0nhhqZXTok/TohRbTyghKPYNQKU0ZAxtglfGL0lii7E?=
 =?us-ascii?Q?R+upR0sne1tlgVf9eHMy6gKz3jPnMeTDIx8DK/Z6aYlOukO4XEUcXfD1uqpU?=
 =?us-ascii?Q?atji8gTe4KmN98zzBke8r+oOmyTJzFjLWZS1c3gnRQKw5gTQsen3k1hrkSsl?=
 =?us-ascii?Q?fWbV9WDQ3V6DPXq6wUdxjM+t+6ySQRP3pTjJ5+JRT4b4cgH4UDGkcgsoJGW2?=
 =?us-ascii?Q?2wetsg3P2Rxl7bM3IJZomUQowJzyYL7UW6QsuSmHYNCNB/PObck2V3RgzKI6?=
 =?us-ascii?Q?8zh2b3BbCtg9spQKoPxnnzxXgW/sx7IvbJ2tglvPjXLd1nw/MAKjLag+Kb9Z?=
 =?us-ascii?Q?4xun9ZPwBcfycO62WpK3CsMVzDrHGLjwAvIPavQxIsg8BXNGcoQP2rdpXkXd?=
 =?us-ascii?Q?FaSK3qgNiY9/Q9bJgrJqYnYHqJSd0ToGUj0LgCCIeZkrXNE57oQEHj76llos?=
 =?us-ascii?Q?twTFg4rAeSR2dRsi0sQKXckVZGO1ZXfh5wZrUdf/mi9MibLRXvGd+7KLyDYZ?=
 =?us-ascii?Q?Kt2HGxDnLPXb7vGChtM0cc/95w0+EXKWNUqJEMIeqSTBAGTrREFw7hEGFwZU?=
 =?us-ascii?Q?xYXWG+5CImOcPC56O6fz51aYb1cTms1PdbfscUKxwgDSQ/NP98tBZ/aLpDAA?=
 =?us-ascii?Q?NueLQBdYnS9Uao9nH4QuabKo0JCKPLosH4telgnn+3f0jKoqAZ+V85gYLTSx?=
 =?us-ascii?Q?W23yf8zIsMGdB8ys44iFxA+w18lWiGvkLvl0bJUGBfRqUthftkaRilbAsseq?=
 =?us-ascii?Q?8/sUNvGGUUq5p0QfSEguqlCy/EfN3PVLun3+VRIbpZrkXKdBhReAKvIgrv/H?=
 =?us-ascii?Q?7TolQSLzlNt22ffhG/tA54akC/9tInHU40s1rS4dpPYI1BPTfCIDvGtQJBA1?=
 =?us-ascii?Q?bdCGNzZM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffacfeec-7d9c-4380-092a-08d8c10fa2a2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 09:00:17.2732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4G7EG1kruAZcUdxU5YqzluWQJ8BSXg3Qkuo0l3MVOJgikVzkPsdXbwSdCfvsw+z5sHpaLHIDhXpMrhjwGx8Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add JSON metrics for imx8mq DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../arch/arm64/freescale/imx8mq/sys/ddrc.json | 37 +++++++++++++++++++
 .../arm64/freescale/imx8mq/sys/metrics.json   | 18 +++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
new file mode 100644
index 000000000000..c8682728ddad
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
@@ -0,0 +1,37 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx8mq_ddr.cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MQ"
+   },
+   {
+           "BriefDescription": "ddr read-cycles event",
+           "EventCode": "0x2a",
+           "EventName": "imx8mq_ddr.read_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MQ"
+   },
+   {
+           "BriefDescription": "ddr write-cycles event",
+           "EventCode": "0x2b",
+           "EventName": "imx8mq_ddr.write_cycles",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MQ"
+   },
+   {
+           "BriefDescription": "ddr read event",
+           "EventCode": "0x35",
+           "EventName": "imx8mq_ddr.read",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MQ"
+   },
+   {
+           "BriefDescription": "ddr write event",
+           "EventCode": "0x38",
+           "EventName": "imx8mq_ddr.write",
+           "Unit": "imx8_ddr",
+           "Compat": "i.MX8MQ"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
new file mode 100644
index 000000000000..862c98171e0d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
@@ -0,0 +1,18 @@
+[
+   {
+	    "BriefDescription": "bytes all masters read from ddr based on read-cycles event",
+	    "MetricName": "imx8mq_ddr_read.all",
+	    "MetricExpr": "imx8mq_ddr.read_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MQ"
+   },
+   {
+	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
+	    "MetricName": "imx8mq_ddr_write.all",
+	    "MetricExpr": "imx8mq_ddr.write_cycles * 4 * 4",
+	    "ScaleUnit": "9.765625e-4KB",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MQ"
+    }
+]
-- 
2.17.1

