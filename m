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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E32C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1907860720
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhHQWNI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:13:08 -0400
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:10208
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235977AbhHQWNF (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:13:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBpAmxeFSbxR7S/E6gcrOa/X4MAV87OeoCeuOPlXNAqGBpyUHvp1oqpm1Q+PaLr2QcKCyNwGJLfcnnLD/eOvR6A3mJqS3EAu4l94zE/KEFb/nWTF7NK2+fda/jRmKD//G+RSv9mk7LEuQykfyV41yYsSf686GodfXAfyAGOeigiL/hqCaFgXYBVz/2eYM6Fz77lLlUTSnGOMeFvkSLpglawzpm0vWse+b2orVTt98E7++1AbZ0dgfcSVMlCJybbkkqUrQYnMsGyFf4iM1FcEnhyoZePAyCjlZKllKzZf3VUl7wYUBj8c6ujG19OVSVMMdj4JD/py2q+0BcCOwVTBCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmdGgHvgEKpRao2AUrwAwpK26Gn8LJ/44BaqiuhNrew=;
 b=RatQgCGPTunF2+fs9WfXLE/wh1uCjKHtm6fUCuGfqMzwNcDxLnWRFT45RSAwLwViybH703x9JAWYjhUZT8ZCODY3DqT884frnwoPekMj4RLS2ybJoO51kePpyA6WxYGj9eWr7qik7PLvXoSC1SG4Q0vAzL+czDJchmhpjAmN5wWc0S7rz1PMxv/CU7uEEymMPOHO0BvZksZowAegO3y/DA/Faxudic26nlzSgcyrZR1nyTmYoeK1aH8a3eDAlww36+pehpfp4OB5qLYQF7EIfd4XGOcsGzWnHglg9Rk8ssF3DSNXvJKdBv3NqMP54D0ceLWM7GoqzVP+r0AsjoYUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmdGgHvgEKpRao2AUrwAwpK26Gn8LJ/44BaqiuhNrew=;
 b=Wj5SdZqzh1zXU+JbJHOsgNjZY12vkAHiKUtk4gVDTNtpI1JinsZvcEUqKLaoD+qbsTqB6K5TqcZ0l6cgx4YK/fA+B0WzzMpgYtSnFC8aU0LP077o5P5vwSzyAxYm2xsGnEc+RDwMflgQjHceTFv1MyCDni27AhHgFOQpV7UJxAs=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB4977.namprd12.prod.outlook.com (2603:10b6:408:a4::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 22:12:30 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:12:30 +0000
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
Subject: [PATCH 6/8] x86/cpu: Add helper function get_llc_id
Date:   Tue, 17 Aug 2021 17:10:46 -0500
Message-Id: <20210817221048.88063-7-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817221048.88063-1-kim.phillips@amd.com>
References: <20210817221048.88063-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:806:d3::23) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SA0PR11CA0018.namprd11.prod.outlook.com (2603:10b6:806:d3::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 22:12:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db8ae6d0-1deb-400f-8f22-08d961cc1aac
X-MS-TrafficTypeDiagnostic: BN8PR12MB4977:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB4977EF2689FFFFE5D6F4182B87FE9@BN8PR12MB4977.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enkrqqbS7FWbgEqkCMM42fbDAViIRdx2nfL0YzT6lpvvuROERR2C1tUw59lnh0N1Tcaj7/BZD3DEyCS/Vco9BodGEgIsPyx/39NIO1GrQPbcxkIcFrtR5V34fw2uLN08eufu4DAuCZHSb+JwCywrNyqKFnzpk3oYgiv0ZC+DUTZMab+m9UfhAGWxi6fL3yJGNkM3JmsMcbB5ZQYuAHXgFvPd+2DFbkpipDKBiCHKhFdPpXNrZk8RzcxmEEBddZn1o8yiCVvxYYDs68eaBM2uZnRsnPsg4s7aeuaGRQaeeGOxXSh7aV2SJZLFdqHuELe3QPtEWXTAj44pzBMXU4oUgbNqvqVUHn1tmlHyh5MyaMju5IdkAEnvg1M9KaZKo1UelJpWr39QeMFFYZW/fucv17uc9/mJGXYrCCT56sJ7cRKEGSrfWxhcC9K8Gz2am271CgEiXD0czqacdMvD1lLKI7LjDQAqtykbGPry515AWHDvqu/pbUS1V+8SkDMkLB/6Vm9WUyDwayjkimMpS/adn3XP6yho6uFldT2ba/WOqXi79xbkpTiH/XhHtn44PRknA6ehegAfLrd+7IcyUKEGr/qDSpUOh0BTIeW4vztIfiUJTZoDVs/CRgEzlYYLIGKKDf5VJzKkGu1r9/Ur6nwyowQqJHB38nwlATG/bmkYjVs7jx1m6A1iLeaJyXxAiC0BxhB5u3Oikd3jqwhNcli4qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(1076003)(26005)(54906003)(44832011)(478600001)(7416002)(110136005)(66556008)(66476007)(86362001)(2616005)(2906002)(316002)(83380400001)(7696005)(4326008)(66946007)(7049001)(8936002)(38350700002)(5660300002)(186003)(956004)(36756003)(52116002)(6666004)(38100700002)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tg3QuUbopF6lZCQ8wpG9+wehSJ3YBz72qgVEmgi2TuVJXdBxwBhiTOrsYkde?=
 =?us-ascii?Q?nKyy8aR75k5gymbYgUCVAU9UhmBooDDmqqywYs3X27oBjpdD7PL7mXHieKLN?=
 =?us-ascii?Q?cnavF//P12Rk6kQXTYQGTsyNO8IY9HaLQK/65zma50mrLeEttofsi1U7k+k1?=
 =?us-ascii?Q?DVKfRkyl+1F1Z9zshBC9pO3QY4vHZFnujPgx6SGOrG2I+ABEwZRGtGDtNJr/?=
 =?us-ascii?Q?INhvl6ONivpTtym4aX3CHmbzfnGycr2tFnBM9Y5BpDMB2w7KqcTrp5cVRaCw?=
 =?us-ascii?Q?9OWp/BYqF7Ab9eSj9cjmRa7cuCkKSs1NHGUK8k+Qa/3s05aKuhDBGQB+6Dxv?=
 =?us-ascii?Q?gA7gjRiDhCa8Q/DqdkdI6wLFm6fWm9Lxok/RRT0zZQKUhHuEZ9zjKZ4pIKTp?=
 =?us-ascii?Q?nhyU9lkv2wwLlYIMmIocOpkua0rqcEezQE21j0JUsm2E9MEuBSr7NXZ81eOJ?=
 =?us-ascii?Q?5lhGpZNdciubLQykHp9xfAApQvfvGwPLrQE/r5KON/Eowc8sFJsRsrciTtlC?=
 =?us-ascii?Q?rsZP8cxkb3+27CsxO9LBcWtfTlw4TTx3lnmpMmMee/QVZjgq3IYPD87yxNzJ?=
 =?us-ascii?Q?oPFFIPQaw+WQt/aN/QyaJYGY8fKTi5bT7+l3yAu7+hl4euMrrmjy4qK3iAkN?=
 =?us-ascii?Q?ORI/IDX9pGTC9JbMOhv5TmlWnHveMSI+3mYLrQQJkwCb5VnK4BpChE0+KNKZ?=
 =?us-ascii?Q?D+X2+bMx8da+bABct5PHkqZhxUz6mBPNEDGv/5Pn2zgxALqXhqekCIGt2Ctu?=
 =?us-ascii?Q?BdWwN2BaQCvleKNgqR7M7B7HqIP8XVBKpGaZ7sh6u8NDjjFfdc4yhlPtL+yL?=
 =?us-ascii?Q?H/MFBMq/uoaUwAhFrAAfloLiBEvbQPY+xRKXyTEIk7sonOOqQmx/T2Al2xH6?=
 =?us-ascii?Q?TNypLSbJWzKt2T/KGwbk5UzPx/L9QckVgnjK0T7N+EnT30qv3j67MQ1yKeFS?=
 =?us-ascii?Q?etca/lQ22fyUIC3VLJ7/0S5Rs9kG2AIdUy2A72raShEdMBjd0FYfpvc7i2hP?=
 =?us-ascii?Q?zmxhHy1tJZ/3x6P//pF+KUvVyiyR8Y3Mryzq+yyJqZcYR0+Mpe6bjKD9yj8e?=
 =?us-ascii?Q?aeICH7lt2EG99FKnR4wIW/QXVxXH0OTPXL0BuN2Yu6fmsK/FZgRzX3QJ535h?=
 =?us-ascii?Q?jtGW5fPs41hHI11EINF36Bt5UsHbL8XNkJoCSheuQIhWo3iLspPJsJ1JPV3Y?=
 =?us-ascii?Q?ne6bmOQLZrCO02UXXfN8LR0tGAcYQUj9k3tKnp8YMXzKLcMP0aC5p1Niw7+U?=
 =?us-ascii?Q?27qrpF5SUYTgLP4shPElVCqlNGUWbV9NeINJsEUs5weWPUqOaFC4HY21dSpW?=
 =?us-ascii?Q?qQ/doiWY0IA0XePhcHaqxYI5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8ae6d0-1deb-400f-8f22-08d961cc1aac
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:12:30.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LE3eMWfbXKD3asC0IHc/8Y5Q5CjJNsud6v7H9w8Y/jpxiBwMjCGyubraEXajqxbFOo4mL1sbK7CZ0SEFnONZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4977
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Factor out a helper function rather than export cpu_llc_id, which is
needed in order to be able to build the AMD uncore driver as a module.

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
 arch/x86/events/amd/uncore.c     | 2 +-
 arch/x86/include/asm/processor.h | 2 ++
 arch/x86/kernel/cpu/amd.c        | 2 +-
 arch/x86/kernel/cpu/common.c     | 6 ++++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 7fb50ad171e9..a01f9f1016d9 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -452,7 +452,7 @@ static int amd_uncore_cpu_starting(unsigned int cpu)
 
 	if (amd_uncore_llc) {
 		uncore = *per_cpu_ptr(amd_uncore_llc, cpu);
-		uncore->id = per_cpu(cpu_llc_id, cpu);
+		uncore->id = get_llc_id(cpu);
 
 		uncore = amd_uncore_find_online_sibling(uncore, amd_uncore_llc);
 		*per_cpu_ptr(amd_uncore_llc, cpu) = uncore;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 1e0d13c9fda6..9ad2acaaae9b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -797,6 +797,8 @@ extern int set_tsc_mode(unsigned int val);
 
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
+extern u16 get_llc_id(unsigned int cpu);
+
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_nodes_per_socket(void);
 extern u32 amd_get_highest_perf(void);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b7c003013d41..2131af9f2fa2 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -438,7 +438,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 
 	node = numa_cpu_node(cpu);
 	if (node == NUMA_NO_NODE)
-		node = per_cpu(cpu_llc_id, cpu);
+		node = get_llc_id(cpu);
 
 	/*
 	 * On multi-fabric platform (e.g. Numascale NumaChip) a
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 64b805bd6a54..0f8885949e8c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -79,6 +79,12 @@ EXPORT_SYMBOL(smp_num_siblings);
 /* Last level cache ID of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id) = BAD_APICID;
 
+u16 get_llc_id(unsigned int cpu)
+{
+	return per_cpu(cpu_llc_id, cpu);
+}
+EXPORT_SYMBOL_GPL(get_llc_id);
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
-- 
2.31.1

