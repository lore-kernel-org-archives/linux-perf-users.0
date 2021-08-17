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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BD5C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FE360EB5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhHQWQP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:16:15 -0400
Received: from mail-dm6nam12on2058.outbound.protection.outlook.com ([40.107.243.58]:53857
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229869AbhHQWQO (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:16:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZgl6a9cywuxK/ryzXstikf1WQSRfBHfvbdbtkaMo8dUSUPCZ4Df0Hw3icSHugV/qp/dMKgdnQTARFQR0XVd3LHU5MRp5d21rsPvCIv9asFFLS0NGvO/k2PGqNK8IGWeq3mAyMsqo4Op+CHbf+uNA3n6stiOwJSlC8Qq2xPqMbFztJAMwWoO4KH+5RPxYJtym4i70GgAhQblfV51GtZBXZ/XDgwWZ88QOKi0vp32Eb6iMzl2Le6PNbwrHGtdZYOUxoHNMf+6E4iu5cVhfCwTsov0+Ke3nOh2sfEVcajuG9zoGzF/+3i2ZWifORWGC4/niLpRuIdK+aEcJCrMY2+dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59xkcZNH3wtfwNhMyLL+nrUz9fw7afm8FXtxoFhO2Ew=;
 b=TJMlcU1BKzE4VlOr5LboIRtpMZ13GvFMMtTUyTepzx8ERKmO9UNr0suWheVjsd8Hx+ib9OdGCgh+aTg7ezPY37viCFCnhupCfFWVpol8/XO7uZFRQ2zCoeClnTAUaWkp66EuSM2vYf1YNDWzqcevmn50Kwg/dqfxaifhdWskKurY15aDDcrSL+bh7E1jneCCQk7TB83lJ0HgS7102xiL+sRbNs4kHJpZUdQQPPErzeGSgPcJruxAsjLfvrmLH04MoVK6KvV5QtfJokulL3LCQV12vmmbuSXhNHDtayZ89dYowcce7m0keHEclNo8eUAS6E6l5EaS1p4JMubVufdGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59xkcZNH3wtfwNhMyLL+nrUz9fw7afm8FXtxoFhO2Ew=;
 b=iLgcqkTd97WK+CTok5KuK7L80/5snLiMzh/DRijxLf0XjL0FUXzdMa0jkTDuS8w+F/LXqtsamSv3MzwUq4vsHRBM8Z4dWKnTUxtZXMk+6yNM8BBrJJv89POsP4exHghlmpdETowwP3XddpOHyW8lN+/Pl5Qz6+c73MoKQ/ptBBA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3090.namprd12.prod.outlook.com (2603:10b6:408:67::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 22:15:39 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:15:39 +0000
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
Subject: [PATCH 1/3] perf env: Add perf_env__cpuid, perf_env__{nr_}pmu_mappings
Date:   Tue, 17 Aug 2021 17:15:07 -0500
Message-Id: <20210817221509.88391-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817221509.88391-1-kim.phillips@amd.com>
References: <20210817221509.88391-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SA0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:130::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 22:15:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceb8e734-9969-4b27-474e-08d961cc8b4c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB309065AF6B3CE22FA3E20A2287FE9@BN8PR12MB3090.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lx+70taGuz8NFEh2Wl+G+sFkvTRuy5tiikrbQu4aOXjavXPjcQ0JiCh1u44SWHu0uWDOiTezm7W328L9p+cJfqLZvsoDdy48UyjsryC1DRP5GJk69Lk/Vnehnb/tkGjwxMGdb/lsh2SmDgo+Ly07d6s2qjm6en59uajt83uG5rWbfzza6zN/KQchcsSGBzaYtKios3u189C4rfUkakdlhf22ajGd/qgwJIPDTeWSS52T+rezeQjH+LXaTOjccw9BtIWy+wXraV6IUXMnjiP770BQ8iwe9OT9twqSofyoWMHqnXhBDWTZ9TMS0FJhjfvD4M9LHYHdi2qGYy83xxJVi56n3V6D9vzXI/vGyikM7dU/pxWf9Rh2tZ4ECuBbpMIEwmtRX3TNNDwMhtTkdQiF16FeW4U5lKHJyTUNdzjSrmTVIEkpJP6Ih+3ZNoPZzg8GTZTMaxqTrUfNhV5WL0kdSlZlDwR7vC/3SwuWhmKIM4SFM7w1FmzBxqrGwqQ4pr0diepURDMsW+NmBTClZqChW+ZzcN8w0TU7CGGiWdbDjzbXksX6Ml1HKEXD9tzY/qqySXF0lSV+bQFVXFP+egR7Y0rLDL8f3qCW4Q87SH1IagXXf/qild7zgAcpoyHRL0MTdh03KqcTafLnlaYgXlW7X4vptw4TeOeSQRUN1cyUADy4cYGAfO9VOcQAVMwcynxqQG33G8Q1H7tmw8f7dnepvgy3RYMSt20i+OKKqQ/xJ/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(38100700002)(38350700002)(44832011)(4326008)(186003)(1076003)(26005)(2906002)(54906003)(7416002)(66946007)(66476007)(66556008)(86362001)(2616005)(956004)(6486002)(8676002)(316002)(83380400001)(5660300002)(8936002)(36756003)(7696005)(52116002)(508600001)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r5DorZ0W8oD9cii6AvSNulYUztfcxntMkXQWAF8MYqgPIcoCmEv0DBXnQ/8y?=
 =?us-ascii?Q?6giaxW1X7PfrVryk6TdvXym8AKPIAVEWzrAra2OTMPcLTZ3UtjHog4xjRQYr?=
 =?us-ascii?Q?CNw8DvpYfu6VrN7clvw8LMNt90ptdoSdW1KcP37BXXj5SB96r0FCRyUpFVOo?=
 =?us-ascii?Q?YGDAu60PpMuVw3ONzR1wYqNuTsW1NawHHprqjdUvKwB3Hy4EZe3X1aMRWsln?=
 =?us-ascii?Q?p6OwJMyTmlMAgmiQoa2za8ApJoll1Sev426Y6aoNAQ0vuMRgZOISylef3f4d?=
 =?us-ascii?Q?kUm8dNT3lGP97fWLfROTRMgmpMEJe6g164Ae7pc6tavQ6EAii+upv5j/OEv3?=
 =?us-ascii?Q?3Nj0dO+znZD9BB5Wj0n2kIAeOPo3ZY6GyGMyuj6vEG2EP+ozHL8c7rjJ7/Ir?=
 =?us-ascii?Q?ao6b4/NK0QS7mQ0ft25Wgsj2uVVWhN7aDio6BCANDofWxwZrcqZpTaDBjkfR?=
 =?us-ascii?Q?tNzBmK29aSPWGeVSGxEKOjxRVumkvh2wCwi0JOobefN+Pruv0K4Wqeoyv8oR?=
 =?us-ascii?Q?Gw8Z/5L0D9OmkCH3LT3DeSt+fmNBRp5ZScnF94/qrNlD/qrsCdE7aSq9WrXI?=
 =?us-ascii?Q?d/vWLpFAD08JymCxXf0ehJlitNrHXx13EpxvXjaIEPNeYmFE26zfWA2gJurc?=
 =?us-ascii?Q?pfFa9r+oGNGoT5MRihqfXasJeuRA+CddP0IC/6ChDE3P5d4DZvaC0HAiTgjh?=
 =?us-ascii?Q?7+lvATt6OdKFndwuW0fArEAokL8peUbkDKpodPPRiO9r4oxLmfZ6tKAZbwvS?=
 =?us-ascii?Q?BGKWIk4JCqvSDEyGkH5XB7xP9jpAhDo5XZk0VGT4he6QVIB+jHjedlC53dCn?=
 =?us-ascii?Q?AoNDjyo9DhPsXKoEzkclo6U/trjuLzWxRc3FUEdIo3E0OLC+QLw16zATps39?=
 =?us-ascii?Q?MjmXIDKtGHTqSh4Uxpv1YO9n7v1g4+YhOXKckhbJrfULNaJelNKL4jDXJbMM?=
 =?us-ascii?Q?AzDX4NS6r7XqKJjBFvpxEl1ONoL/jbntFGVzL5jR/gl9lSLgZObrHUSI8Xi0?=
 =?us-ascii?Q?tdAmUBbOYv9g/f30FsUiYKzxCNIz4nJxa9oKjMnJRWDy0okFPF54iffgjvVk?=
 =?us-ascii?Q?zKGODt300rMiGun3rzMaJzSUzo5nNK/GsbFqeSxQe8v7SrXGICd/lux1GSpW?=
 =?us-ascii?Q?s7HEZaFKL0jtXiSnUPCjqL0lSHd91J+P4cZqNMcKYQ4uWj7j7Rse/LlcugAJ?=
 =?us-ascii?Q?XupQd2BnLb5i57DU42PtNjDRfOqrxvu0m+SY3udQu19w8A6bQzLKcTqO6h4J?=
 =?us-ascii?Q?yCUtIsQuo6X9MQCUB1XgQ34Zolts8UZPRDEs1M2dZiGYo1/6OXx9b8U/do6K?=
 =?us-ascii?Q?3Pvbm+Yxspadc5yk8Xbv3dax?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb8e734-9969-4b27-474e-08d961cc8b4c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:15:38.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mI5Rb3vyISoNiL1ySTvPAl60rz456kFEIMNNog+XqVP1BPQ7E/tMFNOZsDA4lCelyKK3eOuWLHVK6ikZZFNlxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3090
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

To be used by IBS raw data display: It needs the recorder's cpuid in
order to determine which errata workarounds to apply to the data, and
the pmu_mappings are needed in order to figure out which PMU sample
type is IBS Fetch vs. IBS Op.  When not available from perf.data,
we assume local operation, and retrieve cpuid and pmu mappings
directly from the running system.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
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
 tools/perf/util/env.c | 78 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h |  5 +++
 2 files changed, 83 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 8f7ff0035c41..cf773f0dec38 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -10,6 +10,7 @@
 #include <sys/utsname.h>
 #include <stdlib.h>
 #include <string.h>
+#include "strbuf.h"
 
 struct perf_env perf_env;
 
@@ -306,6 +307,45 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 	return 0;
 }
 
+int perf_env__read_pmu_mappings(struct perf_env *env)
+{
+	struct perf_pmu *pmu = NULL;
+	u32 pmu_num = 0;
+	struct strbuf sb;
+
+	while ((pmu = perf_pmu__scan(pmu))) {
+		if (!pmu->name)
+			continue;
+		pmu_num++;
+	}
+	if (!pmu_num) {
+		pr_debug("pmu mappings not available\n");
+		return -ENOENT;
+	}
+	env->nr_pmu_mappings = pmu_num;
+
+	if (strbuf_init(&sb, 128 * pmu_num) < 0)
+		return -ENOMEM;
+
+	while ((pmu = perf_pmu__scan(pmu))) {
+		if (!pmu->name)
+			continue;
+		if (strbuf_addf(&sb, "%u:%s", pmu->type, pmu->name) < 0)
+			goto error;
+		/* include a NULL character at the end */
+		if (strbuf_add(&sb, "", 1) < 0)
+			goto error;
+	}
+
+	env->pmu_mappings = strbuf_detach(&sb, NULL);
+
+	return 0;
+
+error:
+	strbuf_release(&sb);
+	return -1;
+}
+
 int perf_env__read_cpuid(struct perf_env *env)
 {
 	char cpuid[128];
@@ -404,6 +444,44 @@ const char *perf_env__arch(struct perf_env *env)
 	return normalize_arch(arch_name);
 }
 
+const char *perf_env__cpuid(struct perf_env *env)
+{
+	int status;
+
+	if (!env || !env->cpuid) { /* Assume local operation */
+		status = perf_env__read_cpuid(env);
+		if (status)
+			return NULL;
+	}
+
+	return env->cpuid;
+}
+
+int perf_env__nr_pmu_mappings(struct perf_env *env)
+{
+	int status;
+
+	if (!env || !env->nr_pmu_mappings) { /* Assume local operation */
+		status = perf_env__read_pmu_mappings(env);
+		if (status)
+			return 0;
+	}
+
+	return env->nr_pmu_mappings;
+}
+
+const char *perf_env__pmu_mappings(struct perf_env *env)
+{
+	int status;
+
+	if (!env || !env->pmu_mappings) { /* Assume local operation */
+		status = perf_env__read_pmu_mappings(env);
+		if (status)
+			return NULL;
+	}
+
+	return env->pmu_mappings;
+}
 
 int perf_env__numa_node(struct perf_env *env, int cpu)
 {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 1f5175820a05..1383876f72b3 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -149,11 +149,16 @@ int perf_env__kernel_is_64_bit(struct perf_env *env);
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
 int perf_env__read_cpuid(struct perf_env *env);
+int perf_env__read_pmu_mappings(struct perf_env *env);
+int perf_env__nr_pmu_mappings(struct perf_env *env);
+const char *perf_env__pmu_mappings(struct perf_env *env);
+
 int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
 const char *perf_env__arch(struct perf_env *env);
+const char *perf_env__cpuid(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
-- 
2.31.1

