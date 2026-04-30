Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE4374737;
	Thu, 30 Apr 2026 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529508; cv=fail; b=U2TyC1tnBpX2mTwfAf2RFIF0wCoXHgTaUlYWxb5+31f/1MqhsMKw5QXgWAfDem1FCjTBuCp7V+o8+eRJ1/962hJb75ky4DVb5U/lqRiG4OMgAnr6fJD6Gh3g7OoTxWZXTf0fVCLUPEGEcEYjEMmaQXsZeaX0DfUjN09UGWyoTRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529508; c=relaxed/simple;
	bh=7zXAJ4yn6KrmshMAL2TLnr1rwAvlIeQjfgYhRQGwVOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2RnWuv+0kdpcGVJu4FLeyTb102+0mCZgojudbHd3fj2XsuMVbD1veA2yDIPMIBE3sr0U5ftqIuWcK018iO3PQcx1sH+mYxVlChT0sYQkeorDFG6ne8bxBhkSgQspyJY2hm6dAnqTxZR1QnHnmwaCU8N7AuEX5IEOwVOchlH9ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vKEyRmNJ; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vKEyRmNJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uid0f1XwMhQSJ0YBs7vX9lqMKHo5A4hqraL1P146sAKw8Fg6xDqkzw7TgtqrZt8kdiMzCAnV7eHf4rPQuzG1XgB85YLA5sLDbs67rWjmd3jUQ5sD2oeShA40f7i2fF57VEHLKOuXAhMRf1B8KEhXJQkfzXvJJqveyYmJ1Df0h1S43Cwv7fHVyshZMOvzSpHtQ2yGkInJKbvaKxl+qWeu26d2iEZNtc95tgOTiFMVPKgxxPX0CWHhNiBST922rohTL0CTgjR+Rz9BhiIrq3twpx/6GbW56nmf+HUnHF6R8bhcFKnc/YR4YVmJpWqSmxnrVOXPicIe14XIDyN4SdkAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl8FXe6pRqmEWIwlwc9yNDjG9gVaKpV0+YVl7Tgq3oE=;
 b=GrFno9Nol2/FeLHmzHtAkmDJS+T7OWX1f1upvqSiAiHj7Lv5lxM6tc7XoxelyXCaRdgMKlGhQc4zOvkHSvkutil5Uzq9Ky7pRBkvXY/Z4nXykJpOOObtObPDE1zARMKFXDgJMUeCojBWWp3Nr0dpGspIDG1GItLZ/6hHap5Ec8yoq8f8IdxUyAtaUSlHwX+EoSagaE1RRwqTqbkkb4oaho2tsJOfuaOzL3vxboyxeFfOXTxQ2pM2hmyRntPSEHmNaDsbydEhvsGNUL4rxWSgSTiTaZH7SNi/lBzYkYj0g9Jol85/1iKvjDNeYK6e/tXv3BjKvSCaB7Y9wC4fk8jVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sl8FXe6pRqmEWIwlwc9yNDjG9gVaKpV0+YVl7Tgq3oE=;
 b=vKEyRmNJwInifkhhMVgx0xg0QEIIaCBUR3FSXfRkKvZuPEIdDImSFl/TuVZh5Q3mnPm2b91iWRUwjAADIGI+HM05GJ/nVyw55AbsFFMu7LaO5K7zkSvcLvjJafQCLzE4GCsOQT4ZWlI7cpd3tIZGNqa7nUvRDzRRUinUFkFmx6E=
Received: from CY5PR19CA0054.namprd19.prod.outlook.com (2603:10b6:930:1a::15)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:11:41 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::52) by CY5PR19CA0054.outlook.office365.com
 (2603:10b6:930:1a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 06:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:11:41 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 01:11:36 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 1/8] perf test amd ibs: Fix incorrect kernel version check
Date: Thu, 30 Apr 2026 06:11:08 +0000
Message-ID: <20260430061115.10266-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430061115.10266-1-ravi.bangoria@amd.com>
References: <20260430061115.10266-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4fd095-ab28-4349-4b2d-08dea67f58be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ogSOmwLckV/wffgmZ5koGH651Z4ibTz3TIjVjbAr4S7KCHNEeqBRAb6oHWt0mIU6AM9aIbyvbCNjajuMIaaa//xcuxxZVBsyAN/PH1PkwtINDUp1277mbi0RR+SXr9TSp7AK9qNilMBvU/K/pjuqWerhqS90F70FxcIDUypWPvyKiqmXjS9GY+s30Ti3A8w15wTUXOtKgmyt7Gt1GChxaYuxIkVPA5Rv8Z3C/UA7F9MXu5g00J6HlO+juCZvvTxEYvZo8rEHbhSdb/qM5NkMTBFhtgtW/RYTnnbwwur/NdJctAU74sNtcnqcNTu8WfMJ627RvFu3SCZH+Ghm5tGRDCgPs6yElfTgn8bkdmI+Ea9HWeTjYohngC3kqxJwTDi5zDmSmcV1RdcVkk7Mq9vbsWxd7o8ZUCDazE+JPRXX3/XJnNckwyHnuhzZZopcQhxw9eP+PME/EqOhLSel6IZozWh/mI9tdJOiwAe3WsQXqwARJpxpkizAQTKSgwraawlgrYocVmYB/OUrVznEWt8D3nzZkdqvDyYMGu/mDAhxy63ZDBYRtoDjL0hXFIOoSw2C3VJ4Toc17cfD9BSqypzsdfcT2/zHIkO9xno6ayPljrTXlz84A6yQaxsY6SRtFmgHcvjnSw3SNUFT705zYUdgZ0gZDOSjj9KP/WdDbMutY9jv0H4PGSkBvBk46y6Qs/wi2eyNGLGQUxrQNI6ZwUuVrRr0Um5gum4hDVhNQMskN08RNHJ3dxSZNbL681NNTWh3mFKjwNqBtdbOk+u1qdIABQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LOgLT4sK82GsGgy+naqCJeU+NfVFCw0TyT69qyoKLQbKN+qzHASkBmeAqkWMiiFrsGoQ7dTDoYlR1yWzBzLOzYwnUat12RwVzYbinQAkXF5WH7TDimnsUXBvoir6jApKab7s2gBym1OwlqYqwWoAFwTEkoewidRNMHmHBw6OmbwzK+v7j6wY+jyBaH8bPAGdDOzUF9lg6oGkIQGsR/GML+EVcUTQLEqY9VJeqswTIlp+fDzUgAkjKgeWW7Neo4RgyJ8Clh2szBWfH+pTRvZUnm5sLc9+4bHXOPYtoBLth7gnJnZR5IqLrpuVgh9lkvj8ZZV1luoCs+5exNEe00Zat5IsNICzfk8qs74EgjyOKc8pwrbCb7WprgYhLe75MBy+X4SLeb3+OXVTCJNom5vhiJwff4NXr8gZsOAhz9+ZiuaMqu+bHXoP0urxtMeM4+z3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:11:41.2227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4fd095-ab28-4349-4b2d-08dea67f58be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847

"AMD IBS sample period" unit test is getting skipped on kernel v7.x. Fix
the kernel version >= v6.15 check.

Fixes: 21fb366b2f457 ("perf test amd: Skip amd-ibs-period test on kernel < v6.15")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/tests/amd-ibs-period.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
index cee9e11c05e0..6a92b3a23ed7 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -932,7 +932,7 @@ static bool kernel_v6_15_or_newer(void)
 	endptr++;
 	minor = strtol(endptr, NULL, 10);
 
-	return major >= 6 && minor >= 15;
+	return major > 6 || (major == 6 && minor >= 15);
 }
 
 int test__amd_ibs_period(struct test_suite *test __maybe_unused,
-- 
2.43.0

