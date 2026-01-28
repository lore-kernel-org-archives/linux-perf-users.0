Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2C37417E;
	Wed, 28 Jan 2026 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624993; cv=fail; b=kln0cRAzqLkPEu3unxeYKTZr1qPbocB1NJzh60djdqbuALAwqQkD4fNmWS9C4BD1LKWo3xPUzj6tMSciu/6qM3+0nydFdMfQqBfaG9Exb40OO6g/ZqZ3WpspjlqNxnYCXQPqHCy64RKnN23MXKsXPHkomhZ9b7u876/yXZ66NlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624993; c=relaxed/simple;
	bh=gA/snZ+d1CJnJhdA1PxeIAeSglOF4xMxMeuON8Zy7BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R7fq/16m6i4BdWJ0GCEnCYA6/v1qK392bQ8+XA0tkOc/CMzcmO+1ftrBEc3mdbfYAokKMCyvrKoWgE1fXb8FW1B1i1jBQQCnu3TxkX/XbdFP9NIL+jQDx+lAOKaDRIDXf11dD6ijrt4Y4XD0diJt0d2gMC6c3XxufI06avUit9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i9ZBqLb0; arc=fail smtp.client-ip=40.93.195.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i9ZBqLb0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p09qfjwVVhplr1I+bHdS1SNbgfH2OsBVp1ieH/84suE5mZpZiUWs/Z8t/tKfeI8VzZQ+tB7iyIfU4vvdVlyH1f2hmVSAXjmgCnFJ7xaTDEVyaJubwjHOtgSt8BGaexGmiWXTugKFTLpMwstrHwAVkZP/tMenDa1k/Gbo5BBQbMx8E2Hwm3SBdLEkit3UnKC41woBBNfGMXIrOB8Hu5gCTTzc7Ow0LyWqCcgwRQXdch90vPVopGKnGxt8Y6hXoQgbk8rurc/ZqcM2I6v/w4S5Gw8bKIROm2hF56480vdLoXKGEIw6FPbK0bYf9F8hnt9Hkw86k7PupTiPatyrSPNF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF21jrQHNAPvBO+CLe6baJ8qOQDCAXAI1jr4RiobYGg=;
 b=PdGmCOnSFvzj8REkAlYrIYDWX6lS4o4GsBFFCp8ShbhitpGgMYE6S0rBbC9LgCFJ+9f3LjcjacEhmxX7c1VTUmunC/SCPj56w0xntteLIrsn/m3LrtpqXuO+EkpqIOZ5MKjk+IzIazcWFlIpXqZnpzCnXGOR9XcO2W6Ht4jJ7eh/RBe0p8zSi3c3CmYiuwOwJNl/oVRzCJ8p7RUx1hXKBDYA6xSmudaICV3WkTduaswjVwCrmQPsAXuCo2oeSsov/WaJIlgoKyTQOOahfKmoE5WkIk+dJgXZ3S+VbBtTJ881lI3t2dF+VvLy9d4CCyJTtDg8swndAeq6/hw6WCBovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VF21jrQHNAPvBO+CLe6baJ8qOQDCAXAI1jr4RiobYGg=;
 b=i9ZBqLb00FheZeHslMkS/GIhJ/ZGowkOBauU81AUCyhGR2ZAvMZ1/XaIftFEo/siINcAYy+/rJvXgoKA2ycuLzeVz0J4euIvNFyHHS6L/4+xAFA6Av+SfjqgTar7oXPX33DMtPnZCYX7SnB+tAiYsaRysj4pwJrpEGlxBXA/F24=
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:29:41 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::ae) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 18:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 18:29:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 12:29:41 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 12:29:41 -0600
Received: from [10.252.192.223] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 28 Jan 2026 12:29:35 -0600
Message-ID: <4da60acc-cbce-4cd2-9600-8a151592d122@amd.com>
Date: Wed, 28 Jan 2026 23:59:29 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] perf header: Replace hardcoded max cpus by
 MAX_NR_CPUS
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Shrikanth Hegde <sshegde@linux.ibm.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <thomas.falcon@intel.com>, <ashelat@redhat.com>,
	<yu.c.chen@intel.com>, <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
 <20260127185000.431884-2-swapnil.sapkal@amd.com>
 <0117fe41-0016-49d7-bc73-1ec682ca8783@linux.ibm.com>
 <50e3ac65-fc5d-47d0-bdc4-5c8c1fc8eac1@amd.com> <aXpSSaMdBhKDRzsY@x1>
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <aXpSSaMdBhKDRzsY@x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8c8a15-2ccb-494e-66ba-08de5e9b33d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M09rWXdScndZdkl5dHA2b0hoVkFxN1NrSXNuT24xc0lJQTUrdzVLcDI0T2c2?=
 =?utf-8?B?UWlFZWVnZ0tubjUvaXIxd2FYeldDN2hVR1FFMVFaS2VVREw0QkdFd2VPYVov?=
 =?utf-8?B?aEdKeExlQlgzSFMzMGp6TW54ZmVNV0ZGejBva2RQQ1AyZzNHTUwzZTR3SGpE?=
 =?utf-8?B?V3BxMVN2OFNzc0lRaitJSGs3Q3BZMUI5ZFl2aHY5TiszZGpnaGpZT0o0L3Ay?=
 =?utf-8?B?Vm9LVURhZEZTUDM1aGJzd0YzUi8zV2c0Unh0RGsxZHVNRzlFWnpSN3p1cmNn?=
 =?utf-8?B?Vm9pOElQdDU2bUxaeDZlRkJabStkUEtlZTl5bmdpUWJ1VUplMXRRd1VtVUFu?=
 =?utf-8?B?TkN6ZkJSR1N5SGZRN2hSQzJhcjBsWUkwVk4vdm9HdEFSY1dCdlZhVFdjeUJG?=
 =?utf-8?B?T3o2OFVzQU5rNFdySWM3cUlvbzNCSXlCQnprTitIOFFseGQ3elpLUWNmZFpK?=
 =?utf-8?B?OG94MEpUSC91VENTSGpJcXllRjhHN08rV0FWSXJEWVVkdkpzaHpSNTd1czhY?=
 =?utf-8?B?Yi9tS3Q5V0JvcDVjU1B2ZlpWTXVlZ1RvNTZIeTkzWUhDdUdxR3hlNC9lRTN3?=
 =?utf-8?B?dmhDWVBMb2d6MThnNDZsM3R2dWJGZmNzRXBLVHBsbWZHZEtIUFd5YlhCSE5o?=
 =?utf-8?B?NG96OTFHdytMU2pma1F4cFY0MkdoYnhTNmMzRHVrc0tVTit3MFFBNzluaThY?=
 =?utf-8?B?TlJsTFZtc0JSOUt6dnZIRTAvUEN0bFBJTUs2L3UvbHZCd3FjSWh2TkwzNjRW?=
 =?utf-8?B?OStyazBtR21PcS96dE1HWDFMQ2c2RFU0NURaWFRCSS9WOVNVYnlXNFNnMm9S?=
 =?utf-8?B?aW5IUC94SStCb1BLTGN4MFRpVTBhczVNaEY0S1FQRDQwY0NYYW9sMkNXR2k1?=
 =?utf-8?B?RHArVU9VQURlNlR0MGNWTXY5S3FTQkkwd254WFNVdlBUOUl6d3pRL2tFM1ph?=
 =?utf-8?B?a3JsalYyczhhbmQ3SkhmY1dXQ2NURHc5V0VuQWY3bkVWM1ltaVFHQ0NYNGlZ?=
 =?utf-8?B?alNmYmkzcGc1T0FyODR4VkxSekV3cUxmZmFxNFhJR3h4RHJwKy9lM2xIZ00x?=
 =?utf-8?B?MmhkVUUrU2tZVnJCS0orV2h0anhlQVkwWVU1TGhvNWhZNU9qVkVaRmE1Mzln?=
 =?utf-8?B?bkh1YWFtS1NIMUVvRHJjT2pLa2RrdjJPR2Mzd242K3h6NmtsWnR2bGhRb1VK?=
 =?utf-8?B?VENVa3J6QVNNN1dDemY0RUNHTVUyTGpzNGlzVStuck14bHR1eE52SkVpYzZm?=
 =?utf-8?B?U3lUUGNCRzU3ZjlxS0s4QTl5QzBFU1RmdEdJQjVyZzZmdzkxZExBVWVOV0FG?=
 =?utf-8?B?MEd2WHhkT1VPYy9mSFlNZGkwMHVjUFJyT1ZWeUlGNXZjeGppSUpVQVRjRXV0?=
 =?utf-8?B?K1laTE1qYk9JUGJlYTBzTXNQYTAvTURBc1RVSWtxUXdIVURoNEpJZmluTnRx?=
 =?utf-8?B?b2VNVWhLKzUxbU5ObStFSHdlNjlaWE9NdzBlQkF0Q0c0WC9PdG1vVXVMc0lX?=
 =?utf-8?B?Z09kWHU1RFlIb29OOVhUdjQzczBOY25kbjFwWC85TE5jb2pDek9mem9vZ1Rk?=
 =?utf-8?B?UTRWSkk2bzNtUWtDZ1BsMHhJaUlXY2p1UlpqSGxxMHVlcU5WcC92djFsUERL?=
 =?utf-8?B?Rmlnd2g0Si9iVllDYnlBK0J2eHZRRm14a0krb256aFplcitLQzE0cnAyczNR?=
 =?utf-8?B?d0VoZGdLdTQ3d0JEdklzSFhETHJqUnZTUzhUa0g0RlJlSEhwd2pheGVoM0tm?=
 =?utf-8?B?NVp1alZOK2dDTWJRU2x2QWRvME1qUlpXVXE3eUJZVDZBZ2M2OWFaZnhFTDk3?=
 =?utf-8?B?SGJ6NURSaCtsU2hMckRpZWZ6N1dwL1lxOHkydVpIeXphT3lEZHRocWlPZFVL?=
 =?utf-8?B?Zk5JWkExbGpFclpqR0k2Rk9wa1hHd0dQZG5zWXBaNlgvQnpTeHQzWHpxVHdD?=
 =?utf-8?B?dFg2TGRzT2hOSWFDZ0dPb1JNV09QZ0NZeE0rSEM3S09CV0RlL05hbTlnbnY5?=
 =?utf-8?B?dUI5SHNOYnNRZnh6Wk1UZUlkN1FTc3VLM2FiMHZvSEkyTnlPQ0cveTdrV3hz?=
 =?utf-8?B?Mys4MG9KaWJldWRpUldWdHZ3elVYeGFaT1ZFQTJSNFBFYXlwbnNmZzVJSVR6?=
 =?utf-8?B?aEhWYWdHaGo1OTlsbnZaZGczVEtld0hYSENlczEwUERobWs3cy9QVE1oUVhx?=
 =?utf-8?B?T2sxQjRkWDJadTY1QlNDL2N2elVsNElRS1dKaXlwSFJ2cHVyNnhyUFpReGxo?=
 =?utf-8?B?YUxYQ2FiT0lKUWJzT0ducGVaNmNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:29:41.4745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8c8a15-2ccb-494e-66ba-08de5e9b33d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857

Hello Arnaldo,

On 28-01-2026 23:45, Arnaldo Carvalho de Melo wrote:
> On Wed, Jan 28, 2026 at 09:55:05PM +0530, Swapnil Sapkal wrote:
>> Hi Srikanth, Arnaldo,
>>
>> Thank you for reviewing the patches.
>>
>> On 28-01-2026 13:09, Shrikanth Hegde wrote:
>>>
>>>
>>> On 1/28/26 12:19 AM, Swapnil Sapkal wrote:
>>>> cpumask and cpulist from cpu-domain header have hardcoded max_cpus value
>>>> of 1024. Current systems have more cpus than this value. Replace it with
>>>> MAX_NR_CPUS. Also define a macro to represent domain name length.
>>>>
>>>> Fixes: d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
>>>> Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>>>> ---
>>>>    tools/perf/util/header.c | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>>>> index eefd1cd73b6a..31c3bab1b10a 100644
>>>> --- a/tools/perf/util/header.c
>>>> +++ b/tools/perf/util/header.c
>>>> @@ -76,6 +76,7 @@ static const u64 __perf_magic2    =
>>>> 0x32454c4946524550ULL;
>>>>    static const u64 __perf_magic2_sw = 0x50455246494c4532ULL;
>>>>    #define PERF_MAGIC    __perf_magic2
>>>> +#define DNAME_LEN    16
>>>>    const char perf_version_string[] = PERF_VERSION;
>>>> @@ -1616,10 +1617,10 @@ static int write_pmu_caps(struct feat_fd *ff,
>>>>    struct cpu_domain_map **build_cpu_domain_map(u32
>>>> *schedstat_version, u32 *max_sched_domains, u32 nr)
>>>>    {
>>>> +    char dname[DNAME_LEN], cpumask[MAX_NR_CPUS];
>>>>        struct domain_info *domain_info;
>>>>        struct cpu_domain_map **cd_map;
>>>> -    char dname[16], cpumask[256];
>>>> -    char cpulist[1024];
>>>> +    char cpulist[MAX_NR_CPUS];
>>>>        char *line = NULL;
>>>>        u32 cpu, domain;
>>>>        u32 dcount = 0;
>>>
>>> Looking at
>>> https://lore.kernel.org/all/20260119175833.340369-3-swapnil.sapkal@amd.com/
>>>
>>> There was one more "char cpus[1024]"  in tools/perf/util/util.c.
>>> You may need to fix that too. It is unlikely but, if one has created
>>> exclusive
>>> cpusets comprising of only one cpu from a core, maybe you will run out
>>> the length.
>>> So better use the MAX_NR_CPUS there as well.
>>
>> Yes, I missed this.
>>
>> Arnaldo, can you please consider the below diff? Let me know if you'd like
>> me to respin the patch.
>>
>> --
>> Thanks and Regards,
>> Swapnil
>>
>> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
>> index c83e59e8c787..3795d5182ce8 100644
>> --- a/tools/perf/util/util.c
>> +++ b/tools/perf/util/util.c
>> @@ -262,7 +262,7 @@ void cpumask_to_cpulist(char *cpumask, char *cpulist)
>>          int i, j, bm_size, nbits;
>>          int len = strlen(cpumask);
>>          unsigned long *bm;
>> -       char cpus[1024];
>> +       char cpus[MAX_NR_CPUS];
>>
>>          for (i = 0; i < len; i++) {
>>                  if (cpumask[i] == ',') {
>> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
>> index 394dbfa944ac..c43f17137efd 100644
>> --- a/tools/perf/util/util.h
>> +++ b/tools/perf/util/util.h
>> @@ -6,6 +6,7 @@
>>   /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
>>   #define _DEFAULT_SOURCE 1
>>
>> +#include "perf.h"
> 
> Why add it to util.h? I'll add it to where it is used, util.c, ok?
> 

This doesn't need to be in util.h. Please move it to util.c

--
Thanks and Regards,
Swapnil

> - Arnaldo
> 
>>   #include <dirent.h>
>>   #include <fcntl.h>
>>   #include <stdbool.h>

