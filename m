Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2938F255;
	Thu, 13 Aug 2026 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640568; cv=fail; b=ZV1aRfip1tGgLEKNIHd0NL6Iwh9jLSkJHTEWp7tmyJG9o2aoq39y5j8mTDGoGxJ/fxuyxROYjWEAwp1K9Zd4rT7TEGwQaCsGTCUfeIm25mbTg86t/5OdyxEO58soTKQRJORM03v4ZzscNPDOSsnqANx/yJP2soLZOpQEt8dFA8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640568; c=relaxed/simple;
	bh=eqw1IvFhu/4XvmZwjF1amKBcGaOX+YYRk1fkUbhXGZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNFiYEsnAwSz3fdPYE8Jj9HGHGw/HQP1q6RlZbxuELK1O+hOQGxa+SWik0rWAk/+5TsQTfSCtAhyBB2iGATy9GKKLrjOdYSww80dNMZPR2kzeCJfcY07ALxZIUWgE3sV1I8/G+ZUU3jPeK/22tm4ndfPEZz64+NI+GkYBr9o91Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d5qpBcyY; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d5qpBcyY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diEUeGY1EplqbRU6y/p9OfEokK/Wfb8wxIfUqTOHRzde2U2B/EWL4fpQa0Suuej54/FNMEu1fTxfnlP3U7i2r+AWx678s2QV90NQ9YyAymOspB6Sho96a9oTePe+NL/fM9W/lO+IoKdUAHGfpFv3yP2TegyDIBYoUpabItGHM8jNFcdvZ1NKL+XJzBlO/2zl3jAhnFUv3/1FZ9nrhGFBZebsB5X2Vlh8tULOjrFs9s19MUjx2HFpF+9et13PxJyU/wsfmxx0PFTeJZ+1lcvSf3K4vVxXk58Plz0+qVXG/wG/M1v/3qIrDTTwJqpNueB0YAYA8TIxwtih398cHBEaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0R61zjWUTurQMHCBx90mBngFiHKUFz6PlFvhbFHzjI=;
 b=VUBlH+qYXzXTcl7KuB84wVu1P3Wz+WDq3XLLB5l1v5SBdENI4YWCrUyPHoV93r0CIgwD2nFRrjii27Xzy1oZcBkaDDKlLiMzGrUqJ1l8ZrAcqIKDMFF05LOTauzxwStvICsKmQa15k66P+djI8pAl8bS6KS6+srfdncn2SSlHnO1VCIGa5ktauSHEDnWp/iL1zL0b4+cK3nEvOfoUNfzudayvQD5Tq7yTFO0dogy1MSHe46RaHSrFAB8VivuOderNut6mwzNcKJFLN4ycZxWibWUYQUoHMSnFG2k6KUItQ4O3HdPh53aBIk+SQBSNlUzGFie6Qd3aTmuF13elJSnZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0R61zjWUTurQMHCBx90mBngFiHKUFz6PlFvhbFHzjI=;
 b=d5qpBcyY+ytqn2dhL75a23aHIV4PkZjQX2tvpr9cvYFQ3R2Hy3osd6mx2GeGGQJsLK3NXVtGV5iJ66Y9sMO/fMv4wfMLbEXkMkS3YjcSU/9IDSsf1/amvBW4iKzDaiSSTpv9TjhIjVGV9y5ybQ3TH79yXBkeG8t4jjqlw5Qpbwl6vwalOsulNnwMBpi/K3mNxtvrOpiGrr5Zw2azMSZtDsavEmxIRQ8HQkJMLaJNiGIyOTid/WiFuzEjOBXaoI+aqVfvbDqlNndfF06usUrUvzBJt1OwqNH91kG20NP8/ofuN8CXmEx3xuteP2lBh0Z6iGfmFbAN5kahaTATQWMSuQ==
Received: from CH0PR03CA0037.namprd03.prod.outlook.com (2603:10b6:610:b3::12)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 17:02:33 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::40) by CH0PR03CA0037.outlook.office365.com
 (2603:10b6:610:b3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 17:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 17:02:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 10:02:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 13 Aug 2026 10:02:08 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 13 Aug 2026 10:02:08 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <john.g.garry@oracle.com>, <will@kernel.org>, <james.clark@linaro.org>,
	<mike.leach@linaro.org>, <leo.yan@linux.dev>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tmakin@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
	<skelley@nvidia.com>, <rajjoshi@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <mochs@nvidia.com>, <sauravsc@amazon.com>, "Besar
 Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH 2/2] perf vendor events arm64: Fix Tegra410 Olympus event 0x0197
Date: Thu, 13 Aug 2026 17:01:55 +0000
Message-ID: <20260813170155.1156593-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813170155.1156593-1-bwicaksono@nvidia.com>
References: <20260813170155.1156593-1-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef40ab9-6d35-4204-fb3e-08def95caafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|7416014|82310400026|921020|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LHlrfeku/6aqet3ly5Vi5ng13FCHpIQy5lG2WeZY1Q0nJSL2annLXV59rI+7A8k8E+S3q/4Sv0a0nji7AopQpHIX+aoEETgDCYNrzFwRgc349qtu3syQhfPiIE/Tz8n9qc4kZ6PYTzL7pZHEPx5NfCYcPpXPpL/M5u8FChV1CUby6EMvUZaK/EnLABKsc5Dg4RXF+Y7UUo/Ydku3t0coU1cxuzDcXQupy5vv1EhP2evNVQIQY29fWYO+C1XIDIePv8pTirrdtxyYjnhSgIdzRXF3VNWKoBjUzd75GMwM8Y7xeLBoFaJheJduT/dKpf5svpJZyIWht2668Ykmc1n/dnIGUCrPORbMroXvP0xivUAhOquUP9SuV9LWHyxvUqb7axlZMev2yuWybtOFrZAchsalV/URsfFAARz1kPJCPIkn7q/8D+WUSoYTymBHEjnX3CqWIZGnnbYwPIMgzDzQ8GS/kq8FcQPAaQ1iFPRNeUydXIUywvt/LdeqtvTQb4DmvRyBl4CPqiPd0V7ak4E6s1Vz3Tdn21wA4JsX5J5jxwRBzt2mb+TrUYbFcaXirWP8tktoXe0v1txZQKIuaOQp2Ij9TuNrYbxeZ38d7ZrDnCF+xnqvyKOFyoiu5A5SVzAcljDNavYm62lvQ17QhH0fV22zfZOjOl6xAWlR9K14Dz57tZlqx1LRNqMP0yPGXv4P7kA5K7WNfuMpEtDlWkSdZtMBmCh1D0JBJWlc2DS6Vc3k8E+6sPChDQdvx1waI+Uw
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(7416014)(82310400026)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vQjVy6RVu4cLW2zc5g08BRwg2nFxSy35pZrpKxVdJAbAIx1j+6IHfUr2zQf5pY3gD6hXjQXuh/MhmZO9T0AzGhpA5S+QUih/zgvZrNJJY2GzzZcs4lwaGM7zdfH/uXCNdRDjhGCCAPGVTTT93vZs0FbUIUElC3o+SbBuEPFZRf0XZHmkQRGQAyknA/CnYXoy0Sm8SyL6pf6V6bDlguIE3GQiH0W7djlXj7P5vbNT2uLRtTArdiGflyyv7Ddmr+Mn5f2vJKgwModUIdkEEqRSUr8laA8puzkzuVuWzB9I//G57srYQGRnhq/1kdKcvoTB2eUzBei0FwU9xb/sl4BzmDaxZgqyhZNk8FK3/cAHpOcYDuPdDbKOd14S5l6kaDYjGymNILBJ9+eTb0bDNbpxAQZSAcyCiZ2BIIvn1eu6xm/2jiJy8ijKFT8YVjK35gUT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:02:33.2772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef40ab9-6d35-4204-fb3e-08def95caafb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

The name and description for NVIDIA Tegra410 Olympus implementation-defined
event 0x0197 incorrectly indicate a TXREQ limit between one quarter and
one half. Correct them to describe a TXREQ limit below one half.

Fixes: 86ff690f45cc ("perf vendor events arm64: Add Tegra410 Olympus PMU events")
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json b/tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json
index 8ff87d844e52..e1b45cc33b18 100644
--- a/tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json
@@ -316,8 +316,8 @@
     },
     {
         "EventCode": "0x0197",
-        "EventName": "TXREQ_LIMIT_1QUARTER_CYCLES",
-        "PublicDescription": "Number of cycles in which the dynamic TXREQ limit is between 1/4 of the L2_TQ_SIZE and 1/2 of the L2_TQ_SIZE."
+        "EventName": "TXREQ_LIMIT_BELOW_HALF_CYCLES",
+        "PublicDescription": "Number of cycles in which the dynamic TXREQ limit is between 0 and 1/2 of the L2_TQ_SIZE."
     },
     {
         "EventCode": "0x019d",
@@ -517,7 +517,7 @@
     {
         "EventCode": "0x01cc",
         "EventName": "TXREQ_LIMIT_COUNT_CYCLES",
-        "PublicDescription": "This event increments by the dynamic TXREQ value, in each cycle.\nThis is a companion event of TXREQ_LIMIT_MAX_CYCLES, TXREQ_LIMIT_3QUARTER_CYCLES, TXREQ_LIMIT_HALF_CYCLES, and TXREQ_LIMIT_1QUARTER_CYCLES."
+        "PublicDescription": "This event increments by the dynamic TXREQ value, in each cycle.\nThis is a companion event of TXREQ_LIMIT_MAX_CYCLES, TXREQ_LIMIT_3QUARTER_CYCLES, TXREQ_LIMIT_HALF_CYCLES, and TXREQ_LIMIT_BELOW_HALF_CYCLES."
     },
     {
         "EventCode": "0x01ce",
-- 
2.43.0

