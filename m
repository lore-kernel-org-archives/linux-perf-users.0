Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378E370AD8;
	Mon, 31 Aug 2026 19:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788204356; cv=fail; b=VWXklSXmxIVqbXTLSuDPa0mgM1sDbbsWPSAIGM/wox12PpyVukZZuhqvGXSiN0Ab4FXYSUcDyHt/2F9LrgEYj4izF4lAmdS4zicuszQLn5lobnftj7z/V/4tjTVH5mCnK4B4sJTKwFdI5mrKgCuA58dEsVlTj3b5ulB40AWjSuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788204356; c=relaxed/simple;
	bh=r3mTDbiyJ6Ri8cCbs/hx1DhztVQQ0CBclSWQcoehl6w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZfjL7yon4KlmZlSpQ+ebnanRtqLOTriPyKuYx2+R4PZ2xXelIDZS1wQUhINHKUEyjCtgQKt+zie7SiJk7Jguu6HaDewMVgTyJOICiMiZoyJ6UxwrgvyjmyKyie6+MvreIShOPu3NGVNScNHFJpD1xtRjHhXd5fLdx2fOJ3SYdNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U0+tL3I6; arc=fail smtp.client-ip=52.101.53.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U0+tL3I6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPq5gCfGZvYU4KshxJTuLmwAvvxf94eAFxX6Yj34xJ8WZWXPPdWipXehFLxPI32XsY5G2VExMCP9rKEiHsTTxBx6kC+zCCv8tFQrtSAkRNt9GpqrEf0P1ZzpH5ASpOsEf3d+QEaic5Vd/swG0GWAojC9kAI/0poCV2z+BR1cL9s3/tbK4UoWlwdavi+5BlEYOoX5Miey3RDAayo6iVmwqTa6dPsg2abHfTRPgB9nDisCfi88TIF+2hrwYrNB6YO3UOLeD0OjvHwAVQ6F9/eWSUWQALx6t+oJlKtFvabHaqS/tHHqx8AEOZaP9lVNDTyzAOmTG1cAKvB21jw72kiU9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQevcIRM2dc7I/YIXVU4WFpH3ye55IqcOiT75scB9ik=;
 b=pQHw3lLqps5ZBFizp71mo3K+/iE+4Lo/OiD2FdEtYvFb02tsrwgEZ0CcSImtBWKiE0nhCYM8cTtkKvN4AMa5DD2knlWGsKRFd4pPy2lB+EnAu/309+A7gwG1sQoZbtM+KrLuT3DdlHDhvtuLbUViOR8fgcNlhJhdoJVtU0+XGNfPWFhhiuFGduZQc7GurFPIvObdIMxxHcYXM0jV1dDjoXNlm33JvJQVnLs0WAD4Exm8I/x0fC0Qm4ZIdrLHAxhnaoy7szqcHJrqFUw/6KFWv3lHBkVHaZ1uU68EAbBjqBwfabHiu4loJyBA5WI0n9D/zuq7GiEjDFXp5EF4PG4EdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQevcIRM2dc7I/YIXVU4WFpH3ye55IqcOiT75scB9ik=;
 b=U0+tL3I6ugke4ulmhCF3wb8LmQ3Ms79WVNjqFCfC+GOVqJB8m4G1oicBoPFcNK6ZtRrz5VDsI8eiOot+L+uV7CGhwDbJQJXzi1qB79XztXBDapfNqmIu7UibtQYm5AsW+z6Hpt+shSRYHJq0R3lE/g9bac8vnAVz5oSdXLGQ3Ma8WYbb/H/8YkP9F8atW0Acuc2e3qH0LyjnzXqmTKvgQ33cHi6QDbmDrHVhe+y7m+fImv2B0I7knyzNBECMCz3VnSt+DF2bY7T/o0tHC+tK8MWZOo+288RWqCz6HQggQYJHs55czdmT158YkHWErPlK54CZFTslhZZiw3dnXpTmTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Mon, 31 Aug
 2026 19:25:41 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 19:25:41 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 31 Aug 2026 15:25:25 -0400
Subject: [PATCH v2 02/14] perf/ring_buffer: stop using PG_private as AUX
 page high-order marker
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-remove-pg_private-v2-2-3668159cd9e8@nvidia.com>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
In-Reply-To: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
To: David Hildenbrand <david@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, 
 linux-perf-users@vger.kernel.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: YQBPR0101CA0331.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 8364d3cb-3246-4abb-d12f-08df0795a55d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	iYumEKz58cLPOZOjfzBCXuzBO7xhcLU6IM5cwST0ym04yNG3cfNWhTxUvrWVwHky7yeFKJc6Jvw26MRtz5K63VlkCa8O2HuZ+NYQtUr2ERPTjICQC5h2IhQBcAtwX9E2PGqztTkSd4/+q4UGic215ggxRs5VHni9UJLSYU4zSDMXoXWc80cKNpKpxCwbc69sBcK0vdqgmKjChJQfFBq30lPk9BpEcTzlVcOpvf3mN+oCuHG+Ufdnm4Noa/SrdQGnaAXo4s7knHG2Ztlvy3ufdd3Gv6NEZgGX/VlauKqbG4HT9joCxILYMqdb9Q5UHijbYtLvlHHIPPXt8jxVLA6Ydm3IZrvz8/jKtihVguAZ4L7xMJ7zZC2H0kHeDOHnySe0AfAg8/gn4/ls/vwEgnhKIbl0TM232KOgPiUb2xeEMws7Di1f+PHYVcv10WDMKlN5t+shUg+RGArVOJqnADWqygwNPXcUP+hmDAsLMxXzZN0B06lWoV47biw80wLVt7ThRy9X107JlgVgh0p1+b+gEU6oyaiwYsiFI2/1SNPgvfpZ25Xfq3PgtXglXIDrnNWWbFYCAaOeEKdk5EiVcxtvZhN+MoK8OGqro6xvJ5lAdryc9N6IH9seEevaBJxwczAmlvkVds12EEB5Ll7tF6MAB4c1G+U23j0qlAias+uO9EPqmPQUegfxMw1uwdilR4BkQdbP4ZgWbQWoaq7KHBS+jA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHorRHNUUWgrNEo3dmx2YXplVTIwWUJIandMZ1d0QWtJTGhNYXlXYUJuZmxL?=
 =?utf-8?B?ZEVzQ0I4M3FPdWRhQjMzNXlINDVsRndRcHBpZ0RSVVVLcU83aFRxdFF4enFS?=
 =?utf-8?B?bTNHeXltcjQwUlRjalQ0T1R4ODFHUDE3bHZjV2NVdlZDUXRVdVJreGhVc0NN?=
 =?utf-8?B?SVFvcjV1QUcxMUw5ZjRKM3pEQlBqMDlRWWpSVlo2ZnhlK1Zud1BVcW5Ya1oz?=
 =?utf-8?B?M085NWZzb3lXdC9FSkY1TnlXcmNzNHRJVnJhTkoyUldleXN4dFRDNjNadnlC?=
 =?utf-8?B?WHUvTXVDNTQ5VnpvSDNaSFI0cE5UbHJXL3NJV2Zpb0J2MlFpWFpWY3crTkZH?=
 =?utf-8?B?bnFlTGlBWWgrYlRTNWFWaGdFL01yMysxNlpyNHh2OUhNdVF5S1BIa3ZXdEdh?=
 =?utf-8?B?UUM1OEx6WUJ5RkZIUFhWc3ZWRWtXWVpkckFFM0dWT0NlckxGNDNtWXdveEF0?=
 =?utf-8?B?RDl1NmVhSVgvUTJZVHR3d1M4bFRqNGhyKzVYYVZCNmtOOVF0MWdvUjRKb2Q5?=
 =?utf-8?B?TTFCM2xXTU9RWW5INUlqUk5SZWhBUURoSVJKdTFoY3Bkdk9WNTRVTDdwaHVO?=
 =?utf-8?B?L2tFMTZTVU1XNVZzSDJISjVrZklKcHRtZXYrczNoUkxBOTIrUmlXME50d0U4?=
 =?utf-8?B?eEw4bzFaQWlYUTNmbjdDUkZKSHIzT09XTnBuVGVrWnBiNzhFV3JKbjZUbyts?=
 =?utf-8?B?c0tQYWhUNkk0UE0rUGE3cnB6TTRDRmc3bVhLSmk1c09rYytjcklnYnc0N3o3?=
 =?utf-8?B?VEZLREJCdHRVSVF2VzN4TzFveFVKcG96Tm1FeUYzaFZpUFhZNWQxcGN3amtW?=
 =?utf-8?B?SDJhZHhkZDcweG1tOHd4VUUyTjArazE3aHJnaXYwY0N5eGRwazM0akVKU29Z?=
 =?utf-8?B?RVhQUnBLempzd1VXZjVEbHhPY3VPZHRwTit0NDMyZWQ2WlJvZnZRa3BlTkc5?=
 =?utf-8?B?RW1zOFZSK0FVbGQvVWIrdVBWT2I0U05jd1RmRlpkYnVNZk1rTm9jWG9PSzdm?=
 =?utf-8?B?a2hVZzBITTVnY1c3dU1UOUpYd2pObEhzMlFheEJJYythWVU4cnJnbnZtekor?=
 =?utf-8?B?NzRWWHZDZmQzSUFUZWJ2VzJzVW91UmJuSXk4ai9BUDRoQ09HTHZ4eDkyYVlP?=
 =?utf-8?B?cmFjSEpaZmRkV2lqT2RDdEtGMDNTNWlVNE5hODFrcnBCZTVHZ0ZGQ0d5Ly9Y?=
 =?utf-8?B?OWcvc25lcytubUNTa1lmYkpVMGExUDRIODdQaDBleVM3YUx6STJvQ2JFZjZC?=
 =?utf-8?B?UlFja1Nmb3dSWVNMNG5ydzlYZU9BMVR4OExMMjVWSUVXS3pqRXZBZEVPNTJa?=
 =?utf-8?B?ZFF6bzZucmdFamcrQWFMRStjS0tFMXNJUEEyYXVMd3ZYN0J3dUtrZXJ0eHpC?=
 =?utf-8?B?VENhZDlYV3lYUUJYb1d0UnRJZFVpNjFHYnFiYnF5Y0U4S3dQcGk5VEQ3amdJ?=
 =?utf-8?B?S29SSzJicWI2TzQ2RUd4THpRSXZSMXJOV3hjZ2VuVGtsZVhEc2JPMFdkaVBN?=
 =?utf-8?B?eUx1eGlhUDE2WDkzbWZMQWhFcEVFRnNjVWV1MmtSVjYyQkdaYmtsYjNXV2Jv?=
 =?utf-8?B?NjFSSUlMdE9zY2oxTFc5Rmt0VkZ4SlJJNm9FbnNZVTlKRWx0UzdXdlJHZzJ4?=
 =?utf-8?B?eEhjRit2cFNrV1c4N0lMMWlzT2dGUGtNWDdGV2RieS9ONmczd1ZtYmNORmx3?=
 =?utf-8?B?TGJVV3FXL044ZERpVGlVRFlaTWlTdFpZWHltdnM3V2Nidk9SdklucXFTRGF6?=
 =?utf-8?B?TGMrRnZpSThiY2ZadVN0c1lRbkRxbUUxYlZvdE8zTnoyb1RJbFd6NEVMdFhV?=
 =?utf-8?B?Nm1BQVdJanRRR0huK2FVRStqY0tyaXI1REk2a3VXWmZIOFk2QU1zRmRBbm5h?=
 =?utf-8?B?RWloc2FINGRsS0lZMC9QcjU0OU1EemhuQVE3MHU2Z3lrUmtoMXlKaFl1eXg3?=
 =?utf-8?B?Sk1mUHQ5cGpqeXdxMmt3Y0g1aHNFanJZR2hiNGlOUGtwa01kb2pYSUVjYnZV?=
 =?utf-8?B?cDZ2YndCYUVXcW5RajV5NW5MZnNNUndJRGJZdFdmRGhuM3JaUVNHSkk0VkQr?=
 =?utf-8?B?aHhyS3RLalVCcDI1TFVGTERSNFRXTEw5KzJNU1RTanBabldzMzMyT3poYjEw?=
 =?utf-8?B?Vm9oWmd3ZnNJMHdFK25IenNrLzdtOG51ckRWaVo0TzIxa0Q3T01oTFBrcTA4?=
 =?utf-8?B?ZTRRdlJsTjI1VXBPVmF4eHVzaTdrSmJKbFJMVWxlRlVTRjJTVXpNZnhrdHNi?=
 =?utf-8?B?WXFrRVBZQ056b3RqQ0phYTFHUFFucHpRVmwxVDQ1Qy9tYTFCU01xaVNEeGRs?=
 =?utf-8?Q?+6vjqy3Tg+1k0plQkQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8364d3cb-3246-4abb-d12f-08df0795a55d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 19:25:41.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9R+mBpWRUWks48/k3neieb7pj88O+PuqzDLGDKnsm59FRNJxSKguTZzz41i/YxyP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742

A high-order AUX page sets PG_private on its first page and stores the
order in first_page->private. Stop using PG_private and check
first_page->private for AUX page order only in the ring buffer and its
users. This is fine because page->private is 0 for order-0 AUX pages,
matching the page order.

It prepares for a future commit that remove PG_private.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Assisted-by: Codex:gpt-5
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 arch/x86/events/intel/bts.c | 3 ---
 arch/x86/events/intel/pt.c  | 6 ++----
 kernel/events/ring_buffer.c | 7 +++----
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index cbac54cb3a9ec..5849392cf26d5 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -66,9 +66,6 @@ static struct pmu bts_pmu;
 
 static int buf_nr_pages(struct page *page)
 {
-	if (!PagePrivate(page))
-		return 1;
-
 	return 1 << page_private(page);
 }
 
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 5754cd4055628..49349afee6119 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -781,8 +781,7 @@ static int topa_insert_pages(struct pt_buffer *buf, int cpu, gfp_t gfp)
 	struct page *p;
 
 	p = virt_to_page(buf->data_pages[buf->nr_pages]);
-	if (PagePrivate(p))
-		order = page_private(p);
+	order = page_private(p);
 
 	if (topa_table_full(topa)) {
 		topa = topa_alloc(cpu, gfp);
@@ -1296,8 +1295,7 @@ static int pt_buffer_try_single(struct pt_buffer *buf, int nr_pages)
 	if (!intel_pt_validate_hw_cap(PT_CAP_single_range_output))
 		goto out;
 
-	if (PagePrivate(p))
-		order = page_private(p);
+	order = page_private(p);
 
 	if (1 << order != nr_pages)
 		goto out;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 9fe92161715e0..061b5cb222266 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -630,11 +630,10 @@ static struct page *rb_alloc_aux_page(int node, int order)
 		/*
 		 * Communicate the allocation size to the driver:
 		 * if we managed to secure a high-order allocation,
-		 * set its first page's private to this order;
-		 * !PagePrivate(page) means it's just a normal page.
+		 * set its first page's private to this order, otherwise page's
+		 * private remains zero.
 		 */
 		split_page(page, order);
-		SetPagePrivate(page);
 		set_page_private(page, order);
 	}
 
@@ -645,7 +644,7 @@ static void rb_free_aux_page(struct perf_buffer *rb, int idx)
 {
 	struct page *page = virt_to_page(rb->aux_pages[idx]);
 
-	ClearPagePrivate(page);
+	set_page_private(page, 0);
 	__free_page(page);
 }
 

-- 
2.53.0

