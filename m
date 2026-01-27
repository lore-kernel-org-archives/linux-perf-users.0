Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB92E7F38;
	Tue, 27 Jan 2026 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539944; cv=fail; b=IhoXg3YNdWo4v25/PM7sWgnG2yO41ZNFcLFInypZzCgHz5SnMAYDeCB+3bRGPfKPT7XxCgHjhmlpRQrJKxW3mKqamzz9AGnp7Zc4j9MTlAFT3P5suEDNhPSMAZHsm4ErlhViU6/UaTL0AW/oLVGzpL6KQ+znoLCXtqt59MXI0kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539944; c=relaxed/simple;
	bh=lDJ+J5q4gcMduQzxpzSMaWnmyt0FWou/3M5e1RkTsLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M88nolDfShPx8tPPE+y5TuznYLb5pSItAL/bfzie7cEd0Haq4+hTvroksLBfh1Qzl3FSQTyrr7p5FRB3SzvA4cvmrkiUdDuSrkRpu+sLBEt3+G/3BLsFSWzxZ1CqDkgbrr1KD9+ZKJOhZoPkzT2ZRSGthZjwJ9wem+9RlXhOS1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F6GpJEZa; arc=fail smtp.client-ip=52.101.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F6GpJEZa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTW4FDIYbGA22DHmMtrYnibtsSEa6rjPrU9oDM1n19LhlnMX9RpcXGEQOGLV2C26vKYiTuKJQU0MNB2knvDKMfLSzYuSSY7E71NqeLRwRqtEkyUqte+bIaen0rnR7buIpkrvGbjK6O2g+yCgIUvvL5H5VohvzwofFrags2LkFSGzO4zRF43x+J/Re3khHt4QC4QFqrBXWQN02d0oe2PquZA8S2My4VytGcnkhvPpsYAH4mcD0eBTXb7cCE6/E4i1ohDnmv0Jglrly/BAXUyEGYHJC67/CPPIsKaS9diHqgd8YXIaGgU/WljxqUTr2amcxFFguT6XTUJ7yO3mHSFFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyUHB4O7RNxENRPA0dSOcCHZ7wT0Sgqjwy98jIvDOKA=;
 b=T4JNNLVkWcuGUgNq5NV7c8mzYLoO2o8re7u5oM6UQl9kggQbxND+4vKUisdmlAKsgnG1AZQ9SrENrkQKv3oTn24mBDxgk1imNa7hEzHprUb1A9f2bybjRqd+lDv5cQPJKJUr7K9sZk98yLmSwefqJ6rowo4b7VuaE8L9HdgvHD1euUzUXcJJPLzd26hP3pNU5tM0BFZdIlyoiH4ICI/Vngp7qDc2iPcq842GD5XQ7VkmIBvlOcnL1o/18R5r6KrlsMYoN4VbP8gAgjRo4ZKSFvC9AREp6WwlRgpuNJWod8GsM+ifNQwSU3bgmn7SAK7GMfxCO5/iStrTz8n1gppwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyUHB4O7RNxENRPA0dSOcCHZ7wT0Sgqjwy98jIvDOKA=;
 b=F6GpJEZaHCHOF0vJVqxkfBaFmWDooZVklfkVkKq8eHh+qO2SUPFcHDpZgLk1+HAbzoanUl5HQWLVXt/z1HNhqk0sC+e0JLJxodZduX2aUm+f6yHE6jIJMveWO4bmQ28O8wWLFWvdre+i7/sqEiIUMgElX4ZIXAiQyJY/CIa8mMM=
Received: from BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29)
 by CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:52:19 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:254:cafe::b5) by BY3PR05CA0024.outlook.office365.com
 (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:52:18 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 12:52:13 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <thomas.falcon@intel.com>,
	<ashelat@redhat.com>, <yu.c.chen@intel.com>, <sshegde@linux.ibm.com>,
	<gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v1 6/6] perf sched stats: Fixes in man page
Date: Tue, 27 Jan 2026 18:50:00 +0000
Message-ID: <20260127185000.431884-7-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127185000.431884-1-swapnil.sapkal@amd.com>
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c32ed4-8209-4216-8b5c-08de5dd53266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tH1DvyiDq6rWTlXxELcQq+ZSP5B3QpZrOlheb0plo50+ZNsE0yYGdb+UaRY6?=
 =?us-ascii?Q?h4xzRNon2+5/ApgNObWylMsh3FVohvUK8ntvPK5mgaa3NS0BnqAL00anynNO?=
 =?us-ascii?Q?wg89fbFhfRg6Qr+UiM42E/3CL2JC1FJbnnsjt51+3oQBDz8vS1nizB1EPC8D?=
 =?us-ascii?Q?FXl3mfUoU6SACXwUQuAQcU+1mnvItUyke1xY4UYg2pE2KNEDn2im3ikKNGP1?=
 =?us-ascii?Q?rwQbZLQ9QWQfNdWEeUZvsCWKwcX39LyoYRbb9KzDCtbNuEbeGPe3cu4HaH3d?=
 =?us-ascii?Q?IawQrXEMZosTkbIE/iAj2dkyw9Ivjs+OUBppqmzaHTxxnES28OT0+3tD4+Th?=
 =?us-ascii?Q?XVD5Vl2BLyoBuK6CC8vSRYnRY7TfV7jW5lgckrAAFs/tX5CrfCDKwhNdlisT?=
 =?us-ascii?Q?Kggp+GQQn5Ro5101HVH1M6NMDQlESjk5Rqb4eBvfZAOXXwaznwypkjtZabd5?=
 =?us-ascii?Q?GihjgTPxfVj+r9VyASnu8GLiA/Hz1KsvJ3NylDVYse47pnfgAnmk4meuu8KD?=
 =?us-ascii?Q?TVBLcHilqEXleVEM4ufhCPIiFNJPB2kKeG+DBVKnGCkdAbOMNtF9M+7WyZzv?=
 =?us-ascii?Q?3//vxqsGn7VDwJOktXApp9+qY/2+JqLwNB7R+iM0p/IKDIJWLJd3EDUMBFU+?=
 =?us-ascii?Q?9FqyElkTCpBdcKbBnSzWNNyy9lVQ+AlRoGkpuFbCpyCbVi1BJpO3qK63C5Oa?=
 =?us-ascii?Q?QhFJi+ugXyR/W+/B3O7crCqW0CSdzJirfKodwLmujQeHNTj4JxN/j7T1re8r?=
 =?us-ascii?Q?OhsfJLDt0hBOotQ1KPdKx39Ixj1PXoEX4PrHLs3MdALGy0K70VitpqnPDq8J?=
 =?us-ascii?Q?64jMHIIGp7C8TH9NtyBx+pphixUvPw/IUHP6LFXEkxwn7zGsQh+QmcKnzZG7?=
 =?us-ascii?Q?VwUTMzraspOPxdmR1jDVKA/4b1gYgu0LC3gcrLs1wvuoBXbYs4pulTXJ+HvY?=
 =?us-ascii?Q?ak9vYA+BIiGM6Avib7RBRMgyd4ysjszJ1SdHKYT8Du2xTFgxbQHhvGhAQ5iD?=
 =?us-ascii?Q?WJyB17A5m32nnpp0dZOzNb0bV7Q8hKBRg6AJVKthA/igigPjGV9fS7HeqI6d?=
 =?us-ascii?Q?XAXYPrOfMVIjlDRRgGPSZy17azMgai+xHNSX9r2tALmSUQuXMslrRJ1E8BKk?=
 =?us-ascii?Q?ofQq/ePaYQY8RICeg1B7Teyy3QrM/LC2B2ilrwzcp/412amvNbzH13bmIk2o?=
 =?us-ascii?Q?kbrDveZb3r7XRHI+E747idPNxlM2fHXvLLxAvgjVL1fhKA5UqTFdgOajdLt9?=
 =?us-ascii?Q?0Lp+DzA9v5puhEg+UDIuw6QgoN+qbflGyieIGVVT6d2czD4p3A020jn11vDx?=
 =?us-ascii?Q?vy2ZqAKvhG+tcrgDpzzT3m8MdiYRnrZjxjmalv3s8pqKNAYtzZAOxPdgtcaA?=
 =?us-ascii?Q?g07mDrAxt+tDQCHHtvKIKU2oGFw1whGVZqec3hkWA2g5+YODBQ07sM+hFGTT?=
 =?us-ascii?Q?Tmx7fTqCuCNxN+LtTmRUApN24ApYNwOMMWLXcz6NKvLJzU8/AesC6Yg/qoEu?=
 =?us-ascii?Q?z3srT1Nf/w4wOFb0baKl/kOH4aSa7FBcdp6DnNlqBxqbPHjk8Zw0pWHkkdxm?=
 =?us-ascii?Q?xWGxfoLxFf3dS1petcUObdWAMKGtILU876sY4Xxjvi9oatxtiK/2d/AmK+/Y?=
 =?us-ascii?Q?Hxo9ypy/L/zN83S0bXKwn+CafIyeeMFAGG4JirwhFeUAV0Xpq3Udmr1sTY8p?=
 =?us-ascii?Q?mDtFFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:52:18.7362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c32ed4-8209-4216-8b5c-08de5dd53266
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744

Fix the incorrect description of the schedstats report. Also fix the
spelling errors in man page.

Fixes: 800af362d689 ("perf sched stats: Add details in man page")
Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/Documentation/perf-sched.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
index 5bfb7bb6c633..4d9981609c04 100644
--- a/tools/perf/Documentation/perf-sched.txt
+++ b/tools/perf/Documentation/perf-sched.txt
@@ -86,7 +86,7 @@ There are several variants of 'perf sched':
    exposed through the file ``/proc/schedstat``. These counters are enabled or disabled
    via the sysctl governed by the file ``/proc/sys/kernel/sched_schedstats``. These
    counters accounts for many scheduler events such as ``schedule()`` calls, load-balancing
-   events, ``try_to_wakeup()`` call among others. This is useful in understading the
+   events, ``try_to_wakeup()`` call among others. This is useful in understanding the
    scheduler behavior for the workload.
 
    Note: The tool will not give correct results if there is topological reordering or
@@ -100,7 +100,7 @@ There are several variants of 'perf sched':
    A detailed description of the schedstats can be found in the Kernel Documentation:
    https://www.kernel.org/doc/html/latest/scheduler/sched-stats.html
 
-   The result can be interprested as follows:
+   The result can be interpreted as follows:
 
    The `perf sched stats report` starts with description of the columns present in
    the report. These column names are given before cpu and domain stats to improve
@@ -116,7 +116,7 @@ There are several variants of 'perf sched':
    Next is the total profiling time in terms of jiffies:
 
    ----------------------------------------------------------------------------------------------------
-   Time elapsed (in jiffies)                                   :       24537
+   Time elapsed (in jiffies)                                   :        2323
    ----------------------------------------------------------------------------------------------------
 
    Next is CPU scheduling statistics. These are simple diffs of /proc/schedstat CPU lines
@@ -210,7 +210,7 @@ There are several variants of 'perf sched':
 
    While profiling was active, the load-balancer found 28490 times the load
    needs to be balanced on a newly idle CPU 0. Following value encapsulated
-   inside $ is average jiffies between two events (28490 / 24537 = 0.08).
+   inside $ is average jiffies between two events (2323 / 28490 = 0.08).
 
    Next are active_load_balance() stats. alb did not trigger while the
    profiling was active, hence it's all 0s.
-- 
2.43.0

