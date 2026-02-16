Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA62BE7D1;
	Mon, 16 Feb 2026 04:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215771; cv=fail; b=jHBog6hSRNlNFypinZVcnuWkjnFktCqqXmiBH2ZTW6MYwqJAo0o3Mb5HozEUwQ72guY2uWcHEhTy4tv6IngQtpunZa7aIub7enk7hPDuAjhQGZdOK9oqagh0Q0iX3tKYHHN5RqV/ewt4koUpnUmvsoUrt8naxIqOOh4ZE+jzGyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215771; c=relaxed/simple;
	bh=QqlBHW2blcLrPuqNILJ+qISYouUg16orV21Q5qXe+QI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjrEhC8pIVUoDfPCr0zK0xirCpgRKU4Afu9uhV5sYZpKVkNi5f2UHPcy01ZSVExG0trhic0OKLfYURQXKraOfN/Qij7PyEmamCUa5ha5IPyDKWtFlxw+U6acOEVv5FTMWZMnzb597bwkJmJG3SYfA3nPiPrOSoSJbF2AN7gAEXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cmzuK58I; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cmzuK58I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8QHRJkWBMfocqWh/VNHcBDYBX2nCBOMV5Wf9SlpBnHX/6Ai69z+MBK0X93Oe26MnQdiAFv137hwzIL9LzKLBGbRGWeCViZOKaGzREuejSI20Ko1uCO4Dsh3Zph/hTSDeXIkAHgRq8ql2VobXj65zUmquHIdLTckoBBhPUNx/7908vrxlPGJQ1oXuzKi6bxpe/zsI/3q96EygZsHBOCwOWHjCdfKdprlFGa2xEr1VFRCp536wu//I1VeaP84hNNuZSirKbx1UtMk92iRs4YN2wFc+5exVM3IIxMkX53niGHlxiL+rI4gFq45Dx+50pThCDObd1WAY/NCrcgkuIWV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF0C56kEAfAr8Zc3lQ0Gql565m3CDv3VFmgi3+lHlnw=;
 b=w1YhqsWm/rf9vez4TT4nE0T2lW3xDHVlmIbgVxHhnNSa7gcgLKaKnyV8tVCQcfOYtJzIcjeJLV/muzRpxZ6kPm0opGZWG0dXlcmn9orzWa00woIQY3maiwZWQ1OwMgjvF1nWZjkVgwCreIvYK3DqycykMDnhekEe6Ct8+9/SRGjXemFPogWVPWqbO+GeTmieDXnHA4Il/07fbsin0yrvRixGbAA4nesBK1gnFZdi366CA6vuG2Rlm9zX96pjDI52iNCnrX2+bb/aZCNwRb1MbzbBY4wup1ugrlvP8/C0dNSmghsQM94MGCE8gYaeU1HJSkM+4v+90GhbT5jgyaOrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF0C56kEAfAr8Zc3lQ0Gql565m3CDv3VFmgi3+lHlnw=;
 b=cmzuK58IRC/s9w3fVIaIUqXNN3O5Gr39CysrJGkBcBKlbJkXash8qnVd3eJafsJJdagszWsoyA75cDEvCvFavJDUNvHsqde+3p8sQv2wEbfNqLsAEHKZ2MV3tNmQ5lX/VZKISaSVdVlemitfAHopMvzhjxHrLdxf+GN3a0T1rOA=
Received: from BY3PR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:39b::15)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:22:46 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::a2) by BY3PR05CA0040.outlook.office365.com
 (2603:10b6:a03:39b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 04:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:22:46 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:22:41 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 2/5] perf/amd/ibs: Limit ldlat->l3missonly dependency to Zen5
Date: Mon, 16 Feb 2026 04:22:13 +0000
Message-ID: <20260216042216.1440-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216042216.1440-1-ravi.bangoria@amd.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6a68cf-941e-4ba5-3885-08de6d130951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bNlBR44481ucrBGBMn6hbwXpoOBE+7Vdq02TAnzbNDnrwPhV47DRoCOlrlOq?=
 =?us-ascii?Q?1OwSXAJx23Kkf+j4NipE5AUSzsHCTMlyfoQwZXwYDCBz2EKpNxhPsd1p/O8z?=
 =?us-ascii?Q?I4h+9TTosEGF8Q6VTNHjPCMYhBiPs1nvoJbA9NHmE+KU8o117BNJzdVCKYL2?=
 =?us-ascii?Q?m7VbawRJiAcQdf4NrNrCGJcTh8xNg3zKCKdTjJqL9C56eMzgQe84CryY+3kZ?=
 =?us-ascii?Q?2guFIRVbyz65F5mnW5kTc20vFS1BZIFwH0ao7UgrkjnQ96TIJtDV0m4Dj0UO?=
 =?us-ascii?Q?td6O3QKrtto5ZfFq42dZWAyWds3Ej/4xeEkTHcEJtfTPIZDPO6JENPuUdmaV?=
 =?us-ascii?Q?m0Trdq+cNmvHXytLmuwg6wQVh3bCES+d6Kkka/evvOahO4nO5FujJ7uB8J18?=
 =?us-ascii?Q?lIL7oG6vuq8rP4H2PSu4rXhwT03bMlBvT5QqHM8BWwOQNeM4zM4qwHB3rXy9?=
 =?us-ascii?Q?nhK+cM/ubjnPt729frs5IZz5+DbpFkVGkj604SK8pyFUxEYbsXur6VrTBMap?=
 =?us-ascii?Q?6zULhyeU0ILwifIRNoyl3FFrfqNdZdAznCxM8OwYfsuPluSxfxcOotPR9mwD?=
 =?us-ascii?Q?5SqCXXQXDPpjYUEQ+kEfzLfcnhxErSW2xjBbj6ViPUfO6Kgp92WDfFVZ5jMj?=
 =?us-ascii?Q?U95af6bwivJKk40c/4oZhVUocNOovgCm51XZqPCFP5GNF6tvFgyx0OFgCE8p?=
 =?us-ascii?Q?g56cYHYfKZDgkMY7Oktrx0V0cLhpB2BaDELeDur8d93vE8k1p928bQn/uU6O?=
 =?us-ascii?Q?HBHYrlSqwqPjUy1NLH0XnRjS26JwtSPY8gPMPxc2d38nc/WfW9BvfCYxYJnF?=
 =?us-ascii?Q?sbRfhY0z8seTdGhfTxpZzS6RL5IF2Fk5rE+LHcK+JO95jnG/1TMnHKyhqyPT?=
 =?us-ascii?Q?YH6EBZo+3ZNqfTMi9s7OCromAMI/iCFfovYV+dmLWsPTsy5diuVsWVyQeJtJ?=
 =?us-ascii?Q?2Ip84E/hBPvSZntb5Q9UebGGk9GFDiHwxiijhSr6QsJW0jmDSuF0mFnyvfAS?=
 =?us-ascii?Q?78SQUrmCqvOvv6P8JmY1EtoOdgKEaSTe2ptc+6L2Z8Ie/O/dz/JQpjFUMJL+?=
 =?us-ascii?Q?bO7zkepdJ2ptzIZVo5OSftDqiWhE2vD3RghJT9uKnzSBN2NIKLsIRm4t3gDu?=
 =?us-ascii?Q?H+2SF/3NGy46EJKYHI9BCAgOU9HqTjvmW+MCf8YaSduZBrqbEizg73p14h1g?=
 =?us-ascii?Q?yeQeu7ud0CU4pZjfyTwN+eAdf5HcBqKSBULbMqBFio3kBE7P3Dg6TmN7poU/?=
 =?us-ascii?Q?15bLkUOlRXsjCFl4FIU8FjXgCEB5hl+XojoKvvWi75fM5wAvaNxjmJiriWj8?=
 =?us-ascii?Q?VXjuPdWK8G5ItEi7VsDl9NyPEGG5gcq1v52eJSjzkaC19F7evHTrJHjVfegQ?=
 =?us-ascii?Q?TFe2EBoo+PNDXwO5gzvVcJPA7J+ld3qgv9rP8+yllVWJmggQqHRNwH+BjQSD?=
 =?us-ascii?Q?xnCN/rWnZAQH/Evufjaw7E7ZMwYpDQR6Uk4ETjcZoc92RkZWOJ/9siL6ULYw?=
 =?us-ascii?Q?SpUeb7X7x8dijPYwqjQD0nOJrCMfk6u7ujzGGnAtrieAU2WfOIDNKsGKAGOY?=
 =?us-ascii?Q?FM5rohltlIF7knIapASuXHbL71m+N0ep8eGt6JI1uS2HM9VT06au0nBk3PlL?=
 =?us-ascii?Q?6L+Gw8vlTdqrj9FQ5wEobWWS1nxC8vw1E3iUA9BY31vi/MkbPCxgpW76m76V?=
 =?us-ascii?Q?dWh2NA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0aUp5kM8GPjSIN/o2x1FGfGDbzxCQ49FiICIpdrLOlUfWSvmQsPwBu9vZb9cdyjwh9MzwskMu3lXzeZxXlZ3mC9E/TpfeaCRsTxA1melrLeG8dVUltpVl8fsdr107uP5qHzfQpsKBOXIUSg8xq5LCB42K3pcFSwNSLncauCXzJLP+etUfIwgh96nggYalWkgU7QGQtSUfJYK81cImOSzT/Q7Bi17cSYp0OlcfA95Do4rLYHeBUwH1bGo5A+zaO6rPMvi3yaU89R3t+pIzsB+aytYPY33Z50uC/C+T+9WBhr73cOtqJXrlzyU8EJpw+GQb051m4vnFrgFcaje99mQ4rThmDsX+6POBNv1fZ7lQP8xQbPLxr7LSURG+Qu+e5Cha86EXX4DxRUjCuHA1JcEyygym+zFPap+pn1q17VsZC9DALN5GFdPLnwq4gdKk9qG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:22:46.0540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6a68cf-941e-4ba5-3885-08de6d130951
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143

The ldlat dependency on l3missonly is specific to Zen 5; newer generations
are not affected. This quirk is documented as an erratum in the following
Revision Guide.

  Erratum: 1606 IBS (Instruction Based Sampling) OP Load Latency Filtering
           May Capture Unwanted Samples When L3Miss Filtering is Disabled

  Revision Guide for AMD Family 1Ah Models 00h-0Fh Processors,
  Pub. 58251 Rev. 1.30 July 2025
  https://bugzilla.kernel.org/attachment.cgi?id=309193

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 705ef43325be..e0b64cb13bf9 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -356,7 +356,10 @@ static int perf_ibs_init(struct perf_event *event)
 		ldlat >>= 7;
 
 		config |= (ldlat - 1) << 59;
-		config |= IBS_OP_L3MISSONLY | IBS_OP_LDLAT_EN;
+
+		config |= IBS_OP_LDLAT_EN;
+		if (cpu_feature_enabled(X86_FEATURE_ZEN5))
+			config |= IBS_OP_L3MISSONLY;
 	}
 
 	/*
-- 
2.43.0

