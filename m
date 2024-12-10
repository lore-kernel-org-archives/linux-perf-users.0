Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3BA223E65;
	Tue, 10 Dec 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823323; cv=fail; b=qg54MfBic3Zdu/MCYsW8/aNGOIH2+ya5hX6aBGIe6+SjJe9t3N0OXiKrDzE2ip+0FE8IIbMSA3cWexD363kembhnWj6C1PCBJiFseLBpHy0SblmReCUoyOggAsvKSc5885WHv/wJhVOAGrdD44en3Gec/7MKyD89E8GndS631Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823323; c=relaxed/simple;
	bh=0RNwN849p7UDauPqf/DwWrz9NnPoupXn4SGtiiOCQrg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+HKy3vUKsIs86HMbipoqf5HUnK3rABV7cfZO04fGiThY3P0WFZcD0vcRNfsLUJhnTUPLqvVZY6TZw9mZMziGH+0YiZ5d2z7xHp2moeLy1DwXRN/ddjqzarpIsYD6q4lDir36LCMQkw9Qt2YOa5550vIOEECl7PS41NOvkGb+DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3SgJSwif; arc=fail smtp.client-ip=40.107.212.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3SgJSwif"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQD2pdwHaLhXwZeUx48tQtOnEITGty7CCsieprIvyks0sq7oN10LY5sYiws+SwWIF3e3ISo+pQZ760N/92AH2KHQvY7Mp2QLWyrDAii3LvlC+L4paOR2ucZGY0JWazcjrv618e2y18m/wHyEb3sTNzWFuBNPl1ogwe7s3tcnpMqzWoI6hb8JTW5pv9hveS53UFT6yZFCKGp2S6U7VGE0oxAuzfFBL6lf8a5ZyISZN9xR/D2mGhquhb898LKOkouPt31yKtHLGA5bKxAuK5ngXv4csZX0VwLBpm+QX7HJqEy4MfNwTGZlBxXnbbNcm0lrizws86WzLwcovz+QzSy6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD17NH4EPAfyG6hGEPH7my8KKYBEeTQVDu5fCU1hAmE=;
 b=p7DPqNCUxJjHVyJFjfgVmtTx6gzfc2gL08VjhCrjwltXOJ0ecxYdk4AH410kh11pvSU/SfLrVB/VU3ArPLkDF72g6hi+/risntI1Degy0ANSjPUTLjK9ZYkR+XGLXED5TgPudlEKeOOfK7HbQYPuf2OWyRrK/WmX8NF+jedCPeXQlo12TpFKqulVFt8ozR3B2HQJCT4Onk76zDKy+lI+DJ356C+kKheU4TuRScf+btEvlhSeU+qrc2VkmKFaVYbjOX5avX2o0kho3SRzwjlsEHsztfhQv1099QzfKHzCNDiqOXDp4cD1kFpJjGgk2rExwBAaXXR6cPr7WXp9WRxIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD17NH4EPAfyG6hGEPH7my8KKYBEeTQVDu5fCU1hAmE=;
 b=3SgJSwifTkinvFARqj8TPQchmxIxits3jSg7C8+98DIEWbFOItkUgGS79BSkCnnyEMyEyiqUr7i3kZhCQzFRHYejve5/pk6kXyeH3O1spqsABBrdC7NXTUTHwvPGwQkDpmCxwt/3vFFbOMfBSDOvYaWGtBBTXRSIn+lHed7xl3w=
Received: from BN9PR03CA0217.namprd03.prod.outlook.com (2603:10b6:408:f8::12)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 09:35:15 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::ec) by BN9PR03CA0217.outlook.office365.com
 (2603:10b6:408:f8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 09:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:35:15 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:35:09 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 00/10] perf/amd/ibs: Fix sample period computations
Date: Tue, 10 Dec 2024 09:34:39 +0000
Message-ID: <20241210093449.1662-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a111b49-0926-4363-a01d-08dd18fdf3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DIWQC4OUXo1HJWo9GPEiqcD2FX7hob2yze/9kLeUD8e1lXJJuuv+8r8v5mCB?=
 =?us-ascii?Q?XXRluDfPRy7r1vh6W+yyN4QadTid7oWm1siZeT4k2youc5bznc6R3wot0HHd?=
 =?us-ascii?Q?gj9dctOF7PCoh7vRnnnUIxRKKgY+TEc21TfCCaa1sEsBPTqkqaOiNC5v4IdQ?=
 =?us-ascii?Q?k+nL+l0z7vnP8Lqkd0lVcVKaKpl+hzN3Mu1v4sbN2nG11L7h2Ut9nkNt6582?=
 =?us-ascii?Q?++6VniwCg96355goOaOWCSkfDjqTnOlDJyRcfOHM8bjW1aaM2pr8HsjtyFJb?=
 =?us-ascii?Q?1/OJexoUwNptO9CZKiS9jOqVaytRNIeLjgnYTWuB3T30SrE4zFUuSyHR1H8W?=
 =?us-ascii?Q?aVDL0Ug+dXTvKaJqpJzkI+5LxV8AeTyCEAtbcU1Ar/TlovlepVIbP/qrZQEC?=
 =?us-ascii?Q?ZBlkllrcGd+M2FNTYhoUVFv6TuFK97a4XSD+YE6gftnw5rVKyOTsxtuFVMdR?=
 =?us-ascii?Q?PHHkVrchTd9HXF2a4/uR0u3MRmPE/XKsWfHRVMKGXlJMXNvrPtIdo0DVcv63?=
 =?us-ascii?Q?wAT8zmF1qJSYcySkGwzLQnWHSiA09r4IaINUDVC5GVI0OLOxtXCQXVUnaTm7?=
 =?us-ascii?Q?pykLf1wtHn90bQ6cSRzXN0h85Xw1xyeqB4zeIG0wO+mOsnzDQhT7YO/7eIL4?=
 =?us-ascii?Q?+wzy0Q7coFakFMwfUiPN1iHfWSVB++UX47s1nu3jnr4ZsKoiN4RqFC+zXf79?=
 =?us-ascii?Q?ce9lD/1blNzISg92poYy9t6BwrZjVr+DN7MS1p3VTLrLp9FAyKTo+BZ0FR6v?=
 =?us-ascii?Q?Kc2gByI4iTyfTOaD7AsHzTDjYvo5r2epBNRZuWo4bep+VbcsWKVQtVGH+zrA?=
 =?us-ascii?Q?B8MF7rJugXVgO/LBUOo8HNI4M9fr1aZgJjFfBGid0zlDlsi+bVsVRarYgErf?=
 =?us-ascii?Q?bf1zOV9uRyLBhXcRAFPFwUGs+OKA5zwRkRdVVMPy3eCtq828Hzf0piBrH6MR?=
 =?us-ascii?Q?DgyTKxJiX/c6Yp8XWULsookn0eWsQKHCQWOJmwPnWBi4nxFmebdR0oQ2AdEL?=
 =?us-ascii?Q?ELT/vGxWMfRYO4P6XVzoRt0KjV6E7wjBryYYgpHYo8NcRYYr9PmtAMW8wssU?=
 =?us-ascii?Q?up2nsTat3taTqVqlxbQ1oHuQ6OuLgedBw7mkaQRDrlrh9p7Es42xlM3X2Z/p?=
 =?us-ascii?Q?OJJuMlwjUBfYW4HnCOVKds1awHK4yZIg2XWsjrMtfLyrlBMIb11cIq8R8irY?=
 =?us-ascii?Q?HZ+K7pOj0HbNK5rpV9qbbLqCPnBJmWhyQFxjXT/iHz9FmNJDSQqr7MnjkfpS?=
 =?us-ascii?Q?rX/wxkeAoYoko5I9YXtSDG9RU1blq4nDEGOlW/ZkUEPsNQl/yuTLbeuwwBQ7?=
 =?us-ascii?Q?WNIpXkK7w4ZoEHOVzR4R8i1cv+WHuX4Fis8y3Vv8qdQ2FE95xfm/R0IwPNbS?=
 =?us-ascii?Q?Be3+rP7+UTmN5wj/9aQFhlJW2g0FjF0Uxs3nao+Nw6Wvilx5APWRQ3zRHXai?=
 =?us-ascii?Q?beLXvl2M6lgUF0qk1zo4jgfEyDtD5qCQjeQjzJxrWGBCu7yc/xMyZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:35:15.2615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a111b49-0926-4363-a01d-08dd18fdf3d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745

IBS Fetch and IBS Op PMUs have constraints on supported sample period
values. The IBS hw behavior could be undefined if they are not followed.
Currently, IBS driver does not honor them correctly and thus a malicious
event could cause issues to the system. Fortunately, the IBS hw is very
resilient so far and IBS PMUs are restricted to root only, so the attack
vector is minimal. In any case, these are genuine bugs and must be fixed.

There were some conflicts with Namhyung's IBS patches[1] which are now
in the tip tree, so rebased the series on tip/perf/core (02c56362a7d3).

v2: https://lore.kernel.org/r/20241206051713.991-1-ravi.bangoria@amd.com
v2->v3:
 - No code changes
 - s/pmu/PMU/g
 - Include unit test example in the commit description

[1]: https://lore.kernel.org/r/20241203180441.1634709-1-namhyung@kernel.org

Ravi Bangoria (10):
  perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
  perf/amd/ibs: Remove pointless sample period check
  perf/amd/ibs: Fix ->config to sample period calculation for OP PMU
  perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
  perf/amd/ibs: Don't allow freq mode event creation through ->config
    interface
  perf/amd/ibs: Add PMU specific minimum period
  perf/amd/ibs: Add ->check_period() callback
  perf/core: Introduce pmu->adjust_period() callback
  perf test: Introduce DEFINE_SUITE_EXCLUSIVE()
  perf test amd ibs: Add sample period unit test

 arch/x86/events/amd/ibs.c                  |  96 ++-
 arch/x86/include/asm/perf_event.h          |   1 +
 include/linux/perf_event.h                 |   5 +
 kernel/events/core.c                       |  12 +-
 tools/perf/arch/x86/include/arch-tests.h   |   1 +
 tools/perf/arch/x86/tests/Build            |   1 +
 tools/perf/arch/x86/tests/amd-ibs-period.c | 953 +++++++++++++++++++++
 tools/perf/arch/x86/tests/arch-tests.c     |   2 +
 tools/perf/tests/tests.h                   |  10 +
 9 files changed, 1055 insertions(+), 26 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-period.c

-- 
2.43.0

