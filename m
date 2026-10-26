Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792988349;
	b=xVgSZJ2FzUfkTBnnj2G6nH/hD4j1FyMXmGqoR7YeYQBPDqNAwbMR7Hhgms4g1WkzJBXO
	 ruTxhbQ2UlOPENohg00YlZZHlFw57IwvRr28CpAMbFXHpZI6FeHAToXjnccR4MmW0wxP4
	 LrkkMaGsTJ6k1Q8XPWt7H8qo6IWbg3dV1c+Y2N+Uj0lTuDQZHobx24LuYzAzxLO/NyzBC
	 sVWYUwoYJzUXUcHA48RsUbNCgc+oeyYneBLStptfLX74P8pluKVNMn/X6EqqWQjNqqEfn
	 izDvv3g7m5XxMKbFPOIvAKTueOooIZ7XPqHBVoGV+jevr2ZBCw/flpGXMGw4PyypDvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792988349;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2OoK3yAdIWF9U9+aep7noPRRMHbyXlKuiEDKL/C35Ms=;
	b=l6kK0VPK7Qh6bZlpoecSy2VwapGrKsUvmOQlxsjxwy2UPymLmM5p9aAsRjYBjL2NqPWH
	 sykRvzGxpfURjykuLV5rEWA7LNG5bqZEoLFF48ZCwDzajg9TPb8tJuszVH8o4hhV/UZj7
	 iQMeia7ikBBZofdN25Gw+WFSHjYWwJSCBiijYiQ8ctjZ6TBKmipbO06yPPpncDfHzfodG
	 RLuXmAWoPrUXG72KnKPEAC7t6TXCRuWM5wn0arIN9B0NfyYkkQ7m8OgAHS19Evnapn/t8
	 rJy8/HVQ8tIS7mmc1u2sg+Kbl8inqt2OSN/rimBmKpm9UEdihr+S1GZe6f4IdvkbD3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eomOfMPU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.38
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D94606A31A;
	Mon, 26 Oct 2026 04:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D94606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eomOfMPU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGoFsUtfpHrRSouqQXGamrZytb/HMgdNRik2P3mI4SN6DsLYkIXJ1DoDqwQu2uw7Sqk3Bev0TddxQPWm/gHtWLjgaiA0gbhoVbkqIjcAIa4gF2xoThtfji1tdpbDunLvEKJQ3mqjoccQEXKPC6FMVGe3GQPOkp8bMj6uRagYs+Nu/aCfWCajvygYFIlmEH5GqsTXO29x9chjOmkA0pdVoTq6gK+6yjfhtCZOfwMNYWZITkKrgTtRrkFRT3XGs6iR7jrWk8oMVEJlTe9+9b980aLNsymOi+1fAQApn3ML9qZyPap/19LgM4TjeU261/3Xpy79YLn5wxbLdMhdM+GWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OoK3yAdIWF9U9+aep7noPRRMHbyXlKuiEDKL/C35Ms=;
 b=H9OKqC+2Y8u5twfScr7ZfEZEBFfCfyFSiMSAJ8X1POPJT7VxTHa669U4+N0pSySUMr8l8phZDk9Qa3QvbxleTHHcr+W0g/BAmVjJfkr4ugVYgC72vX6ntC2iTZ41oxS0pdNbEUN60VORJFrFsyDAK4a2u8TL1zNPPlbmGhzu0xGzM0cm7vDivdMv0fL/V8DJRm051fdxjtYuDITqlJG1qP6ZvC5HB7PygOD3c4KpEnuPLHx5rU7tjIbHDDkwRvVZNYAxBssD47lgK6afiPJqyFEqpNeOrjfAM4JEskzbuXKhYRdhm4c+o7lb3nInn0CMx0QT2XEz5MNicynQ+aawjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OoK3yAdIWF9U9+aep7noPRRMHbyXlKuiEDKL/C35Ms=;
 b=eomOfMPUM4FWcyx1ICR9FIEOt5FrMOG1Mm4dirPHvjuK7qIH9cTGlxLQI9G3VsmR849pzPu28faBNq0cYoNDtTVJNvo+8Z1CQOfWenKsO1d39G5DXzISFv32Vrcid0ghZTLqISwRR0o4wEuLjQE4fTMd4e7Bv16/8DQHWSPuEUo=
Received: from CH2PR10CA0024.namprd10.prod.outlook.com (2603:10b6:610:4c::34)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 04:19:03 +0000
Received: from CH01EPF000BE94E.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::1c) by CH2PR10CA0024.outlook.office365.com
 (2603:10b6:610:4c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.21 via Frontend Transport; Mon,
 26 Oct 2026 04:19:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE94E.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 04:19:03 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 23:18:57 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"Jim Mattson" <jmattson@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Jayapal Ashwin Nair
	<janair@amd.com>, Gennady Kupava <gennady.kupava@gmail.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Manali Shukla <manali.shukla@amd.com>
Subject: [PATCH v2 0/3] perf/amd/ibs: Assorted fixes
Date: Mon, 26 Oct 2026 04:18:34 +0000
Message-ID: <20261026041838.941-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94E:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: bda133cd-1868-4f01-3390-08df331844b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|261009223027099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|10067099003|56012099006|18002099003|13003099007|11063799006;
X-Microsoft-Antispam-Message-Info:
	jV2ZkfPGjN5f5NSewWwB0T/n8i+g9c3ZY+eSfEolyYl7clMBPC08DaCwCm+Yoo5YiRQ2KvNpw3+cUh9EKtHzr6Bj24ZiP/093QyiW1ZfO0Kax5m6l+j+tA4XIJy0+/tKZFinfUFTHp6L5ff+Eg6KOsZ+P2PWuf12YJsgX55Mb+9cf3/ABfybiVpa0JclAnJdy104kIkOYoeTty04wTYk9I5xzw5ivxhBlbmum/eL29wGBv+xJr/hubU9GhADwtATK0aB8+oEdvxtJIG1OFakwxp4SBd+jrVIN8FtWdXdD6mc1MAUEt6s1ZTdXrhuIMXAHplyR/hmmPls1PeD2pVwZSX/HnkQkninWRjF/jN2H2R/tNyy6RONPoRNBCcvdaO4q7SyOJhMjFgmkqXXcJP2JLN60bptluwBRSPSq79antpju3975Vyh7OHIknZxoBuZihuXXCPBN4EHzWzdowouqXxg7/zBqJQDq1NPTFfaU78XlNYUXx7cIJh3pQUGzmtVtCAhefU6Xul6vbsM1q/3OrBjdM/m2o7h6+vNA0Po33hgWUMG7oF9g2L2YgOVoqGsPFMgiDBZ62MrgsS2QEOcP6WvtRN9yoZbD59nOdCp+jllamUgBbQ3wqc+hsAK7gaCJ3smrL9ssYS0AoW8OHAhGg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(56012099006)(18002099003)(13003099007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lZ2qqHOjzmoI0VLoBtdtVLRkpBIv1GOR41xgIm8NUKFesyeRoWS9dr444SG5U/bEV1bS+XzA2VOv1gQyimu3DpTVE/iXzxvI6zGLhyXzfTii55DpitIPTpTjlCrsu+GvOyrMUlQvHBpbzQgzaDMXNDnwd0w32yqJSAekLigmnJFSYMufqOICr0UTPTw0JGAgB4QSMj32SOxB2iOYfrhd5yXQ4Iyd+zVelQA+h/d6qKbfgLiuxVUlAEBb4RVUTlSNcwlu/VKx46lpQ4R4sSCdVmkBtxTxzy1IRggVdIpk1eeI7liA23HJFNVMJIXrDomWvEszZYd+PvEjp3E2lMLY60RY11P1WJ98K1Co9QdX1pk6TAD/b06jOaejpmx4nqJOzR/NyI8i756XsuHBrcbZyFtMQoEvlSEfm9qC22YV5c6GUKjvUvqsk9+eKmHf9W6b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 04:19:03.4379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda133cd-1868-4f01-3390-08df331844b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162

#1 Set IBS MSRs in syscore->resume() callback
#2 Fix kernel address leak through REGS_USER and REGS_INTR
#3 Fix races by reducing SW states when IBS_CAPS_DIS is present

v1: https://lore.kernel.org/r/20261015060430.5877-1-ravi.bangoria@amd.com
v1->v2:
- Use interrupt registers when preparing REGS_USER and REGS_INTR. In
  addition to fixing the kernel address leak, this change also ensures
  GPR snapshot consistency, which resolves the DWARF unwinding issue
  with IBS [1].

[1] https://lore.kernel.org/r/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com 

Ravi Bangoria (3):
  perf/amd/ibs: Reset CPU0 IBS state on syscore resume
  perf/amd/ibs: Fix kernel address leak via REGS_USER and REGS_INTR
  perf/amd/ibs: Simplify event state handling with IBS_CAPS_DIS

 arch/x86/events/amd/ibs.c  | 197 ++++++++++++++++++++++++++++++++-----
 include/linux/perf_event.h |   6 ++
 kernel/events/core.c       |  10 +-
 3 files changed, 184 insertions(+), 29 deletions(-)

-- 
2.55.0

