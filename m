Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6294C223324;
	Thu, 20 Mar 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465371; cv=fail; b=MQk09PQslY4QC1FRgjYbZbL4NUj2/Rjb1/0sZCKK8LgKCPx1VGYj9sZmCpd/eDzv5nmr6eW0iwREUDdZ3r7qznS4GA9gBOk5sMqefeSDmsC5KUG88/6Wg65/pZmYXbAEiBbdL+iNYRi/jQZG+t30b751Fi1Vb0GAY6iLd+LaZlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465371; c=relaxed/simple;
	bh=a/SIfXQswY0I7wQH+J39McNlXwbdOkYeOUMfRPp13tw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8KKbHxN4Khs4ttUw9wnHkuhB5riyUOitBhLHh4vuGMafs2WZewc5eBSckqZ+51yaUDRmAsk0+BxntXZYv9LboeUOWAbjIviAjVyQsBLW/n1ucgRSaZyFA/sK4ZwXTojJ4u8UixGjzf2SVPpeq/1e7aHvk/jmCn8bFFja71N9Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MJ3AthK/; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MJ3AthK/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcrsXSJ0FZTWlLZBft2dCCS5dw11QxKgqe6ap12HBhEKvLbPyPbzFf60GAsckoncmxAUQwT64pKL6tAsLOQW6W32zOnom26kBI9XKlQ+0IqnDOI+ZMOmyJY0+XKeQrFDkXOCn8lugroT/0l9tx90HTaAbExcQ8DTPAJnvcZXsyAjH3GPOFO5qnvkhWDW0OB4cwtvAI0mEXCRRxv8cNkSwWhFGSACos1lcELrjU8es6TOJNEct/z7ppd8BroY1MTRWZcULojAZwuuZpUEZ/+313G4DsH6LyowGSsojwkKdfTnO9bFW2XS+8P0zMuCk3dljWXAoR7qLmRlzGcY74DtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsO9d/l6uPe4Jh8co1pewAixM2z5tCd6UhjxPJ75g/g=;
 b=wgOOS8Ron9WP1o5tAnPh9xMgaxmDvpoY958naudxwDCG6wHif8Jz0vRh0s3/qAC9vaJJ8av2BndCP9OP2B2J+4tiU2yIc6KXvDHTxmHPOrTzJDOjNBFWQsFXBlfvKppQd15vu+nLgJ3qYUCmCO76m74x8EWLxFdZ4BoRJiU4KKdzlmSloGfg4o3rA5YjYuy6yCZZaZxMJQ/N9oisi0hTuo9VvAQevec7BD5BPUtI3tJjf4Y9K+xtizjs1Y0eNEGiSBC4IRAuV5M1E1NFWKRM7dGpF+K3qFfwiReqjB/QrsTSbL9ECh9D3/wX8ukh6xm8n2B2+9DBkvFj7qy1h8F+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsO9d/l6uPe4Jh8co1pewAixM2z5tCd6UhjxPJ75g/g=;
 b=MJ3AthK/b9l15lGMLoy5HPZrysqtf1JI/dYIdNzTJIxSLOEDcKD44PaPdoBQZ9sa1xRmg0AUz0rynOo+vp9n/9kHOxkWRXQhuoBo8N0cCfiWOpNK6zPSO1OI2SfBscm1HNFV2MiJ+sXrgCmravG16wwdEBcKC4qtmGHUm6xcuoU=
Received: from DM6PR07CA0078.namprd07.prod.outlook.com (2603:10b6:5:337::11)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 20 Mar
 2025 10:09:27 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::b7) by DM6PR07CA0078.outlook.office365.com
 (2603:10b6:5:337::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 10:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 10:09:26 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 05:09:23 -0500
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <peterz@infradead.org>, <kan.liang@linux.intel.com>
CC: <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Subject: [PATCH] perf/x86/rapl: Fix error handling in init_rapl_pmus
Date: Thu, 20 Mar 2025 10:06:19 +0000
Message-ID: <20250320100617.4480-1-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: f83f5e9a-45ab-4531-106c-08dd67974bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LDP/u+VD09bagNT4VZsxlrLUnqwBkZbO2sbAIJwyRMeVPzKsmTe5XGNkRsY6?=
 =?us-ascii?Q?u24iUsJ+EkMCOuafySLJCvTImMba180scGix76LwRv4arB9VDz/z39MDYScZ?=
 =?us-ascii?Q?KRzSzkxtsEzFHmTxKt1kBDST3wqRcvc2Dyc6AJ43vW3JYw3qYKsxH1Z+mAN/?=
 =?us-ascii?Q?Na9OqJdpp+ONKtIn2ZF1bF3tSm8MWdnZtHS1whoFc0H5Bp1w64mHPA99AAXT?=
 =?us-ascii?Q?OiXFvlBtGHnKX/i/FfG80QRFV/doKvcYyuypqUoc9Q8mYYKaUwBups9ZP4Pj?=
 =?us-ascii?Q?QloSbl85kuWvE6h9B2erkKiE0sFTuZQ7kcy1BikocaHEbV1l++MiXqw5SFDL?=
 =?us-ascii?Q?YI9MKjXkMFxpLuLlUyXvl5dkqu2rk5Nh3A74X9R0jxi3vXwIgptDjzlFr2ky?=
 =?us-ascii?Q?qOWcj5QNgiHOqz+J+qN6Cj7CfkdqayoNS1jhesHd0Uv/QoZMBs2+4UFoE+Aq?=
 =?us-ascii?Q?K6A5ZpmlbofQSNa7CvkTKMRk4vKscVo9/9zYItsEOXprcJXkgRcC7l+rO8zC?=
 =?us-ascii?Q?lNuuZiN4DLsrfAF/yV4qT/cB1OHKpqkQ7Qu1CRpqNsTiH1Ar5weH/Za+jiKb?=
 =?us-ascii?Q?V8bsQ6d6S17fhP0ABlayaM5PnloqgxeTnuQorvJu36tctAstbrOiai4U8upR?=
 =?us-ascii?Q?vSathKklPSqa6EnkCUwb/2nYL0b2rZdq8DrzJ9/xd6FxIGhfjycx6bSe+mDS?=
 =?us-ascii?Q?+Tr1zfdj+gHtY6QH9LME9bHkFmj/Q7tLuUVrcrX9ogJTHcgmbF5OTLyucLKP?=
 =?us-ascii?Q?Ln6dT/2IpdNC2dRoCVg6aVAA52IqYRGpquCyAn85swdgqw0FFqiuByh4azAw?=
 =?us-ascii?Q?Z4jbVwDtXGy/WWkXxr9SVzu2BcwxnTb1Dl9RzfGgHlMXwoeKZVylboN9cfLn?=
 =?us-ascii?Q?QP0dKb9akmRVm2F+bUrfqJ+NfUnM9ya5kvWY93/zavsw9dt/VjwFUK7jOAGe?=
 =?us-ascii?Q?buSgd9ugmN0YeA6O7WiiHWs4efYKRA7WnkhnY+rwOzFs/VqIhFXxUVrXwCQp?=
 =?us-ascii?Q?CRArLiTF/K9ZDTvWsCBhRQ/8tJlCpjMNL3/jDwM7xJkLITg0YUx9JJAgtasc?=
 =?us-ascii?Q?O4UABPRIU1nJdQL3nj6Z2r3gwctPTncI4QyrMdfUGkGSDNfeCGlvWBnz75W3?=
 =?us-ascii?Q?+hC+EcbrYQvv1qx3ipSjjBxsawgOrUb7NV7TEhei1rH09bkkk0RCWCIIv2++?=
 =?us-ascii?Q?e0utimHLg6aQs8xtrGIiuS9Qdlf/5iFDiCd6jUjp7fQMOw9yOTdTJVhtFHig?=
 =?us-ascii?Q?VHvKSDFYZZW+IdXMovTytIl8l2ZsZ7zDMYPyCdcDvOr7Lv4IBby47DPAwY+J?=
 =?us-ascii?Q?oxvOD7w5d3O4ojbTbzEstDIuISvHzALcEYPMVjgAAlMVA/EkmmfDWtknOoXX?=
 =?us-ascii?Q?J2dhxDxp+vT6cFCHKSGU/0ihUpRZRFFs/XwasnB4ZwH1OOgijm90RF7PxsyG?=
 =?us-ascii?Q?GuWjTAzSebX3iWgqgR2p84mmfk+byZNXoZDzi7FtaF9Obvb7iZqXvzYIst7L?=
 =?us-ascii?Q?LlOWB29djPa4Kn8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 10:09:26.8164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83f5e9a-45ab-4531-106c-08dd67974bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493

If init_rapl_pmu() fails while allocating memory for "rapl_pmu" objects,
we miss freeing the "rapl_pmus" object in the error path. Fix that.

Fixes: 9b99d65c0bb4 ("perf/x86/rapl: Move the pmu allocation out of CPU hotplug")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 6941f4811bec..043f0a0b1e00 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -730,6 +730,7 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
 {
 	int nr_rapl_pmu = topology_max_packages();
 	struct rapl_pmus *rapl_pmus;
+	int ret;
 
 	/*
 	 * rapl_pmu_scope must be either PKG, DIE or CORE
@@ -761,7 +762,11 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
-	return init_rapl_pmu(rapl_pmus);
+	ret = init_rapl_pmu(rapl_pmus);
+	if (ret)
+		kfree(rapl_pmus);
+
+	return ret;
 }
 
 static struct rapl_model model_snb = {
-- 
2.34.1

