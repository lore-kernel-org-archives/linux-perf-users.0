Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A354DEC0C;
	Thu, 15 Oct 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064905; cv=fail; b=IMx/dYk7BeXg7yh33FCuaJ72HZfZhKEXtSaW045mg06C9G6n1N+6bt6YNpd1Bv0sExGURKQJ6sRrKM/vcjVvqGSoDNz/ligHWwheHH3zU4VxqTnq5QQ6FYUF3yoT27/4DUQ+3XF7G0kajXjz7SvIHIpFgFQxaiC8dWK4BjpVjFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064905; c=relaxed/simple;
	bh=gCelusfqNsnLsWdZMaQhyMvvppKGzD1gUNbKfTl6zwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nl00VT0E11II2G1eSt0tnrRT7xct0S8Q1UK9qEFziKk5iUPfzYPgrHKlqQ8/XB4dp1cH/WRaXytIoFC8+NgoQDky+8FDT0sLADZJ+CqrtVm/OA2UlshbRGtKzfd3PDigAYu0uNH3fECsBDKwARFoagz+zKpRDZMwSdqZy8XrWT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fwt2EZE4; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fwt2EZE4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayVPg+7z6chJds4qgKpWwpFpHmmP19JWpSaMVBnaku/uZfUJQq2I/vycPUwFgi306wbZKFAHZlpdUM+xTXyTMQ+wZ8of0qQqnPH2JDiOIOlAoF/jq1xPqBJBZ8aBzaxKQbonWSElC3oqBfcrSJOxhM8QSNrVGUmCSGxbZgKNbhGUzDO0lfjGACJu5XBZz/WWJDCRGJbDTkWbDMD7a7WquaqYrpBtWEHDePnqr+qgUwltI0CT9rsFrAppP9CpwckIr61jOmrZNh//TuelY1H7bWC0+GFdXoOYpUfGMlYdO7VWM04sWgyzbg2yFEcg45Dw0n8QfGRXLxaa7uoBHWJ93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUqnuy4M9gMiLBczzdPGr1pxnGkJO1XX2mfOuU5DUbA=;
 b=rLsX17UpkbSYmt6t/+WbVlDHl60KU7EEjZA+YasSdv81OeM7e/e7NVM0AuHmkYN5//l+QAVT4O4k40nYtQUOODrjVxEqAWoIPtve3cWRjL0m1Eu+BTYI2gX2j+CP9oGZAfqtHr/Trm8rrmxLhKm9qa2oHwJBUVz/Cd/C0UgDnrDhOqulAhYXUQz18/BqKzfFpl1guZD+6JTLY1y6CQqjH5EKOG9h841lICMNh0s3ClYRP7WUhzsQMaY+xE59MJBc1eIHXnArbJMZijKAIgcQ9jhhA+U67AaOiJrlXTEtd3Jphj8kEdSIy4ctdDyINEZeTVxu7hbj3bjDBUf8JMzhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUqnuy4M9gMiLBczzdPGr1pxnGkJO1XX2mfOuU5DUbA=;
 b=fwt2EZE4/LnNaftLf6iYBbmLiwu9nggeywmzmvD75DT5YvsXJX5EWCblISzp+WbfAP3/V90sc+fGEg4Y9UdtvyiZC5abL2VxB9JgWKzIfJyWSSY7DSLcbEVbPPh9rQkX8/wR9KVPLFEsyQwBcJx2QwSyJ9UoHXA18hJUX3gkPJQ=
Received: from DS1PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:458::8) by
 IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 11:48:20 +0000
Received: from CH01EPF000BE94A.namprd02.prod.outlook.com
 (2603:10b6:8:458:cafe::32) by DS1PR06CA0002.outlook.office365.com
 (2603:10b6:8:458::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 11:48:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94A.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 11:48:19 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 06:48:07 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Andrii Nakryiko <andrii@kernel.org>, Song Liu
	<song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 2/2] perf/x86/intel/lbr: Limit branch snapshots to valid entries
Date: Thu, 15 Oct 2026 17:16:12 +0530
Message-ID: <7f611dcd599d6d65325d8c40566a1fc35b447ea2.1792064123.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792064123.git.sandipan.das@amd.com>
References: <cover.1792064123.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94A:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 9206e22e-068c-482b-f42d-08df2ab23581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|7416014|36860700016|376014|13003099007|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/LBOcYTG5UjusPbvlqq7UNaOUjT6thNlL2bpLEq6ayLR0LkExdBANOyNxfXQwiEfVOLAGcvjQkoXYXBEdYCTLOVdZEIpx4aJa4jqyX/8VFCsUGj4kVUWw0c7oPb8eQZY0FXgbixl6qoItqjV/tURk1UKl+gYNkpCJwu4aG4SIIooNBP9AuQSildezaZlndOZYmwiOnkqEW6b86P1I4FKr24VHzxCDinhiTULKHxRb9EPXb+zQfJ8BGteTR/M1FEdGGk9wojkGBbODdcvXjiOg8oRfbSsqcnxDUCxvJ7JniZb/LywSDfwOx5iLcoe/lCyyIgcOstcewEDCjIW1SxjxKSYyBMsI9eU0t0ZtQUqUdbRu64pi6cY61IuD9x+gI018UXF+eLIvCsRgb/4hz3rr8Zzw7xsj50lLhvEeEuWTwr7LHwMkGcvbjIUnnm8UIecdsEvOV0yqw/UkfzC0PrminmyWL3sMz3qhorHv0zpr7tZaIggWZ/eixn7VAALNRuZhauZExwF3Iv2TGswARFfEQbVvM4iKGRvbdJREPJ2kG16c4iPFWbHkDNwvuzgGB5H22EDu4EQbPYpKt4gqRJqdaH5lUqR8SuWNwsVTcVgVDrD/d0z8y9+gphEg3Mjd4rjBasSPKDlVqIvyrT1ZjQmGh5ffSpc8Y5KzMboM3dOZkY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(7416014)(36860700016)(376014)(13003099007)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jsoNXZPP/8o7F5Ly7LU4r8nPjZQAT1A2YMq8qUDlXWKmBOqei4bRBBpXtdLr9jjLCoRC4QSR7grbD2QrO3FPyO8YaOHDIADX/HpV8mLC7dDiYIgP75zhubngEfHKsJOmLOhVaOUrNHdPlvHiO6obdaLYUM3paCtG8t+/n6wz6eIkMFT6WB/vVc1/TnB7myn6LcKRHAM+8MQlz5pV1x7NLen1z+9DLRY9zZrKDwWLFdZt28dZPpbev7UGegboagEDhqqlaRqvt/k/gBGR9mW2aN8jPkRK/W7a3l/lNcKtEOmGArCEPDIJXa94yG/KZEJX4nDcBj6VPwSjS6VPdt1S80XgjzwveENVvQHVrd6801MhGbXLUCuvpH5+T5Wysc2v5W/lZGxP6cTLdZTmaO6FHHnk1dfEWAeTeH/ANva3rdif8g+WQ0OuZvBdE/9Tgi3K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:48:19.9585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9206e22e-068c-482b-f42d-08df2ab23581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

The branch snapshot callback used by bpf_get_branch_snapshot() always
copies x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
last LBR read kept fewer branches. The entries past lbr_stack.nr hold
invalid branches which end up reaching BPF programs.

Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
intel_pmu_lbr_read() skips reading the registers so that a stale count
is never reused.

Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/lbr.c  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a34d674df59..5dfb9e9156e8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	intel_pmu_lbr_read();
-	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
+	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
 
 	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
 	intel_pmu_enable_all(0);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 0b446d8912e4..6b070490f461 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1026,8 +1026,10 @@ void intel_pmu_lbr_read(void)
 	 * but this simple approach seems to work for now.
 	 */
 	if (!cpuc->lbr_users || vlbr_exclude_host() ||
-	    cpuc->lbr_users == cpuc->lbr_pebs_users)
+	    cpuc->lbr_users == cpuc->lbr_pebs_users) {
+		cpuc->lbr_stack.nr = 0;
 		return;
+	}
 
 	x86_pmu.lbr_read(cpuc);
 
-- 
2.53.0

