Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366BD38BDA0;
	Thu,  8 Jan 2026 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858841; cv=fail; b=psDJUk/DEvsNtOWYkytoTBuC5v0pNUumiV96ebIk8mmVvR1canb87DuhRclEY+BH932SitOTM7yUXWyvRBqc4muQpUETv0GteR2YNwAcDqVeraCoAKMI8C6qF0N14YSKPCcl9oIkti2moMirL9yn0JW2pe0XkRFqDR8g2K8VlD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858841; c=relaxed/simple;
	bh=B7juD7/mXSSY+AbpOTf1N0ZVD3ap2yKoiBv1jSKLpyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UT90fYIDxLG3uMu25k89WNrub8NT31ZmhF2mPdAhdRe4pFTosEDwZ0T/8Oi/AJBZaYafgrafiY+ASZLS7yRoGMKxAG4W4s86V74sjTfVszvHCSDohXs38xgV2ADFzv4w1BPsKSxhXgnfNRmtapiWAd7Ycv9GezKNSa2qhljftwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HdCGeBxG; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HdCGeBxG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNfONvoX5TLV4C9sUVIk4dIXmIC/NE+6ejGeFUzLS8gMsWhVHDUZQdiUinEciXM4dMF4PZgoz/4msER7z852ilP6mpW2b1ebMHqBy9DK+Bv26t0tfZ/lMAqZd16D9Gx/uFfkqNEP4mJmXAhat3EjuNyxURWFiKQknxoKa6fHPd+7qJldnye+VEEQOvT24V2tZuUNdYFF7WT51VCQFgM7BPVJEMcBWl12NNycK0Z31E7iWjXCd8AxD45JmIm/ky0RoQOSZKgfZ5uSF65LVsjweEHpr2IwXMUtpEgygaQeJFLiI944FrYlzghH6F6MUyviBdCYEvMZ4A+4xwRz3SjvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ED8HA3VNF3PymooY5TaUEImem+3zsI0DSoczZoiCTM=;
 b=mLQrYzKJEceIR0cTUiWu5B5bkJT2QlPYvlwcIMMrIkDZqB4DcKUNsU4sCotehvv6HbCmuBej0HSFw5GYxi+z6AR3aPDRE0Rk9ivSrvdLiU9RM1M0Bey+3/6jbwwhMiadahtZrs8du21Qe2gdLkYfAwubs4XLSQO/B45bzIPiShR9lkbWGNJjGKBA/PXavQbzaLeKu8WigLaw6FL+tbAvP2eT45ZIOBAiy4vAfZX+kicdCHU8TwPnzj3Ji1jCaG7t4wncs/3QJ38LtzZYVKqpKY5/SU+N3kKVSuMDqZfMtnEDumhMNMrGzhfA0LAuDmoJmvEbUXUvA4PL/6hkH7eROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ED8HA3VNF3PymooY5TaUEImem+3zsI0DSoczZoiCTM=;
 b=HdCGeBxGfd6ST10iYqdaU9xTbA7aGcP6l1J7yreuThb6wcck5M/GKn7WzEi0W48Ku7Tbr6mSO0A6+HTFudahp6ax92O3LK1MpZ6+5BWz1njgTLAnvBHAx+1fzteSZ6GvK3JWyFO1SzAj9+pvUFl0cN2CNTDOFH5ZX2gi7lyc7wU=
Received: from BYAPR02CA0008.namprd02.prod.outlook.com (2603:10b6:a02:ee::21)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:53:42 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::68) by BYAPR02CA0008.outlook.office365.com
 (2603:10b6:a02:ee::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Thu, 8
 Jan 2026 07:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 07:53:42 +0000
Received: from sindhu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 01:53:35 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>, Stephane Eranian
	<eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 4/4] perf vendor events amd: Add Zen 6 mapping
Date: Thu, 8 Jan 2026 13:22:17 +0530
Message-ID: <d1dab14be54bf1a72ac518655583e7e440671b48.1767858676.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1767858676.git.sandipan.das@amd.com>
References: <cover.1767858676.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: f666de37-8970-4bec-2dc7-08de4e8b0ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlmlJqkil7OB5tsk+90/zh7ymjXxH8wSw4iGNXOEQv+a3U3a+XsjlhqUHuMp?=
 =?us-ascii?Q?CoxjGK2X+w2mpuptjymKnSg7xt+iLtlQQp1s4yaYbqEMf0VzRVOVq4Fm3mzh?=
 =?us-ascii?Q?Yy/pmpCkJhCcnjZvTSzixIwKmkqxdOfcrubmy7oEwoZiGG0GiSCpgxaBV+53?=
 =?us-ascii?Q?xHf1lNaa3yMcJAE2G4vKpG4d7gx+6j6zcvxORvRMqQI4LU4wABgVVsImR7Jf?=
 =?us-ascii?Q?amCHoD78BtwhDj4soDJb2YhzBEz8Ms3N5wmGFkSoQdm8IHiqrAPKb9GvVVyU?=
 =?us-ascii?Q?ilIzSggtDV5YHJWAXwlBNiMIH7gydNAOzeyzDSspmTg3Fg1gyZ6X+qZ/9M+G?=
 =?us-ascii?Q?NgZ/O6iPhID/z+wMqYdvK5PNSg2y0/FaulyD7X867lHgcQMuw6pt83UnuDHi?=
 =?us-ascii?Q?rOMoqzAGhPiOjXmkDcMtEHeoXku+PIxvxxxlRJ0VXrEm5aN3/eqcBWEkZxNm?=
 =?us-ascii?Q?y69BwPgtDuniESITaA1Zjyf05M4F9twH1tHIR7mMeMHDoHCtvsCBHEJ5E2BC?=
 =?us-ascii?Q?7jskJ+LydBiZ3c5Ktq6PPQQyeRT4ipSDpFXMh/i3roiGfB/jF7KB+6PR2oUz?=
 =?us-ascii?Q?4VGVWg9/xwtgLG6Fs7OpgIy2UaRh7B8kSPuRNFJj+b+GguPN6rckVFHq0jOC?=
 =?us-ascii?Q?XcIU7vS2xGsRl1Qk1TU6/9j7s8PlnYOwlsbgQM0shP1NYK/PydVPaRtAmGNs?=
 =?us-ascii?Q?tzXiOMrAcuwGlW1nQUoo8z9I/vknctF2voRkZbPo7IhqOee9fFyTdtPBlwJp?=
 =?us-ascii?Q?Q5YPckMTkPGOqj3UnpaWxjPUn2aiHwBQ8qnbnEOZPf8Cx8RiKC/17nDBjMkq?=
 =?us-ascii?Q?8VCh9YxU8j2nbNP8aioy3VT/PmA+6DcA2LLt5Kp7TCeRkc6qpxvXjLUKpVOA?=
 =?us-ascii?Q?qlmTTFnZ/4T6bC25dp/DjWqZZcmRBHH+0WJ1fy20VSOOYW5SwHQVhP73cn2i?=
 =?us-ascii?Q?uuTTHtKkljhE9s6MVJ6oRJ7fEZyMAN2mVtZfuzZ3Atdajfp8rdFCjPHKfovg?=
 =?us-ascii?Q?nHPxiRc46UElQ1my92ue6lCht/iguydYC5niuzKP4YPiHEVHUNgGqORdh7a/?=
 =?us-ascii?Q?SSdspxOjEZZxxTbQOjhP2tYbtv7YlmlvV7cKRTNca4ACrLEYOQn+kwa3E3pO?=
 =?us-ascii?Q?5rQkq4Md0Zt0HH2gz68YXZ5cnIlCYU6ZyzLIJyVT2WBA4yrbBua565N7TnNL?=
 =?us-ascii?Q?FndYi3hOeTskpBj6l1iVg62Ur+/9CX0fKucbVJDeZEvoSPu4out4Vnqtd01i?=
 =?us-ascii?Q?+nR/dFSl3HCSuvq5JtGohOxtnVu2fdn0n//1rWxI5B7xWqX6aQnY7xDkLmDV?=
 =?us-ascii?Q?omfMQTL3wegAJaeFN5sall15dDcUdcp2NJAcP3lmi3EsfVlPSCa6Cke8qmFB?=
 =?us-ascii?Q?LiQDuNpCj9ae85dUdBXKBIU+VIZUXT0sWFws7CYLykC3edr3PAP4s29zVTS3?=
 =?us-ascii?Q?gwZ5QoeDH5S/fBpDfcGzq045myDxdGB9M6F5EbufLhevNC0jAYo48OkIF0/c?=
 =?us-ascii?Q?87hYE30OuEFR8QjOQ//mwWkI22CSLHlT/hb7g5dEVooD7cOmmWwQS3GWsRaj?=
 =?us-ascii?Q?iX7iQBV4ZsWI+GDk3kc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:53:42.1176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f666de37-8970-4bec-2dc7-08de4e8b0ace
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548

Add a regular expression in the map file so that appropriate JSON event
files are used for AMD Zen 6 processors. Restrict the regular expression
for AMD Zen 5 processors to known model ranges since they also belong to
Family 1Ah.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 3d0c57198056..149bbe7abaf5 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -43,4 +43,5 @@ AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
 AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
-AuthenticAMD-26-[[:xdigit:]]+,v1,amdzen5,core
+AuthenticAMD-26-([12467][[:xdigit:]]|[[:xdigit:]]),v1,amdzen5,core
+AuthenticAMD-26-[[:xdigit:]]+,v1,amdzen6,core
-- 
2.43.0

