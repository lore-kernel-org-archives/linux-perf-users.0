Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49532863D;
	Tue, 27 Jan 2026 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539845; cv=fail; b=SVMV+EEocDZFXMsjx96JDMNqT7t7nWT24NwNqgoxnIq4t2FNhcil+BFDyrJ9o+SwNkay+bCYuLS098oD+d2qLJeEA3rtFIedt/R0FwhokvZfgmvvTB7v/Rmw5oHCRSYTsaAdITH1Al/iu7ApsXqvs1sNBycQW4hDj6Tv5Q9IsLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539845; c=relaxed/simple;
	bh=3AWXptf3K+SdqGBNqC2jn29I/3EB1CKXkuhyr1qB884=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MO4LS+0rCPYExKdjuCp0GVWpm4DE81V/gK8IOAYHAPgQ1whOdbCxpWIDMPf6suyjl3nw4fCCkJ8lMMIqkqADHSCZLaSHY+Lce3a+x/r6pP2i/Xg5yoOVCtbetrK/V8QcAT/pl6Egbxpy38WRgcGTeO29KSisBo4igkIDVQR4eiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jmANE2BT; arc=fail smtp.client-ip=40.93.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jmANE2BT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jtd9BTbIkUvPHHVzereoOPflRi3mU9jwXZdooPXGcgP5d6wU7c/YojFPySuMOdHYU3dgWrrP+cCcDkfQ17HJhM1LAjN73uH/bjFwnEiigojTnJ+A/QgSrrqf3WA9yxwn/Nf/0KOac/YprzXWXrdZibY/LVcSNdd1p2s1/3vmPvJODYF8DEDbpihjXol0VVriXIZqh4T+kw3gvWJPou16vRy6i0ttfdTVWg4Gce5GHqZWb6NAbT2T27Ma0+UCWi3u2ucIcVQXT3Q+T6hbWIm81jf8CNuEyPxiFYij+Rew1AYNCD8WitsKxuB1CpsB1eHIEF0lPPNDv6oyW1xpjJVtUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sMegEmO26uWkFXVQCiMULgLLp8hsw0LOjsJTevE4wo=;
 b=TSJ7DyIfPkw1ygAw2246RDukhzxvg2BTJDKa275hNmHtJojqc7m+ibh0X2q2Q27TZWY7y/9fkq3zuFVlvMtdmkzmjk0me81fiFBWfNC47ozr4hvTAASuNBj61Vi7N/4jRhzuyoKttwZDp+9ZusG+Rv4FJJBZ7ViRUYkenlv/GYCLeyF34t303kp0GS+x6KAi2fAVv7mYCSOyMIlaGQ6AiZVq/ctHlLqAWODpEtd8+mVCwLkV1q/VCdfDv95xOK/43fOWRNBYmSre0ABm1qwYruYKNqzg9qrB9AqysVXTcu6r82+MIe97KVn3j8NRSdZBa7+a5p273ynYSQjBtJ40MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sMegEmO26uWkFXVQCiMULgLLp8hsw0LOjsJTevE4wo=;
 b=jmANE2BTOTmHrA9XBnfl0RCPUQOGctHvFN1gTU1txt5vh75lQ2M5bNZj7JTHtOvrgg90g7n6FYrNZaYCUjB92Y+HX8kaV1kqBIxhwj34imbFnvGBggqbAWjMENj8gtzp0L7Q7DukQZ3qT0DWdGRqiNQl+2gYqFyx67k5wRzyYz8=
Received: from BY5PR20CA0026.namprd20.prod.outlook.com (2603:10b6:a03:1f4::39)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 18:50:36 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::d7) by BY5PR20CA0026.outlook.office365.com
 (2603:10b6:a03:1f4::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:50:35 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 12:50:27 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <thomas.falcon@intel.com>,
	<ashelat@redhat.com>, <yu.c.chen@intel.com>, <sshegde@linux.ibm.com>,
	<gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v1 0/6] perf sched stats: Fixes and improvements
Date: Tue, 27 Jan 2026 18:49:54 +0000
Message-ID: <20260127185000.431884-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: f547bc91-703d-459d-f1f5-08de5dd4f508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eWFsLprfL8eOYy7Bh8yfBY9/xrXXL8qYLuZqyO+fvACyqSq/J3saRUd14Kk3?=
 =?us-ascii?Q?k/Fu3K4m90ldEPF/AjKcOkviCWoIqASGFWUI9uh/3RwHXP3CYcFDEUrn2/QY?=
 =?us-ascii?Q?XraQEU6Qaag6Jbrlm2NFEvcrc6xxRDujuBoeqR/h9lo8clbcmYIS2TlXQpr3?=
 =?us-ascii?Q?M6RHAMIYZoPwt9W0bpa++RsueacgWgRlGyyQqknvYQlDqGEcxSTJAlskWydu?=
 =?us-ascii?Q?Fpp6m6BOIYEI5XsE/1Ie5lWJufEb8g7Y+FnHzdDVfI21KVa90oaKdm20uDIa?=
 =?us-ascii?Q?rQb28PgdKK6xlsFnPywLA9ATA1KqKl2VUD+0HiQA6J0FwGwa5Y22aElFWy9n?=
 =?us-ascii?Q?kwVQdbQXbOKEefkmMZC9P0nxXSPKEBrkh6UK+vCI5FQVgps16jbveCAAj7hE?=
 =?us-ascii?Q?wTJskXZ0jWKcinssdB6JV62gk/ftOgHjlbra8l59v3YuNb8Tb+Y+vTK38D0K?=
 =?us-ascii?Q?8FeTI3sBvxt0emGegvqDi2ypumlK7QfBwQyZRi3y6GCV3abRaHRT+eUiD6+I?=
 =?us-ascii?Q?QZEXVgaPT5c8ToENoM+DChkvVhrU4TQC8to+nRNInJBVAs2IexcCM5It1d8R?=
 =?us-ascii?Q?XQXVA/EtVfzKzCsKFcOyXUfCM5bt/9WQdQwdgK+Y8VgNERqgaRGnVxiJO8EY?=
 =?us-ascii?Q?zqy7dy1Sfh4xnhKjtwtHWGUhXaRFlMHkk7775rFWpNrNWb8/bbjOtBiegQca?=
 =?us-ascii?Q?edeYY/pOVwVjVHP9J6pw43CNHg805+8eWGh9YZzHM1zhOTmxscG106QIITL4?=
 =?us-ascii?Q?NYGfw0e3z0mjcYONLpb05Fm6qsABfpPVE3b/KOpvgRHLOjTPqId7TPk8YEfO?=
 =?us-ascii?Q?8C68ENslsqKLUDb12PzmhZPO2eqoxCnGJBCEQsTktMkWC0MdLy0YAyWPATob?=
 =?us-ascii?Q?MHFYinXSZvH3nKe0X01qmQpgYLWFsSaVtLVbsg4GlKObpYsrG7WHE090LAUC?=
 =?us-ascii?Q?lkzfzrmpkg3+wBAKzk4FtaJX4faOcy+7S1VunqprJg4aBZIvorr3Z49UsBmC?=
 =?us-ascii?Q?uY/bR2NRAh6gWbKJ/QjLaeZUCbs7dqkncGYJg/sLCuvi3lweecZpqCEApf+f?=
 =?us-ascii?Q?/s8GrKKq1xr2nGsiTlXDwMkAfLhtPORCZMbSkhBqHr66w2YqhnoUm9tdE0Eg?=
 =?us-ascii?Q?St7PbRdiTfej4MS9uvN0oNXyYjKDTreN9VFV3cgOOyEShIlicsIfTyva1sja?=
 =?us-ascii?Q?VUzuigMpTKT9kuXvKSgJWgd9crXLKySAOa12MvlhZFp6kEPe1KIs45xiAYS8?=
 =?us-ascii?Q?YcLakC5EHUSkYisefv4HyEqdR6nsA4lN6UZZwdOGl5MSheW7g5jhvogTpqvZ?=
 =?us-ascii?Q?/VT0n7SzFzXpfMZRuw6dd73bOfX2rHBCF74m30/L0nmzNrctKyjRzF3mf3Le?=
 =?us-ascii?Q?15p6CSCcMosPp810gzoGbXlCRZkJtVbrwVH9s+if405/RSbRyTS5ROGHJXIx?=
 =?us-ascii?Q?rwgyIiuNMAG7IDUGh8IvSv3j4LEQ15qqa5awdv9BqRV0KgK5lFDW8A7wuPMP?=
 =?us-ascii?Q?bTCj4UVeo6XlaqVF7Vk0JqE+PUbUh/ngNXU+IL9R4S3boYC0OkkaIAuq50Hw?=
 =?us-ascii?Q?LjRUMoW65u/1oBvDPLOov+Uv7yHqQ6pXRV+aVUh8az+9UqO7vKt+RFWHlkpL?=
 =?us-ascii?Q?iGINg1Se51wjLHKi9pqZdyFjeQXeazAFN4R+UBrwD74V+auBvhIQOxiAETOf?=
 =?us-ascii?Q?+2V7Kw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:50:35.7299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f547bc91-703d-459d-f1f5-08de5dd4f508
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

These patches contain fixes and improvements related to perf sched stats
code. The series includes:

* Bug fixes
  - Add NULL check for cd_map in perf sched stats to prevent potential
    NULL pointer dereference
  - Fix NULL check in cpumask_to_cpulist() in perf util

* Code quality improvements:
  - Replace hardcoded max cpus value with MAX_NR_CPUS constant in perf
    header
  - Define SEP_LEN macro to replace magic number in perf sched stats
  - Correct spelling of function name in perf sched stats

* Documentation:
  - Fix various issues in the perf sched stats man page

Swapnil Sapkal (6):
  perf header: Replace hardcoded max cpus by MAX_NR_CPUS
  perf util: Fix NULL check in cpumask_to_cpulist()
  perf sched stats: Add NULL check for cd_map
  perf sched stats: correct spelling of function name
  perf sched stats: Define macro for SEP_LEN
  perf sched stats: Fixes in man page

 tools/perf/Documentation/perf-sched.txt |  8 +++----
 tools/perf/builtin-sched.c              | 30 +++++++++++++++----------
 tools/perf/util/header.c                |  5 +++--
 tools/perf/util/util.c                  |  2 +-
 4 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.43.0

