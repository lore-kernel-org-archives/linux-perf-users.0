Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E03CC337;
	Fri, 10 Jul 2026 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680351; cv=fail; b=fHRoGP7tcpGx8dTzcJpTAxQqKofVKzyllwykqAMrRGcSXfHFi0vYShY9Il9TXaQynJx1KLUj6YCv5vxeMYK6q2ASMX5z6gWWjlYgoLxiBwRr7d3z2PWMEyYsU2tVTqUE0Zad3OeP/tr1FcIjHKGtmGdgslp0vKOmhkG0eWcOLo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680351; c=relaxed/simple;
	bh=Z1GhkmDkZSsTBK8r7IGJj/T563ybQ5li/tCkQ9HnnTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qf1KsOJyYOTSvNm7KuuFhGQfElcvFq+nDbIiY5YS+DE+PVmp9JDVeg2Epkd3thqlWhBfhRz6gNjbe/WNXUxWMca414M/6KXo5uNpZpnvafA6p86qV07Mk+2lkYw10jTs2BvZclU7gUixJ7/S3p2KQzLtnZPzyXx8uM/Zz6W1i0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L1KDc0ls; arc=fail smtp.client-ip=52.101.62.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1KDc0ls"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdW1F3TYfPVvP4rW5P5B3WEREQUqhNPsb3hAOQMlhEdaouXsYjX5EmwxxUqGGwXFuqrk+Bf4tJBUFsOcPfHo8SjjXrxJyA40lXChHYRmMMbzTl4Cu7kucdL+7TqrWkwfYv/JM0bav8xXsD4oZeztNcff3I3SprG0AMzj4RSi13deY+hqddIYVSkWvFHGs1j0nEK8ttGaLZe8Kg4zKO3BicUriz8+rzfQT7Sr1zHVHw92tMIjuSF6SpXU8bfJ0MZJuxX3tfOCL602ZxFnvZxTZkU2wyOlHYrsm5W1+hR2Vg71w4oja3OcP/89EiITZijhEzAGEXLYAbU5ldkrdCFJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZvz+nExHOwxi4Jz9yz54e5dF2zBRN8WtNfO4bJrtVo=;
 b=x2De6wMf22MKMjbTkfLt16Zx5An09TtzC+yWNO8kAIH4qgCyzhRhBXIvdoObbuKgZ56iB/G/c/KuOYS63x/pZEDrmGBGoLeDb7FDUPvzVu4Pnolzz65g5x/yCvWtQSOMSP6X97jeySaZm5gwRieRo+x2S8N06fy9flmv7wA2rESZ9M4nybZigay8z9Dnaf66FySAr2rfuz2dN+pv/oFYWniRfyC+JJ1yscrINGQP4X4Hu4it8ejVhDLtmifytO7szVGMMGXTXj3yAC7MAm+wGKgJsbCVjySI9xi9QQsnhrIExuql6QvkBrhC7xn6qF7tTRAgY2RzEVVn8GdS97yUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZvz+nExHOwxi4Jz9yz54e5dF2zBRN8WtNfO4bJrtVo=;
 b=L1KDc0ls8Y3barCtXGpNq9hcDAtl0dgEtC9QNrn1c2AaYmYZF/jywE4UUAZbe/tsmD2pA27nm7E+WtItd5Q65BgdMC1OMCJm6tUUmLtX6yOtNMkbKASwgn2xy7cHyFEbfEHNAEOS05fkzXcn6Cz9/LSUg5o8ZDryxzmWi5wp57Y=
Received: from CH2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:59::23)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Fri, 10 Jul 2026 10:45:41 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::a7) by CH2PR03CA0013.outlook.office365.com
 (2603:10b6:610:59::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 10:45:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 10:45:41 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 05:45:35 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Stephane Eranian
	<eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/lbr: Fix kernel address leakage
Date: Fri, 10 Jul 2026 16:15:27 +0530
Message-ID: <a898a29725f6b2f30518354cdc2e432db66c43cf.1783680119.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3d11ab-c4bc-44ab-5bdf-08dede706320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	vqeGwo5ByidUSC6SFZWEGTdp9o/BReIH9IFWk1kpNd8Nnpljmg8LGTo5Wl9QY4063UDc2+qVLqISHAJNi9feSPzuTVksWhZYnZ/ohIjkBLOG976Eex3U+QiKiX2lInZCdsU2pFQYbngw2w7X98TkrzfKsjT6TTFCbHiJCKWMfjLoxupHFVXoXyEbOoz3O5VGNPeWtdJ9Yo6LYbtUSYRNBA7b7yshNEGTraI69HkaunZQ6uNF9UFClkXTqbuwhxfeLWkrpO+xr2zNrLzhJWVuEPt0nTsG6wUF9o+GhSXYXQ/6pFyueWpssdPvEdDjGddVO8ptImjv7HMC5qKi+VIWt4Sz/zRzxb8HFxIiat211WY+e3QUUnGuREP8O4qpc3H7eGFlpubEzy/dGpWP6TTPnowJhE070I/+pqZKe5gD8DJyMKGSxhlAvmIbXyRrnms/RA1abkWem5bq1jDPPFOPJpF7zZzS/ZovjHAUqXi2yM76/sNmom6AhrwDwLrSzLecLu7Fb6gQxLfXh3H/dY2r4qnEtFa1uLmjD+8u/MWH5hEvj4yUi8uOY7YeIYNQ0FYoiqBFsL9g+VwkSQlqJtF2ILO7Uzz2LxKzAj5cXEWs/UQ79BVscVAPnzrVDhhzf629hWZlBE/xIp36rWtTCOSZJ8qDLRBGJC/v1YSn1YDu3c15DbC1hPereO9XC/bKgaLLZNBnw7IfzB/PQDgx0QV+Tw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Q7Ebs4L60SMKBsD3esNh7QsiEEzavFRmuyJNJ1CLlPM2X5WdivpUv621IPN+YMHq+/xVMyZuRQI3mpiZBspPQBTX3lmAZvFpFw7YhRtSf1LF5ZUsqQuYmqeJ/D6Arse11sWXFqdB2G5ZiRIIWYllDhAUoXrUUDS0HhwuP9piksAjCxEjtSlpbfOKbrzX4YHTjsB1KQmCGfRoPsjntySe7FqLjVI1dKB4gSnzFzEaXRjHOmUQ2hpyrX/eix19Y/V2SR8fiCpqmV8vgeohSY4I+A3BLb6e3MXFOQwcc6tJGmHKJMU6OwFs9zUW+I4kIpg9n0AXq7gFkDDkAw18qnGJJNRuQLdmwEmzZI+t+Hp1u14CLqR/i9Ui86+mbJccDPrc8Ph/CS7kfSdOBpuovthAXB+Z+ZAgWSwhc/ZaWSmGmzePLmWrNRyHea2vOAkPu0r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:45:41.3406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3d11ab-c4bc-44ab-5bdf-08dede706320
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

A user-only branch stack can contain branches that originate from
the kernel. As a result, kernel addresses are exposed to user space
even when PERF_SAMPLE_BRANCH_USER is requested. On AMD processors
supporting X86_FEATURE_AMD_LBR_V2, perf can still report SYSRET/ERET
entries for which the branch-from addresses are in the kernel.

E.g.

  $ perf record -e cycles -o - -j any,save_type,u -- \
        perf bench syscall basic --loop 1000 | \
        perf script -i - -F brstack|tr ' ' '\n'| \
        grep -E '0x[89a-f][0-9a-f]{15}'

  ...
  0xffffffff81001268/0x717a90a38f1a/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a90a39157/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a90a2c628/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a90a41b60/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a90a260db/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a90a260db/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a8bef1c30/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  0xffffffff81001268/0x717a8e4d3c90/M/-/-/0/ERET/NON_SPEC_CORRECT_PATH
  ...

The reason is that the hardware filter only considers the privilege
level applicable to the branch target. Extend software filtering to
also validate the branch-from addresses against br_sel, so that any
branch record whose branch-from address is in the kernel is dropped
when PERF_SAMPLE_BRANCH_USER is requested.

Fixes: f4f925dae741 ("perf/x86/amd/lbr: Add LbrExtV2 hardware branch filter support")
Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/lbr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 5b437dc8e4ce..9d9c961989d5 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -127,7 +127,8 @@ static void amd_pmu_lbr_filter(void)
 		}
 
 		/* If type does not correspond, then discard */
-		if (type == X86_BR_NONE || (br_sel & type) != type) {
+		if (type == X86_BR_NONE || (br_sel & type) != type ||
+		    (!(br_sel & X86_BR_KERNEL) && kernel_ip(cpuc->lbr_entries[i].from))) {
 			cpuc->lbr_entries[i].from = 0;	/* mark invalid */
 			compress = true;
 		}
-- 
2.53.0

