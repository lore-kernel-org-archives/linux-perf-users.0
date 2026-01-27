Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC3328B58;
	Tue, 27 Jan 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539878; cv=fail; b=FHQhGGQGJ/T/4zIwWJ89uIPjbXPWLRvidWkbr7WIisWwFqpxdWEH1bNvoDNwl1mmHJHcy5QT6RmbyIafs989BDrcGVBe9j+gbRK0Sfe7S4xSdDZjZET0Rfac1r7JuxSeVEg91LJp0S/a9ig9sfrqkGInW4rTZ8cLwclUyu5tdA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539878; c=relaxed/simple;
	bh=4/KzOYQ7BAn3UsVQEk5q2OpdaTiuSSMLaoJLaZS/3+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6FfZ7SpjL7ODpTc6YDuShaGlq2v3Ib+sByi433kbv/V/nSgY/rnjUZmRRQ0BP4gm1IoiOTA389d/bQ4V3TsqIrF5f1TZHDFTM5H8f8Wxp4sWfhTlEGmTpUfpy0c76rBirghvNGOfANEhaowdbd9NquDbVNt/hnk1wc/Z/l59Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G1quUJCK; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G1quUJCK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdTwOy+HXrf+PojSCnMAHer5J7IwXGPsZtckVRvrOP/wPHroE2Xth+KfSvvcUr7MrgkkBAyP5rgzBMDpXoZLnBSjmDWt/d6hQvIUFjh5Hs814EZ/vMUMix4pP+JFVVR8EIZpkXtGtoxVL38RR7wXC/b1AcKMHJuDlUdfzWNA9BbNLW9uHIJPBwIwfpbduUzzknk1JvXzw4ZEe0bDd6fsNpqhtF8kI/BS4UNTbprY22HcXUiqIy4XlRZi6py9g9ozIwAsXd17EOC/y+CvbMDJhSAe36YF75yfauYSKecdBEow3yJGqK8AtkY42Q8GVCgHcMMj+1jeKqMe4iX297t84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxcEDZ3dEsaewI02tDRX+yecT2hntc/6/sP8gT2TRsY=;
 b=EGHbT3vu/lxfGlIoQUiHsG6F7jAeuFgyNpiDPvBWl4ExZ+apsU8IFwYtBgSqYmttayuxuXaoU1n/OlZgQacgJcfcfYNGBJZ1x0eA22C/xCFAzHCjLcMf8jt6dC/9+Lo2ikNjFbQhM1+rAColm6efvkwFdo6z+rjSXn45+mO9N4Oa3menQ0DZ/Oyul2IgRRq+MSqueexNfNTQ34y67sJnyZxFpVzbOVnX+eGljQpDFao7PSXIl4WYV31Ls/Leo9HhFox9rpV31DdgSJBS+sSTp9GiWG8tUvBdgxpweDUVFbaoir3JlSGehJXRVx3boYTyONalX8VAk80LVeT3xZH6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxcEDZ3dEsaewI02tDRX+yecT2hntc/6/sP8gT2TRsY=;
 b=G1quUJCKlFTuN46S4mpmmu30vakZ/7eL+MrIynMcuVIKSDvoIdO9lHqHz9D7ZarqunUk2FpnqZldasd1JKI2bLgpXDjTV9nn/BE1ve3gt+EvW7aJNJI+oYOkoZX94EmX0ykiwJsiaKkEDoYVqXVzqrA8lflp+NwwRxNSBN4yjC8=
Received: from BYAPR11CA0044.namprd11.prod.outlook.com (2603:10b6:a03:80::21)
 by DS0PR12MB6535.namprd12.prod.outlook.com (2603:10b6:8:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:51:11 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:80:cafe::ea) by BYAPR11CA0044.outlook.office365.com
 (2603:10b6:a03:80::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 18:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:51:11 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 12:51:03 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <thomas.falcon@intel.com>,
	<ashelat@redhat.com>, <yu.c.chen@intel.com>, <sshegde@linux.ibm.com>,
	<gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v1 2/6] perf util: Fix NULL check in cpumask_to_cpulist()
Date: Tue, 27 Jan 2026 18:49:56 +0000
Message-ID: <20260127185000.431884-3-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127185000.431884-1-swapnil.sapkal@amd.com>
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DS0PR12MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: 74bd554f-773c-4890-4c79-08de5dd50a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYA09X42uVDX5ONYAA4jxpZRWeDOp/Sa2Wzxn+5lUt+9u/e3zkJzWpKhK9dN?=
 =?us-ascii?Q?iSsERe/BJI/uFKFTS3ayMf5sDxocvpYXdyn1uxbLa95xHTcURTBLVTkJQk1W?=
 =?us-ascii?Q?jFjwF9P379dNlnxY2v7ozJd7oKjDGQZb+LF/9/1uh7R7FZ/XbbcWqgzMwpXH?=
 =?us-ascii?Q?rJMpdsPw3nwd481qwSwakt5OyOBc6zS2spFJgcd2GNDEMalyzul3nO0QymEE?=
 =?us-ascii?Q?jjGfwqpLLj6g//RHHQDZlSSDNCGu8bydMUcrHF17Ln0EgCB7CFcWaMH1XjGZ?=
 =?us-ascii?Q?Dsa6sbGPamNzaiI6dkTdfaXA2U8+H2bLavVUY8cpB9An/Qq41cV+RK4yTAsL?=
 =?us-ascii?Q?Y+mX+DIZkqqABVE+xq19H+lBmamHec3kH8Cy6PKA4XLvnQtE0yrJetrvp/Lj?=
 =?us-ascii?Q?MOQePdOW/LBTFT5qmJuDIkVaIGYAGqHfJCJd3uRCm7deFbk7rJ2O2KIcPeSn?=
 =?us-ascii?Q?5+0XlJq/FPEdNBr8EX40VtjcU2/zn9hxVUW3m9rkfwt2WOJj1OvN05ZxrNK7?=
 =?us-ascii?Q?2oKGvfRPQu+E6Btjeg8JwGG3ltozybQRcs81b02dyXpRErzgF1tANzFcKPEc?=
 =?us-ascii?Q?6FhoYL3YCfZ02sLEqR8mkRFpnW+deu2FFNM8U2w6u54/DCDGP53TJYVNWWQG?=
 =?us-ascii?Q?cbKNwCXHhkcjw8O/eMMDFeMs9saL3NUswURlumzK7Nmq3UtqJHa7vUl81k3o?=
 =?us-ascii?Q?9Oy6GSEEdHuliXeTlghKWe3TkegVNbML/k0d2X64BDF1KuLC2N8za3aCmhRo?=
 =?us-ascii?Q?UQxtNaq6i12cYJQGNRVLcdjUnaLfF3g8svaYl8vrNVOlq8XwPTJPLDREFhmr?=
 =?us-ascii?Q?86oCRiTLWI1ZWmZiSWBTlW0IHR6g7w9G1EnR5ualLjjZc6fMOStKuwPGr9Fr?=
 =?us-ascii?Q?gD/Kf+/uT9kZcTBHiXqP4sz1OlrHdrMvW+oUKWAa67NxuDV5Sh81S+Qbx8jc?=
 =?us-ascii?Q?tSjJB0YtEVSL0OeaeqDkE4Wd4mb1IxzgEFOXBfWZkQ7ZlPzIinF+MLqH9oLC?=
 =?us-ascii?Q?43zFuxMDDQSZ/FgKEd/ODgTWfKGFOE0OFDNNZZ6FkBLHJB70Wb+5P4DtKbdS?=
 =?us-ascii?Q?5Xc+9hSLwgACtHtUXTifb+HAou/E9lHbS95heXRzs6EINPrY+XKY/LeNVPyx?=
 =?us-ascii?Q?UdVimZBReaz2eyMiEBK/TkWw8j2Rqq399C5tYberp0irk6DVhtqK9tVCiJYT?=
 =?us-ascii?Q?yaWQ6Wsd1fJJ0rN210PXiEG3aHmTaOzAODPX33ikwVsXOlREv1lsKWDVXP2S?=
 =?us-ascii?Q?sflLjZbMPQ9frPNo6m9L0+H1obBYlblHuQ9ryDoyIjTz2cNy/JMN27xP8wti?=
 =?us-ascii?Q?W8NUGoFw51FhijKs6wJkm+N0CZ9R4nAA3KzPgTDK3ssKcLPwcwdGH0PH4iPU?=
 =?us-ascii?Q?B9F9yMeEUZDJszCR51ZkIk6qdemO54ghzwm0B+CnJwdL3Gi2ePit40u6sYpx?=
 =?us-ascii?Q?fuSG3Aw4ltPGewxDIjH7jNgNFd8HeOaMainGkCUB8m7ylavBjSlLy3IGc8+x?=
 =?us-ascii?Q?v69h2MMshX4kOKOaY4PwenXXCTB1qdep913yFIIkfBIljoz2XpvjcK9zQWJ7?=
 =?us-ascii?Q?Mx007GDnIa7S05Nggf9YTLV9YTguebjoNHH3txyThVCoMW+a4mAO4OPnKuNa?=
 =?us-ascii?Q?fPMMS5K4yK44mo0rJu8KrOf8P8hag7NunqZS8zg9c+zpQIiUahJpzbUG+0g1?=
 =?us-ascii?Q?tfneqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:51:11.4612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bd554f-773c-4890-4c79-08de5dd50a55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6535

The function cpumask_to_cpulist() allocates memory with calloc() and
stores the result in 'bm', but then incorrectly checks 'cpumask' for
NULL instead of 'bm'. This means that if the allocation fails, the
function will dereference a NULL pointer when trying to access 'bm'.

Fix the check to test the correct variable 'bm'.

Fixes: d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/util/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 03a603fbcd7d..c83e59e8c787 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -278,7 +278,7 @@ void cpumask_to_cpulist(char *cpumask, char *cpulist)
 		return;
 
 	bm = calloc(bm_size, sizeof(unsigned long));
-	if (!cpumask)
+	if (!bm)
 		goto free_bm;
 
 	for (i = 0; i < bm_size; i++) {
-- 
2.43.0

