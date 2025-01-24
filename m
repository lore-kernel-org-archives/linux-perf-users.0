Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7461D7E4B;
	Fri, 24 Jan 2025 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737698834; cv=fail; b=MCOhyyO/WHakbxgHHRjtoLdBz8QaTWdJj16jXiXaQFyKOS7NhTWoqkn9ecpz46qXDXddXcAdSqPVAkZ15uy1xEmArg9SFWQ2/U3riKMBucRJy4HyI++W8Hx4IsRN5HHFFIEhyubxKjgT6KFmP4iUF5Pu3pOnOhjGbx+FYq9ta8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737698834; c=relaxed/simple;
	bh=lRbQp7TMqaxwPY75yFSEL8TMJ3gZ+tPUTE9KNlOjMY8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NEsme6Uy2e4Hkw/Z5KYd4AQJUn+IBH0aiOXGwIQeP5CFEgeHBKvM7v2Umf+GyUUPfEFyHhkyiuAZdzmUkpAwoVMtoiSoVQHXeRdnsbQDh0qxjdwVkONQLOA+0k/z74+afsOlguIv0nOFuCuG5zZ2Y3jxRf4jXKEfFBigD3xRIxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cbboM+mx; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cbboM+mx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/nTV2Jm+v2d4uCSlomC840loALPC+cXzvemWl1bYYVSI9hnHxjIh9/Ljyzk8Ncv+lFGjmTGNv/vyO9rIosrweqJ1urXs5WVSnBntU2ROI0YS1BKZp5Ww4tYmVyJnFcFetQZxyvuysQonp3UZSseR4WBpZ5xuKprNdYkZRp40ZatUkf3Xg0pTaC4Ed8pw8EOuV4MFI3vS+l6IJO7sfbHdPrPEbbarr/Xkqk7NErsrLZzVoYwKgFoLEHANCakyBaUbYty5QLhd+pe+Bv3FtGG/GiKrzYxlB+Z5Nh3oZc5zXCr5wso1igtolizr25WcLAGOnpYbr72gRN4Bt8qfeHo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15KxesTwNAl60UwYujnVhI6pBGVqXZ0t6PoNEA27Qc4=;
 b=unYQkArZ2BW2/Gbpw/K7iBWdlRyBDQdVx/cxXSg3IPcINqfZyHS4ijCWO0hDwV6o5W913KhsXSHL5nXxcuRqgQ/pMgSookGDG0BYBZuvJEMX2juR8CfJ4QC3oYO6W7XuKplPNjkwUDTAZRJVtH1Mo8yVULR8z/WCckUakrMsGVvW3hQvj+fuOYNNf5gA/jruTs1ytHXZ3u22/cg73U4J3QX4mSJjw4QhO7uyiY0BKs5g0SDO5h/YSaY87hUjXJh+eM18ALVARGWTccl/8w9nG4Z1ZvFKUpqC2RlWPyfj8uoJAeYPMwLtYTnS3JbolZWCT3oPJjzLZrplSlhAzPEvzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15KxesTwNAl60UwYujnVhI6pBGVqXZ0t6PoNEA27Qc4=;
 b=cbboM+mxm79zn3YEIBO0T92YQxUIc2x/1MJEUv7SgEw/XK3PffdYzVv8UJ62vEYnWRdVnRl+8VzmDm49pCtan9KqdP8sULA6Gcag8htcVP2JZLqAWse9dk1iQV9SNTetWoQDW6Vc2lHwv0seE8Pph8lrnVesjLaUbDvq+Z9wiEk=
Received: from SA0PR11CA0040.namprd11.prod.outlook.com (2603:10b6:806:d0::15)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Fri, 24 Jan
 2025 06:07:04 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::b8) by SA0PR11CA0040.outlook.office365.com
 (2603:10b6:806:d0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Fri,
 24 Jan 2025 06:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 24 Jan 2025 06:07:01 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Jan
 2025 00:06:56 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <acme@kernel.org>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<eranian@google.com>, <irogers@google.com>, <kan.liang@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>,
	<alexander.shishkin@linux.intel.com>, <bp@alien8.de>, <mark.rutland@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [RFC] perf script AMD/IBS: Add scripts to show function/instruction level granular profile
Date: Fri, 24 Jan 2025 06:06:38 +0000
Message-ID: <20250124060638.905-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f285e5-af46-4efb-5f8c-08dd3c3d51dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cxMKE6ApWYt63PKpGSTvuAXluiMB3uXYFOc2+JzLTOFVLJ0dTYdjZXfDGEkq?=
 =?us-ascii?Q?ucvMwDZpeO3qt2IgU9QLMNZzBoeaoTP4rdQNljnsmrZWt3EGyV9IYoiWCm/n?=
 =?us-ascii?Q?1AkC2Q+wQbFImp827LZWmvUnY2t7IM57QA+ot1wH+GB+bSFrcmes03OHnNUA?=
 =?us-ascii?Q?JQu8hVL0Khp08U0nXZDrSqZaMfTARLR9FrQ60Hz+WbSdLxeojpqf3riGAaf7?=
 =?us-ascii?Q?pt2SIkiqB+spo5ti+aQ/ezJB5DdNK+bsTfJZyBgb+kv40Ldjl+t6YOgVyMtd?=
 =?us-ascii?Q?xmTG0kOoMAJpxxL7B9Kw23OpVBJRB8S9HM1QSkepDZXQ0y8gvfF/2GnRWCi6?=
 =?us-ascii?Q?/FAN1xcPQzqhIjQaQOL131a5pvHp/OsRIkq+OtkYOSjCxmeLE45mQlRay5xU?=
 =?us-ascii?Q?azyZBY+hXExzc+6UbrLYOGsaS75LGDJyYTOF6+tR7z3U4yCBTYO38ymSvwg5?=
 =?us-ascii?Q?0G0aD1RLybREHlQUXriFX52exZkluuIQyxovS0pH1sCFmekwBUl6KJzbUFZU?=
 =?us-ascii?Q?mbf2R5z4J4jEeikVvoRF5Ml8zX1FKbGgHfarh2zkt5zpxFinWGbzxyzeve3y?=
 =?us-ascii?Q?4bMBzXNcz99RIs5sKJpVAL4iuwHlDs2VAFIztzykDebkSVV21wc2raV/+sje?=
 =?us-ascii?Q?AVQkHRdrJa0WCNDeRBuH7uITsM8ef7yw2xwAskH1C27lFk09MDOof0bUj/PT?=
 =?us-ascii?Q?IHgAsFRiNez0V6SHtvDxHXdK8i59EXysg9z/tJBTC1RPA0vBmiAf5JcwPMqg?=
 =?us-ascii?Q?B7OqaqoqZ/CaATOYSX8Cr0Z1XNbTmwmgdXWQ1NDYp/rYvT155N7FY05qZq3z?=
 =?us-ascii?Q?Qjwafr5ITJJZ23ejkyqkEspPbIs1qH73PWfgRQx627m1KCPnIw07Pi788fE1?=
 =?us-ascii?Q?5lfDv/jNY463s7jjKGOcecG/T97LO/oGK6+WWMYuCoorzlT5BDK9IkEFe9mH?=
 =?us-ascii?Q?bh0B4ydprVfbN27vItabCBExw1tCv6rk/O3bBg44tNwBLrm06lPM4xARKl0C?=
 =?us-ascii?Q?fwvVT6waGe3BaBi5CsOywaOwvIYo5ncYukG/oom5TxfJT+8RtQlZM525cQ60?=
 =?us-ascii?Q?CFiOE3O1IYbHS0cqYjrXgqeCe7qEh8Y0xU8trT1wbmhakWLQn3vdxI13bUni?=
 =?us-ascii?Q?OKkojxxn9QVSFG+XsdU/H1ZihORVecHXDmNtsUTd+O/rhNHm0wTlzoaMHV7g?=
 =?us-ascii?Q?GUDyyAzcbtkGz5Bg/w0FiR5vQ2qBHP8bi4pOxwmy6wUcVxUGAYOfd4daXuAk?=
 =?us-ascii?Q?kqSbZ7ZJudaibQd3Y2EhNxHewculuI6+1hG96bp2pUqOjysfL7BKjqkNY9OW?=
 =?us-ascii?Q?QhG6SfsJcgFbN+6CZ41BdtJcjIGplR/zXDIqeeA/qxGBmLeRTOJvhsu6ff9j?=
 =?us-ascii?Q?3O9fvKrTzbVhwQ9um/vskqJ8gTLs1no2wvfak3wMq4sH1vEUSl96WLzQxkIy?=
 =?us-ascii?Q?S8vyaXoef5C9HB5Se6BMTctxC39sa5ud8smaN3g4aI/eWJbhOnDP7n4eA1aY?=
 =?us-ascii?Q?FiIbHlDgqgdeVLY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 06:07:01.9765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f285e5-af46-4efb-5f8c-08dd3c3d51dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602

AMD IBS (Instruction Based Sampling) PMUs provides various insights
about instruction execution through front-end and back-end units.
Various perf tools (e.g. precise-mode (:p), perf-mem, perf-c2c etc.)
uses portion of these information but lot of other insightful data are
still remains unused by perf. I could not think of any generic perf
tool where I can consolidate and show all these data, so thought to
add perf-python scripts.

1) amd-ibs-op-metrics.py: Print various back-end metric events at
   function granularity using AMD IBS Op PMU.
2) amd-ibs-op-metrics-annotate.py: Print various back-end metric events
   at instruction granularity using AMD IBS Op PMU.
3) amd-ibs-fetch-metrics.py: Print various front-end metric events at
   function granularity using AMD IBS Fetch PMU.
   (Annotate script can be added for Fetch PMU as well).

This is still early prototype and thus lot of rough edges. Please feel
free to report bugs/enhancements if you find these to be useful.

Example usage:

IBS Op:

  # perf record -a -e ibs_op// -c 1000000 --raw-sample -- make
  [ perf record: Woken up 91 times to write data ]
  [ perf record: Captured and wrote 49.926 MB perf.data (386979 samples) ]

  # perf script -s amd-ibs-op-metrics.py -- --sort=dc_miss,l2_miss | head -15
  Sort Order: dc_miss,l2_miss
  Percentages: Cache miss and TLB miss %es are wrt NrLdSt not NrSamples
                                               |      Nr |      Nr                                                          90th     Avg |  L1Dtlb            L2Dtlb              90th     Avg |          Branch           |
  function                                     | Samples |    LdSt  DcMiss       (%)  L2Miss       (%)  L3Miss       (%)  PctLat     Lat |    Miss       (%)    Miss       (%)  PctLat     Lat |    Miss/Retired       (%) | dso
  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  clear_page_erms [K]                          |    6704 |    6059    4767 ( 78.68%)    4085 ( 67.42%)    4027 ( 66.46%)       0       0 |      13 (  0.21%)       4 (  0.07%)      76      80 |       0/5       (  0.00%) | [kernel.kallsyms]
  __memmove_avx512_unaligned_erms [U]          |    6274 |    2461    1298 ( 52.74%)    1099 ( 44.66%)     725 ( 29.46%)     465     265 |     996 ( 40.47%)     668 ( 27.14%)     137      88 |      53/2032    (  2.61%) | /usr/lib/x86_64-linux-gnu/libc.so.6
  __memset_avx512_unaligned_erms [U]           |    2759 |    1343     664 ( 49.44%)     345 ( 25.69%)     143 ( 10.65%)       0       0 |     122 (  9.08%)      20 (  1.49%)      94      44 |      20/317     (  6.31%) | /usr/lib/x86_64-linux-gnu/libc.so.6
  _copy_to_iter [K]                            |     918 |     640     351 ( 54.84%)     231 ( 36.09%)     163 ( 25.47%)    1341     391 |      13 (  2.03%)       5 (  0.78%)    1567     369 |       0/3       (  0.00%) | [kernel.kallsyms]
  pop_scope [U]                                |    1648 |     960     302 ( 31.46%)     258 ( 26.88%)     224 ( 23.33%)    1515     493 |      59 (  6.15%)      15 (  1.56%)     782     205 |       6/534     (  1.12%) | /usr/libexec/gcc/x86_64-linux-gnu/13/cc1
  memset [K]                                   |     776 |     505     185 ( 36.63%)      61 ( 12.08%)      46 (  9.11%)       0       0 |       3 (  0.59%)       2 (  0.40%)    4985    2200 |       0/9       (  0.00%) | [kernel.kallsyms]
  _int_malloc [U]                              |    4534 |    1523     178 ( 11.69%)      43 (  2.82%)       6 (  0.39%)      40      25 |      88 (  5.78%)      12 (  0.79%)      84      42 |     103/1141    (  9.03%) | /usr/lib/x86_64-linux-gnu/libc.so.6
  ggc_internal_alloc [U]                       |    2891 |    1254     138 ( 11.00%)      78 (  6.22%)      45 (  3.59%)     905     267 |      80 (  6.38%)       1 (  0.08%)      10      17 |      16/448     (  3.57%) | /usr/libexec/gcc/x86_64-linux-gnu/13/cc1
  native_queued_spin_lock_slowpath [K]         |   36544 |   17736     125 (  0.70%)     124 (  0.70%)     115 (  0.65%)     695     390 |       0 (  0.00%)       0 (  0.00%)       0       0 |      18/17327   (  0.10%) | [kernel.kallsyms]
  get_mem_cgroup_from_mm [K]                   |     985 |     341     122 ( 35.78%)       9 (  2.64%)       1 (  0.29%)      23      19 |      74 ( 21.70%)       0 (  0.00%)       7       7 |       0/297     (  0.00%) | [kernel.kallsyms]

  o Default sort order is Nr Samples.
  o Cache misses and TLB misses percentages are wrt Nr LdSt. Branch
    miss percentages are wrt branches retired.
  o Use --help for more detail.

IBS Op Annotate:

  # perf script -s amd-ibs-op-metrics-annotate.py -- --dso=/home/ravi/linux/vmlinux --symbol=clear_page_erms
                                                   |      Nr |                                                                  90th     Avg |  L1Dtlb            L2Dtlb              90th     Avg |          Branch
  Disassembly                                      | Samples |    LdSt  DcMiss       (%)  L2Miss       (%)  L3Miss       (%)  PctLat     Lat |    Miss       (%)    Miss       (%)  PctLat     Lat |    Miss/Retired       (%)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  ffffffff821d3e10: mov    $0x1000,%ecx            |       6 |       0       0 (  0.00%)       0 (  0.00%)       0 (  0.00%)       0       0 |       0 (  0.00%)       0 (  0.00%)       0       0 |       0/0       (  0.00%)
  ffffffff821d3e15: xor    %eax,%eax               |       4 |       0       0 (  0.00%)       0 (  0.00%)       0 (  0.00%)       0       0 |       0 (  0.00%)       0 (  0.00%)       0       0 |       0/0       (  0.00%)
  ffffffff821d3e17: rep stos %al,%es:(%rdi)        |    6687 |    6059    4767 ( 78.68%)    4085 ( 67.42%)    4027 ( 66.46%)       0       0 |      13 (  0.21%)       4 (  0.07%)      76      80 |       0/0       (  0.00%)
  ffffffff821d3e19: jmp    ffffffff821f27a0        |       7 |       0       0 (  0.00%)       0 (  0.00%)       0 (  0.00%)       0       0 |       0 (  0.00%)       0 (  0.00%)       0       0 |       0/5       (  0.00%)
  Percentages: Cache miss and TLB miss %es are wrt NrLdSt not NrSamples
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  o Actual disassembly of the function, so data are not sorted.
  o Cache misses and TLB misses percentages are wrt Nr LdSt. Branch
    miss percentages are wrt branches retired.

IBS Fetch:

  # perf record -a -e ibs_fetch// -c 1000000 --raw-sample -- make
  [ perf record: Woken up 4 times to write data ]
  [ perf record: Captured and wrote 15.051 MB perf.data (112595 samples) ]

  # perf script -s amd-ibs-fetch-metrics.py -- --sort=ic_miss | head -15
  Sort Order: ic_miss
                                               |      Nr |                                                                            90th     Avg |   Fetch           |  L1Itlb            L2Itlb           |
  function                                     | Samples |  OcMiss       (%)  IcMiss       (%)  L2Miss       (%)  L3Miss       (%)  PctLat     Lat |   Abort       (%) |    Miss       (%)    Miss       (%) | dso
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  _int_malloc [U]                              |    1379 |     407 ( 29.51%)     130 (  9.43%)       1 (  0.07%)       0 (  0.00%)      20      14 |       0 (  0.00%) |      11 (  0.80%)       5 (  0.36%) | /usr/lib/x86_64-linux-gnu/libc.so.6
  _cpp_lex_direct [U]                          |    1621 |     133 (  8.20%)      35 (  2.16%)       1 (  0.06%)       0 (  0.00%)      26      16 |       0 (  0.00%) |       1 (  0.06%)       1 (  0.06%) | /usr/libexec/gcc/x86_64-linux-gnu/13/cc1
  mas_walk [K]                                 |     115 |      75 ( 65.22%)      33 ( 28.70%)       0 (  0.00%)       0 (  0.00%)      20      14 |       0 (  0.00%) |       0 (  0.00%)       0 (  0.00%) | [kernel.kallsyms]
  _int_free [U]                                |     598 |      83 ( 13.88%)      32 (  5.35%)       0 (  0.00%)       0 (  0.00%)      17      13 |       0 (  0.00%) |       5 (  0.84%)       3 (  0.50%) | /usr/lib/x86_64-linux-gnu/libc.so.6
  __libc_calloc [U]                            |     202 |      72 ( 35.64%)      31 ( 15.35%)       0 (  0.00%)       0 (  0.00%)      24      27 |       0 (  0.00%) |      10 (  4.95%)       6 (  2.97%) | /usr/lib/x86_64-linux-gnu/libc.so.6
  ggc_internal_alloc [U]                       |     516 |     102 ( 19.77%)      29 (  5.62%)       0 (  0.00%)       0 (  0.00%)      19      14 |       0 (  0.00%) |       6 (  1.16%)       4 (  0.78%) | /usr/libexec/gcc/x86_64-linux-gnu/13/cc1
  _int_free_merge_chunk [U]                    |     219 |      58 ( 26.48%)      29 ( 13.24%)       0 (  0.00%)       0 (  0.00%)      18      14 |       0 (  0.00%) |       4 (  1.83%)       0 (  0.00%) | /usr/lib/x86_64-linux-gnu/libc.so.6
  get_page_from_freelist [K]                   |      68 |      45 ( 66.18%)      28 ( 41.18%)       1 (  1.47%)       0 (  0.00%)      27      23 |       0 (  0.00%) |       0 (  0.00%)       0 (  0.00%) | [kernel.kallsyms]
  __handle_mm_fault [K]                        |      70 |      43 ( 61.43%)      26 ( 37.14%)       2 (  2.86%)       0 (  0.00%)      17      15 |       0 (  0.00%) |       0 (  0.00%)       0 (  0.00%) | [kernel.kallsyms]
  operand_compare::operand_equal_p [U]         |     364 |      82 ( 22.53%)      26 (  7.14%)       1 (  0.27%)       0 (  0.00%)      18      14 |       0 (  0.00%) |       8 (  2.20%)       6 (  1.65%) | /usr/libexec/gcc/x86_64-linux-gnu/13/cc1
  bitmap_set_bit [U]                           |    1917 |      81 (  4.23%)      25 (  1.30%)       0 (  0.00%)       0 (  0.00%)      23      15 |       0 (  0.00%) |      10 (  0.52%)       8 (  0.42%) | /usr/libexec/gcc/x86_64-linux-gnu/13/cc1

  o Default sort order is Nr Samples.
  o All percentages are wrt Nr Samples.
  o Use --help for more detail.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 .../scripts/python/amd-ibs-fetch-metrics.py   | 219 +++++++++++
 .../python/amd-ibs-op-metrics-annotate.py     | 342 ++++++++++++++++++
 .../perf/scripts/python/amd-ibs-op-metrics.py | 285 +++++++++++++++
 3 files changed, 846 insertions(+)
 create mode 100644 tools/perf/scripts/python/amd-ibs-fetch-metrics.py
 create mode 100644 tools/perf/scripts/python/amd-ibs-op-metrics-annotate.py
 create mode 100644 tools/perf/scripts/python/amd-ibs-op-metrics.py

diff --git a/tools/perf/scripts/python/amd-ibs-fetch-metrics.py b/tools/perf/scripts/python/amd-ibs-fetch-metrics.py
new file mode 100644
index 000000000000..63a91843585f
--- /dev/null
+++ b/tools/perf/scripts/python/amd-ibs-fetch-metrics.py
@@ -0,0 +1,219 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2025 Advanced Micro Devices, Inc.
+#
+# Print various metric events at function granularity using AMD IBS Fetch PMU.
+
+from __future__ import print_function
+
+import os
+import sys
+import re
+import numpy as np
+from optparse import OptionParser, make_option
+
+# To avoid BrokenPipeError when redirecting output to head/less etc.
+from signal import signal, SIGPIPE, SIG_DFL
+signal(SIGPIPE,SIG_DFL)
+
+# IBS FETCH CTL bit positions
+IBS_FETCH_CTL_FETCH_LAT_SHIFT       = 32
+IBS_FETCH_CTL_IC_MISS_SHIFT         = 51
+IBS_FETCH_CTL_L1_ITLB_MISS_SHIFT    = 55
+IBS_FETCH_CTL_L2_ITLB_MISS_SHIFT    = 56
+IBS_FETCH_CTL_L2_MISS_SHIFT         = 58
+IBS_FETCH_CTL_OC_MISS_SHIFT         = 60
+IBS_FETCH_CTL_L3_MISS_SHIFT         = 61
+IBS_FETCH_CTL_FETCH_COMP            = 50
+
+allowed_sort_keys = ("nr_samples", "oc_miss", "ic_miss", "l2_miss", "l3_miss", "abort", "l1_itlb_miss", "l2_itlb_miss")
+default_sort_order = ("nr_samples",) # Trailing comman is needed for single member tuple
+sort_order = default_sort_order
+options = None
+
+def parse_cmdline_options():
+    global sort_order
+    global options
+
+    option_list = [
+        make_option("-s", "--sort", dest="sort",
+                    help="Comma separated custom sort order. Allowed values: " +
+                         ", ".join(allowed_sort_keys))
+    ]
+
+    parser = OptionParser(option_list=option_list)
+    (options, args) = parser.parse_args()
+
+    if (options.sort):
+        sort_err = 0
+        temp = []
+        for sort_option in options.sort.split(","):
+            if sort_option not in allowed_sort_keys:
+                print("ERROR: Invalid sort option: %s" % sort_option)
+                print("       Falling back to default sort order.")
+                sort_err = 1
+                break
+            else:
+                temp.append(sort_option)
+
+        if (sort_err == 0):
+            sort_order = tuple(temp)
+
+parse_cmdline_options()
+
+data = {};
+
+def init_data_element(symbol, cpumode, dso):
+    # XXX: Should the key be dso:symbol ?
+    data[symbol] = {
+        'nr_samples': 0,
+        'cpumode': cpumode,
+
+        'oc_miss': 0,
+        'ic_miss': 0,
+        'l2_miss': 0,
+        'l3_miss': 0,
+        'lat': [],
+
+        'abort': 0,
+
+        'l1_itlb_miss': 0,
+        'l2_itlb_miss': 0,
+
+        # Misc data
+        'dso': dso,
+    }
+
+def get_cpumode(cpumode):
+    if (cpumode == 1):
+        return 'K'
+    if (cpumode == 2):
+        return 'U'
+    if (cpumode == 3):
+        return 'H'
+    if (cpumode == 4):
+        return 'GK'
+    if (cpumode == 5):
+        return 'GU'
+    return '?'
+
+def is_oc_miss(fetch_ctl):
+    return (fetch_ctl >> IBS_FETCH_CTL_OC_MISS_SHIFT) & 0x1
+
+def is_ic_miss(fetch_ctl):
+    return (fetch_ctl >> IBS_FETCH_CTL_IC_MISS_SHIFT) & 0x1
+
+def is_l2_miss(fetch_ctl):
+    return ((fetch_ctl >> IBS_FETCH_CTL_L2_MISS_SHIFT) & 0x1 and
+            (fetch_ctl >> IBS_FETCH_CTL_FETCH_COMP) & 0x1)
+
+def is_l3_miss(fetch_ctl):
+    return (fetch_ctl >> IBS_FETCH_CTL_L3_MISS_SHIFT) & 0x1
+
+def get_fetch_lat(fetch_ctl):
+    return (fetch_ctl >> IBS_FETCH_CTL_FETCH_LAT_SHIFT) & 0xffff
+
+def is_l1_itlb_miss(fetch_ctl):
+    return (fetch_ctl >> IBS_FETCH_CTL_L1_ITLB_MISS_SHIFT) & 0x1
+
+def is_l2_itlb_miss(fetch_ctl):
+    return (fetch_ctl >> IBS_FETCH_CTL_L2_ITLB_MISS_SHIFT) & 0x1
+
+def is_comp(fetch_ctl):
+    return (fetch_ctl >> IBS_FETCH_CTL_FETCH_COMP) & 0x1
+
+def process_event(param_dict):
+    raw_buf = param_dict['raw_buf']
+    fetch_ctl = int.from_bytes(raw_buf[4:12], "little")
+
+    if ('symbol' in param_dict):
+        symbol = param_dict['symbol']
+        symbol = re.sub(r'\(.*\)', '', symbol)
+    else:
+        symbol = hex(param_dict['sample']['ip'])
+
+    if (symbol not in data):
+        init_data_element(symbol, get_cpumode(param_dict['sample']['cpumode']),
+                          param_dict['dso'] if 'dso' in param_dict else "")
+
+    data[symbol]['nr_samples'] += 1
+
+    if (is_oc_miss(fetch_ctl)):
+        data[symbol]['oc_miss'] += 1
+        if (is_ic_miss(fetch_ctl)):
+            data[symbol]['ic_miss'] += 1
+            latency = get_fetch_lat(fetch_ctl)
+            data[symbol]['lat'].append(latency)
+            if (is_l2_miss(fetch_ctl)):
+                data[symbol]['l2_miss'] += 1
+                if (is_l3_miss(fetch_ctl)):
+                    data[symbol]['l3_miss'] += 1
+
+    if (is_l1_itlb_miss(fetch_ctl)):
+        data[symbol]['l1_itlb_miss'] += 1
+        if (is_l2_itlb_miss(fetch_ctl)):
+            data[symbol]['l2_itlb_miss'] += 1
+
+    if (is_comp(fetch_ctl) == 0):
+        data[symbol]['abort'] += 1
+
+def print_sort_order():
+    global sort_order
+    print("Sort Order: " + ",".join(sort_order))
+
+def print_header():
+    print_sort_order()
+    print("%-45s| %7s | %7s %9s %7s %9s %7s %9s %7s %9s %7s %7s | %7s %9s | %7s %9s %7s %9s | %s" %
+          ("","Nr", "", "", "", "", "", "", "", "", "90th", "Avg", "Fetch", "", "L1Itlb", "", "L2Itlb", "", ""))
+    print("%-45s| %7s | %7s %9s %7s %9s %7s %9s %7s %9s %7s %7s | %7s %9s | %7s %9s %7s %9s | %s" %
+          ("function", "Samples", "OcMiss", "(%)", "IcMiss", "(%)", "L2Miss", "(%)",
+           "L3Miss", "(%)", "PctLat", "Lat", "Abort", "(%)", "Miss", "(%)", "Miss", "(%)", "dso"))
+    print("-----------------------------------------------------------------------------"
+          "-----------------------------------------------------------------------------"
+          "------------------------------------------------------------------")
+
+def print_footer():
+    print("-----------------------------------------------------------------------------"
+          "-----------------------------------------------------------------------------"
+          "------------------------------------------------------------------")
+    print()
+
+def sort_fun(item):
+    global sort_order
+
+    temp = []
+    for sort_option in sort_order:
+        temp.append(item[1][sort_option])
+    return tuple(temp)
+
+def trace_end():
+    sorted_data = sorted(data.items(), key = sort_fun, reverse = True)
+
+    print_header()
+
+    for d in sorted_data:
+        symbol_cpumode = d[0] + " [" + d[1]['cpumode'] + "]"
+
+        oc_miss_perc = (d[1]['oc_miss'] * 100) / float(d[1]['nr_samples'])
+        ic_miss_perc = (d[1]['ic_miss'] * 100) / float(d[1]['nr_samples'])
+        l2_miss_perc = (d[1]['l2_miss'] * 100) / float(d[1]['nr_samples'])
+        l3_miss_perc = (d[1]['l3_miss'] * 100) / float(d[1]['nr_samples'])
+        abort_perc = (d[1]['abort'] * 100) / float(d[1]['nr_samples'])
+        l1_itlb_miss_perc = (d[1]['l1_itlb_miss'] * 100) / float(d[1]['nr_samples'])
+        l2_itlb_miss_perc = (d[1]['l2_itlb_miss'] * 100) / float(d[1]['nr_samples'])
+
+        avg_lat = 0
+        pct_lat = 0
+        if (d[1]['lat']):
+            avg_lat = sum(d[1]['lat']) / float(len(d[1]['lat']))
+            pct_lat = np.percentile(d[1]['lat'], 90)
+
+        print("%-45s| %7d | %7d (%6.2f%%) %7d (%6.2f%%) %7d (%6.2f%%) %7d (%6.2f%%)"
+              " %7d %7d | %7d (%6.2f%%) | %7d (%6.2f%%) %7d (%6.2f%%) | %s" %
+              (symbol_cpumode, d[1]['nr_samples'], d[1]['oc_miss'], oc_miss_perc,
+               d[1]['ic_miss'], ic_miss_perc, d[1]['l2_miss'], l2_miss_perc,
+               d[1]['l3_miss'], l3_miss_perc, pct_lat, avg_lat, d[1]['abort'],
+               abort_perc, d[1]['l1_itlb_miss'], l1_itlb_miss_perc,
+               d[1]['l2_itlb_miss'], l2_itlb_miss_perc, d[1]['dso']))
+
+    print_footer()
diff --git a/tools/perf/scripts/python/amd-ibs-op-metrics-annotate.py b/tools/perf/scripts/python/amd-ibs-op-metrics-annotate.py
new file mode 100644
index 000000000000..beef6a302258
--- /dev/null
+++ b/tools/perf/scripts/python/amd-ibs-op-metrics-annotate.py
@@ -0,0 +1,342 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2025 Advanced Micro Devices, Inc.
+#
+# Print various metric events at instruction granularity using AMD IBS Op PMU.
+
+from __future__ import print_function
+
+import os
+import sys
+import re
+import numpy as np
+from optparse import OptionParser, make_option
+import subprocess
+
+# To avoid BrokenPipeError when redirecting output to head/less etc.
+from signal import signal, SIGPIPE, SIG_DFL
+signal(SIGPIPE,SIG_DFL)
+
+# IBS OP DATA bit positions
+IBS_OPDATA_BR_TAKEN_SHIFT       = 35
+IBS_OPDATA_BR_MISS_SHIFT        = 36
+IBS_OPDATA_BR_RET_SHIFT         = 37
+
+# IBS OP DATA2 bit positions
+IBS_OPDATA2_DATA_SRC_LOW_SHIFT  = 0
+IBS_OPDATA2_DATA_SRC_HIGH_SHIFT = 6
+
+# IBS OP DATA3 bit positions
+IBS_OPDATA3_LDOP_SHIFT          = 0
+IBS_OPDATA3_STOP_SHIFT          = 1
+IBS_OPDATA3_L1_DTLB_MISS_SHIFT  = 2
+IBS_OPDATA3_L2_DTLB_MISS_SHIFT  = 3
+IBS_OPDATA3_DC_MISS_SHIFT       = 7
+IBS_OPDATA3_L2_MISS_SHIFT       = 20
+IBS_OPDATA3_DC_MISS_LAT_SHIFT   = 32
+IBS_OPDATA3_PHYADDR_VAL_SHIFT   = 18
+IBS_OPDATA3_DTLB_MISS_LAT_SHIFT = 48
+
+INSN_SIZE_INVAL = -1
+
+annotate_symbol = None
+annodate_dso = None
+
+#total_samples = 0
+data = []
+
+def parse_cmdline_options():
+    global annotate_symbol
+    global annodate_dso
+    global sort_order
+    global options
+
+    option_list = [
+        make_option("-d", "--dso", dest="dso",
+                    help="Path of binary or a library the symbol belongs to"),
+        make_option("-s", "--symbol", dest="symbol",
+                    help="Symbol name")
+    ]
+
+    parser = OptionParser(option_list=option_list)
+    (options, args) = parser.parse_args()
+
+    if (options.dso):
+        annodate_dso = options.dso
+    else:
+        print("Error: Invalid dso path.\n")
+        exit()
+
+    if (options.symbol):
+        annotate_symbol = options.symbol
+    else:
+        print("Error: Invalid symbol.\n")
+        exit()
+
+def disassemble_symbol(symbol, dso):
+    global data
+
+    readelf = subprocess.Popen(["readelf", "-WsC", "--sym-base=16", dso],
+                               stdout=subprocess.PIPE, text=True)
+    grep = subprocess.Popen(["grep", "-w", symbol], stdin=readelf.stdout,
+                            stdout=subprocess.PIPE, text=True)
+    output, error = grep.communicate()
+
+    if (error != None):
+        print("Error reading symbol table data for '%s'" % (symbol))
+        exit()
+
+    match = re.search(r'([^\s]+):\s([^\s]+)\s([^\s]+)\s([^\s]+)\s+([^\s]+)\s([^\s]+)\s+([^\s]+)\s([^\s]+)', output)
+    if (match == None):
+        print("Can not find start address / size of '%s'" % (symbol))
+        exit()
+
+    start_addr = int(match.group(2), 16)
+    size = int(match.group(3), 16)
+    stop_addr = start_addr + size
+
+    objdump = subprocess.run(["objdump", "-d", "-C", "--no-show-raw-insn",
+                              "--start-address", hex(start_addr), "--stop-address",
+                              hex(stop_addr), dso], capture_output = True, text = True)
+    if (objdump.returncode == 1):
+        print("Error dissassembling '%s'" % (symbol))
+        exit()
+
+    disasm = objdump.stdout.split("\n")
+
+    header_lines = 1
+    # hex(<number>) will convert <number> to hex with 0x prefix. But objdump
+    # addresses skips 0x, so use alternative format(<number>, 'x') which
+    # converts <number> to hex without 0x prefix.
+    start_addr_regex = r"^\s*" + format(start_addr, 'x') + r":"
+    idx = 0;
+    for line in disasm:
+        if (header_lines and (not re.match(start_addr_regex, line))):
+            continue
+        header_lines = 0
+
+        match = re.search(r'\s*([^:]+):[\t\s]+(.*)', line)
+        if (match == None):
+            continue
+
+        addr = int(match.group(1), 16)
+        offset = addr - start_addr
+        insn = re.sub(r'(<.*>)|(\s+#.*)|(\s+$)', '', match.group(2))
+
+        data.append({
+            'addr': addr,
+            'insn_size': INSN_SIZE_INVAL,
+            'symoff': offset,
+            'insn': insn,
+
+            'nr_samples': 0,
+
+            # Branch data
+            'br_ret': 0,
+            'br_miss': 0,
+            'br_taken': 0,
+            'br_fallth': 0,
+
+            # Load / Store data
+            'ld_cnt': 0, # LdOp=1 && StOp=1 are only added int ld_cnt
+            'st_cnt': 0,
+            'dc_miss': 0,
+            'l2_miss': 0,
+            'l3_miss': 0,
+            # XXX: Breakdown beyond L3 ?
+            'dc_miss_lat': [],
+
+            'l1_dtlb_miss': 0,
+            'l2_dtlb_miss': 0,
+            'dtlb_miss_lat': [],
+        })
+
+        if (idx > 0):
+            data[idx - 1]['insn_size'] = (data[idx]['addr'] -
+                                          data[idx - 1]['addr']);
+        idx += 1
+
+parse_cmdline_options()
+disassemble_symbol(annotate_symbol, annodate_dso)
+
+def get_cpumode(cpumode):
+    if (cpumode == 1):
+        return 'K'
+    if (cpumode == 2):
+        return 'U'
+    if (cpumode == 3):
+        return 'H'
+    if (cpumode == 4):
+        return 'GK'
+    if (cpumode == 5):
+        return 'GU'
+    return '?'
+
+def is_br_ret(op_data):
+    return (op_data >> IBS_OPDATA_BR_RET_SHIFT) & 0x1
+
+def is_br_miss(op_data):
+    return (op_data >> IBS_OPDATA_BR_MISS_SHIFT) & 0x1
+
+def is_br_taken(op_data):
+    return (op_data >> IBS_OPDATA_BR_TAKEN_SHIFT) & 0x1
+
+def is_ld_op(op_data3):
+    return (op_data3 >> IBS_OPDATA3_LDOP_SHIFT) & 0x1
+
+def is_st_op(op_data3):
+    return (op_data3 >> IBS_OPDATA3_STOP_SHIFT) & 0x1
+
+def is_dc_miss(op_data3):
+    return (op_data3 >> IBS_OPDATA3_DC_MISS_SHIFT) & 0x1
+
+def get_dc_miss_lat(op_data3):
+    return (op_data3 >> IBS_OPDATA3_DC_MISS_LAT_SHIFT) & 0xffff
+
+def is_l2_miss(op_data3):
+    return (op_data3 >> IBS_OPDATA3_L2_MISS_SHIFT) & 0x1
+
+def get_data_src(op_data2):
+    data_src_high = (op_data2 >> IBS_OPDATA2_DATA_SRC_HIGH_SHIFT) & 0x3
+    data_src_low = (op_data2 >> IBS_OPDATA2_DATA_SRC_LOW_SHIFT) & 0x7
+    return (data_src_high << 3) | data_src_low
+
+def is_phy_addr_val(op_data3):
+    return (op_data3 >> IBS_OPDATA3_PHYADDR_VAL_SHIFT) & 0x1
+
+def is_l1_dtlb_miss(op_data3):
+    return (op_data3 >> IBS_OPDATA3_L1_DTLB_MISS_SHIFT) & 0x1
+
+def get_dtlb_miss_lat(op_data3):
+    return (op_data3 >> IBS_OPDATA3_DTLB_MISS_LAT_SHIFT) & 0xffff
+
+def is_l2_dtlb_miss(op_data3):
+    return (op_data3 >> IBS_OPDATA3_L2_DTLB_MISS_SHIFT) & 0x1
+
+def process_event(param_dict):
+    global data
+
+    raw_buf = param_dict['raw_buf']
+    op_data = int.from_bytes(raw_buf[20:28], "little")
+    op_data2 = int.from_bytes(raw_buf[28:36], "little")
+    op_data3 = int.from_bytes(raw_buf[36:44], "little")
+
+    if ('symbol' not in param_dict):
+        return
+
+    symbol = param_dict['symbol']
+    symbol = re.sub(r'\(.*\)', '', symbol)
+
+    if (symbol != annotate_symbol):
+        return
+
+    symoff = 0
+    if ('symoff' in param_dict):
+        symoff = param_dict['symoff']
+
+    idx = 0
+    for d in data:
+        if (d['symoff'] <= symoff and
+            (d['insn_size'] == INSN_SIZE_INVAL or
+             d['symoff'] + d['insn_size'] > symoff)):
+            break
+        else:
+            idx += 1
+
+    d = data[idx]
+
+    d['nr_samples'] += 1
+    #total_samples += 1
+
+    if (is_br_ret(op_data)):
+        d['br_ret'] += 1
+        if (is_br_miss(op_data)):
+            d['br_miss'] += 1
+        if (is_br_taken(op_data)):
+            d['br_taken'] += 1
+
+    ld_st = 0
+    if (is_ld_op(op_data3)):
+        d['ld_cnt'] += 1
+        ld_st = 1
+    elif (is_st_op(op_data3)):
+        d['st_cnt'] += 1
+        ld_st = 1
+
+    if (ld_st == 1):
+        if (is_dc_miss(op_data3)):
+            d['dc_miss'] += 1
+            dc_miss_lat = get_dc_miss_lat(op_data3)
+            d['dc_miss_lat'].append(dc_miss_lat)
+            if (is_l2_miss(op_data3)):
+                d['l2_miss'] += 1
+                if (get_data_src(op_data2) > 1):
+                    d['l3_miss'] += 1
+        if (is_phy_addr_val(op_data3)):
+            if (is_l1_dtlb_miss(op_data3)):
+                d['l1_dtlb_miss'] += 1
+                dtlb_miss_lat = get_dtlb_miss_lat(op_data3)
+                d['dtlb_miss_lat'].append(dtlb_miss_lat)
+                if (is_l2_dtlb_miss(op_data3)):
+                    d['l2_dtlb_miss'] += 1
+
+def print_header():
+    addr_width = len(format(data[0]['addr'], 'x')) + 32
+    pattern = ("%-" + str(addr_width) + "s | %7s | %7s %7s %9s %7s %9s %7s %9s %7s"
+               " %7s | %7s %9s %7s %9s %7s %7s | %15s %9s")
+    print(pattern % ("", "Nr", "", "", "", "", "", "", "", "90th", "Avg", "L1Dtlb", "",
+                    "L2Dtlb", "", "90th", "Avg", "Branch", ""))
+    print(pattern % ("Disassembly", "Samples", "LdSt", "DcMiss", "(%)", "L2Miss", "(%)",
+                     "L3Miss", "(%)", "PctLat", "Lat", "Miss", "(%)", "Miss", "(%)",
+                     "PctLat", "Lat", "Miss/Retired", "(%)"))
+    print("--------------------------------------------------------------------------------------"
+          "--------------------------------------------------------------------------------------"
+          "------------------------------------------------")
+
+def print_footer():
+    print("Percentages: Cache miss and TLB miss %es are wrt NrLdSt not NrSamples")
+    print("--------------------------------------------------------------------------------------"
+          "--------------------------------------------------------------------------------------"
+          "------------------------------------------------")
+def trace_end():
+    global data
+
+    print_header()
+
+    for d in data:
+        dc_miss_perc = 0
+        l2_miss_perc = 0
+        l3_miss_perc = 0
+        l1_dtlb_miss_perc = 0
+        l2_dtlb_miss_perc = 0
+        avg_dc_miss_lat = 0
+        pct_dc_miss_lat = 0
+        avg_dtlb_miss_lat = 0
+        pct_dtlb_miss_lat = 0
+        if (d['ld_cnt'] or d['st_cnt']):
+            dc_miss_perc = (d['dc_miss'] * 100) / float(d['ld_cnt'] + d['st_cnt'])
+            l2_miss_perc = (d['l2_miss'] * 100) / float(d['ld_cnt'] + d['st_cnt'])
+            l3_miss_perc = (d['l3_miss'] * 100) / float(d['ld_cnt'] + d['st_cnt'])
+            l1_dtlb_miss_perc = (d['l1_dtlb_miss'] * 100) / float(d['ld_cnt'] + d['st_cnt'])
+            l2_dtlb_miss_perc = (d['l2_dtlb_miss'] * 100) / float(d['ld_cnt'] + d['st_cnt'])
+            if (d['dc_miss_lat']):
+                avg_dc_miss_lat = sum(d['dc_miss_lat']) / float(len(d['dc_miss_lat']))
+                pct_dc_miss_lat = np.percentile(d['dc_miss_lat'], 90)
+            if (d['dtlb_miss_lat']):
+                avg_dtlb_miss_lat = sum(d['dtlb_miss_lat']) / float(len(d['dtlb_miss_lat']))
+                pct_dtlb_miss_lat = np.percentile(d['dtlb_miss_lat'], 90)
+
+        br_miss_perc = 0
+        if (d['br_ret']):
+            br_miss_perc = (d['br_miss'] * 100) / float(d['br_ret'])
+
+        print("%x: %-30s | %7d | %7d %7d (%6.2f%%) %7d (%6.2f%%) %7d (%6.2f%%)"
+              " %7d %7d | %7d (%6.2f%%) %7d (%6.2f%%) %7d %7d | %7d/%-7d (%6.2f%%)" %
+              (d['addr'], d['insn'], d['nr_samples'], d['ld_cnt'] + d['st_cnt'],
+               d['dc_miss'], dc_miss_perc, d['l2_miss'], l2_miss_perc,
+               d['l3_miss'], l3_miss_perc, pct_dc_miss_lat, avg_dc_miss_lat,
+               d['l1_dtlb_miss'], l1_dtlb_miss_perc, d['l2_dtlb_miss'],
+               l2_dtlb_miss_perc, pct_dtlb_miss_lat, avg_dtlb_miss_lat,
+               d['br_miss'], d['br_ret'], br_miss_perc))
+
+    print_footer()
diff --git a/tools/perf/scripts/python/amd-ibs-op-metrics.py b/tools/perf/scripts/python/amd-ibs-op-metrics.py
new file mode 100644
index 000000000000..67c0b2f9d79a
--- /dev/null
+++ b/tools/perf/scripts/python/amd-ibs-op-metrics.py
@@ -0,0 +1,285 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2025 Advanced Micro Devices, Inc.
+#
+# Print various metric events at function granularity using AMD IBS Op PMU.
+
+from __future__ import print_function
+
+import os
+import sys
+import re
+import numpy as np
+from optparse import OptionParser, make_option
+
+# To avoid BrokenPipeError when redirecting output to head/less etc.
+from signal import signal, SIGPIPE, SIG_DFL
+signal(SIGPIPE,SIG_DFL)
+
+# IBS OP DATA bit positions
+IBS_OPDATA_BR_TAKEN_SHIFT       = 35
+IBS_OPDATA_BR_MISS_SHIFT        = 36
+IBS_OPDATA_BR_RET_SHIFT         = 37
+
+# IBS OP DATA2 bit positions
+IBS_OPDATA2_DATA_SRC_LOW_SHIFT  = 0
+IBS_OPDATA2_DATA_SRC_HIGH_SHIFT = 6
+
+# IBS OP DATA3 bit positions
+IBS_OPDATA3_LDOP_SHIFT          = 0
+IBS_OPDATA3_STOP_SHIFT          = 1
+IBS_OPDATA3_L1_DTLB_MISS_SHIFT  = 2
+IBS_OPDATA3_L2_DTLB_MISS_SHIFT  = 3
+IBS_OPDATA3_DC_MISS_SHIFT       = 7
+IBS_OPDATA3_L2_MISS_SHIFT       = 20
+IBS_OPDATA3_DC_MISS_LAT_SHIFT   = 32
+IBS_OPDATA3_PHYADDR_VAL_SHIFT   = 18
+IBS_OPDATA3_DTLB_MISS_LAT_SHIFT = 48
+
+allowed_sort_keys = ("nr_samples", "dc_miss", "l2_miss", "l3_miss", "l1_dtlb_miss", "l2_dtlb_miss", "br_miss")
+default_sort_order = ("nr_samples",) # Trailing comman is needed for single member tuple
+sort_order = default_sort_order
+options = None
+
+def parse_cmdline_options():
+    global sort_order
+    global options
+
+    option_list = [
+        make_option("-s", "--sort", dest="sort",
+                    help="Comma separated custom sort order. Allowed values: " +
+                         ", ".join(allowed_sort_keys))
+    ]
+
+    parser = OptionParser(option_list=option_list)
+    (options, args) = parser.parse_args()
+
+    if (options.sort):
+        sort_err = 0
+        temp = []
+        for sort_option in options.sort.split(","):
+            if sort_option not in allowed_sort_keys:
+                print("ERROR: Invalid sort option: %s" % sort_option)
+                print("       Falling back to default sort order.")
+                sort_err = 1
+                break
+            else:
+                temp.append(sort_option)
+
+        if (sort_err == 0):
+            sort_order = tuple(temp)
+
+parse_cmdline_options()
+
+# Final data
+data = {}
+
+def init_data_element(symbol, cpumode, dso):
+    # XXX: Should the key be dso:symbol ?
+    data[symbol] = {
+        'nr_samples': 0,
+        'cpumode': cpumode,
+
+        # Branch data
+        'br_ret': 0,
+        'br_miss': 0,
+        'br_taken': 0,
+        'br_fallth': 0,
+
+        # Load / Store data
+        'ld_cnt': 0, # LdOp=1 && StOp=1 are only added int ld_cnt
+        'st_cnt': 0,
+        'dc_miss': 0,
+        'l2_miss': 0,
+        'l3_miss': 0,
+        # XXX: Breakdown beyond L3 ?
+        'dc_miss_lat': [],
+
+        'l1_dtlb_miss': 0,
+        'l2_dtlb_miss': 0,
+        'dtlb_miss_lat': [],
+
+        # Misc data
+        'dso': dso,
+    }
+
+def get_cpumode(cpumode):
+    if (cpumode == 1):
+        return 'K'
+    if (cpumode == 2):
+        return 'U'
+    if (cpumode == 3):
+        return 'H'
+    if (cpumode == 4):
+        return 'GK'
+    if (cpumode == 5):
+        return 'GU'
+    return '?'
+
+def is_br_ret(op_data):
+    return (op_data >> IBS_OPDATA_BR_RET_SHIFT) & 0x1
+
+def is_br_miss(op_data):
+    return (op_data >> IBS_OPDATA_BR_MISS_SHIFT) & 0x1
+
+def is_br_taken(op_data):
+    return (op_data >> IBS_OPDATA_BR_TAKEN_SHIFT) & 0x1
+
+def is_ld_op(op_data3):
+    return (op_data3 >> IBS_OPDATA3_LDOP_SHIFT) & 0x1
+
+def is_st_op(op_data3):
+    return (op_data3 >> IBS_OPDATA3_STOP_SHIFT) & 0x1
+
+def is_dc_miss(op_data3):
+    return (op_data3 >> IBS_OPDATA3_DC_MISS_SHIFT) & 0x1
+
+def get_dc_miss_lat(op_data3):
+    return (op_data3 >> IBS_OPDATA3_DC_MISS_LAT_SHIFT) & 0xffff
+
+def is_l2_miss(op_data3):
+    return (op_data3 >> IBS_OPDATA3_L2_MISS_SHIFT) & 0x1
+
+def get_data_src(op_data2):
+    data_src_high = (op_data2 >> IBS_OPDATA2_DATA_SRC_HIGH_SHIFT) & 0x3
+    data_src_low = (op_data2 >> IBS_OPDATA2_DATA_SRC_LOW_SHIFT) & 0x7
+    return (data_src_high << 3) | data_src_low
+
+def is_phy_addr_val(op_data3):
+    return (op_data3 >> IBS_OPDATA3_PHYADDR_VAL_SHIFT) & 0x1
+
+def is_l1_dtlb_miss(op_data3):
+    return (op_data3 >> IBS_OPDATA3_L1_DTLB_MISS_SHIFT) & 0x1
+
+def get_dtlb_miss_lat(op_data3):
+    return (op_data3 >> IBS_OPDATA3_DTLB_MISS_LAT_SHIFT) & 0xffff
+
+def is_l2_dtlb_miss(op_data3):
+    return (op_data3 >> IBS_OPDATA3_L2_DTLB_MISS_SHIFT) & 0x1
+
+def process_event(param_dict):
+    raw_buf = param_dict['raw_buf']
+    op_data = int.from_bytes(raw_buf[20:28], "little")
+    op_data2 = int.from_bytes(raw_buf[28:36], "little")
+    op_data3 = int.from_bytes(raw_buf[36:44], "little")
+
+    if ('symbol' in param_dict):
+        symbol = param_dict['symbol']
+        symbol = re.sub(r'\(.*\)', '', symbol)
+    else:
+        symbol = hex(param_dict['sample']['ip'])
+
+    if (symbol not in data):
+        init_data_element(symbol, get_cpumode(param_dict['sample']['cpumode']),
+                          param_dict['dso'] if 'dso' in param_dict else "")
+
+    data[symbol]['nr_samples'] += 1
+
+    if (is_br_ret(op_data)):
+        data[symbol]['br_ret'] += 1
+        if (is_br_miss(op_data)):
+            data[symbol]['br_miss'] += 1
+        if (is_br_taken(op_data)):
+            data[symbol]['br_taken'] += 1
+
+    ld_st = 0
+    if (is_ld_op(op_data3)):
+        data[symbol]['ld_cnt'] += 1
+        ld_st = 1
+    elif (is_st_op(op_data3)):
+        data[symbol]['st_cnt'] += 1
+        ld_st = 1
+
+    if (ld_st == 1):
+        if (is_dc_miss(op_data3)):
+            data[symbol]['dc_miss'] += 1
+            dc_miss_lat = get_dc_miss_lat(op_data3)
+            data[symbol]['dc_miss_lat'].append(dc_miss_lat)
+            if (is_l2_miss(op_data3)):
+                data[symbol]['l2_miss'] += 1
+                if (get_data_src(op_data2) > 1):
+                    data[symbol]['l3_miss'] += 1
+        if (is_phy_addr_val(op_data3)):
+            if (is_l1_dtlb_miss(op_data3)):
+                data[symbol]['l1_dtlb_miss'] += 1
+                dtlb_miss_lat = get_dtlb_miss_lat(op_data3)
+                data[symbol]['dtlb_miss_lat'].append(dtlb_miss_lat)
+                if (is_l2_dtlb_miss(op_data3)):
+                    data[symbol]['l2_dtlb_miss'] += 1
+
+def print_sort_order():
+    global sort_order
+    print("Sort Order: " + ",".join(sort_order))
+
+def print_header():
+    print_sort_order()
+    print("Percentages: Cache miss and TLB miss %es are wrt NrLdSt not NrSamples")
+    print("%-45s| %7s | %7s %7s %9s %7s %9s %7s %9s %7s %7s | %7s %9s %7s %9s %7s %7s | %15s %9s | %s" %
+          ("","Nr", "Nr", "", "", "", "", "", "", "90th", "Avg", "L1Dtlb", "", "L2Dtlb", "", "90th",
+           "Avg", "Branch", "", ""))
+    print("%-45s| %7s | %7s %7s %9s %7s %9s %7s %9s %7s %7s | %7s %9s %7s %9s %7s %7s | %15s %9s | %s" %
+          ("function","Samples", "LdSt", "DcMiss", "(%)", "L2Miss", "(%)", "L3Miss", "(%)",
+           "PctLat", "Lat", "Miss", "(%)", "Miss", "(%)", "PctLat", "Lat", "Miss/Retired", "(%)", "dso"))
+    print("--------------------------------------------------------------------------------------"
+          "--------------------------------------------------------------------------------------"
+          "----------------------------------------------------------------")
+
+def print_footer():
+    print("--------------------------------------------------------------------------------------"
+          "--------------------------------------------------------------------------------------"
+          "----------------------------------------------------------------")
+    print()
+
+def sort_fun(item):
+    global sort_order
+
+    temp = []
+    for sort_option in sort_order:
+        temp.append(item[1][sort_option])
+    return tuple(temp)
+
+def trace_end():
+    sorted_data = sorted(data.items(), key = sort_fun, reverse = True)
+
+    print_header()
+
+    for d in sorted_data:
+        symbol_cpumode = d[0] + " [" + d[1]['cpumode'] + "]"
+
+        dc_miss_perc = 0
+        l2_miss_perc = 0
+        l3_miss_perc = 0
+        l1_dtlb_miss_perc = 0
+        l2_dtlb_miss_perc = 0
+        avg_dc_miss_lat = 0
+        pct_dc_miss_lat = 0
+        avg_dtlb_miss_lat = 0
+        pct_dtlb_miss_lat = 0
+        if (d[1]['ld_cnt'] or d[1]['st_cnt']):
+            dc_miss_perc = (d[1]['dc_miss'] * 100) / float(d[1]['ld_cnt'] + d[1]['st_cnt'])
+            l2_miss_perc = (d[1]['l2_miss'] * 100) / float(d[1]['ld_cnt'] + d[1]['st_cnt'])
+            l3_miss_perc = (d[1]['l3_miss'] * 100) / float(d[1]['ld_cnt'] + d[1]['st_cnt'])
+            l1_dtlb_miss_perc = (d[1]['l1_dtlb_miss'] * 100) / float(d[1]['ld_cnt'] + d[1]['st_cnt'])
+            l2_dtlb_miss_perc = (d[1]['l2_dtlb_miss'] * 100) / float(d[1]['ld_cnt'] + d[1]['st_cnt'])
+            if (d[1]['dc_miss_lat']):
+                avg_dc_miss_lat = sum(d[1]['dc_miss_lat']) / float(len(d[1]['dc_miss_lat']))
+                pct_dc_miss_lat = np.percentile(d[1]['dc_miss_lat'], 90)
+            if (d[1]['dtlb_miss_lat']):
+                avg_dtlb_miss_lat = sum(d[1]['dtlb_miss_lat']) / float(len(d[1]['dtlb_miss_lat']))
+                pct_dtlb_miss_lat = np.percentile(d[1]['dtlb_miss_lat'], 90)
+
+        br_miss_perc = 0
+        if (d[1]['br_ret']):
+            br_miss_perc = (d[1]['br_miss'] * 100) / float(d[1]['br_ret'])
+
+        print("%-45s| %7d | %7d %7d (%6.2f%%) %7d (%6.2f%%) %7d (%6.2f%%)"
+              " %7d %7d | %7d (%6.2f%%) %7d (%6.2f%%) %7d %7d | %7d/%-7d (%6.2f%%) | %s" %
+              (symbol_cpumode, d[1]['nr_samples'],
+              d[1]['ld_cnt'] + d[1]['st_cnt'], d[1]['dc_miss'], dc_miss_perc,
+              d[1]['l2_miss'], l2_miss_perc, d[1]['l3_miss'], l3_miss_perc,
+              pct_dc_miss_lat, avg_dc_miss_lat, d[1]['l1_dtlb_miss'],
+              l1_dtlb_miss_perc, d[1]['l2_dtlb_miss'], l2_dtlb_miss_perc,
+              pct_dtlb_miss_lat, avg_dtlb_miss_lat,
+              d[1]['br_miss'], d[1]['br_ret'], br_miss_perc, d[1]['dso']))
+
+    print_footer()
-- 
2.43.0

