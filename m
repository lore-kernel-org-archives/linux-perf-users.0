Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223B4DAF8A;
	Thu, 15 Oct 2026 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792064867; cv=fail; b=JQv5j1rBgLgyPlo4fZRmqfumDHrKgoMkHQjVgqu6kxLRzmUI+3MB0L3zK45T/2hoDf+vwRWwoYL3L1mMyknPPwtuuORh5xcEqa5+D4D8TF1sP5J6sIsT9rycY47vlBv4W9UvU6GoRr8BVZiVq8kD/b4j5cRTlHGysDfvr8kpS3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792064867; c=relaxed/simple;
	bh=LEXIuGklrG5maNhDjLYOxAoVLpwD3JXkvoVcrJD1CSg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b4/FVF7WunEEW/8j5s0I1V/d1KshC70S5AvNQXHLyPx21M2hw/VVUSHBoeI0MlY7laJEkTPvwAWQRwdCMhVqIeaz82qX4Yc516f68OlQn5X50mMsJiIXhqYwh3+2CPj4Xki9jGkAUsEVpmHIhnoPDWP2oVFYP418Z+JD74Jq3sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lfe4dUui; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lfe4dUui"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODWVP0Ya1RHbyaDNjdS8IEM3zflrNqed3OSp/w+F+8CDCWjRaEJBul8jxif89ZLmvAnvDDSIo2AlYgxB0YPA9cvea8PZLt4Y9WcIOwl+UEZWGn7Vkduu4G2IzJBJLxXPXev595Sj1JxrOeURV+QvapyAvEwJd0qA8DQPxHCGFYFgYt5pqEEqy+0yBnLXYkCj7nITque+Oh6DnolSIoDWjUeiq0pIDJw84w6Io9Ek3piUOvfjybVGhrPwPP2Aw9HArghsR6DyLICPB6Q508B5HjpRVfWNzrBY7O/q6IvBgb+moKmB9ZoGeE8aI9Ft3GP0GG4RrzGDLV5lzsqmLGHLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE+FDikOUlrLkIyS1NPm4zt4rmGBYFSARdXH/8a0Bi0=;
 b=lo0R2slTG5Wyekb04Gc+vQhMIbu8zH7Ydpd+Jcf1jZT/sATWzIqkhm1xFbng6T7PUJcKKDbqwDqK96Px9ML3jMpCTUhaMBc8ovEURi/15ogkz+ELmM50ejsptMkXfRaX9gMwCljJuU8cpufHXNzNEi+a+/xL+OW64z+y4RNVvT0HsiMvlE/TlMIj8U6R4cV/S2Es8JyO9J51DHUaWvG1ItmkWg4uuPcE+7uFB10FuUcKv3hiEx32X/atgou+p89wJO5o0m2MznwJ7ysJtuqP3rWdaxdyc0SXwfHlBmfdTmrim+5nrvq5YCLRB3hGiQvFUESLqzao3+P1Ic0+OocWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE+FDikOUlrLkIyS1NPm4zt4rmGBYFSARdXH/8a0Bi0=;
 b=lfe4dUuiw4vyCKBmcbaCZ1oN2JFUmafNk464UNOOHbpDLhQ2Ruuf68PTBJBArhvjAn3hSWnJdo/crSkPNM7HfG8pSNLh295JEr/NBtfPkPDSi5hSK7aFLPI27mHoKxa0La0l00Up8hdW9a1a0XCPiElVGCt5VDoNtewqc+v/dRY=
Received: from DM6PR01CA0024.prod.exchangelabs.com (2603:10b6:5:296::29) by
 MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 15 Oct
 2026 11:47:42 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:5:296:cafe::81) by DM6PR01CA0024.outlook.office365.com
 (2603:10b6:5:296::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 11:47:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 11:47:42 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 06:47:29 -0500
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
Subject: [PATCH v2 0/2] perf/x86: Limit branch snapshots to valid entries
Date: Thu, 15 Oct 2026 17:16:10 +0530
Message-ID: <cover.1792064123.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 40cb7bf7-4382-41d0-c409-08df2ab21f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|82310400026|36860700016|11063799006|56012099006|261009223027099003|18002099003|13003099007|10067099003;
X-Microsoft-Antispam-Message-Info:
	f96G/hYe36yVG2ZCZiCjWoQcHm75l9IUa96ke8gCy8HzKAguBZDyvwlDIYlXjArvW/FTUGflQcpWY8uuPWqEnJ/Zem9i4E8HH3tCfRQ8tTHEk0DMx8M7T6YaeS395MIR6UbUSTwU5q7dNoHw4MNbh+XJuL89WY8crG0T0cqT8C5NMqQ0MBWJvejtc8hkFmyprbMhuB/2NABnQRtakENY+RqVG2f3s5M71mYIIbR41aDNUcjjcxyH5jdCYeIok40L2WoNXWOYoF+VcXR7boXA032NJynid6IromQVOuGAsj+uagza9jspQ9jjj1v8HvYBeOdp9jZjYrn37xMnML+Ukmsaw47+MeLHyISzuWHZVOcQGWlff13mC3nh8lF5S8WIO1AhmaTQuXS8qtaGko1WgG/5bgsMx2pk1De28F5voJH1cqJy1ldRZbkxXNJTTXFE4dMKzunnoOSMoaym3x+SJcB30ZNAtDATN8gbLwu3fI50qrXa3Qn/bXGCobs1pwgNEVLoUzJZgx16HaqNhz2IrztnG78Q6tWj2Jm868H63lJlC8zoN4+L5EA+TMZvLOC6e5gOobB3t6ZK5tHsliOT2ET1m/+bAmQ0OKKHGwF2Wt+eqUbDihpuDYQ7tUNrjCWvABf4Z8r//UepAkMsfutbqC2a9j4HR4wkn7+v09xhpM4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(18002099003)(13003099007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JKl1zT5sU4JGNS314927Zj5C12S2oMvBN3E8Q10iVCWBmurSwiXjOj1v6w7Jn0OtwX/Il6Lg7pS4soEzYQixzvxjrnH1ARoK5TdDDO8ocWGQ39C9EEGfWUjL9/eRYQHnk3l4P4STgiOFvM5Y0inEZLaGzuleAHXXRNIsGWsnFnDGwQqKuZLYEMIE9BVmerj1LHnVHo2SeR7xSfMVU/6KKhx6WFyDr2eL3ovV6nGhKeRkyijFABRC26sBM0IkbBZ56Q/jBXJrD8tOrX6KNvZnttRdqm4wL2bYt205bskbBnltoPEHsqGGMJ2B48MdNPMRwkpt2cD/l35BIvEG5w+baPJYxeiViAfTJxOHpxqgnezGgP9EWfOARlkLJBMk1dpJn9LCBvVL9/GrBh74ITXI2tjaz1RUY9+KKWOFUVmYDNRLszVTecXKLA/b/inlsPtH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:47:42.3216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cb7bf7-4382-41d0-c409-08df2ab21f12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960

Sashiko reported that the vendor-specific branch snapshot callbacks
used by bpf_get_branch_snapshot() copy up to x86_pmu.lbr_nr entries
from cpuc->lbr_entries[], regardless of how many valid entries the
last LBR read produced. This makes BPF programs read stale or invalid
branch records. Patch 1 addresses AMD and patch 2 addresses Intel.

Previous version(s) can be found at
v1: https://lore.kernel.org/all/20261007181002.4005262-1-sandipan.das@amd.com/

Changes in v2:
  * Include a fix for Intel LBR.
  * Add Tested-by from Dapeng to the Intel fix.
    https://lore.kernel.org/all/eb6c7bda-0dcf-4fac-ad69-9f5b24abc21b@linux.intel.com/

Sandipan Das (2):
  perf/x86/amd/lbr: Limit branch snapshots to valid entries
  perf/x86/intel/lbr: Limit branch snapshots to valid entries

 arch/x86/events/amd/core.c   | 2 +-
 arch/x86/events/amd/lbr.c    | 4 +++-
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/lbr.c  | 4 +++-
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.53.0

