Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1990B18B47B;
	Fri, 22 Nov 2024 08:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265166; cv=fail; b=bG2sFJzy4G5RwDLNCy6Ad1fV/7f6X3Lxh6h6ko4MjZhDfYmpQHMWyN1uaWckl5WtLi55UkFxdFLqg+W54y5S8rq7GXXoCLoV216gnDXFB9SKcKSPz3aeLUY0E2deqidUwgyh0KI3HT/yxa9V3oIjBy9EKghdaXvbCBKecaNXOto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265166; c=relaxed/simple;
	bh=P1nWv8z/IOls01vQg/NC6fLMvX7VZStc7AFmDwKJHEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u058wQPzfUCbhLpqseAhz6/YdbywfPzHTbXT1Nmmc4OtcPW2fJcYoz95Iu/gdta2Dq18zmCVEvLN0016p9w/sHsBy9+gLUduGJxnJl26DP3JlzYSQKm1ZWNDFlL7GGHI/UmP+Zf9p724vA0BQvnP59AtLKdrOAEPdDCK0admF4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bgZIEpDF; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bgZIEpDF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiScKEo4Y0SDitcnjZdVcNgmMcfC87m6U7XeOGGlyGDGxzUPRxevaGyvuOYPAMW7kKqy57QHomm5qPth9gN8bUQGjuSzz+d7NefjSg7gBdZlygwjWXi0NbnlLw1iZKBzRxDQRnD3Xt+LNqMfl5P/zkInMMt1N3pFEUmQ6c/4a+nMV2qWm+G7c3LeMNdyFx3LSB5QaEcaXXOf11L86RH3WZuRgzQJjCEMzhA2IiXaQ7jy+JsQJwIACAYlTwJD4/E8yzzgdlKSa6+6eZOKHFTB2mVKcXgdZ0aSq9l5wRd8qgS3mi3JF6tnkHDJjSPpshgAGIV/4DNWJNONM3ogB3yOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/DI0PVVpXpBtH/awXTgRanKvguZmxyb83QDf7ygUuU=;
 b=pe1V682sw1sKBLS2LUL3Ffnxs+REyzDxv+bluXo6fgqbKHfCFHHr3grVay0b4MIL5nv5rnRwkBmwbIFaHhsciSXRwgNcLfp0JpurzjV3BrOsyx8/ZQ4eDkGIfKUK4lOuOpVcvHq1pw0eWSCAKKYPTzlRpOpwv9ZHSKyauu6PX55yhp0KTMdGvwijNJ/gTy0xXRk63jB7iYFMi4XDyMN6f5anllIJteeuZKgVyjtnYdXEtvPoZjX5NAJ9v+ebWkHpbTmHhwDMqO4OEzEa7jvSF0PhwMTOJCGOoWPlIQLsE8Xtq4ywXESWYZzmVk/5zuHYDm5aVu9gmjUhf3QMsBzLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/DI0PVVpXpBtH/awXTgRanKvguZmxyb83QDf7ygUuU=;
 b=bgZIEpDF6Gnpm+KoGvTYfhYNCwPP1s2i9RKOhZhrph/DErODYXwFfnP5SPMkNxvK4kTn9Al+8UHXdqFO8AR6WqjJMh6dRR042ZvkyoKAjnFg17mD03JU0HZYiUErsd6488BX7wqOdW7fNUsLwvPEvJJZ7Df92Gq/WEz+hxMTndI=
Received: from BN9PR03CA0466.namprd03.prod.outlook.com (2603:10b6:408:139::21)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 08:45:56 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:139:cafe::4e) by BN9PR03CA0466.outlook.office365.com
 (2603:10b6:408:139::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend Transport; Fri,
 22 Nov 2024 08:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Fri, 22 Nov 2024 08:45:55 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 02:45:47 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <ravi.bangoria@amd.com>, <yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<vineethr@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
Subject: [PATCH v2 1/6] sched/stats: Print domain name in /proc/schedstat
Date: Fri, 22 Nov 2024 08:44:47 +0000
Message-ID: <20241122084452.1064968-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
References: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b6efe8-4388-43c5-d09e-08dd0ad21453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aVd1jGJ9iGN4AIB0HNJW3wBaF8KCK9yHmJ5eHjKlg8iZwUXbj2ExtM+Vm4HD?=
 =?us-ascii?Q?Et/DG4j8lpPgYtb6V70M5DpBM2Pe8FURL6MttIbNdH5Tbn+4+eP7psWX/9vo?=
 =?us-ascii?Q?ZrWUM2xAXNtjKRM9w/NDkhQ50svw1Is+UajQ7zRos2ozDG/LFgK5OFa8AfQI?=
 =?us-ascii?Q?hlGlkh1TKSVWSI8mgGuCRkcTAlG2gTWShZcHGqlEvEPIctuQSEXBFjgpOlXi?=
 =?us-ascii?Q?7Y1OfShsQs1iijIOaKrwtwp4xT3gwtjPtvH9MdiiQXC20ok83cE06WZpSC1X?=
 =?us-ascii?Q?Vlndtnc3K87l6ujnKtJ/OocU6j8Gf4kM9qJdTtyvjK3uqfXIjQhEXo0JE076?=
 =?us-ascii?Q?xNsABEIge13Xk4kjUAVU+grPcQ98bRZ50Z6cauJXk5PjmCQdb/g99xUJ4TAB?=
 =?us-ascii?Q?k+3C7SG8llppkfDZO4CBILJOKWVj3r6O828E6LV5jhB0m2IcVFGOHG+8C+PJ?=
 =?us-ascii?Q?6cekDuqgj3FL+I0UZ21WnKhdxtSq2S7yEKxn4/YvRKwahRmovEbY2rP+ISkm?=
 =?us-ascii?Q?ziNc+N2S5cHcYEgDB9h5dPJHtHHyww8DUVYCqahGrj5ODdNFVLQtnRvrDyK2?=
 =?us-ascii?Q?asImIwKUph7LjhRgBYV9V40ar4tmCg+Gy+maRfVMPzCK9QyDOmPdk8II7ldz?=
 =?us-ascii?Q?G0QZV/sVgYRgQHUyMh8XRRPv5JabMU49PuKYqMqJ1gcr4sfFIfVCSQnQGfkW?=
 =?us-ascii?Q?pJILLM7pahIyRahueI/GM/8dbog+BkAv0ARz/rp5bWbPSgTTvPSizr42fnoU?=
 =?us-ascii?Q?w4FYW1hUHGeXs0SD1928tOESfJj9d+g2y05SOkQkRZ0FpR4yLa1TilbFZqYI?=
 =?us-ascii?Q?B+a4G20nWOmZfH0htThSz0SS3vFj216+WriYhyWNiTnqdesn0CqQqvlCNpmo?=
 =?us-ascii?Q?mOixlEA/pIDserdV6zDucR1BEYkhYQvmyYv9a/+X/OQ33SZzXOX2aVipF6WR?=
 =?us-ascii?Q?xquEroJCtXz5gtFVQU3A33/fFsEjx7wb3qY4UEscU6D6DvynoqDO2E3UjXPx?=
 =?us-ascii?Q?nC/kCiUB1yQ/i3MoOJa31TL+bOOcZxspYn+gup/7ZI+rwSg3LO+XVx4mDjSi?=
 =?us-ascii?Q?JqLMnziur3d0Q1iS2Tc9h+loSkN6oSz5RPZQhKwdSwCbUHH8PL7O3ja/xkNR?=
 =?us-ascii?Q?4olxUQJ73nIc8mm0jgJ32h7zrXCRPXGvdL2iIJ1dQcNzdj5BlhvNylz+FbFN?=
 =?us-ascii?Q?zcdDaAIEPET03t7fl4yGkOAHb97X4gXhS0IU3ZkPheDp0csSP18yi9yeFiLa?=
 =?us-ascii?Q?a0fH3XEvajG4uahbj/CJs2THUk1roPArxQPxuigPPE7fEnfW7nXNgZySFACD?=
 =?us-ascii?Q?l32wqFX6LPAIyQA9JRDp9+Xltzfe9H7rQgps9HDq4vHtYzfzRXIUYxGRFX5J?=
 =?us-ascii?Q?cfbn+awnwu9WsxZyWCov7IC68SGLBQCttNoGjr91RigQ/UlCpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 08:45:55.6144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b6efe8-4388-43c5-d09e-08dd0ad21453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166

From: K Prateek Nayak <kprateek.nayak@amd.com>

Currently, there does not exist a straightforward way to extract the
names of the sched domains and match them to the per-cpu domain entry in
/proc/schedstat other than looking at the debugfs files which are only
visible after enabling "verbose" debug after commit 34320745dfc9
("sched/debug: Put sched/domains files under the verbose flag")

Since tools like `perf sched schedstat` require displaying per-domain
information in user friendly manner, display the names of sched domain,
alongside their level in /proc/schedstat if CONFIG_SCHED_DEBUG is enabled.

Domain names also makes the /proc/schedstat data unambiguous when some
of the cpus are offline. For example, on a 128 cpus AMD Zen3 machine
where CPU0 and CPU64 are SMT siblings and CPU64 is offline:

Before:
    cpu0 ...
    domain0 ...
    domain1 ...
    cpu1 ...
    domain0 ...
    domain1 ...
    domain2 ...

After:
    cpu0 ...
    domain0:MC ...
    domain1:PKG ...
    cpu1 ...
    domain0:SMT ...
    domain1:MC ...
    domain2:PKG ...

schedstat version has not been updated since this change merely adds
additional information to the domain name field and does not add a new
field altogether.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: James Clark <james.clark@linaro.org>
---
 Documentation/scheduler/sched-stats.rst | 8 ++++++--
 kernel/sched/stats.c                    | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index 7c2b16c4729d..b60a3e7bc108 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -6,6 +6,8 @@ Version 16 of schedstats changed the order of definitions within
 'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
 columns in show_schedstat(). In particular the position of CPU_IDLE
 and __CPU_NOT_IDLE changed places. The size of the array is unchanged.
+With CONFIG_SCHED_DEBUG enabled, the domain field can also print the
+name of the corresponding sched domain.
 
 Version 15 of schedstats dropped counters for some sched_yield:
 yld_exp_empty, yld_act_empty and yld_both_empty. Otherwise, it is
@@ -71,9 +73,11 @@ Domain statistics
 -----------------
 One of these is produced per domain for each cpu described. (Note that if
 CONFIG_SMP is not defined, *no* domains are utilized and these lines
-will not appear in the output.)
+will not appear in the output. [:<name>] is an optional extension to the domain
+field that prints the name of the corresponding sched domain. It can appear in
+schedstat version 16 and above, and requires CONFIG_SCHED_DEBUG.)
 
-domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
+domain<N>[:<name>] <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
 
 The first field is a bit mask indicating what cpus this domain operates over.
 
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index eb0cdcd4d921..bd4ed737e894 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -138,7 +138,11 @@ static int show_schedstat(struct seq_file *seq, void *v)
 		for_each_domain(cpu, sd) {
 			enum cpu_idle_type itype;
 
-			seq_printf(seq, "domain%d %*pb", dcount++,
+			seq_printf(seq, "domain%d", dcount++);
+#ifdef CONFIG_SCHED_DEBUG
+			seq_printf(seq, ":%s", sd->name);
+#endif
+			seq_printf(seq, " %*pb",
 				   cpumask_pr_args(sched_domain_span(sd)));
 			for (itype = 0; itype < CPU_MAX_IDLE_TYPES; itype++) {
 				seq_printf(seq, " %u %u %u %u %u %u %u %u",
-- 
2.43.0

