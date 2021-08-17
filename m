Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED12C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623BF60ED5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhHQWLv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:11:51 -0400
Received: from mail-mw2nam08on2081.outbound.protection.outlook.com ([40.107.101.81]:3969
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235617AbhHQWLu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/vSnHAoav6Bxby2WbdXH+/q+Vv8PbcmzBwijpMuSNHe+K5mBBuAleyWR3eQIVGnX4Q++D4Tt+aZPiBTo5Ag3JiBdOn1/z4u58pHm8mK0V7sldABBu0MBUgDctD802h6K/Uf04Yp/2OEIaCIpBgFvFgL/SkQASaO+NeOfArJBS2Pbz4X2sy0Nmf8UODfWLr65E9RRyTHALbyDhmOAbAgh8/AvyqZdy//HdYXXQPzOIuJ08LUg45TXiMLj4wWc+6cG8gBowxP5gWq2cN9mybuOwtXSyeX/7Oy861gU+dgH2nyj4k8eHXEvJxlVVik1CPB51s0HhMrG+419AFRFMqO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/e57mvKCTlFw4N/X1B2VNfFFgiRTCFAQR2xOWFQwPA=;
 b=i/iG8XrqtwrIduZtPiSLIcRAcmDCJ1dR/z/LAaKMjeUShXYHqYxB73gOT9l/G1gUFb/2isAwKsetidvqwNX0VVzF0rmqdlRejuFm2tA/JM0fxp1ZFzXoHnyzIX0y5uQas31KT3lTyzEIX9jQHZ634QEJV7Ei4U1gwmZdmE9kdJDQzkTTx2XhLnJga/VATO0XpTqvgsdXnVZNFnAdBytBBYTS6l1DW6ismTYrIs3RVlIiHVH+DxE21fE6+KGUfxGLEelHGZm+rvnKWl2D9cDJz5mAhAYwsz3a8NlNFSvMFOgG9HDh7GKihxYBNeqcg9ykPzOmxBdH0qGZB04ZF5y10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/e57mvKCTlFw4N/X1B2VNfFFgiRTCFAQR2xOWFQwPA=;
 b=fQY9/cUmihO02pUVvZ735V17+2m69ke1gDhuR2QCOsVJPBRCgtwGLq4gKWcmtp9GbylxImi+HSWGIrTagNZoDon270KPZnGhtDYkz0RuFCcT2JMMFPI4v9fTteIxKDpadhmSB8kTMwbJxzhdD+uxalv1ooHZwe7q2ZgTG65ikOc=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN7PR12MB2611.namprd12.prod.outlook.com (2603:10b6:408:27::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Tue, 17 Aug
 2021 22:11:13 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:11:13 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 0/8] perf/amd: Fixes, uncore as a module, new IBS header
Date:   Tue, 17 Aug 2021 17:10:40 -0500
Message-Id: <20210817221048.88063-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:806:27::14) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SA9PR13CA0129.namprd13.prod.outlook.com (2603:10b6:806:27::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11 via Frontend Transport; Tue, 17 Aug 2021 22:11:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e87881a9-9d16-4273-5c82-08d961cbecad
X-MS-TrafficTypeDiagnostic: BN7PR12MB2611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB261134277ACDF4802526398287FE9@BN7PR12MB2611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKxqqq2gU3DFAL+F9q3IQHVSt9cozoXV6F3qcxukYnTgmjVpDEcw1QdOPqSqDF6czkB5+D6Yxj9CSsPJPtzD/CD1ctOI7ckwtVe3rBNOsp8cRo0pT/GvaADeRCnqbTq66DcITPUY4Io6fx7KHkTnVHNggKWwKO8roRxkWRM7YjyuldhvLwHd9HKufkE6t1aA5T7kFPHdCaHaTthULH3cwkkNX5uruhMvTgG4DAMI54iMxbO5K7PC1voz4YL1h+D+KPrMODZR+lhdQese/rSfHV96T9XCHX+jYCLa0rhbIEXYymRAMhrG4kOmxPlMMXWJqRmSfum52iYn2M2uxz+M2bbBGo0kpOl/4pOuPFGsejQoI9Tkc3nbNx578B1eRWGuduHmGJ8xCaaEzIFFO8/yHMBsQDj9ytEJRCFyuLSGqtxmyzyB4xT5drvy9nYHM5749bYmAD8SHT1ez2CphNLj7VEOAHDP5m+/3el/iq4U4AYz0Da0YsfwrznH7PREBoEYlFfhQsFxnJjbhh6FuG4BonOs9sLG692UEk/9KGjt64KmrE9ZZbQln1lubqt/rf14augSamruTBjzWOFttWfbQxDutd/yw6+7ctRsdK+Rh3p7wLQd20WW73AKAgWBa/loiVJ61rrfgNHzBN7657Y/p7VgByxeg5j510iaBoMDP/uwbcD3ubl0ZSCIK5449LB4G25Mpqv4mlf1fljrFpWFWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(110136005)(54906003)(36756003)(38100700002)(38350700002)(66476007)(7049001)(2616005)(316002)(66946007)(8676002)(956004)(26005)(83380400001)(478600001)(6666004)(6486002)(66556008)(1076003)(4326008)(5660300002)(2906002)(7416002)(44832011)(86362001)(52116002)(186003)(7696005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cEAqUhUTY6Qr/L3eppCAhO/ele3OVbKZMiDvypQSfcZCIqBRWL0nVlwUFXU?=
 =?us-ascii?Q?bXD1vXm1VxmBPhc1n1OgB2pFjzkXHkcudlBCoHo1x1v/MKsBS7SKuzM/poVR?=
 =?us-ascii?Q?UwwCIuare3BPt0ONDPyUGbTsixqR4IaZvIO/OhADJcrmy31tXoSzCdLKUgi9?=
 =?us-ascii?Q?I/w7xjccCQ/34fwfVr/Nd/BAOokHgic6TdCxx+BK0mbWddT1kvGmoynyu1IO?=
 =?us-ascii?Q?vbKeYWJ0/qoTKHTQww5HKCcU8dQzKpHw4mzy38wWwuby5oCs2nVnix+jcmyP?=
 =?us-ascii?Q?h7rNXtGHAtSoKv6v/bJy/DsCR0rh9uOIDKSdOzLDRylZlh6OrvcJgbbSTE9n?=
 =?us-ascii?Q?Mg22X6SXRZgt6JbCHsP4nhmwoh7d2L8N9iQyToRYgcc4Ft2uX2pqZCatH38A?=
 =?us-ascii?Q?8DhspyFk8E7Ucrkfc3m/JiJ2MhISgVtDAk+3uOgOKmBZBMgWNAbgOwrLNNTN?=
 =?us-ascii?Q?GA2vOAVJzslcQBof5iNc9axLKpSdPLsBfmoNEZUAouIYOcXmGNRqIn2YtIXe?=
 =?us-ascii?Q?2c+xaq4td3S8Ap7GwoH5QJyQgYK9m7a2ssyGEvoC4PBQxEskv+ZjErUQ0Wep?=
 =?us-ascii?Q?J62ZAG9SDk9/Itngjje1Nouc8Kr9QNrBFuI2vuf3KC4MKwVZk3U2+sz0KxPb?=
 =?us-ascii?Q?ZyGew/B4KzbPcSpIOmpOTBwL3gQ5wWK8wecrM+6zsvmRDtdkmhQQgGM5o8oJ?=
 =?us-ascii?Q?ICVbQmbkTekWeODYKqVoC7atU/xGfMXuhIfbTzuhRHWUp+ytWl74aANLLL3G?=
 =?us-ascii?Q?ZYJxM5gVWjk8di8EeYlk+5iyWlGKfBaYC5+Lb+1r8+5SKvcWZCocmM1l18MU?=
 =?us-ascii?Q?Wh53tw+4ctNC8ac8bhswkaE+JB06Lislv/y6NPXX7TlTj1vPaaBBCma4pvFK?=
 =?us-ascii?Q?xLZgRf8K32lW3TMYXZGM1asoiAY1HSGwiJ6fu1CbMfT0PXWTEpsZmcKSRxVo?=
 =?us-ascii?Q?NYV0ZIZXNIYK3+4Sq4jQvBmslkudk72sar4HfwkkFWl2seskDzDFlKov810L?=
 =?us-ascii?Q?Y6ej525h0ZfOuM42jyEy+uoQgMGV2+uK6b8snKcAjYDp3T3tMgYqMV40QMnZ?=
 =?us-ascii?Q?7oSMMFh7us3P8WKMxOMGntGQXnw2Gc16dGnPcumu1r1XcdMFVc0Z7j5FLfnc?=
 =?us-ascii?Q?lB/DUVaGAZBc8PW5/1u1DD4PI+tMUkdDcGdVfP+RJny2bF+u4k3qmsP2WS+T?=
 =?us-ascii?Q?p2VhJplpOvG6uuKL/lsmd1Off4NRKvab7ewc8tk/cNdoiwzvDo4VAvSkSnDR?=
 =?us-ascii?Q?7185jL1MFaJC4MlXz3evMXZZjzz+ymVJvzi/gTRoqyzC/5XPqAnnvYpXN++f?=
 =?us-ascii?Q?uISEWQKkHBlpTxGqTxEygT2d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87881a9-9d16-4273-5c82-08d961cbecad
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:11:12.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0CTZMqk+QDRsaN+FG7uX0M2iz3S8uFkXfspEnIx7jc/Al7oiZUcFHiRvMS366xr9SyDKzL9Ep+6Rn4Ff+rvKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2611
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Linux kernel events users and maintainers,

These are some miscellaneous updates for kernel-side perf for AMD:

 - Miscellaneous IBS, power, uncore fixes
 - Allow the uncore driver to be built as a module
 - Add a new IBS header for use in the driver and the perf tool.

A patch series for the tool is being submitted seperately
from this series.

Thanks,

Kim

Kim Phillips (8):
 arch/x86/events/Kconfig          |  10 +++
 arch/x86/events/amd/Makefile     |   6 +-
 arch/x86/events/amd/ibs.c        |  32 ++++----
 arch/x86/events/amd/power.c      |   1 +
 arch/x86/events/amd/uncore.c     |  40 ++++++++--
 arch/x86/include/asm/amd-ibs.h   | 132 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/processor.h |   2 +
 arch/x86/kernel/cpu/amd.c        |   2 +-
 arch/x86/kernel/cpu/common.c     |   6 ++
 9 files changed, 205 insertions(+), 26 deletions(-)
 create mode 100644 arch/x86/include/asm/amd-ibs.h

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: x86@kernel.org

-- 
2.31.1

