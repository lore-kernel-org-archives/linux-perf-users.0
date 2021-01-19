Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD90C433DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 02:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8936C206C0
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 02:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbhASC7A (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 21:59:00 -0500
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:47429
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbhASC6z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jan 2021 21:58:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPZUxjwGVO9iIutqRkKE+Q4RENNAGLZeggzMKBChzZKMoXsGHdZ8e2c0dpKtCsBm3A83iI5BnlkUokLu/1+JqjXxDP9YmDgR3IvuLqxcN65E53fWza5IPHjEGE2wYF9mUiom29F2THkRnxekSXBygi826c5QlKsh6zUcWcNnGBxW9VSd95t0D6CHzze6+YTjhKaPLdy9LFvDY8UnN46ROhHgegG/RsCt4sHErdE4WI2zXtiqX4l184QsZZRgTV00cdgvAhTYgdYQx2eZ9PoHP3/uezbXQT7hTpzHQBfIPXtQpONa7pvHRzqazt2uqE1q/Ib6tTwcC2Zq8PlzhcZ5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgnIucgQ+gf+7t185aPSPK/ha93JKPb1gI9kPZ4Wnb8=;
 b=cmgvp7tFJUsJUJ4+pEtNiRSdxqbPCxNXcnAdUXIGsF24F/wtn2aGtS4SE8gfmwKp5s8iyWkNwMqu69zd8qCHoG1dAZX2z6UNRjG0lfKpV49jKrgBGxNaHiFHfooxBndcNVJNv059rqhfTPfNLCAhg3i/BmahSPEgQHNevzMKYpNfpcWfhR4fHEl1Tei1FQ+qU+FfVw6juTlvdf5cLnTrSnm9QTSK9kS3tNLJRwjd15Rf3oYpqwtI9HrDY69I40Sa1lz+x4/nahomVuozqlx44CSIYVSex2p/9za6Zv+VeVaPvieQzFxbMo7n423x3R4LLAQzo/+WLJg6cgOlCekv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgnIucgQ+gf+7t185aPSPK/ha93JKPb1gI9kPZ4Wnb8=;
 b=myp7IxSXBM8KW2j4D4ac2GyV9eyFkWSlCwWx+RvgV+L5DDQbeP4d58Z/0lRQV0ZJhquJajbB+w260Yn4COf33aEwfsKNUs/6EFYSdCLAjspPgL2Y/brGEnkEXn+2IvE3t2LJCJEEwAxGvRxfiO2lUIU2tOCMg0vkJ3P+p69zXIM=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR0402MB2903.eurprd04.prod.outlook.com (2603:10a6:4:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Tue, 19 Jan
 2021 02:58:05 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::b83c:2edc:17e8:2666%4]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 02:58:05 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, acme@kernel.org, jolsa@redhat.com
Cc:     will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-imx@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V1 0/4] tools: perf: Add JSON metrics for i.MX8M platforms
Date:   Tue, 19 Jan 2021 10:56:43 +0800
Message-Id: <20210119025647.12569-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0231.apcprd06.prod.outlook.com
 (2603:1096:4:ac::15) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0231.apcprd06.prod.outlook.com (2603:1096:4:ac::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 02:58:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 897f6e21-6039-4ce1-c75a-08d8bc260b05
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2903A8C83B80A200AAA2328CE6A30@DB6PR0402MB2903.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxfE3GsvFO453N8W+iIuJZNL1hN2p7jxznRF6smYWCIcXrvW4SKSsUbgIiO9gGGQcSRE5hMRMtre/kua8cfrEME+MezYrqS3Z50v1kMNBydHPJt4IwO7XF9ZOwJnwXX5oSDWruUer6XxH/p+W5iOF/FitnGkuKCVw0fNE2NMRAwBHsxHH4F9zAKEjoJ/A7eMg+G+8HiBvypxz3L3pDY2nhktVvUVdHtMYRLQh+JacBYban1jRBEXgUOcBonYo6Z4SpWUMeq6QhfQr9cWTmP6CgE8BBgdR/8QqfjyV2MdEJfzQ2LMVgMeWWPQH+kUgya8z3/ua4CkZJDldG2jHWQcBsd6mTftM5eWuEVerLtFTbCeKm0Po1gneiqRDZvnI+OXAsWmdgSqkSornE3NrFd9jtjYd5qMDSudEF3ecT3+/nLhj/KyWYuAQV1a6EMM/6YHMZTIYdVpcyHJWBxVnipZdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(36756003)(8936002)(4326008)(6512007)(316002)(8676002)(2906002)(86362001)(66556008)(69590400011)(1076003)(6506007)(6666004)(6486002)(186003)(26005)(5660300002)(478600001)(16526019)(52116002)(83380400001)(2616005)(956004)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ycl6Z+9X0ke8nWt0SvKd0rhCmmnyqOQckQu2BegYQHiiDmcXIPiTQiTpQ2PK?=
 =?us-ascii?Q?vS0cer/sUdG7S4Ts8Kd0r87yXuC+vYPg+aypyOsqsZrjynUMEBN1NiVTPObW?=
 =?us-ascii?Q?MyFrNqh4RN8ltHp07jjG1vbMXSxgaHk0fN4eSXAwCPGFIio0GBK1mOivoYIV?=
 =?us-ascii?Q?H0ldEv87l17veCZrD0v0q1xdnzvOfBuU8qVNfhVGAXWQNGH5BnuaRRorAu/5?=
 =?us-ascii?Q?QHXV8xaxRwPykPoBWO0UhKU9kSx3pjgmQBKRPbmIPkLm4o99eHLLI3/wgg1H?=
 =?us-ascii?Q?UwGHt9ojZuYt+vOn8dhrytjYTrULqga+2ixGFxwoEM+l9722RToWpzhTkLIr?=
 =?us-ascii?Q?+YdRLQO/9gMpJ8p+qZDn8Jv76b5KG0EQCSqMlfaAGdIqbMoOJV3FjXKfhVfp?=
 =?us-ascii?Q?xCuxSH8lpeZck7BC6l1ZMSH08cO7wA/aaL6gS8iX/bMh3ifu8p4yyRHSHPjP?=
 =?us-ascii?Q?ZsQ4r6aMm7qj2n2gI8+WqKfi2dgnSFbrD1tg9QKzXM+0xvnyfaKSaIB11z7T?=
 =?us-ascii?Q?Y1Yidwg5lPz6Q01PBSXb9SpKecdQMbS5JrRzw8u+vyXN4bW+lW6j3tw532+T?=
 =?us-ascii?Q?1w1uEzRuSdGtJCpSU9s2Oi6g+A4vBBHZSN8rgdBk3AYGQG47vDUxGPi35f+q?=
 =?us-ascii?Q?wYJzqeJb1rJe0JabhQacOggebiOiwWc1VEVSwYrBSwUwRR8QpqXuvmILDCsI?=
 =?us-ascii?Q?IeOc6eU3MWE/PI9/eVrdSAT2HRuBPN1aYM7SRlwTX6e7dJU5L+Te0tSBmHtl?=
 =?us-ascii?Q?RRFVWT4bR6k/7JiwSv8uglJUCGnkuObUfbvnxQDRaF7clXQqPMpVUcbHRYFV?=
 =?us-ascii?Q?u8H4p4qCdyqnpBokp+07nuKJUDUJLd3ocky84r0CbNOVUhfV7avvT6wA5GNd?=
 =?us-ascii?Q?Bt8/MDATmnoN49vlXgjQSFZ8Mw31qTPMkwAke9W3XyYZgWlVFzhJkYjQIX8d?=
 =?us-ascii?Q?JALiBMxv0HsFnxHubXZFP4bpLfy6Xj92NVpZYW1ZPTpHQcss+tB3GSY5hE4O?=
 =?us-ascii?Q?wfe8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897f6e21-6039-4ce1-c75a-08d8bc260b05
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 02:58:05.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5/DfvscDhnCn0efpqjt2YguZJBP9U95nWRO4B3422kbV9d5HnMNJmEpvXYb6mlXwuBOWK2cDl9FyTsE8eVauw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2903
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add JSON metrics for i.MX8M platforms

Joakim Zhang (4):
  perf vendor events: Add bandwidth metric for imx8mm
  perf vendor events: Add JSON metrics for imx8mn DDR Perf
  perf vendor events: Add JSON metrics for imx8mq DDR Perf
  perf vendor events: Add JSON metrics for imx8mp DDR Perf

 .../arm64/freescale/imx8mm/sys/metrics.json   |  20 +-
 .../arch/arm64/freescale/imx8mn/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mn/sys/metrics.json   |  34 ++
 .../arch/arm64/freescale/imx8mp/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mp/sys/metrics.json   | 474 ++++++++++++++++++
 .../arch/arm64/freescale/imx8mq/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mq/sys/metrics.json   |  26 +
 7 files changed, 663 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json

-- 
2.17.1

