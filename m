Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD223AD;
	Fri, 18 Apr 2025 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947803; cv=fail; b=uhZBUiUJ8Ne1b+XbA3diQBe3km0rEyqMrNqv4a2gdAejT/cJ6C0QhBFMDdLy+m2ZmZZX1TyrqWYFI5BZB7YXemsDncmNynzS3l1oJCBzhNOlIlqYhfYTqhxujN/Y/bp7BQn+goCDQgsEwXJ14uc+oRhW87ssOYAcFGV9IQKWpfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947803; c=relaxed/simple;
	bh=TSjcUkkmWipSkTMw4DbEU1MPlneFhu0JGgcrEl0hzgg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B0CdDksoUtVIJgs4SIVAALDTJ/QkFNGtFp7e3q0e8o8Qbphe2E0otA4giLcKHOhKEpLgvHZTOenjP2RkDIXcGjRAqXOfOII+wDQj4B5Pln5qZa+OAHqwpG2uW9YJ6YyGrj5jSpLGhigNt3eYfMMwLfbsFzXwGGcMfiZ3iACNx1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IhZOXIFn; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IhZOXIFn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kF0C1HWIzP2cl+0K5JVKJpj8jT5olNadpH/IKiOruxwKpNURAz8duko2QjayztOHjNW6tINDViL7sf6WYyb4aaMTD/oMbhi9cdUERtG+IpLharoAPEd+z39cq94/3jASQWo7P8LnxtAxfvRLhSYZO4P1UoARc0z582knu5ZSLKVtR3tq76uk8cUNYbvF09/GJmiEwqC6+hPnHvDkbCNuLx2cxg0aPX4L/lyRiyrxQhdfvEYrgZYId7sePJsjGMltSjW7ZkUXh7uJDMS9RC/ou/jl9dmUBbraknRnjQ4gySR0jo+7zZEP0uG/hYnIcYRUAV50/QfY0IapH8e2mwV9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/Kp2BBDqF7098HF8cIhwknt7ubptYtPQV3/PbqqUhM=;
 b=noLwS3bdeBo3/5r7jOUb+iZeTKloUnV/5wD9QXn/o7A5T8fL5h97SbOAYVfc1zzaLAUTQf99ZhxdQk86/Fn0juN28N8UdvBSdrtEv14C9aX++/sRzv0C4YPYj6Ayf4NnlOTSuCIjGPXn+0AMwZxKdoBeFoFai4w3OA/5NZ25XwZGZX0Pk85nTo2HjIiircHdvPW0elyHCAFND1mZHh96W7Ag4XAHiOlq5YyeYyfzmRM++wONwoI/MfTs7e3UQ3VLsBFFg9/D0/Spp1P2NAPin/WH4lbhZi0ACMOJuWzCxhwA5gATfGXGvoRZkGVpm0PyEeWknSsBXSY8hKfZoG1Hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/Kp2BBDqF7098HF8cIhwknt7ubptYtPQV3/PbqqUhM=;
 b=IhZOXIFnk1PKif6gFfhmB+KfX0tSHS5/d0xEDeFRvgJDouvZ6MvvEUYeGm4zJ1tiQhBXDRhe0k0SQW1xF9wMzv5fyV7/eXmQ2POPobuyroyZfO+oZxM3u/hpLk8Yg3P2oXiSz1XDV1ujhAGNES+hmPrFmhRnx853LoKJbp8wba4=
Received: from PH8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:510:2cd::9)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Fri, 18 Apr
 2025 03:43:18 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::9d) by PH8PR07CA0002.outlook.office365.com
 (2603:10b6:510:2cd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Fri,
 18 Apr 2025 03:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 03:43:17 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 22:43:11 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <eranian@google.com>,
	<songliubraving@meta.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH v2 0/5] perf/x86/uncore: Overflow handling enhancements
Date: Fri, 18 Apr 2025 09:12:58 +0530
Message-ID: <cover.1744906694.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bc38cf-a444-435a-f03c-08dd7e2b2844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rMg+RQbNpxwi6BQJfNd7ylllrXGdvkcVPppbvhFOUDpWsZvJ5fQ+Czu6j639?=
 =?us-ascii?Q?uSUrG05beNQY9pqNlYMWh+yHYE4c90d4aFKoX2uspQRmxAZwU25e0PJVwd8i?=
 =?us-ascii?Q?SPCA3F9lUVnj/WtkJFNrDnuP23y9KB73iB89XTUOF7OEtLhNJT1tMa+hxubm?=
 =?us-ascii?Q?+NmuedWIHgwVr76jztXSc3M/tylpz2zqvgw1XZXnmE/w14Cnvk2zGoZarnQg?=
 =?us-ascii?Q?6T+fNPSCgdhWb0JyLeV822Mujj/MjupRXNr7X+EPxY6uEZRIU5FnL1d5NhW3?=
 =?us-ascii?Q?BZNxsFCv1NFmHRuuXT8ZlCMLOpBlUv3nQqlejmpjOG9RHsSAEwdh0R60prnB?=
 =?us-ascii?Q?Ou6Rt45wA9uhif8IU4hXFBbUIhYMNpX92kkkE4dhFPZ2OSD8W6QSBffBIGzQ?=
 =?us-ascii?Q?htQLH1hWNC0ZIO1io/AuYeD/dEG2RLIsrO+TCy5miTvi1pTJnP4Ab6X08jRq?=
 =?us-ascii?Q?lLNS+/J3diQqWktZAwMvtGyHRV315ubcS/We37aPRLVbRk62HMecr555KUj2?=
 =?us-ascii?Q?q+7jlT0MpbaNDzW4GnGb3NOGnT7v5SaZcx1jA5ky8Rr/jieaAC9f30rS0PmO?=
 =?us-ascii?Q?u2eyZYCtQoGpuUuYxHNPE/+ATUvFYKCmphe4K8JefQiLuZlWMa0RSyBiRBru?=
 =?us-ascii?Q?XlX5GvUjI0Tc/haU+hNIbGrUdMSFKRzx9QVOVkWUzOhijzdP2g7rl8ZRbFty?=
 =?us-ascii?Q?04BubWj3VyNQz4Bw2592f1Z7/b59o8h1BjH76B/XRc+k1EGWEytxO8AZiuRu?=
 =?us-ascii?Q?5BJ3nXvNvGt9pgqI5m01Adgi5wH9pOY0oUaMeOon2PwWDiz6JkYLpHUfWT79?=
 =?us-ascii?Q?vCn2Jh/ngvH0Qv67+PFmFeX0A9h6YxVvZ4+sF+8nmnKwLOve1cl3hbmzNmQl?=
 =?us-ascii?Q?uuSdlEBLbOfD9szgzAgKc9yEZsX77yWFuudpMfMDBG/pBKp/3JIg5szcu18B?=
 =?us-ascii?Q?dL8m1GjNLmH1iPV3MOXP9n6AAbQ/0eehfyFJZu9fKF+zVuJl47eZRXJPLacQ?=
 =?us-ascii?Q?hM+Kkbtq3xFJ1dGXyOlUXRWCkveNnTm0PLKUTpkHXxfwXQkTK6XtAWAxl9yo?=
 =?us-ascii?Q?WBhBBEup1E7qw4bBK88Giimjso7xYVCn4EhP5XR1qV3QNY3s38C2hJonRczt?=
 =?us-ascii?Q?DknsvhYLYGMIo2NiN7yqP6H5iEoCVhBSSsNH0lmBabJj/9G1FgqZQk6Dd5ZU?=
 =?us-ascii?Q?rE9qg12O80hyG/zciCbWB2arwOCSGAegQwDX5w7iGiT6E1NlLfOy/ljAzZRf?=
 =?us-ascii?Q?busBcy1r1sYN8gPiUe60G6iVkeECiDc8tyDP6iQDMDW9ROSONbrqxYFwcY66?=
 =?us-ascii?Q?5DwflvwXWj/k0Bq9OEDm343Tcty4SHhBt3SFuBIoWlqRjdwQN4oIaRfNgE1w?=
 =?us-ascii?Q?8gMPfdeEiPQVgD3y2NXMFs+VV0CyB9QJxJWr8H4jnrq/O0LmFeDjN4LRh7/W?=
 =?us-ascii?Q?bUOc+Cg63nYcZS7fwkEvGYbfa/cBP2jAwtIfDGnrDZVvAa1anYAsCw+IKsaN?=
 =?us-ascii?Q?hSZspgcKXYvjI+j7PPvBYwnXSget3X5/DZq8Fvn4B2QyvBRPwfeUEUqD4w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 03:43:17.9216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bc38cf-a444-435a-f03c-08dd7e2b2844
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780

Uncore counters on AMD processors either roll over or saturate on
overflow and the amd-uncore driver has no way of knowing if multiple
overflows have occurred between two successive pmu->read() requests for
an event. This makes the user-visible counter values inaccurate. Solve
this by periodically initiating pmu->read() in order to keep prev_count
up-to-date. The approach follows Intel's precedent in handling uncore
counters.

Previous versions can be found at:
v1: https://lore.kernel.org/all/cover.1744184837.git.sandipan.das@amd.com/

Changes in v2:
 - Add a Fixes tag for the first patch.
 - Change the hrtimer mode for both the Intel and the AMD uncore drivers
   based on Peter's suggestion.
 - Fix an issue in the UMC workaround where prev_count is not zeroed out
   after a counter is reset.

Sandipan Das (5):
  perf/x86/amd/uncore: Remove unused member from amd_uncore_ctx
  perf/x86/intel/uncore: Use HRTIMER_MODE_HARD for detecting overflows
  perf/x86/amd/uncore: Use hrtimer for handling overflows
  perf/x86/amd/uncore: Add parameter to configure hrtimer
  perf/x86/amd/uncore: Prevent UMC counters from saturating

 arch/x86/events/amd/uncore.c   | 103 ++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/uncore.c |  12 +---
 2 files changed, 103 insertions(+), 12 deletions(-)

-- 
2.43.0

