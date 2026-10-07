Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43936194C;
	Wed,  7 Oct 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384365; cv=fail; b=tdCBOZeCmOHoh+jz6CqHtXNk2Vu7fFAiIByTlkRnFZMh6YYOIhZiDxol6oFehGeDHFULbyMZF1K877kNk27Er8ERKE11lDtik6LVkU2BGb5/swznozRPwx0ZEScuiGVpsRUEgxc1MO/ic6v4CQP7gNVYGGBsS9mSySk93fjulpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384365; c=relaxed/simple;
	bh=GJuC8ZNOXqI+I+KelB+LNdZO54W0R7z1FtUYD546r8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CRNY7eVyc2l5VGAJRv7pQ1TRmUlhAGUAulFbty2Y+dz3gNE+RakpjbDEdX28nGv1LIEuLB8HJKqN/IN/zFESoNorlwbQ1i1S/NfiI88veQ4zVRmuOPIdyrQlhbB3oRad7IvhF8XWtIeQ5zqpDn4x+dyvhFosVjqKOnaw18HS7uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xe5bdHuq; arc=fail smtp.client-ip=52.101.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xe5bdHuq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfF1cYbMyeB5kT254lue/bKh2zbfhJ8eR96KOikcW9UsgMntThZ63sVEDOKpzdn4TbnTgXBQA4HMnEOPlz9v9Ejn1a1hDItTlRB7Acke9hH9y9OE3cuCBHyI7emmQo/yr8b8F+vc9ELq6GBwnIsj/3v6H2UqEeElHomCXg59FGKeNYCtVlLFTq6/DTjIsG2nOpu7/EA8KlJJeVrEuOqz1atDzT7hXipYGQDCgO9o46fhynzVtVDDDvNzURGx/3opKpSZDGHhouJIOnTNS1SvDAYryycE3y/1ES0ZgHxwINLGmm8UVj06S92ubuiau7BOYaFwA/dMOA3wDOYK6Yc61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Js4vurE+VZcAdKIEZ7x3IxXTcCv+luGohLVSo8EiobA=;
 b=TERhLA6XcBDu4b8Go1tMJMmzC/XrHJsMz3hHdVmsEnu1+vpKCfwE8591FUo1fS04wlktVplBTuZDTtqnlMrbvhYZga6dnxThNYw5qU+xhzvy5nsZ8ToCYU0zW+543yR+RlnqS66Jw/cJzYi4NAOZy5fzhUQC3u5kY3nZP4QnLhOYve69/2+Vam7wJqFjIk11dIqCe9dbYvP+NjEp6StPoFgPK77uvdEz/eoWBwTMWXMJXkVMzi59zHdQXQuxke3E45jgRfs49zEpHRNY/m46wyvbQaN/WCYnBSRkMXAqaLCPpAuuJOTjEVzZ4XrHzT/hDMe27MEHXpW+C9mH5v5tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Js4vurE+VZcAdKIEZ7x3IxXTcCv+luGohLVSo8EiobA=;
 b=Xe5bdHuqe789ULlMrf1soDr0wuK3YJLxBMZv2kuxudflYq8EPXes/Nr18b5s1ETvMxK71RyoctCyBT5GrjOck51lAR8gMudyXrx+eoTqaCaMwVLKttd7Wp1C0RxWxRSLiL7iJadsJazgDR7oJ/X1w7PzZ4CbhCexJvZNhSXeA2A=
Received: from SN7PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:f2::18)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Wed, 7 Oct
 2026 14:45:50 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::4b) by SN7PR04CA0013.outlook.office365.com
 (2603:10b6:806:f2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 14:45:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 14:45:49 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 09:45:38 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Ravi Bangoria
	<ravi.bangoria@amd.com>, Ananth Narayan <ananth.narayan@amd.com>, "Sandipan
 Das" <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/lbr: Compress branch stack in a single pass
Date: Wed, 7 Oct 2026 20:14:16 +0530
Message-ID: <20261007144416.3446108-1-sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cb9f1e-10db-49e7-9f87-08df2481add3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|23010399003|1800799024|36860700016|376014|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	SNG0iQ2ibwKe5TvrC2gL3DfoqOTQE+i/yJJGU+syb+rm6MuxDpRnbyNYdWc3486Yc3j8oCbtnekyxi8TMYmq1DoL6hNEpFuMpGmnYuyocXLglj2+bRQTXDcw/PPcbmO8B6WpJZpNg+QMgsU8eTbQ0tS8yeVKMmjgcDtQY+VMdjW6HLtjNAaX31K7lGfc4hLloXiUQLfBnCV5fASwSIWcGofo1eYgB+tOGUxYF4r7xEPf186b2ptiSGjneXcl/IYYsl26Z8CK/+D2BezJ7gQVJ5Xaprf8iz59Iv/5ZQFEq6Jfuxic2XVZ+g+HRLf9NqaqMsckx4o4K6nJ66kPC81SjSrMNVS4S1VGKZ7h+6VrbrawDbOSk4eOrRuKVA0oC6xkMQWCxw0gW9OjSkm1IOmqZNjjGXKM9HnjwnD/5uheWzrBHhlhJjrFQNjw+JIOTXdiwn8t8foj7ELy++rCqBpwCMW1L6DMkht9qCKHrInv5L4W4BC40sPrKf7OqQKdPvvdUovdniJNh62e5KhuwDokMw+2kY62341xXjTGWtkK5UD3+/V3ZDrMnfOaSF3ciKLG1r3tiVviSqbbUJCW0K8zTpHfe8nVs1iWoIG+DhNWOaYPKce8ZDAnVGn9ET/YLg590DW5zKFtnIOuLWy8Us17+DVVz97nQjxcFii5VfsIonL01I1Zmnt3Zoo7f9VayiKfnE3oU4BMNnWc3bLQ7yGmBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(23010399003)(1800799024)(36860700016)(376014)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Bpd1rSqNaxowEsqBAcN3CyfzxVSq2qeQvL5AhP7kZAuxpkqVZmcYkY2aS3gMKX4U8l3p3tdLZdtbCbojk9AWpB5Ocxr1Ep5nD2sRo3D6J3/odgIfAl6fxsMNiVFncL2hPH9vE+g62hnk5rI+d8S7cCPccierQuUQ1aXxUxd3vgo/SV0QLP1iheOWxr033sJFQiFn6aLjuoCmo1S817PHxCvJB/6xayi38eAvI/w0VdGi5ZO6DDq7r3GGcYpmqcO8lJJgsGHkVNSszCV6yN4latYSFy24fDXLymU26LaSQOsQ2lqtO0qhtbhP1DIao0ypVyoJ5Z6KGnE38Y2kRlJGpM7zdWJdg7ykG27mhBNlyLszvVmxw3djuNFbGAJe9pK4WBhMZZrHX+rRYDOuAcFjFB5L/8+cGTsIsQ6Gfy4oslNvVccWd+c3Vc/hK5XJQzMW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 14:45:49.5169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cb9f1e-10db-49e7-9f87-08df2481add3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

Software filtering removes rejected branch records by shifting the
entire tail of the array down by one for each dropped entry. With k
invalid entries out of n, this costs O(k*n) copies. Switch to a two
pointer compaction that walks the array once and packs the remaining
entries towards the front, moving each entry at most once, for O(n)
total. No functional change intended.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/lbr.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index a55646fcb846..1e1b2f08cb51 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -141,17 +141,14 @@ static void amd_pmu_lbr_filter(void)
 		return;
 
 	/* Remove all invalid entries */
-	for (i = 0; i < cpuc->lbr_stack.nr; ) {
-		if (!cpuc->lbr_entries[i].from) {
-			j = i;
-			while (++j < cpuc->lbr_stack.nr)
-				cpuc->lbr_entries[j - 1] = cpuc->lbr_entries[j];
-			cpuc->lbr_stack.nr--;
-			if (!cpuc->lbr_entries[i].from)
-				continue;
-		}
-		i++;
+	for (i = 0, j = 0; i < cpuc->lbr_stack.nr; i++) {
+		if (!cpuc->lbr_entries[i].from)
+			continue;
+		if (j != i)
+			cpuc->lbr_entries[j] = cpuc->lbr_entries[i];
+		j++;
 	}
+	cpuc->lbr_stack.nr = j;
 }
 
 static const int lbr_spec_map[PERF_BR_SPEC_MAX] = {
-- 
2.53.0

