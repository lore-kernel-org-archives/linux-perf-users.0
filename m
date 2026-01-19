Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1924A046;
	Mon, 19 Jan 2026 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790645; cv=fail; b=q/vKjY2YugE3SMlD50cq4YGl1mtYCj2WqTMp1BEi0g4DkdTaj4PoP5aIpjcdLBk0dCX4PObjjGkNBCgSZ1l7/gsE633acDy+6k1x7dasWBkZ3EDOoAaTAm1gAGqoVKtoz4muBCYeVRslYuaHR3dYRB3i114e+DFx8Hu6QyT9OBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790645; c=relaxed/simple;
	bh=yDNzcUeUgsEk24/J59wy1T+kUWrRDGiWmde2LRKNr7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFf6TrefSsT/pL2it2JTzJqoxBvC0S5kM2peqtGt96cJoplRGOn2tcqtygovHIugusagF6prmNLYTv5IJg+lYt+tvC04zUU0OtQNYy69Hn14GpSyZbu5DOF4zNT01DGTnMknm3CFwaIJvl1qW0NOjONMLiaLODJRwDsgryZMMeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SLZjrJ6t; arc=fail smtp.client-ip=40.93.196.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SLZjrJ6t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynPkFl+Mbe7meLEdX9I3U6ggDbUWvukHoitvbYj1XNxECj5uUfv/5+vyhzXqtUkLxHKmtHNtkoRg6gaQwHWayzQooyQQEcf+MlnzVk+iVeGhDXk+EEptvKoQm/Mq6njp+bgh8C7FXGCpmnF1L9QKa8e4TpNBtlbpdTVYV9cp+0eHaYGoC7+tVsmBnjxc8RsH8BwYi9yUA0HBZG6ByyHPfro9IL+QeDGJsHi8Ryokxzd3wLrQXiCE1PaUfpN4sBV0SKUhRIvP290Bfl1aBthBy7Tg30WFuR1S/uH/A/fvExLaOPqSE8fCiu3XhE+/LbX3t31dd/Z4UoXzzbRN0rjjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0r1p5pYzfNoAi5du8gBxpk7L/1CXmjuapfBBW6OW1Y=;
 b=ftONVjiqz0Y35MNuQ9/is7i4pJg9dMYqzxZcAp6QSvCK/GoBJcmeAijsda6zIoEZPjqc5/9jxkgS5iiMwM4CgK8mvOBcPK/o7g60CCfU0Y4nbODLjatsUfHW/fojZ0uYhAFPPaVVov5mWOM15s62mOsKYSu5Gr5yXiqTKHMWNJVmzauIQH8nD8BZHeSoHwJHJb6iLaK0OgkjQjzT9NUr6wVLFmNjDFkvPkxlMc48H92Hb3WJMUeInedx7Rtkhej6jk2VbOuM6lxzt8t2ia+PCyLVy5R5psz87TnNLm4z4g/Qdu0ZVCedFu2SbV95haWdaq2oTx2UXtAczo8zRyMM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0r1p5pYzfNoAi5du8gBxpk7L/1CXmjuapfBBW6OW1Y=;
 b=SLZjrJ6tYuLBtBOBuuuSrAdINRILVtFMTSxFOjjaN4R2RpcB0Qw3FhE2MCmZHuHiLevFKrkkxhTN1F1vmy0Ws2iV0mmdHrvp1VEtlR9xsyEquukLAiTkrP5+62SeYFQ/YFnRH0PHy7+QBnj7rZoT3TIEES3Nat+JZ/HLcJyAkV8=
Received: from CY5PR15CA0179.namprd15.prod.outlook.com (2603:10b6:930:81::27)
 by LV0PR12MB999094.namprd12.prod.outlook.com (2603:10b6:408:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 02:44:01 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::ae) by CY5PR15CA0179.outlook.office365.com
 (2603:10b6:930:81::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 02:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 02:43:59 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 18 Jan
 2026 20:43:54 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 2/6] perf test ibs: Remove obsolete privilege test
Date: Mon, 19 Jan 2026 02:43:23 +0000
Message-ID: <20260119024328.897-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119024328.897-1-ravi.bangoria@amd.com>
References: <20260119024328.897-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|LV0PR12MB999094:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5abe67-6d11-4f08-13bb-08de5704997e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?//lz7xwjZsa2oGs4Sa6UlhnI04YA/ipRrN6cSTHLO3hEDdX+8Jo5DC6U+Kph?=
 =?us-ascii?Q?VXinJl6G/aexLCMoL0OtT5hb8pmSliltVnrf7LuIdKVPrvcmlWWcvznTRczg?=
 =?us-ascii?Q?4QBvgsvItbPXSrZ/8Lfdgkt+5kjRPefw53Ez7oHOpItPrsJJ0H6bhPJUO0o/?=
 =?us-ascii?Q?mlzYhsULZxTZ/sv45ZL92D2Ug9yTF5FCyvNZHFvZbKS6VpFG+rP1pbwFJXpl?=
 =?us-ascii?Q?UWojBxZky41tvg3qhJ3anN9F5nEpco4Vtq6NqdpqL8BjQniZuGBVEeyjpK2R?=
 =?us-ascii?Q?xzoZ1Vc7eu8l8MT7Iz7DDnmEHDjL30iXwnpqtuQd9wTZIj0TNFzUFZRfK84+?=
 =?us-ascii?Q?BupAkRvGeBHXGXN0y4tRzpHQKOMfVtxLqKnQptUOGznWeGxY/8FjfMYwa/FL?=
 =?us-ascii?Q?jaJJ82AnT9GckfuU90JZe63Iy8n3+sCBns63RJHNGBEE5RElFIsFtDHY1Zgd?=
 =?us-ascii?Q?sNAPWPzj/BEZ0lJMc5h3c7iv2XGgaeA5diyRPvhp9CGXJe2AmJbYAk9/Q2ld?=
 =?us-ascii?Q?jv2cLhh13pCg8f9d7Vm32/uimDAjV05MLY7GBnd5mHMH4/spRgUjH7uAA5PR?=
 =?us-ascii?Q?N6f5Xltf5/zMsvw6hKDPC3FT1byfPVWBGnCv272p58m7fqdVNAGgH1qZ09tk?=
 =?us-ascii?Q?YFGYpzKdIs3+SWExC6k+8B20xvkHA9HmY83ek2otjOsIpH7+3540eIe7wY7+?=
 =?us-ascii?Q?IFgctN8ZlQc0m2x27X/5mfzisHqTLEoC/e0z0Ex5In35IfAVEWIaRDyqBFwN?=
 =?us-ascii?Q?jgaeITDPmqeUAU6b1FQH/IC5P7VtBgnh0JCklPQIWfPERl6sISKd1NqcKymF?=
 =?us-ascii?Q?VoBv7i4oWiibohgpo9X9ARzI1AQ6/NuuWUH8sbBC8ADpSxpyA3yF9c1/0/bf?=
 =?us-ascii?Q?h1YcOmEFc/+FLV/uARd4qUzepUBs9kgMWd+biJVpoo2gGuBRQhydz8BiF4qQ?=
 =?us-ascii?Q?J7I80I//L8YDuUYS3o2oI4D6B4Lci9rmkwqKlaRIRoUmR7X/j7B2QuGlNzZp?=
 =?us-ascii?Q?RuEflYKUbQ+tDlCR4aBRLPSiyl+Jo7xIjyD8RpE0RWHCpYWNQex4HQSDapDl?=
 =?us-ascii?Q?l6FL2lRMAB9VP2s9WOmoHuhy7BslvFBD010iriQlACCiPm//5CzrZGmXqCNo?=
 =?us-ascii?Q?3+809oGL6+/8SEvwR241I30OvLy+NpMM102JDDPR5etdfn+LcBogxA/jABf7?=
 =?us-ascii?Q?hG8OLIEDhAsNeRfQ4psRrNmtkCqx2bwvuVony+25Ic/EMfiD/t4fEF+p6FYX?=
 =?us-ascii?Q?j8tmXypWUMFVmnDkTenynTryQmEKK0eKEw5I1TXBVFBdyGS+bjDePMi735IB?=
 =?us-ascii?Q?BVZvzlDwjI/Bk1NdEXGGR4dG9hQhX0Vg1224nfJkGEDfiEeexzsJwL2YMpWm?=
 =?us-ascii?Q?mKLjHfivAoU3vnZfBGvVLcXAQbCm3Y/835hA4RmYLqHtGhz8KTWTkRt3cO3g?=
 =?us-ascii?Q?AnCbm/KqMMFQdRMw4rP7Ptp+ynLMrxwxVqR2z1BHtYe1DSvuydHtVcDToPJt?=
 =?us-ascii?Q?+WfJS0bc0vAnZlLbKwoRfamaE9id4t8zlKefPzPpWFqiCiuZmKzIW6DSQARP?=
 =?us-ascii?Q?wXEaOpeDphbBoRYfIdaOclBV2EcHbIp4uuvT+pwYRQTCwIHTeY17j/6sWHJv?=
 =?us-ascii?Q?Yq9CP9fAieaBmVJyXuYKFeU/rJQKfEqccCFO+A/3ZSL3o73vgL1kngGZocJV?=
 =?us-ascii?Q?xNccRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 02:43:59.8985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5abe67-6d11-4f08-13bb-08de5704997e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999094

Older IBS implementations lacked a hardware privilege filter, so the
kernel enabled swfilt=1. Newer AMD CPUs will provide privilege filtering
via the RIP[63] bit, making swfilt redundant. Remove the perf unit test
that assumes IBS has no hardware-assisted privilege filter.

swfilt is ignored by kernel on platforms that support RIP[63] bit filter
i.e. all amd-ibs-swfilt.sh tests will test hardware assisted privilege
filter.

Without the patch:

  # ./perf test -vv 75
  test child forked, pid 26029
  check availability of IBS swfilt
  run perf record with modifier and swfilt
  [FAIL] IBS PMU should not accept exclude_kernel
   75: AMD IBS software filtering                            : FAILED!

With the patch:

  # ./perf test -vv 75
  check availability of IBS swfilt
  run perf record with modifier and swfilt
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  check number of samples with swfilt
  [ perf record: Woken up 5 times to write data ]
  [ perf record: Captured and wrote 0.040 MB - ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.054 MB - ]
   75: AMD IBS software filtering                            : Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/tests/shell/amd-ibs-swfilt.sh | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
index e7f66df05c4b..92ef45bf3043 100755
--- a/tools/perf/tests/shell/amd-ibs-swfilt.sh
+++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
@@ -22,13 +22,6 @@ fi
 echo "run perf record with modifier and swfilt"
 err=0
 
-# setting any modifiers should fail
-perf record -B -e ibs_op//u -o /dev/null true 2> /dev/null
-if [ $? -eq 0 ]; then
-    echo "[FAIL] IBS PMU should not accept exclude_kernel"
-    exit 1
-fi
-
 # setting it with swfilt should be fine
 perf record -B -e ibs_op/swfilt/u -o /dev/null true
 if [ $? -ne 0 ]; then
-- 
2.43.0

