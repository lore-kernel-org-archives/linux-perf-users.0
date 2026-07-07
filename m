Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015DF3A16AB;
	Tue,  7 Jul 2026 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451059; cv=fail; b=IseXGnR5728cIiEYhI5JP9SfWfVTeb53ZLYVSL1BumXVNqnFq2aBEt4O4pfyB3yMpa01q/Nw7j1CS04DjfWWktl7Pc2nBE0c/hyGoO5MgDut9tP/3KOtbP5qHlw1SD+62sXprL7lavzMa94bqABuBE+rDw/EiIWn1J7P5ZRx6CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451059; c=relaxed/simple;
	bh=yVmByMd5ib+Dy/di7QTKA+2GzNkK7+BwK97GIRO85bM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kbmpfIjamfM6P1fau+KjYYy63FRmY+luedXYw/i2H/f8SlSpW4LUbs3rnv2R4sAvFqw0ilhUPtNc6P7z33xdgvYheImcIwLzgcatTatrmHnZ4X/sxIDmXUl37yaBfor3sszTtZQkB2rvFaB+sr5ehqPZiRmXReDhOKBDzJKaaU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GKr96rK4; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GKr96rK4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMatXieleqdQdaQcNpXvKsl2Y2/ATERzQUMfhAs/T7EtSfol1dAsExhjKHpIyQ2DTEbbboQtbs1QnSynRbgIlOB6WGfvbDNAIh7/rqcgo/yY59SPgBlvtKei+ELNs5wjScDHRxwvk5680up5Kg+HUHGG4UmSypa5qQ0s2Bgh2MSwhufSY5DEXsiL4TdXz4KTxZ3T6xdDYrxbkVtFnWthrO7g94h5l0199OzXu/hVTAtm+cvSc/pXwgje/Kms4kY1nOvVlS231ehNptRIN7zamovw+ofoEZVh42Sxe8pGAXL79mCJ2iFoujAsHtzDkyexP2JlTz2BYKxHD/bC6cUJew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkcliAwKvaUgXrpefaSqQkUeF7pMtOLIDNytXIt3XPM=;
 b=HTKjYogvk7PW9PUtlDYnOizdExWisQXkBJjwMx6sNIbhadCi4bC6CCNijoeQ2a/6RQvEcTDsY4FEKJC5nFEw4zVny0X3XkFxaE1r5WL1yE0izNjd0ClKf9zZuKbD42YXTk86HfFw+5n8fovigDmFgz5rL7NogiyQqbAP72u+U1lq39dtdc+t7+ddw4GCIcvAS+xNovqQjxQVfh9YsfL59V9Xa5GnOF0D2b0ncFQKtD499hZ/8Thf4tFek7UgH4ZmU7BKD6dN16+cDBTvUq2qIS7aGNty9h5SV3wjua9GJzCnKNzfdboGEByFJdrOOStlFamV8PbYS8vardImZLPvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkcliAwKvaUgXrpefaSqQkUeF7pMtOLIDNytXIt3XPM=;
 b=GKr96rK4HHP9D8mtmFVw6h8ryIX5I4hg+JmutAhCIacUvFDUpAeGmY5zHFlVFpa6tqV8/kwZAE/4ukgZMRC/+nyp97F5TK0CoqoRDIK2JLxnXOfWYKvMmYquND+19WTQTuQnD8bIgSwIKivye+00tLkS+jk6/Xi/8AC85LGYwOc=
Received: from CH2PR18CA0049.namprd18.prod.outlook.com (2603:10b6:610:55::29)
 by LV2PR12MB999095.namprd12.prod.outlook.com (2603:10b6:408:353::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 19:04:14 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:55:cafe::39) by CH2PR18CA0049.outlook.office365.com
 (2603:10b6:610:55::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 19:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Tue, 7 Jul 2026 19:04:13 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 14:04:09 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH] perf vendor events amd: Reintroduce deprecated Zen 5 core events
Date: Wed, 8 Jul 2026 00:34:01 +0530
Message-ID: <20260707190401.1427329-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|LV2PR12MB999095:EE_
X-MS-Office365-Filtering-Correlation-Id: 652d5b8e-19ba-4406-2ba0-08dedc5a892b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|7416014|11063799006|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	UyQyt6xAuoPa2V+mZBkU5ZjRpSLVqOJyeetOLR2Iz38xE6MjSKtzdc8yb9PWgSyT1ujy8C7hl+z7dkOxLyZGIKeUw/BEssT/bslUBbow0LG3j2ByWnG07V4DcvgDUVjYnvzuafrt+V1cZuG8DJ1wBArMqPnpOoYIh0e/PpkKADhYnrSO+iDFjPa5xvZ1895RZ3V1RQIxPbe9ea9jyT7CDFPvsXVwixYhVkLkr/nSX76QHDoLEP+SDSco0hyGvshIqt1VINr9jf3QzvPaJvko4YViSAlFrjrx0YBYhUn/cg450LGKKKItGkpGXBtM8dHMuTRRMnK2ZgIvM2r9YNfZrsTgU4X6n6CqOl9EYygTx2XRbvy5CRdMG0aC9T1SHOs8dt5rWTbNa4TeKJ2ZHgpDaLY+uZZdMk4+xWOfPcwNklXfEAbUAdQDgYn90JvLm3MbpSGLuzdGHYUcoHyE9kuVANBLqiUMftWm/ujMf+V0KF1xklAlfXo6bw1vzdRsQX6zHWvgBOjOm6SMHSZWDZCarYCsJhXwpEPSkDlYcUtTxBvfkRZGKnHoDSmDWH9md/KM6RViN/Vxd1juLBI0oAk1dGVDq8W5d8VhV1VEO1nHq9fZ0ZEZcmLwN5+ETaxy/XjC0mYWPKHAxOSAeOKFN5Esg/TKy+7s0UdmLiyvgKIiR13fYm1DviITA7moBbe+uGRgRV/wpsAb8dFhXR83YKqA/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(7416014)(11063799006)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jKAwuKwEFvSHEdSkCyXuouNriu2ZGF7s1QFWdm4rvaMyajQAWz9ZPZSgOnR2rNEY3gI+MdjL5LjhbccYzdhz2rjkNlvkCW2x3DbkAcF+ZS3+P5Oa3tG87wB6wbjGhV/56cN0Cef9jet6OjlXwtDY0n+E+CrL3b5rnGaggu3GP56FQBFlamkPbmuNNO9iirPkWZUDs/sZywWvURsmGqiIiPNKaxIix7TiHTAN5Vr1dQ9CL6vUDcR1a1QTLpITCsK+qB30R2LL8uu4Cqy5u3sFSMZrCYlsHcXW8y+jnzHgINRXcKorZwGUzNB/M+c8db7VcWwKc1guQXTeNns7nXlFzk3Ab+nbuOKfgGXQFAcxyTfuaXAwxz9v+Ri8SZp3iGhZ/3X2cSWk30Wnegy27/DwiUc/2dLuClypwb7KWiGr4n1+hVtSZq9ucAJTHzOfF2ZB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 19:04:13.9352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652d5b8e-19ba-4406-2ba0-08dedc5a892b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999095

Maintain backward compatibility by reintroducing the events that were
previously removed by commit 047979af3bf6 ("perf vendor events amd:
Update Zen 5 core events"). Also set the deprecated flag and update
the descriptions to point users to the correct alternative.

Reported-by: Ian Rogers <irogers@google.com>
Closes: https://lore.kernel.org/all/CAP-5=fV_czvd-z4N7K+_SabxuOm9UUHRyBxNuchrtAgJL3OqOw@mail.gmail.com/
Fixes: 047979af3bf6 ("perf vendor events amd: Update Zen 5 core events")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen5/floating-point.json      | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
index 569975b53cc3..50d38434f8d3 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
@@ -383,6 +383,13 @@
     "BriefDescription": "Retired MMX integer VNNI ops.",
     "UMask": "0x0c"
   },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_pack",
+    "EventCode": "0x0b",
+    "BriefDescription": "This event is deprecated. Refer to new event sse_avx_ops_retired.mmx_vnni",
+    "Deprecated": "1",
+    "UMask": "0x0c"
+  },
   {
     "EventName": "sse_avx_ops_retired.mmx_logical",
     "EventCode": "0x0b",
@@ -449,6 +456,13 @@
     "BriefDescription": "Retired SSE and AVX integer convert or pack ops.",
     "UMask": "0x80"
   },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_clm",
+    "EventCode": "0x0b",
+    "BriefDescription": "This event is deprecated. Refer to new event sse_avx_ops_retired.sse_avx_cvt",
+    "Deprecated": "1",
+    "UMask": "0x80"
+  },
   {
     "EventName": "sse_avx_ops_retired.sse_avx_shift",
     "EventCode": "0x0b",
@@ -473,6 +487,13 @@
     "BriefDescription": "Retired SSE and AVX integer VNNI ops.",
     "UMask": "0xc0"
   },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_pack",
+    "EventCode": "0x0b",
+    "BriefDescription": "This event is deprecated. Refer to new event sse_avx_ops_retired.sse_avx_vnni",
+    "Deprecated": "1",
+    "UMask": "0xc0"
+  },
   {
     "EventName": "sse_avx_ops_retired.sse_avx_logical",
     "EventCode": "0x0b",
@@ -731,6 +752,13 @@
     "BriefDescription": "Retired 128-bit packed integer convert or pack ops.",
     "UMask": "0x08"
   },
+  {
+    "EventName": "packed_int_op_type.int128_clm",
+    "EventCode": "0x0d",
+    "BriefDescription": "This event is deprecated. Refer to new event packed_int_op_type.int128_cvt",
+    "Deprecated": "1",
+    "UMask": "0x08"
+  },
   {
     "EventName": "packed_int_op_type.int128_shift",
     "EventCode": "0x0d",
@@ -755,6 +783,13 @@
     "BriefDescription": "Retired 128-bit packed integer VNNI ops.",
     "UMask": "0x0c"
   },
+  {
+    "EventName": "packed_int_op_type.int128_pack",
+    "EventCode": "0x0d",
+    "BriefDescription": "This event is deprecated. Refer to new event packed_int_op_type.int128_vnni",
+    "Deprecated": "1",
+    "UMask": "0x0c"
+  },
   {
     "EventName": "packed_int_op_type.int128_logical",
     "EventCode": "0x0d",
@@ -845,6 +880,13 @@
     "BriefDescription": "Retired 256-bit packed integer VNNI ops.",
     "UMask": "0xc0"
   },
+  {
+    "EventName": "packed_int_op_type.int256_pack",
+    "EventCode": "0x0d",
+    "BriefDescription": "This event is deprecated. Refer to new event packed_int_op_type.int256_vnni",
+    "Deprecated": "1",
+    "UMask": "0xc0"
+  },
   {
     "EventName": "packed_int_op_type.int256_logical",
     "EventCode": "0x0d",
-- 
2.53.0

