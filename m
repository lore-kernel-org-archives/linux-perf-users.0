Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138315B0F4;
	Mon, 16 Sep 2024 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505358; cv=fail; b=msIlOrqrQJeJbzU0yuJJeFEmGZwmQiI9fZWeIyZU6tzex2Ep1ggwkAx3o35vrUWE4LXdW1ekbFtO13Pl//phiLPbN0Ah6GuDSDRxxBAEASN3wNSnW4mDieBVeyVrWaDR51i0kA245vM3AFZNYfjiEOIb7B+BDmjI5AnWPN+KcTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505358; c=relaxed/simple;
	bh=CQ0IfzsbVx1/yKQCqXkTv6nH1ZJOZw92LQlMezJO0Bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loafDnfBPoCSHVwBFGiATGAUYDswZCJzY8SseHkwvGrj4x16Qlt6LTdOqWHsubSpgaLF1sQ6KWQGlPanZkWguhZbkcGYyc5ygOG9KqRnB1pfkCemMm7oTmhydHw0DtA3O3tOC10zYEAmjpRbg+ZPU5fLYxMdZe+zsA09ddd7T4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bSAbUvpD; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bSAbUvpD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZ2I3VArEkoieA+7vZnnzaxtjQETUZfUb6GQeZkpFY9UA/J4w3Jwzxm094Y8Gz46eHVeZ5fNdIM3n0qy2RQKmrv2R+crpcLxoCxtzaa5um94KnZ7a187R0/qt8y1MKfG0VH73Qs7TEuCVyYAJRzKzmba6aXgyWQ+EwQInuhLqd/JaRNAHo75XVSCjDYOXcdFt9IRX81aIg+DEaysgIOoerYtpilRGYeAsomnu7LsIKmNdYZT3cXKkibIuz9oAFKuTCnpsedY3GPC3p26RDYjNLABrlkP5ioY74EVEYMtLpHwQPzJ3LkJQuBb1EpzIUKhJtssxEAZHbnX+y0PEHTd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KLT1LS7u5Qo7XF6fUdLNTSLZj1eEKAV1XTMTB2yP/4=;
 b=pFg520lOO+KlyMRHi8QYfcGV7YJ4V867Zfy8Y38zwVSo7d+zUjUk++lwytQQ1eFmeDUPRE6lB4lbZcFXqd+zs+QLx20WXymm/78bP21aplWmjD2TOIC0WX7Q2+5+f8x4uFYedLRkHl+DQTYhsyjUu8olOJHbkBl1JdMpGS3mHCX/VybaWhYADW2EEhWgPZpHcsPttwasYdICJwkdUvGKU+lK2QQcpCiEVECjJBPFrl32RUhDAjylbQxiovlhg1vwZIY6H3Ege5TczobYWRCiUJ4GaaaOL4/nrJrkSGV64ueAF0xtaY+9NqzZ7wZxZTct4mgMRJY8sEvfsCExum5OiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KLT1LS7u5Qo7XF6fUdLNTSLZj1eEKAV1XTMTB2yP/4=;
 b=bSAbUvpDXiLrS7dBPIqRaygxNoXPwv4Zu6/sz8KVs9jUVUjVrGYtfCOJb/3698TNFFypWVPRPnzN4EsZzlRfYZ6g5UJr+NTN+3cHqpXCaes6cdrxQFadZEdXTmFVZro1wSzW6tAVWyyVkAHqHVrsednvfEgeLWVTc9oftSqgFJo=
Received: from SJ0PR13CA0209.namprd13.prod.outlook.com (2603:10b6:a03:2c3::34)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:49:12 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::ae) by SJ0PR13CA0209.outlook.office365.com
 (2603:10b6:a03:2c3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 16:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:49:11 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:48:59 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<bristot@redhat.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 1/5] sched/stats: Print domain name in /proc/schedstat
Date: Mon, 16 Sep 2024 16:47:18 +0000
Message-ID: <20240916164722.1838-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916164722.1838-1-ravi.bangoria@amd.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: aabee691-7324-4ac4-06cb-08dcd66f7db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sGLkMhXVp6RJ4E0MQSDS6M3d/z4PSdPOSCis7wI3B7NHOmReqRWqFX4XCaF2?=
 =?us-ascii?Q?xPnTTw9OcjMy6eBQZKCwbWt4zs+VLd1q74q7ByCzVttFaNkcZ1MI/2yAikaJ?=
 =?us-ascii?Q?DI8IF32kXFWxeID/fws3Z9U5zn2UO9ZjTAC3EOVoXl+Dvd+4eLtRnfYxnAGX?=
 =?us-ascii?Q?1I2rZ8HkyWkmdCkrJ476n+xtVobjr/UojAhycqWAcGgM7QcmYNpFdGLsAQBK?=
 =?us-ascii?Q?oGooPELQPnNrC7/RUv9RZZfp+tII6i1z3iVfwBilX9I8H1/kk4ZvMe+jPziE?=
 =?us-ascii?Q?XE015JV2j0Pn+jEgxgxsE6T0WroLaMD2s8WjROAYjUHidWjANfxTV2FeU99Q?=
 =?us-ascii?Q?z7uwbhGF99CrsHFUq+E0+Pzdu1HhOssrxyaktP874qrEkSEnKI9SQ+CzUXxi?=
 =?us-ascii?Q?5yavSpbEEhKjb+kKj8hOH5VJ5cuJrNnoPjCQ56YeHlTxTADAXclilB1AVCE2?=
 =?us-ascii?Q?7FtfnMeUloBudQcCItIjup3R0YhoGTn8osdz3KsaLt7lCwKdJq54OMuhavhG?=
 =?us-ascii?Q?iuzYatFfEo+5G3GzkYM45dIUCEqT0v+D0enYoP6GnMkqLSOF396HURF/Q7d3?=
 =?us-ascii?Q?vidS60jA9JQnQpX8NWUOru+XyJOxXblevQ/78TQ5SgZC1/Q1oaTNE5UV7yEU?=
 =?us-ascii?Q?vmflybLgb6p7YkKhzOA1o4qAh1/akexsgtJZEl2Dz5sjC3gnXyMXRc2/+kGm?=
 =?us-ascii?Q?c7uAFk6CzkpXycFdonVOs5M3gl7Dcz0dhM5IgGlqayKKv3Ssf6UfAQxjiDoB?=
 =?us-ascii?Q?+B/9b8u9bATU+DUJAgno9uJbrcRA3z8pWsHdnJDOWldKtKritKdt2xo0UMpk?=
 =?us-ascii?Q?RS+nmw45LZF37Z6EAvBhHI5lb84CUQMKlxzIsuy2RLjrtr5E5cKaZthlBoDh?=
 =?us-ascii?Q?159XTDKr6n/OQYNNo0Ygi4Vjp3EEwO2sxHUd1mjzhwgvYhKsH2yH03UX5ryz?=
 =?us-ascii?Q?gKmU9uJwGgSBth8hg0YV+vNj4OJdqEgm3xFZpMVW0wt/2twrgewpoV4aNpoQ?=
 =?us-ascii?Q?1eKX+cYP5uEmxYTcSqrNONlXVus2o/jjFrEh9blmcZGIwGqpnRrXiFs00Dj4?=
 =?us-ascii?Q?40g//2sqPNa3RKeBd/qwQ0i8+65nDpntz6BjaDrVgid6R735uaGzq8Yz0DWr?=
 =?us-ascii?Q?XF7aSUhdON9QLju9pWmKY5TcMe7jzVYtt7CKabUbMu/bYXPvAVB6yFG94TmL?=
 =?us-ascii?Q?ijuuYPTrlYKkAOqmcM/D4CalIF9Fa0MlRA0mbs/aX5p+5SwtMqQPybAJl+F5?=
 =?us-ascii?Q?LDPTJyDKfGxsbs018QuBkydSPfwKL/oISwEbgpwM384yxfPt4KDwtFa5cdhW?=
 =?us-ascii?Q?SChN0ZTj9D5p87S6IbOw2UL+IY8nlf2xs8rqemeTSwRtA5JdzXu8aa+VC/mq?=
 =?us-ascii?Q?IprWaaRa1T4Cey0beR6uvaGbAPuwyQ5n3xE7WUELK25KUrOQBQN3d0DDTSTQ?=
 =?us-ascii?Q?jduLfiqa8AkneDi2pSIxMsUnVHDD9HPf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:49:11.6960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aabee691-7324-4ac4-06cb-08dcd66f7db3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321

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
2.46.0

