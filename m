Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16383596F1;
	Thu, 13 Nov 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049791; cv=fail; b=cTZlM/WLOSkr08oULaEsSu5CRKeq2/Wt7rgSqmhpXojnfLtf8s7yuWEjhX07cnSHSVED5DK/ILkOroNQ4MKYWnF1BldSZ3M1UPUo/cQNNn/G3RjS8R0JA6qHw5MWqJstO6dnGj2dkv/WSd6JQ3ewzWuHBSAiXoYL+lUesXcOgKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049791; c=relaxed/simple;
	bh=Uf8ce5dKNdIQxHC2lSQniSZbneI6uLPQukJi1q4prb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D83vHOkcJk1Igh0WbKQzEx3QHUI+7RevtE1cN+yTTriw7fUXFyZRBNpj7ZayHpUmTKA3HgpVujJMV8KxYaefVF+CQknOR7shh6LDNhTIH69sDZkBTr0yo2lbYfncFcbnwT/D5I5JL2etxDuVWfr+CccwnrsC4W+ixhGh5CBm8KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WH6I/+ot; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WH6I/+ot"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K89qkGauup0qggeHR13puBkjhoKvuryTMAUQpwVKhvAvzV20pQB8n4XVK+oIhkcy5LacEWJW3CKTTRZxzspEsegEBoBn2cXRzxlozdG0E3cJ50lfaW0mMZwzMRQqCO/Z7lyouuH1cI+LhqUM2hVdhvKA5yLcjkz5ItQer7VKoTgVUrqSIIJHGtq3moYX7YEKpbmArUSBFfr9qp9z+oryKgD04lnAbkaITA/2SbSzNviqW4VXrC4648euXnzaVel6yXti6S1ev4c2D9lyEeAm9ORF5KB2CiOjg/L6bvq2zMvcq6plEnA+CQYhMd+urSuUvBBWnvyBwVcg5WlWXQ3hIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSfcRdRWnJlVYoJTjzUrxxTtbzNp49SZY8Pov9SNV+0=;
 b=GMuyckrXSOqpH+nsZTf3ug6OmowljdNLtlTHRjJVXFLlRUgoEVTRbHhlV190zwAH3c0kFdjmZlYXsiMLcNRCAIHPHqRsC3yfE6CqI42a2MW7nqo8Auf6OnMOvrmsKLR3Z3DTaAbjELLxA+y8a7Q6neeyzOFOqyAweWCLNZb58dhR6PcOw1tOXb1rpupS82A9CQ8i5nwyKhdVidslDIdKU1wPkNm/hLyirv2LvN7JbIw2Aiydfo6KcS1DV8HdyU9P7rQSPRShZCEgcq9R+wQygKLWznwY4EPdVI4Cpwbj8uCKrcQtoukqZF+52o8LvJ8I5ypnQgkxDm2IdBdwrWsldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSfcRdRWnJlVYoJTjzUrxxTtbzNp49SZY8Pov9SNV+0=;
 b=WH6I/+ot90Dwx3LGI7aNS7KAG7CPhqSoL0LbgTsMzhqXsBcPnG1LD1l7rHEHx87z3L+xaC96kVuLB/jNDlDIZVTnUNvSMsfZpyE9dKNjl6HbY/ShyOQZfGBTozoAuASw+0pbFlv/sNyXZBIxWWjmujOxunWzLAnL+DrQiktJyck=
Received: from SA1P222CA0038.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::19)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 16:03:06 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:2d0:cafe::3f) by SA1P222CA0038.outlook.office365.com
 (2603:10b6:806:2d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 16:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 16:03:05 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 08:03:00 -0800
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Tycho Andersen <tycho@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 1/2] perf lock: Fix segfault due to missing kernel map
Date: Thu, 13 Nov 2025 16:01:23 +0000
Message-ID: <20251113160124.2695-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113160124.2695-1-ravi.bangoria@amd.com>
References: <20251113160124.2695-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b86b03d-559b-4381-9c2d-08de22ce2174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s858b5da4uZtPl0yI9Dk8OxfNcRL59zXVe5nfgGYinUuHMh+kX+EtgjjCymY?=
 =?us-ascii?Q?iwiRNcPhpFmv+K4lymPwFxX5R+d2fTCaCYd5boTlHASUVp+smo249saxkdOy?=
 =?us-ascii?Q?o4asXBNtIBqBE7Ys8wNijiT7Onju5mqiqFBo3cWR8lQLwBSTAzfhrtTplt8g?=
 =?us-ascii?Q?wZHiqlgftg2IGD66/+LRgxJB6YPpoxP2858//Od3IyJkLJlX1zk5GgaQ7xPZ?=
 =?us-ascii?Q?hmPw4N8ogB1RqgbRuqu76R0mpW+GUmgYiPKouTkdQhKnVtiK2KopirVZGaZI?=
 =?us-ascii?Q?N4xrKdjPesq3Gbgsnorin7ifgnGvu5PtnEN79ofaPGmN3ccD8toh642xgnOY?=
 =?us-ascii?Q?s1hc7+Gs/G3wbFjAfGHz0Uq21Oa5VbI1h3qki73x7SwGz+SIYyt+SLMi064g?=
 =?us-ascii?Q?+BM053YCnuVXn5sGYgySH25CDOK/OwJTTEa6+QAsiCyez+yfYaT4ctNkvNr5?=
 =?us-ascii?Q?gn3mOXqC8NVkaHhf38VjAnQH2+qCsvMLBpzK4oVlTdTmJmuk0zjMCRKCFZXX?=
 =?us-ascii?Q?36jWadpe7uUvC5qvfLDW1A7/DcIueoGDm1sKitYnjMllKM7wpUloZwUWLa9W?=
 =?us-ascii?Q?uqqzpNqMVudhQuLRkfAjouW/3ks6pf0zbKR/aVka8qtETn59nxVqDmoHVDlW?=
 =?us-ascii?Q?ea5avlb5zBrgiFcqQro7m1Hooo2peTocsLZuD2iWRKSj+MCLCYHoPNkgiv+V?=
 =?us-ascii?Q?GXw5qkGPnZPxdMCSr+mmQO5Y9ki8hWAc6iP2HKnuu2ZDkIwQw7OR82tr2Sf9?=
 =?us-ascii?Q?cncngdZONoxR6MRW3PfiABFkGOXsy5jAuyxrUaxbtkpMu58KkT7s5vwJ4sjX?=
 =?us-ascii?Q?8uoBDq1Nr0bHcor88tN5BXwyD8+R7RBrTE3X27qsWP7T/TxFj35xEILhxdrL?=
 =?us-ascii?Q?A1NNHtyE1loDgxSYD2tffnb/96MXAr4SLXqzCxtu8duQ5dR8yVTfWOZ2MAt9?=
 =?us-ascii?Q?hySHGjBybiv5ShJPvNXrlA7LOPyNlicy9RIB4h6Rx4WT9sGnmeSZweGAyq87?=
 =?us-ascii?Q?qZKutSchmu9755c67LHzmYyDjwYLK1Dch7m+hoY2JlYFFNhRbgBOgFQYcdLr?=
 =?us-ascii?Q?9bXyoK8jFy3nMvSoEXdGAr9mdKBGc/vChQ0iiL2GNGcBHsLxsQEZHuyS9Vk8?=
 =?us-ascii?Q?ui7R0WGEJvScukjs7ka1yzbj7WKKfAgUXDQm41YM00OMlH4yBtyjfKBfhbsI?=
 =?us-ascii?Q?5I9hqWda11yAQM/pPWKI5xJYZlHbD3Xh+I1AM9GC1Gynu68LQOAZEwvX/MzE?=
 =?us-ascii?Q?BPuEvL22XFeCaib9xqhN0eG+yQUIBI74SckuMwNfMTGvm8XhlmpQQCXgpY3L?=
 =?us-ascii?Q?SsrPyXWzGsv171+OCO2gXKli9w0bO/2rYmxOkHFoChvzBJHq0b4dbTzd4OVS?=
 =?us-ascii?Q?7BNBgJ/wvzaW403QSp4nUOTFGh7pUWNfN2LvY4+ANGxvphwSG36JCQqyX1/f?=
 =?us-ascii?Q?ORKLOdL2FdBAz/BElKjuczPjEPxZBBrakfK2GgdnvTaxv5hWltFzHH7nWaTS?=
 =?us-ascii?Q?uk1kDbnnxRoZg0BsNCaaEXIh4lvT2OyD88rZ62K35AOe5cexxG8fPB1LtNRy?=
 =?us-ascii?Q?sxkTOR2OeEkuHE1GisM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:03:05.2337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b86b03d-559b-4381-9c2d-08de22ce2174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209

Kernel maps are encoded in PERF_RECORD_MMAP2 samples but "perf lock
report" and "perf lock contention" do not process MMAP2 samples.
Because of that, machine->vmlinux_map stays NULL and any later
access triggers a segmentation fault. Fix it by adding ->mmap2()
callbacks.

Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
Reported-by: Tycho Andersen (AMD) <tycho@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: Tycho Andersen (AMD) <tycho@kernel.org>
---
 tools/perf/builtin-lock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 078634461df2..e8962c985d34 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1867,6 +1867,7 @@ static int __cmd_report(bool display_info)
 	eops.sample		 = process_sample_event;
 	eops.comm		 = perf_event__process_comm;
 	eops.mmap		 = perf_event__process_mmap;
+	eops.mmap2		 = perf_event__process_mmap2;
 	eops.namespaces		 = perf_event__process_namespaces;
 	eops.tracing_data	 = perf_event__process_tracing_data;
 	session = perf_session__new(&data, &eops);
@@ -2023,6 +2024,7 @@ static int __cmd_contention(int argc, const char **argv)
 	eops.sample		 = process_sample_event;
 	eops.comm		 = perf_event__process_comm;
 	eops.mmap		 = perf_event__process_mmap;
+	eops.mmap2		 = perf_event__process_mmap2;
 	eops.tracing_data	 = perf_event__process_tracing_data;
 
 	perf_env__init(&host_env);
-- 
2.51.0

