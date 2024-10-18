Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69613A88A;
	Fri, 18 Oct 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243888; cv=fail; b=Vk3Jx5f5df/ww8cQrgSlY+F0uleUfCizyiw7FDoaLe/pC42f6cumMgyJOq+b6JFyYao6UC50N6+nM7TW+zVzz2j9Dz8kTmihgeRQ5d67/Ch7CRRG75PEEL/NZqLEN6IRNoWIwUTDDC6FxLUA7Z33NDj9ZXJAvDdCheYENVVMQ0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243888; c=relaxed/simple;
	bh=3pdbNGO/KRk1FgNtqk51yPL0n1nk1qphymTpReIkWmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FRBHCFXopYZg5lU93NrnLA2aXV0V6fCJYjFpaWN7pkfS1qVDBCPnO/zcsS2mbsmzXx/S80Qby/1NtLyQ5abHwc6Pxh5iUScG7QGlOr3w6WiQfiZkxltYr+iP2e1DUn8gb6PAjiZS41Vo61LSFtvYs2I7baLOizfdaMtXSmQ3wCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2qV9vmOC; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2qV9vmOC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wuvi8J/wx9yJ1yC1NcNCwFm985w2ywi+HMDU1SFnYPXsxLYsGjtxnJNutNqvRgLa+E2n/FF5yruG57fR5MpZRKy+yC9FDn1o7zKa+KKMaEow1H8KimUR4iHh8Ljgbykvy7JDPxazuiYvHjNKywChNuHjcl2hHswoKjnG6z1now2R8FB9vEajSstAMMCfTHQkH3gtqbHSYdycX9tfrU5HU8tMTIIkwa0qUE7IEn9g+0CtYpvmGK7MvFzh+JkfFdW5wF4J0o/rRPxzwih+K9gUStUoRqrq5hhE7JOUQjQfZU4BvD7Og8tONVw15fs+cHEgKchcZrKz/Kf/EK/GqH25/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJwiDdZkkelCSKib88vZkgGzzpcxX78gWgEMyX8aKOc=;
 b=sD2RXxFbNMmhQH96CDF+EUBD8xxmkzDgntBRdi6bZip0tsDCw92ZuedDzKjkqWsNsd3l0brieQGuQRHHqpiwWV7Id0LrUcBpi+JLXf6TwJBTsbTLVC65B9AVzktWS4uY4uS7dSFKHh0xFDk52oRbYKSpcsldlRysjzJQqegQU5E3RpOuVSPCR68xZN0KfZtVzkE9zs57tofeFsILmsejHIpIxGG2JfBVEScYne0z75WRy3X/hFQxDQD7oGh3ifXx5uDBwATNYQxTpiFEE/iXwiWY/qPYz3ZOEhrSnqOLG8vbz0Ftq9tpYzQyWGUY9OVruh9rOU9J/7wjHADqAhM6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJwiDdZkkelCSKib88vZkgGzzpcxX78gWgEMyX8aKOc=;
 b=2qV9vmOCCdqo4kKO/5lUPEbOrGBafc7h97s92gKi6h80y7UiVnTZbtbHTXHRJKyZnrkXp1ohZRwEsmF3VujKXc6HI4KQVKUbaOf8tO0pGMOVcO+I18/R1nbR8GInsCYl0Sg4zqsunpHGJouRsqmXBga3ioLpr+crqX6vWLDDHgU=
Received: from CYZPR20CA0017.namprd20.prod.outlook.com (2603:10b6:930:a2::24)
 by CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Fri, 18 Oct
 2024 09:31:24 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::20) by CYZPR20CA0017.outlook.office365.com
 (2603:10b6:930:a2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 09:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 09:31:23 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 04:31:18 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 0/3] perf vendor events amd: Add more Zen 5 events and metrics
Date: Fri, 18 Oct 2024 15:01:02 +0530
Message-ID: <cover.1729242778.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8e57f5-b917-41bb-d9da-08dcef57a202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OONDq0USCFbExLmohhSH+8f/l/G/h0YyeNtP989t1j9RQaFj7Z7EpzDKl+0B?=
 =?us-ascii?Q?cYveg/ZyVYkNw0tJx4iE9VoehozabAxzFn+BrTD0ZrSe1nYwARxG0BcN2QZn?=
 =?us-ascii?Q?99MYNDYQhOhZRvp3FPZsKI++s0XpVHfJU2Zb1ys9vhxUYvHA7y40FJTRBhzk?=
 =?us-ascii?Q?xQFAzpL9Da6tgEFX2hIgqL/W5jG6bmC2p2MZkxsNiGVCuO6F8mNMwpEQxKVq?=
 =?us-ascii?Q?dj/FMZw/jIwSEF+og6Sw/LLlmVVYENihgrMPLiOZw2WR6YaQ1xDLYHxuzKuJ?=
 =?us-ascii?Q?4aYsB/zlw+Q1kqjFw6NBeH93I2/dMS8tNZQ5f8L54a6FGJTf9Q2AGGEaNGRl?=
 =?us-ascii?Q?AL6FlCFDQjdYZL09fYZDUQSQvfY/j7yxcEr2KDJrAsOl9Hj1ajijoDA1r2RA?=
 =?us-ascii?Q?kHxVY+6/X+dQKubGtxx256we2tH5Crvdu0euIdDSpQzxHY1VgJFdHaCG/D5j?=
 =?us-ascii?Q?bfMv2Tra762cvN93tXZjuNxpXoXh/goQH8FP4373bMoSguLprAQtZP3GBvVX?=
 =?us-ascii?Q?w5pCOlH8FSGzQIC4FYd0EtzJXv+AQrYnPzaFxKtLLOpz+DQ/kzjDSmuwLk7S?=
 =?us-ascii?Q?ESRsetzd7WdikK5Ws4ERVSbZ4ftlYEEYySdoRjfa63htaD6/xi9rhHGKnBZA?=
 =?us-ascii?Q?7b2LxLXhX7Ni3hKIAwVs3p976bs3hGfXrr0yc0YwbB75WsCsRN9ppPR4Qar3?=
 =?us-ascii?Q?M88yaKQvN8OYxpLeS4wiUZ6n95wjLIxHyrpw6J2NLE3nyZtOJ0wYvks3nRHL?=
 =?us-ascii?Q?U42mmC1YfxrlqhAnKlI3ULfagiLK0qR+4/TUNS3RihpVU8k+YazbLVgpOmXt?=
 =?us-ascii?Q?7/F6zgTZzsOR/4ME5o8hYL4Dx++1qRmgzo4wyLGITKPOOc6rnJMJLTfT3/Ek?=
 =?us-ascii?Q?b5+8ymCdijCxxUJ338s1S+2fYETodgJsY8PtLrAQ5txbW14tWkZbXbLcml0l?=
 =?us-ascii?Q?dEQC4zxwsFgUulDgTVaHoUwdWoTrtckjI72KNxMzMlRWGQoK0wuKsqQbGWry?=
 =?us-ascii?Q?nKAFPUsSGffv+8f5YH/kdfTaWXA4xSqKKgObmCWizaiantpKOUft65N4Xye7?=
 =?us-ascii?Q?8gbkFo8wmlX3eCDXHs+i/cwz4oBzYtWvos54ZfUCaPIZveBvwwV5Wo01hVpf?=
 =?us-ascii?Q?UyRgpBjz8jDT1TjDTg6NVNHSVeg9RzbpOzzCtTlR3NYmVWVE07QGVbsPCByB?=
 =?us-ascii?Q?Iv+n5stxLIvPqZfbR6bNZ1q23JeBg2GFL5Bi+1X2XIHQ1U1i0ssUggsl2EIY?=
 =?us-ascii?Q?FFHxeRBwImb+xVcjUTX1Ek6f04Ay2ww2pfLOdBvrJCG0fpL4+MExAFRJ6g72?=
 =?us-ascii?Q?4Rdk4iiUaL6FYVsa3ZQdxjjJrOVLMSPgpzFySPlYK2G4wqb1S64HsayXLd8R?=
 =?us-ascii?Q?/MweZs39CcWx/rPb+Aj8rA4P9yCI+AmUu0jMbCI6qjBjacV1Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:31:23.7181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8e57f5-b917-41bb-d9da-08dcef57a202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889

Add data fabric events and metrics taken from the now released Processor
Programming Reference (PPR) for AMD Family 1Ah Model 02h Revision C1
Processors document available at the link below.
https://bugzilla.kernel.org/attachment.cgi?id=307010

While at it, also update some missing or redundant data cache metrics.

Sandipan Das (3):
  perf vendor events amd: Add Zen 5 data fabric events
  perf vendor events amd: Add Zen 5 data fabric metrics
  perf vendor events amd: Update Zen 5 data cache fill events

 .../arch/x86/amdzen5/data-fabric.json         | 1634 +++++++++++++++++
 .../arch/x86/amdzen5/load-store.json          |   78 +-
 .../arch/x86/amdzen5/recommended.json         |  112 ++
 3 files changed, 1818 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/data-fabric.json

-- 
2.43.0

