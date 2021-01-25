Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55446C433E6
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B2622B3B
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbhAZGEW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:04:22 -0500
Received: from mail-am6eur05on2063.outbound.protection.outlook.com ([40.107.22.63]:16157
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbhAYJUL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jan 2021 04:20:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg1GqFgJY19a/9QLzlEfpP7TAB7aj8mKOpivbIAHdhR/5h5ZSCV0J9JogICYoNGAaKpJlthvI06jMyHVDDQ7IWK0FYUxKkL4qu/Jp5PV9Nsek56+od9eUi6fo4C6kEda6ZEInMrx6gWeZd16OVdar1x7BHdF2+0DXK9AbwXnNGZe/k+fqWAa/l4hipFrsFmP7yX4FcM+lV+YrWMzR+pJjLkWc8I+UprmZamlrbjWu6QGZ0m1LjFbTFPb37ZM4OjbpyWYxjxTNX8Qutj8MkHKab/t7oEY9xpHUn37DSvhxlTCjeqeK+tqdU3wwVv3diAinTkjRt2tChgaWQf091pIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4jgDcQSTr8VeYLU2S3Ak4eGVbhYubvVMKN1WE/fRAk=;
 b=aCiZSqOIMAQQ9X0rYK8jngCj6F3fvwkZkwKbSpnJVWU7cnZXd0ZWzEKQPAwCmc21KHe+8EgGrOAPgpTHFSdqNrCipWCF+9bpHt4OcADiof83Lnyjbo2iOBX9n8XVfBFqlePUPveo0rWC/5Rghz/aPd4vSmsnFdHb2yPnxB1GaYSWjVhlSkmmPbgFqdGCnDsycdOPzImYMvNplYdNcoAvUSWAekXOQshRfMZFP5wKQcH1ysd2dyjIcPIw4hWVLcZZoMur4GgCni8PHZvQ14slngXLAdd0y3gFxS9IxAq501XlKy/H42ZKucHU+PQvTYPREqs+HEGZSXJdd7swqttlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4jgDcQSTr8VeYLU2S3Ak4eGVbhYubvVMKN1WE/fRAk=;
 b=JiTkhmKS6N3zBvhHA72KQRFnjRfAAH3qLkYp2bxWew638znum/Zgu+Iz+2LOieEBpghbIIaXg3mkSyCLQl/hS8w67Y4+0a60o7Nso0vJxQomTMVcBZ5CEhnKKkswK2PNYPuYg6KrIgPTVfcJP5Ipyuqc1elRJ7Mo8CYFzJpFtRM=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 09:00:07 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::9d2b:182e:ba3b:5920%4]) with mapi id 15.20.3784.016; Mon, 25 Jan 2021
 09:00:07 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     john.garry@huawei.com, acme@kernel.org, jolsa@redhat.com
Cc:     will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-imx@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 0/4] tools: perf: Add JSON metrics for i.MX8M platforms
Date:   Mon, 25 Jan 2021 16:59:23 +0800
Message-Id: <20210125085927.27322-1-qiangqing.zhang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To DB8PR04MB6795.eurprd04.prod.outlook.com
 (2603:10a6:10:fa::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0135.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 09:00:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30845c3e-c890-4b36-91cd-08d8c10f9c9d
X-MS-TrafficTypeDiagnostic: DBAPR04MB7366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB736642EBD6367037F421043AE6BD0@DBAPR04MB7366.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CU/FFioNc3tuMm0sNdYi8h8qL6qn3HzoLb2TR6WscwAc6BA+Ij1e/IL7HG/PVXlnnsgRSsUnRJDkWxVFgsMpYiOjOGp20i2zw3JJGWCMy/9m0Nufhfjhz/3Apl+4rKxs2RPQ1OPkENvwWi26BGj0VCRAeInIs/H1LUv33XX1hczrjzIJnfx6l7lz+D/wH8v2kwMoMmQNfHz6JhKJHxEeLoETRU8SC1ezYvI7Yy7+Y6vnWezShxI4layNLkdNFm5JvPqeK5pZofwQgTR76XKOpR/TYoz5w03zubNP25Kre+Znbzng1ii18TBHmphyIaPsey43GIvheE/0qGhsHbBYEKeKvhpxQmoghh1xRBpBY0mwPriof8KHkLke5becbFo+l8PifirdfTx3G77smAn9YhPZCmS0X30k/5Br8EmQqHVcVCH2HBFMsP/QnFi1zZJNNlsHgXtbLHzPmcZM9rZ0kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(956004)(2616005)(36756003)(52116002)(86362001)(2906002)(6506007)(6666004)(6486002)(6512007)(66946007)(5660300002)(8676002)(1076003)(316002)(478600001)(16526019)(66556008)(66476007)(186003)(8936002)(26005)(69590400011)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yZMe+utcLvPgXBUTAjBZFQ9SEWlTYnrkaDKpKv2vTWAkaYf/SMrD0xCA87Ks?=
 =?us-ascii?Q?JTKKw1yl7s6WEUCd23hqj5iVaqW3CHcKoCK8lZC6ekQPqN1lfInJcWQzmhWN?=
 =?us-ascii?Q?lM+G1V0OrKrhSmXMccG8GKCrzLbNHirnsIY332tuBZFbcdobepVavyB1d2mc?=
 =?us-ascii?Q?UTjbyhcimWEfClHfURBwJrDZ3R1nM5KCPb5ZafiIZQbaTAVZQUYXvB0/GasF?=
 =?us-ascii?Q?W4wJm/eGB3gZeAVsaNJV0w5HrvTcilUD8mDUbIEnKCmxaqaKl3yNdST5cLMN?=
 =?us-ascii?Q?SLHqT46LffI2I7fgBCFUomQLAJq2dulcL/LvkBTEc9m4pxXkypKxvEXXWG6D?=
 =?us-ascii?Q?Cv6cpUUUBgSenjS/N86rhW0q4nsf1ZRIc0nyd0j5mDTrwKeh0SMptG0RwXdk?=
 =?us-ascii?Q?2fgSZm316xJVFMWWIUAdeuzq+E79eTpxckCqN5s1OXpFE6mo3R6ZfjPaP3tQ?=
 =?us-ascii?Q?x4kiyP2a0qqfmq4Q45LjjzT6Gs6VPxwiPOHLU4D4uhCufPPbchLoOB2zc17j?=
 =?us-ascii?Q?9mkPJTcoaA+M23OflKJf0GbvqnjnNV3hCeHcjeK9mKWwQCn3XXyWNFJdfi8j?=
 =?us-ascii?Q?CWcEqkYvLicdfrcEAUo4CmQN0Ly3HE4oO0XFcoxr0kf45bhoc+g1s/6cvL3i?=
 =?us-ascii?Q?+BaBejsY37Pz3DKJZPkJUejzP6/Yk0v4ihdj+LrBedNK8kte44wlbspKdL/J?=
 =?us-ascii?Q?U0+3AnJATXKrDpxoacqXiVOuw554Ijoqgmbp3YWCqMKu3/fPBug5YsjP0B+v?=
 =?us-ascii?Q?c92/7Be4CxuBI/WPvnugqK/KPjALuI01eYNFpdEn5cCBeHFSbiOnda+7lL8T?=
 =?us-ascii?Q?zJqBYQAC+a7KBbpVWIOATQjE5fcPFN6ES7lL/Y0u4ysO+tSEAZRzKefhL+L2?=
 =?us-ascii?Q?t3UCAmzX6ZA5jYEytI70t6u/G+H+Ykx9uzVA7HDl5ZwRxmvRe2v+QQ6xoKrU?=
 =?us-ascii?Q?AY51IDl2O4UrRul7NIpgaOa7V3TCUc6Qr0olhAZmfIyfhn9jdPatJ8ajm98+?=
 =?us-ascii?Q?GvWK4oYXy+qycoGIoHK0nrI6l+zGROQLS96znvdbvrlgrb3KUlbBLCyTG9aR?=
 =?us-ascii?Q?cHOCeSwd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30845c3e-c890-4b36-91cd-08d8c10f9c9d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 09:00:07.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QDHOo3UtN94DDJF3HHsKzfh/hFwbJUThxeiRBfgxc7pMuT8bvFl5FlMOLntz4J3UaDcyLcVlKBCzrtlVnqQ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add JSON metrics for i.MX8M platforms.

ChangeLogs:
V1->V2:
	* remove board level metrics (bandwidth metrics)

Joakim Zhang (4):
  perf vendor events: Fix indentation of brackets in imx8mm metrics
  perf vendor events: Add JSON metrics for imx8mn DDR Perf
  perf vendor events: Add JSON metrics for imx8mq DDR Perf
  perf vendor events: Add JSON metrics for imx8mp DDR Perf

 .../arm64/freescale/imx8mm/sys/metrics.json   |   4 +-
 .../arch/arm64/freescale/imx8mn/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mn/sys/metrics.json   |  18 +
 .../arch/arm64/freescale/imx8mp/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mp/sys/metrics.json   | 466 ++++++++++++++++++
 .../arch/arm64/freescale/imx8mq/sys/ddrc.json |  37 ++
 .../arm64/freescale/imx8mq/sys/metrics.json   |  18 +
 7 files changed, 615 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json

-- 
2.17.1

