Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E21C3F0C;
	Thu, 12 Feb 2026 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939327; cv=fail; b=sAkSeUumsLGe8ibBfSDLZCZ/tMstK9shd/D0T9HRPAx+pJxj3bkG4dkWxMWLnEkGFl3mVGu5WMnToUNHuwAQ97MM5xLtTipSFB8Hf22ge2a9sajBQl/+us+alJawKMvJywboyGza1whERKqltC7hAb/ubfPK0SLwZDzwCHAC5ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939327; c=relaxed/simple;
	bh=anmqajptrjAaT+XjSiVDrOTyagY1jKB8abcf7R9thWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nq5yTZZ9uAqDRDmwFvTJAMgRlUzZPtH+Q3MUR8qo+psFofpsfvcRe+Tq3+uyVduuRlzJFEu/N8R5v1oOeSoe6H6Zc9QeQsHdwiyMbUBqwKoBynLpFZHPJPSupuaoXFNOsuhs1ivdrP861pYIIpNucHlTB4WS3FuYkVD/zV67cT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kMO6IdyL; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kMO6IdyL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbtlLweHHgoQatA3U+JT1EvyCkfBQczpepPRhNOUUCjXgNcuMA9uVomnesiO76JYOImy0VI46HEVr2zoNjVbAjEk9L6Ov7tsBvGuwEvdI8HquF1fEqSncB2rrVExNVITR82i1RWTcDxkrs0PxuNjhWQIbKD/UZqHEhTeQDflEsgJ94IOmSsbLGh/qvFt8IwpOqRNU/1v8zrjVfGU8xBkdUwOtbeudG/raIi2/pvyhDgL3YUzPjMKyq40htdrW4wLIYOr3KgdebnNEUAjNC6hgCeh1iChfhVuf33vSDzvZ6agLDk3KSAhzuCtsIpIGF5yjET+jOLwTTSrHB/4FRoxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78yAgYNY8Y8yJ6lUx8OcrYYe8IzqyVHCGwhne4Mz7Dw=;
 b=HTb+XtXMRR3h9buFObaxONhdv1DgZzKrjjzzDlyQmDyyais1ePgmv4nnAnqu5Tjw7tdUbFXAj1fp8AaoRmdTbKWRa6PdUn6Jj5RnJoqw84Aq4fbAxkpfnbfpyiRDQJwTnkY4YEI56jyvmQ/asD5SBkbSh70vSBPLDe5CzSRlIm7Tk4UL1TSJcLaqr/GhjHD7W5ntgo3iAV8szGca79pxJ9D8wp1C/+Pf2m2vzfiaaEEbtCLrs2iMZVEQsOMkz0JK5kfYFZ7FEnDx1qhsQ2izSHejbYx1g7yVYuQsQXgxK58wI/hy9hOnq7Y7jqbC/iV4H42kE6FvtEKgY4WeXpkBog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78yAgYNY8Y8yJ6lUx8OcrYYe8IzqyVHCGwhne4Mz7Dw=;
 b=kMO6IdyLUnZ51tf6anFG1uJ0ezsiFhn4PeGRxvzZqfRyHLoyIsshnMeya29awd4lOPqx8G2xYLLTYQaRLPNRUL96NeJOL1wfpeFHhW71hFYWo+m+ZbOuOBoVVof2wM8o9iQcChIkqdKCryT8oCFWlP2M8w4xFRTql1mQvYBa0jRGakyynn7UnZkZ35a5FmCCZ/JlfEnRgR/FenY6UOAH8PrDkEvyEGPd/W+JLh8FfVt71t3UJVNfya2FjthcYhTPNelqtEUfkFUP/cFY9Bg3WzbaVOBMEUQJUSBgLIfLXGPheoMKz3uw8R8GOrYjPcMZQFneP6JXte9kxKBhfFwSIQ==
Received: from BN9PR03CA0864.namprd03.prod.outlook.com (2603:10b6:408:13d::29)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 23:34:53 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::a4) by BN9PR03CA0864.outlook.office365.com
 (2603:10b6:408:13d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 23:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Thu, 12 Feb 2026 23:34:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 15:34:32 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 12 Feb 2026 15:34:31 -0800
Received: from build-bwicaksono-noble-20251018.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 12 Feb 2026 15:34:30 -0800
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <irogers@google.com>, <james.clark@linaro.org>, <john.g.garry@oracle.com>,
	<will@kernel.org>, <mike.leach@linaro.org>, <leo.yan@linux.dev>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tmakin@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
	<skelley@nvidia.com>, <ywan@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <mochs@nvidia.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v2] perf vendor events arm64: Add Tegra410 Olympus PMU events
Date: Thu, 12 Feb 2026 23:34:07 +0000
Message-ID: <20260212233407.1432673-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: bcc38ec8-eb8e-4a05-81a8-08de6a8f52d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JZxk9x7JHkpcaw1QyNBAbWtgAKqwgxBrHf8IzgjHWQsszklnk0MVDi6tAPhJ?=
 =?us-ascii?Q?vHMaMW1gDb5M+ZcJtqjkV/NCihohXvKW/QsIuWUrMnfuNdNCvOC1P5vlA7yL?=
 =?us-ascii?Q?cld0d+rllL9OHwZBTeV5ckgygfTIwJ61i7tAzjaTGHfkWqbXaO75+QpyAAOU?=
 =?us-ascii?Q?7eYAixzDxy+8xlLhrwA2rXKg6f8EP6BkxuOuG4kMMz/WE9ftshxnOAv15G4b?=
 =?us-ascii?Q?eicmPdpgiZFxa7X8ef0wGtGtTneDhFVZbd5NX/wv7zEafK1UXCv/DKDKC9+6?=
 =?us-ascii?Q?yX9vD7k2j6tD+3aj3XRTDG3qMArKlzrfql0nWAfFp2x5Wt5YHmxg6O1RrOu5?=
 =?us-ascii?Q?LAisLr8eXE+Ql0309QMCuCb49CgmgPTXAaQC0QFo0sFtMYTFcCXNlypSjgJK?=
 =?us-ascii?Q?yPD1DfYg991igb2EQAy5khAuwBwZEj+zA+Vvt7ibXpFKD4t7f8+B0vH0pk6G?=
 =?us-ascii?Q?fDnWrDfZQPZaAy7OOB1gNNiYqQVTdhOyVExYMJPI2sBAVz/PsXHLJbcK9adu?=
 =?us-ascii?Q?djHP0x5ngkkhYpDO9gOI8GV4EVEuRZyPQuMmvqgL9/6/aZc1c6h0mwayc/im?=
 =?us-ascii?Q?mH/A90w7tZp0eRJRoS1a0z+7Xr5bl325dzCXgbXnaowdiJh1GpIV4HyvwrV5?=
 =?us-ascii?Q?i+FVtIEyYfWoqDYuugtI+GTUUzkYSJAuqjWBL3e4ZWHjaoUNxkRIuwSGzNEz?=
 =?us-ascii?Q?cQmf2WjME7bM96JKiWXtTj5FzCINZC8nZmcAfcq8F/585AKEnKkjKkjtZp04?=
 =?us-ascii?Q?6rk3ZXDnsciqK4Kg1qLLOKRVwt4il3uq8f6U3NhaM4doxOP+rMD2NvUeog9t?=
 =?us-ascii?Q?6sin/Rx4GQxkithPEShDU4Xmmo9car6SNGLkAUqS3vWA17C121hDS4YkDiP8?=
 =?us-ascii?Q?tBx++pMF6QoNUvB7yHabvBLXNXeULHkqOqmvw2/RgvKVmpiBU9pSTN99ri2c?=
 =?us-ascii?Q?epMy9FhSTvMlfylp6WvgU1bYQPO1JhaNS8Em19s/YtuE4lkYSc66xar88fn9?=
 =?us-ascii?Q?2c0Z6RozdYUx/WZdGYFy9rBPBUW1/p9/mql9598rsfbPg4DqZWDcUd+ZklLT?=
 =?us-ascii?Q?59sD6Z47pCnXWx77PoH+af5i2/VtV+aGEHe0Xj3558I0RTCM54LlaEscx/l9?=
 =?us-ascii?Q?vBuaPJaKVPt/WVbmdHYIxrTqVwABbCXcjjtmrDeHAxtmzvcOUXynDvzhobC/?=
 =?us-ascii?Q?kELhPLW62SClfBpEM3235kxfino9Zy5HKwiXCt17CQgSYb/09lsKGZyPMN4d?=
 =?us-ascii?Q?VHS2OWO/Zgm2l5BtBULqi2taBuFQ57x7DeBFPxDdhOQvv8nCepuLxpoM2FN1?=
 =?us-ascii?Q?9eiWoazfkXA1JYXyWfTEasXJ3QC0UpZkdPjovBy9ODF+vGWQpOEholkv6hkG?=
 =?us-ascii?Q?FJO+KIR/otBXeKymbqs4G6MzmWysgaXa77EkU28Kjm57YQlkNrLre2VwZVGd?=
 =?us-ascii?Q?PeeNI2B6trbZsRp4iGS6wBlZan3ihqoZRzgo7HwTOielVk1odqU17t38fVzJ?=
 =?us-ascii?Q?24JIr9C5XDpH1PmQwxDHMuHACn3Zvn6ebFJBTwCXnsbgxEmPZ66Oa+RU61Gq?=
 =?us-ascii?Q?XsWlSE8h7OZf/2F1Dx04emXSJ8irvlMffQz78aIO1W2/B74/trduH3Bgr1yz?=
 =?us-ascii?Q?U00dKzQMSHai/ZUJqj4mch3MkKz/RCl3L28URi7fkNt2kQrYXwkh9I1OGBRA?=
 =?us-ascii?Q?iYQKi6Pt1j79vELamb7tP+mOlWA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F9k5vlNlZWannaR6B2ZEX8G4hz+vORCzdW0gkD4rBxgvmojJakQW5nEAlhKFOu6lqGbjmIoAMf2T4a/ZpBKkTiRS6RlUZaOS9KuQpuvz4460KccfabO41AgMDUmYOILyXabeQ2jfHRFiLVMU5JtCGMpHIn0sYMmX78LMNaaKq/GetcJmU05b9fogHiJBUyN4T8lf6kUQCuh0jF2RomqJKIzGOc1B7wBJbnzIa/dvEP9zwlAnZ1jYbHgkxqbZBrtr/AA/1efuXpLvc6Yk6JvQGGXymjPYYrnasFNxWBlx9uzOE7fWIqVjWkjMH7dWXyp9TfR/uM11ilGk2Q2wTPySOvn0vKT/zPQXoHZSaBNJbTqxHDfCgOozxxdnEdu5T8EYVAfwQpG2LOfAOPluSTGiSDXl2DdXn2l67ML+lngyjWKwtq1IzUkuG9k9cJUTcypN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 23:34:53.3454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc38ec8-eb8e-4a05-81a8-08de6a8f52d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

Add JSON files for NVIDIA Tegra410 Olympus core PMU events.
Also updated the common-and-microarch.json.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---

Changes from v1:
  * Remove CHAIN event
  * Update event description and fix spelling and capitalization mistakes
Thanks to Ian and James for the review.
v1: https://lore.kernel.org/all/20260127225909.3296202-1-bwicaksono@nvidia.=
com/T/#u

---
 .../arch/arm64/common-and-microarch.json      |  85 +++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 .../arch/arm64/nvidia/t410/branch.json        |  45 ++
 .../arch/arm64/nvidia/t410/brbe.json          |   6 +
 .../arch/arm64/nvidia/t410/bus.json           |  48 ++
 .../arch/arm64/nvidia/t410/exception.json     |  62 ++
 .../arch/arm64/nvidia/t410/fp_operation.json  |  78 ++
 .../arch/arm64/nvidia/t410/general.json       |  15 +
 .../arch/arm64/nvidia/t410/l1d_cache.json     | 122 +++
 .../arch/arm64/nvidia/t410/l1i_cache.json     | 114 +++
 .../arch/arm64/nvidia/t410/l2d_cache.json     | 134 ++++
 .../arch/arm64/nvidia/t410/ll_cache.json      | 107 +++
 .../arch/arm64/nvidia/t410/memory.json        |  46 ++
 .../arch/arm64/nvidia/t410/metrics.json       | 722 ++++++++++++++++++
 .../arch/arm64/nvidia/t410/misc.json          | 642 ++++++++++++++++
 .../arch/arm64/nvidia/t410/retired.json       |  94 +++
 .../arch/arm64/nvidia/t410/spe.json           |  42 +
 .../arm64/nvidia/t410/spec_operation.json     | 230 ++++++
 .../arch/arm64/nvidia/t410/stall.json         | 145 ++++
 .../arch/arm64/nvidia/t410/tlb.json           | 158 ++++
 20 files changed, 2896 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/brbe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/exception.=
json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/fp_operati=
on.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/general.js=
on
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l1d_cache.=
json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l1i_cache.=
json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l2d_cache.=
json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/ll_cache.j=
son
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.js=
on
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/retired.js=
on
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/spec_opera=
tion.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/tlb.json

diff --git a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json b/t=
ools/perf/pmu-events/arch/arm64/common-and-microarch.json
index 468cb085d879..144325d87be4 100644
--- a/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
+++ b/tools/perf/pmu-events/arch/arm64/common-and-microarch.json
@@ -1512,11 +1512,26 @@
         "EventName": "L2D_CACHE_REFILL_PRFM",
         "BriefDescription": "Level 2 data cache refill, software preload"
     },
+    {
+        "EventCode": "0x8150",
+        "EventName": "L3D_CACHE_RW",
+        "BriefDescription": "Level 3 data cache demand access."
+    },
+    {
+        "EventCode": "0x8151",
+        "EventName": "L3D_CACHE_PRFM",
+        "BriefDescription": "Level 3 data cache software prefetch"
+    },
     {
         "EventCode": "0x8152",
         "EventName": "L3D_CACHE_MISS",
         "BriefDescription": "Level 3 data cache demand access miss"
     },
+    {
+        "EventCode": "0x8153",
+        "EventName": "L3D_CACHE_REFILL_PRFM",
+        "BriefDescription": "Level 3 data cache refill, software prefetch."
+    },
     {
         "EventCode": "0x8154",
         "EventName": "L1D_CACHE_HWPRF",
@@ -1527,6 +1542,11 @@
         "EventName": "L2D_CACHE_HWPRF",
         "BriefDescription": "Level 2 data cache hardware prefetch."
     },
+    {
+        "EventCode": "0x8156",
+        "EventName": "L3D_CACHE_HWPRF",
+        "BriefDescription": "Level 3 data cache hardware prefetch."
+    },
     {
         "EventCode": "0x8158",
         "EventName": "STALL_FRONTEND_MEMBOUND",
@@ -1682,6 +1702,11 @@
         "EventName": "L2D_CACHE_REFILL_HWPRF",
         "BriefDescription": "Level 2 data cache refill, hardware prefetch."
     },
+    {
+        "EventCode": "0x81BE",
+        "EventName": "L3D_CACHE_REFILL_HWPRF",
+        "BriefDescription": "Level 3 data cache refill, hardware prefetch."
+    },
     {
         "EventCode": "0x81C0",
         "EventName": "L1I_CACHE_HIT_RD",
@@ -1712,11 +1737,31 @@
         "EventName": "L1I_CACHE_HIT_RD_FPRFM",
         "BriefDescription": "Level 1 instruction cache demand fetch first =
hit, fetched by software preload"
     },
+    {
+        "EventCode": "0x81DC",
+        "EventName": "L1D_CACHE_HIT_RW_FPRFM",
+        "BriefDescription": "Level 1 data cache demand access first hit, f=
etched by software prefetch."
+    },
     {
         "EventCode": "0x81E0",
         "EventName": "L1I_CACHE_HIT_RD_FHWPRF",
         "BriefDescription": "Level 1 instruction cache demand fetch first =
hit, fetched by hardware prefetcher"
     },
+    {
+        "EventCode": "0x81EC",
+        "EventName": "L1D_CACHE_HIT_RW_FHWPRF",
+        "BriefDescription": "Level 1 data cache demand access first hit, f=
etched by hardware prefetcher."
+    },
+    {
+        "EventCode": "0x81F0",
+        "EventName": "L1I_CACHE_HIT_RD_FPRF",
+        "BriefDescription": "Level 1 instruction cache demand fetch first =
hit, fetched by prefetch."
+    },
+    {
+        "EventCode": "0x81FC",
+        "EventName": "L1D_CACHE_HIT_RW_FPRF",
+        "BriefDescription": "Level 1 data cache demand access first hit, f=
etched by prefetch."
+    },
     {
         "EventCode": "0x8200",
         "EventName": "L1I_CACHE_HIT",
@@ -1767,11 +1812,26 @@
         "EventName": "L1I_LFB_HIT_RD_FPRFM",
         "BriefDescription": "Level 1 instruction cache demand fetch line-f=
ill buffer first hit, recently fetched by software preload"
     },
+    {
+        "EventCode": "0x825C",
+        "EventName": "L1D_LFB_HIT_RW_FPRFM",
+        "BriefDescription": "Level 1 data cache demand access line-fill bu=
ffer first hit, recently fetched by software prefetch."
+    },
     {
         "EventCode": "0x8260",
         "EventName": "L1I_LFB_HIT_RD_FHWPRF",
         "BriefDescription": "Level 1 instruction cache demand fetch line-f=
ill buffer first hit, recently fetched by hardware prefetcher"
     },
+    {
+        "EventCode": "0x826C",
+        "EventName": "L1D_LFB_HIT_RW_FHWPRF",
+        "BriefDescription": "Level 1 data cache demand access line-fill bu=
ffer first hit, recently fetched by hardware prefetcher."
+    },
+    {
+        "EventCode": "0x827C",
+        "EventName": "L1D_LFB_HIT_RW_FPRF",
+        "BriefDescription": "Level 1 data cache demand access line-fill bu=
ffer first hit, recently fetched by prefetch."
+    },
     {
         "EventCode": "0x8280",
         "EventName": "L1I_CACHE_PRF",
@@ -1807,6 +1867,11 @@
         "EventName": "LL_CACHE_REFILL",
         "BriefDescription": "Last level cache refill"
     },
+    {
+        "EventCode": "0x828E",
+        "EventName": "L3D_CACHE_REFILL_PRF",
+        "BriefDescription": "Level 3 data cache refill, prefetch."
+    },
     {
         "EventCode": "0x8320",
         "EventName": "L1D_CACHE_REFILL_PERCYC",
@@ -1872,6 +1937,16 @@
         "EventName": "FP_FP8_MIN_SPEC",
         "BriefDescription": "Floating-point operation speculatively_execut=
ed, smallest type is 8-bit floating-point."
     },
+    {
+        "EventCode": "0x8480",
+        "EventName": "FP_SP_FIXED_MIN_OPS_SPEC",
+        "BriefDescription": "Non-scalable element arithmetic operations sp=
eculatively executed, smallest type is single-precision floating-point."
+    },
+    {
+        "EventCode": "0x8482",
+        "EventName": "FP_HP_FIXED_MIN_OPS_SPEC",
+        "BriefDescription": "Non-scalable element arithmetic operations sp=
eculatively executed, smallest type is half-precision floating-point."
+    },
     {
         "EventCode": "0x8483",
         "EventName": "FP_BF16_FIXED_MIN_OPS_SPEC",
@@ -1882,6 +1957,16 @@
         "EventName": "FP_FP8_FIXED_MIN_OPS_SPEC",
         "BriefDescription": "Non-scalable element arithmetic operations sp=
eculatively executed, smallest type is 8-bit floating-point."
     },
+    {
+        "EventCode": "0x8488",
+        "EventName": "FP_SP_SCALE_MIN_OPS_SPEC",
+        "BriefDescription": "Scalable element arithmetic operations specul=
atively executed, smallest type is single-precision floating-point."
+    },
+    {
+        "EventCode": "0x848A",
+        "EventName": "FP_HP_SCALE_MIN_OPS_SPEC",
+        "BriefDescription": "Scalable element arithmetic operations specul=
atively executed, smallest type is half-precision floating-point."
+    },
     {
         "EventCode": "0x848B",
         "EventName": "FP_BF16_SCALE_MIN_OPS_SPEC",
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-=
events/arch/arm64/mapfile.csv
index bb3fa8a33496..7f0eaa702048 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -46,3 +46,4 @@
 0x00000000500f0000,v1,ampere/emag,core
 0x00000000c00fac30,v1,ampere/ampereone,core
 0x00000000c00fac40,v1,ampere/ampereonex,core
+0x000000004e0f0100,v1,nvidia/t410,core
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json b/too=
ls/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
new file mode 100644
index 000000000000..ef4effc00ec3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
@@ -0,0 +1,45 @@
+[
+    {
+        "ArchStdEvent": "BR_MIS_PRED",
+        "PublicDescription": "This event counts branches which are specula=
tively executed and mispredicted."
+    },
+    {
+        "ArchStdEvent": "BR_PRED",
+        "PublicDescription": "This event counts all speculatively executed=
 branches."
+    },
+    {
+        "EventCode": "0x017e",
+        "EventName": "BR_PRED_BTB_CTX_UPDATE",
+        "PublicDescription": "Branch context table update."
+    },
+    {
+        "EventCode": "0x0188",
+        "EventName": "BR_MIS_PRED_DIR_RESOLVED",
+        "PublicDescription": "Number of branch misprediction due to direct=
ion misprediction."
+    },
+    {
+        "EventCode": "0x0189",
+        "EventName": "BR_MIS_PRED_DIR_UNCOND_RESOLVED",
+        "PublicDescription": "Number of branch misprediction due to direct=
ion misprediction for unconditional branches."
+    },
+    {
+        "EventCode": "0x018a",
+        "EventName": "BR_MIS_PRED_DIR_UNCOND_DIRECT_RESOLVED",
+        "PublicDescription": "Number of branch misprediction due to direct=
ion misprediction for unconditional direct branches."
+    },
+    {
+        "EventCode": "0x018b",
+        "EventName": "BR_PRED_MULTI_RESOLVED",
+        "PublicDescription": "Number of resolved branch which made predict=
ion by polymorphic indirect predictor."
+    },
+    {
+        "EventCode": "0x018c",
+        "EventName": "BR_MIS_PRED_MULTI_RESOLVED",
+        "PublicDescription": "Number of branch misprediction which made pr=
ediction by polymorphic indirect predictor."
+    },
+    {
+        "EventCode": "0x01e4",
+        "EventName": "BR_RGN_RECLAIM",
+        "PublicDescription": "This event counts the Indirect predictor ent=
ries flushed by region reclamation."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/brbe.json b/tools=
/perf/pmu-events/arch/arm64/nvidia/t410/brbe.json
new file mode 100644
index 000000000000..9c315b2d7046
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/brbe.json
@@ -0,0 +1,6 @@
+[
+    {
+        "ArchStdEvent": "BRB_FILTRATE",
+        "PublicDescription": "This event counts each valid branch record c=
aptured in the branch record buffer. Branch records that are not captured b=
ecause they are removed by filtering are not counted."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/bus.json b/tools/=
perf/pmu-events/arch/arm64/nvidia/t410/bus.json
new file mode 100644
index 000000000000..5bb8de617c68
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/bus.json
@@ -0,0 +1,48 @@
+[
+    {
+        "ArchStdEvent": "BUS_ACCESS",
+        "PublicDescription": "This event counts the number of data-beat ac=
cesses between the CPU and the external bus. This count includes accesses d=
ue to read, write, and snoop. Each beat of data is counted individually."
+    },
+    {
+        "ArchStdEvent": "BUS_CYCLES",
+        "PublicDescription": "This event counts bus cycles in the CPU. Bus=
 cycles represent a clock cycle in which a transaction could be sent or rec=
eived on the interface from the CPU to the external bus. Since that interfa=
ce is driven at the same clock speed as the CPU, this event increments at t=
he rate of CPU clock. Regardless of the WFE/WFI state of the PE, this event=
 increments on each processor clock."
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD",
+        "PublicDescription": "This event counts memory Read transactions s=
een on the external bus. Each beat of data is counted individually."
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR",
+        "PublicDescription": "This event counts memory Write transactions =
seen on the external bus. Each beat of data is counted individually."
+    },
+    {
+        "EventCode": "0x0154",
+        "EventName": "BUS_REQUEST_REQ",
+        "PublicDescription": "Bus request, request."
+    },
+    {
+        "EventCode": "0x0155",
+        "EventName": "BUS_REQUEST_RETRY",
+        "PublicDescription": "Bus request, retry."
+    },
+    {
+        "EventCode": "0x0198",
+        "EventName": "L2_CHI_CBUSY0",
+        "PublicDescription": "Number of RXDAT or RXRSP response received w=
idth CBusy of 0."
+    },
+    {
+        "EventCode": "0x0199",
+        "EventName": "L2_CHI_CBUSY1",
+        "PublicDescription": "Number of RXDAT or RXRSP response received w=
idth CBusy of 1."
+    },
+    {
+        "EventCode": "0x019a",
+        "EventName": "L2_CHI_CBUSY2",
+        "PublicDescription": "Number of RXDAT or RXRSP response received w=
idth CBusy of 2."
+    },
+    {
+        "EventCode": "0x019b",
+        "EventName": "L2_CHI_CBUSY3",
+        "PublicDescription": "Number of RXDAT or RXRSP response received w=
idth CBusy of 3."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/exception.json b/=
tools/perf/pmu-events/arch/arm64/nvidia/t410/exception.json
new file mode 100644
index 000000000000..ecd996c3610b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/exception.json
@@ -0,0 +1,62 @@
+[
+    {
+        "ArchStdEvent": "EXC_TAKEN",
+        "PublicDescription": "This event counts any taken architecturally =
visible exceptions such as IRQ, FIQ, SError, and other synchronous exceptio=
ns. Exceptions are counted whether or not they are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_RETURN",
+        "PublicDescription": "This event counts any architecturally execut=
ed exception return instructions. For example: AArch64: ERET."
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF",
+        "PublicDescription": "This event counts the number of synchronous =
exceptions which are taken locally that are due to attempting to execute an=
 instruction that is UNDEFINED.\nAttempting to execute instruction bit patt=
erns that have not been allocated.\nAttempting to execute instructions when=
 they are disabled.\nAttempting to execute instructions at an inappropriate=
 Exception level.\nAttempting to execute an instruction when the value of P=
STATE.IL is 1."
+    },
+    {
+        "ArchStdEvent": "EXC_SVC",
+        "PublicDescription": "This event counts SVC exceptions taken local=
ly."
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT",
+        "PublicDescription": "This event counts synchronous exceptions tha=
t are taken locally and caused by Instruction Aborts."
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT",
+        "PublicDescription": "This event counts exceptions that are taken =
locally and are caused by data aborts or SErrors. Conditions that could cau=
se those exceptions are attempting to read or write memory where the MMU ge=
nerates a fault, attempting to read or write memory with a misaligned addre=
ss, Interrupts from the nSEI inputs and internally generated SErrors."
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ",
+        "PublicDescription": "This event counts IRQ exceptions including t=
he virtual IRQs that are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+        "PublicDescription": "This event counts FIQ exceptions including t=
he virtual FIQs that are taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_SMC",
+        "PublicDescription": "This event counts SMC exceptions taken to EL=
3."
+    },
+    {
+        "ArchStdEvent": "EXC_HVC",
+        "PublicDescription": "This event counts HVC exceptions taken to EL=
2."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT",
+        "PublicDescription": "This event counts exceptions which are traps=
 not taken locally and are caused by Instruction Aborts. For example, attem=
pting to execute an instruction with a misaligned PC."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT",
+        "PublicDescription": "This event counts exceptions which are traps=
 not taken locally and are caused by Data Aborts or SError Interrupts. Cond=
itions that could cause those exceptions are:\n* Attempting to read or writ=
e memory where the MMU generates a fault,\n* Attempting to read or write me=
mory with a misaligned address,\n* Interrupts from the SEI input,\n* Intern=
ally generated SErrors."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER",
+        "PublicDescription": "This event counts the number of synchronous =
trap exceptions which are not taken locally and are not SVC, SMC, HVC, Data=
 Aborts, Instruction Aborts, or Interrupts."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ",
+        "PublicDescription": "This event counts IRQ exceptions including t=
he virtual IRQs that are not taken locally."
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ",
+        "PublicDescription": "This event counts FIQs which are not taken l=
ocally but taken from EL0, EL1, or EL2 to EL3 (which would be the normal be=
havior for FIQs when not executing in EL3)."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/fp_operation.json=
 b/tools/perf/pmu-events/arch/arm64/nvidia/t410/fp_operation.json
new file mode 100644
index 000000000000..3588e130781d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/fp_operation.json
@@ -0,0 +1,78 @@
+[
+    {
+        "ArchStdEvent": "FP_HP_SPEC",
+        "PublicDescription": "This event counts speculatively executed hal=
f precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_SP_SPEC",
+        "PublicDescription": "This event counts speculatively executed sin=
gle precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_DP_SPEC",
+        "PublicDescription": "This event counts speculatively executed dou=
ble precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_SCALE_OPS_SPEC",
+        "PublicDescription": "This event counts speculatively executed sca=
lable single precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_FIXED_OPS_SPEC",
+        "PublicDescription": "This event counts speculatively executed non=
-scalable single precision floating point operations."
+    },
+    {
+        "ArchStdEvent": "FP_HP_SCALE_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed scalable element arithmetic operation, due to an instruction=
 where the largest type was half-precision floating-point, where v is a val=
ue such that (v*(VL/128)) is the number of arithmetic operations carried ou=
t by the operation or instruction which causes the counter to increment.\nT=
his event does not count operations that are counted by FP_FIXED_OPS_SPEC o=
r FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_HP_FIXED_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed non-scalable element arithmetic operation, due to an instruc=
tion where the largest type was half-precision floating-point, where v is t=
he number of arithmetic operations carried out by the operation or which in=
struction causes the event to increment.\nThis event does not count operati=
ons that are counted by FP_SCALE_OPS_SPEC or FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_SP_SCALE_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed scalable element arithmetic operation, due to an instruction=
 where the largest type was single-precision floating-point, where v is a v=
alue such that (v*(VL/128)) is the number of arithmetic operations carried =
out by the operation or instruction which causes the event to increment.\nT=
his event does not count operations that are counted by FP_FIXED_OPS_SPEC o=
r FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_SP_FIXED_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed non-scalable element arithmetic operation, due to an instruc=
tion where the largest type was single-precision floating-point, where v is=
 the number of arithmetic operations carried out by the operation or instru=
ction which causes the event to increment.\nThis event does not count opera=
tions that are counted by FP_SCALE_OPS_SPEC or FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_DP_SCALE_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed scalable element arithmetic operation, due to an instruction=
 where the largest type was double-precision floating-point, where v is a v=
alue such that (v*(VL/128)) is the number of arithmetic operations carried =
out by the operation or instruction which causes the event to increment.\nT=
his event does not count operations that are counted by FP_FIXED_OPS_SPEC o=
r FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_DP_FIXED_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed non-scalable element arithmetic operation, due to an instruc=
tion where the largest type was double-precision floating-point, where v is=
 the number of arithmetic operations carried out by the operation or instru=
ction which causes the event to increment.\nThis event does not count opera=
tions that are counted by FP_SCALE_OPS_SPEC or FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_SP_FIXED_MIN_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed non-scalable element arithmetic operation, due to an instruc=
tion where the smallest type was single-precision floating-point, where v i=
s the number of arithmetic operations carried out by the operation or instr=
uction which causes the event to increment.\nThis event does not count oper=
ations that are counted by FP_SCALE_OPS_SPEC or FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_HP_FIXED_MIN_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed non-scalable element arithmetic operation, due to an instruc=
tion where the smallest type was half-precision floating-point, where v is =
the number of arithmetic operations carried out by the operation or instruc=
tion which causes the event to increment.\nThis event does not count operat=
ions that are counted by FP_SCALE_OPS_SPEC or FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_BF16_FIXED_MIN_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed non-scalable element arithmetic operation, due to an instruc=
tion where the smallest type was BFloat16 floating-point. Where v is the nu=
mber of arithmetic operations carried out by the operation or instruction w=
hich causes the event to increment. This event does not count operations th=
at are counted by FP_SCALE_OPS_SPEC or FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_FP8_FIXED_MIN_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed non-scalable element arithmetic operation, due to an instruc=
tion where the smallest type was 8-bit floating-point, where v is the numbe=
r of arithmetic operations carried out by the operation or instruction whic=
h causes the event to increment.\nThis event does not count operations that=
 are counted by FP_SCALE_OPS_SPEC or FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_SP_SCALE_MIN_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed scalable element arithmetic operation, due to an instruction=
 where the smallest type was single-precision floating-point, where v is a =
value such that (v*(VL/128)) is the number of arithmetic operations carried=
 out by the operation or instruction which causes the event to increment.\n=
This event does not count operations that are counted by FP_FIXED_OPS_SPEC =
or FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_HP_SCALE_MIN_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed scalable element arithmetic operation, due to an instruction=
 where the smallest type was half-precision floating-point, where v is a va=
lue such that (v*(VL/128)) is the number of arithmetic operations carried o=
ut by the operation or instruction which causes the event to increment.\nTh=
is event does not count operations that are counted by FP_FIXED_OPS_SPEC or=
 FP_SCALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_BF16_SCALE_MIN_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed scalable element arithmetic operation, due to an instruction=
 where the smallest type was BFloat16 floating-point, where v is a value su=
ch that (v*(VL/128)) is the number of arithmetic operations carried out by =
the operation or instruction which causes the event to increment.\nThis eve=
nt does not count operations that are counted by FP_FIXED_OPS_SPEC or FP_SC=
ALE2_OPS_SPEC."
+    },
+    {
+        "ArchStdEvent": "FP_FP8_SCALE_MIN_OPS_SPEC",
+        "PublicDescription": "This event increments by v for each speculat=
ively executed scalable element arithmetic operation, due to an instruction=
 where the smallest type was 8-bit floating-point, where v is a value such =
that (v*(VL/128)) is the number of arithmetic operations carried out by the=
 operation or instruction which causes the event to increment.\nThis event =
does not count operations that are counted by FP_FIXED_OPS_SPEC or FP_SCALE=
2_OPS_SPEC."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/general.json b/to=
ols/perf/pmu-events/arch/arm64/nvidia/t410/general.json
new file mode 100644
index 000000000000..bd9c248387aa
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/general.json
@@ -0,0 +1,15 @@
+[
+    {
+        "ArchStdEvent": "CPU_CYCLES",
+        "PublicDescription": "This event counts CPU clock cycles when the =
PE is not in WFE/WFI. The clock measured by this event is defined as the ph=
ysical clock driving the CPU logic."
+    },
+    {
+        "ArchStdEvent": "CNT_CYCLES",
+        "PublicDescription": "This event increments at a constant frequenc=
y equal to the rate of increment of the System Counter, CNTPCT_EL0.\nThis e=
vent does not increment when the PE is in WFE/WFI."
+    },
+    {
+        "EventCode": "0x01e1",
+        "EventName": "CPU_SLOT",
+        "PublicDescription": "Entitled CPU slots.\nThis event counts the n=
umber of slots. When in ST mode, this event shall increment by PMMIR_EL1.SL=
OTS quantities, and when in SMT partitioned resource mode (regardless of in=
 WFI state or otherwise), this event is incremented by PMMIR_EL1.SLOTS/2 qu=
antities."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/l1d_cache.json b/=
tools/perf/pmu-events/arch/arm64/nvidia/t410/l1d_cache.json
new file mode 100644
index 000000000000..ed6f764eff24
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/l1d_cache.json
@@ -0,0 +1,122 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL",
+        "PublicDescription": "This event counts L1 D-cache refills caused =
by speculatively executed load or store operations, preload instructions, o=
r hardware cache prefetching that missed in the L1 D-cache. This event only=
 counts one event per cache line.\nSince the caches are Write-back only for=
 this processor, there are no Write-through cache accesses."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE",
+        "PublicDescription": "This event counts L1 D-cache accesses from a=
ny load/store operations, software preload, or hardware prefetch operations=
. Atomic operations that resolve in the CPU's caches (near atomic operation=
s) count as both a write access and read access. Each access to a cache lin=
e is counted including the multiple accesses caused by single instructions =
such as LDM or STM. Each access to other L1 data or unified memory structur=
es, for example refill buffers, write buffers, and write-back buffers, are =
also counted.\nThis event counts the sum of the following events:\nL1D_CACH=
E_RD,\nL1D_CACHE_WR,\nL1D_CACHE_PRFM, and\nL1D_CACHE_HWPRF."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB",
+        "PublicDescription": "This event counts write-backs of dirty data =
from the L1 D-cache to the L2 cache. This occurs when either a dirty cache =
line is evicted from L1 D-cache and allocated in the L2 cache or dirty data=
 is written to the L2 and possibly to the next level of cache. This event c=
ounts both victim cache line evictions and cache write-backs from snoops or=
 cache maintenance operations. The following cache operations are not count=
ed:\n* Invalidations which do not result in data being transferred out of t=
he L1 (such as evictions of clean data),\n* Full line writes which write to=
 L2 without writing L1, such as write streaming mode.\nThis event is the su=
m of the following events:\nL1D_CACHE_WB_CLEAN and\nL1D_CACHE_WB_VICTIM."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_LMISS_RD",
+        "PublicDescription": "This event counts cache line refills into th=
e L1 D-cache from any memory Read operations, that incurred additional late=
ncy.\nCounts same as L1D_CACHE_REFILL_RD on this CPU."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+        "PublicDescription": "This event counts L1 D-cache accesses from a=
ny Load operation. Atomic Load operations that resolve in the CPU's caches =
count as both a write access and read access."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+        "PublicDescription": "This event counts L1 D-cache accesses genera=
ted by Store operations. This event also counts accesses caused by a DC ZVA=
 (D-cache zero, specified by virtual address) instruction. Near atomic oper=
ations that resolve in the CPU's caches count as a write access and read ac=
cess.\nThis event is a subset of the L1D_CACHE event, except this event onl=
y counts memory Write operations."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+        "PublicDescription": "This event counts L1 D-cache refills caused =
by speculatively executed Load instructions where the memory Read operation=
 misses in the L1 D-cache. This event only counts one event per cache line.=
\nThis event is a subset of the L1D_CACHE_REFILL event, but only counts mem=
ory Read operations. This event does not count reads caused by cache mainte=
nance operations or preload instructions."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
+        "PublicDescription": "This event counts L1 D-cache refills caused =
by speculatively executed Store instructions where the memory Write operati=
on misses in the L1 D-cache. This event only counts one event per cache lin=
e.\nThis event is a subset of the L1D_CACHE_REFILL event, but only counts m=
emory Write operations."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
+        "PublicDescription": "This event counts L1 D-cache refills (L1D_CA=
CHE_REFILL) where the cache line data came from caches inside the immediate=
 Cluster of the Core (L2 cache)."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
+        "PublicDescription": "This event counts L1 D-cache refills (L1D_CA=
CHE_REFILL) for which the cache line data came from outside the immediate C=
luster of the Core, like an SLC in the system interconnect or DRAM or remot=
e socket."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
+        "PublicDescription": "This event counts dirty cache line evictions=
 from the L1 D-cache caused by a new cache line allocation. This event does=
 not count evictions caused by cache maintenance operations.\nThis event is=
 a subset of the L1D_CACHE_WB event, but only counts write-backs that are a=
 result of the line being allocated for an access made by the CPU."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
+        "PublicDescription": "This event counts write-backs from the L1 D-=
cache that are a result of a coherency operation made by another CPU. Event=
 counts include cache maintenance operations.\nThis event is a subset of th=
e L1D_CACHE_WB event."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+        "PublicDescription": "This event counts each explicit invalidation=
 of a cache line in the L1 D-cache caused by:\n* Cache Maintenance Operatio=
ns (CMO) that operate by a virtual address.\n* Broadcast cache coherency op=
erations from another CPU in the system.\nThis event does not count for the=
 following conditions:\n* A cache refill invalidates a cache line.\n* A CMO=
 which is executed on that CPU and invalidates a cache line specified by Se=
t/Way.\nNote that CMOs that operate by Set/Way cannot be broadcast from one=
 CPU to another."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_RW",
+        "PublicDescription": "This event counts L1 data demand cache acces=
ses from any Load or Store operation. Near atomic operations that resolve i=
n the CPU's caches count as both a write access and read access.\nThis even=
t is implemented as L1D_CACHE_RD + L1D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_PRFM",
+        "PublicDescription": "This event counts L1 D-cache accesses from s=
oftware preload or prefetch instructions."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_MISS",
+        "PublicDescription": "This event counts each demand access counted=
 by L1D_CACHE_RW that misses in the L1 Data or unified cache, causing an ac=
cess to outside of the L1 caches of this PE."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_PRFM",
+        "PublicDescription": "This event counts L1 D-cache refills where t=
he cache line access was generated by software preload or prefetch instruct=
ions."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_HWPRF",
+        "PublicDescription": "This event counts L1 D-cache accesses from a=
ny Load/Store operations generated by the hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_HWPRF",
+        "PublicDescription": "This event counts each hardware prefetch acc=
ess counted by L1D_CACHE_HWPRF that causes a refill of the L1 D-cache from =
outside of the L1 D-cache."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_HIT_RW_FPRFM",
+        "PublicDescription": "This event counts each demand access first h=
it counted by L1D_CACHE_HIT_RW_FPRF where the cache line was fetched in res=
ponse to a prefetch instruction. That is, the L1D_CACHE_REFILL_PRFM event w=
as generated when the cache line was fetched into the cache.\nOnly the firs=
t hit by a demand access is counted. After this event is generated for a ca=
che line, the event is not generated again for the same cache line while it=
 remains in the cache."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_HIT_RW_FHWPRF",
+        "PublicDescription": "This event counts each demand access first h=
it counted by L1D_CACHE_HIT_RW_FPRF where the cache line was fetched by a h=
ardware prefetcher. That is, the L1D_CACHE_REFILL_HWPRF Event was generated=
 when the cache line was fetched into the cache.\nOnly the first hit by a d=
emand access is counted. After this event is generated for a cache line, th=
e event is not generated again for the same cache line while it remains in =
the cache."
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_HIT_RW_FPRF",
+        "PublicDescription": "This event counts each demand access first h=
it counted by L1D_CACHE_HIT_RW where the cache line was fetched in response=
 to a prefetch instruction or by a hardware prefetcher. That is, the L1D_CA=
CHE_REFILL_PRF event was generated when the cache line was fetched into the=
 cache.\nOnly the first hit by a demand access is counted. After this event=
 is generated for a cache line, the event is not generated again for the sa=
me cache line while it remains in the cache."
+    },
+    {
+        "ArchStdEvent": "L1D_LFB_HIT_RW_FPRFM",
+        "PublicDescription": "This event counts each demand access line-fi=
ll buffer first hit counted by L1D_LFB_HIT_RW_FPRF where the cache line was=
 fetched in response to a prefetch instruction. That is, the access hits a =
cache line that is in the process of being loaded into the L1 D-cache, and =
so does not generate a new refill, but has to wait for the previous refill =
to complete, and the L1D_CACHE_REFILL_PRFM event was generated when the cac=
he line was fetched into the cache.\nOnly the first hit by a demand access =
is counted. After this event is generated for a cache line, the event is no=
t generated again for the same cache line while it remains in the cache."
+    },
+    {
+        "ArchStdEvent": "L1D_LFB_HIT_RW_FHWPRF",
+        "PublicDescription": "This event counts each demand access line-fi=
ll buffer first hit counted by L1D_LFB_HIT_RW_FPRF, where the cache line wa=
s fetched by a hardware prefetcher. That is, the access hits a cache line t=
hat is in the process of being loaded into the L1 D-cache, and so does not =
generate a new refill, but has to wait for the previous refill to complete,=
 and the L1D_CACHE_REFILL_HWPRF Event was generated when the cache line was=
 fetched into the cache.\nOnly the first hit by a demand access is counted.=
 After this event is generated for a cache line, the event is not generated=
 again for the same cache line while it remains in the cache."
+    },
+    {
+        "ArchStdEvent": "L1D_LFB_HIT_RW_FPRF",
+        "PublicDescription": "This event counts each demand access line-fi=
ll buffer first hit counted by L1D_LFB_HIT_RW where the cache line was fetc=
hed in response to a prefetch instruction or by a hardware prefetcher. That=
 is, the access hits a cache line that is in the process of being loaded in=
to the L1 D-cache, and so does not generate a new refill, but has to wait f=
or the previous refill to complete, and the L1D_CACHE_REFILL_PRF event was =
generated when the cache line was fetched into the cache.\nOnly the first h=
it by a demand access is counted. After this event is generated for a cache=
 line, the event is not generated again for the same cache line while it re=
mains in the cache."
+    },
+    {
+        "EventCode": "0x01f5",
+        "EventName": "L1D_CACHE_REFILL_RW",
+        "PublicDescription": "L1 D-cache refill, demand Read and Write. Th=
is event counts demand Read and Write accesses that causes a refill of the =
L1 D-cache of this PE, from outside of this cache."
+    },
+    {
+        "EventCode": "0x0204",
+        "EventName": "L1D_CACHE_REFILL_OUTER_LLC",
+        "PublicDescription": "This event counts L1D_CACHE_REFILL from L3 D=
-cache."
+    },
+    {
+        "EventCode": "0x0205",
+        "EventName": "L1D_CACHE_REFILL_OUTER_DRAM",
+        "PublicDescription": "This event counts L1D_CACHE_REFILL from loca=
l memory."
+    },
+    {
+        "EventCode": "0x0206",
+        "EventName": "L1D_CACHE_REFILL_OUTER_REMOTE",
+        "PublicDescription": "This event counts L1D_CACHE_REFILL from a re=
mote memory."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/l1i_cache.json b/=
tools/perf/pmu-events/arch/arm64/nvidia/t410/l1i_cache.json
new file mode 100644
index 000000000000..952454004d98
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/l1i_cache.json
@@ -0,0 +1,114 @@
+[
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL",
+        "PublicDescription": "This event counts cache line refills in the =
L1 I-cache caused by a missed instruction fetch (demand, hardware prefetch,=
 and software preload accesses). Instruction fetches may include accessing =
multiple instructions, but the single cache line allocation is counted once=
."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE",
+        "PublicDescription": "This event counts instruction fetches (deman=
d, hardware prefetch, and software preload accesses) which access the L1 In=
struction Cache. Instruction Cache accesses caused by cache maintenance ope=
rations are not counted."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_LMISS",
+        "PublicDescription": "This event counts cache line refills into th=
e L1 I-cache, that incurred additional latency.\nCounts the same as L1I_CAC=
HE_REFILL in this CPU."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_RD",
+        "PublicDescription": "This event counts demand instruction fetches=
 which access the L1 I-cache."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_PRFM",
+        "PublicDescription": "This event counts instruction fetches genera=
ted by software preload or prefetch instructions which access the L1 I-cach=
e."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HWPRF",
+        "PublicDescription": "This event counts instruction fetches which =
access the L1 I-cache generated by the hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL_PRFM",
+        "PublicDescription": "This event counts cache line refills in the =
L1 I-cache caused by a missed instruction fetch generated by software prelo=
ad or prefetch instructions. Instruction fetches may include accessing mult=
iple instructions, but the single cache line allocation is counted once."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL_HWPRF",
+        "PublicDescription": "This event counts each hardware prefetch acc=
ess counted by L1I_CACHE_HWPRF that causes a refill of the Level 1I-cache f=
rom outside of the L1 I-cache."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HIT_RD",
+        "PublicDescription": "This event counts demand instruction fetches=
 that access the L1 I-cache and hit in the L1 I-cache."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HIT_RD_FPRF",
+        "PublicDescription": "This event counts each demand fetch first hi=
t counted by L1I_CACHE_HIT_RD where the cache line was fetched in response =
to a software preload or by a hardware prefetcher. That is, the L1I_CACHE_R=
EFILL_PRF event was generated when the cache line was fetched into the cach=
e.\nOnly the first hit by a demand access is counted. After this event is g=
enerated for a cache line, the event is not generated again for the same ca=
che line while it remains in the cache."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HIT",
+        "PublicDescription": "This event counts instruction fetches that a=
ccess the L1 I-cache (demand, hardware prefetch, and software preload acces=
ses) and hit in the L1 I-cache. I-cache accesses caused by cache maintenanc=
e operations are not counted."
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_HIT_PRFM",
+        "PublicDescription": "This event counts instruction fetches genera=
ted by software preload or prefetch instructions that access the L1 I-cache=
 and hit in the L1 I-cache."
+    },
+    {
+        "ArchStdEvent": "L1I_LFB_HIT_RD",
+        "PublicDescription": "This event counts demand instruction fetches=
 that access the L1 I-cache and hit in a line that is in the process of bei=
ng loaded into the L1 I-cache."
+    },
+    {
+        "EventCode": "0x0174",
+        "EventName": "L1I_HWPRF_REQ_DROP",
+        "PublicDescription": "L1 I-cache hardware prefetch dropped."
+    },
+    {
+        "EventCode": "0x01e3",
+        "EventName": "L1I_CACHE_REFILL_RD",
+        "PublicDescription": "L1 I-cache refill, Read.\nThis event counts =
demand instruction fetch that causes a refill of the L1 I-cache of this PE,=
 from outside of this cache."
+    },
+    {
+        "EventCode": "0x01ea",
+        "EventName": "L1I_CFC_ENTRIES",
+        "PublicDescription": "This event counts the CFC (Cache Fill Contro=
l) entries.\nThe CFC is the fill buffer for I-cache."
+    },
+    {
+        "EventCode": "0x01ef",
+        "EventName": "L1I_CACHE_INVAL",
+        "PublicDescription": "L1 I-cache invalidate.\nThis event counts ea=
ch explicit invalidation of a cache line in the L1 I-cache caused by:\n* Br=
oadcast cache coherency operations from another CPU in the system.\n* Inval=
idation dues to capacity eviction in L2 D-cache.\nThis event does not count=
 for the following conditions:\n* A cache refill invalidates a cache line.\=
n* A CMO which is executed on that CPU Core and invalidates a cache line sp=
ecified by Set/Way.\n* Cache Maintenance Operations (CMO) that operate by a=
 virtual address.\nNote that\n* CMOs that operate by Set/Way cannot be broa=
dcast from one CPU Core to another.\n* The CMO is treated as No-op for the =
purposes of L1 I-cache line invalidation, as this Core implements fully coh=
erent I-cache."
+    },
+    {
+        "EventCode": "0x0212",
+        "EventName": "L1I_CACHE_HIT_HWPRF",
+        "PublicDescription": "This event counts each hardware prefetch acc=
ess that hits an L1 I-cache."
+    },
+    {
+        "EventCode": "0x0215",
+        "EventName": "L1I_LFB_HIT",
+        "PublicDescription": "L1 Line fill buffer hit.\nThis event counts =
each Demand or software preload or hardware prefetch induced instruction fe=
tch that hits an L1 I-cache line that is in the process of being loaded int=
o the L1 instruction cache, and so does not generate a new refill, but has =
to wait for the previous refill to complete."
+    },
+    {
+        "EventCode": "0x0216",
+        "EventName": "L1I_LFB_HIT_PRFM",
+        "PublicDescription": "This event counts each software prefetch acc=
ess that hits a cache line that is in the process of being loaded into the =
L1 instruction cache, and so does not generate a new refill, but has to wai=
t for the previous refill to complete."
+    },
+    {
+        "EventCode": "0x0219",
+        "EventName": "L1I_LFB_HIT_HWPRF",
+        "PublicDescription": "This event counts each hardware prefetch acc=
ess that hits a cache line that is in the process of being loaded into the =
L1 instruction cache, and so does not generate a new refill, but has to wai=
t for the previous refill to complete."
+    },
+    {
+        "EventCode": "0x0221",
+        "EventName": "L1I_PRFM_REQ",
+        "PublicDescription": "L1 I-cache software prefetch requests."
+    },
+    {
+        "EventCode": "0x0222",
+        "EventName": "L1I_HWPRF_REQ",
+        "PublicDescription": "L1 I-cache hardware prefetch requests."
+    },
+    {
+        "EventCode": "0x0228",
+        "EventName": "L1I_CACHE_HIT_PRFM_FPRF",
+        "PublicDescription": "L1 I-cache software prefetch access first hi=
t, fetched by hardware or software prefetch.\nThis event counts each softwa=
re preload access first hit where the cache line was fetched in response to=
 a hardware prefetcher or software preload instruction.\nOnly the first hit=
 is counted. After this event is generated for a cache line, the event is n=
ot generated again for the same cache line while it remains in the cache."
+    },
+    {
+        "EventCode": "0x022a",
+        "EventName": "L1I_CACHE_HIT_HWPRF_FPRF",
+        "PublicDescription": "L1 I-cache hardware prefetch access first hi=
t, fetched by hardware or software prefetch.\nThis event counts each hardwa=
re prefetch access first hit where the cache line was fetched in response t=
o a hardware or prefetch instruction.\nOnly the first hit is counted. After=
 this event is generated for a cache line, the event is not generated again=
 for the same cache line while it remains in the cache."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/l2d_cache.json b/=
tools/perf/pmu-events/arch/arm64/nvidia/t410/l2d_cache.json
new file mode 100644
index 000000000000..66f21a94381e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/l2d_cache.json
@@ -0,0 +1,134 @@
+[
+    {
+        "ArchStdEvent": "L2D_CACHE",
+        "PublicDescription": "This event counts accesses to the L2 cache d=
ue to data accesses. L2 cache is a unified cache for data and instruction a=
ccesses. Accesses are for misses in the L1 D-cache or translation resolutio=
ns due to accesses. This event also counts write-back of dirty data from L1=
 D-cache to the L2 cache.\nI-cache accesses are included in this event. Thi=
s event is the sum of the following events:\nL2D_CACHE_RD,\nL2D_CACHE_WR,\n=
L2D_CACHE_PRFM, and\nL2D_CACHE_HWPRF."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL",
+        "PublicDescription": "This event counts cache line refills into th=
e L2 cache. L2 cache is a unified cache for data and instruction accesses. =
Accesses are for misses in the L1 D-cache or translation resolutions due to=
 accesses.\nI-cache refills are included in this event. This event is the s=
um of the following events:\nL2D_CACHE_REFILL_RD,\nL2D_CACHE_REFILL_WR,\nL2=
D_CACHE_REFILL_HWPRF, and\nL2D_CACHE_REFILL_PRFM."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB",
+        "PublicDescription": "This event counts write-backs of data from t=
he L2 cache to outside the CPU. This includes snoops to the L2 (from other =
CPUs) which return data even if the snoops cause an invalidation. L2 cache =
line invalidations which do not write data outside the CPU and snoops which=
 return data from an L1 cache are not counted. Data would not be written ou=
tside the cache when invalidating a clean cache line.\nThis event is the su=
m of the following events:\nL2D_CACHE_WB_VICTIM and\nL2D_CACHE_WB_CLEAN."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD",
+        "PublicDescription": "This event counts L2 D-cache accesses due to=
 memory Read operations. L2 cache is a unified cache for data and instructi=
on accesses, accesses are for misses in the L1 D-cache or translation resol=
utions due to accesses.\nI-cache accesses are included in this event. This =
event is a subset of the L2D_CACHE event, but this event only counts memory=
 Read operations."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR",
+        "PublicDescription": "This event counts L2 cache accesses due to m=
emory Write operations. L2 cache is a unified cache for data and instructio=
n accesses, accesses are for misses in the L1 D-cache or translation resolu=
tions due to accesses.\nThis event is a subset of the L2D_CACHE event, but =
this event only counts memory Write operations."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
+        "PublicDescription": "This event counts refills for memory accesse=
s due to memory Read operation counted by L2D_CACHE_RD. L2 cache is a unifi=
ed cache for data and instruction accesses, accesses are for misses in the =
L1 D-cache or translation resolutions due to accesses.\nThis CPU includes I=
-cache refills in this counter as an L2I equivalent event was not implement=
ed. This event is a subset of the L2D_CACHE_REFILL event. This event does n=
ot count L2 refills caused by stashes into L2.\nThis count includes demand =
requests that encounter an L2 prefetch request or an L2 software prefetch r=
equest to the same cache line, which is still pending in the L2 LFB."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
+        "PublicDescription": "This event counts refills for memory accesse=
s due to memory Write operation counted by L2D_CACHE_WR. L2 cache is a unif=
ied cache for data and instruction accesses, accesses are for misses in the=
 L1 D-cache or translation resolutions due to accesses.\nThis count include=
s demand requests that encounter an L2 prefetch request or an L2 software p=
refetch request to the same cache line, which is still pending in the L2 LF=
B."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
+        "PublicDescription": "This event counts evictions from the L2 cach=
e because of a line being allocated into the L2 cache.\nThis event is a sub=
set of the L2D_CACHE_WB event."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
+        "PublicDescription": "This event counts write-backs from the L2 ca=
che that are a result of any of the following:\n* Cache maintenance operati=
ons,\n* Snoop responses, or\n* Direct cache transfers to another CPU due to=
 a forwarding snoop request.\nThis event is a subset of the L2D_CACHE_WB ev=
ent."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL",
+        "PublicDescription": "This event counts each explicit invalidation=
 of a cache line in the L2 cache by cache maintenance operations that opera=
te by a virtual address, or by external coherency operations. This event do=
es not count if either:\n* A cache refill invalidates a cache line, or\n* A=
 cache Maintenance Operation (CMO), which invalidates a cache line specifie=
d by Set/Way,\nis executed on that CPU.\nCMOs that operate by Set/Way canno=
t be broadcast from one CPU to another."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_LMISS_RD",
+        "PublicDescription": "This event counts cache line refills into th=
e L2 unified cache from any memory Read operations that incurred additional=
 latency.\nCounts the same as L2D_CACHE_REFILL_RD in this CPU"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RW",
+        "PublicDescription": "This event counts L2 cache demand accesses f=
rom any Load/Store operations. L2 cache is a unified cache for data and ins=
truction accesses, accesses are for misses in the L1 D-cache or translation=
 resolutions due to accesses.\nI-cache accesses are included in this event.=
\nThis event is the sum of the following events:\nL2D_CACHE_RD and\nL2D_CAC=
HE_WR."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_PRFM",
+        "PublicDescription": "This event counts L2 D-cache accesses genera=
ted by software preload or prefetch instructions with target =3D L1/L2/L3 c=
ache.\nNote that a software preload or prefetch instructions with (target =
=3D L1/L2/L3) that hits in L1D will not result in an L2 D-cache access. The=
refore, such a software preload or prefetch instructions will not be counte=
d by this event."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_MISS",
+        "PublicDescription": "This event counts cache line misses in the L=
2 cache. L2 cache is a unified cache for data and instruction accesses. Acc=
esses are for misses in the L1 D-cache or translation resolutions due to ac=
cesses.\nThis event counts the same as L2D_CACHE_REFILL_RD in this CPU."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_PRFM",
+        "PublicDescription": "This event counts refills due to accesses ge=
nerated as a result of software preload or prefetch instructions as counted=
 by L2D_CACHE_PRFM. I-cache refills are included in this event."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_HWPRF",
+        "PublicDescription": "This event counts the L2 D-cache access caus=
ed by L1 or L2 hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_HWPRF",
+        "PublicDescription": "This event counts each hardware prefetch acc=
ess counted by L2D_CACHE_HWPRF that causes a refill of the L2 cache, or any=
 L1 Data, or Instruction cache of this PE, from outside of those caches.\nT=
his does not include prefetch requests pending waiting for a refill in LFB =
and a new demand request to the same cache line hitting the LFB entry. All =
such refills are counted as L2D_LFB_HIT_RWL1PRF_FHWPRF."
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_PRF",
+        "PublicDescription": "This event counts each access to L2 Cache du=
e to a prefetch instruction, or hardware prefetch that causes a refill of t=
he L2 or any Level 1, from outside of those caches."
+    },
+    {
+        "EventCode": "0x0108",
+        "EventName": "L2D_CACHE_IF_REFILL",
+        "PublicDescription": "L2 D-cache refill, instruction fetch.\nThis =
event counts demand instruction fetch that causes a refill of the L2 cache =
or L1 cache of this PE, from outside of those caches."
+    },
+    {
+        "EventCode": "0x0109",
+        "EventName": "L2D_CACHE_TBW_REFILL",
+        "PublicDescription": "L2 D-cache refill, Page table walk.\nThis ev=
ent counts demand translation table walk that causes a refill of the L2 cac=
he or L1 cache of this PE, from outside of those caches."
+    },
+    {
+        "EventCode": "0x010a",
+        "EventName": "L2D_CACHE_PF_REFILL",
+        "PublicDescription": "L2 D-cache refill, prefetch.\nThis event cou=
nts L1 or L2 hardware or software prefetch accesses that causes a refill of=
 the L2 cache or L1 cache of this PE, from outside of those caches."
+    },
+    {
+        "EventCode": "0x010b",
+        "EventName": "L2D_LFB_HIT_RWL1PRF_FHWPRF",
+        "PublicDescription": "L2 line fill buffer demand Read, demand Writ=
e or L1 prefetch first hit, fetched by hardware prefetch.\nThis event count=
s each of the following access that hit the line-fill buffer when the same =
cache line is already being fetched due to an L2 hardware prefetcher.\n* De=
mand Read or Write\n* L1I-HWPRF\n* L1D-HWPRF\n* L1I PRFM\n* L1D PRFM\nThese=
 accesses hit a cache line that is currently being loaded into the L2 cache=
 as a result of a hardware prefetcher to the same line. Consequently, this =
access does not initiate a new refill but waits for the completion of the p=
revious refill.\nOnly the first hit is counted. After this event is generat=
ed for a cache line, the event is not generated again for the same cache li=
ne while it remains in the cache."
+    },
+    {
+        "EventCode": "0x0179",
+        "EventName": "L2D_CACHE_HIT_RWL1PRF_FHWPRF",
+        "PublicDescription": "L2 D-cache demand Read, demand Write and L1 =
prefetch hit, fetched by hardware prefetch. This event counts each demand R=
ead, demand Write and L1 hardware or software prefetch request that hit an =
L2 D-cache line that was refilled into L2 D-cache in response to an L2 hard=
ware prefetch. Only the first hit is counted. After this event is generated=
 for a cache line, the event is not generated again for the same cache line=
 while it remains in the cache."
+    },
+    {
+        "EventCode": "0x01b8",
+        "EventName": "L2D_CACHE_L1PRF",
+        "PublicDescription": "L2 D-cache access, L1 hardware or software p=
refetch. This event counts L1 Hardware or software prefetch access to L2 D-=
cache."
+    },
+    {
+        "EventCode": "0x01b9",
+        "EventName": "L2D_CACHE_REFILL_L1PRF",
+        "PublicDescription": "L2 D-cache refill, L1 hardware or software p=
refetch.\nThis event counts each access counted by L2D_CACHE_L1PRF that cau=
ses a refill of the L2 cache or any L1 cache of this PE, from outside of th=
ose caches."
+    },
+    {
+        "EventCode": "0x0201",
+        "EventName": "L2D_CACHE_BACKSNOOP_L1D_VIRT_ALIASING",
+        "PublicDescription": "This event counts when the L2 D-cache sends =
an invalidating back-snoop to the L1 D for an access initiated by the L1 D,=
 where the corresponding line is already present in the L1 D-cache.\nThe L2=
 D-cache line tags the PE that refilled the line. It also retains specific =
bits of the VA to identify virtually aliased addresses.\nThe L1 D request r=
equiring a back-snoop can originate either from the same PE that refilled t=
he L2 D line or from a different PE. In either case, this event only counts=
 those back snoop where the requested VA mismatch the VA stored in the L2 D=
 tag.\nThis event is counted only by PE that initiated the original request=
 necessitating a back-snoop.\nNote : The L1 D is VIPT, it identifies this a=
ccess as a miss. Conversely, as L2 is PIPT, it identifies this as a hit. L2=
 D utilizes the back-snoop mechanism to refill L1 D with the snooped data."
+    },
+    {
+        "EventCode": "0x0208",
+        "EventName": "L2D_CACHE_RWL1PRF",
+        "PublicDescription": "L2 D-cache access, demand Read, demand Write=
 or L1 hardware or software prefetch.\nThis event counts each access to L2 =
D-cache due to the following:\n* Demand Read or Write.\n* L1 Hardware or so=
ftware prefetch."
+    },
+    {
+        "EventCode": "0x020a",
+        "EventName": "L2D_CACHE_REFILL_RWL1PRF",
+        "PublicDescription": "L2 D-cache refill, demand Read, demand Write=
 or L1 hardware or software prefetch.\nThis event counts each access counte=
d by L2D_CACHE_RWL1PRF that causes a refill of the L2 cache, or any L1 cach=
e of this PE, from outside of those caches."
+    },
+    {
+        "EventCode": "0x020c",
+        "EventName": "L2D_CACHE_HIT_RWL1PRF_FPRFM",
+        "PublicDescription": "L2 D-cache demand Read, demand Write and L1 =
prefetch hit, fetched by software prefetch.\nThis event counts each demand =
Read, demand Write and L1 hardware or software prefetch request that hit an=
 L2 D-cache line that was refilled into L2 D-cache in response to an L2 sof=
tware prefetch. Only the first hit is counted. After this event is generate=
d for a cache line, the event is not generated again for the same cache lin=
e while it remains in the cache."
+    },
+    {
+        "EventCode": "0x020e",
+        "EventName": "L2D_CACHE_HIT_RWL1PRF_FPRF",
+        "PublicDescription": "L2 D-cache demand Read, demand Write and L1 =
prefetch hit, fetched by software or hardware prefetch.\nThis event counts =
each demand Read, demand Write and L1 hardware or software prefetch request=
 that hit an L2 D-cache line that was refilled into L2 D-cache in response =
to an L2 hardware prefetch or software prefetch. Only the first hit is coun=
ted. After this event is generated for a cache line, the event is not gener=
ated again for the same cache line while it remains in the cache."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/ll_cache.json b/t=
ools/perf/pmu-events/arch/arm64/nvidia/t410/ll_cache.json
new file mode 100644
index 000000000000..851d0a70de9c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/ll_cache.json
@@ -0,0 +1,107 @@
+[
+    {
+        "ArchStdEvent": "L3D_CACHE_ALLOCATE",
+        "PublicDescription": "This event counts each memory Write operatio=
n that writes an entire line into the L3 data without fetching data from ou=
tside the L3 Data. These are allocations of cache lines in the L3 Data that=
 are not refills counted by\nL3D_CACHE_REFILL. For example:\nA Write-back o=
f an entire cache line from an L2 cache to the L3 D-cache.\n* A Write of an=
 entire cache line from a coalescing Write buffer.\n* An operation such as =
DC ZVA.\nThis counter does not count writes that write an entire line to be=
yond level 3. Thus this counter does not count the streaming writes to beyo=
nd L3 cache."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL",
+        "PublicDescription": "This event counts each access counted by L3D=
_CACHE that causes a refill of the L3 Data, or any L1 Data, instruction or =
L2 cache of this PE, from outside of those caches. This includes the refill=
 due to hardware prefetch and software prefetch accesses.\nThis event is a =
sum of L3D_CACHE_MISS, L3D_CACHE_REFILL_PRFM and L3D_CACHE_REFILL_HWPRF eve=
nt.\nA refill includes any access that causes data to be fetched from outsi=
de of the L1 to L3 caches, even if the data is ultimately not allocated int=
o the L3 D-cache."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE",
+        "PublicDescription": "This event counts each memory Read operation=
 or memory Write operation that causes a cache access to the Level 3.\nThis=
 event is a sum of the following Events:\n* L3D_CACHE_RD(0x00a0)\n* L3D_CAC=
HE_ALLOCATE(0x0029)\n* L3D_CACHE_PRFM(0x8151)\n* L3D_CACHE_HWPRF(0x8156)\n*=
 L2D_CACHE_WB(0x0018)"
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_RD",
+        "PublicDescription": "This is an alias to the event L3D_CACHE_RD (=
0x00a0)."
+    },
+    {
+        "ArchStdEvent": "LL_CACHE_MISS_RD",
+        "PublicDescription": "This is an alias to the event L3D_CACHE_REFI=
LL_RD (0x00a2)."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RD",
+        "PublicDescription": "This event counts each Memory Read operation=
 to L3 D-cache from instruction fetch, Load/Store, and MMU translation tabl=
e accesses. This does not include hardware prefetcher or PRFM instruction a=
ccesses. This include L1 and L2 prefetcher accesses to L3 D-cache."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL_RD",
+        "PublicDescription": "This event counts each access counted by bot=
h L3D_CACHE_RD and L3D_CACHE_REFILL. That is, every refill of the L3 cache =
counted by L3D_CACHE_REFILL that is caused by a Memory Read operation.\nThe=
 L3D_CACHE_MISS(0x8152), L3D_CACHE_REFILL_RD (0x00a2) and L3D_CACHE_LMISS_R=
D(0x400b) count the same event in the hardware."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_LMISS_RD",
+        "PublicDescription": "This event counts each memory Read operation=
 to the L3 cache counted by L3D_CACHE that incurs additional latency becaus=
e it returns data from outside of the L1 to L3 caches.\nThe L3D_CACHE_MISS(=
0x8152), L3D_CACHE_REFILL_RD (0x00a2) and L3D_CACHE_LMISS_RD(0x400b) count =
the same event in the hardware."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_RW",
+        "PublicDescription": "This event counts each access counted by L3D=
_CACHE that is due to a demand memory Read operation or demand memory Write=
 operation.\nThis event is a sum of L3D_CACHE_RD(0x00a0), L3D_CACHE_ALLOCAT=
E(0x0029) and L2D_CACHE_WB(0x0018).\nNote that this counter does not count =
that writes an entire line to beyond level 3. Thus this counter does not co=
unt the streaming Writes to beyond L3 cache."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_PRFM",
+        "PublicDescription": "This event counts each access counted by L3D=
_CACHE that is due to a prefetch instruction. This includes L3 Data accesse=
s due to the L1, L2, or L3 prefetch instruction."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_MISS",
+        "PublicDescription": "This event counts each demand Read access co=
unted by L3D_CACHE_RD that misses in the L1 to L3 Data, causing an access t=
o outside of the L3 cache.\nThe L3D_CACHE_MISS(0x8152), L3D_CACHE_REFILL_RD=
 (0x00a2) and L3D_CACHE_LMISS_RD(0x400b) count the same event in the hardwa=
re."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL_PRFM",
+        "PublicDescription": "This event counts each access counted by L3D=
_CACHE_PRFM that causes a refill of the L3 cache, or any L1 or L2 Data, fro=
m outside of those caches."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_HWPRF",
+        "PublicDescription": "This event counts each access to L3 cache th=
at is due to a hardware prefetcher. This includes L3D accesses due to the L=
evel-1 or Level-2 or Level-3 hardware prefetcher."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL_HWPRF",
+        "PublicDescription": "This event counts each hardware prefetch cou=
nted by L3D_CACHE_HWPRF that causes a refill of the L3 Data or unified cach=
e, or any L1 or L2 Data, Instruction, or unified cache of this PE, from out=
side of those caches."
+    },
+    {
+        "ArchStdEvent": "L3D_CACHE_REFILL_PRF",
+        "PublicDescription": "This event counts each access to L3 cache du=
e to a prefetch instruction, or hardware prefetch that causes a refill of t=
he L3 Data, or any L1 or L2 Data, from outside of those caches."
+    },
+    {
+        "EventCode": "0x01e8",
+        "EventName": "L3D_CACHE_RWL1PRFL2PRF",
+        "PublicDescription": "L3 cache access, demand Read, demand Write, =
L1 hardware or software prefetch or L2 hardware or software prefetch.\nThis=
 event counts each access to L3 D-cache due to the following:\n* Demand Rea=
d or Write.\n* L1 Hardware or software prefetch.\n* L2 Hardware or software=
 prefetch."
+    },
+    {
+        "EventCode": "0x01e9",
+        "EventName": "L3D_CACHE_REFILL_RWL1PRFL2PRF",
+        "PublicDescription": "L3 cache refill, demand Read, demand Write, =
L1 hardware or software prefetch or L2 hardware or software prefetch.\nThis=
 event counts each access counted by L3D_CACHE_RWL1PRFL2PRF that causes a r=
efill of the L3 cache, or any L1 or L2 cache of this PE, from outside of th=
ose caches."
+    },
+    {
+        "EventCode": "0x01f6",
+        "EventName": "L3D_CACHE_REFILL_L2PRF",
+        "PublicDescription": "This event counts each access counted by L3D=
_CACHE_L2PRF that causes a refill of the L3 cache, or any L1 or L2 cache of=
 this PE, from outside of those caches."
+    },
+    {
+        "EventCode": "0x01f7",
+        "EventName": "L3D_CACHE_HIT_RWL1PRFL2PRF_FPRF",
+        "PublicDescription": "L3 cache demand Read, demand Write, L1 prefe=
tch L2 prefetch first hit, fetched by software or hardware prefetch.\nThis =
event counts each demand Read, demand Write, L1 hardware or software prefet=
ch request and L2 hardware or software prefetch that hit an L3 D-cache line=
 that was refilled into L3 D-cache in response to an L3 hardware prefetch o=
r software prefetch. Only the first hit is counted. After this event is gen=
erated for a cache line, the event is not generated again for the same cach=
e line while it remains in the cache."
+    },
+    {
+        "EventCode": "0x0225",
+        "EventName": "L3D_CACHE_REFILL_IF",
+        "PublicDescription": "L3 cache refill, instruction fetch.\nThis ev=
ent counts demand instruction fetch that causes a refill of the L3 cache, o=
r any L1 or L2 cache of this PE, from outside of those caches."
+    },
+    {
+        "EventCode": "0x0226",
+        "EventName": "L3D_CACHE_REFILL_MM",
+        "PublicDescription": "L3 cache refill, translation table walk acce=
ss.\nThis event counts demand translation table access that causes a refill=
 of the L3 cache, or any L1 or L2 cache of this PE, from outside of those c=
aches."
+    },
+    {
+        "EventCode": "0x0227",
+        "EventName": "L3D_CACHE_REFILL_L1PRF",
+        "PublicDescription": "This event counts each access counted by L3D=
_CACHE_L1PRF that causes a refill of the L3 cache, or any L1 or L2 cache of=
 this PE, from outside of those caches."
+    },
+    {
+        "EventCode": "0x022c",
+        "EventName": "L3D_CACHE_L1PRF",
+        "PublicDescription": "This event counts the L3 D-cache access due =
to L1 hardware prefetch or software prefetch request.\nThe L1 hardware pref=
etch or software prefetch requests that miss the L1I, L1D and L2 D-cache ar=
e counted by this counter"
+    },
+    {
+        "EventCode": "0x022d",
+        "EventName": "L3D_CACHE_L2PRF",
+        "PublicDescription": "This event counts the L3 D-cache access due =
to L2 hardware prefetch or software prefetch request.\nThe L2 hardware pref=
etch or software prefetch requests that miss the L2 D-cache are counted by =
this counter"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/memory.json b/too=
ls/perf/pmu-events/arch/arm64/nvidia/t410/memory.json
new file mode 100644
index 000000000000..becd2d90bf39
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/memory.json
@@ -0,0 +1,46 @@
+[
+    {
+        "ArchStdEvent": "MEM_ACCESS",
+        "PublicDescription": "This event counts memory accesses issued by =
the CPU load/store unit, where those accesses are issued due to load or sto=
re operations. This event counts memory accesses regardless of whether the =
data is received from any level of cache hierarchy or external memory. If m=
emory accesses are broken up into smaller transactions than what were speci=
fied in the load or store instructions, then the event counts those smaller=
 memory transactions.\nMemory accesses generated by the following instructi=
ons or activity are not counted: instruction fetches, cache maintenance ins=
tructions, translation table walks or prefetches, memory prefetch operation=
s. This event counts the sum of the following events:\nMEM_ACCESS_RD and\nM=
EM_ACCESS_WR."
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR",
+        "PublicDescription": "This event counts any detected correctable o=
r uncorrectable physical memory errors (ECC or parity) in protected CPU RAM=
s. On the Core, this event counts errors in the caches (including data and =
tag RAMs). Any detected memory error (from either a speculative and abandon=
ed access, or an architecturally executed access) is counted.\nNote that er=
rors are only detected when the actual protected memory is accessed by an o=
peration."
+    },
+    {
+        "ArchStdEvent": "REMOTE_ACCESS",
+        "PublicDescription": "This event counts each external bus read acc=
ess that causes an access to a remote device. That is, a socket that does n=
ot contain the PE."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD",
+        "PublicDescription": "This event counts memory accesses issued by =
the CPU due to Load operations. This event counts any memory Load access, n=
o matter whether the data is received from any level of cache hierarchy or =
external memory. This event also counts atomic Load operations. If memory a=
ccesses are broken up by the Load/Store unit into smaller transactions that=
 are issued by the bus interface, then the event counts those smaller trans=
actions.\nThe following instructions are not counted:\n1) Instruction fetch=
es,\n2) Cache maintenance instructions,\n3) Translation table walks or pref=
etches,\n4) Memory prefetch operations.\nThis event is a subset of the MEM_=
ACCESS event but the event only counts memory-Read operations."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR",
+        "PublicDescription": "This event counts memory accesses issued by =
the CPU due to Store operations. This event counts any memory Store access,=
 no matter whether the data is located in any level of cache or external me=
mory. This event also counts atomic Load and Store operations. If memory ac=
cesses are broken up by the Load/Store unit into smaller transactions that =
are issued by the bus interface, then the event counts those smaller transa=
ctions."
+    },
+    {
+        "ArchStdEvent": "LDST_ALIGN_LAT",
+        "PublicDescription": "This event counts the number of memory Read =
and Write accesses in a cycle that incurred additional latency due to the a=
lignment of the address and the size of data being accessed, which results =
in a store crossing a single cache line.\nThis event is implemented as the =
sum of the following events on this CPU:\nLD_ALIGN_LAT and\nST_ALIGN_LAT."
+    },
+    {
+        "ArchStdEvent": "LD_ALIGN_LAT",
+        "PublicDescription": "This event counts the number of memory Read =
accesses in a cycle that incurred additional latency due to the alignment o=
f the address and size of data being accessed, which results in a load cros=
sing a single cache line."
+    },
+    {
+        "ArchStdEvent": "ST_ALIGN_LAT",
+        "PublicDescription": "This event counts the number of memory Write=
 accesses in a cycle that incurred additional latency due to the alignment =
of the address and size of data being accessed."
+    },
+    {
+        "ArchStdEvent": "INST_FETCH_PERCYC",
+        "PublicDescription": "This event counts number of instruction fetc=
hes outstanding per cycle, which will provide an average latency of instruc=
tion fetch."
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD_PERCYC",
+        "PublicDescription": "This event counts the number of outstanding =
Loads or memory Read accesses per cycle."
+    },
+    {
+        "ArchStdEvent": "INST_FETCH",
+        "PublicDescription": "This event counts instruction memory accesse=
s that the PE makes."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json b/to=
ols/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
new file mode 100644
index 000000000000..b825ede03f54
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
@@ -0,0 +1,722 @@
+[
+    {
+        "MetricName": "backend_bound",
+        "MetricExpr": "100 * (STALL_SLOT_BACKEND / CPU_SLOT)",
+        "BriefDescription": "This metric is the percentage of total slots =
that were stalled due to resource constraints in the backend of the process=
or.",
+        "ScaleUnit": "1percent of slots",
+        "MetricGroup": "TopdownL1"
+    },
+    {
+        "MetricName": "backend_busy_bound",
+        "MetricExpr": "100 * (STALL_BACKEND_BUSY / STALL_BACKEND)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to issue queues being full to accept operations=
 for execution.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Backend"
+    },
+    {
+        "MetricName": "backend_cache_l1d_bound",
+        "MetricExpr": "100 * (STALL_BACKEND_L1D / (STALL_BACKEND_L1D + STA=
LL_BACKEND_MEM))",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to memory access latency issues caused by L1 D-=
cache misses.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Backend"
+    },
+    {
+        "MetricName": "backend_cache_l2d_bound",
+        "MetricExpr": "100 * (STALL_BACKEND_MEM / (STALL_BACKEND_L1D + STA=
LL_BACKEND_MEM))",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to memory access latency issues caused by L2 D-=
cache misses.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Backend"
+    },
+    {
+        "MetricName": "backend_core_bound",
+        "MetricExpr": "100 * (STALL_BACKEND_CPUBOUND / STALL_BACKEND)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to backend Core resource constraints not relate=
d to instruction fetch latency issues caused by memory access components.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Backend"
+    },
+    {
+        "MetricName": "backend_core_rename_bound",
+        "MetricExpr": "100 * (STALL_BACKEND_RENAME / STALL_BACKEND_CPUBOUN=
D)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend as the rename unit registers are unavailable.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Backend"
+    },
+    {
+        "MetricName": "backend_mem_bound",
+        "MetricExpr": "100 * (STALL_BACKEND_MEMBOUND / STALL_BACKEND)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to backend Core resource constraints related to=
 memory access latency issues caused by memory access components.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Backend"
+    },
+    {
+        "MetricName": "backend_mem_cache_bound",
+        "MetricExpr": "100 * ((STALL_BACKEND_L1D + STALL_BACKEND_MEM) / ST=
ALL_BACKEND_MEMBOUND)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to memory latency issues caused by D-cache miss=
es.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Backend"
+    },
+    {
+        "MetricName": "backend_mem_store_bound",
+        "MetricExpr": "100 * (STALL_BACKEND_ST / STALL_BACKEND_MEMBOUND)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to memory Write pending caused by Stores stalle=
d in the pre-commit stage.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Backend"
+    },
+    {
+        "MetricName": "backend_mem_tlb_bound",
+        "MetricExpr": "100 * (STALL_BACKEND_TLB / STALL_BACKEND_MEMBOUND)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the backend due to memory access latency issues caused by Data =
TLB misses.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Backend"
+    },
+    {
+        "MetricName": "backend_stalled_cycles",
+        "MetricExpr": "100 * (STALL_BACKEND / CPU_CYCLES)",
+        "BriefDescription": "This metric is the percentage of cycles that =
were stalled due to resource constraints in the backend unit of the process=
or.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Cycle_Accounting"
+    },
+    {
+        "MetricName": "bad_speculation",
+        "MetricExpr": "100 - (frontend_bound + retiring + backend_bound)",
+        "BriefDescription": "This metric is the percentage of total slots =
that executed operations and didn't retire due to a pipeline flush. This in=
dicates cycles that were utilized but inefficiently.",
+        "ScaleUnit": "1percent of slots",
+        "MetricGroup": "TopdownL1"
+    },
+    {
+        "MetricName": "barrier_percentage",
+        "MetricExpr": "100 * ((ISB_SPEC + DSB_SPEC + DMB_SPEC) / INST_SPEC=
)",
+        "BriefDescription": "This metric measures instruction and data bar=
rier operations as a percentage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "Operation_Mix"
+    },
+    {
+        "MetricName": "branch_direct_ratio",
+        "MetricExpr": "BR_IMMED_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of direct bran=
ches retired to the total number of branches architecturally executed.",
+        "ScaleUnit": "1per branch",
+        "MetricGroup": "Branch_Effectiveness"
+    },
+    {
+        "MetricName": "branch_indirect_ratio",
+        "MetricExpr": "BR_IND_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of indirect br=
anches retired, including function returns, to the total number of branches=
 architecturally executed.",
+        "ScaleUnit": "1per branch",
+        "MetricGroup": "Branch_Effectiveness"
+    },
+    {
+        "MetricName": "branch_misprediction_ratio",
+        "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of branches mi=
spredicted to the total number of branches architecturally executed. This g=
ives an indication of the effectiveness of the branch prediction unit.",
+        "ScaleUnit": "1per branch",
+        "MetricGroup": "Miss_Ratio;Branch_Effectiveness"
+    },
+    {
+        "MetricName": "branch_mpki",
+        "MetricExpr": "1000 * (BR_MIS_PRED_RETIRED / INST_RETIRED)",
+        "BriefDescription": "This metric measures the number of branch mis=
predictions per thousand instructions executed.",
+        "ScaleUnit": "1MPKI",
+        "MetricGroup": "MPKI;Branch_Effectiveness"
+    },
+    {
+        "MetricName": "branch_percentage",
+        "MetricExpr": "100 * ((BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SP=
EC)",
+        "BriefDescription": "This metric measures branch operations as a p=
ercentage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "Operation_Mix"
+    },
+    {
+        "MetricName": "branch_return_ratio",
+        "MetricExpr": "BR_RETURN_RETIRED / BR_RETIRED",
+        "BriefDescription": "This metric measures the ratio of branches re=
tired that are function returns to the total number of branches architectur=
ally executed.",
+        "ScaleUnit": "1per branch",
+        "MetricGroup": "Branch_Effectiveness"
+    },
+    {
+        "MetricName": "bus_bandwidth",
+        "MetricExpr": "BUS_ACCESS * 32 / duration_time ",
+        "BriefDescription": "This metric measures the bus-bandwidth of the=
 data transferred between this PE's L2 with unCore in the system.",
+        "ScaleUnit": "1Bytes/sec"
+    },
+    {
+        "MetricName": "cpu_cycles_fraction_in_st_mode",
+        "MetricExpr": "((CPU_SLOT/CPU_CYCLES) - 5) / 5",
+        "BriefDescription": "This metric counts fraction of the CPU cycles=
 spent in ST mode during program execution.",
+        "ScaleUnit": "1fraction of cycles",
+        "MetricGroup": "SMT"
+    },
+    {
+        "MetricName": "cpu_cycles_in_smt_mode",
+        "MetricExpr": "(1 - cpu_cycles_fraction_in_st_mode) * CPU_CYCLES",
+        "BriefDescription": "This metric counts CPU cycles in SMT mode dur=
ing program execution.",
+        "ScaleUnit": "1CPU cycles",
+        "MetricGroup": "SMT"
+    },
+    {
+        "MetricName": "cpu_cycles_in_st_mode",
+        "MetricExpr": "cpu_cycles_fraction_in_st_mode * CPU_CYCLES",
+        "BriefDescription": "This metric counts CPU cycles in ST mode duri=
ng program execution.",
+        "ScaleUnit": "1CPU cycles",
+        "MetricGroup": "SMT"
+    },
+    {
+        "MetricName": "crypto_percentage",
+        "MetricExpr": "100 * (CRYPTO_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures crypto operations as a p=
ercentage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "Operation_Mix"
+    },
+    {
+        "MetricName": "dtlb_mpki",
+        "MetricExpr": "1000 * (DTLB_WALK / INST_RETIRED)",
+        "BriefDescription": "This metric measures the number of Data TLB W=
alks per thousand instructions executed.",
+        "ScaleUnit": "1MPKI",
+        "MetricGroup": "MPKI;DTLB_Effectiveness"
+    },
+    {
+        "MetricName": "dtlb_walk_average_latency",
+        "MetricExpr": "DTLB_WALK_PERCYC / DTLB_WALK",
+        "BriefDescription": "This metric measures the average latency of D=
ata TLB walks in CPU cycles.",
+        "ScaleUnit": "1CPU cycles",
+        "MetricGroup": "Average_Latency"
+    },
+    {
+        "MetricName": "dtlb_walk_ratio",
+        "MetricExpr": "DTLB_WALK / L1D_TLB",
+        "BriefDescription": "This metric measures the ratio of Data TLB Wa=
lks to the total number of Data TLB accesses. This gives an indication of t=
he effectiveness of the Data TLB accesses.",
+        "ScaleUnit": "1per TLB access",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness"
+    },
+    {
+        "MetricName": "fp16_percentage",
+        "MetricExpr": "100 * (FP_HP_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures half-precision floating =
point operations as a percentage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "FP_Precision_Mix"
+    },
+    {
+        "MetricName": "fp32_percentage",
+        "MetricExpr": "100 * (FP_SP_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures single-precision floatin=
g point operations as a percentage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "FP_Precision_Mix"
+    },
+    {
+        "MetricName": "fp64_percentage",
+        "MetricExpr": "100 * (FP_DP_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures double-precision floatin=
g point operations as a percentage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "FP_Precision_Mix"
+    },
+    {
+        "MetricName": "fp_ops_per_cycle",
+        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLE=
S",
+        "BriefDescription": "This metric measures floating point operation=
s per cycle in any precision performed by any instruction. Operations are c=
ounted by computation and by vector lanes, fused computations such as multi=
ply-add count as twice per vector lane for example.",
+        "ScaleUnit": "1operations per cycle",
+        "MetricGroup": "FP_Arithmetic_Intensity"
+    },
+    {
+        "MetricName": "frontend_bound",
+        "MetricExpr": "100 * (STALL_SLOT_FRONTEND_WITHOUT_MISPRED / CPU_SL=
OT)",
+        "BriefDescription": "This metric is the percentage of total slots =
that were stalled due to resource constraints in the frontend of the proces=
sor.",
+        "ScaleUnit": "1percent of slots",
+        "MetricGroup": "TopdownL1"
+    },
+    {
+        "MetricName": "frontend_cache_l1i_bound",
+        "MetricExpr": "100 * (STALL_FRONTEND_L1I / (STALL_FRONTEND_L1I + S=
TALL_FRONTEND_MEM))",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to memory access latency issues caused by L1 I=
-cache misses.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Frontend"
+    },
+    {
+        "MetricName": "frontend_cache_l2i_bound",
+        "MetricExpr": "100 * (STALL_FRONTEND_MEM / (STALL_FRONTEND_L1I + S=
TALL_FRONTEND_MEM))",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to memory access latency issues caused by L2 I=
-cache misses.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Frontend"
+    },
+    {
+        "MetricName": "frontend_core_bound",
+        "MetricExpr": "100 * (STALL_FRONTEND_CPUBOUND / STALL_FRONTEND)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to frontend Core resource constraints not rela=
ted to instruction fetch latency issues caused by memory access components.=
",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Frontend"
+    },
+    {
+        "MetricName": "frontend_core_flow_bound",
+        "MetricExpr": "100 * (STALL_FRONTEND_FLOW / STALL_FRONTEND_CPUBOUN=
D)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend as the decode unit is awaiting input from the bran=
ch prediction unit.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Frontend"
+    },
+    {
+        "MetricName": "frontend_core_flush_bound",
+        "MetricExpr": "100 * (STALL_FRONTEND_FLUSH / STALL_FRONTEND_CPUBOU=
ND)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend as the processor is recovering from a pipeline flu=
sh caused by bad speculation or other machine resteers.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Frontend"
+    },
+    {
+        "MetricName": "frontend_mem_bound",
+        "MetricExpr": "100 * (STALL_FRONTEND_MEMBOUND / STALL_FRONTEND)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to frontend Core resource constraints related =
to the instruction fetch latency issues caused by memory access components.=
",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Frontend"
+    },
+    {
+        "MetricName": "frontend_mem_cache_bound",
+        "MetricExpr": "100 * ((STALL_FRONTEND_L1I + STALL_FRONTEND_MEM) / =
STALL_FRONTEND_MEMBOUND)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to instruction fetch latency issues caused by =
I-cache misses.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Frontend"
+    },
+    {
+        "MetricName": "frontend_mem_tlb_bound",
+        "MetricExpr": "100 * (STALL_FRONTEND_TLB / STALL_FRONTEND_MEMBOUND=
)",
+        "BriefDescription": "This metric is the percentage of total cycles=
 stalled in the frontend due to instruction fetch latency issues caused by =
Instruction TLB misses.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Topdown_Frontend"
+    },
+    {
+        "MetricName": "frontend_stalled_cycles",
+        "MetricExpr": "100 * (STALL_FRONTEND / CPU_CYCLES)",
+        "BriefDescription": "This metric is the percentage of cycles that =
were stalled due to resource constraints in the frontend unit of the proces=
sor.",
+        "ScaleUnit": "1percent of cycles",
+        "MetricGroup": "Cycle_Accounting"
+    },
+    {
+        "MetricName": "instruction_fetch_average_latency",
+        "MetricExpr": "INST_FETCH_PERCYC / INST_FETCH",
+        "BriefDescription": "This metric measures the average latency of i=
nstruction fetches in CPU cycles.",
+        "ScaleUnit": "1CPU cycles",
+        "MetricGroup": "Average_Latency"
+    },
+    {
+        "MetricName": "integer_dp_percentage",
+        "MetricExpr": "100 * (DP_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures scalar integer operation=
s as a percentage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "Operation_Mix"
+    },
+    {
+        "MetricName": "ipc",
+        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
+        "BriefDescription": "This metric measures the number of instructio=
ns retired per cycle.",
+        "ScaleUnit": "1per cycle",
+        "MetricGroup": "General"
+    },
+    {
+        "MetricName": "itlb_mpki",
+        "MetricExpr": "1000 * (ITLB_WALK / INST_RETIRED)",
+        "BriefDescription": "This metric measures the number of instructio=
n TLB Walks per thousand instructions executed.",
+        "ScaleUnit": "1MPKI",
+        "MetricGroup": "MPKI;ITLB_Effectiveness"
+    },
+    {
+        "MetricName": "itlb_walk_average_latency",
+        "MetricExpr": "ITLB_WALK_PERCYC / ITLB_WALK",
+        "BriefDescription": "This metric measures the average latency of i=
nstruction TLB walks in CPU cycles.",
+        "ScaleUnit": "1CPU cycles",
+        "MetricGroup": "Average_Latency"
+    },
+    {
+        "MetricName": "itlb_walk_ratio",
+        "MetricExpr": "ITLB_WALK / L1I_TLB",
+        "BriefDescription": "This metric measures the ratio of instruction=
 TLB Walks to the total number of Instruction TLB accesses. This gives an i=
ndication of the effectiveness of the Instruction TLB accesses.",
+        "ScaleUnit": "1per TLB access",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_cache_miss_ratio",
+        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
+        "BriefDescription": "This metric measures the ratio of L1 D-cache =
accesses missed to the total number of L1 D-cache accesses. This gives an i=
ndication of the effectiveness of the L1 D-cache.",
+        "ScaleUnit": "1per cache access",
+        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_cache_mpki",
+        "MetricExpr": "1000 * (L1D_CACHE_REFILL / INST_RETIRED)",
+        "BriefDescription": "This metric measures the number of L1 D-cache=
 accesses missed per thousand instructions executed.",
+        "ScaleUnit": "1MPKI",
+        "MetricGroup": "MPKI;L1D_Cache_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_cache_rw_miss_ratio",
+        "MetricExpr": "l1d_demand_misses / l1d_demand_accesses",
+        "BriefDescription": "This metric measures the ratio of L1 D-cache =
Read accesses missed to the total number of L1 D-cache accesses. This gives=
 an indication of the effectiveness of the L1 D-cache for demand Load or St=
ore traffic.",
+        "ScaleUnit": "1per cache access",
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_demand_accesses",
+        "MetricExpr": "L1D_CACHE_RW",
+        "BriefDescription": "This metric measures the count of L1 D-cache =
accesses incurred on Load or Store by the instruction stream of the program=
.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_demand_misses",
+        "MetricExpr": "L1D_CACHE_REFILL_RW",
+        "BriefDescription": "This metric measures the count of L1 D-cache =
misses incurred on a Load or Store by the instruction stream of the program=
.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_prf_accuracy",
+        "MetricExpr": "100 * (l1d_useful_prf / l1d_refilled_prf)",
+        "BriefDescription": "This metric measures the fraction of prefetch=
ed memory addresses that are used by the instruction stream.",
+        "ScaleUnit": "1percent of prefetch",
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_prf_coverage",
+        "MetricExpr": "100 * (l1d_useful_prf / (l1d_demand_misses + l1d_re=
filled_prf))",
+        "BriefDescription": "This metric measures the baseline demand cach=
e misses which the prefetcher brings into the cache.",
+        "ScaleUnit": "1percent of cache access",
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_refilled_prf",
+        "MetricExpr": "L1D_CACHE_REFILL_HWPRF + L1D_CACHE_REFILL_PRFM + L1=
D_LFB_HIT_RW_FHWPRF + L1D_LFB_HIT_RW_FPRFM",
+        "BriefDescription": "This metric measures the count of cache lines=
 refilled by L1 data prefetcher (hardware prefetches or software preload) i=
nto L1 D-cache.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_tlb_miss_ratio",
+        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
+        "BriefDescription": "This metric measures the ratio of L1 Data TLB=
 accesses missed to the total number of L1 Data TLB accesses. This gives an=
 indication of the effectiveness of the L1 Data TLB.",
+        "ScaleUnit": "1per TLB access",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_tlb_mpki",
+        "MetricExpr": "1000 * (L1D_TLB_REFILL / INST_RETIRED)",
+        "BriefDescription": "This metric measures the number of L1 Data TL=
B accesses missed per thousand instructions executed.",
+        "ScaleUnit": "1MPKI",
+        "MetricGroup": "MPKI;DTLB_Effectiveness"
+    },
+    {
+        "MetricName": "l1d_useful_prf",
+        "MetricExpr": "L1D_CACHE_HIT_RW_FPRF + L1D_LFB_HIT_RW_FHWPRF + L1D=
_LFB_HIT_RW_FPRFM",
+        "BriefDescription": "This metric measures the count of cache lines=
 refilled by L1 data prefetcher (hardware prefetches or software preload) i=
nto L1 D-cache which are further used by Load or Store from the instruction=
 stream of the program.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L1I_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_cache_miss_ratio",
+        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
+        "BriefDescription": "This metric measures the ratio of L1 I-cache =
accesses missed to the total number of L1 I-cache accesses. This gives an i=
ndication of the effectiveness of the L1 I-cache.",
+        "ScaleUnit": "1per cache access",
+        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_cache_mpki",
+        "MetricExpr": "1000 * (L1I_CACHE_REFILL / INST_RETIRED)",
+        "BriefDescription": "This metric measures the number of L1 I-cache=
 accesses missed per thousand instructions executed.",
+        "ScaleUnit": "1MPKI",
+        "MetricGroup": "MPKI;L1I_Cache_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_cache_rd_miss_ratio",
+        "MetricExpr": "l1i_demand_misses / l1i_demand_accesses",
+        "BriefDescription": "This metric measures the ratio of L1 I-cache =
Read accesses missed to the total number of L1 I-cache accesses. This gives=
 an indication of the effectiveness of the L1 I-cache for demand instructio=
n fetch traffic. Note that cache accesses in this cache are demand instruct=
ion fetch.",
+        "ScaleUnit": "1per cache access",
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_demand_accesses",
+        "MetricExpr": "L1I_CACHE_RD",
+        "BriefDescription": "This metric measures the count of L1 I-cache =
accesses caused by an instruction fetch by the instruction stream of the pr=
ogram.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_demand_misses",
+        "MetricExpr": "L1I_CACHE_REFILL_RD",
+        "BriefDescription": "This metric measures the count of L1 I-cache =
misses caused by an instruction fetch by the instruction stream of the prog=
ram.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_prf_accuracy",
+        "MetricExpr": "100 * (l1i_useful_prf / l1i_refilled_prf)",
+        "BriefDescription": "This metric measures the fraction of prefetch=
ed memory addresses that are used by the instruction stream.",
+        "ScaleUnit": "1percent of prefetch",
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_prf_coverage",
+        "MetricExpr": "100 * (l1i_useful_prf / (l1i_demand_misses + l1i_re=
filled_prf))",
+        "BriefDescription": "This metric measures the baseline demand cach=
e misses which the prefetcher brings into the cache.",
+        "ScaleUnit": "1percent of cache access",
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_refilled_prf",
+        "MetricExpr": "L1I_CACHE_REFILL_HWPRF + L1I_CACHE_REFILL_PRFM",
+        "BriefDescription": "This metric measures the count of cache lines=
 refilled by L1 instruction prefetcher (hardware prefetches or software pre=
load) into L1 I-cache.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_tlb_miss_ratio",
+        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
+        "BriefDescription": "This metric measures the ratio of L1 Instruct=
ion TLB accesses missed to the total number of L1 Instruction TLB accesses.=
 This gives an indication of the effectiveness of the L1 Instruction TLB.",
+        "ScaleUnit": "1per TLB access",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_tlb_mpki",
+        "MetricExpr": "1000 * (L1I_TLB_REFILL / INST_RETIRED)",
+        "BriefDescription": "This metric measures the number of L1 Instruc=
tion TLB accesses missed per thousand instructions executed.",
+        "ScaleUnit": "1MPKI",
+        "MetricGroup": "MPKI;ITLB_Effectiveness"
+    },
+    {
+        "MetricName": "l1i_useful_prf",
+        "MetricExpr": "L1I_CACHE_HIT_RD_FPRF",
+        "BriefDescription": "This metric measures the count of cache lines=
 refilled by L1 instruction prefetcher (hardware prefetches or software pre=
load) into L1 I-cache which are further used by instruction stream of the p=
rogram.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L1D_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l2_cache_miss_ratio",
+        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
+        "BriefDescription": "This metric measures the ratio of L2 cache ac=
cesses missed to the total number of L2 cache accesses. This gives an indic=
ation of the effectiveness of the L2 cache, which is a unified cache that s=
tores both data and instruction.\nNote that cache accesses in this cache ar=
e either data memory access or instruction fetch as this is a unified cache=
.",
+        "ScaleUnit": "1per cache access",
+        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness"
+    },
+    {
+        "MetricName": "l2_cache_mpki",
+        "MetricExpr": "1000 * (l2d_demand_misses / INST_RETIRED)",
+        "BriefDescription": "This metric measures the number of L2 unified=
 cache accesses missed per thousand instructions executed.\nNote that cache=
 accesses in this cache are either data memory access or instruction fetch =
as this is a unified cache.",
+        "ScaleUnit": "1MPKI",
+        "MetricGroup": "MPKI;L2_Cache_Effectiveness"
+    },
+    {
+        "MetricName": "l2_tlb_miss_ratio",
+        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
+        "BriefDescription": "This metric measures the ratio of L2 unified =
TLB accesses missed to the total number of L2 unified TLB accesses.\nThis g=
ives an indication of the effectiveness of the L2 TLB.",
+        "ScaleUnit": "1per TLB access",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness"
+    },
+    {
+        "MetricName": "l2_tlb_mpki",
+        "MetricExpr": "1000 * (L2D_TLB_REFILL / INST_RETIRED)",
+        "BriefDescription": "This metric measures the number of L2 unified=
 TLB accesses missed per thousand instructions executed.",
+        "ScaleUnit": "1MPKI",
+        "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness"
+    },
+    {
+        "MetricName": "l2d_cache_rwl1prf_miss_ratio",
+        "MetricExpr": "l2d_demand_misses / l2d_demand_accesses",
+        "BriefDescription": "This metric measures the ratio of L2 D-cache =
Read accesses missed to the total number of L2 D-cache accesses.\nThis give=
s an indication of the effectiveness of the L2 D-cache for demand instructi=
on fetch, Load, Store, or L1 prefetcher accesses traffic.",
+        "ScaleUnit": "1per cache access",
+        "MetricGroup": "L2_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l2d_demand_accesses",
+        "MetricExpr": "L2D_CACHE_RD + L2D_CACHE_WR + L2D_CACHE_L1PRF",
+        "BriefDescription": "This metric measures the count of L2 D-cache =
accesses incurred on an instruction fetch, Load, Store, or L1 prefetcher ac=
cesses by the instruction stream of the program.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L2_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l2d_demand_misses",
+        "MetricExpr": "L2D_CACHE_REFILL_RD + L2D_CACHE_REFILL_WR + L2D_CAC=
HE_REFILL_L1PRF",
+        "BriefDescription": "This metric measures the count of L2 D-cache =
misses incurred on an instruction fetch, Load, Store, or L1 prefetcher acce=
sses by the instruction stream of the program.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L2_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l2d_prf_accuracy",
+        "MetricExpr": "100 * (l2d_useful_prf / l2d_refilled_prf)",
+        "BriefDescription": "This metric measures the fraction of prefetch=
ed memory addresses that are used by the instruction stream.",
+        "ScaleUnit": "1percent of prefetch",
+        "MetricGroup": "L2_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l2d_prf_coverage",
+        "MetricExpr": "100 * (l2d_useful_prf / (l2d_demand_misses + l2d_re=
filled_prf))",
+        "BriefDescription": "This metric measures the baseline demand cach=
e misses which the prefetcher brings into the cache.",
+        "ScaleUnit": "1percent of cache access",
+        "MetricGroup": "L2_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l2d_refilled_prf",
+        "MetricExpr": "(L2D_CACHE_REFILL_PRF - L2D_CACHE_REFILL_L1PRF) + L=
2D_LFB_HIT_RWL1PRF_FHWPRF",
+        "BriefDescription": "This metric measures the count of cache lines=
 refilled by L2 data prefetcher (hardware prefetches or software preload) i=
nto L2 D-cache.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L2_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l2d_useful_prf",
+        "MetricExpr": "L2D_CACHE_HIT_RWL1PRF_FPRF + L2D_LFB_HIT_RWL1PRF_FH=
WPRF",
+        "BriefDescription": "This metric measures the count of cache lines=
 refilled by L2 data prefetcher (hardware prefetches or software preload) i=
nto L2 D-cache which are further used by instruction fetch, Load, Store, or=
 L1 prefetcher accesses from the instruction stream of the program.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L2_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l3d_cache_rwl1prfl2prf_miss_ratio",
+        "MetricExpr": "l3d_demand_misses / l3d_demand_accesses",
+        "BriefDescription": "This metric measures the ratio of L3 D-cache =
Read accesses missed to the total number of L3 D-cache accesses. This gives=
 an indication of the effectiveness of the L2 D-cache for demand instructio=
n fetch, Load, Store, L1 prefetcher, or L2 prefetcher accesses traffic.",
+        "ScaleUnit": "1per cache access",
+        "MetricGroup": "L3_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l3d_demand_accesses",
+        "MetricExpr": "L3D_CACHE_RWL1PRFL2PRF",
+        "BriefDescription": "This metric measures the count of L3 D-cache =
accesses incurred on an instruction fetch, Load, Store, L1 prefetcher, or L=
2 prefetcher accesses by the instruction stream of the program.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L3_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l3d_demand_misses",
+        "MetricExpr": "L3D_CACHE_REFILL_RWL1PRFL2PRF",
+        "BriefDescription": "This metric measures the count of L3 D-cache =
misses incurred on an instruction fetch, Load, Store, L1 prefetcher, or L2 =
prefetcher accesses by the instruction stream of the program.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L3_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l3d_prf_accuracy",
+        "MetricExpr": "100 * (l3d_useful_prf / l3d_refilled_prf)",
+        "BriefDescription": "This metric measures the fraction of prefetch=
ed memory addresses that are used by the instruction stream.",
+        "ScaleUnit": "1percent of prefetch",
+        "MetricGroup": "L3_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l3d_prf_coverage",
+        "MetricExpr": "100 * (l3d_useful_prf / (l3d_demand_misses + l3d_re=
filled_prf))",
+        "BriefDescription": "This metric measures the baseline demand cach=
e misses which the prefetcher brings into the cache.",
+        "ScaleUnit": "1percent of cache access",
+        "MetricGroup": "L3_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l3d_refilled_prf",
+        "MetricExpr": "L3D_CACHE_REFILL_HWPRF + L3D_CACHE_REFILL_PRFM - L3=
D_CACHE_REFILL_L1PRF - L3D_CACHE_REFILL_L2PRF",
+        "BriefDescription": "This metric measures the count of cache lines=
 refilled by L3 data prefetcher (hardware prefetches or software preload) i=
nto L3 D-cache.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L3_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "l3d_useful_prf",
+        "MetricExpr": "L3D_CACHE_HIT_RWL1PRFL2PRF_FPRF",
+        "BriefDescription": "This metric measures the count of cache lines=
 refilled by L3 data prefetcher (hardware prefetches or software preload) i=
nto L3 D-cache which are further used by instruction fetch, Load, Store, L1=
 prefetcher, or L2 prefetcher accesses from the instruction stream of the p=
rogram.",
+        "ScaleUnit": "1count",
+        "MetricGroup": "L3_Prefetcher_Effectiveness"
+    },
+    {
+        "MetricName": "ll_cache_read_hit_ratio",
+        "MetricExpr": "(LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD",
+        "BriefDescription": "This metric measures the ratio of last level =
cache Read accesses hit in the cache to the total number of last level cach=
e accesses. This gives an indication of the effectiveness of the last level=
 cache for Read traffic. Note that cache accesses in this cache are either =
data memory access or instruction fetch as this is a system level cache.",
+        "ScaleUnit": "1per cache access",
+        "MetricGroup": "LL_Cache_Effectiveness"
+    },
+    {
+        "MetricName": "ll_cache_read_miss_ratio",
+        "MetricExpr": "LL_CACHE_MISS_RD / LL_CACHE_RD",
+        "BriefDescription": "This metric measures the ratio of last level =
cache Read accesses missed to the total number of last level cache accesses=
. This gives an indication of the effectiveness of the last level cache for=
 Read traffic. Note that cache accesses in this cache are either data memor=
y access or instruction fetch as this is a system level cache.",
+        "ScaleUnit": "1per cache access",
+        "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness"
+    },
+    {
+        "MetricName": "ll_cache_read_mpki",
+        "MetricExpr": "1000 * (LL_CACHE_MISS_RD / INST_RETIRED)",
+        "BriefDescription": "This metric measures the number of last level=
 cache Read accesses missed per thousand instructions executed.",
+        "ScaleUnit": "1MPKI",
+        "MetricGroup": "MPKI;LL_Cache_Effectiveness"
+    },
+    {
+        "MetricName": "load_average_latency",
+        "MetricExpr": "MEM_ACCESS_RD_PERCYC / MEM_ACCESS",
+        "BriefDescription": "This metric measures the average latency of L=
oad operations in CPU cycles.",
+        "ScaleUnit": "1CPU cycles",
+        "MetricGroup": "Average_Latency"
+    },
+    {
+        "MetricName": "load_percentage",
+        "MetricExpr": "100 * (LD_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures Load operations as a per=
centage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "Operation_Mix"
+    },
+    {
+        "MetricName": "nonsve_fp_ops_per_cycle",
+        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLES",
+        "BriefDescription": "This metric measures floating point operation=
s per cycle in any precision performed by an instruction that is not an SVE=
 instruction. Operations are counted by computation and by vector lanes, fu=
sed computations such as multiply-add count as twice per vector lane for ex=
ample.",
+        "ScaleUnit": "1operations per cycle",
+        "MetricGroup": "FP_Arithmetic_Intensity"
+    },
+    {
+        "MetricName": "retiring",
+        "MetricExpr": "100 * ((OP_RETIRED/OP_SPEC) * (1 - (STALL_SLOT/CPU_=
SLOT)))",
+        "BriefDescription": "This metric is the percentage of total slots =
that retired operations, which indicates cycles that were utilized efficien=
tly.",
+        "ScaleUnit": "1percent of slots",
+        "MetricGroup": "TopdownL1"
+    },
+    {
+        "MetricName": "scalar_fp_percentage",
+        "MetricExpr": "100 * (VFP_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures scalar floating point op=
erations as a percentage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "Operation_Mix"
+    },
+    {
+        "MetricName": "simd_percentage",
+        "MetricExpr": "100 * (ASE_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures advanced SIMD operations=
 as a percentage of total operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "Operation_Mix"
+    },
+    {
+        "MetricName": "store_percentage",
+        "MetricExpr": "100 * (ST_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures Store operations as a pe=
rcentage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "Operation_Mix"
+    },
+    {
+        "MetricName": "sve_all_percentage",
+        "MetricExpr": "100 * (SVE_INST_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures scalable vector operatio=
ns, including Loads and Stores, as a percentage of operations speculatively=
 executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "Operation_Mix"
+    },
+    {
+        "MetricName": "sve_fp_ops_per_cycle",
+        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLES",
+        "BriefDescription": "This metric measures floating point operation=
s per cycle in any precision performed by SVE instructions. Operations are =
counted by computation and by vector lanes, fused computations such as mult=
iply-add count as twice per vector lane for example.",
+        "ScaleUnit": "1operations per cycle",
+        "MetricGroup": "FP_Arithmetic_Intensity"
+    },
+    {
+        "MetricName": "sve_predicate_empty_percentage",
+        "MetricExpr": "100 * (SVE_PRED_EMPTY_SPEC / SVE_PRED_SPEC)",
+        "BriefDescription": "This metric measures scalable vector operatio=
ns with no active predicates as a percentage of SVE predicated operations s=
peculatively executed.",
+        "ScaleUnit": "1percent of SVE predicated operations",
+        "MetricGroup": "SVE_Effectiveness"
+    },
+    {
+        "MetricName": "sve_predicate_full_percentage",
+        "MetricExpr": "100 * (SVE_PRED_FULL_SPEC / SVE_PRED_SPEC)",
+        "BriefDescription": "This metric measures scalable vector operatio=
ns with all active predicates as a percentage of SVE predicated operations =
speculatively executed.",
+        "ScaleUnit": "1percent of SVE predicated operations",
+        "MetricGroup": "SVE_Effectiveness"
+    },
+    {
+        "MetricName": "sve_predicate_partial_percentage",
+        "MetricExpr": "100 * (SVE_PRED_PARTIAL_SPEC / SVE_PRED_SPEC)",
+        "BriefDescription": "This metric measures scalable vector operatio=
ns with at least one active predicates as a percentage of SVE predicated op=
erations speculatively executed.",
+        "ScaleUnit": "1percent of SVE predicated operations",
+        "MetricGroup": "SVE_Effectiveness"
+    },
+    {
+        "MetricName": "sve_predicate_percentage",
+        "MetricExpr": "100 * (SVE_PRED_SPEC / INST_SPEC)",
+        "BriefDescription": "This metric measures scalable vector operatio=
ns with predicates as a percentage of operations speculatively executed.",
+        "ScaleUnit": "1percent of operations",
+        "MetricGroup": "SVE_Effectiveness"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json b/tools=
/perf/pmu-events/arch/arm64/nvidia/t410/misc.json
new file mode 100644
index 000000000000..8ff87d844e52
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json
@@ -0,0 +1,642 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR",
+        "PublicDescription": "This event counts software writes to the PMS=
WINC_EL0 (software PMU increment) register. The PMSWINC_EL0 register is a m=
anually updated counter for use by application software.\nThis event could =
be used to measure any user program event, such as accesses to a particular=
 data structure (by writing to the PMSWINC_EL0 register each time the data =
structure is accessed).\nTo use the PMSWINC_EL0 register and event, develop=
ers must insert instructions that write to the PMSWINC_EL0 register into th=
e source code.\nSince the SW_INCR event records writes to the PMSWINC_EL0 r=
egister, there is no need to do a Read/Increment/Write sequence to the PMSW=
INC_EL0 register."
+    },
+    {
+        "ArchStdEvent": "TRB_WRAP",
+        "PublicDescription": "This event is generated each time the trace =
buffer current Write pointer is wrapped to the trace buffer base pointer."
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT0",
+        "PublicDescription": "Trace unit external output 0."
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT1",
+        "PublicDescription": "Trace unit external output 1."
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT2",
+        "PublicDescription": "Trace unit external output 2."
+    },
+    {
+        "ArchStdEvent": "TRCEXTOUT3",
+        "PublicDescription": "Trace unit external output 3."
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT4",
+        "PublicDescription": "Cross-trigger Interface output trigger 4."
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT5",
+        "PublicDescription": "Cross-trigger Interface output trigger 5."
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT6",
+        "PublicDescription": "Cross-trigger Interface output trigger 6."
+    },
+    {
+        "ArchStdEvent": "CTI_TRIGOUT7",
+        "PublicDescription": "Cross-trigger Interface output trigger 7."
+    },
+    {
+        "EventCode": "0x00e1",
+        "EventName": "L1I_PRFM_REQ_DROP",
+        "PublicDescription": "L1 I-cache software prefetch dropped."
+    },
+    {
+        "EventCode": "0x0100",
+        "EventName": "L1_PF_REFILL",
+        "PublicDescription": "L1 prefetch requests, refilled to L1 cache."
+    },
+    {
+        "EventCode": "0x0120",
+        "EventName": "FLUSH",
+        "PublicDescription": "This event counts both the CT flush and BX f=
lush. The BR_MIS_PRED counts the BX flushes. So the FLUSH-BR_MIS_PRED gives=
 the CT flushes."
+    },
+    {
+        "EventCode": "0x0121",
+        "EventName": "FLUSH_MEM",
+        "PublicDescription": "Flushes due to memory hazards. This only inc=
ludes CT flushes."
+    },
+    {
+        "EventCode": "0x0122",
+        "EventName": "FLUSH_BAD_BRANCH",
+        "PublicDescription": "Flushes due to bad predicted branch. This on=
ly includes CT flushes."
+    },
+    {
+        "EventCode": "0x0123",
+        "EventName": "FLUSH_STDBYPASS",
+        "PublicDescription": "Flushes due to bad predecode. This only incl=
udes CT flushes."
+    },
+    {
+        "EventCode": "0x0124",
+        "EventName": "FLUSH_ISB",
+        "PublicDescription": "Flushes due to ISB or similar side-effects. =
This only includes CT flushes."
+    },
+    {
+        "EventCode": "0x0125",
+        "EventName": "FLUSH_OTHER",
+        "PublicDescription": "Flushes due to other hazards. This only incl=
udes CT flushes."
+    },
+    {
+        "EventCode": "0x0126",
+        "EventName": "STORE_STREAM",
+        "PublicDescription": "Stored lines in streaming no-Write-allocate =
mode."
+    },
+    {
+        "EventCode": "0x0127",
+        "EventName": "NUKE_RAR",
+        "PublicDescription": "Load/Store nuke due to Read-after-Read order=
ing hazard."
+    },
+    {
+        "EventCode": "0x0128",
+        "EventName": "NUKE_RAW",
+        "PublicDescription": "Load/Store nuke due to Read-after-Write orde=
ring hazard."
+    },
+    {
+        "EventCode": "0x0129",
+        "EventName": "L1_PF_GEN_PAGE",
+        "PublicDescription": "Load/Store prefetch to L1 generated, Page mo=
de."
+    },
+    {
+        "EventCode": "0x012a",
+        "EventName": "L1_PF_GEN_STRIDE",
+        "PublicDescription": "Load/Store prefetch to L1 generated, stride =
mode."
+    },
+    {
+        "EventCode": "0x012b",
+        "EventName": "L2_PF_GEN_LD",
+        "PublicDescription": "Load prefetch to L2 generated."
+    },
+    {
+        "EventCode": "0x012d",
+        "EventName": "LS_PF_TRAIN_TABLE_ALLOC",
+        "PublicDescription": "LS prefetch train table entry allocated."
+    },
+    {
+        "EventCode": "0x0130",
+        "EventName": "LS_PF_GEN_TABLE_ALLOC",
+        "PublicDescription": "This event counts the number of cycles with =
at least one table allocation, for L2 hardware prefetches (including the so=
ftware PRFM instructions that are converted into hardware prefetches due to=
 D-TLB miss).\nLS prefetch gen table allocation (for L2 prefetches)."
+    },
+    {
+        "EventCode": "0x0131",
+        "EventName": "LS_PF_GEN_TABLE_ALLOC_PF_PEND",
+        "PublicDescription": "This event counts the number of cycles in wh=
ich at least one hardware prefetch is dropped due to the inability to ident=
ify a victim when the generation table is full. The hardware prefetch consi=
dered here includes the software PRFM that is converted into hardware prefe=
tches due to D-TLB miss."
+    },
+    {
+        "EventCode": "0x0132",
+        "EventName": "TBW",
+        "PublicDescription": "Tablewalks."
+    },
+    {
+        "EventCode": "0x0134",
+        "EventName": "S1L2_HIT",
+        "PublicDescription": "Translation cache hit on S1L2 walk cache ent=
ry."
+    },
+    {
+        "EventCode": "0x0135",
+        "EventName": "S1L1_HIT",
+        "PublicDescription": "Translation cache hit on S1L1 walk cache ent=
ry."
+    },
+    {
+        "EventCode": "0x0136",
+        "EventName": "S1L0_HIT",
+        "PublicDescription": "Translation cache hit on S1L0 walk cache ent=
ry."
+    },
+    {
+        "EventCode": "0x0137",
+        "EventName": "S2L2_HIT",
+        "PublicDescription": "Translation cache hit for S2L2 IPA walk cach=
e entry."
+    },
+    {
+        "EventCode": "0x0138",
+        "EventName": "IPA_REQ",
+        "PublicDescription": "Translation cache lookups for IPA to PA entr=
ies."
+    },
+    {
+        "EventCode": "0x0139",
+        "EventName": "IPA_REFILL",
+        "PublicDescription": "Translation cache refills for IPA to PA entr=
ies."
+    },
+    {
+        "EventCode": "0x013a",
+        "EventName": "S1_FLT",
+        "PublicDescription": "Stage1 tablewalk fault."
+    },
+    {
+        "EventCode": "0x013b",
+        "EventName": "S2_FLT",
+        "PublicDescription": "Stage2 tablewalk fault."
+    },
+    {
+        "EventCode": "0x013c",
+        "EventName": "COLT_REFILL",
+        "PublicDescription": "Aggregated page refill."
+    },
+    {
+        "EventCode": "0x0145",
+        "EventName": "L1_PF_HIT",
+        "PublicDescription": "L1 prefetch requests, hitting in L1 cache."
+    },
+    {
+        "EventCode": "0x0146",
+        "EventName": "L1_PF",
+        "PublicDescription": "L1 prefetch requests."
+    },
+    {
+        "EventCode": "0x0147",
+        "EventName": "CACHE_LS_REFILL",
+        "PublicDescription": "L2 D-cache refill, Load/Store."
+    },
+    {
+        "EventCode": "0x0148",
+        "EventName": "CACHE_PF",
+        "PublicDescription": "L2 prefetch requests."
+    },
+    {
+        "EventCode": "0x0149",
+        "EventName": "CACHE_PF_HIT",
+        "PublicDescription": "L2 prefetch requests, hitting in L2 cache."
+    },
+    {
+        "EventCode": "0x0150",
+        "EventName": "UNUSED_PF",
+        "PublicDescription": "L2 unused prefetch."
+    },
+    {
+        "EventCode": "0x0151",
+        "EventName": "PFT_SENT",
+        "PublicDescription": "L2 prefetch TGT sent.\nNote that PFT_SENT !=
=3D PFT_USEFUL + PFT_DROP. There may be PFT_SENT for which the accesses res=
ulted in a SLC hit."
+    },
+    {
+        "EventCode": "0x0152",
+        "EventName": "PFT_USEFUL",
+        "PublicDescription": "L2 prefetch TGT useful."
+    },
+    {
+        "EventCode": "0x0153",
+        "EventName": "PFT_DROP",
+        "PublicDescription": "L2 prefetch TGT dropped."
+    },
+    {
+        "EventCode": "0x0162",
+        "EventName": "LRQ_FULL",
+        "PublicDescription": "This event counts the number of cycles the L=
RQ is full."
+    },
+    {
+        "EventCode": "0x0163",
+        "EventName": "FETCH_FQ_EMPTY",
+        "PublicDescription": "Fetch Queue empty cycles."
+    },
+    {
+        "EventCode": "0x0164",
+        "EventName": "FPG2",
+        "PublicDescription": "Forward progress guarantee. Medium range liv=
elock triggered."
+    },
+    {
+        "EventCode": "0x0165",
+        "EventName": "FPG",
+        "PublicDescription": "Forward progress guarantee. Tofu global live=
lock buster is triggered."
+    },
+    {
+        "EventCode": "0x0172",
+        "EventName": "DEADBLOCK",
+        "PublicDescription": "Write-back evictions converted to dataless E=
VICT.\nThe victim line is deemed deadblock if the likeliness of a reuse is =
low. The Core uses dataless evict to evict a deadblock; and it uses an evic=
t with data to evict an L2 line that is not a deadblock."
+    },
+    {
+        "EventCode": "0x0173",
+        "EventName": "PF_PRQ_ALLOC_PF_PEND",
+        "PublicDescription": "L1 prefetch prq allocation (replacing pendin=
g)."
+    },
+    {
+        "EventCode": "0x0178",
+        "EventName": "FETCH_ICACHE_INSTR",
+        "PublicDescription": "Instructions fetched from I-cache."
+    },
+    {
+        "EventCode": "0x017b",
+        "EventName": "NEAR_CAS",
+        "PublicDescription": "Near atomics: compare and swap."
+    },
+    {
+        "EventCode": "0x017c",
+        "EventName": "NEAR_CAS_PASS",
+        "PublicDescription": "Near atomics: compare and swap pass."
+    },
+    {
+        "EventCode": "0x017d",
+        "EventName": "FAR_CAS",
+        "PublicDescription": "Far atomics: compare and swap."
+    },
+    {
+        "EventCode": "0x0186",
+        "EventName": "L2_BTB_RELOAD_MAIN_BTB",
+        "PublicDescription": "Number of completed L1 BTB update initiated =
by L2 BTB hit which swap branch information between L1 BTB and L2 BTB."
+    },
+    {
+        "EventCode": "0x018f",
+        "EventName": "L1_PF_GEN_MCMC",
+        "PublicDescription": "Load/Store prefetch to L1 generated, MCMC."
+    },
+    {
+        "EventCode": "0x0190",
+        "EventName": "PF_MODE_0_CYCLES",
+        "PublicDescription": "Number of cycles in which the hardware prefe=
tcher is in the most aggressive mode."
+    },
+    {
+        "EventCode": "0x0191",
+        "EventName": "PF_MODE_1_CYCLES",
+        "PublicDescription": "Number of cycles in which the hardware prefe=
tcher is in the more aggressive mode."
+    },
+    {
+        "EventCode": "0x0192",
+        "EventName": "PF_MODE_2_CYCLES",
+        "PublicDescription": "Number of cycles in which the hardware prefe=
tcher is in the less aggressive mode."
+    },
+    {
+        "EventCode": "0x0193",
+        "EventName": "PF_MODE_3_CYCLES",
+        "PublicDescription": "Number of cycles in which the hardware prefe=
tcher is in the most conservative mode."
+    },
+    {
+        "EventCode": "0x0194",
+        "EventName": "TXREQ_LIMIT_MAX_CYCLES",
+        "PublicDescription": "Number of cycles in which the dynamic TXREQ =
limit is the L2_TQ_SIZE."
+    },
+    {
+        "EventCode": "0x0195",
+        "EventName": "TXREQ_LIMIT_3QUARTER_CYCLES",
+        "PublicDescription": "Number of cycles in which the dynamic TXREQ =
limit is between 3/4 of the L2_TQ_SIZE and the L2_TQ_SIZE-1."
+    },
+    {
+        "EventCode": "0x0196",
+        "EventName": "TXREQ_LIMIT_HALF_CYCLES",
+        "PublicDescription": "Number of cycles in which the dynamic TXREQ =
limit is between 1/2 of the L2_TQ_SIZE and 3/4 of the L2_TQ_SIZE."
+    },
+    {
+        "EventCode": "0x0197",
+        "EventName": "TXREQ_LIMIT_1QUARTER_CYCLES",
+        "PublicDescription": "Number of cycles in which the dynamic TXREQ =
limit is between 1/4 of the L2_TQ_SIZE and 1/2 of the L2_TQ_SIZE."
+    },
+    {
+        "EventCode": "0x019d",
+        "EventName": "PREFETCH_LATE_CMC",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit on =
TQ entry allocated by CMC prefetch request."
+    },
+    {
+        "EventCode": "0x019e",
+        "EventName": "PREFETCH_LATE_BO",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit on =
TQ entry allocated by BO prefetch request."
+    },
+    {
+        "EventCode": "0x019f",
+        "EventName": "PREFETCH_LATE_STRIDE",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit on =
TQ entry allocated by STRIDE prefetch request."
+    },
+    {
+        "EventCode": "0x01a0",
+        "EventName": "PREFETCH_LATE_SPATIAL",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit on =
TQ entry allocated by SPATIAL prefetch request."
+    },
+    {
+        "EventCode": "0x01a2",
+        "EventName": "PREFETCH_LATE_TBW",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit on =
TQ entry allocated by TBW prefetch request."
+    },
+    {
+        "EventCode": "0x01a3",
+        "EventName": "PREFETCH_LATE_PAGE",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit on =
TQ entry allocated by PAGE prefetch request."
+    },
+    {
+        "EventCode": "0x01a4",
+        "EventName": "PREFETCH_LATE_GSMS",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit on =
TQ entry allocated by GSMS prefetch request."
+    },
+    {
+        "EventCode": "0x01a5",
+        "EventName": "PREFETCH_LATE_SIP_CONS",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit on =
TQ entry allocated by SIP_CONS prefetch request."
+    },
+    {
+        "EventCode": "0x01a6",
+        "EventName": "PREFETCH_REFILL_CMC",
+        "PublicDescription": "PF/prefetch or PF/readclean request from CMC=
 pf engine filled the L2 cache."
+    },
+    {
+        "EventCode": "0x01a7",
+        "EventName": "PREFETCH_REFILL_BO",
+        "PublicDescription": "PF/prefetch or PF/readclean request from BO =
pf engine filled the L2 cache."
+    },
+    {
+        "EventCode": "0x01a8",
+        "EventName": "PREFETCH_REFILL_STRIDE",
+        "PublicDescription": "PF/prefetch or PF/readclean request from STR=
IDE pf engine filled the L2 cache."
+    },
+    {
+        "EventCode": "0x01a9",
+        "EventName": "PREFETCH_REFILL_SPATIAL",
+        "PublicDescription": "PF/prefetch or PF/readclean request from SPA=
TIAL pf engine filled the L2 cache."
+    },
+    {
+        "EventCode": "0x01ab",
+        "EventName": "PREFETCH_REFILL_TBW",
+        "PublicDescription": "PF/prefetch or PF/readclean request from TBW=
 pf engine filled the L2 cache."
+    },
+    {
+        "EventCode": "0x01ac",
+        "EventName": "PREFETCH_REFILL_PAGE",
+        "PublicDescription": "PF/prefetch or PF/readclean request from PAG=
E pf engine filled the L2 cache."
+    },
+    {
+        "EventCode": "0x01ad",
+        "EventName": "PREFETCH_REFILL_GSMS",
+        "PublicDescription": "PF/prefetch or PF/readclean request from GSM=
S pf engine filled the L2 cache."
+    },
+    {
+        "EventCode": "0x01ae",
+        "EventName": "PREFETCH_REFILL_SIP_CONS",
+        "PublicDescription": "PF/prefetch or PF/readclean request from SIP=
_CONS pf engine filled the L2 cache."
+    },
+    {
+        "EventCode": "0x01af",
+        "EventName": "CACHE_HIT_LINE_PF_CMC",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit in =
L2 cache on line filled by CMC prefetch request."
+    },
+    {
+        "EventCode": "0x01b0",
+        "EventName": "CACHE_HIT_LINE_PF_BO",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit in =
L2 cache on line filled by BO prefetch request."
+    },
+    {
+        "EventCode": "0x01b1",
+        "EventName": "CACHE_HIT_LINE_PF_STRIDE",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit in =
L2 cache on line filled by STRIDE prefetch request."
+    },
+    {
+        "EventCode": "0x01b2",
+        "EventName": "CACHE_HIT_LINE_PF_SPATIAL",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit in =
L2 cache on line filled by SPATIAL prefetch request."
+    },
+    {
+        "EventCode": "0x01b4",
+        "EventName": "CACHE_HIT_LINE_PF_TBW",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit in =
L2 cache on line filled by TBW prefetch request."
+    },
+    {
+        "EventCode": "0x01b5",
+        "EventName": "CACHE_HIT_LINE_PF_PAGE",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit in =
L2 cache on line filled by PAGE prefetch request."
+    },
+    {
+        "EventCode": "0x01b6",
+        "EventName": "CACHE_HIT_LINE_PF_GSMS",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit in =
L2 cache on line filled by GSMS prefetch request."
+    },
+    {
+        "EventCode": "0x01b7",
+        "EventName": "CACHE_HIT_LINE_PF_SIP_CONS",
+        "PublicDescription": "LS/readclean or LS/readunique lookup hit in =
L2 cache on line filled by SIP_CONS prefetch request."
+    },
+    {
+        "EventCode": "0x01ba",
+        "EventName": "PREFETCH_LATE_STORE_ISSUE",
+        "PublicDescription": "This event counts the number of demand reque=
sts that matches a Store-issue prefetcher's pending refill request. These a=
re called late prefetch requests and are still counted as useful prefetcher=
 requests for the sake of accuracy and coverage measurements."
+    },
+    {
+        "EventCode": "0x01bb",
+        "EventName": "PREFETCH_LATE_STORE_STRIDE",
+        "PublicDescription": "This event counts the number of demand reque=
sts that matches a Store-stride prefetcher's pending refill request. These =
are called late prefetch requests and are still counted as useful prefetche=
r requests for the sake of accuracy and coverage measurements."
+    },
+    {
+        "EventCode": "0x01bc",
+        "EventName": "PREFETCH_LATE_PC_OFFSET",
+        "PublicDescription": "This event counts the number of demand reque=
sts that matches a PC-offset prefetcher's pending refill request. These are=
 called late prefetch requests and are still counted as useful prefetcher r=
equests for the sake of accuracy and coverage measurements."
+    },
+    {
+        "EventCode": "0x01bd",
+        "EventName": "PREFETCH_LATE_IFUPF",
+        "PublicDescription": "This event counts the number of demand reque=
sts that matches a IFU prefetcher's pending refill request. These are calle=
d late prefetch requests and are still counted as useful prefetcher request=
s for the sake of accuracy and coverage measurements."
+    },
+    {
+        "EventCode": "0x01be",
+        "EventName": "PREFETCH_REFILL_STORE_ISSUE",
+        "PublicDescription": "This event counts the number of cache refill=
s due to Store-Issue prefetcher."
+    },
+    {
+        "EventCode": "0x01bf",
+        "EventName": "PREFETCH_REFILL_STORE_STRIDE",
+        "PublicDescription": "This event counts the number of cache refill=
s due to Store-stride prefetcher."
+    },
+    {
+        "EventCode": "0x01c0",
+        "EventName": "PREFETCH_REFILL_PC_OFFSET",
+        "PublicDescription": "This event counts the number of cache refill=
s due to PC-offset prefetcher."
+    },
+    {
+        "EventCode": "0x01c1",
+        "EventName": "PREFETCH_REFILL_IFUPF",
+        "PublicDescription": "This event counts the number of cache refill=
s due to IFU prefetcher."
+    },
+    {
+        "EventCode": "0x01c2",
+        "EventName": "CACHE_HIT_LINE_PF_STORE_ISSUE",
+        "PublicDescription": "This event counts the number of first hit to=
 a cache line filled by Store-issue prefetcher."
+    },
+    {
+        "EventCode": "0x01c3",
+        "EventName": "CACHE_HIT_LINE_PF_STORE_STRIDE",
+        "PublicDescription": "This event counts the number of first hit to=
 a cache line filled by Store-stride prefetcher."
+    },
+    {
+        "EventCode": "0x01c4",
+        "EventName": "CACHE_HIT_LINE_PF_PC_OFFSET",
+        "PublicDescription": "This event counts the number of first hit to=
 a cache line filled by PC-offset prefetcher."
+    },
+    {
+        "EventCode": "0x01c5",
+        "EventName": "CACHE_HIT_LINE_PF_IFUPF",
+        "PublicDescription": "This event counts the number of first hit to=
 a cache line filled by IFU prefetcher."
+    },
+    {
+        "EventCode": "0x01c6",
+        "EventName": "L2_PF_GEN_ST_ISSUE",
+        "PublicDescription": "Store-issue prefetch to L2 generated."
+    },
+    {
+        "EventCode": "0x01c7",
+        "EventName": "L2_PF_GEN_ST_STRIDE",
+        "PublicDescription": "Store-stride prefetch to L2 generated"
+    },
+    {
+        "EventCode": "0x01cb",
+        "EventName": "L2_TQ_OUTSTANDING",
+        "PublicDescription": "Outstanding tracker count, per cycle.\nThis =
event increments by the number of valid entries pertaining to this thread i=
n the L2TQ, in each cycle.\nThis event can be used to calculate the occupan=
cy of L2TQ by dividing this by the CPU_CYCLES event. The L2TQ queue tracks =
the outstanding Read, Write and Snoop transactions. The Read transaction an=
d the Write transaction entries are attributable to PE, whereas the Snoop t=
ransactions are not always attributable to PE."
+    },
+    {
+        "EventCode": "0x01cc",
+        "EventName": "TXREQ_LIMIT_COUNT_CYCLES",
+        "PublicDescription": "This event increments by the dynamic TXREQ v=
alue, in each cycle.\nThis is a companion event of TXREQ_LIMIT_MAX_CYCLES, =
TXREQ_LIMIT_3QUARTER_CYCLES, TXREQ_LIMIT_HALF_CYCLES, and TXREQ_LIMIT_1QUAR=
TER_CYCLES."
+    },
+    {
+        "EventCode": "0x01ce",
+        "EventName": "L3DPRFM_TO_L2PRQ_CONVERTED",
+        "PublicDescription": "This event counts the number of Converted-L3=
D-PRFMs. These are indeed L3D PRFM and activities around these PRFM are cou=
nted by the L3D_CACHE_PRFM, L3D_CACHE_REFILL_PRFM and L3D_CACHE_REFILL Even=
ts."
+    },
+    {
+        "EventCode": "0x01d2",
+        "EventName": "DVM_TLBI_RCVD",
+        "PublicDescription": "This event counts the number of TLBI DVM mes=
sage received over CHI interface, for *this* Core."
+    },
+    {
+        "EventCode": "0x01d6",
+        "EventName": "DSB_COMMITING_LOCAL_TLBI",
+        "PublicDescription": "This event counts the number of DSB that are=
 retired and committed at least one local TLBI instruction. This event incr=
ements no more than once (in a cycle) even if the DSB commits multiple loca=
l TLBI instruction."
+    },
+    {
+        "EventCode": "0x01d7",
+        "EventName": "DSB_COMMITING_BROADCAST_TLBI",
+        "PublicDescription": "This event counts the number of DSB that are=
 retired and committed at least one broadcast TLBI instruction. This event =
increments no more than once (in a cycle) even if the DSB commits multiple =
broadcast TLBI instruction."
+    },
+    {
+        "EventCode": "0x01eb",
+        "EventName": "L1DPRFM_L2DPRFM_TO_L2PRQ_CONVERTED",
+        "PublicDescription": "This event counts the number of Converted-L1=
D-PRFMs and Converted-L2D-PRFM.\nActivities involving the Converted-L1D-PRF=
M are counted by the L1D_CACHE_PRFM. However they are *not* counted by the =
L1D_CACHE_REFILL_PRFM, and L1D_CACHE_REFILL, as these Converted-L1D-PRFM ar=
e treated as L2 D hardware prefetches. Activities around the Converted-L1D-=
PRFMs and Converted-L2D-PRFMs are counted by the L2D_CACHE_PRFM, L2D_CACHE_=
REFILL_PRFM and L2D_CACHE_REFILL Events."
+    },
+    {
+        "EventCode": "0x01ec",
+        "EventName": "PREFETCH_LATE_CONVERTED_PRFM",
+        "PublicDescription": "This event counts the number of demand reque=
sts that matches a Converted-L1D-PRFM or Converted-L2D-PRFM pending refill =
request at L2 D-cache. These are called late prefetch requests and are stil=
l counted as useful prefetcher requests for the sake of accuracy and covera=
ge measurements.\nNote that this event is not counted by the L2D_CACHE_HIT_=
RWL1PRF_LATE_HWPRF, though the Converted-L1D-PRFM or Converted-L2D-PRFM are=
 replayed by the L2PRQ."
+    },
+    {
+        "EventCode": "0x01ed",
+        "EventName": "PREFETCH_REFILL_CONVERTED_PRFM",
+        "PublicDescription": "This event counts the number of L2 D-cache r=
efills due to Converted-L1D-PRFM or Converted-L2D-PRFM.\nNote : L2D_CACHE_R=
EFILL_PRFM is inclusive of PREFETCH_REFILL_PRFM_CONVERTED, where both the P=
REFETCH_REFILL_PRFM_CONVERTED and the L2D_CACHE_REFILL_PRFM increment when =
L2 D-cache refills due to Converted-L1D-PRFM or Converted-L2D-PRFM."
+    },
+    {
+        "EventCode": "0x01ee",
+        "EventName": "CACHE_HIT_LINE_PF_CONVERTED_PRFM",
+        "PublicDescription": "This event counts the number of first hit to=
 a cache line filled by Converted-L1D-PRFM or Converted-L2D-PRFM.\nNote tha=
t L2D_CACHE_HIT_RWL1PRF_FPRFM is inclusive of CACHE_HIT_LINE_PF_CONVERTED_P=
RFM, where both the CACHE_HIT_LINE_PF_CONVERTED_PRFM and the L2D_CACHE_HIT_=
RWL1PRF_FPRFM increment on a first hit to L2 D-cache filled by Converted-L1=
D-PRFM or Converted-L2D-PRFM."
+    },
+    {
+        "EventCode": "0x01f0",
+        "EventName": "TMS_ST_TO_SMT_LATENCY",
+        "PublicDescription": "This event counts the number of CPU cycles s=
pent on TMS for ST-to-SMT switch.\nThis event is counted by both the thread=
s - This event in both threads increment during TMS for ST-to-SMT switch."
+    },
+    {
+        "EventCode": "0x01f1",
+        "EventName": "TMS_SMT_TO_ST_LATENCY",
+        "PublicDescription": "This event counts the number of CPU cycles s=
pent on TMS for SMT-to-ST switch. The count also includes the CPU cycles sp=
end due to an aborted SMT-to-ST TMS attempt.\nThis event is counted only by=
 the thread that is not in WFI."
+    },
+    {
+        "EventCode": "0x01f2",
+        "EventName": "TMS_ST_TO_SMT_COUNT",
+        "PublicDescription": "This event counts the number of completed TM=
S from ST-to-SMT.\nThis event is counted only by the active thread (the one=
 that is not in WFI).\nNote: When an active thread enters the Debug state i=
n ST-Full resource mode, it is switched to SMT mode. This is because the in=
active thread cannot wake up while the other thread remains in the Debug st=
ate. To prEvent this issue, threads operating in ST-Full resource mode are =
transitioned to SMT mode upon entering Debug state. This event count will a=
lso reflect such switches from ST to SMT mode.\n(Also see the (NV_CPUACTLR1=
4_EL1.chka_prEvent_st_tx_to_smt_when_tx_in_debug_state bit to disable this =
behavior.)"
+    },
+    {
+        "EventCode": "0x01f3",
+        "EventName": "TMS_SMT_TO_ST_COUNT",
+        "PublicDescription": "This event counts the number of completed TM=
S from SMT-to-ST.\nThis event is counted only by the thread that is not in =
WFI."
+    },
+    {
+        "EventCode": "0x01f4",
+        "EventName": "TMS_SMT_TO_ST_COUNT_ABRT",
+        "PublicDescription": "This event counts the number of aborted TMS =
from SMT-to-ST.\nThis event is counted only by the thread that is not in WF=
I."
+    },
+    {
+        "EventCode": "0x0202",
+        "EventName": "L0I_CACHE_RD",
+        "PublicDescription": "This event counts the number of predict bloc=
ks serviced out of L0 I-cache.\nNote: The L0 I-cache performs at most 4 L0 =
I look-up in a cycle. Two of which are to service PB from L0 I. And the oth=
er two to refill L0 I-cache from L1 I. This event count only the L0 I-cache=
 lookup pertaining to servicing the PB from L0 I."
+    },
+    {
+        "EventCode": "0x0203",
+        "EventName": "L0I_CACHE_REFILL",
+        "PublicDescription": "This event counts the number of L0I cache re=
fill from L1 I-cache."
+    },
+    {
+        "EventCode": "0x0207",
+        "EventName": "INTR_LATENCY",
+        "PublicDescription": "This event counts the number of cycles elaps=
ed between when an Interrupt is recognized (after masking) to when a uop as=
sociated with the first instruction in the destination exception level is a=
llocated. If there is some other flush condition that pre-empts the Interru=
pt, then the cycles counted terminates early at the first instruction execu=
ted after that flush. In the event of dropped Interrupts (when an Interrupt=
 is deasserted before it is taken), this counter measures the number of cyc=
les that elapse from the moment an Interrupt is recognized (post-masking) u=
ntil the Interrupt is dropped or deasserted.\nNote that\n* IESB(Implicit Er=
ror Synchronization Barrier) is an internal mop, so the latency of an impli=
cit IESB mop executed before the Interrupt taken is included in the Interru=
pt latency count.\n* Nukes or TMS sequence within the window are also count=
ed by the Interrupt latency Event.\n* A SMT to ST TMS will be aborted on de=
tecting the wake condition for the WFI thread. The Interrupt latency count =
includes any additional penalty for an aborted TMS."
+    },
+    {
+        "EventCode": "0x021c",
+        "EventName": "CWT_ALLOC_ENTRY",
+        "PublicDescription": "Cache Way Tracker Allocate entry."
+    },
+    {
+        "EventCode": "0x021d",
+        "EventName": "CWT_ALLOC_LINE",
+        "PublicDescription": "Cache Way Tracker Allocate line."
+    },
+    {
+        "EventCode": "0x021e",
+        "EventName": "CWT_HIT",
+        "PublicDescription": "Cache Way Tracker hit."
+    },
+    {
+        "EventCode": "0x021f",
+        "EventName": "CWT_HIT_TAG",
+        "PublicDescription": "Cache Way Tracker hit when ITAG lookup suppr=
essed."
+    },
+    {
+        "EventCode": "0x0220",
+        "EventName": "CWT_REPLAY_TAG",
+        "PublicDescription": "Cache Way Tracker causes ITAG replay due to =
miss when ITAG lookup suppressed."
+    },
+    {
+        "EventCode": "0x0250",
+        "EventName": "GPT_REQ",
+        "PublicDescription": "GPT lookup."
+    },
+    {
+        "EventCode": "0x0251",
+        "EventName": "GPT_WC_HIT",
+        "PublicDescription": "GPT lookup hit in Walk cache."
+    },
+    {
+        "EventCode": "0x0252",
+        "EventName": "GPT_PG_HIT",
+        "PublicDescription": "GPT lookup hit in TLB."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/retired.json b/to=
ols/perf/pmu-events/arch/arm64/nvidia/t410/retired.json
new file mode 100644
index 000000000000..34c7eefa66b0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/retired.json
@@ -0,0 +1,94 @@
+[
+    {
+        "ArchStdEvent": "INST_RETIRED",
+        "PublicDescription": "This event counts instructions that have bee=
n architecturally executed."
+    },
+    {
+        "ArchStdEvent": "CID_WRITE_RETIRED",
+        "PublicDescription": "This event counts architecturally executed w=
rites to the CONTEXTIDR_EL1 register, which usually contains the kernel PID=
 and can be output with hardware trace."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed d=
irect branches."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_RETIRED",
+        "PublicDescription": "This event counts architecturally executed p=
rocedure returns."
+    },
+    {
+        "ArchStdEvent": "TTBR_WRITE_RETIRED",
+        "PublicDescription": "This event counts architectural writes to TT=
BR0/1_EL1. If virtualization host extensions are enabled (by setting the HC=
R_EL2.E2H bit to 1), then accesses to TTBR0/1_EL1 that are redirected to TT=
BR0/1_EL2, or accesses to TTBR0/1_EL12, are counted. TTBRn registers are ty=
pically updated when the kernel is swapping user-space threads or applicati=
ons."
+    },
+    {
+        "ArchStdEvent": "BR_RETIRED",
+        "PublicDescription": "This event counts architecturally executed b=
ranches, whether the branch is taken or not. Instructions that explicitly w=
rite to the PC are also counted. Note that exception generating instruction=
s, exception return instructions, and context synchronization instructions =
are not counted."
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED",
+        "PublicDescription": "This event counts branches counted by BR_RET=
IRED which were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "OP_RETIRED",
+        "PublicDescription": "This event counts micro-operations that are =
architecturally executed. This is a count of number of micro-operations ret=
ired from the commit queue in a single cycle."
+    },
+    {
+        "ArchStdEvent": "BR_INDNR_TAKEN_RETIRED",
+        "PublicDescription": "This event counts architecturally executed i=
ndirect branches excluding procedure returns that were taken."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed d=
irect branches that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_MIS_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed d=
irect branches that were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_IND_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed i=
ndirect branches including procedure returns that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_IND_MIS_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed i=
ndirect branches including procedure returns that were mispredicted and cau=
sed a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed p=
rocedure returns that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_MIS_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed p=
rocedure returns that were mispredicted and caused a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_INDNR_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed i=
ndirect branches excluding procedure returns that were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_INDNR_MIS_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed i=
ndirect branches excluding procedure returns that were mispredicted and cau=
sed a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_TAKEN_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed b=
ranches that were taken and were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_TAKEN_MIS_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed b=
ranches that were taken and were mispredicted causing a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_SKIP_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed b=
ranches that were not taken and were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_SKIP_MIS_PRED_RETIRED",
+        "PublicDescription": "This event counts architecturally executed b=
ranches that were not taken and were mispredicted causing a pipeline flush."
+    },
+    {
+        "ArchStdEvent": "BR_PRED_RETIRED",
+        "PublicDescription": "This event counts branch instructions counte=
d by BR_RETIRED which were correctly predicted."
+    },
+    {
+        "ArchStdEvent": "BR_IND_RETIRED",
+        "PublicDescription": "This event counts architecturally executed i=
ndirect branches including procedure returns."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/spe.json b/tools/=
perf/pmu-events/arch/arm64/nvidia/t410/spe.json
new file mode 100644
index 000000000000..00d0c5051a48
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/spe.json
@@ -0,0 +1,42 @@
+[
+    {
+        "ArchStdEvent": "SAMPLE_POP",
+        "PublicDescription": "This event counts statistical profiling samp=
le population, the count of all operations that could be sampled but may or=
 may not be chosen for sampling."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED",
+        "PublicDescription": "This event counts statistical profiling samp=
les taken for sampling."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FILTRATE",
+        "PublicDescription": "This event counts statistical profiling samp=
les taken which are not removed by filtering."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_COLLISION",
+        "PublicDescription": "This event counts statistical profiling samp=
les that have collided with a previous sample and so therefore not taken."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_BR",
+        "PublicDescription": "This event counts statistical profiling samp=
les taken which are branches."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_LD",
+        "PublicDescription": "This event counts statistical profiling samp=
les taken which are Loads or Load atomic operations."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_ST",
+        "PublicDescription": "This event counts statistical profiling samp=
les taken which are Stores or Store atomic operations."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_OP",
+        "PublicDescription": "This event counts statistical profiling samp=
les taken which are matching any operation type filters supported."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_EVENT",
+        "PublicDescription": "This event counts statistical profiling samp=
les taken which are matching event packet filter constraints."
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED_LAT",
+        "PublicDescription": "This event counts statistical profiling samp=
les taken which are exceeding minimum latency set by operation latency filt=
er constraints."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/spec_operation.js=
on b/tools/perf/pmu-events/arch/arm64/nvidia/t410/spec_operation.json
new file mode 100644
index 000000000000..8bc802f5f350
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/spec_operation.json
@@ -0,0 +1,230 @@
+[
+    {
+        "ArchStdEvent": "INST_SPEC",
+        "PublicDescription": "This event counts operations that have been =
speculatively executed."
+    },
+    {
+        "ArchStdEvent": "OP_SPEC",
+        "PublicDescription": "This event counts micro-operations speculati=
vely executed. This is the count of the number of micro-operations dispatch=
ed in a cycle."
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC",
+        "PublicDescription": "This event counts unaligned memory Read oper=
ations issued by the CPU. This event counts unaligned accesses (as defined =
by the actual instruction), even if they are subsequently issued as multipl=
e aligned accesses.\nThis event does not count preload operations (PLD, PLI=
).\nThis event is a subset of the UNALIGNED_LDST_SPEC event."
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC",
+        "PublicDescription": "This event counts unaligned memory Write ope=
rations issued by the CPU. This event counts unaligned accesses (as defined=
 by the actual instruction), even if they are subsequently issued as multip=
le aligned accesses.\nThis event is a subset of the UNALIGNED_LDST_SPEC eve=
nt."
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
+        "PublicDescription": "This event counts unaligned memory operation=
s issued by the CPU. This event counts unaligned accesses (as defined by th=
e actual instruction), even if they are subsequently issued as multiple ali=
gned accesses.\nThis event is the sum of the following events:\nUNALIGNED_S=
T_SPEC and\nUNALIGNED_LD_SPEC."
+    },
+    {
+        "ArchStdEvent": "LDREX_SPEC",
+        "PublicDescription": "This event counts Load-Exclusive operations =
that have been speculatively executed. For example: LDREX, LDX"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC",
+        "PublicDescription": "This event counts Store-exclusive operations=
 that have been speculatively executed and have successfully completed the =
Store operation."
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC",
+        "PublicDescription": "This event counts Store-exclusive operations=
 that have been speculatively executed and have not successfully completed =
the Store operation."
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC",
+        "PublicDescription": "This event counts Store-exclusive operations=
 that have been speculatively executed.\nThis event is the sum of the follo=
wing events:\nSTREX_PASS_SPEC and\nSTREX_FAIL_SPEC."
+    },
+    {
+        "ArchStdEvent": "LD_SPEC",
+        "PublicDescription": "This event counts speculatively executed Loa=
d operations including Single Instruction Multiple Data (SIMD) Load operati=
ons."
+    },
+    {
+        "ArchStdEvent": "ST_SPEC",
+        "PublicDescription": "This event counts speculatively executed Sto=
re operations including Single Instruction Multiple Data (SIMD) Store opera=
tions."
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC",
+        "PublicDescription": "This event counts Load and Store operations =
that have been speculatively executed."
+    },
+    {
+        "ArchStdEvent": "DP_SPEC",
+        "PublicDescription": "This event counts speculatively executed log=
ical or arithmetic instructions such as MOV/MVN operations."
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC",
+        "PublicDescription": "This event counts speculatively executed Adv=
anced SIMD operations excluding Load, Store, and Move micro-operations that=
 move data to or from SIMD (vector) registers."
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC",
+        "PublicDescription": "This event counts speculatively executed flo=
ating point operations. This event does not count operations that move data=
 to or from floating point (vector) registers."
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC",
+        "PublicDescription": "This event counts speculatively executed ope=
rations which cause software changes of the PC. Those operations include al=
l taken branch operations."
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC",
+        "PublicDescription": "This event counts speculatively executed cry=
ptographic operations except for PMULL and VMULL operations."
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC",
+        "PublicDescription": "This event counts direct branch operations w=
hich are speculatively executed."
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC",
+        "PublicDescription": "This event counts procedure return operation=
s (RET, RETAA and RETAB) which are speculatively executed."
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC",
+        "PublicDescription": "This event counts indirect branch operations=
 including procedure returns, which are speculatively executed. This includ=
es operations that force a software change of the PC, other than exception-=
generating operations and direct branch instructions. Some examples of the =
instructions counted by this event include BR Xn, RET, etc."
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC",
+        "PublicDescription": "This event counts ISB operations that are ex=
ecuted."
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC",
+        "PublicDescription": "This event counts DSB operations that are sp=
eculatively issued to Load/Store unit in the CPU."
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC",
+        "PublicDescription": "This event counts DMB operations that are sp=
eculatively issued to the Load/Store unit in the CPU. This event does not c=
ount implied barriers from Load-acquire/Store-release operations."
+    },
+    {
+        "ArchStdEvent": "CSDB_SPEC",
+        "PublicDescription": "This event counts CSDB operations that are s=
peculatively issued to the Load/Store unit in the CPU. This event does not =
count implied barriers from Load-acquire/Store-release operations."
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC",
+        "PublicDescription": "This event counts any Load acquire operation=
s that are speculatively executed. For example: LDAR, LDARH, LDARB"
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC",
+        "PublicDescription": "This event counts any Store release operatio=
ns that are speculatively executed. For example: STLR, STLRH, STLRB"
+    },
+    {
+        "ArchStdEvent": "SIMD_INST_SPEC",
+        "PublicDescription": "This event counts speculatively executed ope=
rations that are SIMD or SVE vector operations or Advanced SIMD non-scalar =
operations."
+    },
+    {
+        "ArchStdEvent": "ASE_INST_SPEC",
+        "PublicDescription": "This event counts speculatively executed Adv=
anced SIMD operations."
+    },
+    {
+        "ArchStdEvent": "SVE_INST_SPEC",
+        "PublicDescription": "This event counts speculatively executed ope=
rations that are SVE operations."
+    },
+    {
+        "ArchStdEvent": "INT_SPEC",
+        "PublicDescription": "This event counts speculatively executed int=
eger arithmetic operations."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_SPEC",
+        "PublicDescription": "This event counts speculatively executed pre=
dicated SVE operations.\nThis counter also counts SVE operation due to inst=
ruction with Governing predicate operand that determines the Active element=
s that do not write to any SVE Z vector destination register using either z=
eroing or merging predicate. Thus, the operations due to instructions such =
as INCP, DECP, UQINCP, UQDECP, SQINCP, SQDECP and PNEXT, are counted by the=
 SVE_PRED_* events."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_EMPTY_SPEC",
+        "PublicDescription": "This event counts speculatively executed pre=
dicated SVE operations with no active predicate elements.\nThis counter als=
o counts SVE operation due to instruction with Governing predicate operand =
that determines the Active elements that do not write to any SVE Z vector d=
estination register using either zeroing or merging predicate. Thus, the op=
erations due to instructions such as INCP, DECP, UQINCP, UQDECP, SQINCP, SQ=
DECP and PNEXT, are counted by the SVE_PRED_* events."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_FULL_SPEC",
+        "PublicDescription": "This event counts speculatively executed pre=
dicated SVE operations with all predicate elements active.\nThis counter al=
so counts SVE operation due to instruction with Governing predicate operand=
 that determines the Active elements that do not write to any SVE Z vector =
destination register using either zeroing or merging predicate. Thus, the o=
perations due to instructions such as INCP, DECP, UQINCP, UQDECP, SQINCP, S=
QDECP and PNEXT, are counted by the SVE_PRED_* events."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_PARTIAL_SPEC",
+        "PublicDescription": "This event counts speculatively executed pre=
dicated SVE operations with at least one but not all active predicate eleme=
nts.\nThis counter also counts SVE operation due to instruction with Govern=
ing predicate operand that determines the Active elements that do not write=
 to any SVE Z vector destination register using either zeroing or merging p=
redicate. Thus, the operations due to instructions such as INCP, DECP, UQIN=
CP, UQDECP, SQINCP, SQDECP and PNEXT, are counted by the SVE_PRED_* events."
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_NOT_FULL_SPEC",
+        "PublicDescription": "This event counts speculatively executed pre=
dicated SVE operations with at least one non active predicate elements.\nTh=
is counter also counts SVE operation due to instruction with Governing pred=
icate operand that determines the Active elements that do not write to any =
SVE Z vector destination register using either zeroing or merging predicate=
. Thus, the operations due to instructions such as INCP, DECP, UQINCP, UQDE=
CP, SQINCP, SQDECP and PNEXT, are counted by the SVE_PRED_* events."
+    },
+    {
+        "ArchStdEvent": "PRF_SPEC",
+        "PublicDescription": "This event counts speculatively executed ope=
rations that prefetch memory. For example, Scalar: PRFM, SVE: PRFB, PRFD, P=
RFH, or PRFW."
+    },
+    {
+        "ArchStdEvent": "SVE_LDFF_SPEC",
+        "PublicDescription": "This event counts speculatively executed SVE=
 first fault or non-fault Load operations."
+    },
+    {
+        "ArchStdEvent": "SVE_LDFF_FAULT_SPEC",
+        "PublicDescription": "This event counts speculatively executed SVE=
 first fault or non-fault Load operations that clear at least one bit in th=
e FFR."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT8_SPEC",
+        "PublicDescription": "This event counts speculatively executed Adv=
anced SIMD or SVE integer operations with the largest data type being an 8-=
bit integer."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT16_SPEC",
+        "PublicDescription": "This event counts speculatively executed Adv=
anced SIMD or SVE integer operations with the largest data type a 16-bit in=
teger."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT32_SPEC",
+        "PublicDescription": "This event counts speculatively executed Adv=
anced SIMD or SVE integer operations with the largest data type a 32-bit in=
teger."
+    },
+    {
+        "ArchStdEvent": "ASE_SVE_INT64_SPEC",
+        "PublicDescription": "This event counts speculatively executed Adv=
anced SIMD or SVE integer operations with the largest data type a 64-bit in=
teger."
+    },
+    {
+        "EventCode": "0x011d",
+        "EventName": "SPEC_RET_STACK_FULL",
+        "PublicDescription": "This event counts predict pipe stalls due to=
 speculative return address predictor full."
+    },
+    {
+        "EventCode": "0x011f",
+        "EventName": "MOPS_SPEC",
+        "PublicDescription": "Macro-ops speculatively decoded."
+    },
+    {
+        "EventCode": "0x0180",
+        "EventName": "BR_SPEC_PRED_TAKEN",
+        "PublicDescription": "Number of predicted taken from branch predic=
tor."
+    },
+    {
+        "EventCode": "0x0181",
+        "EventName": "BR_SPEC_PRED_TAKEN_FROM_L2BTB",
+        "PublicDescription": "Number of predicted taken branch from L2 BTB=
."
+    },
+    {
+        "EventCode": "0x0182",
+        "EventName": "BR_SPEC_PRED_TAKEN_MULTI",
+        "PublicDescription": "Number of predicted taken for polymorphic br=
anch."
+    },
+    {
+        "EventCode": "0x0185",
+        "EventName": "BR_SPEC_PRED_STATIC",
+        "PublicDescription": "Number of post fetch prediction."
+    },
+    {
+        "EventCode": "0x01d0",
+        "EventName": "TLBI_LOCAL_SPEC",
+        "PublicDescription": "A non-broadcast TLBI instruction executed (S=
peculatively or otherwise) on *this* PE."
+    },
+    {
+        "EventCode": "0x01d1",
+        "EventName": "TLBI_BROADCAST_SPEC",
+        "PublicDescription": "A broadcast TLBI instruction executed (Specu=
latively or otherwise) on *this* PE."
+    },
+    {
+        "EventCode": "0x01e7",
+        "EventName": "BR_SPEC_PRED_ALN_REDIR",
+        "PublicDescription": "BPU predict pipe align redirect (either AL-A=
PQ hit/miss)."
+    },
+    {
+        "EventCode": "0x0200",
+        "EventName": "SIMD_CRYPTO_INST_SPEC",
+        "PublicDescription": "SIMD, SVE, and CRYPTO instructions speculati=
vely decoded."
+    },
+    {
+        "EventCode": "0x022e",
+        "EventName": "VPRED_LD_SPEC",
+        "PublicDescription": "This event counts the number of Speculativel=
y-executed-Load operations with addresses produced by the value-prediction =
mechanism. The loaded data might be discarded if the predicted address diff=
ers from the actual address."
+    },
+    {
+        "EventCode": "0x022f",
+        "EventName": "VPRED_LD_SPEC_MISMATCH",
+        "PublicDescription": "This event counts a subset of VPRED_LD_SPEC =
where the predicted Load address and the actual address mismatched."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/stall.json b/tool=
s/perf/pmu-events/arch/arm64/nvidia/t410/stall.json
new file mode 100644
index 000000000000..92d9e0866c24
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/stall.json
@@ -0,0 +1,145 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND",
+        "PublicDescription": "This event counts cycles when frontend could=
 not send any micro-operations to the rename stage because of frontend reso=
urce stalls caused by fetch memory latency or branch prediction flow stalls=
. STALL_FRONTEND_SLOTS counts SLOTS during the cycle when this event counts=
. STALL_SLOT_FRONTEND will count SLOTS when this event is counted on this C=
PU."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND",
+        "PublicDescription": "This event counts cycles whenever the rename=
 unit is unable to send any micro-operations to the backend of the pipeline=
 because of backend resource constraints. Backend resource constraints can =
include issue stage fullness, execution stage fullness, or other internal p=
ipeline resource fullness. All the backend slots were empty during the cycl=
e when this event counts."
+    },
+    {
+        "ArchStdEvent": "STALL",
+        "PublicDescription": "This event counts cycles when no operations =
are sent to the rename unit from the frontend or from the rename unit to th=
e backend for any reason (either frontend or backend stall). This event is =
the sum of the following events:\nSTALL_FRONTEND and\nSTALL_BACKEND."
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_BACKEND",
+        "PublicDescription": "This event counts slots per cycle in which n=
o operations are sent from the rename unit to the backend due to backend re=
source constraints. STALL_BACKEND counts during the cycle when STALL_SLOT_B=
ACKEND counts at least 1. STALL_BACKEND counts during the cycle when STALL_=
SLOT_BACKEND is SLOTS."
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_FRONTEND",
+        "PublicDescription": "This event counts slots per cycle in which n=
o operations are sent to the rename unit from the frontend due to frontend =
resource constraints. STALL_FRONTEND counts during the cycle when STALL_SLO=
T_FRONTEND is SLOTS."
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT",
+        "PublicDescription": "This event counts slots per cycle in which n=
o operations are sent to the rename unit from the frontend or from the rena=
me unit to the backend for any reason (either frontend or backend stall).\n=
STALL_SLOT is the sum of the following events:\nSTALL_SLOT_FRONTEND and\nST=
ALL_SLOT_BACKEND."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEM",
+        "PublicDescription": "This event counts cycles when the backend is=
 stalled because there is a pending demand Load request in progress in the =
last level Core cache.\nLast level cache in this CPU is Level 2, hence this=
 event counts same as STALL_BACKEND_L2D."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_MEMBOUND",
+        "PublicDescription": "This event counts cycles when the frontend c=
ould not send any micro-operations to the rename stage due to resource cons=
traints in the memory resources."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_L1I",
+        "PublicDescription": "This event counts cycles when the frontend i=
s stalled because there is an instruction fetch request pending in the L1 I=
-cache."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_MEM",
+        "PublicDescription": "This event counts cycles when the frontend i=
s stalled because there is an instruction fetch request pending in the last=
 level Core cache.\nLast level cache in this CPU is Level 2, hence this eve=
nt counts rather than STALL_FRONTEND_L2I."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_TLB",
+        "PublicDescription": "This event counts when the frontend is stall=
ed on any TLB misses being handled. This event also counts the TLB accesses=
 made by hardware prefetches."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_CPUBOUND",
+        "PublicDescription": "This event counts cycles when the frontend c=
ould not send any micro-operations to the rename stage due to resource cons=
traints in the CPU resources excluding memory resources."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_FLOW",
+        "PublicDescription": "This event counts cycles when the frontend c=
ould not send any micro-operations to the rename stage due to resource cons=
traints in the branch prediction unit."
+    },
+    {
+        "ArchStdEvent": "STALL_FRONTEND_FLUSH",
+        "PublicDescription": "This event counts cycles when the frontend c=
ould not send any micro-operations to the rename stage as the frontend is r=
ecovering from a machine flush or resteer. Example scenarios that cause a f=
lush include branch mispredictions, taken exceptions, microarchitectural fl=
ush etc."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEMBOUND",
+        "PublicDescription": "This event counts cycles when the backend co=
uld not accept any micro-operations due to resource constraints in the memo=
ry resources."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_L1D",
+        "PublicDescription": "This event counts cycles when the backend is=
 stalled because there is a pending demand Load request in progress in the =
L1 D-cache."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_TLB",
+        "PublicDescription": "This event counts cycles when the backend is=
 stalled on any demand TLB misses being handled."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_ST",
+        "PublicDescription": "This event counts cycles when the backend is=
 stalled and there is a Store that has not reached the pre-commit stage."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_CPUBOUND",
+        "PublicDescription": "This event counts cycles when the backend co=
uld not accept any micro-operations due to any resource constraints in the =
CPU excluding memory resources."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_BUSY",
+        "PublicDescription": "This event counts cycles when the backend co=
uld not accept any micro-operations because the issue queues are full to ta=
ke any operations for execution."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_ILOCK",
+        "PublicDescription": "This event counts cycles when the backend co=
uld not accept any micro-operations due to resource constraints imposed by =
input dependency."
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_RENAME",
+        "PublicDescription": "This event counts cycles when backend is sta=
lled even when operations are available from the frontend but at least one =
is not ready to be sent to the backend because no rename register is availa=
ble."
+    },
+    {
+        "EventCode": "0x0158",
+        "EventName": "FLAG_DISP_STALL",
+        "PublicDescription": "Rename stalled due to FRF(Flag register file=
) full."
+    },
+    {
+        "EventCode": "0x0159",
+        "EventName": "GEN_DISP_STALL",
+        "PublicDescription": "Rename stalled due to GRF (General-purpose r=
egister file) full."
+    },
+    {
+        "EventCode": "0x015a",
+        "EventName": "VEC_DISP_STALL",
+        "PublicDescription": "Rename stalled due to VRF (Vector register f=
ile) full."
+    },
+    {
+        "EventCode": "0x015c",
+        "EventName": "SX_IQ_STALL",
+        "PublicDescription": "Dispatch stalled due to IQ full, SX."
+    },
+    {
+        "EventCode": "0x015d",
+        "EventName": "MX_IQ_STALL",
+        "PublicDescription": "Dispatch stalled due to IQ full, MX."
+    },
+    {
+        "EventCode": "0x015e",
+        "EventName": "LS_IQ_STALL",
+        "PublicDescription": "Dispatch stalled due to IQ full, LS."
+    },
+    {
+        "EventCode": "0x015f",
+        "EventName": "VX_IQ_STALL",
+        "PublicDescription": "Dispatch stalled due to IQ full, VX."
+    },
+    {
+        "EventCode": "0x0160",
+        "EventName": "MCQ_FULL_STALL",
+        "PublicDescription": "Dispatch stalled due to MCQ full."
+    },
+    {
+        "EventCode": "0x01cf",
+        "EventName": "PRD_DISP_STALL",
+        "PublicDescription": "Rename stalled due to predicate registers (p=
hysical) are full."
+    },
+    {
+        "EventCode": "0x01e0",
+        "EventName": "CSDB_STALL",
+        "PublicDescription": "Rename stalled due to CSDB."
+    },
+    {
+        "EventCode": "0x01e2",
+        "EventName": "STALL_SLOT_FRONTEND_WITHOUT_MISPRED",
+        "PublicDescription": "Stall slot frontend during non-mispredicted =
branch.\nThis event counts the STALL_STOT_FRONTEND Events, except for the 4=
 cycles following a mispredicted branch Event or 4 cycles following a commi=
t flush&restart Event."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/nvidia/t410/tlb.json b/tools/=
perf/pmu-events/arch/arm64/nvidia/t410/tlb.json
new file mode 100644
index 000000000000..18ec5c348c87
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/nvidia/t410/tlb.json
@@ -0,0 +1,158 @@
+[
+    {
+        "ArchStdEvent": "L1I_TLB_REFILL",
+        "PublicDescription": "This event counts L1 Instruction TLB refills=
 from any instruction fetch (demand, hardware prefetch, and software preloa=
d accesses). If there are multiple misses in the TLB that are resolved by t=
he refill, then this event only counts once. This event will not count if t=
he translation table walk results in a fault (such as a translation or acce=
ss fault), since there is no new translation created for the TLB."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL",
+        "PublicDescription": "This event counts L1 Data TLB accesses that =
resulted in TLB refills. If there are multiple misses in the TLB that are r=
esolved by the refill, then this event only counts once. This event counts =
for refills caused by preload instructions or hardware prefetch accesses. T=
his event counts regardless of whether the miss hits in L2 or results in a =
translation table walk. This event will not count if the translation table =
walk results in a fault (such as a translation or access fault), since ther=
e is no new translation created for the TLB. This event will not count on a=
n access from an AT (Address Translation) instruction.\nThis event counts t=
he sum of the following events:\nL1D_TLB_REFILL_RD and\nL1D_TLB_REFILL_WR."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB",
+        "PublicDescription": "This event counts L1 Data TLB accesses cause=
d by any memory Load or Store operation.\nNote that Load or Store instructi=
ons can be broken up into multiple memory operations.\nThis event does not =
count TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1I_TLB",
+        "PublicDescription": "This event counts L1 instruction TLB accesse=
s (caused by demand or hardware prefetch or software preload accesses), whe=
ther the access hits or misses in the TLB. This event counts both demand ac=
cesses and prefetch or preload generated accesses.\nThis event is a superse=
t of the L1I_TLB_REFILL event."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL",
+        "PublicDescription": "This event counts L2 TLB refills caused by m=
emory operations from both data and instruction fetch, except for those cau=
sed by TLB maintenance operations and hardware prefetches.\nThis event is t=
he sum of the following events:\nL2D_TLB_REFILL_RD and\nL2D_TLB_REFILL_WR."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB",
+        "PublicDescription": "This event counts L2 TLB accesses except tho=
se caused by TLB maintenance operations.\nThis event is the sum of the foll=
owing events:\nL2D_TLB_RD and\nL2D_TLB_WR."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK",
+        "PublicDescription": "This event counts number of demand data tran=
slation table walks caused by a miss in the L2 TLB and performing at least =
one memory access. Translation table walks are counted even if the translat=
ion ended up taking a translation fault for reasons different than EPD, E0P=
D and NFD. Note that partial translations that cause a translation table wa=
lk are also counted. Also note that this event counts walks triggered by so=
ftware preloads, but not walks triggered by hardware prefetchers, and that =
this event does not count walks triggered by TLB maintenance operations.\nT=
his event does not include prefetches."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK",
+        "PublicDescription": "This event counts number of instruction tran=
slation table walks caused by a miss in the L2 TLB and performing at least =
one memory access. Translation table walks are counted even if the translat=
ion ended up taking a translation fault for reasons different than EPD, E0P=
D and NFD. Note that partial translations that cause a translation table wa=
lk are also counted. Also note that this event does not count walks trigger=
ed by TLB maintenance operations.\nThis event does not include prefetches."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
+        "PublicDescription": "This event counts L1 Data TLB refills caused=
 by memory Read operations. If there are multiple misses in the TLB that ar=
e resolved by the refill, then this event only counts once. This event coun=
ts for refills caused by preload instructions or hardware prefetch accesses=
. This event counts regardless of whether the miss hits in L2 or results in=
 a translation table walk. This event will not count if the translation tab=
le walk results in a fault (such as a translation or access fault), since t=
here is no new translation created for the TLB. This event will not count o=
n an access from an Address Translation (AT) instruction.\nThis event is a =
subset of the L1D_TLB_REFILL event."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
+        "PublicDescription": "This event counts L1 Data TLB refills caused=
 by data side memory Write operations. If there are multiple misses in the =
TLB that are resolved by the refill, then this event only counts once. This=
 event counts for refills caused by preload instructions or hardware prefet=
ch accesses. This event counts regardless of whether the miss hits in L2 or=
 results in a translation table walk. This event will not count if the tabl=
e walk results in a fault (such as a translation or access fault), since th=
ere is no new translation created for the TLB. This event will not count wi=
th an access from an Address Translation (AT) instruction.\nThis event is a=
 subset of the L1D_TLB_REFILL event."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD",
+        "PublicDescription": "This event counts L1 Data TLB accesses cause=
d by memory Read operations. This event counts whether the access hits or m=
isses in the TLB. This event does not count TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR",
+        "PublicDescription": "This event counts any L1 Data side TLB acces=
ses caused by memory Write operations. This event counts whether the access=
 hits or misses in the TLB. This event does not count TLB maintenance opera=
tions."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD",
+        "PublicDescription": "This event counts L2 TLB refills caused by m=
emory Read operations from both data and instruction fetch except for those=
 caused by TLB maintenance operations or hardware prefetches.\nThis event i=
s a subset of the L2D_TLB_REFILL event."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR",
+        "PublicDescription": "This event counts L2 TLB refills caused by m=
emory Write operations from both data and instruction fetch except for thos=
e caused by TLB maintenance operations.\nThis event is a subset of the L2D_=
TLB_REFILL event."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD",
+        "PublicDescription": "This event counts L2 TLB accesses caused by =
memory Read operations from both data and instruction fetch except for thos=
e caused by TLB maintenance operations.\nThis event is a subset of the L2D_=
TLB event."
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR",
+        "PublicDescription": "This event counts L2 TLB accesses caused by =
memory Write operations from both data and instruction fetch except for tho=
se caused by TLB maintenance operations.\nThis event is a subset of the L2D=
_TLB event."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_PERCYC",
+        "PublicDescription": "This event counts the number of data transla=
tion table walks in progress per cycle."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_PERCYC",
+        "PublicDescription": "This event counts the number of instruction =
translation table walks in progress per cycle."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RW",
+        "PublicDescription": "This event counts L1 Data TLB demand accesse=
s caused by memory Read or Write operations. This event counts whether the =
access hits or misses in the TLB. This event does not count TLB maintenance=
 operations."
+    },
+    {
+        "ArchStdEvent": "L1I_TLB_RD",
+        "PublicDescription": "This event counts L1 Instruction TLB demand =
accesses whether the access hits or misses in the TLB."
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_PRFM",
+        "PublicDescription": "This event counts L1 Data TLB accesses gener=
ated by software prefetch or preload memory accesses. Load or Store instruc=
tions can be broken into multiple memory operations. This event does not co=
unt TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "L1I_TLB_PRFM",
+        "PublicDescription": "This event counts L1 Instruction TLB accesse=
s generated by software preload or prefetch instructions. This event counts=
 whether the access hits or misses in the TLB. This event does not count TL=
B maintenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_HWUPD",
+        "PublicDescription": "This event counts number of memory accesses =
triggered by a data translation table walk and performing an update of a tr=
anslation table entry. Memory accesses are counted even if the translation =
ended up taking a translation fault for reasons different than EPD, E0PD an=
d NFD. Note that this event counts accesses triggered by software preloads,=
 but not accesses triggered by hardware prefetchers."
+    },
+    {
+        "ArchStdEvent": "ITLB_HWUPD",
+        "PublicDescription": "This event counts number of memory accesses =
triggered by an instruction translation table walk and performing an update=
 of a translation table entry. Memory accesses are counted even if the tran=
slation ended up taking a translation fault for reasons different than EPD,=
 E0PD and NFD."
+    },
+    {
+        "ArchStdEvent": "DTLB_STEP",
+        "PublicDescription": "This event counts number of memory accesses =
triggered by a demand data translation table walk and performing a Read of =
a translation table entry. Memory accesses are counted even if the translat=
ion ended up taking a translation fault for reasons different than EPD, E0P=
D and NFD.\nNote that this event counts accesses triggered by software prel=
oads, but not accesses triggered by hardware prefetchers."
+    },
+    {
+        "ArchStdEvent": "ITLB_STEP",
+        "PublicDescription": "This event counts number of memory accesses =
triggered by an instruction translation table walk and performing a Read of=
 a translation table entry. Memory accesses are counted even if the transla=
tion ended up taking a translation fault for reasons different than EPD, E0=
PD and NFD."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_LARGE",
+        "PublicDescription": "This event counts number of demand data tran=
slation table walks caused by a miss in the L2 TLB and yielding a large pag=
e. The set of large pages is defined as all pages with a final size higher =
than or equal to 2MB. Translation table walks that end up taking a translat=
ion fault are not counted, as the page size would be undefined in that case=
. If DTLB_WALK_BLOCK is implemented, then it is an alias for this event in =
this family.\nNote that partial translations that cause a translation table=
 walk are also counted.\nAlso note that this event counts walks triggered b=
y software preloads, but not walks triggered by hardware prefetchers, and t=
hat this event does not count walks triggered by TLB maintenance operations=
."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_LARGE",
+        "PublicDescription": "This event counts number of instruction tran=
slation table walks caused by a miss in the L2 TLB and yielding a large pag=
e. The set of large pages is defined as all pages with a final size higher =
than or equal to 2MB. Translation table walks that end up taking a translat=
ion fault are not counted, as the page size would be undefined in that case=
. In this family, this is equal to ITLB_WALK_BLOCK event.\nNote that partia=
l translations that cause a translation table walk are also counted.\nAlso =
note that this event does not count walks triggered by TLB maintenance oper=
ations."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_SMALL",
+        "PublicDescription": "This event counts number of data translation=
 table walks caused by a miss in the L2 TLB and yielding a small page. The =
set of small pages is defined as all pages with a final size lower than 2MB=
. Translation table walks that end up taking a translation fault are not co=
unted, as the page size would be undefined in that case. If DTLB_WALK_PAGE =
event is implemented, then it is an alias for this event in this family. No=
te that partial translations that cause a translation table walk are also c=
ounted.\nAlso note that this event counts walks triggered by software prelo=
ads, but not walks triggered by hardware prefetchers, and that this event d=
oes not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_SMALL",
+        "PublicDescription": "This event counts number of instruction tran=
slation table walks caused by a miss in the L2 TLB and yielding a small pag=
e. The set of small pages is defined as all pages with a final size lower t=
han 2MB. Translation table walks that end up taking a translation fault are=
 not counted, as the page size would be undefined in that case. In this fam=
ily, this is equal to ITLB_WALK_PAGE event.\nNote that partial translations=
 that cause a translation table walk are also counted.\nAlso note that this=
 event does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_RW",
+        "PublicDescription": "This event counts number of demand data tran=
slation table walks caused by a miss in the L2 TLB and performing at least =
one memory access. Translation table walks are counted even if the translat=
ion ended up taking a translation fault for reasons different than EPD, E0P=
D and NFD.\nNote that partial translations that cause a translation table w=
alk are also counted.\nAlso note that this event does not count walks trigg=
ered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_RD",
+        "PublicDescription": "This event counts number of demand instructi=
on translation table walks caused by a miss in the L2 TLB and performing at=
 least one memory access. Translation table walks are counted even if the t=
ranslation ended up taking a translation fault for reasons different than E=
PD, E0PD and NFD.\nNote that partial translations that cause a translation =
table walk are also counted.\nAlso note that this event does not count walk=
s triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK_PRFM",
+        "PublicDescription": "This event counts number of software prefetc=
hes or preloads generated data translation table walks caused by a miss in =
the L2 TLB and performing at least one memory access. Translation table wal=
ks are counted even if the translation ended up taking a translation fault =
for reasons different than EPD, E0PD and NFD.\nNote that partial translatio=
ns that cause a translation table walk are also counted.\nAlso note that th=
is event does not count walks triggered by TLB maintenance operations."
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK_PRFM",
+        "PublicDescription": "This event counts number of software prefetc=
hes or preloads generated instruction translation table walks caused by a m=
iss in the L2 TLB and performing at least one memory access. Translation ta=
ble walks are counted even if the translation ended up taking a translation=
 fault for reasons different than EPD, E0PD and NFD.\nNote that partial tra=
nslations that cause a translation table walk are also counted.\nAlso note =
that this event does not count walks triggered by TLB maintenance operation=
s."
+    },
+    {
+        "EventCode": "0x010e",
+        "EventName": "L1D_TLB_REFILL_RD_PF",
+        "PublicDescription": "L1 Data TLB refill, Read, prefetch."
+    },
+    {
+        "EventCode": "0x010f",
+        "EventName": "L2TLB_PF_REFILL",
+        "PublicDescription": "L2 Data TLB refill, Read, prefetch.\nThis ev=
ent counts MMU refills due to internal PFStream requests."
+    },
+    {
+        "EventCode": "0x0223",
+        "EventName": "L1I_TLB_REFILL_RD",
+        "PublicDescription": "L1 Instruction TLB refills due to Demand mis=
s."
+    },
+    {
+        "EventCode": "0x0224",
+        "EventName": "L1I_TLB_REFILL_PRFM",
+        "PublicDescription": "L1 Instruction TLB refills due to Software p=
refetch miss."
+    }
+]
--=20
2.43.0

