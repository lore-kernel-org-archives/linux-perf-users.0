Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F79C433E0
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0152822B37
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbhAZGD4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:03:56 -0500
Received: from mail-eopbgr60073.outbound.protection.outlook.com ([40.107.6.73]:27085
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbhAYJSk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jan 2021 04:18:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCU2PA/S3Sw285K4lxoOmQ7hhixzeyCPI5jRG065ZrOY/JAHJUusCsxEVHowk+kzzkQWU6P/ZIQnx67amH7bW16QQTYK2J9wvEyC9dwvWbR62wf7V/fODsqT6hF9JdStG7VuPcFJG+jLws6q6y5R7ghfykaECjvThltcvGaxE4TqoUqEjcGwLvHDbtqjz85bBkEzpz5oI0iys4hHbWPdJHnAP4IJtRRgGbvkmCkjG/jpFX3sPwAQCl69OXqohpptW6eScClWZ/mB9xyKkkGua+i1PZs+Sjn4jJOCIhvCL9NutV3LOUSJ18TxwvMjiBOXwzXaS3Xn1twbkhS4XJq2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT9m9cF0Kc0jm3bqJhb/OVvJufFPLtY58gbuDBTQaGA=;
 b=dFrZJ0I+GQ12lI9HLUrLdGCvq7u1GAhk6iZCl71PsgAFwIhl8pxBsdGo+Oq6A651QZ3f3QkjWmZe+S5kQqhbZDKldoegBBMBEUlDBWw6O3jt9KJnFDA8mbypRhc2Yi8tiVHCSwA8PxN/uU8prMvrTjnWW2LQkLBs9Db5lDxJU/gnc7bnXWBO4PTs4n87jKs/I0tGVjr0YuRPpx3dSq3LtnVdYIcRnn3fnTnf3u3lqdP8GiTXknG4yyBKklM8wxdmSgQnb94DBOUHDi9IeXcW6cnkrcLo3Kx2qUd+McY64j+J7CS/5WHBTk0QLdHcmdUTgCRnSfxEBtS5mOBBsrZYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VT9m9cF0Kc0jm3bqJhb/OVvJufFPLtY58gbuDBTQaGA=;
 b=IM+2seIjfjxLpXqigPs2PUywfESGrgbjiou/Dg+jc63JLgwqc/ou0cZfDuPYonlAHB8f3q87Pw27mX/S8V/iGK3vlGvJ816ONEUx1a7XnqRWvO+eChn5GxdhT65uIRwPZDmUzS7wzb0BdWgcPoxkhUdtydfPA4yWHwf8SbcmEkE=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 09:00:10 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%4]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 09:00:10 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, acme@kernel.org, jolsa@redhat.com
Cc:     will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-imx@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 1/4] perf vendor events: Fix indentation of brackets in imx8mm metrics
Date:   Mon, 25 Jan 2021 16:59:24 +0800
Message-Id: <20210125085927.27322-2-qiangqing.zhang@nxp.com>
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
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0135.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 09:00:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17ab72b5-5dda-4af9-35d2-08d8c10f9e9f
X-MS-TrafficTypeDiagnostic: DBAPR04MB7366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB73667A0E1BF19F398A724184E6BD0@DBAPR04MB7366.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5Z4cnaPx37enmTKOGMjAuMhFYL4PuAo/tAxi3McGsTtFov/tw/+G12X5aKLz9B4tn2wO7yiwEKczw5+17ZxFaOZfsML6NhMraZucU2XKGlydUBTmv/58J+L3QVmucHdq2Mek/8PH1cQbjud4vXdjtfZjavLi/aTgXuP8EjWiQzHe3OJEmJ3nDEokMSAm4Hep3xMI9kNNn4X1oZbMmRNSTUwvzcmKnkqsAbikQP1ow+UULoONN2365u17JpMceb38HxRTM5vj91u2vwVpyuhx9qHAlZByd36fV/hEAFV/qqwFhwUxvVmX2TvHUJzY/7SFqzQ5PccFvygi1aywivGiAg6CTlRtTW282jPULmmbmwmMFq3AMXbAdSzBTLpo0/qpRgERv0Omb5bYsauzKRiHB5Y2/Py/YicxAESz3pDZR89STDTbpHz8CEmoaFweN5cCEzhfBSXRvtHJAhByT7RTKENEIFABH/EQbsQP+RW8QE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(956004)(2616005)(36756003)(52116002)(86362001)(2906002)(6506007)(6666004)(6486002)(6512007)(66946007)(5660300002)(8676002)(1076003)(316002)(4744005)(478600001)(16526019)(66556008)(66476007)(186003)(8936002)(26005)(69590400011)(4326008)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JJRjROUXS2BZxYxVwh3aZ9J1jbL+dGrzj4x/J2GEq5fQ1z75VOvzjvDt/Uzd?=
 =?us-ascii?Q?uthM7INMwvFV6wgKQ35MazMB5Kqu7SDZaF+EAPunjdB3QjHBZLJEyyR+gxVd?=
 =?us-ascii?Q?vYpkMaPJJdsTMO4k6HO7AjwvDMVgqV6ofKch6D7gG2drCUykC4goPiylGIOI?=
 =?us-ascii?Q?uswkCxBVSlQUqoehfroNJhnZhVgcHBIewSip/KLC0Q3rD90QS2UiGMrSId/2?=
 =?us-ascii?Q?gVFLPpSHvR94g7SgjBBGrYyFtbgtnEPvAkr6pf3r/Y5DnJ5ntZTwB8m+QzbW?=
 =?us-ascii?Q?l4lRGtfAQBpzoa2zX1x8CTsxIGfTIlAZeNNAObn/CvynppxcvHDwhsqK8x6N?=
 =?us-ascii?Q?amPJBL/kGTpZmJZxe/YaakHLk+gvdkhgDOeB5hN13VpeM1vfaGhcZSjYfEsv?=
 =?us-ascii?Q?unvOnEcYeYVTQhvIx4gARFKz4/ehCAxJxFIhIHmISenz436KibRHYvLjHv/5?=
 =?us-ascii?Q?OKklQ0ebB3gdaqHCJk+X1KA4/NFLnAGBSBUCmPyjWqJ8PFKE9b1WCvuXgwGx?=
 =?us-ascii?Q?yZ30Itb5R8qG6lT4tj5RmYfvoLiyzjRO9ffaIeHHu+de3fLhWRKEWp8JhhpS?=
 =?us-ascii?Q?KvvDEJxgCS+euH7t00q9kkL2v+KdrVO7EycBPWMZ21cBZOXVI9jf7rSnD427?=
 =?us-ascii?Q?FCAcKmc3wQOyHzFtc6cjA5weTpdAAPdxAPVcfOzXo9kDxF32iAuA0xjXlM9n?=
 =?us-ascii?Q?oCfi84TRHy0L8MVLD1u6NEEWd/9Yy1rVtbuHO137iOboogpdKbIxr2UkFd1+?=
 =?us-ascii?Q?2zOkQktkDpN5fftslVdj/a5c20868JmSiP5eHw7iITQPTq7dqBg9LG3H8Ave?=
 =?us-ascii?Q?zKVEoFoW3kIt3dOmrcH8thb88fYODfgAnPsWLMbbigbFpouDLdLUrmmahGG9?=
 =?us-ascii?Q?9opdWRr6df9gMp1hD55iUOJX17nlKsEVB3r7iUObRquOju/RO2xaI1JweO2n?=
 =?us-ascii?Q?2OMtlCcduwqN+yUe5vKaWqJXIYXskKh3E/rlz0kfmIMo3AHh0Dv0+fmkcHWc?=
 =?us-ascii?Q?P+lzX2ZMnipw7Mn6e907dXBp3KmNxmTLgBPd0pu1oltT4HN6Q73NAcoRnWBU?=
 =?us-ascii?Q?ZqAuYJCg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ab72b5-5dda-4af9-35d2-08d8c10f9e9f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 09:00:10.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoZCqIM8IymXHKTyzveUZ/nh17Swa7je3OQuSf4nRU6CKVvaVQAIYdzySFE1ypeUFCkcRjV+tqGKf5szwS0DRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix indentation of brackets in imx8mm metrics.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 .../pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
index 8e553b67cae6..f416fa052337 100644
--- a/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
@@ -6,7 +6,7 @@
 	    "ScaleUnit": "9.765625e-4KB",
 	    "Unit": "imx8_ddr",
 	    "Compat": "i.MX8MM"
-    },
+   },
    {
 	    "BriefDescription": "bytes all masters write to ddr based on write-cycles event",
 	    "MetricName": "imx8mm_ddr_write.all",
@@ -14,5 +14,5 @@
 	    "ScaleUnit": "9.765625e-4KB",
 	    "Unit": "imx8_ddr",
 	    "Compat": "i.MX8MM"
-    }
+   }
 ]
-- 
2.17.1

