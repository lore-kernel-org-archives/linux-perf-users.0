Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013028.outbound.protection.outlook.com [40.93.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA31885A5;
	Mon, 16 Feb 2026 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215953; cv=fail; b=GPlfGVorJfF1SAFIMb/1WwSZqxbS9KLEY/PIVlznPF76SxqFyWx72Wji7GeyJqGHYM0SKV2R4Q9H/8yeHtTUwkqnEqm5QWZy4AO8PlzPWr9SvHD6Fl1W+tza9QXgJttH1ETqrI39YtohX8++DHDvb9/JZw+BIj2exbSkji68EBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215953; c=relaxed/simple;
	bh=JnG7Ff57v3xQ/bPHZDN0ibW8Tz6CtalcoeuC9pPFHK8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nv+y15TzUn3GTqg7R7gzvEGYp3TPNI1C3mI865UppoNXMesYTkn0p5kAa+SmnQXzboVOJ00FVtYvolvPVpWtFbu61B0Z40tKJ+lbM12HXEyl7Sx4b/pwkaQlpRqZIB8HQfNYSgazPo0k255EttLiux7jKqo1UgtW0xxS5QlAgGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4GsSmeDu; arc=fail smtp.client-ip=40.93.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4GsSmeDu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEM0NktcfA3Yz/U9aEktMjF/HPHDAbRNCYImHp7yZAr62PxuG3XKkmiDcw1+KIdWnMlNt9AIqOcfDeuSSwJiO/Rtgsa6SKSiSyk0YXKfzQxTl23W1LSBINWaEGq6cWIYb5nORO2UV9aBjiF+i4DHaa7BKIcGBstJbY1xPwqcxmJGkQYZrufYJGiEupQnfXVGl+dD6MEH6AvJ2nFREXuTKJ7GJfVynLViqbpqqf2/tS3BkT4ATcSTtm6As/QdTRraJhHaQIAPJrs9XMa3py1EC9iQIzwt4Kj24/IIzA3LZBV1i9uOpE/flJ4dv3viiCwlljrhXfah6FOwMlTl4LEnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1UfNW+Q3MSWx1a5EELvj4I0J+V7p0Mc/NuCOgYznlw=;
 b=XnzN9CW/ADcJnwNy47OS8gO7FYI/wG2AnqJIKOJPUfNHsmwRYma4Vn5KL6+214mGazefYGsjkgMQ0vO6v6fmCMfarVtfer9P/52PqYBCIMz1+dyfJyd5yS+ZOmRFmOIr3WOapV1w0kZDhLs59fk3jtgpJ+WtRdDBl51iiw2XaAElfzGMfhI/F3sAa1vaSPihu92a4Au2wyPCVd6shdnyXiv/OaLYVfynSgcBNwZfweCpogGaQ+01jGPhBZoPCAh2zIOuEzsrDVvHY6PxDEDNew8ELcyYfVXLW561TqPQPfljzS8cmBZeyCgVvqqM7/pdrYkNo2xHT89IP6F5mxBHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1UfNW+Q3MSWx1a5EELvj4I0J+V7p0Mc/NuCOgYznlw=;
 b=4GsSmeDuTLoYclVtp9m+qW2EkKdwlDU4uc+Kkxjk0hae3isywObR4IiJwTzUY17qmsqMvtiCZetembgYfdzFJZbHJD9PqAnKDcLNVgB+4hvNfpQWlC0F3qS3wNHK2A3jMO4t3bsVNvtSszOhVReJNtHVezyj2F8wfGygkz8JyzA=
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by SN7PR12MB8027.namprd12.prod.outlook.com (2603:10b6:806:32a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:25:48 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::ad) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:25:48 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:25:43 -0600
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
Subject: [PATCH v2 0/7] perf/amd/ibs: Future enhancements
Date: Mon, 16 Feb 2026 04:25:23 +0000
Message-ID: <20260216042530.1546-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SN7PR12MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 604d4838-661f-415e-4b64-08de6d137600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d0OP/2oh4wU/wKteVK9FJR505tmHdq0gzCjnuhCXBy89+tn/XzYgEZOIy1ad?=
 =?us-ascii?Q?9vxUHDUZBjMCCk+gEup69UXiuKxysK+VKqx2+JtoN+vOwmeqowAosjmLPltW?=
 =?us-ascii?Q?lcwSY438pQjBqMiR2Mgux/13F/ePo3pglvfsDPar5v7HnQUbYisiUzurf/7z?=
 =?us-ascii?Q?sevW9eseSkRTGSLRKPIClzJHPf7eW/zO4wxorMy1+FupKZLWM/yj/DlLTPmt?=
 =?us-ascii?Q?UTelxgftaxKTF1IAVrtWVTaPm76cO1ODizvQcAB8jjmoS9/4eZ9RjTbIpUNl?=
 =?us-ascii?Q?jvNVeLEhQvR7UTyPnsyP3jG6qaOZyjxXy+kjvwm7QU/xgMBA4JVl0jTz84ET?=
 =?us-ascii?Q?5h+bpD8uZ7EMsFPwfelM8RQZsbpGq+kb6p3K12py0FXAd2F5JU2vK+lJYpTY?=
 =?us-ascii?Q?a+JhtoHiFFCmeaJDHrluIkv0xtNfbO1r1N6aUyTRJLFNtOjl2EGVqa1PYthN?=
 =?us-ascii?Q?uMg6s6dz1S3DvmXBX4gCt8l/yBGjc19JPFFGGyN8uybsAAhD8hx3LxYvb13N?=
 =?us-ascii?Q?exrwS3wgF9PU1sydmcKMas5dHRTWgHz3dFi87jq3KATOKAR70ftRIK4OQ4DN?=
 =?us-ascii?Q?YqVvz2Pg/avTPyDMYLSEkg0xU0U0eOGL4W3G9RjSUTDVlpr7805DXu/fNTqy?=
 =?us-ascii?Q?GyJTpYL0tkFyT1j1pI9UfK8NShVeYKS5IeKRs2zARmjMwicN5mFDe9LIw14H?=
 =?us-ascii?Q?TbYoIw54ewfn3N20O+YlC4Ko+MoXvX0BCgb9J/kenzXV5+agWoCNNsfoeQRL?=
 =?us-ascii?Q?cn3mIe/q8XIWe4dlKdYvuRnPFligSkNkYVIP9/jvZQtbuN6vWjRxbi8XbNeI?=
 =?us-ascii?Q?eyUNrv38h1lrCeK7NSCu1PqPahAJHcLYxY7V+KjQIkDD20Sr2QB3Yooa9IPQ?=
 =?us-ascii?Q?RX3C3DV3DgzYZ4jizvoCdfuDz9nS/lBz8FTnc6176VpmVZWQ2Tx89dcqLY5v?=
 =?us-ascii?Q?tcRWlK8SJzFe38DX31DufXUDbuygahj2UuiLGLJlHECxQurm8i/4tj6c/ZoS?=
 =?us-ascii?Q?WT1JNEaloRMa36VsYIX4JfaZjqF2PAGdfnATpA9ZA1xq+yR6HBRni0hQ0xRi?=
 =?us-ascii?Q?TD+VjMQt1OpiNTV+Pnni33ypCTdiM2vf/nwSgx1IcAdHsogNraBvYpiwt6Xz?=
 =?us-ascii?Q?2rmhrQ2bA3tRkgHix9fUb4rqertMuoY8oN1kEPxxwWDBhkuZ+ctoQ/lZVw4K?=
 =?us-ascii?Q?oDtIXhl/yML8ldsMje5D8Uir5cGVLybpjr8Qy5wE5WnDlMrhJMS32BoR9o/5?=
 =?us-ascii?Q?V9Qak9tY6YQoJsvIKSkvxtgccwZP1a4GO0KCWY43LiN2Nhl2oMTIuaN3s8oe?=
 =?us-ascii?Q?AclM7NW4E3SN2s1ppFta1MsTCmEtUBZhPWhIo253tPgiY9ZOKI1hTmFwI0vA?=
 =?us-ascii?Q?a6OReT629QqkZkrZy/6Ys811TJbxDcujosmolA3b6xuJK7ylS1z9bZBlUIop?=
 =?us-ascii?Q?yVbmsAhhUcfhh5k6LmlbdLxjhsh3lcwO+hWOAHPiP+oghmbcvnWd2m4AJtlI?=
 =?us-ascii?Q?1Xv6kebUBnFcD0EEVy5i7NxiTVCrGQe+uXJR8e/lj3LIFMKCvTvtWz2Sp0Nc?=
 =?us-ascii?Q?EURWytjGCy04l98NEIVK0mWXar0N7KaOKuFUq0nB8dILLGjBsPA0I+a11rCK?=
 =?us-ascii?Q?MjrHfo8qzRKsIYMnIm0VtkddGO7DvRvEyzQ9MjKsZByb40TsJvB8l7uKmaBf?=
 =?us-ascii?Q?Z6eXhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5mZ/lXvhkN7D+JuNblQtZbcpAbjZ0dZ8RdkUqwJbScph4lTbFY68keViO7AqJNiOB+fIbVgOvSxUWZR9Eja0vWXIuiZuhcUM0uBYwX5i6f4eVDpIpdn+hw+8Gilfty0PS2kDFzLKgKBu+g6vQby8qoye97tCKj4u+oS2iZZ7ApXO/Aqs5sXcv7D/16ArhcjL+VtU8O+ubJlHLwKioD5ZfvzdIf8DAjhlb7Wm/NXhs6bKILAtLO3Ac41Km7mIYeuQH00twG77yaW/W5JbLYn9Qghv4xI1uFR96HIp29UOHD7+sigfJLtZgsQAuhwQMnHHnepy21JJNC2NLMGhrGbWSSlDIJ96p4rz/ugDW4k8zJfZZiuH+M7QJXx7KThZHmnu9Lqn/Fxsc0YW66cOh/9TfsOr1E/5bz6A0T3+YJwGtlLPkrUDWabFn7KSglvAMPob
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:25:48.4125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 604d4838-661f-415e-4b64-08de6d137600
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8027

Add support for new capabilities that will appear in future AMD
CPUs:
  - Alternate disable bit with control only MSRs to eliminate the
    RMW race in existing IBS_{FETCH|OP}_CTL MSRs
  - RIP bit 63 filtering, which can be used as hardware assisted
    privilege filtering, enabling IBS for unprivileged users without
    software based privilege filtering
  - Fetch latency threshold filter to capture only high-latency fetch
    events
  - Streaming-store filter to sample only instructions that perform
    streaming stores
  - Remote socket indicator for load/store instructions

Patches are prepared on tip/perf/core (7db06e329af3) + IBS fixes series

IBS fixes series:
  https://lore.kernel.org/r/20260216042216.1440-1-ravi.bangoria@amd.com

Perf tools patches:
  https://lore.kernel.org/r/20260119024328.897-1-ravi.bangoria@amd.com

v1: https://lore.kernel.org/r/20260116033450.965-1-ravi.bangoria@amd.com
v1->v2:
  - Split fixes series from future enhancements
  - Replace magic numbers with macros

Ravi Bangoria (7):
  perf/amd/ibs: Define macro for ldlat mask and shift
  perf/amd/ibs: Add new MSRs and CPUID bits definitions
  perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to eliminate RMW race
  perf/amd/ibs: Enable fetch latency filtering
  perf/amd/ibs: Enable RIP bit63 hardware filtering
  perf/amd/ibs: Enable streaming store filter
  perf/amd/ibs: Advertise remote socket capability

 arch/x86/events/amd/ibs.c         | 238 ++++++++++++++++++++++++++++--
 arch/x86/include/asm/amd/ibs.h    |   4 +-
 arch/x86/include/asm/msr-index.h  |   2 +
 arch/x86/include/asm/perf_event.h |  55 ++++---
 4 files changed, 266 insertions(+), 33 deletions(-)

-- 
2.43.0

