Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5120ED;
	Tue, 30 Jul 2024 04:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722314184; cv=fail; b=Gh/bHx/HG16kUIbKT6pa2iVUheNgWaoF+vYlnqS26/vHlSNmDpfTRwYqer98c5Ge9zubgsdeli4ozfZ3UibMdeSSnG+gIm+g4YI+DA043Uoy82Zn92u66LsoY2VTt/KnxFGxMDNwUJrCC/xd0tm9HHfkL/R0e5lQvSj9JoECIIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722314184; c=relaxed/simple;
	bh=sCmT7tkd8GWoeRPeb6QHcAOoYt863fAVcLf7D8RCS/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BSkcTWP/P/6v4LeGdXPUX1dy+tsIVDWllkhL6a3qQ+tBkNjhIZKD4FuxNSqlEdXnAE5NeMlCavkhsnkcYsVzqMyieLlRVOAM9x2RZ56PZGxQVJ0sbqLzATycccdX6ShCeKIcoqvdbFN8zpsa2stuMgQ95pswco4egc2c5Myx9PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w3Ds98qH; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w3Ds98qH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vD7QjLDLipAnEigX7ydWlOjbCxBRqxP/alHVBmuvCtY7kvEkIMJkH0yBbIaurgABYdr/0h2rG3pxqUbbskQT3XGWS69rv+GVMa/gJsCV4wk7ipdejIE4umQtLKRbxHOnw6wx2nvyEJ/hHOxWmuqLVuHI2RZ+GhsZ+5p6a4XuVBKL2hAVzK9mBYN+7+EJIsA1dczEtlzWe4Lwu6sTtp9vzvVIW2B5bErzIEIEZoAkx3U+sOY2evTEbi0E5LsciNFDR2IsDPv+df7+Xag7zdWYCuF3Fmp1FIZiPz0kxjdrcRjJjs0yv7HPZNTF/JolW1U/3SIuIqVy1F55e8bYi9aV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hO6HgHUahkh1wHAtftq7y/6bNCvXD+OftFRHJWYARvs=;
 b=VNBoWJe7rMNY/1t6DZ0yxCKwHOaaNkwZwWGW+1+DBuA5Ipzr80gPk+67Loy6QZwM7HMmfQQmsPeES8oH93ExDc6OR8t04HMrq3t8Z2OBZCREBZljS3Q5c+X/quEIPaioe07Ufh+LqWhpwTUtkUZPRxc9tih1xNzsSVttUNUGtFe95czQ2Lo8nt1bgKLqbqpvIGz6AEjV2B3x+b6nqoekAyndPC/TLX07pXY67GH/NoqxauDqpv3sqOJhSn0RKmlIt9PQ1l+JzUo+TCDHP8YQUnS3sipHLYzzAsTSzdWjLS8ApItGyly5RueJfJeId2CbB1UkXOtzxruMAM256QmRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hO6HgHUahkh1wHAtftq7y/6bNCvXD+OftFRHJWYARvs=;
 b=w3Ds98qHeuGgMPRyOb+aWlbEEyICUzY4jUa0SdJnA4qPP9sem2KwU2B15+KF0b4/RSTZjoZ4zxoRE+5c38/SHrfyhQn4UxdNjiEV8QCeEcWdrpZm+1qLiKAs/RC0tcb04udrai6doEjozC//rexfbG+bsW0cPMhDBtj/cPUTih4=
Received: from MN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:208:530::35)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 04:36:18 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::25) by MN0PR02CA0017.outlook.office365.com
 (2603:10b6:208:530::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 04:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 04:36:18 +0000
Received: from [10.136.40.92] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Jul
 2024 23:36:13 -0500
Message-ID: <5a49e8fa-d7db-a380-174d-b44b34db62ae@amd.com>
Date: Tue, 30 Jul 2024 10:06:06 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] perf/x86: Fix smp_processor_id()-in-preemptible
 warnings
Content-Language: en-US
To: Li Huafei <lihuafei1@huawei.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <kan.liang@linux.intel.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <ak@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240729220928.325449-1-lihuafei1@huawei.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240729220928.325449-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 63166cda-96d7-4d07-ddf6-08dcb05127b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGxoRk82cjM5SDExS2NqaWp2amR4YjJId0JNNnFldk4vVXltS1ZxVHZ3SURz?=
 =?utf-8?B?aDJFVVNtVW1qbFBhbDlRWWJWMG9YOGhrcXdBb2FUbWdGTjE0MzU0ZENUTElp?=
 =?utf-8?B?QlFOT09oemtHVnVueG5DZEpjMzNLQXRETmo0K0dmd1B1Y2tqemNFbnRYUSs0?=
 =?utf-8?B?cmFRYm5OMzJvMklTWUR1dWpJSGhxdjlITGhTS0M2VVI2OGJuRG5yRTd2eXZM?=
 =?utf-8?B?SFRCNW5Edi9kdVlrbHR2bXJtSFRDS2Y4MnFhT3VRaGJHdTF3ZUdUQjdsbUk0?=
 =?utf-8?B?dGEvNnhFUGRVSXhaMnVhUlNRVVZaN3JLdnFOeGtTOWtCOEtwODFNb202Y3RQ?=
 =?utf-8?B?UTloSUw1a1JaQ1E4QUZ0MzJRZlUzV1lLYU8rdzkzV1V0VzhPVTZ3SjBDcGJm?=
 =?utf-8?B?bVZEcnRqbkFpWnFQek1GTGxMVDBCYmpMV1lQV24ydmM1V2dRVmpJSkV3dVFq?=
 =?utf-8?B?QWpCSlpSTC9rVU1BcDZpdzJLaXhYOE1MUWJJbkdZWFE4cU9RU0VzZmJ3V3hm?=
 =?utf-8?B?bEZXTlQ5RWRQYkJack4zSzZ3ZE9heUIyU0lyOGtQRU1KdDE0RytnNjFWa2pK?=
 =?utf-8?B?cWpDRFVrYU1PMXprRVRmWHFUdHVHV3E5SkZXTytUVjBiejU3TTNKaHlQV01O?=
 =?utf-8?B?eUZXN3RGZWtWOU80bUpOS0dmN2hjZFg4M211NmdTOFgzZXJyNFIvMVR4TFZ1?=
 =?utf-8?B?bmVRbEVSMUR4TnUxcFFZUzNLOFRZUXBCa05rNFZNbEE5dkF0bi9HcmtlMlov?=
 =?utf-8?B?amtaam1yTStTRXoxWHBGV0lJSVdNMnl1Ui8xRmNnNm8xMmhsOEZyVWZ4NDBJ?=
 =?utf-8?B?SnpaYW5jeXd6RkZoVWM1WW4rMks5Sk5xTzRLTGxJRWRQcTBiY3pjVDE5Z3d0?=
 =?utf-8?B?cXFyOURRUFVmaWlRcUZEL0xjS2NTY2FoWlNoYmQrSTZIUVRnd3pkdkN4WXFw?=
 =?utf-8?B?OFA2ZG9oYVpmYzZWM1RWNDlUQzNKeFluZkZIY2dZZklHc2VyNVRSMzRFNTNh?=
 =?utf-8?B?RWpRTERxbEczQ3NSajNjNG9nNUJnTDlLa2ZDS1JMNnI4ZjdwS2RtV2NpZ2Fs?=
 =?utf-8?B?QlhYelBoOFBKVlhyaDRXZWdSa292Q0dTSXNveVpGaTE1RndyT2xYRSttTlA3?=
 =?utf-8?B?b25YN29NV2hSK2tqZThVblpYd3JkMkk5MDlMTjBPUndxL0JCWTMxd1FsVWpW?=
 =?utf-8?B?RUVIYUlhUFN6STAya1JZUGlZeG1neWlUMW1xUGVsS056TGkxVDdhUTNVMVZE?=
 =?utf-8?B?WTJabmZ6eExsWkxyUWZQYTl0TUhwY3dhenEyNDF4azJ4R0xFOFViUWZBVFdo?=
 =?utf-8?B?QmlSTkh1RDZRWlVLbVk2bklvZ1FLNjY1cUZEY3gwa2l5TXhvQUZNdGQrSGpL?=
 =?utf-8?B?MG1nczMzc3gwV0xkbXJicGNKcisrRFQrSDhSZHhlUVBwVHBCS1d3YXIvM1Yv?=
 =?utf-8?B?MVE5cFd0Uk9NWTZzUzJ5SUt5Q2VyRW1hTU5RTktNWWtscUtzN0tRUDc5RTZZ?=
 =?utf-8?B?QW9qNi92MUM2dlFqc3BQN0RyZGlyWG5BcXRYY3FkcnlqUi9EUFR3QjBybDAx?=
 =?utf-8?B?MUowYTQ3MjgrWlFENURKN2plRFBuTXZTM0FDNWhlQmdNQWtRMzF2em1MKzJk?=
 =?utf-8?B?RkRKSlM1S0lCSHIvZWM0K1FCd0plMEJ5MUtPM04vWStBdFh5eEpiN2NpRXR4?=
 =?utf-8?B?WnhvSjA5dndhb2d0WCtKQWJLazRGWmRiZFZVUERNa0RoUnp0N0xwWmhpNEdq?=
 =?utf-8?B?MGVpTjh3VTZ0UGRnNzBNdXBDVlhsdHQzRE4xYm1yTkp1OWVUbklibitwOC9G?=
 =?utf-8?B?S3ZEcnVya05TUnUyWkdOUXk2OUNuK3pWMCtNWjdBQnd4b0E3QWxTeC9pdmJO?=
 =?utf-8?B?MWQ0aDB6cDRWVTdRZ29nWWRFTFBXdURKbjFoWGs5WFBRbTdYZGFuaEkxdWNx?=
 =?utf-8?Q?MBT+bfzFKM2FRBLBNAPuuIPLCpBM2J5y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 04:36:18.4212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63166cda-96d7-4d07-ddf6-08dcb05127b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043

Hello Huafei,

On 7/30/2024 3:39 AM, Li Huafei wrote:
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
> issue.> 
> Fixes: d4b294bf84db ("perf/x86: Hybrid PMU support for counters")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

I can confirm seeing the splat on current tip:perf/core with
CONFIG_DEBUG_PREEMPT=y and can also confirm I no longer see it with this
patch for the above mentioned reproducer.

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> ---
> v2:
>   - "cpu" and "idx" are defined together.
>   - Use guard(irqsave)() instead of local_irq_save{restore}() to avoid
>     forgetting to restore irq when returning early.
> ---
>   arch/x86/events/core.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 12f2a0c14d33..2cadfdd8dd99 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1521,19 +1521,22 @@ void perf_event_print_debug(void)
>   {
>   	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
>   	u64 pebs, debugctl;
> -	int cpu = smp_processor_id();
> -	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
> -	unsigned long *cntr_mask = hybrid(cpuc->pmu, cntr_mask);
> -	unsigned long *fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
> -	struct event_constraint *pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
> -	unsigned long flags;
> -	int idx;
> +	int cpu, idx;
> +	struct cpu_hw_events *cpuc;
> +	unsigned long *cntr_mask, *fixed_cntr_mask;
> +	struct event_constraint *pebs_constraints;> +
> +	guard(irqsave)();
> +
> +	cpu = smp_processor_id();
> +	cpuc = &per_cpu(cpu_hw_events, cpu);
> +	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
> +	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
> +	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
>   
>   	if (!*(u64 *)cntr_mask)
>   		return;
>   
> -	local_irq_save(flags);
> -
>   	if (x86_pmu.version >= 2) {>   		rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>   		rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
> @@ -1577,7 +1580,6 @@ void perf_event_print_debug(void)
>   		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
>   			cpu, idx, pmc_count);
>   	}
> -	local_irq_restore(flags);
>   }
>   
>   void x86_pmu_stop(struct perf_event *event, int flags)

