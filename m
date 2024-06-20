Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA01381DE;
	Thu, 20 Jun 2024 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862091; cv=fail; b=mjQYQ8EcQSe3B1mFAvLmb6ULgjj5YtG//WR2zROMZyzEp1/g8Lk3jMvnb/vRHAWHcuqkpLbImAIJQQC0di6TmpPT3xTFmFJh6kjaKEG+7Si79EAopb3tpkNQ0M8SFjSq//Z3LmvxpIvhuRuCFRmRTzh0jgG9VcTlS8XNr57k4Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862091; c=relaxed/simple;
	bh=7q7WbGkYCXCgmiWDIxlSOekyyVj61/B+/JfMFWS813I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=huJVPBBoy8vLpVnHJ2qI1FvoJ15PoBzPFK8WgJ0byHATtSbow+mVjsP3vyN847LsofsRvmV8aEiKqU+ntv1/k6KaK71FyUHJETqCL8wBpbbjBuvcGqb5brqzOtXmApeuxuSXhBTbfuwSEKdyk4oouEalQ81ebE4Cy5m43vZmgb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=avc4g6Qh; arc=fail smtp.client-ip=40.107.96.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="avc4g6Qh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR1Ix8aCYr5fM8gN7XNItEOOXa/9+oTHSjLEiXjD8VjocNaOwrkdTUgTcNYWaFFylTQnyolFQ0jvh1Q7GYbJo9UsH3HW1qNqb932KLV+/MC/ww2Emn+dJiKBbtiMaCCi2o/iyZ5JE/EmzvOLni1xu9pIcnSRzhrGp7gdSKCsYpXO1TVQ1FLVUvhP57gVGehkux+54h+q2/oBxX/A3yPXRyHTkpyvi3WVBYimBQpwxlq0fhi60pSl60Ara9vaWz+ABoBzVCOBc56P5guVjy+1EkRCZaCF9gM1s9wdjJrBa9aQmSEH6p/f4p1XTSD0kf29kvaLjsWgm6pKC+xpo7/UMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxEvbZz221/yeB+BqhLOm6cyRgcZzGk4y9XhHXDX3RQ=;
 b=T18/naNqUV6y99VcaoNf0E0P37OS6QmdbsPBgSfth3z9Jde9Tm8Kk6L8bjkocsLvKsFJaLJ5fgFjx/s6Jiq9x0SPPzi1MsHa0JJ9X19Dks7wG7ORARWLDouUX20KXfXtB+7QZ2tFFvYEGBbJKyWgmvvbpPyomtsg+dgZkv9hlilAlCrhJqoujny0X0Tb2N6LCFZhlOGTbtwW3ckIhT4JrRuydMkvjvhmmqpnqDqmRJIAC03vrifClviFkE0nmqa9zMKdIIGKnRV40dH+GyQc808FLIeH1zAJBoiA8kDdMPzQbdFDhXEpstiv/MyO0uDEleo+88s1j96Awn5Ba5LO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxEvbZz221/yeB+BqhLOm6cyRgcZzGk4y9XhHXDX3RQ=;
 b=avc4g6QhmsTl4oDhkLr2V+ycgM9769LY7WcPkVa1JDi/1Ej7KP5EJo+zkuE/PIaWh3Xy/dYCurwer9Xg4+Q0SLOnLWrxWkPhnLPAgU4waf/Q9bhLVqC16wphbAktBcvbw0hdi3GkKY7c7X09sJ6tAnVGpuj3l5CsBk4jxs0tUMc=
Received: from CH0PR03CA0183.namprd03.prod.outlook.com (2603:10b6:610:e4::8)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Thu, 20 Jun
 2024 05:41:25 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:e4:cafe::8e) by CH0PR03CA0183.outlook.office365.com
 (2603:10b6:610:e4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 05:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Thu, 20 Jun 2024 05:41:24 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:41:19 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <acme@kernel.org>
CC: <ravi.bangoria@amd.com>, <namhyung@kernel.org>, <irogers@google.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<yangjihong1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <sandipan.das@amd.com>,
	<ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2] perf doc: Add AMD IBS usage document
Date: Thu, 20 Jun 2024 05:41:04 +0000
Message-ID: <20240620054104.815-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: b432fc6e-76d9-42e5-6686-08dc90eb9f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|7416011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hvR35axtC68rW4U3UhbmJJuWPzI6qBfez7e8WXSNz8bL23e0WBn/4kZiOgWE?=
 =?us-ascii?Q?0JypYrZSuHt7EM67NsGDvV2uEuQCPH9eXyMC1Ck10Y331dF7w1DXoKidgJML?=
 =?us-ascii?Q?UVu2Vm+24DmPK9VFN61P8zc6lIFEF41Tiv9rH3M2Z4n4/nMlE+RMx4jVw5dC?=
 =?us-ascii?Q?TJPPWhE8hGYGVAwmnBrPG6tW9VrOS+kZixqMlPrZOJ/5DiqBxj8UUTj8DSOv?=
 =?us-ascii?Q?/vReJxm0a3aZO40kYC3jf8TM4jk7BBDaN1VdVi3w715QrrLlnbUf/pO89U+0?=
 =?us-ascii?Q?uZUbBKsf1YfVhK3XWtQxKBHgd1KxiwQLDW4X8dS+xRWlLGCYwcEYwj1p6y30?=
 =?us-ascii?Q?Lp1AFGuSIa2jg16jz781ATOHybg9/k8G7HTLtXhw3aW0qb8NwhJCQ2jPuE15?=
 =?us-ascii?Q?RlQ+cAD5ZLwkPpwRXiJe4BsuQwNyddBPbvT0jUb8uxonaeH2/LfcX5IwUMUu?=
 =?us-ascii?Q?vyPIRy7+gbH8TVJ3m0legmYpZXTEoEB476MXkVhOJf5ZwbkCcmTG1KCbv8yL?=
 =?us-ascii?Q?SC56bRsXfv1GS5sbM4HhZAPmSR3vWgy9dg1M2RWFGiI79KBvCsAZtdEOaSlr?=
 =?us-ascii?Q?9hReBpvYAp1oLazadqV7hOD/3r9pihOQoyHkaLsC2S6KbgYq+NdFdB/NVUaf?=
 =?us-ascii?Q?ZQVhEBNC6FqznHxkvYZlVgcyKFKXLxukczFnNpaKHZfRTnOi8sNSTReU5m2c?=
 =?us-ascii?Q?frQ1hU8pJ91tfAttKxxeH1GXbm/7S33f+6A+ZGwq4HGk8WZw34kj0lo+au9n?=
 =?us-ascii?Q?yt87blDaMw4V5yvJfcleXAtP6efxKkN6zwAsbtvvr+5/nBtibcBDhwg5IpaP?=
 =?us-ascii?Q?9oB9+G3XUdDlR6KZQRuHOQrHPVaaTuvtFMY03emAJO4n/iJdF676KExdu2S+?=
 =?us-ascii?Q?oONe4TjYuEMUJsAa5LYlvEnalkd0+vtEWlogAHtyZxmTst6QWhBzaTMDCbGI?=
 =?us-ascii?Q?ER4KO8NazKFOOeYcg8XSnFHvbv+lSJoGT9yum3IpVV+MNQ5IbJHC1LPGxpME?=
 =?us-ascii?Q?PfrcbWDmhkR2TyKqk2TVkywrtk83FRx6YJAGlc1WtbL0uHs/2Pz5uYVp/wXf?=
 =?us-ascii?Q?/F0ypK1iXzNssVZICD7DU6zgeik3+/v2GfYUSfDq84U8MgMZ4EV4P+5onKAz?=
 =?us-ascii?Q?+yAoNPgEy4VbtblhTSgsSsj0KHHRwWqpTMC3CTlldgGmZmwy65WB/bDm575p?=
 =?us-ascii?Q?kWPAjf8+1nRB/6M/M/OYGOPewbb+SRZBlnzMz1LabvtBQRJjRabt8Ld768SS?=
 =?us-ascii?Q?NcXo2CVK/GUy69rV6+M9hR9DIYya76yWMlm4DR3R/gX9r7YrPyLZIwW2IoyE?=
 =?us-ascii?Q?Kav6g42xYC76w/OxTRcOg7E9005xcI7lIG+MMaZN0bVVmSubpl2uok/KCtXf?=
 =?us-ascii?Q?6I6JF78=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(7416011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:41:24.8003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b432fc6e-76d9-42e5-6686-08dc90eb9f94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279

Add a perf man page document that describes how to exploit AMD IBS with
Linux perf. Brief intro about IBS and simple one-liner examples will help
naive users to get started. This is not meant to be an exhaustive IBS
guide. User should refer latest AMD64 Architecture Programmer's Manual
for detailed description of IBS.

Usage:

  $ man perf-amd-ibs

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
v1: https://lore.kernel.org/r/20240619092234.1165-1-ravi.bangoria@amd.com
v1->v2:
 - Describe core PMU to IBS event forwarding
 - Describe perf mem and perf c2c in brief
 - Add example of IBS register raw dump
 - Describe rand_en flag of IBS Fetch PMU

 tools/perf/Documentation/perf-amd-ibs.txt | 189 ++++++++++++++++++++++
 tools/perf/Documentation/perf.txt         |   3 +-
 2 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/Documentation/perf-amd-ibs.txt

diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Documentation/perf-amd-ibs.txt
new file mode 100644
index 000000000000..ce8ac51d4ce2
--- /dev/null
+++ b/tools/perf/Documentation/perf-amd-ibs.txt
@@ -0,0 +1,189 @@
+perf-amd-ibs(1)
+===============
+
+NAME
+----
+perf-amd-ibs - Support for AMD Instruction-Based Sampling (IBS) with perf tool
+
+SYNOPSIS
+--------
+[verse]
+'perf record' -e ibs_op//
+'perf record' -e ibs_fetch//
+
+DESCRIPTION
+-----------
+
+Instruction-Based Sampling (IBS) provides precise Instruction Pointer (IP)
+profiling support on AMD platforms. IBS has two independent components: IBS
+Op and IBS Fetch. IBS Op sampling provides information about instruction
+execution (micro-op execution to be precise) with details like d-cache
+hit/miss, d-TLB hit/miss, cache miss latency, load/store data source, branch
+behavior etc. IBS Fetch sampling provides information about instruction fetch
+with details like i-cache hit/miss, i-TLB hit/miss, fetch latency etc. IBS is
+per-smt-thread i.e. each SMT hardware thread contains standalone IBS units.
+
+Both, IBS Op and IBS Fetch, are exposed as PMUs by Linux and can be exploited
+using the Linux perf utility. The following files will be created at boot time
+if IBS is supported by the hardware and kernel.
+
+  /sys/bus/event_source/devices/ibs_op/
+  /sys/bus/event_source/devices/ibs_fetch/
+
+IBS Op PMU supports two events: cycles and micro ops. IBS Fetch PMU supports
+one event: fetch ops.
+
+IBS PMUs do not have user/kernel filtering capability and thus it requires
+CAP_SYS_ADMIN or CAP_PERFMON privilege.
+
+IBS VS. REGULAR CORE PMU
+------------------------
+
+IBS gives samples with precise IP, i.e. the IP recorded with IBS sample has
+no skid. Whereas the IP recorded by regular core PMU will have some skid
+(sample was generated at IP X but perf would record it at IP X+n). Hence,
+regular core PMU might not help for profiling with instruction level
+precision. Further, IBS provides additional information about the sample in
+question. On the other hand, regular core PMU has it's own advantages like
+plethora of events, counting mode (less interference), up to 6 parallel
+counters, event grouping support, filtering capabilities etc.
+
+Three regular core PMU events are internally forwarded to IBS Op PMU when
+precise_ip attribute is set:
+
+	-e cpu-cycles:p becomes -e ibs_op//
+	-e r076:p becomes -e ibs_op//
+	-e r0C1:p becomes -e ibs_op/cnt_ctl=1/
+
+EXAMPLES
+--------
+
+IBS Op PMU
+~~~~~~~~~~
+
+System-wide profile, cycles event, sampling period: 100000
+
+	# perf record -e ibs_op// -c 100000 -a
+
+Per-cpu profile (cpu10), cycles event, sampling period: 100000
+
+	# perf record -e ibs_op// -c 100000 -C 10
+
+Per-cpu profile (cpu10), cycles event, sampling freq: 1000
+
+	# perf record -e ibs_op// -F 1000 -C 10
+
+System-wide profile, uOps event, sampling period: 100000
+
+	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -a
+
+Same command, but also capture IBS register raw dump along with perf sample:
+
+	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -a --raw-samples
+
+System-wide profile, uOps event, sampling period: 100000, L3MissOnly (Zen4 onward)
+
+	# perf record -e ibs_op/cnt_ctl=1,l3missonly=1/ -c 100000 -a
+
+Per process(upstream v6.2 onward), uOps event, sampling period: 100000
+
+	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -p 1234
+
+Per process(upstream v6.2 onward), uOps event, sampling period: 100000
+
+	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -- ls
+
+To analyse recorded profile in aggregate mode
+
+	# perf report
+	/* Select a line and press 'a' to drill down at instruction level. */
+
+To go over each sample
+
+	# perf script
+
+Raw dump of IBS registers when profiled with --raw-samples
+
+	# perf report -D
+	/* Look for PERF_RECORD_SAMPLE */
+
+	Example register raw dump:
+
+	ibs_op_ctl:     000002c30006186a MaxCnt    100000 L3MissOnly 0 En 1
+		Val 1 CntCtl 0=cycles CurCnt       707
+	IbsOpRip:       ffffffff8204aea7
+	ibs_op_data:    0000010002550001 CompToRetCtr     1 TagToRetCtr   597
+		BrnRet 0  RipInvalid 0 BrnFuse 0 Microcode 1
+	ibs_op_data2:   0000000000000013 RmtNode 1 DataSrc 3=DRAM
+	ibs_op_data3:   0000000031960092 LdOp 0 StOp 1 DcL1TlbMiss 0
+		DcL2TlbMiss 0 DcL1TlbHit2M 1 DcL1TlbHit1G 0 DcL2TlbHit2M 0
+		DcMiss 1 DcMisAcc 0 DcWcMemAcc 0 DcUcMemAcc 0 DcLockedOp 0
+		DcMissNoMabAlloc 0 DcLinAddrValid 1 DcPhyAddrValid 1
+		DcL2TlbHit1G 0 L2Miss 1 SwPf 0 OpMemWidth 32 bytes
+		OpDcMissOpenMemReqs 12 DcMissLat     0 TlbRefillLat     0
+	IbsDCLinAd:     ff110008a5398920
+	IbsDCPhysAd:    00000008a5398920
+
+IBS applied in a real world usecase
+
+	~90% regression was observed in tbench with specific scheduler hint
+	which was counter intuitive. IBS profile of good and bad run captured
+	using perf helped in identifying exact cause of the problem:
+
+	https://lore.kernel.org/r/20220921063638.2489-1-kprateek.nayak@amd.com
+
+IBS Fetch PMU
+~~~~~~~~~~~~~
+
+Similar commands can be used with Fetch PMU as well.
+
+System-wide profile, fetch ops event, sampling period: 100000
+
+	# perf record -e ibs_fetch// -c 100000 -a
+
+System-wide profile, fetch ops event, sampling period: 100000, Random enable
+
+	# perf record -e ibs_fetch/rand_en=1/ -c 100000 -a
+
+	Random enable adds small degree of variability to sample period. This
+	helps in cases like long running loops where PMU is tagging the same
+	instruction over and over because of fixed sample period.
+
+etc.
+
+PERF MEM AND PERF C2C
+---------------------
+
+perf mem is a memory access profiler tool and perf c2c is a shared data
+cacheline analyser tool. Both of them internally uses IBS Op PMU on AMD.
+Below is a simple example of the perf mem tool.
+
+	# perf mem record -c 100000 -- make
+	# perf mem report
+
+A normal perf mem report output will provide detailed memory access profile.
+However, it can also be aggregated based on output fields. For example:
+
+	# perf mem report -F mem,sample,snoop
+	Samples: 3M of event 'ibs_op//', Event count (approx.): 23524876
+	Memory access                                 Samples  Snoop
+	N/A                                           1903343  N/A
+	L1 hit                                        1056754  N/A
+	L2 hit                                          75231  N/A
+	L3 hit                                           9496  HitM
+	L3 hit                                           2270  N/A
+	RAM hit                                          8710  N/A
+	Remote node, same socket RAM hit                 3241  N/A
+	Remote core, same node Any cache hit             1572  HitM
+	Remote core, same node Any cache hit              514  N/A
+	Remote node, same socket Any cache hit           1216  HitM
+	Remote node, same socket Any cache hit            350  N/A
+	Uncached hit                                       18  N/A
+
+Please refer to their man page for more detail.
+
+SEE ALSO
+--------
+
+linkperf:perf-record[1], linkperf:perf-script[1], linkperf:perf-report[1],
+linkperf:perf-mem[1], linkperf:perf-c2c[1]
diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 09f516f3fdfb..cbcc2e4d557e 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -82,7 +82,8 @@ linkperf:perf-stat[1], linkperf:perf-top[1],
 linkperf:perf-record[1], linkperf:perf-report[1],
 linkperf:perf-list[1]
 
-linkperf:perf-annotate[1],linkperf:perf-archive[1],linkperf:perf-arm-spe[1],
+linkperf:perf-amd-ibs[1], linkperf:perf-annotate[1],
+linkperf:perf-archive[1], linkperf:perf-arm-spe[1],
 linkperf:perf-bench[1], linkperf:perf-buildid-cache[1],
 linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
 linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
-- 
2.45.2

