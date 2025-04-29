Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04C27470;
	Tue, 29 Apr 2025 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899244; cv=fail; b=XLwNnup5Pq8/JfQHXKEBZ8M5RcPFz4ysWZZSreVEFuKKPfQ87IY1jLytyc1VF9Lw9/GOi78j3jLSaLnIBIPTIGClc+ZETd1o/bPFUGkd9vbO71vts6f0nXwPYNsHpzU0eNI27PQ5S/h6s3vfhzjQReIG7kdu97+fY20ng7wKE00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899244; c=relaxed/simple;
	bh=Glp+NTrVrjz69E7ID8NKNOhdRLnwqMvd7kGsouV6spA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0hzYfq7zjHTBN+cjXtgG/gBX3ybdkiREI3S24K7VhhUg1/nuERZP0TnbpJVCGNdCS6yVjxYxjRjW9UeSQ6OMMHlk1rIAtqdrLJp9h3y83osOTvQkK7eE8zTLvmt77iWRgw+wYeZHwE+AVY3eDUfsh4YcPW6qpKNsVfafN4uTS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zACiqTTJ; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zACiqTTJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsiRD96du/PqBOj16JpO4xlU+4AnxnRx3XStRW0OX3iTQ54Q0nieyROZwtSHsNsQFeW1DoXlD1hKxDUM7EEDaYyOMfqY6WXob96Y3qszwMNer5dn1tAvZ+eovuVVIBPayzIQw+g7aHMgoj75N53J4Tndz3vQ6/TqCngwzFpxGOrlRYa/7Ye+c6wRKT51IKteKjrjDkMx11ooCfABNBG5zLgXxJq9D8MLLJ5quZFOWoZiw93YoX0XWc27VQchCWc3qiKdJ/jauqdHMk08+keN9Fh0cbAv5gpv8a6AaDHuQFn3/+2BMPh12DVPhq5QduxKJHU/H1rxYN9wDFEJtZAHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZJKQdzsXhc4h5/H42TwHke+LKvW80blz8uLEdZiC4U=;
 b=rLNSw9QFbIP94BMKZL6pDi5lfHJ+QaE9WvEmaZNn5mfJbaoX2+1FpzH1sBuOzUjOoA2IqGASat+673Cgqn6pivgEYxAD14rqNy6n5eEmwOvM3svokiUkP53lpVeum0V3E3DPA4yeR5kaXaJRtk5zOV3BbY08+2n0MM/Zw+xvXC51hFa7yzarmBUTrIorqXMX8P+kTSQhWCb4ywtWWWmqqvoqcSoNba5kotoY9InuuLNgEHmVUjDO884jZg1ekN7V1DmbiaInUKAaSO7EyzBv3koQAzQrDE36J7pTcPZNPH8pcvhWkC7LU5t+VoMEfBmX9Si8Vo4fvqCkPayCNGFKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZJKQdzsXhc4h5/H42TwHke+LKvW80blz8uLEdZiC4U=;
 b=zACiqTTJ+3yfNaTQHinG/fOFhT+714USq4nNGapmFZrZd4NYZ3SP37BE2oaam6s1NEbkrVPAjCSaKQ6JU3Jk2EzfIHlDXoLs/92egtAxAxxOIdjlHsunMi0afyUyxSfVqvZWiv1HtVF5d98EABY7KknnAYA1iucnsX77518mrlc=
Received: from CH2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:610:60::19)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 04:00:38 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::e2) by CH2PR14CA0009.outlook.office365.com
 (2603:10b6:610:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Tue,
 29 Apr 2025 04:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Tue, 29 Apr 2025 04:00:38 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 23:00:32 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Joe Mario <jmario@redhat.com>, Stephane Eranian
	<eranian@google.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
	<irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v4 1/4] perf amd ibs: Add Load Latency bits in raw dump
Date: Tue, 29 Apr 2025 03:59:35 +0000
Message-ID: <20250429035938.1301-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429035938.1301-1-ravi.bangoria@amd.com>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: c0162844-4d57-4c1f-daa1-08dd86d26705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UcSySSaoCZl8Sdo0ExFk+ncf2YmBE7T+SlyxgRhETzIvJExB5W7vSot39Y+E?=
 =?us-ascii?Q?DLAmenDgpCOn2fldymnGpGWHlEXf8QeoiPAECoUTgBc8EBgQMlT4qXzGCZn/?=
 =?us-ascii?Q?zh2ZY+H4uvWhy8Zf/8cogITjaAQx7iXCTkjUQ/MmTL7L+PYXXeY7eJ7c8lsH?=
 =?us-ascii?Q?/epDcnmSVMSlDaJpxk0qdo+yzHCCbxN4N+JkaoFI6ofDIp5H+PG3JI17KJUJ?=
 =?us-ascii?Q?RelRUCBxBNHI1XpqmCzEuGM9iVLyFolumgBiQQQ24HnKkSTAR9lQE5z8bCcs?=
 =?us-ascii?Q?HMqvqPJwpTd/SGQ/OKPDRsb3UlVlfdYqseJDOTZpCR4/hhLhhrO4Eg1Xl8pL?=
 =?us-ascii?Q?qe7edvwwLPzy+MzZtQ7HTRlhzhR400n5+liIDb19CYJulIRdULu8zuNhC7Pc?=
 =?us-ascii?Q?2dntqNdR6Oo1C1bEkYtS0EOkWJoFnqxKuuKL7HcoZRb8/DWId+z1sQHvI/dt?=
 =?us-ascii?Q?ufAUOUZZ+LxFjC8LXoieTfXQsmdKckmp2DMPfzgMUj4MXjd04v119fWVcpkg?=
 =?us-ascii?Q?Ndv1WhvKtl4J03zq8GvB+sJIMkf2+zvWHV0+lHCG0kJmkEuNvt6BqRxlFdmU?=
 =?us-ascii?Q?P6+CjJY2a8GgbevwuS2QgJfspzrBh/rxuNTTzDobKK0YG4z2nnEMCLxuirjg?=
 =?us-ascii?Q?bUt+ob0qQjhMnUzA/2j5C3WRBTUCb5i4f9cJWIzXmdVZlwI0IIasXAhsn1Oq?=
 =?us-ascii?Q?pXY/0+ys7xWSMRrKRdu1wOcUiN4fDGeyTtFl0x1fcs/XvPqKv/fIm/G6OTa7?=
 =?us-ascii?Q?IY0wr3g5e4GRtMUVQ4LzMmqrohwAJd5LngMv5hsIQm5b8lLqkCN0lxBxp/MS?=
 =?us-ascii?Q?RQMhguQ6nlPVLwvL/owUr0Mn3CBTHLxM9lWl4vhlWxE6586uCR7+L4nsgQqa?=
 =?us-ascii?Q?G6wvvHCGuLRE1Uga7Vmz2iYpF4QkmnA0uiZG620ZQr9kI/gt0UEQ4z4HUY4T?=
 =?us-ascii?Q?T66DRmFX50JW8GgTXOLK25J+MDPGHI5tn2JCaEN3Ez09XMtTBdWlbxv6LLas?=
 =?us-ascii?Q?iG1k9DBZB2zk/n58Jwnj22X+uaP/hyAZaeshXT22p/vEcRvwnoJPbgUEJHHx?=
 =?us-ascii?Q?qHt1mjgfpWUo7DgSpXYAia54SDUr3fh9ZyqqrOcieG2SRtJIlC/incj26+iP?=
 =?us-ascii?Q?g/SzLUC52WYVXOt3KanKuyKf0wY7B5KBctat8SSoBNY/lRhPNQFVE5Ebbh2d?=
 =?us-ascii?Q?tyTbEpR23lmAxx2sZB4b9FOfBq8TzXwpZI6Wbvp9qLZeEBgaid9scBQjMHZI?=
 =?us-ascii?Q?vcYjQK4yyRUkHkN0WzDGni5iK68D7sNdOyDa+QqS4y4s+jo596Zk+mrKufns?=
 =?us-ascii?Q?wU8ZB7MKxQsPHrw49HeIRIomepJnOA4Z1DS48PLTCxpE+Op19nVyXAUpRLVE?=
 =?us-ascii?Q?0EtCy+iqbY8DKgxzOG70UFZDIWXZ/GUaTK9WgKlqseXEMiL95spjiIG1vJzA?=
 =?us-ascii?Q?xlGWFOkbPEeLuh1fcLd7sEI2rxPPPhnNdNCCyXRDO/aRMtA6Cul/n9qSn9Yu?=
 =?us-ascii?Q?KavqJ3fCcHS1sDWcxUChh3BegEeQ/YaCedzN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 04:00:38.5500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0162844-4d57-4c1f-daa1-08dd86d26705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494

IBS OP PMU on Zen5 supports Load Latency filtering. Decode and dump Load
Latency filtering related bits into perf script raw dump.

Also add oneliner example in the perf-amd-ibs man page.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-amd-ibs.txt |  9 +++++++++
 tools/perf/util/amd-sample-raw.c          | 14 ++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Documentation/perf-amd-ibs.txt
index 2fd31d9d7b71..55f80beae037 100644
--- a/tools/perf/Documentation/perf-amd-ibs.txt
+++ b/tools/perf/Documentation/perf-amd-ibs.txt
@@ -85,6 +85,15 @@ System-wide profile, uOps event, sampling period: 100000, L3MissOnly (Zen4 onwar
 
 	# perf record -e ibs_op/cnt_ctl=1,l3missonly=1/ -c 100000 -a
 
+System-wide profile, cycles event, sampling period: 100000, LdLat filtering (Zen5
+onward)
+
+	# perf record -e ibs_op/ldlat=128/ -c 100000 -a
+
+	Supported load latency threshold values are 128 to 2048 (both inclusive).
+	Latency value which is a multiple of 128 incurs a little less profiling
+	overhead compared to other values.
+
 Per process(upstream v6.2 onward), uOps event, sampling period: 100000
 
 	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -p 1234
diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index 9d0ce88e90e4..ac34b18ccc0c 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -19,6 +19,7 @@
 
 static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
 static bool zen4_ibs_extensions;
+static bool ldlat_cap;
 
 static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
 {
@@ -78,14 +79,20 @@ static void pr_ic_ibs_extd_ctl(union ic_ibs_extd_ctl reg)
 static void pr_ibs_op_ctl(union ibs_op_ctl reg)
 {
 	char l3_miss_only[sizeof(" L3MissOnly _")] = "";
+	char ldlat[sizeof(" LdLatThrsh __ LdLatEn _")] = "";
 
 	if (zen4_ibs_extensions)
 		snprintf(l3_miss_only, sizeof(l3_miss_only), " L3MissOnly %d", reg.l3_miss_only);
 
-	printf("ibs_op_ctl:\t%016llx MaxCnt %9d%s En %d Val %d CntCtl %d=%s CurCnt %9d\n",
+	if (ldlat_cap) {
+		snprintf(ldlat, sizeof(ldlat), " LdLatThrsh %2d LdLatEn %d",
+			 reg.ldlat_thrsh, reg.ldlat_en);
+	}
+
+	printf("ibs_op_ctl:\t%016llx MaxCnt %9d%s En %d Val %d CntCtl %d=%s CurCnt %9d%s\n",
 		reg.val, ((reg.opmaxcnt_ext << 16) | reg.opmaxcnt) << 4, l3_miss_only,
 		reg.op_en, reg.op_val, reg.cnt_ctl,
-		reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt);
+		reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt, ldlat);
 }
 
 static void pr_ibs_op_data(union ibs_op_data reg)
@@ -331,6 +338,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
 	if (perf_env__find_pmu_cap(env, "ibs_op", "zen4_ibs_extensions"))
 		zen4_ibs_extensions = 1;
 
+	if (perf_env__find_pmu_cap(env, "ibs_op", "ldlat"))
+		ldlat_cap = 1;
+
 	if (ibs_fetch_type || ibs_op_type) {
 		if (!cpu_family)
 			parse_cpuid(env);
-- 
2.43.0

