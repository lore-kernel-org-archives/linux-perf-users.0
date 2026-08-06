Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126C42B73F;
	Thu,  6 Aug 2026 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011388; cv=fail; b=o40Wg6qmyu9elOc4OUaNEu7ioQjJgXKr7xBuoDkocEaUz0aILtq4mFD+3kEkaJqBW4j5yoqs9L1NIcZzRlNiI1a+pLLTBJVfdE4wxxYDnP3e8eRgNo0LZB540IXPCZoifsFJLHsSzvsBpox5XWYMfxuIpXfiwskPnSc+FiZd+s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011388; c=relaxed/simple;
	bh=7nATPM/FgNbDRgz1TFWlFklMQq0ZYiiV2njax2+oMu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lz866Yl88aqfZYJB6+m/9firzseelrcCtpqB4ZEbTAVeqg+C1CVBW5WPhXS6JgbcbdI9iNlRMzrNA5LOcMOLyNOobFE7GKONA5I2vAL5TfEr3Rqpz8VDggvNzHCqH/osw+Lfy2DRb8qU5EWQvpdfQ4PKkOemRWnRfL0EHMiI6ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZRSQgcaU; arc=fail smtp.client-ip=52.101.193.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZRSQgcaU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6s1aTE7LYzgoZL2ynNtlIhnwv/wJVPVst9O8kPCEMrjvMXeyjdajB0jQ+AsuaahQata3SJeTn2nNAjXhMUx0njtYLrdsFsqmUapLnRPNTz+T4QecxJiBOzM+gtqw2mlQG9/WTCPGfIJczlHBWOCz1Kn6zRLQ3txtuMliAEMrxrn1Vkm8xa+FtOEG+AFrL15NT4sUT/kOQB6g8+UTX4P+1fahgV/cabjhE6XqhpjwLdEgfNu885IrvcJhsv9ssby09VnvnR3ckSMEnvj5b7w7RAjnsYVm6iZlIbntk7HBbZL5Ju1003WCvuJ7oF22UwHaMb62T5fxIDLxNwj0AB0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIIFM5u4E8rUcw1IgBF+57n2mS7mptcnwhiF66PAOEE=;
 b=GVqKOICqRKo46Kq3EVZ493Tj0WrRfQO/bo3koj7neWAkMYb9BObX2O1sK3vIN+PJaLeEm8zEgjqjrNDI4HQRECJn0hgMxZPca44hLUurPQ3QDLgYfNKL8xYAsz4NTuEw0bo3plrOvjy0dGQmrPCrm4FwWGFwHC4w+jb0OAnR/tVNX3sBsMdICM4hKOZet3lVw3VjmYHpJ59V/ZC4BXzmmYqq8hvq4+alyE/9752Cem05BRal8JVkOViAOl2seTN28uSzezl0ONKuQDmgHnqSJU03hsooC7H2T9NUxsaspYLQnvQZg7P8dv3rI+JzsUJla7o5cUpQMAXAH0oAIusNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIIFM5u4E8rUcw1IgBF+57n2mS7mptcnwhiF66PAOEE=;
 b=ZRSQgcaUF7oaXYZKQHHHXkrpkyvItEGBqBdActS91/V0jAjZrjM6oBq7bFaU/fcuL349Dw8YFBB2c68lcs88cJgIyizzRB9op0lhoZCHRFzZg7+wZS0XBnuEP320ielbDtDl4aSvNPgHcm1t8oEPz3kB0ir6zyDNxf8h25MU/IM=
Received: from CH0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:610:cc::9)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 10:16:20 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::4c) by CH0PR03CA0064.outlook.office365.com
 (2603:10b6:610:cc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 10:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 10:16:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 05:16:16 -0500
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 05:04:16 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Petr Tesarik
	<ptesarik@suse.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 0/3] perf/x86: Fix perf_event_print_debug() on non-Intel PMUs
Date: Thu, 6 Aug 2026 15:33:25 +0530
Message-ID: <cover.1786010408.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb10.amd.com
 (10.181.42.219)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c16e7f-d59d-4d73-153a-08def3a3c24b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|23010399003|11063799006|10067099003|56012099006|6133799003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	K2pssQR0OhdD5xEgWI2UqYGRN3KNLHUQKAiDkNVrtmG0gsGJaCjjj4HV/IxBdry92JtJBuU1fTh+R0iVmqoHoObuJ61Wj1yKlmIdCRJ6ue5LBMKxTsysJKspv2hZGdiXTXTC7rVLGIxTSakSbjNgMIsrUz6zNTZlydMK8cLvtXtao1KTrhqRv6va7vW8JN6j/aIG4ZltemIgPU859br3RFJBa+3w61tUZAqBgKQoSaBsFB5axKZved1vqRV3BEmVEa4YN/FVK0P939F0lth4+4yuGjKHK1Psgli2/2qGI70X6FJ8PU2z87Ii3n9Rsv/ODHUvlkamH7f6JvlHVP7AyiIiA89BvDEJZzF6hDCDnhgHlBltN4uDTtyKPxt6N1W0ocM70F7RK2ei5lk8jlw9F8Rt2WmlM/PtHeIDgfgSmKKqG05RDWlT/lQ0rzAKco3zpkxMLtpKxtg9ipPmvB25vNknKBJ2rzi1LLEPp4PgnpXy0vMrZqjbMCQ38CZ5c+XBme6qNcSPqaWFhI0eryr9Fy3t2znIdqccWhIo9/OdUPfksv8Ol7OjHDIvXdRXGu8OENdFtPao4mJaidg/nJVpXgosQouAYBoe0QzgRXIPiZAUmrO/zHcjLSECgneNsQqAJ0mUt+QCI7OcfrJdfWlyVgDJcdj7XncXvVlOFSq61wa9+84Gy4t36wUkM+e6BfCiXUTE4ViZxxlIEkXmjJCwPQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kJTgBp530835ckySS4v+GFLPE/q2BmY7OxSZU02qNzvRzciIKveUzNeykagNqAOCR2tN9mR6bqjNkLIpB7hYYhxI4rBZzUBrK3ddfb5ciK9jSyt2anbGFmazU6jxQRzKDmAMUSip6TEwJzGMD1wxFV/dMJrXr1ruNiGKFKQHHUmLKzDHhktIBVIW7wmTy0wrZfTA8Vy/fYBpgjbtCWmkQnPFt7DDku1uU5uewOVy09+gV9IQBTguYKh4z5DcocvM7/fZ55nUhNMfc+aecBGl5YhyMBdv9wZyRj730UrroBNWL/vtQVVq05SVE0WsTIj7aenNxjhEDbB3YaS3ZsJEqivV647AiIu8d3OV5fFpOFFRkbV1y9s2/EnWuONHaCgSG+Oe+gFBKMpyHIrdwVs7jutVpOdZSjcLeeoFd2I3nlCkTAbHKUREfqDj69+O4a6N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 10:16:19.7698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c16e7f-d59d-4d73-153a-08def3a3c24b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

Petr Tesarik reported that reading MSR_ARCH_PERFMON_FIXED_CTR_CTRL
raises a #GP on AMD processors that support PerfMonV2, and proposed
skipping that register when no fixed counters are implemented [1].

However, perf_event_print_debug() also dumps the global control and
status registers whenever x86_pmu.version >= 2, and reads Intel
Architectural PerfMon MSRs to do so. That condition used to be
Intel-specific, but since commit 21d59e3e2c40 ("perf/x86/amd/core:
Detect PerfMonV2 support"), x86_pmu.version is also set to 2 on AMD
processors that support PerfMonV2, where none of those registers are
available.

The same reasoning therefore applies to the other registers read here,
so rather than special-casing each one or reinstating a vendor check,
this series makes the global register dump a vendor-specific operation.

[1] https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.com/

Sandipan Das (3):
  perf/x86: Add x86_pmu::print_debug
  perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to vendor code
  perf/x86/amd: Implement x86_pmu::print_debug

 arch/x86/events/amd/core.c     | 20 ++++++++++++
 arch/x86/events/core.c         | 56 +++++++++++++++-------------------
 arch/x86/events/intel/core.c   | 32 +++++++++++++++++++
 arch/x86/events/perf_event.h   |  4 +++
 arch/x86/events/zhaoxin/core.c | 18 +++++++++++
 5 files changed, 98 insertions(+), 32 deletions(-)

-- 
2.53.0

