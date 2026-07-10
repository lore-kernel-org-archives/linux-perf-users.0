Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098C2D3A7C;
	Fri, 10 Jul 2026 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701311; cv=fail; b=Oc0pLHi91si1BE1hfkGQh/nLWZfVXUKFAT5ykR0uI5HdND1clm0dI897GD2br/WJ2xlTE0w/kBpdS6yqIesGzRnxgX5wGAR+l/Ds1pcnf2FeWcjMpLTQZsCiSHMeS6lZsspKVQTfYFpmLmiJfC9ubfr6qidOU4hIdMHP9edpEw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701311; c=relaxed/simple;
	bh=ZY1XvCfXTNd0MZUXnnzCBZsgxIlnU+nFopm5zt88CVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AClw6tzD8hhpwfHSvpmAOIbeihj1JEt9oTR0KCemotdwroCE6WLsCFVVk/zm00zCcBA/o7ti4XOh/db3zBWrCmY5uqO9yDlFnE3GfvC/BJStbV0WNKtIkItgyLieWd8pEKJnsTLwE0vcKSzcNEQjJeqijj7telAbItuSHYYAMS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q9O/CtSc; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q9O/CtSc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVP6fFX7qah+57eAaSvphTFtPgqdp2oIOVpoAMtHSaqLaA7rcYWHPOAB0VgsWV1sEYdbxGl/ygHp2XFQ/wpnbjMoEhYHMTn8eGx3T0N4BIh5Cs7Q0kkwP0pmxPMCB2dglW6GvdnqVvgg3AH0AsMa7HkAsuroFc6shqKsu/36NdAsBJocArwJ0Pe+J7e77jRcYlS7DU4/Pe01m3sBPQpKhBhNmlnepSJp1m00qqDOUQCev2pPnJLU0m+cAHWhghTsZLY4/W4zhs3XmfBbjKozamg0PuwVUWlNjaFNk9OK/TnnvUKgPSebjaaDaKZa5Bg00XPgz7iJDKRVCm7IZD0k+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cXhx2ma7nvCiDu5qXfb9SnL1a87mOXWDHBBM7YFiJU=;
 b=X8tjXEpGhcU7JdDP3sjBTXneInaxnZB6AnX8TRpGCMcGL5weC2MuVSqUKHt2yGpNvkcQ+yixdgkTca6/y5m8wn9pSgDmKA7edRpbvkWV3TnZfF8zT6cfgoXpr0ftBA2pZCDLT6q2ROkeK12nRWPZ6GPVWax3a8sMLwUpy78axSdPWDh5TboRih5m95i5cJOLmVrxkaPa6AtSsXAT1y51ENxfG1jJxM1zPYAHFFM3sa2N2G3oAQkLqkDCSATzSiAbCjL2ZdTnNNNbim1MibNd3XYELk/0y3bdlknLwTMZh/mJybGKa6Qb1XWjgjZjHoEBB6JHl0f1xMyEOV3EH8IzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cXhx2ma7nvCiDu5qXfb9SnL1a87mOXWDHBBM7YFiJU=;
 b=Q9O/CtScquqmmBpG+216kDm56x9MmRliJx+wiV0azPmsHy4l/+gBa++fQnX+3CNZqpK+P5Tc7i41Two53RLoKHXde4JlKTjAV0rJg6H2n1bTjlr9s/gS/Zkk4p7x7ZTIXvIcJvU5oHq5gW54SHcYXGMHV5FczLNc297DvqRmddo=
Received: from SJ2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:a03:505::17)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 16:35:03 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::9d) by SJ2PR07CA0017.outlook.office365.com
 (2603:10b6:a03:505::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.14 via Frontend Transport; Fri,
 10 Jul 2026 16:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 16:35:02 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 11:34:56 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Stephane Eranian
	<eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH] perf/x86/amd/brs: Fix kernel address leakage
Date: Fri, 10 Jul 2026 22:04:49 +0530
Message-ID: <f05931c4f89a146c364bd5dc6b8170b1ac611c65.1783701239.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|MN2PR12MB4288:EE_
X-MS-Office365-Filtering-Correlation-Id: be295ff4-1a73-498d-ae05-08dedea13133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|18002099003|11063799006|6133799003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	qXADIGTkU483qtJFAWDgyyp8/DiuSBTJ4RiPCJJgN3fBAROqJc8O2ldZUACOPKfSCpCAFpPmgMg84VZsGruB0l8Hz6KeZHJYnPpbG/+8F6fugiUGJy/kduGLx5wZBA3FCadm7VT3kKxmeGB4NZj1YAUUS8wLMS3TlM7oNlqQweNLufuaMdLcnZshM6quVl9uPYsVMkqHkbvTg9vUmm7N93owOxlJGesyqZlmFQb48jM0m9Yw9kL1C6rcZdV2j0HbEg16W/fcjWKfnzSCugICvce2KljmCIj3UfLNPnPGhKHBQZ3AM+IQK2m7KVWvGOF5kygLLHQq1AXrHztqN4zyiJ3EzrjQ1U/8mzwN2yO4RlhF8c8Y8NohzwncXUI1CLL/Rw/G2MR68Qk0pefLJoTyUydgo9KJKeieUIkSuoU+5W3OXvZQJS9GJ6TlIDnnZhg824XipuucDzt8XisDu1fey5Fb9JHeMXpCYqzJvNFW945d2ckHqIVLHBYNTvub1BanaKopRzlVhob4FrbW1dtOfj1430WcB+5xdk7yMWfis82QwJB0+z754XH5rgpM0/rfzD5mLEolfKgsg+BHUmkPejEdOsUtFQOdACNg+w4olQRDmucYICFOTz2+CeGEbgixGd1NTHE+/ey1VUVq6hsT8tv95pmoEJxmwdbzonK0ehh+RGK01s7fBHU975L+A2RNlOsUNuW8gpq1O0jhhAsX5Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(18002099003)(11063799006)(6133799003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XDOne8SATQBa7Ywck74oX2FASEU1C9tFpcM50V8cqtKAiLbCmBT7yd/bWfkoHuuDcF83sgP03/bfepoGHW2uu4iFTUnoh7xuk6qVYYJUP/gN7bmo3/8ylftrBP1dBmWfmIQb2A7l1EKfRnhL8DqffS67AgoFpQnh74zLtZtxdp5kiAruADMMQevVSTF+8Xwo/Zm09OHnrI0uToHlKRfGQSdV82joxF/b11pRjkesmu8tU7CgnEdLaB3JxTCI7IKSsDGHE9uXFDorA7OSriZ46fezxMRoAnwVddb6WXugvc10zU4UjZf6PfJq+yduS8yeLtTcgw82+z7gNdAYoJBdOXVw6j1TQDpkQnFRN09L2uz03CymFSgg/KMUhOFzaQ+GqCmd3TFLZrGY8nb4R6QCtd5+XVnmFieT7VsD5Y7K7Qkq009QOG5gNTx6ZVZXSXfS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 16:35:02.8415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be295ff4-1a73-498d-ae05-08dedea13133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288

A user-only branch stack can contain branches that originate from
the kernel. As a result, kernel addresses are exposed to user space
even when PERF_SAMPLE_BRANCH_USER is requested. On AMD processors
supporting X86_FEATURE_BRS (Zen 3 only), perf can still report entries
such as SYSRET/interrupt returns for which the branch-from addresses
are in the kernel.

E.g.

  $ perf record -j any,u -c 4000 -e branch-brs -o - -- \
        perf bench syscall basic --loop 1000 | \
        perf script -i - -F brstack|tr ' ' '\n'| \
        grep -E '0x[89a-f][0-9a-f]{15}'

  ...
  0xffffffff810001c4/0x72e2e32955eb/-/-/-/0//-
  0xffffffff810001c4/0x72e2d94a9821/-/-/-/0//-
  0xffffffff810001c4/0x72e2d94ffa1b/-/-/-/0//-
  ...

BRS provides no hardware branch filtering, so privilege level
filtering is performed entirely in software. However, amd_brs_match_plm()
only validates the branch-to address against the requested privilege
levels. For branches from the kernel to user space, the branch-from
address is left unchecked and is leaked. Extend the software filter to
also validate the branch-from address, so that any branch record whose
branch-from address is in the kernel is dropped when
PERF_SAMPLE_BRANCH_USER is requested.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260710110235.F3FD81F000E9@smtp.kernel.org/
Fixes: 8910075d61a3 ("perf/x86/amd: Enable branch sampling priv level filtering")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/brs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 06f35a6b58a5..dc564688f3d7 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -259,13 +259,13 @@ void amd_brs_disable_all(void)
 		amd_brs_disable();
 }
 
-static bool amd_brs_match_plm(struct perf_event *event, u64 to)
+static bool amd_brs_match_plm(struct perf_event *event, u64 from, u64 to)
 {
 	int type = event->attr.branch_sample_type;
 	int plm_k = PERF_SAMPLE_BRANCH_KERNEL | PERF_SAMPLE_BRANCH_HV;
 	int plm_u = PERF_SAMPLE_BRANCH_USER;
 
-	if (!(type & plm_k) && kernel_ip(to))
+	if (!(type & plm_k) && (kernel_ip(to) || kernel_ip(from)))
 		return 0;
 
 	if (!(type & plm_u) && !kernel_ip(to))
@@ -338,11 +338,11 @@ void amd_brs_drain(void)
 		 */
 		to = (u64)(((s64)to << shift) >> shift);
 
-		if (!amd_brs_match_plm(event, to))
-			continue;
-
 		rdmsrq(brs_from(brs_idx), from);
 
+		if (!amd_brs_match_plm(event, from, to))
+			continue;
+
 		perf_clear_branch_entry_bitfields(br+nr);
 
 		br[nr].from = from;
-- 
2.53.0

