Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B13FC433E6
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 02:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA04C207C4
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 02:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbhASC7h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 21:59:37 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:17984
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389618AbhASC7g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 21:59:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGsQuR/iMiWEZQJu6/MQtP5exv3a6yv/Vtc+sWLZdZRs0Kut/eU2lJzd8cadqmlaaofYYyHQqe3yTui2XD5SHCT4QWNv/EadJ/nXWsn+rREbLgi8EX5onqAs2jsIe5dlNFaovhtxWdsfpi8j/pvTXP4Zt1P9rOmh9EFHNltqqfTElkFsr+ubJijF37mK6fPLzAAF8ZD/8TIhSWAnYXmPQQWeXZjwYM4/VEtpIezonNhrFzcwGFmxnxdll80dvymyiwiliNJ//phSOIgia+DWcEnF+OecX93lZhKG3KmnKeVpJUiWqZ7x9xjUIrdmAdyFEdCj8ZzYn/otXV2vnBgUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2ndC83muw/dhsnIbo9ua85g3WwrvK4mvgiltmBQrmE=;
 b=mrZfGujm+aNtlc8SsxhVR+PtcmybN9uVLyzZ6rOBQ/EWrcv+gEX3InxG8gtbE/2fQKq0EhX1g6t63F43hfBrWoB/ZuPdp5HkkYYh+1Ykx0AyyNLStFAAsjLqY0YWXDKpXJjWJq7hfmKD0eyrEBQhjY2OGKBYblWRTvL4MwP78Snvef4klszCBg8K07KwwELS4qAiaEPcmiNz1Pgq/r6FOseGyG/GFVUOIga7x8jheXdnf2qbALdEdyWyAUPIho3ddk6E1mpyYvG+6NWWtuOI4CeZYK9a585U65YANXX5EcagtTiANCuQIZpgV6WM6FJJ1iRtZwppgqIOjZdBZoofgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2ndC83muw/dhsnIbo9ua85g3WwrvK4mvgiltmBQrmE=;
 b=NK92hLPNX2CEr4qBIfbzzHe1J2P38jaXvYLKxbqEmL0lY4tBb2dTbgKNd5YhFoOozl4bAa24xtPG9XTCAFxAo27Pel81e+gL7MpCm2FaVn05rlP5AnVGaAd9xoBIKlRDbz01J8JNzsG8g4Cf6E8ybs/aqPh1hM9s+zYvHdbLMRg=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR04MB3208.eurprd04.prod.outlook.com (2603:10a6:6:3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.14; Tue, 19 Jan 2021 02:58:14 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 02:58:14 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, acme@kernel.org, jolsa@redhat.com
Cc:     will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-imx@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V1 3/4] perf vendor events: Add JSON metrics for imx8mq DDR Perf
Date:   Tue, 19 Jan 2021 10:56:46 +0800
Message-Id: <20210119025647.12569-4-qiangqing.zhang@nxp.com>
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
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0231.apcprd06.prod.outlook.com (2603:1096:4:ac::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 02:58:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78c64f6c-daea-4b7d-0a06-08d8bc26108f
X-MS-TrafficTypeDiagnostic: DB6PR04MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB32080793058621544FC60AD1E6A30@DB6PR04MB3208.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zb+Xd7r3tm8XjlPmhfLXTYmZLKm5+KPr5xCtWS51xeoBzzBMDS1ty0BEuSsSydViK2+QCdcsDK0g9aHmhz5kMlICLSqB/zFhZnnuBJHlApotwPVOsn9fdzqqCdyoskhgr56ouq29bxuhBjb1k1TidZT4WBqySPoLvY2O2KwdNbvgY6L/eWgnKhcdW4GCxz4wAMbemIBdWMv6Hn2dFs1Lku3N48DeLY3P+dMd6evl26pyO9s1kEQI788ToysBtn2q5NpENKPApDby0duDxHCCeleHS8FNskvYEfGXWMQq9yFlYMBoyB2pHlxFjAVd+OBCpqn0kTI2m0yzVaDjViDmiNIZCfXoHx+XRvcu2C87KF59l76eIpNS55c8d1dw7OrtCgOShIG8Kdkfbn7E1SY7tkhhhx99KTIOCMP2yB1JLbHlfJwcbwT6MRtT3QVycHFoyRL2PZebNvkRv8GmFAF1F/ErSXw5v22WokwC54daU7D545AF7lBlblBxdhVhLZ8Edfb/oaguNHB63k0j3gPVubUH7WvUOIJyMI9rrco8HhPh/dRhemwCWMycfOGxf3m6kEKXeOFjHP+EGF4Keek1htjYXltWk2MjCt8TWRUf9sQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(36756003)(1076003)(6506007)(956004)(2616005)(66556008)(26005)(16526019)(8936002)(5660300002)(186003)(52116002)(6512007)(66946007)(69590400011)(8676002)(66476007)(6486002)(4326008)(6666004)(2906002)(478600001)(86362001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CDCmNIjp2LlwLW4I9V/Q21mh9fjzqS5Aw3qWAB90piVpip2ft7rKjzGoLQ2u?=
 =?us-ascii?Q?DguSEEFQNvJ6pS/22LlbNg8nwsVXd5nNO5EfldELdUYFAyp2ZTdvuT01PXq0?=
 =?us-ascii?Q?Sbw8i2uJHnTmes4cyJWK33y2KlCEYU5s7EjUA9eb4t2vYNA/P6LvuuIF/z6c?=
 =?us-ascii?Q?6LKBeruxYwMtWQqH9ZdzFEMOO6d4U5RN5I7/LsuxvWhhHbpVn4gHqNWZy669?=
 =?us-ascii?Q?rPRbVk16NYoRrtNNRyr9XgEcSBL87aK+9isAmkRqfbBs4nxG/DiJgFUdgQD1?=
 =?us-ascii?Q?1RvcObZ7+c9gP1MlPCgX1BMozrUylxfd/GHfDcsZYJaH41LseJYL8bl8Llo5?=
 =?us-ascii?Q?p/usLEQbqhb0HOl/H/UiZPnr0fjoFAhjvHJk4z363BAspso4lUCczUns3DOh?=
 =?us-ascii?Q?/qiTylM1Ol12bU7CZ9xWiiCd5JX+M7HzMQVMibwjbsqggUyB1sM/absnE9ME?=
 =?us-ascii?Q?8XgsHwnHhewN58kt2xWFJG/aNMd7EyqYMsviSBvNZdLwR2bdJH9NxYlaTOq9?=
 =?us-ascii?Q?Zo8GTBbbmoT1+k7vxmi8aH60WIbE7kQt2UeM3WHDFWDIoXLdWBA487rTiNb/?=
 =?us-ascii?Q?b8Z/UgEijdXSoulW3B8BtBL4QHGPlkK9TFeH9JP/G6Lav6V/8ZQXUbLdxHjy?=
 =?us-ascii?Q?yUCsGKZEVKNkcGZQpxPnwadR1DaeE48dp8sOj/tr7dc/TJ9qd3U9wxEX+bgV?=
 =?us-ascii?Q?mhYNURem9TRyuQK8oIYywDRE450UICZWtQvmULHkItzW4O3EdhU1G4+UlZmO?=
 =?us-ascii?Q?C3AHhYIF8gRMGL3xe9jkM1yDeioG7aaOMqxE8odNui/cpAHYykjDTpiY+psA?=
 =?us-ascii?Q?9BEzn2gbhM4zobeYviZEQXbSHzy/TLdRw2jQ+ADv5m2xPsSn4+zRtFPPvPo5?=
 =?us-ascii?Q?/EnQ6nak9NlAZ5gKKnMa96+mZyO9WDMFH+wUtuvr1JJyoe2jiEZHuOYo0TVv?=
 =?us-ascii?Q?/kgQHckUs57P23C38mzbeldKc5t4vrN37HJCSJfSKsNYGHX2U15o8wuKpMWH?=
 =?us-ascii?Q?QWUt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c64f6c-daea-4b7d-0a06-08d8bc26108f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 02:58:14.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCQxMuC2CDMIGqfEsvm4PRU3zXLgVrv2ebzDrFB9/p82b6NaifVQ+yYQ5/GYKh9dMQlzzvRJoOCX9pqXsdQplg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3208
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add JSON metrics for imx8mq DDR Perf.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../arch/arm64/freescale/imx8mq/sys/ddrc.json | 37 +++++++++++++++++++
 .../arm64/freescale/imx8mq/sys/metrics.json   | 26 +++++++++++++
 2 files changed, 63 insertions(+)
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
index 000000000000..c3e9f89a4a4d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
@@ -0,0 +1,26 @@
+[
+   {
+	    "BriefDescription": "bandwidth usage for lpddr4 evk board",
+	    "MetricName": "imx8mq_bandwidth_usage.lpddr4",
+	    "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) * 4 * 4 / duration_time) / (800 * 1000000 * 4 * 4)",
+	    "ScaleUnit": "1e2%",
+	    "Unit": "imx8_ddr",
+	    "Compat": "i.MX8MQ"
+   },
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

