Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E512517A5
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 05:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943757; cv=fail; b=gIVnxqgNJPmONl9KFk2E69bXyygwTc4WuvMMISJPcf6xR5095JvUD10/IWdRSnF7/JE2D9z/07y4AtKE7YeQOY/fLuP7r2u+GkaHaVcFSeZUmFtTqP3Rgj9Hk7FLU56wRZNol6N1o0ZBNp04UtO5M34i4U8QpZ21ZQTBTV4wWkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943757; c=relaxed/simple;
	bh=OssFUOWWkNFcqoGRAc5cP5J8Z6VeiYE4zYIQrFgzvlo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lGGhaM/yhgFtZfuQY6p+WgA4C9B+GOHny11Evj+cYc3LUFNrQCOPQ/dAr1yoeWovbt0p5V31iLFcaq5BV8LFUt5ImRZr39mP6o48Lgqyy9iADukqu4Fd6OAsxd02fhnD0NXTNrhgml8wnSg9qDQpaXGbmvMt2Pvjp8Sq4jNYqzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UinOmaDE; arc=fail smtp.client-ip=52.101.57.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UinOmaDE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzTUwqx45kyHxeZlIM5w7Zml5nBJmcPhTYRlkwnv4xGV/+Y3l81UCKSZMjIi7nHCBkB98w3Sm1uVI1WXl+iRZeZOGCRl7tyAJlbk3VfhylDNgzOiCMOi7Ekd2AcYKhZA2d0e742yUFIIwDsHwKtopC5QWiWxuQ/3fpZKVlosLY2fxzuVnuBht0SNpfm+b/nRLrdtkvT0HAwWFpfRwjWUQOGs4tbYVpOXX8olar/z0MvwLoFSbg0om2CnI9HcJPeMOC1x95gknnm0Ety8NA14VIB/foior1sfNH/kz5AIuhG761X8RLCGPaPoVF7wwjan4Bj2hywp1KO+Il4IIqAd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGoJSKD75I76dfXMcdz3HFAKa8Vt6YcnsVy+zfslb2w=;
 b=aTfeEFcpIMkNEm1FwzVcwQtml3xVWaEgRQ3WF8HW6VsyTuDUoDcivtHmbC+aNOj9LBj7tN3qxVpCff4G+Tm47EvrwmSiQIf8Q8wfoVFTL0AJqzNdGFYTWbND3fLftrT9tZHIWcZIp+LSkwRZfRZQ9wgVbAYizNLw1x1f1hiGUxAr0bLV3AqQUeSTqFbNUclCZ1vhfqaOZddEnuFRg06VcrZ0yQbyPXDQVjldqReqza/AW0LC4CFdjI8T7lOG47OpXvNZvxDQyXewiu/jfthzNwBRK71s3gfQrAE9qF7BMO6AQG+shJQJsKDUFFbdL/Xo8WKsnkxdwP69MbEBBhMFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGoJSKD75I76dfXMcdz3HFAKa8Vt6YcnsVy+zfslb2w=;
 b=UinOmaDEG1UFnlMa21gjDwJl2MMpv7I/eDwNsxH5UVKptqJGFay6CC/hiVfr7ZkGIGWgBY5VpLicoI+INGsdJ+Hhti5V9IxOhRA71LIb+SNppaaicW8Vj5LZaxHz4SlX/0jqhO4O/QMTuk91bL+EjmibHcJlKp6RqoQ4/Otz6vM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Mon, 17 Aug
 2026 05:15:52 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:15:52 +0000
Message-ID: <86d5a3e9-4002-4f67-a1b0-6596fb58a68a@amd.com>
Date: Mon, 17 Aug 2026 10:45:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to
 vendor code
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1786728929.git.sandipan.das@amd.com>
 <d83896ecfd6e98424c2053298fbb10a3d91592f9.1786728929.git.sandipan.das@amd.com>
 <20260814180140.5F9BB1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260814180140.5F9BB1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::11) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bddb6c-2cba-49b0-eefb-08defc1e9b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OAJUHo8QOVhT92IYCVh1usZNnYIPfbCvSg7pdMCoGE8aHhB5lji52hgwVQbcqh9E7eF6XdCosXmK/pZI0cMD2Rx4RBzYSsRy4vTpMXE7Gyk5jLtsnYnXAuFPuze5sf/8hIOUoZ5Ct2FsQIvE2W7Yvb4qcqBZ1L14qrLhooG1CvKFgfNWtgZvRzwYUjXT+jUjpaGmwDEEbjeKSsA7gQaxoGCN3IVOH5b6KfqFHBcEsYxy3eUyX9xk42d7acflafWqWP3KlXCQceJjeo1q24rm5dXep3bpi6Pn6hJBvj6yBoij7CrmLD00eO3IkpCozb0bKUXUlDQXN+tCDQ746xkI8VEMEDySPpKpi3s/5I/fdGgiZPODCnVED++dDEJrH8fEjFy0alGTKPrCfU5FOg8eoot+bA0zEoT3kUCJ38qmELgWgUmTr01ei1ULe2hD61f6SFTQmGFXaXnDw3py49ine5mQHsKHQB0pF16+0AfjOZm80WdzBKHAzn6QzORu8KeW1XzCHdQHzteaFVYruE+WRdTdGPa+L40Edh3gAGm23yHL/NLGVHOBt7e2od5NEagT3AEJIXZ4JThG0PxCsRdqT4NA6mvdvJnQ0N1koIwD/wuBrGMTIxuFZ8gneZaW53fvRiXuUNnSR/ldd4hoj2xkXFL0igUKaUHW7cAs4Sleblw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXJNOE9RaFVxOEppZjB4bnZSSStxM2xOTXl0SHg4cHQzMzFCbTIwc1l1SlVS?=
 =?utf-8?B?MWNOWVpQdHh0ZFdDWlRPYjZiUTZFWFRUVkFrZ0xVZVNTeGM5dHl4SnpLeTZw?=
 =?utf-8?B?OHZabktRbS85ZHAwVWxMUFRsTlMxclA4cUFZQlFFR2VIQi9VVlkyV0ZpY0E3?=
 =?utf-8?B?QUxCVjhrekY3ckNNNFFXQy92UnlNRXlRSVhLSTNRa2JxSVkyM1BpdjZIckpr?=
 =?utf-8?B?bVVKZytYNzNER1dUT1lPYzdRQVQwdnlRd0R5M2d3enFmazBWQzQ4VDBvc0p4?=
 =?utf-8?B?cUVPQlhmT2x2U3lBdWVrTTh0dHkxV3BsYzhZMGljeE1yYWF4MjJsYW4vaTVV?=
 =?utf-8?B?U2dZZlUyZEtuVWNhV1NmbkVTdDhLU0Y4SWJJTWt1eFMrNUdBZWZ0V1dDUHRI?=
 =?utf-8?B?d2cvVXJjVGJCYk43U2E0Y2JwOFJrTEJrK29JbWFBS1ZjdWowWXVSc3FLUVJa?=
 =?utf-8?B?YXJLOGJweEl6d0k5NVYwM0RubjR5NXJuSCs2VUhRd1N3R09BdXVkQWNpRXNz?=
 =?utf-8?B?Y3pURDNYVlVVMHljT0lVL0toOVBDaUFWMmE1bm5OZFl6SXpZQ1J3UmxaVVUx?=
 =?utf-8?B?V3BUdmVLempvSGlwTFZkQnZQcmgxdldEMXhyQkF4NkRmNUs1SnNZVlFVUDZs?=
 =?utf-8?B?eE5uWFBqdDBBeVNqWkVuVEQvVlowSjFFSXE0Vzk4VkZiUEk1N0xpR0lMOGdu?=
 =?utf-8?B?NktHUWJTajNIb3NUdzBQMmZyR3FTZTQrOWJkMFozSFNSSGFSdEpFb0VzMlVP?=
 =?utf-8?B?Q2plWEFaMFF6ZmtCejY1c0VHYThlZWJHLzhsdkFDQzV3QXh5bWxraDAweENl?=
 =?utf-8?B?cnZKNzFnUVh5K2ZXb09Gb0hTOHRrMnBwaXJHOWJzVTV3di8rSkNrYTJoVlZY?=
 =?utf-8?B?L1ZYMGFTU2JVZ1dWNUIzUm4wRllHSW1ZbDVtMnRWVDY0cWhZQ1hvMFliUDdS?=
 =?utf-8?B?VmRvVVY1TkpUTS96MklyWWt2OWQ2aXVDMWQxaU9pYnNNSXg4aEg2M242NjBQ?=
 =?utf-8?B?M0NyeUVKOVMyTGpCK2M3Y3VhczFhUXM0SS8xVmVmTEhOS2Zwc3RncE1DTUth?=
 =?utf-8?B?cnNRWitheU5TUmR2TmlVWDFoRFBBQzViTGtMbS9WUWRTVDJwZ0llLy9vNzZa?=
 =?utf-8?B?VUdxWnZ3UFdUdUtPT1ZNdDM0RHBhdy8rdlVaUTRmM0JPWDAzWlMrMEdqY0tr?=
 =?utf-8?B?TzZKOGJKSkZyV1oyS3EvVEhMZXRORG9ESUNZNXZSNGNYRVFlKzhqVEo2MWxH?=
 =?utf-8?B?S0dxZEphSEIyYTd4QUpBMW1JUTNCYVhDQlJVNHZZQnVsNE42REpOa09mT0lQ?=
 =?utf-8?B?KzZGeXVpbXluRUNWUjNPZEZaMyt0QlliazdWMVdZTkw2VEVkVURkK3VxLytL?=
 =?utf-8?B?RThVbXlBemY4ZTFhMlUvWXdkOVg0M2RJZFdKOGpXMHVVbENHdnF2M1FmT3dx?=
 =?utf-8?B?dlRxRUxycW13aXJ5cUxXOGR4OTk4bE1EclVOaVg0d3MwRnZXN0ExMHNEbXQ1?=
 =?utf-8?B?UzRucFM2ZHBzM1BqUEV5dEdDaENRUVNCVUJraG55eWVHMkFYNVhrM2pZQVZW?=
 =?utf-8?B?T0hrTzNTa0RSY0ZRZEJFWjR2RUhlRXpiclhWMnV5alIySzZOSTFRNk0xMllH?=
 =?utf-8?B?R2R3K01TaE9lb3JvUVBGUGcvbENTdlZRY1RmTmxrTUo3SDFta0hrSkpsbElt?=
 =?utf-8?B?Q2paQ0RzU0tmK00wWkV2WURIYm11TDJEbjJVRkRKM3BJSlJEU0l2ZTZ5UUhq?=
 =?utf-8?B?VEJpbDlHVmtsVWpqekxlOVhQM0Jhc1QrV2tpbEhnbUhqdGl3QVFMY21MNnFF?=
 =?utf-8?B?OUgxSEU3ZFdCdms2S09IR0tnbDQ3d0tSc1Z2Y0NXcUU2QVRTMkZoZ044bFNX?=
 =?utf-8?B?WXg3dnFhUThGdDJPWFJmUTdLdVY2d2NPUjFrRmcxYlZIR0I0SXdzdGo1aU5U?=
 =?utf-8?B?NmgzZ054REtxamRkYzFGWUpyR1FNamJEWFFJS0I2WFUwdVp4Yzd6VDRWQTd2?=
 =?utf-8?B?QmFPZ2dmS1lBM3lHOStQeERlNmFibzlKMS83VWlNalQvc3BKdFJ5c2h4QzNK?=
 =?utf-8?B?b3RST20yb3Z5R1VpaTIwV1VvZk15a3Y0OENaQk9ycXg2WGhETHBvTXBrUTlx?=
 =?utf-8?B?V0orZ3dnTDZuUDdDT1ZNaThQaUx6bHRNN1VUbU5aQk5pdWpCa21YOEJhMXR0?=
 =?utf-8?B?K2xrWnplRjR5VG5HcE9rSEg5S1F1Tk53RVVXWkkzQ1M3bDgycGxrMFpJaFdi?=
 =?utf-8?B?cGZyRk5HSStXd0paSDkxNTlwK1RyUzJtTmQxOVUya2wvckU4bzhHT2xmZ1pl?=
 =?utf-8?B?Mm53enlVdFZxNFlHTFV0aHYzekRkdkhPelNXbnN2TEErUTdBZ3g1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bddb6c-2cba-49b0-eefb-08defc1e9b84
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 05:15:52.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnjHFmGohOyJdY9yooMWmK0eMXmeBfzp24yPk471a5SZ1j1F6zWee3M9eszVVzDSk/97aZoEMkHtQ/dcMKxzmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345

On 14-08-2026 23:31, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unintended removal of MSR_IA32_DEBUGCTLMSR from AMD PMU debug dump.
> --
> 
> --- Patch [2]: [PATCH v2 2/3] perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to vendor code ---
> commit 9c3227849508af744eb4359d394119d9f9ee749a
> Author: Sandipan Das <sandipan.das@amd.com>
> 
> perf/x86: Move MSR_CORE_PERF_GLOBAL_* dump to vendor code
> 
> This commit moves the dumping of MSR_CORE_PERF_GLOBAL_* and
> MSR_ARCH_PERFMON_FIXED_CTR_CTRL registers from common code to vendor-specific
> code. This prevents unchecked MSR access errors on AMD processors that report
> PerfMonV2 support but lack these Intel Architectural PerfMon registers.
> 
> Closes: https://lore.kernel.org/all/20260717150315.2868314-1-ptesarik@suse.com/
> 
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index ae773f8d55c39..4c70cb0148716 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
> 
> [ ... ]
> 
>> @@ -1561,38 +1561,15 @@ static void x86_pmu_start(struct perf_event *event, int flags)
>>  
>>  void x86_pmu_print_debug(int cpu)
>>  {
>> -	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
>>  	unsigned long *cntr_mask, *fixed_cntr_mask;
>> -	struct event_constraint *pebs_constraints;
>> +	u64 pmc_ctrl, pmc_count, prev_left;
>>  	struct cpu_hw_events *cpuc;
>> -	u64 pebs, debugctl;
>>  	int idx;
>>  
>>  	cpuc = &per_cpu(cpu_hw_events, cpu);
>>  	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
>>  	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
>> -	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
>> -
>> -	if (x86_pmu.version >= 2) {
>> -		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>> -		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
>> -		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
>> -		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
>> -
>> -		pr_info("\n");
>> -		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
>> -		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
>> -		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
>> -		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
>> -		if (pebs_constraints) {
>> -			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
>> -			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
>> -		}
>> -		if (x86_pmu.lbr_nr) {
>> -			rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
>> -			pr_info("CPU#%d: debugctl:   %016llx\n", cpu, debugctl);
>> -		}
> 
> [Severity: Medium]
> Will this unintentionally drop the MSR_IA32_DEBUGCTLMSR dump for AMD CPUs?
> 
> AMD processors with LBR support use MSR_IA32_DEBUGCTLMSR for LBR freezing, but
> since this read was moved entirely to the Intel-specific intel_pmu_print_debug(),
> SysRq-P will no longer dump this register for AMD processors relying on the
> common x86_pmu_print_debug() function.
> 
> Should the debugctl dump be preserved in common code, or added to an AMD-specific
> print_debug function?
> 

If the intent is to just see if LBR is enabled, then amd_pmu_v2_print_debug()
already does that by dumping MSR_AMD_DBG_EXTN_CFG. I am not sure it matters
here whether freeze is enabled as well.

>> -	}
>> +
>>  	pr_info("CPU#%d: active:     %016llx\n", cpu, *(u64 *)cpuc->active_mask);
>>  
>>  	for_each_set_bit(idx, cntr_mask, X86_PMC_IDX_MAX) {
> 

