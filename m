Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C832B999;
	Tue, 27 Jan 2026 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539908; cv=fail; b=MBqShiGNL7E4dPBQviIYMEe0bVWoHgTWBAgEKf30Aj5OZ2OKMvyIm5y9gP/f72sxV/AVXp+nLyGl8zP2TbdJPeNa48ELnOJ5LGX8nctjA4dPEmawZcvHt8Qpk4ogSctCUGVOk3v22jHkFBkUwMyxmdWoWwMg8xntpy/y/0B7dEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539908; c=relaxed/simple;
	bh=cogf/gk4qM5WwnBrKwmN8b6Z5sjyIMnlitg9i2J9360=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saeVnLxj4pxTazWLNXTYLDfkgDy+9w9XfzYr0Hyobz+J0h5Hh6Kd1KaiLazDyQKd31+scmh3Fl+mQujy7ug6hFYyOzw/0y5W0Rryqp058Db8Qy0TIYHiXAsVCEReFgA1qBzLDtCqTePOw357iOAfNG5s4jONyGKqcDC8ufNjktI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jKL37Mnp; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jKL37Mnp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+kw/bN2IW9LTN8ux8apYgcQB4neND1sL+y0JcrXp0gUbcyiIrANDWeYS46QimQDdXs53yezugZTF1k4b8wp8RhjCNO9YdV4rYFZ+pBg3sDiBPKf0yoq1kWRXfAPJLtxD4qzD4Mtusp30MA+Lq1DL3earWXSiORUPk52cAz9RtlyFi9GjwU9P/ADjHqy0+6m1Q6FRDOrBUjRdt36wnGGpTicXHNQyB204Iaw8hOcd9ggrMb1pGWQYK54g6B1CdVUS5d40rOs7H1MB22uZ7KU8OMm8x7fItxlRPDGd/JO5S4Ac2JEVqsMys2N924EhQnAjcaDEC5rzm6ZQqKssb3f5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LKGEnP8T4NFwAHvkxuS6gqmGa+e/4c/Uqp2bbtk8No=;
 b=ml4EzVGXi3qHYS4d8urKL9vsGIw7NgdtGw7WBgnbHSnyk5ERLs2wxDv69SxhDZn6Pdys6/d9AN768YHDRJF3AQNb0nu00/Jqwgi91MeaJxQdIvMmW98KAwXuY43VYsPwTLKc3uTKq4rt8TxxiWwAxS3TcNg6WYyduwYVAcaX3YiyALTA9V+Y02L5h4rKyhODL2Vay7Apxw471Vani5u+ToDHsjUXleB94+8NY+fLweVs68OI3/vkg0tYltf99Rkpi5NPtN08BBF5jGznHOWoaWDo7Qnp8DZtR12AQ2zYX0R2UjurutY+qXQJV4GHo5c2GYmQ+XHjborcqgSz0N7MBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LKGEnP8T4NFwAHvkxuS6gqmGa+e/4c/Uqp2bbtk8No=;
 b=jKL37Mnp4TSk4v2c8aj9pWciuAGrBXxnBqbH0JQjUAJDKmRA/ClDv8Q/4nYrDE4P5X44U5txItbzwoYElOsrXzRdmIjOZTof+mR25EN2x1zFHX0WtxCA1VHsZ3DJ6dWug/JpwY+pJ5MWY43n/nLVDeyWSritOPmLZdj4PbsKmBc=
Received: from BY3PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:217::6)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 18:51:44 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::6f) by BY3PR04CA0001.outlook.office365.com
 (2603:10b6:a03:217::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 18:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:51:44 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 12:51:38 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <thomas.falcon@intel.com>,
	<ashelat@redhat.com>, <yu.c.chen@intel.com>, <sshegde@linux.ibm.com>,
	<gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v1 4/6] perf sched stats: correct spelling of function name
Date: Tue, 27 Jan 2026 18:49:58 +0000
Message-ID: <20260127185000.431884-5-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127185000.431884-1-swapnil.sapkal@amd.com>
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d3f7c9-9667-4c16-06d4-08de5dd51dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RKjyGfE4yqU/YVdWjd49QeNQv8ypZ2P0rePp4nCWhtcb/rCX5djno+8T2vSg?=
 =?us-ascii?Q?hAoaQcTYxpF4OIUhEiyJv4wu8R1dvGEwop8WX9q+WEQfLRO5Mdk21GFqzkyB?=
 =?us-ascii?Q?ZOnQeyx3Akla62qkM5KmXCk7ubAXIXNgs7lgcCdZ0HlU6Q8/TikU2fzgRut5?=
 =?us-ascii?Q?wLDSzDKCCtNNYUrkgha7voR5s/JxDRwgdQLSejhAT9gE9vJZ65U0lTs72yKW?=
 =?us-ascii?Q?r2iIT1uDvIAZ/uWkVXjdwGnp6r5n+hZ/R1I1NRtr0+L7033mVnpBF2SpAZTk?=
 =?us-ascii?Q?FKYTX1yzfMfZsgybEQ+hLvPowbJy7dZBPDXAiZdFYEKDi3j1cYsEdTFuEcgB?=
 =?us-ascii?Q?qwJv4GOtP5rTsumAd1nM2KPy8Yvkh5AlLfl9JrnQVl6uEjgZ6aUVTI3o/vyT?=
 =?us-ascii?Q?1cu4USwF2WyOsM/sqjsxWkK4j7oZzdanArnkbtKPdLXGC+nhIkRcGE7BxKom?=
 =?us-ascii?Q?r7HICyC4l/mBbn4I1luZTKMt6cpc1wnwqF1y20UIaKF+wEhtqPkKXPeMx+rX?=
 =?us-ascii?Q?6VbU4keh4U8oooYpRdcU4FtQv46y/Uy18w9NvbpXDMcLoU/u+JGD0nHWOd0m?=
 =?us-ascii?Q?F8j5F6FfYfziUFXR2kVP+DyY3E/nB1FQ/b1lboQaITwO/m2jBSnRm9xtGmzW?=
 =?us-ascii?Q?cXKy0t6stXHwxSaSleVNqAi9b0i0FthddIxJB7YI3vxc2UnB6Wz2sfqhyj+2?=
 =?us-ascii?Q?2E8hbDWAaP9J/WDG83LO6aIe23mG9Q+No0of/GGxtINlhIZ/AN7deHd1c49T?=
 =?us-ascii?Q?K24yqtjplb9WawWPdGoAsqgrm+CEi3pbqeyctDw/9RZCYTgKASSCkr2PIApj?=
 =?us-ascii?Q?nYfXamGXjceUjQkKjt/931ZmpvFEISyR6S3KWcMHGlZkdBVOH/a2RCYQLe88?=
 =?us-ascii?Q?Y9HcxReOhpJkDQhsiaK6JWrP7aj8dePDENC0SSzdrM+asxNWGfwfKktoOyAU?=
 =?us-ascii?Q?CVrse0+yh/fyAB6NH/30LI4CLqKxeKehxKOIKoK/qEMNVqepo93bIVUUs1Cy?=
 =?us-ascii?Q?mHmhwJmLmFrhczsXumn6MBxnaU8HdszGfUh/E75C2rWRxCOcsN8NIoVqpa1m?=
 =?us-ascii?Q?vJARXeoU8HT2CcmI/86HQsPwp1pJNghwBT6g7A6FW33o3cUvt5WnAY5cqhNe?=
 =?us-ascii?Q?ltCFkukUd8UTrjRb4O1+3sQKtuch1nzHeIfdfMYQINbVfye5ht610Nhq4qaJ?=
 =?us-ascii?Q?v+Rklu9C2sbiPnNOQcprIhpaTY7KieT/lkPVDRY9HeRxT4uRtwaECE5ElUji?=
 =?us-ascii?Q?ExWdVvKudY2n1geLgwbDRkG6ufuJAG9WGqTAOrhtJLAidqtu8dkWp1tDfRgH?=
 =?us-ascii?Q?N8ZpFB/1gFh6bT09bQS81i/ElhmvFmwjQKPldJSLIJ+NdTPXC/mRXUz2LAiM?=
 =?us-ascii?Q?9DxEX6zRo1deWgfNweHTGqZnBbplBwocb1i8bC8dehMMPtoNsq/o7rzWf94o?=
 =?us-ascii?Q?NpuP6CiiBAduG55s/rhALqfRwU6BxueHpIU3oa9w8Lg4SUWBBhpkUE2ltCnR?=
 =?us-ascii?Q?4WD7nJOQl9/SIk30fnLxONrMN+fkbadmpbWZbw9YU/g48mjB6DnnfId94HVw?=
 =?us-ascii?Q?+4m4lprQSZaNZ30MtL8j8tGGMVC3/ROzL3EScj97nYlfh0/KLd3CTjr9nb4D?=
 =?us-ascii?Q?RvjPj2R05gRcgEjsyI8cEZoayiX+3iJ+4toGi7JWuTt4Qx/MmqVyb16Tj0BD?=
 =?us-ascii?Q?0pNn5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:51:44.0255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d3f7c9-9667-4c16-06d4-08de5dd51dbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

Replace store_schedtstat_cpu_diff() with store_schedstat_cpu_diff()

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index f5e449bd6823..1a24c4869331 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3946,7 +3946,7 @@ static struct schedstat_domain *domain_second_pass;
 static bool after_workload_flag;
 static bool verbose_field;
 
-static void store_schedtstat_cpu_diff(struct schedstat_cpu *after_workload)
+static void store_schedstat_cpu_diff(struct schedstat_cpu *after_workload)
 {
 	struct perf_record_schedstat_cpu *before = cpu_second_pass->cpu_data;
 	struct perf_record_schedstat_cpu *after = after_workload->cpu_data;
@@ -4437,7 +4437,7 @@ static int perf_sched__process_schedstat(const struct perf_tool *tool __maybe_un
 			}
 			domain_second_pass = list_first_entry(&cpu_second_pass->domain_head,
 							      struct schedstat_domain, domain_list);
-			store_schedtstat_cpu_diff(temp);
+			store_schedstat_cpu_diff(temp);
 		}
 	} else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
 		struct schedstat_cpu *cpu_tail;
-- 
2.43.0

