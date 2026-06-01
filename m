Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD33299A82;
	Mon,  1 Jun 2026 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330569; cv=fail; b=F32bXLBRp8VsB3lheFxA1Kln6p0++L99X3cGymlEuM6Bee87QjoxgyxSmt88s/aitVFZrNX6G6j2zWNDH/IGKsy92Pd+qesIhyMg9gD/kGOxiRZSqURPFbZr3XHCmW4AUm3SWzUM9EkYiNbUBgmPkNLeecc0tBY+DfDRUvAl5Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330569; c=relaxed/simple;
	bh=4ixolaSQjgTbEP1o44HotUbfYtyR4AMfhBfenQP+XQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p446Hd6v1LdQSI9h7hgTzg8PW0z1qiMDS0+PCkNFn+QD9/vgN6pY47fmGHje9hbJLD6EYBcI9/h8Y2M7iEJEQPLuaQMxz8YBZWo+Ftzkadt/o6vNkA47y7tUYcaXj3tp6zStz9Ak0EXoCJ30fYPT4CPtc0pxi1ffx5Qp0xwRVqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iF53zS2g; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iF53zS2g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aj69DxtjqZDyrLHBEkE+pyQsebcQr2ivojSSFRwz+cLJl8bs2Yw5ipl8JnWfUP4/VUHv7CdFLPxe2YS7KjPWzMIMsPiHAhZvWA8JkuGn+eBToUz7SwGNXuN7QUKieWl0CR5PwJ5GceLyy/kyeCdK0MRq95+L8wLnMC65GZXyR6Xl43JfmKbzjqnM2JaQjjhR+2QEwoHbGYJ8ZaXEVp0eAvsHsiUgeddHNSse61hbwo6FGSZJGJTXNGybt60Oy001+xqMqU1LOcXWONx8vpZa558vfzKUvjej8Iyz8RCfd5wohw7cdHcz/gLABIemgfUI1VICvcCTe+XW/ATY788yfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/oUl6CV3rcrTzzHTlU9+U/gWsYkVYR8qKvHOOWz7OY=;
 b=KlSRUbV+HwpxNMXddhNKoWXPbB87pn4HqQGWuRJWD2E52rktgEnlM3Mhj5ld6DD6f5rxwFsDd9oBz4NvJOut2TtmdIsM7REeMAY93l2nuF9hArNwIWSMLHV77t0du1jzsJSvPGzfhuji3rjMpeilrw5MHMp+7c3CVMfHm/zfY8hP5xGDcK5nP09GpMNkqo7GwUU676tTUqyW1do919LokX0P169A2chpwDEFQZkAGB6klxRRsgHUPK28SF/CJflRBNtn9O3qS84fTpUznwXoIlUWvT7Bcar9/YEDqPgLBAmA8N+wx/YHO86pOMRyKLdevMGnVSyCw03TL4QBF0pijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/oUl6CV3rcrTzzHTlU9+U/gWsYkVYR8qKvHOOWz7OY=;
 b=iF53zS2g2R5HRl8r7BN0oK2Dv5a/3S/zZThZWTsoytG7+njx/DyStDLuyifrFuLreOeB54mRjtf8k1cUheGBSV4F0T1N+RGZaoopYrj6COFD2jgON9TckvBCsCznrtmqaGi0QcNKy4SFPxa7foTiANuJUwA2syYSPRZJcRujPQI=
Received: from SA9P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::8) by
 DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 16:15:59 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::a5) by SA9P221CA0003.outlook.office365.com
 (2603:10b6:806:25::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 16:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 16:15:59 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 11:15:54 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 1/2] perf vendor events amd: Update Zen 5 core events
Date: Mon, 1 Jun 2026 21:45:45 +0530
Message-ID: <f16d1391366762dee0d49f00697f5e6ea913e2c1.1780330378.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fc96f8-34f9-475a-fb78-08debff91144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|56012099006|3023799007|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	+/p21kxtAr3F2ppG2mwzc6G96JCD4LJZMqBwtunSW1YIMmJU9LqUMksBPBCMO1Uj6LfigIhCL5spixDcHxTV1gSM+pxAbrLETeT3Ffh27nyVSg56wtQVgn1cfCRdQs4HCxDW6w9U7wnQ4t+7kyiNpR0fKDDroFAujuEBXNmY0R1Eq8XILehuJDsjbL/tLvqtf7iW9x9ibF/YonDzRWPDV7+23cg5Ji/UZ+x5CLPs53lhdf8ChK55CNbKYRSvyC4lrb8SA0LuQnrc8bmrQJyggl0E4+gPWtcHulOWKvjqgpR27TIyAkWmECs797dH8ZuI7DInyv5r6byWkbdxk5ye4DTxcWVspthCrnGyQw6JWCVjzDw31kIIZtghQ8H4Is+BARuJZ+UMqbicLcBvF6jubvETV2W40jWWmiNrgBs93zbP9PyVtyrG7l54herdIy/PczpN7y/OZ1C6gmjH+7gMrhnYyrYGle+b4QFivGQIlrUaRoGglrj8nJs8vsyUFUJBexnDiL3B+QpIrxyLnEAx1TUEm+4+umpFApCW8jUhxwe7cYb6AOHW9xFtDR4s69icFVabvBsXacq0vPcPakiAa2WeT3oHrr5jhmTJG2tBtokAQ6Ti8t8PAAHhjx30Pe+fTdK2CXzRfWyCETXSmOO1iK//nI3AVZRtOJClCyMriilVDjJDHQr+5O+eo2n93BKKZIqthupbOCzPpR0aKeTMVjvR5tctjwlgzMQIm8yUkQw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(56012099006)(3023799007)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tv3hyNdia7rA7/6C3D1pMyetReiURAujqSrtiVDtZjPdnGDkvFoNq/wOKDh2EyOdwiO5dO7GLYxazs3XjyqHq1swxUIBCss7h7ls0Ric1cf0wJxczMaFQ8d/Vk5356tMgaKqGZI7msxlrL0ccOsxdBiHrCarART181Yul2/FS/yw5Qxt8YDsCPxa1nG9V9kd0vuU4mPmMLwqcivQuVAhXH4bFGM/8QMoYgWUt7A+UwNTpAsRHZEi6kw4MqyZsglRbb5eIGuoG7AS+/WXdkTugnZDlnhU8QkFRS9TFH3WWTuQapJ26fy0vTllOwkMCFvCftXZcMtVR/ecOxXWTKjFxkGB2RFOLUPRi2rLxhccRk37/GYvtf6/tiyCbMzVEAOchAhW385pedD8PSuFkl74GP3apeRTY+/PaNsBWMt9dTIebSb9LE9SjVNBf8iV3Xf3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 16:15:59.0049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fc96f8-34f9-475a-fb78-08debff91144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

Update definitions for the following events.
  * PMCx00A - Add missing unit masks
  * PMCx00B - Add missing unit masks and fix descriptions
  * PMCx00C - Add missing unit masks
  * PMCx00D - Add missing unit masks
  * PMCx025 - Add missing unit masks and fix descriptions

Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen5/floating-point.json      | 130 +++++++++++++++---
 .../arch/x86/amdzen5/load-store.json          |   8 +-
 2 files changed, 120 insertions(+), 18 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
index 9204bfb1d69e..39bd720f9541 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
@@ -179,6 +179,30 @@
     "BriefDescription": "Retired scalar floating-point blend ops.",
     "UMask": "0x09"
   },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_mov",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point MOV ops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_shuffle",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_bfloat",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point bfloat ops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_logical",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point move ops.",
+    "UMask": "0x0d"
+  },
   {
     "EventName": "fp_ops_retired_by_type.scalar_other",
     "EventCode": "0x0a",
@@ -245,12 +269,24 @@
     "BriefDescription": "Retired vector floating-point blend ops.",
     "UMask": "0x90"
   },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_mov",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point MOV ops.",
+    "UMask": "0xa0"
+  },
   {
     "EventName": "fp_ops_retired_by_type.vector_shuffle",
     "EventCode": "0x0a",
     "BriefDescription": "Retired vector floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
     "UMask": "0xb0"
   },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_bfloat",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point bfloat ops.",
+    "UMask": "0xc0"
+  },
   {
     "EventName": "fp_ops_retired_by_type.vector_logical",
     "EventCode": "0x0a",
@@ -278,7 +314,7 @@
   {
     "EventName": "sse_avx_ops_retired.mmx_add",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired MMX integer add.",
+    "BriefDescription": "Retired MMX integer add ops.",
     "UMask": "0x01"
   },
   {
@@ -299,16 +335,34 @@
     "BriefDescription": "Retired MMX integer multiply-accumulate ops.",
     "UMask": "0x04"
   },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_aes",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer AES ops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_sha",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer SHA ops.",
+    "UMask": "0x06"
+  },
   {
     "EventName": "sse_avx_ops_retired.mmx_cmp",
     "EventCode": "0x0b",
     "BriefDescription": "Retired MMX integer compare ops.",
     "UMask": "0x07"
   },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_cvt",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer convert or pack ops.",
+    "UMask": "0x08"
+  },
   {
     "EventName": "sse_avx_ops_retired.mmx_shift",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired MMX integer shift ops.",
+    "BriefDescription": "Retired MMX integer shift or rotate ops.",
     "UMask": "0x09"
   },
   {
@@ -324,9 +378,9 @@
     "UMask": "0x0b"
   },
   {
-    "EventName": "sse_avx_ops_retired.mmx_pack",
+    "EventName": "sse_avx_ops_retired.mmx_vnni",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired MMX integer pack ops.",
+    "BriefDescription": "Retired MMX integer VNNI ops.",
     "UMask": "0x0c"
   },
   {
@@ -390,15 +444,15 @@
     "UMask": "0x70"
   },
   {
-    "EventName": "sse_avx_ops_retired.sse_avx_clm",
+    "EventName": "sse_avx_ops_retired.sse_avx_cvt",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired SSE and AVX integer CLM ops.",
+    "BriefDescription": "Retired SSE and AVX integer convert or pack ops.",
     "UMask": "0x80"
   },
   {
     "EventName": "sse_avx_ops_retired.sse_avx_shift",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired SSE and AVX integer shift ops.",
+    "BriefDescription": "Retired SSE and AVX integer shift or rotate ops.",
     "UMask": "0x90"
   },
   {
@@ -414,9 +468,9 @@
     "UMask": "0xb0"
   },
   {
-    "EventName": "sse_avx_ops_retired.sse_avx_pack",
+    "EventName": "sse_avx_ops_retired.sse_avx_vnni",
     "EventCode": "0x0b",
-    "BriefDescription": "Retired SSE and AVX integer pack ops.",
+    "BriefDescription": "Retired SSE and AVX integer VNNI ops.",
     "UMask": "0xc0"
   },
   {
@@ -497,12 +551,24 @@
     "BriefDescription": "Retired 128-bit packed floating-point blend ops.",
     "UMask": "0x09"
   },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_mov",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point MOV ops.",
+    "UMask": "0x0a"
+  },
   {
     "EventName": "fp_pack_ops_retired.fp128_shuffle",
     "EventCode": "0x0c",
     "BriefDescription": "Retired 128-bit packed floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
     "UMask": "0x0b"
   },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_bfloat",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point bfloat ops.",
+    "UMask": "0x0c"
+  },
   {
     "EventName": "fp_pack_ops_retired.fp128_logical",
     "EventCode": "0x0c",
@@ -575,12 +641,24 @@
     "BriefDescription": "Retired 256-bit packed floating-point blend ops.",
     "UMask": "0x90"
   },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_mov",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point MOV ops.",
+    "UMask": "0xa0"
+  },
   {
     "EventName": "fp_pack_ops_retired.fp256_shuffle",
     "EventCode": "0x0c",
     "BriefDescription": "Retired 256-bit packed floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
     "UMask": "0xb0"
   },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_bfloat",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point bfloat ops.",
+    "UMask": "0xc0"
+  },
   {
     "EventName": "fp_pack_ops_retired.fp256_logical",
     "EventCode": "0x0c",
@@ -648,15 +726,15 @@
     "UMask": "0x07"
   },
   {
-    "EventName": "packed_int_op_type.int128_clm",
+    "EventName": "packed_int_op_type.int128_cvt",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 128-bit packed integer CLM ops.",
+    "BriefDescription": "Retired 128-bit packed integer convert or pack ops.",
     "UMask": "0x08"
   },
   {
     "EventName": "packed_int_op_type.int128_shift",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 128-bit packed integer shift ops.",
+    "BriefDescription": "Retired 128-bit packed integer shift or rotate ops.",
     "UMask": "0x09"
   },
   {
@@ -672,9 +750,9 @@
     "UMask": "0x0b"
   },
   {
-    "EventName": "packed_int_op_type.int128_pack",
+    "EventName": "packed_int_op_type.int128_vnni",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 128-bit packed integer pack ops.",
+    "BriefDescription": "Retired 128-bit packed integer VNNI ops.",
     "UMask": "0x0c"
   },
   {
@@ -719,16 +797,34 @@
     "BriefDescription": "Retired 256-bit packed integer multiply-accumulate ops.",
     "UMask": "0x40"
   },
+  {
+    "EventName": "packed_int_op_type.int256_aes",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer AES ops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_sha",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer SHA ops.",
+    "UMask": "0x60"
+  },
   {
     "EventName": "packed_int_op_type.int256_cmp",
     "EventCode": "0x0d",
     "BriefDescription": "Retired 256-bit packed integer compare ops.",
     "UMask": "0x70"
   },
+  {
+    "EventName": "packed_int_op_type.int256_cvt",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer convert or pack ops.",
+    "UMask": "0x80"
+  },
   {
     "EventName": "packed_int_op_type.int256_shift",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 256-bit packed integer shift ops.",
+    "BriefDescription": "Retired 256-bit packed integer shift or rotate ops.",
     "UMask": "0x90"
   },
   {
@@ -744,9 +840,9 @@
     "UMask": "0xb0"
   },
   {
-    "EventName": "packed_int_op_type.int256_pack",
+    "EventName": "packed_int_op_type.int256_vnni",
     "EventCode": "0x0d",
-    "BriefDescription": "Retired 256-bit packed integer pack ops.",
+    "BriefDescription": "Retired 256-bit packed integer VNNI ops.",
     "UMask": "0xc0"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
index 06bbaea15925..b1994539ece8 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
@@ -8,9 +8,15 @@
   {
     "EventName": "ls_locks.bus_lock",
     "EventCode": "0x25",
-    "BriefDescription": "Retired Lock instructions which caused a bus lock.",
+    "BriefDescription": "Retired lock instructions which caused a bus lock.",
     "UMask": "0x01"
   },
+  {
+    "EventName": "ls_locks.all",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions of all types.",
+    "UMask": "0x1f"
+  },
   {
     "EventName": "ls_ret_cl_flush",
     "EventCode": "0x26",
-- 
2.53.0

