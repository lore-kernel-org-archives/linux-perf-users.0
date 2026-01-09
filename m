Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D43280317;
	Fri,  9 Jan 2026 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957885; cv=fail; b=CUdPaKuLrbETR6bm86GmhcvAeWoJdv1ALXPuxq5hMEAWQF6Og5WebyziwehK6pN2WOJo0+NJ8zlxFC9CJJgzO48wesxigt6cpKrURFJNh+cTOQ6ziS8RVrTsEbV1KH5iwe/w/lqAALyiVM34EyLh2DeQzj+0g405ErCYAv91OB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957885; c=relaxed/simple;
	bh=X5ZI7e8MDbJyIwNzXK0I7ehsBtnMvRxHnlNuQm0DzfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qUlAQh2Bnxa3AD8G/eoiXdvoiNSvvMFBxkUb0jzdO5qKRKZqfcaj5EoAtYBMXdn+0PXRY6guMn/TeEyySFyyoUosJQBd625I+ezkpOHAg3n8WasEMJ67MqHC6UIo4FcxkHJoZoYe8hdnBHv4CfS2PQz97JchAEbsymcJp6sKGlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AVx5N5FF; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AVx5N5FF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOo0vAP7SatLzGW1eIjXPeJqztvzLcXH4iyrHTToZzNwa6gilay3jSlAMvAEpmP30dhEwLpbNyzki7dl5upbP/y7EHFB8mWWrNlnfisvV2nLQPqwSBa3B+GwOZwJsMKSfrx+YQxPUZe2PVJLBpLfXLFx7pudn+7Mze0r6Xl/AdyqjsnA8CmdNR/r4hVngr0xQ7C0O2mkd7kTZwb/IhY2n+X4/DK9V7aHOByey0TFE8da1JbimcV5HVzaXAVj856y3m+rS7Nd9fjHiXMWpStvC5vQUJTSno5WXQA2I5RJvuATuSFy/66ZiqPfum/hKRWPPhUU3siRGyy2isVEyGWSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQLUNl19PEVD40TFXSrFRWcehzyfFG59cBByARxMQZQ=;
 b=tKLREVbLRbCqCWMrOoavNcMEZDcdNBNm0ZNTx76yE9hlScgombdzXkPcKsUGcwKViIZNoQO5vtO9gftuTV8J8o05A2GXkWQD2JP3GLDegIhRanUgAsSacHwk20lFndsopExppmnYxqWe7xB4Htslz3G9UNJjG04thGGVTBV2/nRI6BJXVXejNWApgfmCph1Ops32iVyqjy0asXjV3Q35iZ73FpzYqjgVPUfOP3ZpGW+3DELBTwDOO/V39UzbD+gS09f/uzVtzlwFIcVfLar9VwQfNMfTifK6GR64hGCTI/ibnAb3naORVYoVR55q12lOsLOxI1ENJgQLb4dHcbImyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQLUNl19PEVD40TFXSrFRWcehzyfFG59cBByARxMQZQ=;
 b=AVx5N5FFkANUNjHXfU6XKDvPi7FxXdZoN3u2BTGnVlhZqYmwowceUHG+bWNgHiYxDIPKWRu2RLpP1SZcsi0Gu8tx6+2X0WuWVdOZ4Jd5/l3gNqOdl07yHfqS139UimonzFijDIgRAabZXSnnyDWkq3o/WCXIzL5Ha4mz2gDKQ9c=
Received: from BN9PR03CA0275.namprd03.prod.outlook.com (2603:10b6:408:f5::10)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 11:24:29 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::54) by BN9PR03CA0275.outlook.office365.com
 (2603:10b6:408:f5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 11:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 11:24:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 05:24:27 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 03:24:26 -0800
Received: from [10.136.42.229] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 03:24:14 -0800
Message-ID: <bef26ca0-6600-431e-8a23-4d612a24c87c@amd.com>
Date: Fri, 9 Jan 2026 16:54:13 +0530
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
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <aVhGJJBp0F5kygFt@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d7d641-4c4d-4ac9-033f-08de4f71a652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlZQQlo2Nk4xUE1tQmNwSDBPZVpDMkNIVUhXekwycXpOSzQ4c1pVaUdKQ0hW?=
 =?utf-8?B?S2hoN0U3RVpCRytBUVJlTHExN2NRT3NDSHcrQUtBVndha1lrby92OWt6REFy?=
 =?utf-8?B?YW5tV0w0bjVsRVJCa2VZaENpOFFCOFVSZTRKdU1vYWFKaHlxOEkyemFKbDhE?=
 =?utf-8?B?UnRGbjJXU1FOUDNFd1QwRXkrbk9MZE1PRWFkd2oycmJOWjN2T01vS2RCR2dN?=
 =?utf-8?B?RE5ZbUQ5VzJOWHJLeDBjQXFPRDhCYnlDaG9EMWlLMXpBcG9UZzN6eGZqdHlk?=
 =?utf-8?B?bndMNjFTeWFHSXpkS1VpYXZnTEdlM3dBeTN1anZsV0V1QWlyK3R1cFhpMGlT?=
 =?utf-8?B?MVNLbjdpZTZISHFWUVk5TVl4eTJXMGtCNEI3ZEZSMnBtY3hJUWhROVpxdFFX?=
 =?utf-8?B?eXdqaTlSc0lKRUVWd1BUVjdUOEorMmFvNWladDNkUzJGcEFnVGpoNmQvZVVi?=
 =?utf-8?B?M0tSUWU0KzF1NGRYcXY2UDlQakV4Q2FrZGFwNWI2WC9sQ3JVTHZxd3VYNWNR?=
 =?utf-8?B?M3BEVnU3MkdEang0MUk1M0JYVmZjalFRSm1IOWUzL1pjdmZxY2pDS243bWI0?=
 =?utf-8?B?Uk84dmZFa0ozdTB0U1krNjg1eUFKRHAyVXlDQVh1a2s3TVBBei9LSUR2SU5t?=
 =?utf-8?B?QXM0YzNrZGQ3eUJVTU96SHRjUmk1VFU3ZnRhdGZpQ3JSTTErZWxvNDJ5YkJi?=
 =?utf-8?B?V2RsRVhhTm01SzJiekFVNUFtUmh4WFpsMjN3emFYS3BIaStrNVFBd2paNjVh?=
 =?utf-8?B?bVpYN2tCSFZTYWhQVVU5WFFYbmF6Q0VaQmx5UUZnWEhHY045K0xnTElIZmND?=
 =?utf-8?B?ZWZtaWplYmlYQm84N0FUaFplckJ0dFRnYlJXSldHUGU4Mi9UVVVnRkxPc0FX?=
 =?utf-8?B?T2Z6T0JLY1JCZnZZZ3F2TjZNTGtwVjdNTnp1Q0tDYk5RSTh5dU5rRVBSRFpt?=
 =?utf-8?B?ajVKdXJVQ2pXSzRXQ0hTTzJaY1hOVTBRSDVqK1U4aUxBYkgrN09TVStxSjI4?=
 =?utf-8?B?cUNGYjd1TmdFazBnRVczaDcxVk1FQ3VvdDhCc1ZWZlh0RCtoR1pHOStldkhJ?=
 =?utf-8?B?L1BJaE5JQUFyOHppUmlKS3hUZE1jbE9RSGVHVGtNOTVKYjhIMWJuQnhETUgz?=
 =?utf-8?B?czZFZi9HanBxa1laWDRFdUxNcHQ2K20wUWM4WGlubUR1eDN1akVqSTU5N3R1?=
 =?utf-8?B?ZC9tc1lleU9LV29TbWxXNkxyS1JjMzJXT0twbnNGTG9mMGxxM0VoRkxuaUFo?=
 =?utf-8?B?WUdKR1FTUUQ5a1ZURkNJekdmcUI3UWJOV05ySkZtSDROU1pTdld1MXFrV2g4?=
 =?utf-8?B?MEsxczE3V0ptNEEwV2FyWVBZTjJiSU1oaDdkZks2R01wRnNaVGI3MDZFeFNk?=
 =?utf-8?B?WnBzTWF6VjhFRXhYOWQwQW1xRm1ZcWY3Mld5WHFFaHQzUzIvMllLb1Z1Vyts?=
 =?utf-8?B?ZHc5YmplUlhXM2dUWkJxd2ZicUNKUTdZRFI2UmtBQ2w4OC90RVRBc3NMaVpI?=
 =?utf-8?B?RFZ1THFMUWNCZWx2aXBxUjAvWmJrUUp6eWpLT2d3UWVnL1J1SEEzZGljOGcw?=
 =?utf-8?B?VDBidjBVYTN0R2s1QlM1KzdZUHhGTnVkNHNnVXorZ05WUklhWWRzOXcrUGZQ?=
 =?utf-8?B?NEhYRnlVSHFrSXJEalcxM2VZSW1PWVh2TURTWU9WWmFZYkpnM1dDaXllSGQ2?=
 =?utf-8?B?MkNlS2RDSTByNmhKWG9uVkY3WUxMUjVOVE1FKzMvelVLa2E4ZDJpVnFWSFJI?=
 =?utf-8?B?V29hRVc0Q0d6TEFWbXZMSjg1R3VteHRKOUE0NWFWTDFLQVZ2Yy9JZkNVeGRp?=
 =?utf-8?B?dkdmaHFiWGhoWEwvWENOWG83cTJrbDd3VFpkV1pSdnk1cDBtZWcyV0JEWDBa?=
 =?utf-8?B?U2c1VlZtcm96Mjl6VmJGem1KZUlRaEhDb0piRmxOeU10eHhIWFIvS3ozVlIx?=
 =?utf-8?B?ZTZGeVdjOUFIWE1EcTVGeUVoZ1FCSmdkNTB0UkloaFNwNFhSMmN6TVA5cStO?=
 =?utf-8?B?WEhKc3ZBdGgxYUloRDF1bmVaU0RPVWtYSzNiTTJEZllYUXNxY0d3d0FkZUxI?=
 =?utf-8?B?bGV6bWEyTUJkTTVRUnRLdExqQ1F3QjYrbEJQdElJSUgyZnNzOFZTbmsraFRi?=
 =?utf-8?Q?eLFc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:24:27.3059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d7d641-4c4d-4ac9-033f-08de4f71a652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827

Hello Namhyung,

On 03-01-2026 03:56, Namhyung Kim wrote:
> On Tue, Sep 09, 2025 at 11:42:19AM +0000, Swapnil Sapkal wrote:
>> '/proc/schedstat' gives the info about load balancing statistics within
>> a given domain. It also contains the cpu_mask giving information about
>> the sibling cpus and domain names after schedstat version 17. Storing
>> this information in perf header will help tools like `perf sched stats`
>> for better analysis.
>>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   .../Documentation/perf.data-file-format.txt   |  17 +
>>   tools/perf/builtin-inject.c                   |   1 +
>>   tools/perf/util/env.h                         |  16 +
>>   tools/perf/util/header.c                      | 304 ++++++++++++++++++
>>   tools/perf/util/header.h                      |   1 +
>>   tools/perf/util/util.c                        |  42 +++
>>   tools/perf/util/util.h                        |   3 +
>>   7 files changed, 384 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
>> index cd95ba09f727..92dbba1003cf 100644
>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>> @@ -437,6 +437,23 @@ struct {
>>   	} [nr_pmu];
>>   };
>>   
>> +	HEADER_CPU_DOMAIN_INFO = 32,
>> +
>> +List of cpu-domain relation info. The format of the data is as below.
>> +
>> +struct domain_info {
>> +	int domain;
>> +	char dname[];
>> +	char cpumask[];
>> +	char cpulist[];
>> +};
>> +
>> +struct cpu_domain_info {
>> +	int cpu;
>> +	int nr_domains;
>> +	struct domain_info domains[];
>> +};
>> +
>>   	other bits are reserved and should ignored for now
>>   	HEADER_FEAT_BITS	= 256,
>>   
>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>> index a114b3fa1bea..f43a7ec44b5f 100644
>> --- a/tools/perf/builtin-inject.c
>> +++ b/tools/perf/builtin-inject.c
>> @@ -2058,6 +2058,7 @@ static bool keep_feat(int feat)
>>   	case HEADER_CLOCK_DATA:
>>   	case HEADER_HYBRID_TOPOLOGY:
>>   	case HEADER_PMU_CAPS:
>> +	case HEADER_CPU_DOMAIN_INFO:
>>   		return true;
>>   	/* Information that can be updated */
>>   	case HEADER_BUILD_ID:
>> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
>> index e00179787a34..71034c4b4488 100644
>> --- a/tools/perf/util/env.h
>> +++ b/tools/perf/util/env.h
>> @@ -54,6 +54,19 @@ struct pmu_caps {
>>   	char            *pmu_name;
>>   };
>>   
>> +struct domain_info {
>> +	u32	domain;
>> +	char	*dname;
>> +	char	*cpumask;
>> +	char	*cpulist;
>> +};
>> +
>> +struct cpu_domain_map {
>> +	u32			cpu;
>> +	u32			nr_domains;
>> +	struct domain_info	**domains;
>> +};
>> +
>>   typedef const char *(arch_syscalls__strerrno_t)(int err);
>>   
>>   struct perf_env {
>> @@ -70,6 +83,8 @@ struct perf_env {
>>   	unsigned int		max_branches;
>>   	unsigned int		br_cntr_nr;
>>   	unsigned int		br_cntr_width;
>> +	unsigned int		schedstat_version;
>> +	unsigned int		max_sched_domains;
>>   	int			kernel_is_64_bit;
>>   
>>   	int			nr_cmdline;
>> @@ -92,6 +107,7 @@ struct perf_env {
>>   	char			**cpu_pmu_caps;
>>   	struct cpu_topology_map	*cpu;
>>   	struct cpu_cache_level	*caches;
>> +	struct cpu_domain_map	**cpu_domain;
>>   	int			 caches_cnt;
>>   	u32			comp_ratio;
>>   	u32			comp_ver;
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index 4f2a6e10ed5c..7ff7434bac2c 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -1621,6 +1621,184 @@ static int write_pmu_caps(struct feat_fd *ff,
>>   	return 0;
>>   }
>>   
>> +static void free_cpu_domain_info(struct cpu_domain_map **cd_map, u32 schedstat_version, u32 nr)
>> +{
>> +	for (u32 i = 0; i < nr; i++) {
>> +		if (cd_map[i]->domains) {
>> +			for (u32 j = 0; j < cd_map[i]->nr_domains; j++) {
>> +				struct domain_info *d_info = cd_map[i]->domains[j];
>> +
> 
> I'm not sure if it needs a NULL check for d_info before access.
> 

Thanks for catching this. Yes we need a NULL check here.

If some of the cpus are offline then it is possible that some sched 
domains can be degenerated and for some cpus.

for e.g. cpu0, cpu128 are smt siblings. If cpu 128 is offline then SMT 
domain will be degenerated for cpu0 alone. All the other cpus will have 
a valid SMT domain. Thus SMT for the d_info can be NULL.

> 
>> +				if (schedstat_version >= 17)
>> +					free(d_info->dname);
>> +
>> +				free(d_info->cpumask);
>> +				free(d_info->cpulist);
>> +			}
>> +			free(cd_map[i]->domains);
>> +		}
>> +	}
>> +
>> +	free(cd_map);
>> +}
>> +
>> +static struct cpu_domain_map  **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
>> +						     u32 nr)
>> +{
>> +	struct domain_info *domain_info;
>> +	struct cpu_domain_map **cd_map;
>> +	char dname[16], cpumask[256];
>> +	char cpulist[1024];
>> +	char *line = NULL;
>> +	u32 cpu, domain;
>> +	u32 dcount = 0;
>> +	size_t len;
>> +	FILE *fp;
>> +
>> +	fp = fopen("/proc/schedstat", "r");
>> +	if (!fp) {
>> +		pr_err("Failed to open /proc/schedstat\n");
>> +		return NULL;
>> +	}
>> +
>> +	cd_map = calloc(nr, sizeof(*cd_map));
>> +	if (!cd_map)
>> +		goto out;
>> +
>> +	while (getline(&line, &len, fp) > 0) {
>> +		int retval;
>> +
>> +		if (strncmp(line, "version", 7) == 0) {
>> +			retval = sscanf(line, "version %d\n", schedstat_version);
>> +			if (retval != 1)
>> +				continue;
>> +
>> +		} else if (strncmp(line, "cpu", 3) == 0) {
>> +			retval = sscanf(line, "cpu%u %*s", &cpu);
>> +			if (retval == 1) {
>> +				cd_map[cpu] = calloc(1, sizeof(*cd_map[cpu]));
>> +				if (!cd_map[cpu])
>> +					goto out_free_line;
>> +				cd_map[cpu]->cpu = cpu;
>> +			} else
>> +				continue;
>> +
>> +			dcount = 0;
>> +		} else if (strncmp(line, "domain", 6) == 0) {
>> +			dcount++;
>> +
>> +			cd_map[cpu]->domains = realloc(cd_map[cpu]->domains,
>> +						       dcount * sizeof(domain_info));
>> +			if (!cd_map[cpu]->domains)
>> +				goto out_free_line;
> 
> Please use a temporary variable to save the result in order to not lose
> the original pointer in case of failure.
> 

Sure, will do.

>> +
>> +			domain_info = calloc(1, sizeof(*domain_info));
>> +			if (!domain_info)
>> +				goto out_free_line;
>> +
>> +			cd_map[cpu]->domains[dcount - 1] = domain_info;
>> +
>> +			if (*schedstat_version >= 17) {
>> +				retval = sscanf(line, "domain%u %s %s %*s", &domain, dname,
>> +						cpumask);
>> +				if (retval != 3)
>> +					continue;
>> +
>> +				domain_info->dname = calloc(strlen(dname) + 1, sizeof(char));
>> +				if (!domain_info->dname)
>> +					goto out_free_line;
>> +
>> +				strcpy(domain_info->dname, dname);
> 
> This can be simply:
> 				domain_info->dname = strdup(dname);
> 

Sure, will do.

> 
>> +			} else {
>> +				retval = sscanf(line, "domain%u %s %*s", &domain, cpumask);
>> +				if (retval != 2)
>> +					continue;
>> +			}
>> +
>> +			domain_info->domain = domain;
>> +			if (domain > *max_sched_domains)
>> +				*max_sched_domains = domain;
>> +
>> +			domain_info->cpumask = calloc(strlen(cpumask) + 1, sizeof(char));
>> +			if (!domain_info->cpumask)
>> +				goto out_free_line;
>> +
>> +			strcpy(domain_info->cpumask, cpumask);
>> +
>> +			cpumask_to_cpulist(cpumask, cpulist);
>> +			domain_info->cpulist = calloc(strlen(cpulist) + 1, sizeof(char));
>> +			if (!domain_info->cpulist)
>> +				goto out_free_line;
> 
> All error paths should call free_cpu_domain_info() at some point and
> free the intermediate domain_info properly.
> 

Sure, will do.

>> +
>> +			strcpy(domain_info->cpulist, cpulist);
>> +			cd_map[cpu]->nr_domains = dcount;
>> +		}
>> +	}
>> +
>> +out_free_line:
>> +	free(line);
>> +out:
>> +	fclose(fp);
>> +	return cd_map;
>> +}
>> +
>> +static int write_cpu_domain_info(struct feat_fd *ff,
>> +				 struct evlist *evlist __maybe_unused)
>> +{
>> +	u32 max_sched_domains = 0, schedstat_version = 0;
>> +	struct cpu_domain_map **cd_map;
>> +	u32 i, j, nr, ret;
>> +
>> +	nr = cpu__max_present_cpu().cpu;
>> +
>> +	cd_map = build_cpu_domain_map(&schedstat_version, &max_sched_domains, nr);
>> +	if (!cd_map)
>> +		return -1;
>> +
>> +	ret = do_write(ff, &schedstat_version, sizeof(u32));
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	max_sched_domains += 1;
>> +	ret = do_write(ff, &max_sched_domains, sizeof(u32));
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		if (cd_map[i]->domains) {
> 
> Is it supposed to have NULL domains? 

Yes, It is possible to have NULL domains if the cmdline has isolcpus. I 
will also add NULL check for cd_map[i] to handle offline cpu.

> Anyway it'd be nice if you can
> skip the case like with 'continue' statement to reduce the indentation
> level.
> 

Sure, will do this.

>> +			ret = do_write(ff, &cd_map[i]->cpu, sizeof(u32));
>> +			if (ret < 0)
>> +				goto out;
>> +
>> +			ret = do_write(ff, &cd_map[i]->nr_domains, sizeof(u32));
>> +			if (ret < 0)
>> +				goto out;
>> +
>> +			for (j = 0; j < cd_map[i]->nr_domains; j++) {
>> +				ret = do_write(ff, &cd_map[i]->domains[j]->domain, sizeof(u32));
>> +				if (ret < 0)
>> +					goto out;
>> +				if (schedstat_version >= 17) {
>> +					ret = do_write_string(ff, cd_map[i]->domains[j]->dname);
>> +					if (ret < 0)
>> +						goto out;
>> +				}
>> +
>> +				ret = do_write_string(ff, cd_map[i]->domains[j]->cpumask);
>> +				if (ret < 0)
>> +					goto out;
>> +
>> +				ret = do_write_string(ff, cd_map[i]->domains[j]->cpulist);
>> +				if (ret < 0)
>> +					goto out;
>> +			}
>> +		}
>> +	}
>> +
>> +out:
>> +	free_cpu_domain_info(cd_map, schedstat_version, nr);
>> +	return ret;
>> +}
>> +
>>   static void print_hostname(struct feat_fd *ff, FILE *fp)
>>   {
>>   	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
>> @@ -2254,6 +2432,35 @@ static void print_mem_topology(struct feat_fd *ff, FILE *fp)
>>   	}
>>   }
>>   
>> +static void print_cpu_domain_info(struct feat_fd *ff, FILE *fp)
>> +{
>> +	struct cpu_domain_map **cd_map = ff->ph->env.cpu_domain;
>> +	u32 nr = ff->ph->env.nr_cpus_avail;
>> +	struct domain_info *d_info;
>> +	u32 i, j;
>> +
>> +	fprintf(fp, "# schedstat version	: %u\n", ff->ph->env.schedstat_version);
>> +	fprintf(fp, "# Maximum sched domains	: %u\n", ff->ph->env.max_sched_domains);
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		if (cd_map[i]->domains) {
> 
> Ditto.

Ack.

> 
>> +			fprintf(fp, "# cpu		: %u\n", cd_map[i]->cpu);
>> +			fprintf(fp, "# nr_domains	: %u\n", cd_map[i]->nr_domains);
>> +
>> +			for (j = 0; j < cd_map[i]->nr_domains; j++) {
>> +				d_info = cd_map[i]->domains[j];
>> +				fprintf(fp, "# Domain		: %u\n", d_info->domain);
>> +
>> +				if (ff->ph->env.schedstat_version >= 17)
>> +					fprintf(fp, "# Domain name      : %s\n", d_info->dname);
>> +
>> +				fprintf(fp, "# Domain cpu map   : %s\n", d_info->cpumask);
>> +				fprintf(fp, "# Domain cpu list  : %s\n", d_info->cpulist);
>> +			}
>> +		}
>> +	}
>> +}
>> +
>>   static int __event_process_build_id(struct perf_record_header_build_id *bev,
>>   				    char *filename,
>>   				    struct perf_session *session)
>> @@ -3395,6 +3602,102 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
>>   	return ret;
>>   }
>>   
>> +static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused)
>> +{
>> +	u32 schedstat_version, max_sched_domains, cpu, domain, nr_domains;
>> +	struct perf_env *env = &ff->ph->env;
>> +	char *dname, *cpumask, *cpulist;
>> +	struct cpu_domain_map **cd_map;
>> +	struct domain_info *d_info;
>> +	u32 nra, nr, i, j;
>> +	int ret;
>> +
>> +	nra = env->nr_cpus_avail;
>> +	nr = env->nr_cpus_online;
>> +
>> +	cd_map = calloc(nra, sizeof(*cd_map));
>> +	if (!cd_map)
>> +		return -1;
>> +
>> +	env->cpu_domain = cd_map;
> 
> Where is it freed?
> 

I missed freeing this. This needs to be freed in perf_env__exit(). 
Please correct me if I am missing something.

--
Thanks and Regards,
Swapnil

> Thanks,
> Namhyung
