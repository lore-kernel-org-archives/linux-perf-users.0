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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A26C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0ED60EB5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbhHQWNU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:13:20 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:38336
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234860AbhHQWNU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:13:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2PJAEvFiJWy/csl5seogl4Muj8Ga6O7ZfaP4Y7sgqNEWrKgCYGSUOqIg1JydZqK4QTnWP/zuF50iE4zml/3mxP70mqHZDyypeVjPsDCIrtpIM0DTFS3Se7Q5e1pv0TjQx7BKeITlgml+EeUPtctTP+Rj2Xo1hmsIgVOXkPIfdtxauZ03VT0j5Cd2BmjA04Hhz5Ws/rVtaevMUxlZLqUXe5gLOUV/UNGN2C/3xDb1ZO9IQJXELtM2yhgz37zL40JtlSCeBzB4UIT3GPiWttWGtKb3feFU35no76WIg7ffn4fqcIztYNg945QvFXc4Rkg/OmIgQYInfZazvhapSTJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0jH3FHypV+5gULm2ewH87yRvdYjBnTCaI51iypR1TM=;
 b=Qi1vvX64RI7lmIqcRdZd+nqrMVJZFqOCiJ4e57qwP9Z+vthoUCDRscxFXp0ApnVpJmsN4w4iyn3eYWXJ87hOdTdGF113nmooUsR+ieL3iS3ZAmsbJVV6gjPLFhgwExYJyxBZjN1tSi55Ct/s0PtdD//2qDkRxCyxrCI4jJkYI24Jsv+0gSnWgtzVM5qWnGr/fLvP9Vk/mpca2BhE8hCWmYbGsx7pYW92gsYJ9SQ1hMrLjayVNbEr1NbmTboHNpqrrPgtIUDMEKxsrZSpADwu1H4Kvypn+05i7tBDL7i34skWPClFl2LjALcWQV3WEXjVgWfJKMNNjnMfd3hePXmK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0jH3FHypV+5gULm2ewH87yRvdYjBnTCaI51iypR1TM=;
 b=X9RxMv1TuiXVXB6lWKfQi17LcSPuY0BEoAlHmasPbakKuNoMPY8dsYNGKGy0nrSWvJyufzysb5Mz1x3YFqKvq9GNGUM3HbxSVGwb9BeGtwsCQKZVsd1mUtKeCYZNzGwhMn3xWR7oFk+N/ObGUon000459CsQxUhmjPCbXqH+lsU=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3090.namprd12.prod.outlook.com (2603:10b6:408:67::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 22:12:43 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:12:43 +0000
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
Subject: [PATCH 7/8] perf/amd/uncore: Allow the driver to be built as a module
Date:   Tue, 17 Aug 2021 17:10:47 -0500
Message-Id: <20210817221048.88063-8-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817221048.88063-1-kim.phillips@amd.com>
References: <20210817221048.88063-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:806:d3::22) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SA0PR11CA0017.namprd11.prod.outlook.com (2603:10b6:806:d3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 22:12:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0264bf0-279a-402f-d683-08d961cc2276
X-MS-TrafficTypeDiagnostic: BN8PR12MB3090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3090F4D989B8B93DB0D3BC6387FE9@BN8PR12MB3090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YxCeFqMVKnFvVF2NPCRsULKjbIGVwDUpMdRFI1ToNluMzECWmhP+5auZHf5WbZKFawONg2hGKF5X3KMxWi4bdvwOB0Ue02m1NDWEVg9ThgMsSyrnLSwDLEfl1uSTkqrneDMdfU2ZpjnO2s0wZtDDNrCarNaP/1FraWSuJsSlVwOIdmw02lh+BsKJR5dOTZjHs5JQO9j+QJGypHM3Na866Vyzfl9V+sH05RNJ1oAKDUNnx6rWNhaEiY8F1ggE/+yOA87ANLUpq5nruB6/uUhN7Uxa/r0n/rKQtw9aSgfaBlhnu8hw4KkEhOd+HJMMjge0Qbq+zZoZkbcLUFJX7lZNpk7dt8S0+HZtSuZJ7e1olfPaz+RtZYDsnqVdsr4b0lNF2U4vN+1vgjqVk6ugZyN/9vKT7l2cSI+5RT+AwSg+TsrpQl1kX+5VsqA/ALXXsX6g9soTSn3ihE8ZWdDq0Qu4Mj2VIbEkdzhYmjCJrno8Zh9R6HAOOo6wysUuZkarJR8x4IGPCqJELbA+bQg496jPh2pya5m8+/001AXZCy/yMZxNtqcg9sZx31ToH5UiBVeEC8iZJHhppwBMi3dxbRrwdQU6yKZ+NqOQFqvKg2nGdi1KTnyhBCBMrzVa0DCuYyM3IIGe8iw0C/5ggLjKxIbxzo5cgfW9gz++saMxXGiVRZmKnsr8YNcUo4lpUIg3NWEVyN0vtrVlVw61UdwoSxkJxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(38350700002)(44832011)(4326008)(186003)(1076003)(26005)(2906002)(110136005)(54906003)(7416002)(66946007)(66476007)(66556008)(86362001)(2616005)(956004)(6486002)(8676002)(316002)(7049001)(83380400001)(5660300002)(8936002)(36756003)(7696005)(52116002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMUlY5nGHvh2Uh9SlI2+iLmn0mDEefun2W+e73MTdiAuG0MrBRJw+NSfPXUO?=
 =?us-ascii?Q?nXH/FSAKb+DyI1U6ZefpvBxRKDjqpMFdzOE3fW983oMILRA2yx2UzNtLmCit?=
 =?us-ascii?Q?LJilj5x2DJkzRHBQr1wsWt0wFRbWkut8vN6NgLvfk6/KNBZ19CdBcZlgn8C4?=
 =?us-ascii?Q?80rBVo/m1hzLtpkPJxxK/c2Gh5T7m77N6hsQXfw0QEWPLEzQL0wAV/4kDE6z?=
 =?us-ascii?Q?wQcqq46Yd7CfhzAMgkz0Ov2hAGGHtvY0tqN36aEEHG97danVTk5YtWEeIK2G?=
 =?us-ascii?Q?jLTwrb42rn4RVsjngK+aEMCI1gob+rYToFKcC7YeNQXrS1A2wRFc+OGVQWbp?=
 =?us-ascii?Q?+Tv3n0KpnZTjEzVlYS7eTdYlVNKwS/9CSgf62uYDRFFHSQH8ahIdrOeqL4PB?=
 =?us-ascii?Q?zS8T+wWNe7VnVhp3jER1hvT3Bf7DLdMsC7M07EwBtaszCdkKOwO7mHl0Xmb0?=
 =?us-ascii?Q?XPxQbqlqsLh49mdBnGpauLIqYapeoo/Aij1F8WqI1RPHV7agkXQGX2G/wNlt?=
 =?us-ascii?Q?LFdkhU6pGPr5pzThbRwX4Tarw/xG0vcqKvo0Iblg2eA/cGzEMPsyqR73I/Tu?=
 =?us-ascii?Q?Yh+4y6jxOt/JVq11Af5T1bUPSI8nx1aldNdwfi+mm3r2RBsa37x0v7cuWDYo?=
 =?us-ascii?Q?t1rNd/uV6PNYVDeNbVna2pc+ISCX52VF0BOeDm3T4sXW1rJuz32+TblWUDtw?=
 =?us-ascii?Q?IV6nBNDy3aV/Kg4ArpLIX5h+dah3/zE7mmHZVPir3OJrc96aNPb6BvttjqUM?=
 =?us-ascii?Q?3X7CgMUY9o8tjEGDnWU7dO2RFS0q7HANCcW6RLCjkBrkzf4JBa6uNBDY1ug9?=
 =?us-ascii?Q?quUJwEp9Fzlg6lMO3eAiGOB69WEzRXu5Vs3J0anrHAcqyCM6pl57aTQ+ZtlP?=
 =?us-ascii?Q?LPKMzddcJZkMvlgtsDCTvvWYZpg35sbUCfGLih/iI358/9iH8yFuSYokF7+q?=
 =?us-ascii?Q?auYS5koFUz4C4h0+ONAazSxVSTKr6nxkIqwZr7AinskE6WoBvyVJiirN0YHD?=
 =?us-ascii?Q?+PGcYgeco8wvKzIndNPNWretI2dDCNPT9/kdFOZ3mspELtRfTHvkmoH1uZFL?=
 =?us-ascii?Q?xqkjujTkMNC6IVh6CDKkbE9yOLBtcmTj1N+ZpXoz/HQWclYdfacU8C9ggI8W?=
 =?us-ascii?Q?mkjGlfnnPP6g6CVRqtzHZeCn1juEv8ItApJJrZ6oJFt9m69V05ylBCgKPhaE?=
 =?us-ascii?Q?mUZZ4tCQd3TwYdsBAWxx1t5Y48Irmf5HLxJGa+g6PCNeBA+QfY6V3Eltx84h?=
 =?us-ascii?Q?hhVK30fZQ4cJriDR07GEfJOOYkVKWQcWCbsWhB5ziyy6P0Iw0qXx0xZpJsbP?=
 =?us-ascii?Q?uCHiszG1W+2UnYEx5buQTGge?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0264bf0-279a-402f-d683-08d961cc2276
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:12:43.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfsbMhDbtcNGtQSg+iUtywceBTQXfPF7EqYAt2NZH7dG3strU8+uc1ldijILVZsOFj2OWQSQ0sfIBVFmwgYigA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3090
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add support to build the AMD uncore driver as a module.
This is in order to facilitate development.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
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
---
 arch/x86/events/Kconfig      | 10 ++++++++++
 arch/x86/events/amd/Makefile |  6 +++---
 arch/x86/events/amd/uncore.c | 28 +++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index 39d9ded9e25a..d6cdfe631674 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -34,4 +34,14 @@ config PERF_EVENTS_AMD_POWER
 	  (CPUID Fn8000_0007_EDX[12]) interface to calculate the
 	  average power consumption on Family 15h processors.
 
+config PERF_EVENTS_AMD_UNCORE
+	tristate "AMD Uncore performance events"
+	depends on PERF_EVENTS && CPU_SUP_AMD
+	default y
+	help
+	  Include support for AMD uncore performance events for use with
+	  e.g., perf stat -e amd_l3/.../,amd_df/.../.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called 'amd-uncore'.
 endmenu
diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index fe8795a67385..ec45a12deb8b 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CPU_SUP_AMD)		+= core.o uncore.o
+obj-$(CONFIG_CPU_SUP_AMD)		+= core.o ibs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
-obj-$(CONFIG_X86_LOCAL_APIC)		+= ibs.o
+obj-$(CONFIG_PERF_EVENTS_AMD_UNCORE)	+= amd-uncore.o
+amd-uncore-objs				:= uncore.o
 ifdef CONFIG_AMD_IOMMU
 obj-$(CONFIG_CPU_SUP_AMD)		+= iommu.o
 endif
-
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index a01f9f1016d9..0d04414b97d2 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -347,6 +347,7 @@ static struct pmu amd_nb_pmu = {
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+	.module		= THIS_MODULE,
 };
 
 static struct pmu amd_llc_pmu = {
@@ -360,6 +361,7 @@ static struct pmu amd_llc_pmu = {
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+	.module		= THIS_MODULE,
 };
 
 static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
@@ -665,4 +667,28 @@ static int __init amd_uncore_init(void)
 
 	return ret;
 }
-device_initcall(amd_uncore_init);
+
+static void __exit amd_uncore_exit(void)
+{
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE);
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING);
+	cpuhp_remove_state(CPUHP_PERF_X86_AMD_UNCORE_PREP);
+
+	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
+		perf_pmu_unregister(&amd_llc_pmu);
+		free_percpu(amd_uncore_llc);
+		amd_uncore_llc = NULL;
+	}
+
+	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB)) {
+		perf_pmu_unregister(&amd_nb_pmu);
+		free_percpu(amd_uncore_nb);
+		amd_uncore_nb = NULL;
+	}
+}
+
+module_init(amd_uncore_init);
+module_exit(amd_uncore_exit);
+
+MODULE_DESCRIPTION("AMD Uncore Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.31.1

