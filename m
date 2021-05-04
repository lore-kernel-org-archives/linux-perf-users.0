Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA07C433B4
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 May 2021 06:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6F661175
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 May 2021 06:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhEDGkW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 May 2021 02:40:22 -0400
Received: from mail-bn1nam07on2045.outbound.protection.outlook.com ([40.107.212.45]:38371
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229724AbhEDGkU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 May 2021 02:40:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cENtQjJuzjV8FDZL/jlx9107HU22NzAHNdr6rkxjQELZpaAuksHcpEScQ+DnOhTijahCx11sBZMe8uYwAs0GQcaYtZ/oumBAndpR/C1Eiy9WiXFlAzuRHGC3//iNG3Cm1+eJf7SplyNPDvuVZ/cR25xqVbhC52PGz7jKschI647UFWOgQeie8+fq4up649I8ZeIb7G6cjBZDDf1fymDLm3cPRM22JwiklLWAbqFKOVq/Fvm0M8K6Fqj/TaKa8YWzigKotX+AD40FXDnt1XIKa1yrcd7fNsIHUJPLw+CyyKX7dAM5lMjsFN7L/Uww02ww/va8LmdmjGyCr+t1QuRHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByoA+Kort+TPrDrZlHGtVCm21BVibHpcee/kXDiC9T8=;
 b=AVaYSsOV66T0kEBAuNT1hjR15PkaGzwosQbx/FEazEmcwxoLpWV38iqBZ2x+h3qrrYZodZZ1wRAWUfX2UXj4OTvXaLRWkX4AUc0Mtp9dmeudRG1MbYZKTwVWcqiISK7lKJGi6q0LH3GFN5sYd8skce7SZdZE3KdEN44A9nEOSqr4fbIFcFQVioU/ONG1PKG9pcUU2npjdXxEAAn1fof8FxNVJsydoSh6QFj7h2yJ2dZhxEmsGaYeltQWAwpPYmrrdA0UOiOevyeJNQoxXOJVxKqCIDqC3SDlc/n1mQJPa0fQOqiESjOmK3bjMfM4orRLB4TJ9CcJYSbOs9KQ5BA0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByoA+Kort+TPrDrZlHGtVCm21BVibHpcee/kXDiC9T8=;
 b=JgPcNEEcG58jDXBYkbxkfmt1y6lIkFbSDKtIFYZM2SQAQHyyb7gurbSojoqRmTbYdP+MJdUAifPOIkXIe83rmQDMoSARiXmKG4Lz15B33WrpAwYWiDVmcXKGFjx/RS0VCijFGRuBZKzEjX5D9kQe0/8IRkNzBR34df9Uieqmxxk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4002.namprd12.prod.outlook.com (2603:10b6:a03:1ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Tue, 4 May
 2021 06:39:22 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 06:39:22 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     peterz@infradead.org, mingo@redhat.com, joro@8bytes.org,
        Jon.Grimm@amd.com, amonakov@ispras.ru,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        David Coe <david.coe@live.co.uk>
Subject: [PATCH] x86/events/amd/iommu: Fix invalid Perf result due to IOMMU PMC power-gating
Date:   Tue,  4 May 2021 01:52:36 -0500
Message-Id: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.184.1]
X-ClientProxiedBy: BN9PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:408:f4::34) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.184.1) by BN9PR03CA0179.namprd03.prod.outlook.com (2603:10b6:408:f4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Tue, 4 May 2021 06:39:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d05afa-7678-4dcd-7899-08d90ec759d3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4002F08777E027DE5465C708F35A9@BY5PR12MB4002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXtFAAcJ2+/i9O2F1EmmVISspKoPHD0JzjteLVXg9KduXObjKVKEBjnLA/FBo9gw344XJLVZI5SKiwIqATVvqk0AcvA5Y5oFT5MyD6Rr+JdO6sWdC9UbPVdcDRKAJZ49UTGs/ffycTBrg44jdPvIov+MhUxcfqJTvV8bdrCzarKgWX5XZ909l15aNBzJecKrwsJhIAwm6aopLr2zc2qNONRIs9mR7ex8biDkKnZN3zt/X6fQIdvDCPZ4rSoPltOm1laTjP0h3M4sYvjRIVR2iES5rsaDzcp67BiyR46m2ifxmksLmqZoilpuGfH3xoaJjOMD3TR8YE+UAUOu16t7EKVA3yUYiYRtrojqgmItRhUenddxKItiyTrCQJyc6SjGFvKNf43mUkMOVdazsrajnQX+jAP4dAesE4jpdIVPlBWhaJsUZytQ2zTqQk5UhIHTHe5vhjNkaZJ7AP1KhI76pw3PWmTaFiUo5YnDfyIkaT7nTVLEPUKwo/o40IcsAbhO9NT+E5xtABdUumhTYoNBnh1bFv9B8lh8teGp5AzaD0dnODhwUiKh6oqLiLmyvKqV6CSGjVHHh0R/9HZCQHfXSJWZrhjlYnQZPCi6mTEVSqknF9sk8zii/PeBSwLE+ksuvzvEl31tduSDKg4B1XNKzH7DRj86Y2S+EY1NhUX9OMPWcfhTgGh8nL6HO0Vw9daO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(478600001)(34580700001)(956004)(66476007)(52116002)(54906003)(38100700002)(2616005)(66946007)(66556008)(186003)(44832011)(26005)(86362001)(83380400001)(6486002)(4326008)(8676002)(1076003)(38350700002)(5660300002)(8936002)(316002)(2906002)(36756003)(16526019)(6666004)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zbB+3uv4/Dk9EBwNP0wZ0tk9GYqTbU5/ASQvA6au24ayYJF6mMBrr8aHAayp?=
 =?us-ascii?Q?5kKLZoEhtoL5k7Zt/xV+LCosm4KaOWVHz0GylVOUoJ14jK3kWoXOCCHaUfGz?=
 =?us-ascii?Q?wUOBWT6wa3aRsswnbPW1EqhCCp21f7+x9hQQN0J6xgbAQXrnRAe2ZJbiw9aW?=
 =?us-ascii?Q?714SQNfgpgELVpfw1EuZoKdLIbRjy0V05kf4GUiaz/RV9pCzhXkPK4In7nRq?=
 =?us-ascii?Q?n4BLtAzHUtutLg58mzmNaRgO26j7EBtRmNTSZPYMkMIJftLwPuIOqVmRbNzG?=
 =?us-ascii?Q?7hqg2JgmaYRRWnDgck69U+Ss5WLa81b/2i8YtLkdDV//rrJN3GzSYP/cMT/X?=
 =?us-ascii?Q?HCagTTEvImE3bKDmXFPOHC9EhF/AeFUfFYaK/UQ/tRP0NpPflqDZjRXMRkwo?=
 =?us-ascii?Q?fyOYUa+T3JXDPQ3Ed7Yica+RI+J0V3rI7mxSHwnwN4Y780L02l+P5yeJLE63?=
 =?us-ascii?Q?gW//mWCeGoqRsX1Jvjmt3qcaKDYp1BGfW4QjqXc16KR8A5AMe+SCxzQn3XQK?=
 =?us-ascii?Q?uk1zjYtLBGQcNoDHEQ23XO+s9yGYyIPXtR/vro2OlxyWEyCpcUS4c1tyGH/h?=
 =?us-ascii?Q?wPl8E7j8GWJZ2mEiVZy9Q8FKJ9MQV904gKLRBXmjDb30qK52lTXNqBI0v/FX?=
 =?us-ascii?Q?l7k3hapjKeTHBno4d/fTMpeVzi+BdlAigqw46eb7nlik1qt3uG7FS0XkyBQ/?=
 =?us-ascii?Q?BT3fYn7FE9WK2Bchv3V4YC3x88FKup64M2H3Q1eLwE0ESanBn58Oe5tlO09h?=
 =?us-ascii?Q?aT8Fcr9zwejEY9HHb/mOe8kQpNYmO+2+OzpdsLau28sxxjPd8V4ziGrgNLPS?=
 =?us-ascii?Q?qU3sv+GfgGW7b1LiTh6hb1KVWorVAEJhxgRJfhXhp48y2BK746JYw+3O97NF?=
 =?us-ascii?Q?O6DzwQolbZF0Bf6Y4EoTGSrpbUQxnmA1qW5Mhrcqychm+AnwcldQNc0SYUmW?=
 =?us-ascii?Q?i/2HBzoqM/xHfTzDyD3R6rxwle8APuKN2aWB8yeG0Dt2kQYqH8UIDrhY7lVL?=
 =?us-ascii?Q?B+WhjtiEiLrsGNa2lANUZAJyAjnkoi6trnUicaztslVEnomslPu6agtUL9/j?=
 =?us-ascii?Q?rYvF4sidbJlgJWqfCYNo5Dh/yJsWyxdXAEjyhSc+NixxZf9DEZdZ5ohui0QL?=
 =?us-ascii?Q?E+Hti3GXPb9fzbqDtCBOwxHIkwZVzVQ5dzwqhziGXbpux3thLK4DnATzprls?=
 =?us-ascii?Q?vhb8eGrF3O/OCfUwfbm+Y1lX9G597WQ6QFPikqNlkypatOsXcvoUivFDAvpK?=
 =?us-ascii?Q?opv7Ko+jokdcUhcqx/XPU8szImab2uiUDur39NMvjcF/CJL1jZDIBRdzxTse?=
 =?us-ascii?Q?tmJURBve7KsFcX8cJ9fr3nHL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d05afa-7678-4dcd-7899-08d90ec759d3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 06:39:22.1715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcfUvXYEZtlWVqP550t6Jnes7KwHa+162V1vPbkhyRk+fFoc163blyAq5KiZ2mlpH6S1ZeXOuQowHYdwe6z8QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4002
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On certain AMD platforms, when the IOMMU performance counter source
(csource) field is zero, power-gating for the counter is enabled, which
prevents write access and returns zero for read access.

This can cause invalid perf result especially when event multiplexing
is needed (i.e. more number of events than available counters) since
the current logic keeps track of the previously read counter value,
and subsequently re-program the counter to continue counting the event.
With power-gating enabled, we cannot gurantee successful re-programming
of the counter.

Workaround this issue by :

1. Modifying the ordering of setting/reading counters and enabing/
   disabling csources to only access the counter when the csource
   is set to non-zero.

2. Since AMD IOMMU PMU does not support interrupt mode, the logic
   can be simplified to always start counting with value zero,
   and accumulate the counter value when stopping without the need
   to keep track and reprogram the counter with the previously read
   counter value.

This has been tested on systems with and without power-gating.

Fixes: 994d6608efe4 ("iommu/amd: Remove performance counter pre-initialization test")
Suggested-by: Alexander Monakov <amonakov@ispras.ru>
Cc: David Coe <david.coe@live.co.uk>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/events/amd/iommu.c | 47 ++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 1c1a7e45dc64..913745f1419b 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -19,8 +19,6 @@
 #include "../perf_event.h"
 #include "iommu.h"
 
-#define COUNTER_SHIFT		16
-
 /* iommu pmu conf masks */
 #define GET_CSOURCE(x)     ((x)->conf & 0xFFULL)
 #define GET_DEVID(x)       (((x)->conf >> 8)  & 0xFFFFULL)
@@ -286,22 +284,31 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
 	hwc->state = 0;
 
+	/*
+	 * To account for power-gating, which prevents write to
+	 * the counter, we need to enable the counter
+	 * before setting up counter register.
+	 */
+	perf_iommu_enable_event(event);
+
 	if (flags & PERF_EF_RELOAD) {
-		u64 prev_raw_count = local64_read(&hwc->prev_count);
+		u64 count = 0;
 		struct amd_iommu *iommu = perf_event_2_iommu(event);
 
+		/*
+		 * Since the IOMMU PMU only support counting mode,
+		 * the counter always start with value zero.
+		 */
 		amd_iommu_pc_set_reg(iommu, hwc->iommu_bank, hwc->iommu_cntr,
-				     IOMMU_PC_COUNTER_REG, &prev_raw_count);
+				     IOMMU_PC_COUNTER_REG, &count);
 	}
 
-	perf_iommu_enable_event(event);
 	perf_event_update_userpage(event);
-
 }
 
 static void perf_iommu_read(struct perf_event *event)
 {
-	u64 count, prev, delta;
+	u64 count;
 	struct hw_perf_event *hwc = &event->hw;
 	struct amd_iommu *iommu = perf_event_2_iommu(event);
 
@@ -312,14 +319,11 @@ static void perf_iommu_read(struct perf_event *event)
 	/* IOMMU pc counter register is only 48 bits */
 	count &= GENMASK_ULL(47, 0);
 
-	prev = local64_read(&hwc->prev_count);
-	if (local64_cmpxchg(&hwc->prev_count, prev, count) != prev)
-		return;
-
-	/* Handle 48-bit counter overflow */
-	delta = (count << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
-	delta >>= COUNTER_SHIFT;
-	local64_add(delta, &event->count);
+	/*
+	 * Since the counter always start with value zero,
+	 * simply just accumulate the count for the event.
+	 */
+	local64_add(count, &event->count);
 }
 
 static void perf_iommu_stop(struct perf_event *event, int flags)
@@ -329,15 +333,16 @@ static void perf_iommu_stop(struct perf_event *event, int flags)
 	if (hwc->state & PERF_HES_UPTODATE)
 		return;
 
+	/*
+	 * To account for power-gating, in which reading the counter would
+	 * return zero, we need to read the register before disabling.
+	 */
+	perf_iommu_read(event);
+	hwc->state |= PERF_HES_UPTODATE;
+
 	perf_iommu_disable_event(event);
 	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 	hwc->state |= PERF_HES_STOPPED;
-
-	if (hwc->state & PERF_HES_UPTODATE)
-		return;
-
-	perf_iommu_read(event);
-	hwc->state |= PERF_HES_UPTODATE;
 }
 
 static int perf_iommu_add(struct perf_event *event, int flags)
-- 
2.17.1

