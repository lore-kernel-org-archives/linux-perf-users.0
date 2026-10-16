Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99C3AA1B2;
	Fri, 16 Oct 2026 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135179; cv=fail; b=jCtUZVblwchSqbG66Sj54SSHJYwlAh+0+BuANxUKYAbVuQVweyMY/ZRyevF2Q/ZNLKv50pSGOtxVPQI6XSCtKxZgr1JrDrHwPBKpUOiyQlbVJsFbUtQG6wEgkAkPIxgPQXHGPOmUFcuouXXpkQDXUboCV5aLOO4xW7BxAFCDWc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135179; c=relaxed/simple;
	bh=dHQBaKWavhrTM4ic1+JcZn3lqdGZP8qKv4/EecAT+yo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YpT9ukS8WE+/RGHvith+0cs4YqnPTlCGbggpCcrFMljDQOOZz3FHvSPWEJSoORcsFKD1WFrmnVMTc9KPOf2Ez7dF7wCazTbOqNmtEMBTErsHjYZgPmbHVbpk9LdwV3XeR6doCOQDqFFflIqutqX4tB3vBPYzLIJ3g6DUePkd5WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EKetygMg; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EKetygMg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wThhogF4XWbN7BOLKmByxPpf6BXT/Uogw2EkRYxXztcMHJnL+7g83X8Ip4HUZyrmQIFOuQBJgHdZ0TtRK4UUMo/TXSSxMrgwaUxnOpUejj4CTj9ktF3g7Ok5d4STAUmYOAehKnwKwJAY6qCFea9SIbXO6x89q5Fn4HywQdgRtuS2its+lAQM4PLJH3hETn9lLPr1lZZL6w0V2/tXweBiZmf2jZWGJn+P16DlWJachqZTwF6lPQU8t4QmHyDyAY8xr6uMA1o4qyfp00Uy58WuHc3f2EPASLlrMhYTQ9swmaWc8UJIurVCq/eyPjq6zaDOW/YRXBtWdOifV/IRJJE4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=530M9rA4hJvKVKNkpEpIHgWJrvYAtV4007Qly4a238E=;
 b=iSvi/Bv1ZrqGuN9UJyOzfRJS1l4jQtmIOCB4RfgK+qM/A6oKuAuvCZsWYbohrLP6w54giH/gzNU7ye8qy85h8yAdcp/hDQWKHkcrzw6BF7LYLjgz31RcQgIvo424LyfDn0DPLmp6/Aytj7NCmpXPJyoDb2MYbADhWYjpJLoKJwu5eTYpOzGUsANqDBegndMSv/hLM8cHzIcuqEUzM0GEzm9M1d6/iRMabmV+kbDYTKaPik9dObKs8PfYj3fVrQrvQyqwihaPwHECioUXqIUaW/tRpOEievx2lRY8pS//3G3mDrBA6MrkWuo/8z0bR0Kq2KOxBwiOa25SLjWMYPtEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=530M9rA4hJvKVKNkpEpIHgWJrvYAtV4007Qly4a238E=;
 b=EKetygMgDz8KGqnsx9NBiCxUcSNA0mLxrJFt0biTk//mHVQRvuujRhnVOZgr6mFtMlm6p9pjAapQM0iEiIthAu6DIG1QuoIFqpfIKnLrxAe4gPiBnPVH7mA9uLPEXH8VWH+aMjFwsZ0QfbFZCWa53HpjNeRHRfBrwqrQebv/+iU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) by
 MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 07:19:34 +0000
Received: from DM4PR12MB5721.namprd12.prod.outlook.com
 ([fe80::8fe3:c3d1:a057:fd24]) by DM4PR12MB5721.namprd12.prod.outlook.com
 ([fe80::8fe3:c3d1:a057:fd24%4]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 07:19:33 +0000
Message-ID: <6e67dec1-f31f-4a98-ac15-8df0770dbe1c@amd.com>
Date: Fri, 16 Oct 2026 12:49:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf/x86/intel/lbr: Limit branch snapshots to
 valid entries
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, bot+bpf-ci@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, tglx@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 andrii@kernel.org, song@kernel.org, ravi.bangoria@amd.com,
 ananth.narayan@amd.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <7f611dcd599d6d65325d8c40566a1fc35b447ea2.1792064123.git.sandipan.das@amd.com>
 <9ef8c1f496a9dca33792c7c3978e24208fe67d87688d5356b5e54e77eb009747@mail.kernel.org>
 <4ef25c08-ac66-4734-abd1-2d50bebcd94f@linux.intel.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <4ef25c08-ac66-4734-abd1-2d50bebcd94f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::8) To DM4PR12MB5721.namprd12.prod.outlook.com
 (2603:10b6:8:5c::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5721:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c57036-63e2-45d3-a166-08df2b55d3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|18002099003|22082099003|10067099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	DX7Wc57glfY1QbjwSOL7qspOrpUvpRMajNrNuNZtZdRp8U/CdzHT8jq4UKCRoiNvKmFITFspopV65Uegm8eJCKacnRl4b773zEqmxyP2mz5QGRHfyNM8ehW6QqcGHTaDcEzqOIntP+3EXNS/H5Ds4+/Tib+iGSXLUR7iGxE3sMpUYEMb078eaESg2mNBmvI0+L21hD9L/aOGrH+9dsfBebEN7H3iTBR6CkxKsipCAN0CT6msH3585NEWRTRqXhKAeZ9U/lDSfexGQ9qc5A4pL74kRBobsUQXtxWrg2ssi7B2g8tTzgiOkKCLd90uwP3fkog+9pfs8+ob08jPbBEx2XI3RLnGxpYGSIQWpPWaiQvKt4FOobHVXTaL8SkoymefFs3IGM5Dw3U1m8f4Pf0hAb0d/VAza5axIMLeOsh1qTVE1guvl8NJlDd0jqFPuWwwdSDK3pWJyJA8sib2NffBUCkQs3OkoGkbuO8MhSyvyeRfHpFryuWu7i7fWkz/veY1DKbZ+c4RQ2HKpexQV925QqfUONUgj4aHMr5VtW31ApjW3BYGrMrQDnFBe+nLv5E5aRXzO0bbbp8hPB4twLfVqHvlV+wRJjnMIjw5BzpWotLvHCCCuU7V6G8Dr/yzwpZDc789QQJ+zuiZ4N7Hjbj1FWV3WfPXGqtzahgabZ6Uydg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5721.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cSs5bkRjVkFJRHVEdEUwOXU0T1RES0lGbEJLQ1hrWmxpaWRpbWdRWkJZWEt5?=
 =?utf-8?B?ajFFOXpVd0JVakVGb3YvcnNHbTk1Ykh5SnVFb1J0T3Y1a0daeE5QQUU5SnZl?=
 =?utf-8?B?bGY3M2V6MDltWVFNeCtPNjBxSFJldXdIRFFRZ3MxR0lXSDVZSjJMTmZ1TUNy?=
 =?utf-8?B?a1VrTHJrdHRwajh5Yi8zblg3WmVuNzA3bDkya255Z0RMWjUzZVZCeFZ1ZlpN?=
 =?utf-8?B?UnFUUElXRXFKTlBrQU9vTlFXNmNzRWZNQmFST2QyMmYzQTRCUkZjSkdxQit3?=
 =?utf-8?B?WGV4Q1Rzem5OTlY5QjQ0TFBYSUdNcUpxekdIbWdidWh4VXlidW4vWm5DM0Rs?=
 =?utf-8?B?Vnlianc0TUI0cHlNemQ5SEJxTmZMWEVyUzVRa3d4aHREaTlKOG9qcFQ2TEFG?=
 =?utf-8?B?M0I0M0hWUFZDbkhXUEJWTW5CVjZCTEVuMzVQNXJ5anZJZkNBQzR5T3E0UkVr?=
 =?utf-8?B?N0QzTHZiZnlIb2daQ3hpY1FxbHQ0MVMxTzVTZC81djQyUCtwbCt6R3hmdXd6?=
 =?utf-8?B?dDczeEx3QlZTdlhEZzJLaURHWlBob3VRb3RIcGUxQW9uZkloMTdWMjJZVDJj?=
 =?utf-8?B?S0dTTDJwWFZ4c2dhbFp0MTlOdFZMajl1djE5VG96VnNZZ2JnUWUvQk1BVkNr?=
 =?utf-8?B?c29YUEpDNnRhR09vRGF4dFAvRjhzTXpidGNCWUN1YlRacTVmQUh6SDd2Z093?=
 =?utf-8?B?MmNvNEFjR0llMjdlK3JRQUdCVVdKTm9NajlIU21DZDF2TXF5YU9pam52NG9u?=
 =?utf-8?B?QTkzMFFUcVN5YUowYlRCTllwRmUzQmVWam1PbC92TEhxTk1nSEhWeW12MGpr?=
 =?utf-8?B?dW1Ia1dvNFN4SnFxNnN1R1c3bjlPSjJoWUNZMnpvYWI1TEVhSWwxNVo3NE9x?=
 =?utf-8?B?Witxd1h5V1RkZERPNFgwUlA4WFVIUlB2cHVDNEw1eXh5VnJpemlKbGY3RWtB?=
 =?utf-8?B?a2gxQ1ZTRlhQNFVqeXdwODhLMm5zVnZlbjNaUStoeTFUaUtGbnpJcnlzeWdi?=
 =?utf-8?B?UE9kazJOWEZ3VTJDWjcvdkR2MHIxT0FPSlhHbjBZMHlFYUNXRmYxUUx5Z1g3?=
 =?utf-8?B?ajE1YjN3UW9EL2ZDemxQanRDaERPalY4eGZnMHNSMktNNkNRd3lTUStzMStj?=
 =?utf-8?B?ZmE0WnFWRlUzWHVmV3c3RXVSbCs4NzIybEFiSWRDd280RGhuOGVoQWgxNXNP?=
 =?utf-8?B?VkJYRVFUZXlpSDJFL3R3UVpWWXBkQzJMaGIrYVI3T3hKYlhvZDZMc1J3akVj?=
 =?utf-8?B?aFZTVHlPQzZGZTFXZXJkL2JVd2dyQ0I4dDRXTnVValZuQ2RHTUd3RHVlbUI0?=
 =?utf-8?B?dFl5NUk4OEk3K1hHMW5Tc1N4QWVEYXdMaWtreGZBanlKOTQyTnVRK0YrYmlT?=
 =?utf-8?B?ODc1MnE1MEpHWjFYa0xmbFEzV21GcFFqKzg3dFNTU3F4RHYxYXJFN2lJQlFF?=
 =?utf-8?B?MHRVR0llTVRjUGN0TVMyU2Y3Q0x4V0xsTExnK3RudkFQd3lYY3VFN3ZqTW5w?=
 =?utf-8?B?TjR2YnRqWkNrUHZwMldUODRLdXAram1EVm9GUzZ6VXI3TFNZZjdweEVKNkVG?=
 =?utf-8?B?MHJkN1RTdVkrbWphQlAvSVlRTU9BbXVUQnhSRVhXSDJkM0RMb0N5am1OaUp4?=
 =?utf-8?B?VFlpNkxkem1HaURPZ0lKTTBEMndsYXZKVjEyZFNrM2JjUnlnZ1dsSUMxb3l2?=
 =?utf-8?B?cVBWakV3M1p6THZlSkE0R2Z1QW5BUCtNV3BtTFFLNnpXSHUxWjB5WVNvdVNJ?=
 =?utf-8?B?WDJRK0NCYlJIUDhSM2tLeW1tYnVSOG1Lb0tvOEtHZlV1c0tNL1dlOVZKcnpV?=
 =?utf-8?B?NUY4MENWUnlVUWlqRCttUTQzOUkyZkE2bmJjRFg2ZEZKaTBwNGtZcU1Edngx?=
 =?utf-8?B?QzhlMEFOTlIwaCsyTjUxNUNneXNKbUZQL3Ric1ZubG5EbG5XUjNlcUVJMEdK?=
 =?utf-8?B?ditmTzN5ZUtoalF5TDdUSnRJbjdkTTBSNUo1MVQwV016WEcxdlNydmpXemFF?=
 =?utf-8?B?dWdKZ3pYSFV4dEpoWWRDZ00yUm9IdFFScURyUUg2YWFYR3hqalFMWnordEFs?=
 =?utf-8?B?NmRRUjhmUWdMMlZkTGFYOEFMdjNETExQSkYwTlpjZXpRbGt3RVM3MitYT0lr?=
 =?utf-8?B?UUVFZkFkZ1JPR2treWpNUHVIVXNzcXhSSnpVSlhLZzRNbTd4Z1Y5L0s4b25Y?=
 =?utf-8?B?ZEc0R3RubXR3d2NxakxpOW54N1ozeWFGRnA0RXJGYU5vNDBnOFFjMm5ZQ2p6?=
 =?utf-8?B?QzdrQzNPbjIyN1NXbnIwQXdqZUEvVWFmN2t0bkFEL0lSVFhtM0lvNVVqaTZH?=
 =?utf-8?Q?HpsETrj6L4+1MY1Elr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c57036-63e2-45d3-a166-08df2b55d3b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:19:33.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOXIHkbtfMvT50oxMPPaEbK5DaXWQ3TuH1pk8EfvA+kXinVISVy/xJy/QwNhsuhhZRfzuTdD7KU22boLs3qZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223

On 16-10-2026 08:41, Mi, Dapeng wrote:
> 
> On 10/16/2026 8:21 AM, bot+bpf-ci@kernel.org wrote:
>>> perf/x86/intel/lbr: Limit branch snapshots to valid entries
>> TL;DR: Resetting cpuc->lbr_stack.nr in intel_pmu_lbr_read() may clobber an
>> in-flight adaptive PEBS sample if a BPF program calls
>> bpf_get_branch_snapshot(), possibly yielding a PERF_RECORD_SAMPLE without
>> branch records and with leftover bytes.
>>
>>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>>> index 22e2a06d5786..2fe858d99979 100644
>>> --- a/arch/x86/events/intel/lbr.c
>>> +++ b/arch/x86/events/intel/lbr.c
>> [ ... ]
>>
>>> @@ -1026,8 +1026,10 @@ void intel_pmu_lbr_read(void)
>>>  	 * but this simple approach seems to work for now.
>>>  	 */
>>>  	if (!cpuc->lbr_users || vlbr_exclude_host() ||
>>> -	    cpuc->lbr_users == cpuc->lbr_pebs_users)
>>> +	    cpuc->lbr_users == cpuc->lbr_pebs_users) {
>>> +		cpuc->lbr_stack.nr = 0;
>>                  ^^^^
>> Can this clobber the branch stack of a PEBS sample that is still being
>> built?
>>
>> Before this patch the early return had no side effects.  Now it writes to
>> cpuc->lbr_stack, which is shared with the adaptive PEBS path.
>>
>> If every LBR user on the CPU is an adaptive PEBS event, then
>> cpuc->lbr_users == cpuc->lbr_pebs_users, and the PEBS drain points the
>> sample at the per-CPU stack:
>>
>> setup_pebs_adaptive_sample_data()
>>     intel_pmu_store_pebs_lbrs(lbr);         /* cpuc->lbr_stack.nr = N */
>>     intel_pmu_lbr_save_brstack(data, cpuc, event);
>>         perf_sample_save_brstack(data, event, &cpuc->lbr_stack, ...);
>>             data->br_stack = brs;           /* points at cpuc->lbr_stack */
>>             data->dyn_size += ... + brs->nr * sizeof(struct perf_branch_entry);
>>
>> __intel_pmu_pebs_last_event() then calls perf_event_overflow(), and
>> __perf_event_overflow() runs bpf_overflow_handler() before the sample is
>> written.  A perf event BPF program attached to that event can call
>> bpf_get_branch_snapshot(), which is in bpf_base_func_proto:
> 
> Yeah, it's a possible risk. After thinking twice about this issue, the
> issue seems much more complex than I ever thought.
> 
> intel_pmu_lbr_read() could be called in two paths, one is from the perf PMI
> handler, the other is from the bpf_get_branch_snapshot() bpf helper. Which
> makes the thing more complicated is that bpf_get_branch_snapshot() helper
> could be called in the PMI handler as well, where is just before the
> default event overflow handler. In this case, intel_pmu_lbr_read() could be
> called twice in PMI handler.
> 
> So there could be 3 scenarios for the intel_pmu_lbr_read() calling.
> 
> 1. bpf_get_branch_snapshot() is not attached to any event, then
> bpf_get_branch_snapshot() won't be called in anywhere, current LBR stack
> update in PMI handler is good for both PEBS and non-PEBS events.
> 
> 2. bpf_get_branch_snapshot() is attached to a software tracepoint, then
> bpf_get_branch_snapshot() is called out of PMI handler,
> the intel_pmu_lbr_read() is called to get the current LBR stack data in
> bpf_get_branch_snapshot(), it's fine as well.
> 
> 3. bpf_get_branch_snapshot() is attached to a perf hardware event, then
> bpf_get_branch_snapshot() is called in the PMI handler, it leads to LBR
> stack could be updated twice in the PMI handler. In this scenario, since
> perf has already read the latest LBR stack data before calling
> bpf_get_branch_snapshot() helper, bpf_get_branch_snapshot() is unnecessary
> to read the LBR stack again, and worse it could overwrite the cache PEBS
> LBR stack data if PMI is triggered by PEBS event.
> 
> Roughly we could need below changes to thoroughly fix this issue.
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 442be0639414..d2cbb5ade003 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2869,8 +2869,8 @@ __intel_pmu_snapshot_branch_stack(struct
> perf_branch_entry *entries,
>  {
>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> 
> -       intel_pmu_lbr_read();
> -       cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> +       intel_pmu_lbr_read(true);
> +       cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
> 
>         memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry)
> * cnt);
>         intel_pmu_enable_all(0);
> @@ -4090,7 +4090,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
> 
>         loops = 0;
>  again:
> -       intel_pmu_lbr_read();
> +       intel_pmu_lbr_read(false);
>         intel_pmu_ack_status(status);
>         if (++loops > 100) {
>                 static bool warned;
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 2218469be644..c651b94a893f 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1008,18 +1008,31 @@ static void intel_pmu_arch_lbr_read_xsave(struct
> cpu_hw_events *cpuc)
>         intel_pmu_store_lbr(cpuc, xsave->state.lbr.entries);
>  }
> 
> -void intel_pmu_lbr_read(void)
> +void intel_pmu_lbr_read(bool from_bpf)
>  {
>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> 
> +       if (!cpuc->lbr_users || vlbr_exclude_host()) {
> +               /* Reset lbr_stack.nr to prevent stale data leakage. */
> +               cpuc->lbr_stack.nr = 0;
> +               return;
> +       }
> +
>         /*
>          * Don't read when all LBRs users are using adaptive PEBS.
>          *
>          * This could be smarter and actually check the event,
>          * but this simple approach seems to work for now.
>          */
> -       if (!cpuc->lbr_users || vlbr_exclude_host() ||
> -           cpuc->lbr_users == cpuc->lbr_pebs_users)
> +       if (cpuc->lbr_users == cpuc->lbr_pebs_users)
> +               return;
> +
> +       /*
> +        * Don't read LBRs from BPF context if we're in an PMI handler
> +        * since the LBR stack has been updated previously and new LBR
> +        * stack update could overwrite the cached PEBS LBR stack.
> +        */
> +       if (from_bpf && in_nmi())
>                 return;
> 
>         x86_pmu.lbr_read(cpuc);
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 60038d329518..4738b40288a4 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -2006,7 +2006,7 @@ void intel_pmu_lbr_enable_all(bool pmi);
> 
>  void intel_pmu_lbr_disable_all(void);
> 
> -void intel_pmu_lbr_read(void);
> +void intel_pmu_lbr_read(bool from_bpf);
> 
>  void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc);
> 
> Sandipan, would you mind I take this series? I need to do fully validation
> for the Intel side changes. Once the validation passes, I would send a new
> patch series to fix the issue for both AMD and Intel side. Thanks.
> 

Sure, please go ahead.

> 
>>
>> intel_pmu_snapshot_branch_stack()
>>     __intel_pmu_snapshot_branch_stack()
>>         intel_pmu_lbr_read()
>>             /* lbr_users == lbr_pebs_users, early return taken */
>>             cpuc->lbr_stack.nr = 0;
>>
>> When the program returns, data->br_stack still points at cpuc->lbr_stack,
>> but nr is now 0.  A later bpf_read_branch_records() in the same program
>> reads ctx->data->br_stack->nr and returns 0 bytes.
>>
>> perf_output_sample() then writes nr = 0 and no entries, while header.size was
>> already computed by perf_prepare_header() from data->dyn_size, which counted
>> N entries.  Doesn't that leave the PERF_RECORD_SAMPLE without its branch
>> records and followed by N * sizeof(struct perf_branch_entry) bytes of
>> leftover ring buffer content?
>>
>> Before the patch, the early return left cpuc->lbr_stack untouched and this
>> sample came out intact.
>>
>> Would it be better to leave cpuc->lbr_stack alone in the snapshot path, for
>> example by checking the skip condition in __intel_pmu_snapshot_branch_stack()
>> and returning 0 there, instead of resetting the shared nr inside
>> intel_pmu_lbr_read() for every caller?
>>
>>>  		return;
>>> +	}
>>>
>>>  	x86_pmu.lbr_read(cpuc);
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38827450009

