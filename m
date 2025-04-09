Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C219259C;
	Wed,  9 Apr 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185448; cv=fail; b=DLWq47ekrb7ondYtHFaNodSBhXlNwIrKsaRvWU7huLVdtlUgEi/7tLNUa0WJ4kkW3fHR3xUynSlkzpflrEWWriev8u7YwNb0oTq+RoCc8Eq9CQzoMce+k5bHRM83R7M/2D24jSBBnjLb2fi4+Uw6wsdFwLiJulRQVn3wR8IHKqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185448; c=relaxed/simple;
	bh=f7AaQQCRdQzCCGvdiWcsAIncbT/jU4TxrgaDT4b+a0g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MyDMPQUNPkkxT6PrahBrQXSo468Fu5+5DfB95v31sx/k7r9iBXtZwU7xm75GndfrOqUecAj6dnFfM5PN5LojwNatgH1qAo0kDOwOrwkKUTtmtPZ1ZV9Vs/0UyZfm7L01MbP7MitNlDVlX113JZ0GeOa6faAFOpY/D00UKmgPmLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3VQJXxAm; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3VQJXxAm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmuHmbe8AoTfuWss1jQeXvlojRms25P+QFU20d8hxdnLUzyjm41hEoXNov1ViH5xzPIZp/0N6WJXskb+oVZVYvE5oYcEdMbgylK5wgL832p5ZYtX/TfAxCMgIDd13bzaMTOzWSFre7B5SbhlKXe6zp7hdrAQHgXGEf7FBOKzp+aJZac+pKK6WOgmghxvpqELiuHwhJNGoIOVriteZfE/YFYEIEn/JHyeIZ6srgzl1g0UY2AncGDFTTGutddnt1OS1fJw9D8J1q1rkEiirLe+WOUyqnC3+LOAIY0EI6nhr9NZOttaeB6lyY28RapmtN+LUTnNRhFrKTT2LKw4nZnr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTLlNec/BG1Y5/PNSRx7D2Zurz+Hrc2mX78dM07oqUg=;
 b=D885SEG6JYeMTpbz0NLAGPnmH5bYuxUduac9OrrZEuhWrFdPxXiXGdNyR2C0nzKEdZrGQAHWMzU68JpcB66rj+LhUDHq2QLW6MUqIM8uV+IyOgC/6TkDhrD3Hf9TtXDO4XkHWtxELoYaOm7QOi24jweeNfAQNo9QQ9t6IX1EJJ9t/Nk+YiXpm+uWqhrgpzCOk4i+SqZC9BnB/A5iTUsUNIEkmZs3y/nRtBVMtLwcCYmLrigFdbqXwUEU1D//aZB5lJYgL7inaLlhHR9o60488aM4BhRHmRNJfjdNwvaf6kKToMt1yVcoEAumCLQ6bDBdgTiWg9R4LOna+U6XSo4FGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTLlNec/BG1Y5/PNSRx7D2Zurz+Hrc2mX78dM07oqUg=;
 b=3VQJXxAmA07QS6yjUJKm9MBI2gnwIOyqUiyNPVTheKA+KaYtPAM9Pqd3ixosNnp+vymbVhF3d54XULoSLOBQ9xqgT41tF4JH7oKiCIWMIIoxrIB2p0yHYYIafhTPPiTtrOpbp/fvgZMDhL27XIGE8oFwXXy3GxNJtLT6B7iwZ/g=
Received: from BYAPR08CA0028.namprd08.prod.outlook.com (2603:10b6:a03:100::41)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 07:57:24 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::da) by BYAPR08CA0028.outlook.office365.com
 (2603:10b6:a03:100::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Wed,
 9 Apr 2025 07:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 07:57:23 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 02:57:17 -0500
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
Subject: [PATCH 0/4] perf/x86/amd/uncore: Overflow handling enhancements
Date: Wed, 9 Apr 2025 13:27:05 +0530
Message-ID: <cover.1744184837.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e7e176-40c4-4864-9eb1-08dd773c29c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?69qo4gPmgMeVFvfStzImlKU0RHcTI3OQsV8ikJhrit48uKNDZV8dE6fxelqi?=
 =?us-ascii?Q?j90podtTVyVVRqBPuw+RdWiv/MdIEKqSq0NyF+33KN2zuvEGpI80A4vog78Y?=
 =?us-ascii?Q?Ao2Ncu8fdrH4/KmT9y7TY+A0tV/NxXRM8RateYxU0KDaZbGUxlsZWh79zm0M?=
 =?us-ascii?Q?vmQxw3LyB7RmZmwg3FC1eOg0IAsU4S8ibtWOknbWJd1ekCLNhU0JgYKd1cac?=
 =?us-ascii?Q?A90c5d6epF7qZWvf1V8EQu/5B901JJF5T6tHkqUV0SZEW9EgWxzKLDt7mvnj?=
 =?us-ascii?Q?TKkVmL15NZbZXOIrxunNgei+YcE00LgThGk/dIakFOLNQre8dEAvU0zdcyAO?=
 =?us-ascii?Q?bdEjh/i3x4VAyWeRvW/PfaY5A6qlJDc/7Wx415b/D1AboQ+7nJxph3ltGB5P?=
 =?us-ascii?Q?OW+wn8vjWhiFv8WFx1JNSgJNC8aHuIWllWrbTQ8AYZkgganmuk1LVwwowius?=
 =?us-ascii?Q?+L+0Dble7DvYZwRNNwbfJl1v7o5sFpLMh7F1jVkPQ3w2F0h8aEXj1mExIOoM?=
 =?us-ascii?Q?fZF+Ye5lAb8dCbYUtjtO98XQLZIRlcsqzid7O8Sw9LWR1ViiGpt9oU6zbhL7?=
 =?us-ascii?Q?nMH6MFW50XnAXSf0lEUHP3EgdnVYrSWv3MXECm9BJ21z0mag12TO1egbciW2?=
 =?us-ascii?Q?hUGrwFidqh8P1kklmPHBl7C4S8D5/7Y9pSJ4Xv3S5/p6s1kL9IWrYq49YYip?=
 =?us-ascii?Q?aF3o0A5jhWRvxys90Gh02quqVM9YBhTTr3+Z9cXW6FgmLuMnI/9ryiTJOULP?=
 =?us-ascii?Q?9pBNJNbxzjyUJcDLUDzMuw9wFklS13VnnMa7ohvy+1Ude3AHoIdazRt6o+YP?=
 =?us-ascii?Q?gs1l83EKxBYeCaUbZ1N0IOP1STwG9ulSg3hRedDp2eG2RfvPDYGPtx3e9Aoq?=
 =?us-ascii?Q?J3FOoML8n/x7Gz1Eqm+vrzzbrlmGaKJPZv6N8W3tE2QQDqzzdgsidk1PtdJl?=
 =?us-ascii?Q?gBGTXlo97ISLHpimvVcFqecZoXzjrGHPWP+OXOXfvYBwPzplV1NZXBUfLcOn?=
 =?us-ascii?Q?uO+TOk92QdNFzbpG76reuokf0+fbzqFSQQGC/4yiya50QPCJECY76mBjxRJ0?=
 =?us-ascii?Q?u09v9Dj7ADNjKP71IPumD5FgmZuazCuv6WKthKwFQLKn8EAEKL9zZwFi/oKG?=
 =?us-ascii?Q?vhZNf0M9scj+SnS5qhOADFL9QWokXSbxFM9y80CwPk5HaAFusJZbsbdPyvvR?=
 =?us-ascii?Q?H8sH0XHCtmU+FrA9b8TrSDHFUgqZ4OY8B/hNXM1iC4coyczXB27PsYSc1J/I?=
 =?us-ascii?Q?u15H/b0fK9I2OkPDa5GLikpPP7BWMkgsq1GfILNJLOzk1+o51qszk6uC/0y4?=
 =?us-ascii?Q?EFdjTJGfx9nqtFC+fwlnACzmUfNwWJKRpHyLTVCyWvhpcLNL/qRO0CBzavMN?=
 =?us-ascii?Q?Cm5ycnQCIaqjVnycHMHdwAwz+0d3RhMps3uO3Dryl0px18x8BZ12gjy859UG?=
 =?us-ascii?Q?SIbOi5SI7+479gSY5vFGADD4SfQ8j2GfYUCw0JDMZi+HNXUl+xsBiLUInpPJ?=
 =?us-ascii?Q?otdH4jdfDeihHkRuitcRSmdoj7lgMMbrNK1C?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:57:23.7697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e7e176-40c4-4864-9eb1-08dd773c29c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

Uncore counters on AMD processors either roll over or saturate on
overflow and the amd-uncore driver has no way of knowing if multiple
overflows have occurred between two successive pmu->read() requests for
an event. This makes the user-visible counter values inaccurate. Solve
this by periodically initiating pmu->read() in order to keep prev_count
up-to-date. The approach follows Intel's precedent in handling uncore
counters.

Sandipan Das (4):
  perf/x86/amd/uncore: Remove unused member from amd_uncore_ctx
  perf/x86/amd/uncore: Use hrtimer for handling overflows
  perf/x86/amd/uncore: Add parameter to configure hrtimer
  perf/x86/amd/uncore: Prevent UMC counters from saturating

 arch/x86/events/amd/uncore.c | 109 ++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

-- 
2.43.0

