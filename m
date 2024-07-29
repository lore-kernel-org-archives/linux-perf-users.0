Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858B768FD;
	Mon, 29 Jul 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244427; cv=fail; b=Cq6HYNV9VcS6xsuSeOxglI05IfqTIdcLwwTkPLKdNjEJpjupmPgNz8uwAvv22kaZTfevH7dR2BJTiOL1wu2CHl1FivPQj5G8okxZlVfSB51OPDrxqVeHapXGJ1EEGojDR9+isjysGRzNjzYAEAE1xWnk6AsSF4BIYBCkKN5o+rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244427; c=relaxed/simple;
	bh=ckm7NqyhBe/xoG/z3wsze+H0l3ifTVtrKyoJwbFToYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=joIl9hM412eD7+1v5ooXixqML5cv57rOu7RXP/RWqUga2lXH11SZAKl7CZ6QpS6EoyPl5Tks9+mPAuAQtnMbY4tAmqQEYHOqHP9ztC5C6neDjSKyl3JadBzjLR2azbBzLXZgkbh3TDJj7/mvoLX2nhrcE/+ulb5e4dpTMvieXPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XXFUa1eu; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XXFUa1eu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxEr8NGfZ6eCXqU8Xhxh2TIZCfkPj3KU/zBHx3iGxml00X0uKVKE2QE4fC+Vj9e2Ss6V/FdiXBPqcF73ZReiuFdmFDJhS/6QH0BTLPChYqR1Yt+nSYcHppof4Uj3PP4DrUKdP3UfCSAoD3+VY6RE4ngAXLHYhflfDCOLW+JW+Qyoe3mAusufjEuAufFbVEbzVmiEM3k8FOPKyv/1f4yngN8tQYaEj6O7NYRweTUW9k/ZhNwPT8VXQ6q3J2CVxPc1NPL/mTTwPedcru5v2pnp0UYM61uVr6mLgVFfufXg1OITYAQQuOQ2+2x+GoiQ2Ib0cDBQzwINELyQzWdrXT7Emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1iEGYwACQfLTVr00M/HZJrFVKkn78XopS4c3NSvlI8=;
 b=HTTvLQ3z3A1gA8g5a5At28jgRUQji116E49ejAsY8ADHDF5JFd+QV4/a2AibpOBbvtTXsE3i2eTmyM50LzOJSrGJBpJf4dnDh5HeQ46dut3e0ipUiWipzEq75ndKcJD1/itfH/r84uSP0ey5yDtjUy5yv4UzVZeh3d2ke/sQmiDuGegqO1AhcF3EHGw6xKyTrTpK3UWoOGi17zjDkz4eRybzmxsoJvcS6msp42cuiGheWKJWDTdoVRL8ETiGVlCGHi2Ha34PflctmJiB1wwD47WfqTa3OY5Qld2aL501kYSOMtbBEj9uwhOmRqmN4RjwoVAumzGqKtlkFIsClkRbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1iEGYwACQfLTVr00M/HZJrFVKkn78XopS4c3NSvlI8=;
 b=XXFUa1euNpuGEh36WonRf4kysMilGmvMKFPSqNPZKnusw3CRo3KeVy12hNlLvj2B7QSr37YtWjDkDDXX6FvoeC2VGkpgYiKlKI2tad2zAiUBwjTZNHrR/JPc44HbbGI/xbwfh//MmRz43ksAxm1zWQS9NuZT81rChQ88wZiJY6M=
Received: from SN7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::29)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 09:13:41 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:123:cafe::aa) by SN7P220CA0024.outlook.office365.com
 (2603:10b6:806:123::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 09:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 09:13:40 +0000
Received: from [10.136.40.92] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 04:13:33 -0500
Message-ID: <132ddbbd-5afc-8436-9db6-0f1add4bcec1@amd.com>
Date: Mon, 29 Jul 2024 14:43:31 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf/x86: Fix smp_processor_id()-in-preemptible warnings
Content-Language: en-US
To: Li Huafei <lihuafei1@huawei.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <kan.liang@linux.intel.com>
CC: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <ak@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240729114541.3517574-1-lihuafei1@huawei.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240729114541.3517574-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: fce7c3fc-c580-4350-308f-08dcafaebc77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVlGKzZjenJCZ21Uc1FhdTJUQXMrc29ZdVhhM0NJa1RqREpCSC9IM3FzU0pj?=
 =?utf-8?B?eUI4dDlBYy9ZT2RPSEthTngwdUdPeHhMWGJmeHBuRmQ5c3B0ZlNZRUV2c3hp?=
 =?utf-8?B?b0Q2VTQ3L0pMOFIvSCtLMU9yRStRem0vVHQwOGdLSDR1NUxIMmxaT2R5Qllz?=
 =?utf-8?B?bWFCQ0xPUzI4TnJhUmZraDNSZGZsSDFvVVZ3ZzRPRlpPTTZ1SDRSNlRHRXMv?=
 =?utf-8?B?eXpFeFlUYjNJblZTWTRvVlZmVy9Vb2hZKzdJSW9ZWjlhRmVmQUIrVWU5QVNq?=
 =?utf-8?B?R1BTVlczNnlhNk03ck5iTmd3SGZZOW5CRkZwTnRTTE10Nnp1ZUd2VG1TT1Vz?=
 =?utf-8?B?cUpPSUJCejdpcFBMdVk4cGV2Wmw0QmRBYUVTb25GYWZEWHBiS3ZsaXRGWjNW?=
 =?utf-8?B?WWtOcVN2YlhKbWZ1MGZvYit6bmdpZTJ4bUtrRVlRMUdJQzRrWUpobGlTYnpD?=
 =?utf-8?B?TCtVcWI4SlRFaTRlcE91ZHlIalRWNVB3Q3JzNVR5bzM2VlFGUTF6eU9WbGls?=
 =?utf-8?B?cDVSWXU5NURCa3gvV28rdTlsUzYyMnRjTUxOSWZFZEFRbzdJbys1TmFnVkY2?=
 =?utf-8?B?aVZibk93MW9LVUhoQ3B2Z2FQcGRHbG1uUjdmWlB6UkdlM01STzlValg0a1FH?=
 =?utf-8?B?ZUFTWEYwT2ppeW5jeW41NVRMblFpeWRLbGdoZVpseXIwWVoxM29jTFRyenpo?=
 =?utf-8?B?T2ZIamFOVCtwUUtKQkxSRUxERmZ0NkpIR0tGaTRPWmg2TlNnL1VkUmRhS2pB?=
 =?utf-8?B?cUNTS3NNUHdqRE5OL01ZQTNqUUZNMzlDbVpJeXJPcmgzWVJhaEd4b1NNb0Yx?=
 =?utf-8?B?Y0NQZmlmby9TdkZ0LzFCLzR0Q0pZM0Y1dHkrTWNvbmhxZWlHenNNbDBZRnVL?=
 =?utf-8?B?L1ptODRTWjA2L0lKL3pUSkVyZW5IU0VrTXg0V3ZuSzhOdk1rbUlmdzlaV1o2?=
 =?utf-8?B?QzFIVWdDcWY3dk9ScGQvazk5bUwxdk92L0NoZkpURC9NLzZhc2NhTGl4YnAz?=
 =?utf-8?B?SXRsSGpadkVxVXlyUVM2S2lIcm5Xc2loYWo5TFVEbzVKb01mc1NnZjhOaVAr?=
 =?utf-8?B?dnY5SlNMb1VlbW1nWTk5TkVSeVpWaVpqRnpFYXBmTzcrQUJCQ2FtamwzUWhi?=
 =?utf-8?B?WTRveGtSemhoUUNmMnpJN2d4QmJzekpaYjN1ME13YlUxeHlEbDFTeWRpbWxJ?=
 =?utf-8?B?cGgybkp2aTF6UFdnRXlhR0hzazI5Y2JYUWhCazV2S2M2TG56dElBNXl0Z0dr?=
 =?utf-8?B?aFI3UkQ5UXd0UUFQODB5SjdtS1dyTmxMM242dlJaN0V0QlcxeGtwWXVqRGZV?=
 =?utf-8?B?OERnMEwzNTJ3UnB4cjZCTGhiVVhQNTE1a2RTRFZIWHpsYk5Yd0hiL1lIRzEw?=
 =?utf-8?B?a2VKcXFKVWRqbnM1S3hKSFZUd0UwbUFHWDJJK1N5MHg2T1Ftd3gxYWNGK1Z5?=
 =?utf-8?B?N2V4TitnVkpza2F2TjNhOWVqc1ZyZThzYWhjY3VtZncwcFArZ1lGaUswL3FO?=
 =?utf-8?B?VVhLWXpsa1FlMW9WUUQ2MU1iSHFWbWRyVmJqZFJiT1EyZkdSVXBNM1IxWDdJ?=
 =?utf-8?B?MHI5Rm1YVFMvSjUrWm5lSTFCZmxLNDY3eGtRaWJnWGJXdnVETXU1SkNnalda?=
 =?utf-8?B?NVk4dlB3VHJzMmQwNkZHVjVwTExMaDMvZkhVNEMvNU1MMDVHMDQwMjZVbDE5?=
 =?utf-8?B?OUd0SVZkaXZqdVM2NG5GTHVROEo0a3h2NE5NZXZpV0MrT2JBS3VjUFhsenQr?=
 =?utf-8?B?Z0tzbHJ0TFhTeW4zaVRZUXpoNDQwUU5XT1NibGYyblkveWpWYlAzT3FKRTc3?=
 =?utf-8?B?ZHo5a3I0S1VEbFlINHV0N2hqcHZpdW9yc1FZSmJEZm41Z3JOeTF1aTF2NWdv?=
 =?utf-8?B?ZGJzZDFIaVBvTFloOG1adkZwUUJnT2QxOThJNFg4aElMbzFxaGhKSXp1bHRt?=
 =?utf-8?Q?KyPDzB2UtWgyCBYUoGCBSgMf1Vohw/XB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 09:13:40.0084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce7c3fc-c580-4350-308f-08dcafaebc77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280

Hello Huafei,

On 7/29/2024 5:15 PM, Li Huafei wrote:
> The following bug was triggered on a system built with
> CONFIG_DEBUG_PREEMPT=y:
> 
>   # echo p > /proc/sysrq-trigger
> 
>   BUG: using smp_processor_id() in preemptible [00000000] code: sh/117
>   caller is perf_event_print_debug+0x1a/0x4c0
>   CPU: 3 UID: 0 PID: 117 Comm: sh Not tainted 6.11.0-rc1 #109
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x4f/0x60
>    check_preemption_disabled+0xc8/0xd0
>    perf_event_print_debug+0x1a/0x4c0
>    __handle_sysrq+0x140/0x180
>    write_sysrq_trigger+0x61/0x70
>    proc_reg_write+0x4e/0x70
>    vfs_write+0xd0/0x430
>    ? handle_mm_fault+0xc8/0x240
>    ksys_write+0x9c/0xd0
>    do_syscall_64+0x96/0x190
>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> This is because the commit d4b294bf84db ("perf/x86: Hybrid PMU support
> for counters") took smp_processor_id() outside the irq critical section.
> If a preemption occurs in perf_event_print_debug() and the task is
> migrated to another cpu, we may get incorrect pmu debug information.
> Move smp_processor_id() back inside the irq critical section to fix this
> issue.
> 
> Fixes: d4b294bf84db ("perf/x86: Hybrid PMU support for counters")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>   arch/x86/events/core.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 12f2a0c14d33..c0157a5d8296 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1521,19 +1521,24 @@ void perf_event_print_debug(void)
>   {
>   	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
>   	u64 pebs, debugctl;
> -	int cpu = smp_processor_id();
> -	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
> -	unsigned long *cntr_mask = hybrid(cpuc->pmu, cntr_mask);
> -	unsigned long *fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
> -	struct event_constraint *pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
> +	int cpu;
> +	struct cpu_hw_events *cpuc;
> +	unsigned long *cntr_mask, *fixed_cntr_mask;
> +	struct event_constraint *pebs_constraints;
>   	unsigned long flags;
>   	int idx;

nit. "cpu" and "idx" can be defined together and this can be converted
to use revere xmas tree order.

>   
> +	local_irq_save(flags);

Perhaps use "guard(irqsave)();" here since ...

> +
> +	cpu = smp_processor_id();
> +	cpuc = &per_cpu(cpu_hw_events, cpu);
> +	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
> +	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
> +	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
> +
>   	if (!*(u64 *)cntr_mask)

... a "local_irq_restore(flags)" is required here now before returning
and using the guard can avoid that. Even the flags variable will no
longer be necessary.

Thoughts?

>   		return;
>   
> -	local_irq_save(flags);
> -
>   	if (x86_pmu.version >= 2) {
>   		rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>   		rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);

-- 
Thanks and Regards,
Prateek
