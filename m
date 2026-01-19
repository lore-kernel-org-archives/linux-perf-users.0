Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F67405A;
	Mon, 19 Jan 2026 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846335; cv=fail; b=m7ls7RSdTWumE3B576bM9c/uoXwf3gj2wtSZWMCiQJ7qsU9bt6nLvmQPFf0wY2XcHNm7niNU0DCp7tfWeJL9rMKY/G/cpYhuhv4KbGjrgugydu2qrqCBlxnPhOfbIR+WvZqRBIiIhslQVBA8FhL46gVytVCj99zsDbIMDMjVHWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846335; c=relaxed/simple;
	bh=EegTBD5uOUs1vo5ZIEssiQVIYgVFL29Ja5yBoSQkXmw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=oGfLzCDYg821UJGepY7xDbYYIMCt5Wj1QGgAsnRpXoLgqIFB+rHfUxKvE/SDHi9q955P1dHBJdb45++fJP5ffy39BMiSBR09b7EmudkE2prtFNZwcp6uwxobDP8fWsGozUj8zyHLvcyM/okaSe9vvpZIAvQYJpw3qO4f8F10evg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mrz30iPA; arc=fail smtp.client-ip=52.101.85.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mrz30iPA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+lEPKfTfqsJhj7DH6bha6Yc3o29Xp6zU83AyycXQnEgJNTP1nOlcu3BLXQcuGM3sxCSIuIdKx5TsRu4Ndd+KwtM8vVt7roQvYLoUoct7LeRwNXQORjxN8GBQidb3hjwvnV0QlZ+CD8a5sHd7lVKpHn9Xpq3xNdlF3t/8kRTxGEZv6KnW3hF5Uve5xrt4rAjnbDuCtlIBBO+VZUW12hrvK3AYQclInoJZN6lR+QP3K/vetIFlbsTP8YHwV9CfmF6kzaAuQdWQZTIbiY6FtnXr52Q96ih70xWcjSIDw6b0pkgzpA8gq2uK+W2lVs6/uHLiHDbxB4cMJnR8iBOHAkH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okFftieZun+Ph501N483nlsxG/RgzI8IOT9OM4KSDYQ=;
 b=sl3Iyr498OMk3qddx+3tADT8FmSLCb78ZC69Jf4V2bUig5HIyBI5+HSrTx8mWi/sV+TMX4lrz458AmnHGqECaYYDq4blBriLT/sDaFXI/ihM2F+woo96nIRgCWFi3iX54sRsfVBDwnMbPKnXZvP1yzcbzaN4IZTUsWm+Od1akVgqjn2o7qnjqo9otqUQBm81wMHh64PTPwv2r5PXl4ptjS85rlHzmL4LqkpohuC+m/SeNiFhlEpmm/pFqkcr+51dXOrucJaNGFkjOb7HJWbPRp3ELNM93lsGTU9lTjkiIXVUdQ1zHOkLltmIfBPrmp5vaukFQ2xXXhWywRFrS5swaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okFftieZun+Ph501N483nlsxG/RgzI8IOT9OM4KSDYQ=;
 b=mrz30iPADpsQT7tzUXhxpJqBeyfwSuq0/Gmu1TJkZ7JcXcj8Qep83TPTEN8Fwg/Oz+FeKawaD+jXFxZ1S894dgALPrOVhTK0iVEzqjPTm04boGHd3FhEZYP/ZDzefwe+yCJddcihzOhTvpRdiyz/va8tmi8f675wIOGVY8HTMqA=
Received: from SA0PR11CA0170.namprd11.prod.outlook.com (2603:10b6:806:1bb::25)
 by DS4PR12MB9633.namprd12.prod.outlook.com (2603:10b6:8:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:12:07 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::19) by SA0PR11CA0170.outlook.office365.com
 (2603:10b6:806:1bb::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 18:12:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 12:12:06 -0600
Received: from [172.31.155.20] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 10:11:53 -0800
Message-ID: <3dffd1ec-54a8-4763-88db-c615bb361f95@amd.com>
Date: Mon, 19 Jan 2026 23:41:51 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 03/11] perf header: Support CPU DOMAIN relation
 info
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <ravi.bangoria@amd.com>,
	<yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
 <20250909114227.58802-4-swapnil.sapkal@amd.com> <aVhGJJBp0F5kygFt@google.com>
 <bef26ca0-6600-431e-8a23-4d612a24c87c@amd.com>
In-Reply-To: <bef26ca0-6600-431e-8a23-4d612a24c87c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DS4PR12MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1b1268-6c0f-4292-9032-08de5786418a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVQ4SzlVUnVwdWZTYlNIUE4xOWZnWnphOWMxbkRXS3ptdkhmZ0lieVBOeFpz?=
 =?utf-8?B?bHRGc2x6bWZIbEVIZGNIUG9kOTFVclNFRVRNNllrMWRDemRMeFhMaDlKVTUw?=
 =?utf-8?B?RDV1QmtVQU1vKzltQWcwL01rZVk3NXFvTEh1akFqcGVSenRuLzZiRWlzdENE?=
 =?utf-8?B?Wk5LamF4UGU5QkpNQ2taN0xIN1BHVUljWGJzRFNrV1VMd3ZSWk5Ga1JoOVVU?=
 =?utf-8?B?T1NmSVd4emNoYjJXYTJQOWdkTktIZ1ZIOGo5VTIwSHYxY1pyMTkyL0RWdDNj?=
 =?utf-8?B?L0xZeVQwaXVwYzFlMmpjSFZkdTRBWmZLNXdPbnN2RExNckRDbFd2K0RwTzJk?=
 =?utf-8?B?TnR0dGZoMnZRUmpBZzdvNXpRNnNRaEpvUmUybzhPNUZrb0pwYno4SExFTVNO?=
 =?utf-8?B?UUlGQjhITEZ2NzNSK3J2YVNta21sdkg5c0dnay9rcWFOUXZXK3VqSGs5WTRy?=
 =?utf-8?B?djdpR09vYm4rWithNEhUWHdZS0o3cnB0cFU5dHFEeVZ5SWRsYlFndlo2TS8x?=
 =?utf-8?B?NUs5MWE1SXh1dnlsbVlpK051R1R3NDRQUDB3RnRkK3cxMXNPWXROOTBrdEFD?=
 =?utf-8?B?UnZGemt0K0ZpSmhWb0ZNQXo0OERZbjhJSTBvb0pmZGJEUFNVYURTcGtiQS95?=
 =?utf-8?B?QmRVbHZVK1p3S2Z5TGpFdVhBVmI0bS84enJEa2lOMk5xa3hhWXJ5Y3NxOU1r?=
 =?utf-8?B?WWk4d1krNUphV2tLUUloWVAzejduNTNjVk9PMzB1aUpWVmd6Z3pwMDgydFp3?=
 =?utf-8?B?dmdKREt6ZFRvbW9nUk9QMEVWVWpKUEp5WlNoeU5aM2xZWFNva0trdFo3c3U0?=
 =?utf-8?B?d2ZTMklrdzFtT1dXWThIYTJZMzI4M29pQUJnaHpTTGd0SEdQcldiUldnYklZ?=
 =?utf-8?B?UjhZdk9vZTluN3NORy9FUnoyTDA2ZURuN0ZyV2ptU1NSNUxOWlBEMGJJL0lE?=
 =?utf-8?B?N2lobW81WTEyNi9NajNpMWFFcU8yVkh0YWQ4c3FSV200RllSNFJTZkpUWTlQ?=
 =?utf-8?B?ZHN0Q1p2aEpqZWhXbVpwaWtwSVhoTlhqVldaRGl6WXdFZ2c0eE9EK0dXYldC?=
 =?utf-8?B?OVhjeWU0T3hNdWJhK3hhRFJZSkIrWFVtZll2OTdSS3VMcHhsMVMzaTg2eVVU?=
 =?utf-8?B?LzJHUWc0MVBQRFBjek5nMWo2eThOWDNmQStUbjJPa2dTeWZoOHZSNUZMSUVU?=
 =?utf-8?B?UmdNQTN6dUQvTzY5TCtqOG1pMkhYN0F3L09TanI2WEQyRFl2b2pxY1hMUmNY?=
 =?utf-8?B?SHVUdmVFREdmWDhhUmFKS2UrdW14WGUreEo4QUxpcGNNWXRkSnBVVFVpWXRY?=
 =?utf-8?B?MDkzYWNMY1RSQ0w4MGZWbGNkcU1kMXpTcDBvVGFpaXdIdmFBQVZvbVJlSEhG?=
 =?utf-8?B?bUd6L0xadHRrU296QSsyemxSL0gwZllEKzVRVHBUdDhEb0x4SnJUYzV2UXlG?=
 =?utf-8?B?QmZycWh3ZG9NS1duM1Y4U05wUWtWRzljZ0lwZE5RNjJrSjVFdXJacTIyTjdz?=
 =?utf-8?B?czlpNjE5UVg5RThsdGdMdXp6cllOREVYTG1qbUxGQW5HYVM1L0RYcUJqOTdB?=
 =?utf-8?B?VWFWV2JwZnRFTmpQZXBVREVsR0Z6TE0ybmVLclpwYkJNbmFLR3VoVzZYUHZn?=
 =?utf-8?B?OTJycVh2UHRpdmpDc3FhT1d6VjBaM0orUU4zaUM2R1QwSGV2cUlYTEZWNjZD?=
 =?utf-8?B?THdjQmFscGRDdGIvc0hwSFRkS0VGejZQQzdTc2FwVXRvTDAzTjhMdnRpMGVT?=
 =?utf-8?B?NTJnNDNxbU1SdklVaUR4TS83RXN4M2psdWJ4SDVpdU55aVhYY0dyT2JLZ0tU?=
 =?utf-8?B?eGREWlJRWFRoRHF2WlRwRTRUV2w4OExoWU4yY0daWW85ZCtOdG43RkpicFBw?=
 =?utf-8?B?UlhKczBvNUxzZ3BySUJRNFFjSUh1QjZCNmJZY2FRNTR5T29lMWxhcUlqWHRn?=
 =?utf-8?B?WXM3UkhzNllkSlptNHg4TExud2lMRlVqajk4K2JuUU5EaWtCTnF1dm5KbVpU?=
 =?utf-8?B?eVc1NjlkVEFualpjU1VoTWRpd3FuZnNRcmdTc1lsdXIzY2gvNTFrVkpEcjhW?=
 =?utf-8?B?YUljS2FGaFk1c3h0Y0hkSFdFOTFJZVFJbkR6VzVYczVwdUZBNUV0Q0N3elZM?=
 =?utf-8?B?dXZQbUVCMUVySnR6enJKME1oWXN5c01PY0JpOTcyYUJCd3l2WXhDUFNSRWVB?=
 =?utf-8?B?Z1RUdFRhNGwwdzdoRHczbmw3VWxmWEdvNEViU3A4VU5JQTAxaXl6VEpJMUEz?=
 =?utf-8?B?ZWpRRmJTUDVrVkNxSytSRkVxTGx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:12:06.9419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1b1268-6c0f-4292-9032-08de5786418a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9633

Hi Namhyung,

On 09-01-2026 16:54, Swapnil Sapkal wrote:
> Hello Namhyung,
> 
> On 03-01-2026 03:56, Namhyung Kim wrote:
>> On Tue, Sep 09, 2025 at 11:42:19AM +0000, Swapnil Sapkal wrote:
>>> '/proc/schedstat' gives the info about load balancing statistics within
>>> a given domain. It also contains the cpu_mask giving information about
>>> the sibling cpus and domain names after schedstat version 17. Storing
>>> this information in perf header will help tools like `perf sched stats`
>>> for better analysis.
>>>
>>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>>> ---
>>>   .../Documentation/perf.data-file-format.txt   |  17 +
>>>   tools/perf/builtin-inject.c                   |   1 +
>>>   tools/perf/util/env.h                         |  16 +
>>>   tools/perf/util/header.c                      | 304 ++++++++++++++++++
>>>   tools/perf/util/header.h                      |   1 +
>>>   tools/perf/util/util.c                        |  42 +++
>>>   tools/perf/util/util.h                        |   3 +
>>>   7 files changed, 384 insertions(+)
>>>
>>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/ 
>>> tools/perf/Documentation/perf.data-file-format.txt
>>> index cd95ba09f727..92dbba1003cf 100644
>>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>>> @@ -437,6 +437,23 @@ struct {
>>>       } [nr_pmu];
>>>   };
>>> +    HEADER_CPU_DOMAIN_INFO = 32,
>>> +
>>> +List of cpu-domain relation info. The format of the data is as below.
>>> +
>>> +struct domain_info {
>>> +    int domain;
>>> +    char dname[];
>>> +    char cpumask[];
>>> +    char cpulist[];
>>> +};
>>> +
>>> +struct cpu_domain_info {
>>> +    int cpu;
>>> +    int nr_domains;
>>> +    struct domain_info domains[];
>>> +};
>>> +
>>>       other bits are reserved and should ignored for now
>>>       HEADER_FEAT_BITS    = 256,
>>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>>> index a114b3fa1bea..f43a7ec44b5f 100644
>>> --- a/tools/perf/builtin-inject.c
>>> +++ b/tools/perf/builtin-inject.c
>>> @@ -2058,6 +2058,7 @@ static bool keep_feat(int feat)
>>>       case HEADER_CLOCK_DATA:
>>>       case HEADER_HYBRID_TOPOLOGY:
>>>       case HEADER_PMU_CAPS:
>>> +    case HEADER_CPU_DOMAIN_INFO:
>>>           return true;
>>>       /* Information that can be updated */
>>>       case HEADER_BUILD_ID:
>>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>>> index e00179787a34..71034c4b4488 100644
>>> --- a/tools/perf/util/env.h
>>> +++ b/tools/perf/util/env.h
>>> @@ -54,6 +54,19 @@ struct pmu_caps {
>>>       char            *pmu_name;
>>>   };
>>> +struct domain_info {
>>> +    u32    domain;
>>> +    char    *dname;
>>> +    char    *cpumask;
>>> +    char    *cpulist;
>>> +};
>>> +
>>> +struct cpu_domain_map {
>>> +    u32            cpu;
>>> +    u32            nr_domains;
>>> +    struct domain_info    **domains;
>>> +};
>>> +
>>>   typedef const char *(arch_syscalls__strerrno_t)(int err);
>>>   struct perf_env {
>>> @@ -70,6 +83,8 @@ struct perf_env {
>>>       unsigned int        max_branches;
>>>       unsigned int        br_cntr_nr;
>>>       unsigned int        br_cntr_width;
>>> +    unsigned int        schedstat_version;
>>> +    unsigned int        max_sched_domains;
>>>       int            kernel_is_64_bit;
>>>       int            nr_cmdline;
>>> @@ -92,6 +107,7 @@ struct perf_env {
>>>       char            **cpu_pmu_caps;
>>>       struct cpu_topology_map    *cpu;
>>>       struct cpu_cache_level    *caches;
>>> +    struct cpu_domain_map    **cpu_domain;
>>>       int             caches_cnt;
>>>       u32            comp_ratio;
>>>       u32            comp_ver;
>>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>>> index 4f2a6e10ed5c..7ff7434bac2c 100644
>>> --- a/tools/perf/util/header.c
>>> +++ b/tools/perf/util/header.c
>>> @@ -1621,6 +1621,184 @@ static int write_pmu_caps(struct feat_fd *ff,
>>>       return 0;
>>>   }
>>> +static void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 
>>> schedstat_version, u32 nr)
>>> +{
>>> +    for (u32 i = 0; i < nr; i++) {
>>> +        if (cd_map[i]->domains) {
>>> +            for (u32 j = 0; j < cd_map[i]->nr_domains; j++) {
>>> +                struct domain_info *d_info = cd_map[i]->domains[j];
>>> +
>>
>> I'm not sure if it needs a NULL check for d_info before access.
>>
> 
> Thanks for catching this. Yes we need a NULL check here.
> 
> If some of the cpus are offline then it is possible that some sched 
> domains can be degenerated and for some cpus.
> 
> for e.g. cpu0, cpu128 are smt siblings. If cpu 128 is offline then SMT 
> domain will be degenerated for cpu0 alone. All the other cpus will have 
> a valid SMT domain. Thus SMT for the d_info can be NULL.
> 
>>
>>> +                if (schedstat_version >= 17)
>>> +                    free(d_info->dname);
>>> +
>>> +                free(d_info->cpumask);
>>> +                free(d_info->cpulist);
>>> +            }
>>> +            free(cd_map[i]->domains);
>>> +        }
>>> +    }
>>> +
>>> +    free(cd_map);
>>> +}
>>> +
>>> +static struct cpu_domain_map  **build_cpu_domain_map(u32 
>>> *schedstat_version, u32 *max_sched_domains,
>>> +                             u32 nr)
>>> +{
>>> +    struct domain_info *domain_info;
>>> +    struct cpu_domain_map **cd_map;
>>> +    char dname[16], cpumask[256];
>>> +    char cpulist[1024];
>>> +    char *line = NULL;
>>> +    u32 cpu, domain;
>>> +    u32 dcount = 0;
>>> +    size_t len;
>>> +    FILE *fp;
>>> +
>>> +    fp = fopen("/proc/schedstat", "r");
>>> +    if (!fp) {
>>> +        pr_err("Failed to open /proc/schedstat\n");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    cd_map = calloc(nr, sizeof(*cd_map));
>>> +    if (!cd_map)
>>> +        goto out;
>>> +
>>> +    while (getline(&line, &len, fp) > 0) {
>>> +        int retval;
>>> +
>>> +        if (strncmp(line, "version", 7) == 0) {
>>> +            retval = sscanf(line, "version %d\n", schedstat_version);
>>> +            if (retval != 1)
>>> +                continue;
>>> +
>>> +        } else if (strncmp(line, "cpu", 3) == 0) {
>>> +            retval = sscanf(line, "cpu%u %*s", &cpu);
>>> +            if (retval == 1) {
>>> +                cd_map[cpu] = calloc(1, sizeof(*cd_map[cpu]));
>>> +                if (!cd_map[cpu])
>>> +                    goto out_free_line;
>>> +                cd_map[cpu]->cpu = cpu;
>>> +            } else
>>> +                continue;
>>> +
>>> +            dcount = 0;
>>> +        } else if (strncmp(line, "domain", 6) == 0) {
>>> +            dcount++;
>>> +
>>> +            cd_map[cpu]->domains = realloc(cd_map[cpu]->domains,
>>> +                               dcount * sizeof(domain_info));
>>> +            if (!cd_map[cpu]->domains)
>>> +                goto out_free_line;
>>
>> Please use a temporary variable to save the result in order to not lose
>> the original pointer in case of failure.
>>
> 
> Sure, will do.
> 
>>> +
>>> +            domain_info = calloc(1, sizeof(*domain_info));
>>> +            if (!domain_info)
>>> +                goto out_free_line;
>>> +
>>> +            cd_map[cpu]->domains[dcount - 1] = domain_info;
>>> +
>>> +            if (*schedstat_version >= 17) {
>>> +                retval = sscanf(line, "domain%u %s %s %*s", &domain, 
>>> dname,
>>> +                        cpumask);
>>> +                if (retval != 3)
>>> +                    continue;
>>> +
>>> +                domain_info->dname = calloc(strlen(dname) + 1, 
>>> sizeof(char));
>>> +                if (!domain_info->dname)
>>> +                    goto out_free_line;
>>> +
>>> +                strcpy(domain_info->dname, dname);
>>
>> This can be simply:
>>                 domain_info->dname = strdup(dname);
>>
> 
> Sure, will do.
> 
>>
>>> +            } else {
>>> +                retval = sscanf(line, "domain%u %s %*s", &domain, 
>>> cpumask);
>>> +                if (retval != 2)
>>> +                    continue;
>>> +            }
>>> +
>>> +            domain_info->domain = domain;
>>> +            if (domain > *max_sched_domains)
>>> +                *max_sched_domains = domain;
>>> +
>>> +            domain_info->cpumask = calloc(strlen(cpumask) + 1, 
>>> sizeof(char));
>>> +            if (!domain_info->cpumask)
>>> +                goto out_free_line;
>>> +
>>> +            strcpy(domain_info->cpumask, cpumask);
>>> +
>>> +            cpumask_to_cpulist(cpumask, cpulist);
>>> +            domain_info->cpulist = calloc(strlen(cpulist) + 1, 
>>> sizeof(char));
>>> +            if (!domain_info->cpulist)
>>> +                goto out_free_line;
>>
>> All error paths should call free_cpu_domain_info() at some point and
>> free the intermediate domain_info properly.
>>
> 
> Sure, will do.

Sorry, I missed to mention here that the parent function is taking care 
of freeing the memory by calling free_cpu_domain_info() in case of error 
path also. Because of which I have not addressed this in the next version.

--
Thanks and Regards,
Swapnil


