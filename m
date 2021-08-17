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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C92C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E031E60EB5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhHQWQs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:16:48 -0400
Received: from mail-bn8nam11on2072.outbound.protection.outlook.com ([40.107.236.72]:20065
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236099AbhHQWQq (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:16:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aI8Ai/lgHVMRZzzc8xsD6n9xrwXFDCUL0olvh51LnkSt1UrC/A3/ws9CR7iLgZ7XcPHtVxBbsssFds2UN4Lv+yP1uorbTyhWbZxIXUe31INmXEfqEdhRJIBFFyaZInnKLJcmBVi/B8VNk6eWd7HeWkseXxkumeJojNFpRcpphVamX6+ECoZgElHZOwWaA4cqRerd5DMxZM2dihhWpulKW3RFAUbjpCgtHsBlVqs60REB1tZpO7vZCx+swjVyyKwFuS3tUUGD3VpT2LqB3CyrHLUt4AoAhoMlddj6lqrg3X73OcL6nMkoMxbZqXUpTJdd7GVfIBVWQ2U6Whu2cecgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrMceoHdO70Mum7GRXDHPu0SCJW6dRe0c9kMPEgT7DY=;
 b=CZ6gVKSo+VJkGxMHMfwHchXHqS5w9ZuGflC9nOM3fiPItQ/spPLIytKHsvjuEcO7H3EnX+a0EyvzCTYmfNTA02HhpBWOjOjzGPCls47Et9ca8DBew8IkSVZ8ax6bdcqxSPzhJu87mQ4H9hBSKMqg7csgWrZQmCKg+xG7LWh9Wa9fHGdnn/F4WjLubW2nWIfPX7yyf7+O80gG4jswKA7093Sdsa0d31zNVsrldzdfTRWHYYgTbBIkZjgcGsgShjlYeBXWCWb6iysqzdeX1aq8Bb3BqihclchbNG0oHjIUZn0ceGaDwxQ7gDRyFX6AYQ2Uh5iFz3ozckEbYtiWhx1vyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrMceoHdO70Mum7GRXDHPu0SCJW6dRe0c9kMPEgT7DY=;
 b=AOkYsicovfoj90pxrvnDp4dfNwQhk0kf83U9UHONYx/oo/pxPgVjXqnlBn2wWyCaXtIZ3ph8wG/v+BMZhcn0MVpLU6OAmZXnx72ABixih3NXEe7oG8E+5VDpOfWPGAFzh/xTnt1RkhaRVViHNXfhN1FwGLDa7rXxPH0/MXkb8Zc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3090.namprd12.prod.outlook.com (2603:10b6:408:67::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 22:16:09 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:16:09 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf report: Add support to print a textual representation of IBS raw sample data
Date:   Tue, 17 Aug 2021 17:15:09 -0500
Message-Id: <20210817221509.88391-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817221509.88391-1-kim.phillips@amd.com>
References: <20210817221509.88391-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::11) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SA9P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 22:16:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee68246a-8a71-4926-399a-08d961cc9d81
X-MS-TrafficTypeDiagnostic: BN8PR12MB3090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB30908010F883F284466EEFDB87FE9@BN8PR12MB3090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqdH7S4cMQKEkXr6U3wHcMNUE2vZ7PDO3/DXyvO/nvXTecuao7rZO4idYWMzUX4jMk8c9jMeURklLw9V7xUBylURpd3nR6tYXAAIS9Rg7cN56S9nsFTlWeOKrswGKNq16vxK2BTXDXpmZCtvblqpZDjs1T5XjJ5O9I6xCzL1pQoniXkbkhnNgpoU7vIbFbdItJPO7ngX5qEpwJiStXPvXPj6J6wuLydtydpdUkadrdGUVQ7TXQISDDgZ+GOsx2TgrP6gbEd8F0bwM5OD6p94xqX/jeMDlFdLXLXuY+AVGOjDDgPm/lebNlnvVXRMiqd1QZcfF0spOi1axvvv1kcRxR+XR2Khp+IRERT/Ozc//e5rP+LULfe/NbarthQDfQO5CeljRC9XJ+4fUDdRyfjNRVwOQZAh96aiNvLZd+UQ3a/+V0tg0MwWiUUMefznP869MLDsipG+EEFz5Ye1Yud5YQK+8KOTmthjJzKBvHCd2aTfyzstlSDRUFLb1hgKXYj4QMDRTfWUYISiBELb/QkTov87RUN8d5jXEfrjb9+VuorwxSEtJxAS9uyxAemgmAi1VC3Jo53s0MX7fBxo4l8eAzZoruACGpvSljd9Q2vxpSO8luDQVLL5uFGFZAToP5zG5+UezhT7bKVXh44CflpEencVBJnJV8238ce9BVvX+r1IjzyENzuSyYToHstrHEVfLjxUZDa3ybMrcgbw3EvgmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(38350700002)(44832011)(4326008)(186003)(1076003)(26005)(2906002)(54906003)(7416002)(66946007)(66476007)(66556008)(86362001)(2616005)(956004)(6486002)(8676002)(316002)(83380400001)(5660300002)(8936002)(36756003)(7696005)(52116002)(30864003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5WzWCO+z2NLscAEUJuk0Fw8Yc35wav/7l0dtRrEvnh33rw1hZ6UOMi5HCoX/?=
 =?us-ascii?Q?Isq6c6wRBv9PqfmWEy3M5sWLju5iIkWisLtkDmW4UlXC33qI4+GIIwipcgEA?=
 =?us-ascii?Q?1BVGaex5JsqSlDz7lQXivt0RVYIbckWqKfLHnJi3UwKNPWcRsfeHqcvUeYjR?=
 =?us-ascii?Q?nGpRhJi2s3hSQByKPnhvlv2lhoWLs4z/R11i7tCY9tmohmYqa133uncBjjbn?=
 =?us-ascii?Q?MyYmyKaatfGOdw4XY0T+I3I/DdN/YrgTtDr/7s8+CVOSqBGn5rSgLp6QmdX3?=
 =?us-ascii?Q?MqjVfB3tyly6koOZubNk0JWyAkbDM6gMKv4xjZezYWPX2tbBeVbaZEVnGDy5?=
 =?us-ascii?Q?EDVoTsbKMF9x7kZKWmLDx5mxEjWmbKaSB2pUERTYGeYqC8Nt8s98zy/gL/ia?=
 =?us-ascii?Q?ZQsqTbCcidziuz3XowfvMV0M0Yb5ZkzjWkaRH/4tmxgnBjSzZQHdRBHn7dSV?=
 =?us-ascii?Q?GaHFjpQPo/0e/rWYQYUdRXaW5k+ghVWbl9C7qIqPeFadg02/pIsrdCW9hN3v?=
 =?us-ascii?Q?bo3pb7370mJr4pOgA3nIKX+YwX9jtSW5hD/be7nFT3obPwG4YnNIgaWrQNZV?=
 =?us-ascii?Q?klxRfDUohsZ2wN+6C90EGT4u0i5hlErdpODmDF99/WYccL2Aj5rWieitMqUi?=
 =?us-ascii?Q?4ouoXhJiV8QXxfP26Qnt0AKaxXybZqWaB3D7b6WNI7FyXZTE0tjVjUcm3PJa?=
 =?us-ascii?Q?K8j4oOv8wf5G49H0Q2/HbA9cDxCWrXNortem1y+9F8a4GvfFw3VXgIKodiVB?=
 =?us-ascii?Q?vrDVPxbXSqzdZTh4k6+Y6wwAQ3wipyM1tahB9OUtCh15pjKXswT7lgnweEuK?=
 =?us-ascii?Q?4OSUvt8OX3zwo2zX+GKlGnQ8dAUUkmb36nBBZVn1gJORxiKc+38POuRrWDbU?=
 =?us-ascii?Q?bf/QFokdWISuVRSscUy5YEFCqHCxdSlapDVjVGFOn3HBORA5ER05Zc/n4Nn4?=
 =?us-ascii?Q?aWFOGW8dIiyAUFu1LoSQi3LV10jn6DRtewZn2xwV7tqFjrZ8CA+UMPOodkO4?=
 =?us-ascii?Q?lG8Hc4hWxMmFbpndjQM9JOb4c2vARvZ3nBIuQWPSwnQOGcFiN2uf4mbBjtlL?=
 =?us-ascii?Q?MxArUjDt90+b96BGcqQBPRF4nNm2mCHeXFuOIDtgngAzWCU2Sr0or0KEnyly?=
 =?us-ascii?Q?gnzRyBI9UUgfn2fURbTretiL/DgBhkYekdIh9z7lB4TYwRFCyNpdOWYtJdVZ?=
 =?us-ascii?Q?oX/k/qaQsVyvghld3hBAxjwZJsPFIttVZHpascPsz7CGCdj+Yfw5s4q1W1tH?=
 =?us-ascii?Q?Eq8Ef2E9L7MG27iMcE2j4+ThdFHcmbfN25Qfmckcn66pphv4wqVmWT5VwmAG?=
 =?us-ascii?Q?IRzHhiCHVkp/a20wr0LAV5Mc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee68246a-8a71-4926-399a-08d961cc9d81
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:16:09.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQ08xgK/hMFwyIlp1pp+gx5l6C8JAvzdSwq1Id+et+ZQLznP+Ods9attNuWI3Ht5N3f5skTVy9cAkUKfVDvRnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3090
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Perf records IBS (Instruction Based Sampling) extra sample data when
'perf record --raw-samples' is used with an IBS-compatible event, on a
machine that supports IBS.  IBS support is indicated in
CPUID_Fn80000001_ECX bit #10.

Up until now, users have been able to see the extra sample data solely
in raw hex format using 'perf report --dump-raw-trace'.  From there,
users could decode the data either manually, or by using an external
script.

Enable the built-in 'perf report --dump-raw-trace' to do the decoding
of the extra sample data bits, so manual or external script decoding
isn't necessary.

Example usage:

sudo perf record -c 10000001 -a --raw-samples -e ibs_fetch/rand_en=1/,ibs_op/cnt_ctl=1/ -C 0,1 taskset -c 0,1 7za b -mmt2 | perf report --dump-raw-trace

Stdout contains IBS Fetch samples, e.g.:

ibs_fetch_ctl:	02170007ffffffff MaxCnt 1048560 Cnt 1048560 Lat     7 En 1 Val 1 Comp 1 IcMiss 0 PhyAddrValid 1 L1TlbPgSz 4KB L1TlbMiss 0 L2TlbMiss 0 RandEn 1 L2Miss 0
IbsFetchLinAd:	000056016b2ead40
IbsFetchPhysAd:	000000115cedfd40
ic_ibs_ext_ctl:	0000000000000000 IbsItlbRefillLat   0

..and IBS Op samples, e.g.:

ibs_op_ctl:	0000009e009e8968 MaxCnt  10000000 En 1 Val 1 CntCtl 1=uOps CurCnt       158
IbsOpRip:	000056016b2ea73d
ibs_op_data:	00000000000b0002 CompToRetCtr     2 TagToRetCtr    11 BrnRet 0  RipInvalid 0 BrnFuse 0 Microcode 0
ibs_op_data2:	0000000000000002 CacheHitSt 0=M-state RmtNode 0 DataSrc 2=Local node cache
ibs_op_data3:	0000000000c60002 LdOp 0 StOp 1 DcL1TlbMiss 0 DcL2TlbMiss 0 DcL1TlbHit2M 0 DcL1TlbHit1G 0 DcL2TlbHit2M 0 DcMiss 0 DcMisAcc 0 DcWcMemAcc 0 DcUcMemAcc 0 DcLockedOp 0 DcMissNoMabAlloc 0 DcLinAddrValid 1 DcPhyAddrValid 1 DcL2TlbHit1G 0 L2Miss 0 SwPf 0 OpMemWidth  4 bytes OpDcMissOpenMemReqs  0 DcMissLat     0 TlbRefillLat     0
IbsDCLinAd:	00007f133c319ce0
IbsDCPhysAd:	0000000270485ce0

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
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
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
---
 tools/perf/util/Build            |   1 +
 tools/perf/util/amd-sample-raw.c | 290 +++++++++++++++++++++++++++++++
 tools/perf/util/sample-raw.c     |   8 +
 tools/perf/util/sample-raw.h     |   6 +-
 4 files changed, 304 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/amd-sample-raw.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2d4fa1304178..f2914d5bed6e 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -59,6 +59,7 @@ perf-y += pstack.o
 perf-y += session.o
 perf-y += sample-raw.o
 perf-y += s390-sample-raw.o
+perf-y += amd-sample-raw.o
 perf-$(CONFIG_TRACE) += syscalltbl.o
 perf-y += ordered-events.o
 perf-y += namespaces.o
diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
new file mode 100644
index 000000000000..fc1f670e8856
--- /dev/null
+++ b/tools/perf/util/amd-sample-raw.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD specific. Provide textual annotation for IBS raw sample data.
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include <linux/string.h>
+#include <asm/amd-ibs.h>
+
+#include "debug.h"
+#include "session.h"
+#include "evlist.h"
+#include "sample-raw.h"
+#include "pmu-events/pmu-events.h"
+
+static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
+
+static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
+{
+	const char * const ic_miss_strs[] = {
+		" IcMiss 0",
+		" IcMiss 1",
+	};
+	const char * const l1tlb_pgsz_strs[] = {
+		" L1TlbPgSz 4KB",
+		" L1TlbPgSz 2MB",
+		" L1TlbPgSz 1GB",
+		" L1TlbPgSz RESERVED"
+	};
+	const char * const l1tlb_pgsz_strs_erratum1347[] = {
+		" L1TlbPgSz 4KB",
+		" L1TlbPgSz 16KB",
+		" L1TlbPgSz 2MB",
+		" L1TlbPgSz 1GB"
+	};
+	const char *ic_miss_str = NULL;
+	const char *l1tlb_pgsz_str = NULL;
+
+	if (cpu_family == 0x19 && cpu_model < 0x10) {
+		/*
+		 * Erratum #1238 workaround is to ignore MSRC001_1030[IbsIcMiss]
+		 * Erratum #1347 workaround is to use table provided in erratum
+		 */
+		if (reg.phy_addr_valid)
+			l1tlb_pgsz_str = l1tlb_pgsz_strs_erratum1347[reg.l1tlb_pgsz];
+	} else {
+		if (reg.phy_addr_valid)
+			l1tlb_pgsz_str = l1tlb_pgsz_strs[reg.l1tlb_pgsz];
+		ic_miss_str = ic_miss_strs[reg.ic_miss];
+	}
+
+	printf("ibs_fetch_ctl:\t%016llx MaxCnt %7d Cnt %7d Lat %5d En %d Val %d Comp %d%s "
+	       "PhyAddrValid %d%s L1TlbMiss %d L2TlbMiss %d RandEn %d%s\n",
+		reg.val, reg.fetch_maxcnt << 4, reg.fetch_cnt << 4, reg.fetch_lat,
+		reg.fetch_en, reg.fetch_val, reg.fetch_comp, ic_miss_str ? : "",
+		reg.phy_addr_valid, l1tlb_pgsz_str ? : "", reg.l1tlb_miss, reg.l2tlb_miss,
+		reg.rand_en, reg.fetch_comp ? (reg.fetch_l2_miss ? " L2Miss 1" : " L2Miss 0") : "");
+}
+
+static void pr_ic_ibs_extd_ctl(union ic_ibs_extd_ctl reg)
+{
+	printf("ic_ibs_ext_ctl:\t%016llx IbsItlbRefillLat %3d\n", reg.val, reg.itlb_refill_lat);
+}
+
+static void pr_ibs_op_ctl(union ibs_op_ctl reg)
+{
+	printf("ibs_op_ctl:\t%016llx MaxCnt %9d En %d Val %d CntCtl %d=%s CurCnt %9d\n",
+	       reg.val, ((reg.opmaxcnt_ext << 16) | reg.opmaxcnt) << 4, reg.op_en, reg.op_val,
+	       reg.cnt_ctl, reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt);
+}
+
+static void pr_ibs_op_data(union ibs_op_data reg)
+{
+	printf("ibs_op_data:\t%016llx CompToRetCtr %5d TagToRetCtr %5d%s%s%s BrnRet %d "
+		" RipInvalid %d BrnFuse %d Microcode %d\n",
+		reg.val, reg.comp_to_ret_ctr, reg.tag_to_ret_ctr,
+		reg.op_brn_ret ? (reg.op_return ? " OpReturn 1" : " OpReturn 0") : "",
+		reg.op_brn_ret ? (reg.op_brn_taken ? " OpBrnTaken 1" : " OpBrnTaken 0") : "",
+		reg.op_brn_ret ? (reg.op_brn_misp ? " OpBrnMisp 1" : " OpBrnMisp 0") : "",
+		reg.op_brn_ret, reg.op_rip_invalid, reg.op_brn_fuse, reg.op_microcode);
+}
+
+static void pr_ibs_op_data2(union ibs_op_data2 reg)
+{
+	static const char * const data_src_str[] = {
+		"",
+		" DataSrc 1=(reserved)",
+		" DataSrc 2=Local node cache",
+		" DataSrc 3=DRAM",
+		" DataSrc 4=Remote node cache",
+		" DataSrc 5=(reserved)",
+		" DataSrc 6=(reserved)",
+		" DataSrc 7=Other"
+	};
+
+	printf("ibs_op_data2:\t%016llx %sRmtNode %d%s\n", reg.val,
+	       reg.data_src == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
+						     : "CacheHitSt 0=M-state ") : "",
+	       reg.rmt_node, data_src_str[reg.data_src]);
+}
+
+static void pr_ibs_op_data3(union ibs_op_data3 reg)
+{
+	char l2_miss_str[sizeof(" L2Miss _")] = "";
+	char op_mem_width_str[sizeof(" OpMemWidth __ bytes")] = "";
+	char op_dc_miss_open_mem_reqs_str[sizeof(" OpDcMissOpenMemReqs __")] = "";
+
+	/*
+	 * Erratum #1293
+	 * Ignore L2Miss and OpDcMissOpenMemReqs (and opdata2) if DcMissNoMabAlloc or SwPf set
+	 */
+	if (!(cpu_family == 0x19 && cpu_model < 0x10 && (reg.dc_miss_no_mab_alloc || reg.sw_pf))) {
+		snprintf(l2_miss_str, sizeof(" L2Miss _"),
+			 " L2Miss %d", reg.l2_miss);
+		snprintf(op_dc_miss_open_mem_reqs_str, sizeof(" OpDcMissOpenMemReqs __"),
+			 " OpDcMissOpenMemReqs %2d", reg.op_dc_miss_open_mem_reqs);
+	}
+
+	if (reg.op_mem_width)
+		snprintf(op_mem_width_str, sizeof(" OpMemWidth __ bytes"),
+			 " OpMemWidth %2d bytes", 1 << (reg.op_mem_width - 1));
+
+	printf("ibs_op_data3:\t%016llx LdOp %d StOp %d DcL1TlbMiss %d DcL2TlbMiss %d "
+		"DcL1TlbHit2M %d DcL1TlbHit1G %d DcL2TlbHit2M %d DcMiss %d DcMisAcc %d "
+		"DcWcMemAcc %d DcUcMemAcc %d DcLockedOp %d DcMissNoMabAlloc %d DcLinAddrValid %d "
+		"DcPhyAddrValid %d DcL2TlbHit1G %d%s SwPf %d%s%s DcMissLat %5d TlbRefillLat %5d\n",
+		reg.val, reg.ld_op, reg.st_op, reg.dc_l1tlb_miss, reg.dc_l2tlb_miss,
+		reg.dc_l1tlb_hit_2m, reg.dc_l1tlb_hit_1g, reg.dc_l2tlb_hit_2m, reg.dc_miss,
+		reg.dc_mis_acc, reg.dc_wc_mem_acc, reg.dc_uc_mem_acc, reg.dc_locked_op,
+		reg.dc_miss_no_mab_alloc, reg.dc_lin_addr_valid, reg.dc_phy_addr_valid,
+		reg.dc_l2_tlb_hit_1g, l2_miss_str, reg.sw_pf, op_mem_width_str,
+		op_dc_miss_open_mem_reqs_str, reg.dc_miss_lat, reg.tlb_refill_lat);
+}
+
+/*
+ * IBS Op/Execution MSRs always saved, in order, are:
+ * IBS_OP_CTL, IBS_OP_RIP, IBS_OP_DATA, IBS_OP_DATA2,
+ * IBS_OP_DATA3, IBS_DC_LINADDR, IBS_DC_PHYSADDR, BP_IBSTGT_RIP
+ */
+static void amd_dump_ibs_op(struct perf_sample *sample)
+{
+	struct perf_ibs_data *data = sample->raw_data;
+	union ibs_op_ctl *op_ctl = (union ibs_op_ctl *)data->data;
+	__u64 *rip = (__u64 *)op_ctl + 1;
+	union ibs_op_data *op_data = (union ibs_op_data *)(rip + 1);
+	union ibs_op_data3 *op_data3 = (union ibs_op_data3 *)(rip + 3);
+
+	pr_ibs_op_ctl(*op_ctl);
+	if (!op_data->op_rip_invalid)
+		printf("IbsOpRip:\t%016llx\n", *rip);
+	pr_ibs_op_data(*op_data);
+	/*
+	 * Erratum #1293: ignore op_data2 if DcMissNoMabAlloc or SwPf are set
+	 */
+	if (!(cpu_family == 0x19 && cpu_model < 0x10 &&
+	      (op_data3->dc_miss_no_mab_alloc || op_data3->sw_pf)))
+		pr_ibs_op_data2(*(union ibs_op_data2 *)(rip + 2));
+	pr_ibs_op_data3(*op_data3);
+	if (op_data3->dc_lin_addr_valid)
+		printf("IbsDCLinAd:\t%016llx\n", *(rip + 4));
+	if (op_data3->dc_phy_addr_valid)
+		printf("IbsDCPhysAd:\t%016llx\n", *(rip + 5));
+	if (op_data->op_brn_ret && *(rip + 6))
+		printf("IbsBrTarget:\t%016llx\n", *(rip + 6));
+}
+
+/*
+ * IBS Fetch MSRs always saved, in order, are:
+ * IBS_FETCH_CTL, IBS_FETCH_LINADDR, IBS_FETCH_PHYSADDR, IC_IBS_EXTD_CTL
+ */
+static void amd_dump_ibs_fetch(struct perf_sample *sample)
+{
+	struct perf_ibs_data *data = sample->raw_data;
+	union ibs_fetch_ctl *fetch_ctl = (union ibs_fetch_ctl *)data->data;
+	__u64 *addr = (__u64 *)fetch_ctl + 1;
+	union ic_ibs_extd_ctl *extd_ctl = (union ic_ibs_extd_ctl *)addr + 2;
+
+	pr_ibs_fetch_ctl(*fetch_ctl);
+	printf("IbsFetchLinAd:\t%016llx\n", *addr++);
+	if (fetch_ctl->phy_addr_valid)
+		printf("IbsFetchPhysAd:\t%016llx\n", *addr);
+	pr_ic_ibs_extd_ctl(*extd_ctl);
+}
+
+/*
+ * Test for enable and valid bits in captured control MSRs.
+ */
+static bool is_valid_ibs_fetch_sample(struct perf_sample *sample)
+{
+	struct perf_ibs_data *data = sample->raw_data;
+	union ibs_fetch_ctl *fetch_ctl = (union ibs_fetch_ctl *)data->data;
+
+	if (fetch_ctl->fetch_en && fetch_ctl->fetch_val)
+		return true;
+
+	return false;
+}
+
+static bool is_valid_ibs_op_sample(struct perf_sample *sample)
+{
+	struct perf_ibs_data *data = sample->raw_data;
+	union ibs_op_ctl *op_ctl = (union ibs_op_ctl *)data->data;
+
+	if (op_ctl->op_en && op_ctl->op_val)
+		return true;
+
+	return false;
+}
+
+/* AMD vendor specific raw sample function. Check for PERF_RECORD_SAMPLE events
+ * and if the event was triggered by IBS, display its raw data with decoded text.
+ * The function is only invoked when the dump flag -D is set.
+ */
+void evlist__amd_sample_raw(struct evlist *evlist, union perf_event *event,
+			    struct perf_sample *sample)
+{
+	struct evsel *evsel;
+
+	if (event->header.type != PERF_RECORD_SAMPLE || !sample->raw_size)
+		return;
+
+	evsel = evlist__event2evsel(evlist, event);
+	if (!evsel)
+		return;
+
+	if (evsel->core.attr.type == ibs_fetch_type) {
+		if (!is_valid_ibs_fetch_sample(sample)) {
+			pr_debug("Invalid raw IBS Fetch MSR data encountered\n");
+			return;
+		}
+		amd_dump_ibs_fetch(sample);
+	} else if (evsel->core.attr.type == ibs_op_type) {
+		if (!is_valid_ibs_op_sample(sample)) {
+			pr_debug("Invalid raw IBS Op MSR data encountered\n");
+			return;
+		}
+		amd_dump_ibs_op(sample);
+	}
+}
+
+static void parse_cpuid(struct perf_env *env)
+{
+	const char *cpuid;
+	int ret;
+
+	cpuid = perf_env__cpuid(env);
+	/*
+	 * cpuid = "AuthenticAMD,family,model,stepping"
+	 */
+	ret = sscanf(cpuid, "%*[^,],%u,%u", &cpu_family, &cpu_model);
+	if (ret != 2)
+		pr_debug("problem parsing cpuid\n");
+}
+
+/*
+ * Find and assign the type number used for ibs_op or ibs_fetch samples.
+ * Device names can be large - we are only interested in the first 9 characters,
+ * to match "ibs_fetch".
+ */
+bool evlist__has_amd_ibs(struct evlist *evlist)
+{
+	struct perf_env *env = evlist->env;
+	int ret, nr_pmu_mappings = perf_env__nr_pmu_mappings(env);
+	const char *pmu_mapping = perf_env__pmu_mappings(env);
+	char name[sizeof("ibs_fetch")];
+	u32 type;
+
+	while (nr_pmu_mappings--) {
+		ret = sscanf(pmu_mapping, "%u:%9s", &type, name);
+		if (ret == 2) {
+			if (strstarts(name, "ibs_op"))
+				ibs_op_type = type;
+			else if (strstarts(name, "ibs_fetch"))
+				ibs_fetch_type = type;
+		}
+		pmu_mapping += strlen(pmu_mapping) + 1 /* '\0' */;
+	}
+
+	if (ibs_fetch_type || ibs_op_type) {
+		if (!cpu_family)
+			parse_cpuid(env);
+		return true;
+	}
+
+	return false;
+}
diff --git a/tools/perf/util/sample-raw.c b/tools/perf/util/sample-raw.c
index cde5cd3ce49b..f3f6bd9d290e 100644
--- a/tools/perf/util/sample-raw.c
+++ b/tools/perf/util/sample-raw.c
@@ -1,8 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include <string.h>
+#include <linux/string.h>
 #include "evlist.h"
 #include "env.h"
+#include "header.h"
 #include "sample-raw.h"
 
 /*
@@ -12,7 +14,13 @@
 void evlist__init_trace_event_sample_raw(struct evlist *evlist)
 {
 	const char *arch_pf = perf_env__arch(evlist->env);
+	const char *cpuid = perf_env__cpuid(evlist->env);
 
 	if (arch_pf && !strcmp("s390", arch_pf))
 		evlist->trace_event_sample_raw = evlist__s390_sample_raw;
+	else if (arch_pf && !strcmp("x86", arch_pf) &&
+		 cpuid && strstarts(cpuid, "AuthenticAMD") &&
+		 evlist__has_amd_ibs(evlist)) {
+		evlist->trace_event_sample_raw = evlist__amd_sample_raw;
+	}
 }
diff --git a/tools/perf/util/sample-raw.h b/tools/perf/util/sample-raw.h
index 4be84a5510cf..ea01c5811503 100644
--- a/tools/perf/util/sample-raw.h
+++ b/tools/perf/util/sample-raw.h
@@ -6,6 +6,10 @@ struct evlist;
 union perf_event;
 struct perf_sample;
 
-void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event, struct perf_sample *sample);
+void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
+			     struct perf_sample *sample);
+bool evlist__has_amd_ibs(struct evlist *evlist);
+void evlist__amd_sample_raw(struct evlist *evlist, union perf_event *event,
+			    struct perf_sample *sample);
 void evlist__init_trace_event_sample_raw(struct evlist *evlist);
 #endif /* __PERF_EVLIST_H */
-- 
2.31.1

