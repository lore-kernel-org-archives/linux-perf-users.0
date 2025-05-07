Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE6820330;
	Wed,  7 May 2025 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628134; cv=fail; b=k1NoGlVfjEnCBvUB/kiuSPfaSXFqOVVDNaPlN69eb5B0dMAG0wlgr2P0mRwrpUcTendRTsaobitfWPgdfoK7pXX45vT46NFmZ0bv6x+fx6P3dyjZqobAtj8F6QCQ0v/OUHjWgXphbJyVyGoaH7m7SDUe5UGIThgJrxaksOHwI/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628134; c=relaxed/simple;
	bh=0zRa6nn0Ol2Nazm6cYsN2zRs6GSOOnO8x6wZtll4Ank=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Us1Gi/sP0Ob1WxGgULuDO1xSZGtHJWB54yPCs83kWbAFaypx8r9/TR0wJPnSI60LLvj0YS/q7/WueqBwekj7mQ4ITcUxFFUdUuYuTlnd20Xu/LYefWZdYmfC5Lu8Adn15RcUeNMQ19wQkTmCA07q6NHsYXM/YIFOyKs9pQ/ufEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x8A7vyxo; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x8A7vyxo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gr5gfg1BCcU/+rHpE4smUeEYF0pTW5J3ZF/qGe4oLoKDK4Qu2Cdfff1xlZ3pw10GLVKGl+Z4C+JNg4tKK2FxMKjlTh40t0e3kwPV4d385UOAy5qmo8r4RkvDk/YsfCglJD92U5kSv/Z9QLA7FloRELsQEPxDzgNxWA7wn+k8o2fIq0tIHsD7HR+ogoqkldjuC+bUoBivFdXFkMHTGHp/cjV/MYDt7xVXbMuKCOaRtuu8Dsj3NXMDSvzFbWSujrcSV8OqIGkCGcc0scEZxP7umCjQ+jPxDBuHeV9wWaU04nqQwp3pi1gpGjxKUf/I8pu2+lLQR0MOkjsI0geV706tAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrDAFZwVxoelKn/8dY7qo+RpR7u+s5OV5I7Vy0rESkA=;
 b=KvMo4CCVTV0P5VWSW95VUhM+6fT1Xjz2efF8Jr+LUYwnvIRfz2qGGm5vns+YXKho6lns2yVHIiqNhkTC5Aq9sNMTXz0SFHfC5E635lwS7kodnXOtJHOI0lF82fVs8HEG1c7fKsv1Ke0G25z9YrM/SvRZ2db5baSbNtLOT9oxieF7bYgYPCvW484l7aB//wd4w2qhphn9P9eI4yEQMvNNFQ90xvRhMCh5g/gZTvrGZ/WSMlRh4LC9jFPvbnTLDIgdxHk97GJH+qLTTFsWVxc89gIQReZOTQB65pJVX9bAkfdcKt9qE7DF46XluIrCF0A1mMkKvcCLqsjICKLbTuQHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrDAFZwVxoelKn/8dY7qo+RpR7u+s5OV5I7Vy0rESkA=;
 b=x8A7vyxoPnASJxpvsUN4OgcDPFeY42XmtuLOdwUt+PSFiX/hXTsxdYWFz3E38npi7atnJUZ+vxjxqYK58nKa0AavSeK2/dQXMcF/OUJoJrUDqLqNNeYpL1tZnnZYFUx8pOTLAUKI2aODsvkJikfSfXeBhZ4sRkV8+pv/yHs1lNg=
Received: from BL1PR13CA0331.namprd13.prod.outlook.com (2603:10b6:208:2c6::6)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 14:28:42 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::68) by BL1PR13CA0331.outlook.office365.com
 (2603:10b6:208:2c6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 7 May 2025 14:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 14:28:42 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 09:28:37 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, Stephane Eranian
	<eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 0/3] perf vendor events amd: Address event errata
Date: Wed, 7 May 2025 19:58:26 +0530
Message-ID: <cover.1746627307.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ccdd70-2cae-436d-3268-08dd8d737790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1Ggxikd5anZA7hz+OjpN41cOEbS2vmwrXoHQgonNfyXbMOHnYaluNE9piH8?=
 =?us-ascii?Q?6M+Z5KHPRenReg6Ts3Znd0jm4owEgv8n/KIBtMhtS3y9IDnz6q2bGqtoQfgf?=
 =?us-ascii?Q?j2RdZgLGfGm/MHQcI3hScPIkxq7i5fWhqY9Fgcnau4QESf9sdRQcICauargb?=
 =?us-ascii?Q?aebj80JFijkBEEE/CRdQcGk9oawsyA/+V+lxx27Fu3vvY2R/58Z+aiQPYqja?=
 =?us-ascii?Q?ACLZINB+4l+oQpW4rF7kF5E7vd9kAxwiT3PgkbJHQW7x7X3A2C1+N2PeLRRq?=
 =?us-ascii?Q?HHj3VnO2QEjG8wFg3ux2IDE/ZmsjNcz1sWUb+Vs6dEit3Ywq6Q140gCcACvt?=
 =?us-ascii?Q?47G/nihnY7BOk8tkB6OIgO2owKIGJvDe3J3JRv9akEXxfEypSogPRSXxtBBU?=
 =?us-ascii?Q?iwjI5P/i0vYjZzowwZB/9KZ7mH08zcChCtDwcqsKZtxEmVI1yUmcqJyuh9M4?=
 =?us-ascii?Q?wvyz2YapVifx2yUxSCmRZfRuZqWnQZKKI/40vRCSbiv1N6PaL1Y88UgKFBkE?=
 =?us-ascii?Q?cfWkokShTkmOjMFynmBaRtczNulg6fu8NQs1q2Uktz1xdsyAkFwXXeKe8BE3?=
 =?us-ascii?Q?Zib1rwHVzFJmIvuL3Y4l5hN+SmM0RAg7fhNHeLKye/8On4iu90FuxEXHWoK/?=
 =?us-ascii?Q?dh5W40qiR1v+Tm/CWaRx8p6GjcQU/Sx+ePo1r4KlEUzoE1KI0iHUwlKfc0Cg?=
 =?us-ascii?Q?jHEfe54mzgeCN5boKXgCEdr/ntp/f0Zgm0weYdAdy0/NGgdTJ1J6ZD7R4lHm?=
 =?us-ascii?Q?8fkMzKNzNVUI4rZoGMpGvXJPP7Ew1OkGYaCt9r+cFm97h01qOroK7faqqABf?=
 =?us-ascii?Q?6qoZAdXjE0iPDeDQTe+3b4Qm54c9WMT2FkilcakE3X1Mn7hNgdKgGys+RaAY?=
 =?us-ascii?Q?67ofavaDBb7LpFtUK74kuR6c1oCW8Szxwg85kanS71LGkGrEI7ESSeObXnHy?=
 =?us-ascii?Q?iPsn/kEbZBerFLoe/3tLowGSfFtvDdKrWobSsPyOQOid/EAExBJgjqXkwhd5?=
 =?us-ascii?Q?ZGB8maZbFDl0Zv9P84985dvQIvprFYa1/NTHlm3r9TUdTBf6QlNmQSvMmpQi?=
 =?us-ascii?Q?5Cy8A5s5uDcZpCMy7WOpgRmc9C3TuiZmvpqe1I5kmRDjAjNyTGq5mlbYeVXC?=
 =?us-ascii?Q?uj1MDDaWIIVFi1nhtAsJNWDG+8miZ/PD5PTNX9AhcEUj586lr3pIRbrkKxwA?=
 =?us-ascii?Q?pLUjosZOondevpQmhNgIrqUlvBwAWX3c62v3lDJoJDYdt/sRAzldtjhUp44c?=
 =?us-ascii?Q?OLEW8gm5scKHleJERDetSOqLLlcaPU5HFhtZRWGlEfw/RyR9UMXX3rTn7o+/?=
 =?us-ascii?Q?R365b3T6w5Jvyozqs+VXNOGfsU6TyfEnkOJjW8LXh65FOsl4qkCFh5412Ebp?=
 =?us-ascii?Q?g55apwY6DPuNUAOBONVuzHwOukX/oHKfUiI9J2+xnTwUWSyRpEbsrvRMIPFc?=
 =?us-ascii?Q?2vapswF9jNFCGhQgV4WpWiFrEMyh0O7/B6yXGLZE+p3Xqmm+fu7sA0pKsN4R?=
 =?us-ascii?Q?XEmXHu1P6iXl5JL5rf83FuSSqLRWEGrwrepQDbx+OpubHK9IjEzXByYDkg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 14:28:42.2723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ccdd70-2cae-436d-3268-08dd8d737790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

Remove unreliable Zen 5 events and metrics. The following errata from
the Revision Guide for AMD Family 1Ah Models 00h-0Fh Processors have
been addressed.
#1569 PMCx078 Counts Incorrectly in Unpredictable Ways
#1583 PMCx18E May Overcount Instruction Cache Accesses
#1587 PMCx188 May Undercount IBS (Instruction Based Sampling) Fetch Events

The document can be downloaded from
https://bugzilla.kernel.org/attachment.cgi?id=308095

Sandipan Das (3):
  perf vendor events amd: Remove Zen 5 instruction cache events
  perf vendor events amd: Remove Zen 5 TLB flush event
  perf vendor events amd: Remove Zen 5 IBS fetch event

 .../arch/x86/amdzen5/inst-cache.json          | 24 -------------------
 .../arch/x86/amdzen5/load-store.json          |  6 -----
 .../arch/x86/amdzen5/recommended.json         | 13 ----------
 3 files changed, 43 deletions(-)

-- 
2.43.0

