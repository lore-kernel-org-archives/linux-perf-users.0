Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D3287246
	for <linux-perf-users@vger.kernel.org>; Sat, 23 May 2026 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502046; cv=fail; b=WDpYO2b+L5jSA6GXoocxodcAGMkdSlXbikaXNTj+WcJDojrRE7A8etHP6VGZjarrZFVNT9rjGQ3dlvIzdWHnBYdpK2GrHAWg7j+8sFYpmMIVcwvmcsYK1mOZUsx4g9Sf6pPSdXrneMb6Lf6iH/oOoj+6KeO2kY2ApGboZdX4P9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502046; c=relaxed/simple;
	bh=oxEUX91pV2iT0uXVpMh3unI2NubK1sBuaIxRYZfKlfI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o4VXt1cUZIDX8p9P0J21Ceoi9RHk1yeT86tMH3sUXaUG88wWJgPdN7gEDXzOZPI4SAp6hCPa4K/xDvfpu7n+TJMqSeP/wjJZSj9RbsHZIw1CcL3aju1t8M3G3DFQLFbFmKTWiQk+erC1Q9S2tFsr7DXU/D3SKpMTjgqRiTFaQEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BaGyW3sT; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BaGyW3sT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+/hKTws34+q4tzGmjMSgmTWdtYdwikvPtrlKzp2rduu3kW6QZapO2Myy1qWT/bkzt2lTYKS1o6QG1FcCKg1jJ+xkyRT58kxXGgY8z6i667UthSLbq7vOkPoFZ1axVCzD5CcSEvK4IgW0K6p7ESQhUl8X/G/d88SGgExiVN3k/D0Yb7DWT9gBGOSjB/2BrnPJlKsmor7K/Jc3ne5CE1p9/u+9ENh0mCarWiwXn1MHw+ZEOBb61eJ/HsPagAzmkm1TFFKHB0uDTNgH0RV5tAbjbwmZBNB40gKHy9Yet+MuSFzysDdoOhQZYjbQuvxAKbUSjIuYEMQ/6sdv5ci4a3i8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB7gKmH8Z9ksV97+xT7SBM9nNRYuteVKIdWeOuKVqpA=;
 b=bPPL9ac2a9QAN6GhvLBErx0dEP2uM78NqK9T298Stgbwfrb+x52I0TFQ5UO7ZrAtuUZs6yeqONSBvinHavhrbqhID3COnnAPZnZIs9/kfhEcxjI41sSK/1RJ8HkUrum4fZmWcV031hismh9z5QV0TGuwrrDMtGa9OL0aUMUqLXsy31gl2KZBOrVJYPxTagge08oKVjTxT3owP2ZN5ERBjXvZaPq7pefNAv+uRaQdPKWK1v1uL30QJoJreKFXl2o1rjT76sCDd8wF0ncKWxz+Haq/A41Q/nkXiUL7UmVXUDTY2h/0F6AgZCnd2dP8Z7fSrWUxn4AqdiuCNO4XHjfGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB7gKmH8Z9ksV97+xT7SBM9nNRYuteVKIdWeOuKVqpA=;
 b=BaGyW3sTT/j5CY2fNE/0S6jb09ekcwAwxnWF84JDW3valyAhqQ2XVKETaN6S0RTUcdsFnJHjrItJvw/U3LAzfnNRLPVmJrx94aMEZ7UCtgTnGFWamRCWsf8+2jlWNmUvh3gB1WEw3vRaI/YXlTNL4zJQoGQGmIpfCMgsPK1GAi/daiyuIGcjALwuQOvk94ft8H+tdir6RdA4JC7loYyqNfDCwCHHo0GbZmhUGNuvPnzamvZ94ORYn8Abcbn+EtFnhM6yk3rGvVzDH0D5WzgzfDWgPb87R6DK4Njo0ZRK8r4M7TdiXZ2MMtarQmevnbM9I/4uOjZ1xeyoc7g3G+xyxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 02:07:21 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:07:20 +0000
Message-ID: <d6be7b32-6cbd-4af5-af87-58c42cf528ae@nvidia.com>
Date: Fri, 22 May 2026 19:07:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf/core: out-of-line and export
 perf_allow_cpu/tracepoint()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260523013326.129491-2-jhubbard@nvidia.com>
 <20260523015124.6EC1E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260523015124.6EC1E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH8PR12MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f559c12-ed2b-4b31-8fa9-08deb87005c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|5023799004|11063799006|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8DBv81LJWA6cTdtCK+nzeWf7ATkwKIUwSZhu/OpfoiC5khC3MqXpeKdKeNUG0AsmfpG4cvenmS6yzIxELuNBnUFW7W9Oz1MITKEPjeKJ/9IJvuA4rz64Gh7bEu8d0pD8A7wulRHuu0DGcIJhfecEqxsPCpGdNJNdKQgrmzPy9GTHwn5C6+yoCRYBcJBkclVgMkuBhP8jll2TG+ckHaSEwAlsC4a7JxDP5wI4ShWEDGCJQIr1FaUsEO6Xz527Mo5YoF3EYQLIj+z/rWWJtFr+imQkS0Uh25q/BSl6OjFSAGfGUiv+FQ7uEuc9/0aw+XAPbL35aQp3X2PyHoIvCL3BkNeTGoa6QTOfQ3bqiBNV0Ms6cyMgFzln8TwkVWbMFAMPQNNTux9KOqalM/71yAtbN8V9AuoKZZ1TxWeRtE0t0icHM+rHg7P1XNpXS9g+1xJPi0xgx1hxCkHdjIPc9Da+ll2YEBYbySK4JbRu6LznxgUOBdxO3zGkOLYSPkp0Ete0x5+HmJeHoDwW3+T/+pjLzGvBbMRezKW0t9hlzmvCM6ByjSFDP8U5brdllOvP50g2nzhBUn4q4JNP2KFWqTJMPPs9R6PIuF4eFZEJGdhARrEYvvBfKztTe0szHFDZJwvmc+/gbl8N91hTWCqOLDB5zvlZfPPsb5GEHL5o86SmqY+lop/c6ApqCEPUvUthDjUW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU1GeDB4ZHF6dkh2RUhOdlpLSjVmNjZQNFFYb05vd25LSEFYRlloazFpS0pi?=
 =?utf-8?B?NVNNZVBMUkp3Qzg3eTZLSjlIampEUVJBSHoyTG1sZFphREtVVVFQSlJRZnpZ?=
 =?utf-8?B?emc3Ui8vRGFGaTQxYitYL2h6SkRxME1oYzVlR0svOElWZllqdGx3anJiZU5t?=
 =?utf-8?B?WFM0WWJFTWtZSVVMK2txRGNpQytqUld6VmZKQkV4Q0lZN2JqQVRURkF4cmJ4?=
 =?utf-8?B?NytUYkNlR0lsRjM2UDcwRmZEQUdveGdDdWpFWnoxWXNNVXJXVVNxQ2RkMEJ1?=
 =?utf-8?B?dVZ4TENTZHhrc2hiL2tLdmdXTUs3R1gxZHV3TG9jQVlPRU1OZWcxUUFFak45?=
 =?utf-8?B?Y0l0QzR3UW9DT1BnNVBDcHdKOVRYY2haem1SbHF3QTMrRVA1aUJnUU1vSzhr?=
 =?utf-8?B?d0RRbTk1eUo5Z0d6ZVZqSFZjcnZiUExFSzMwVDE2R3BCVWZtUzhqVXlhV21s?=
 =?utf-8?B?R0NjRWFGWFRXVFBwV2lxUkpKZ3JjZmZmbGVJeVRhRXRYaXk4a0lFMnlQNEll?=
 =?utf-8?B?aHBGdUM5K2dDOVEyRm5tWVhTSjlZSXMxTGZMWG51dnFocDBXNldYajE3cm5a?=
 =?utf-8?B?WUtxb3FGUjIrc1ZzdXI3Qkp0TndXZlNnNTZNcjg5MjB2d1hRQWNja3p6RzVh?=
 =?utf-8?B?a3VUemFkTlZKT0RmaGt6b3M0azlwWmt0UG9hQklIYTZCb1RLbDFoMVdFZGxV?=
 =?utf-8?B?VXR0WGtMZlhzOXFoL21oKzFjNkdOSTFJWG5VR0dSUkRmbFFiUVVVYmxIVkM3?=
 =?utf-8?B?SmlTbmFGdEwzVVUxS0FHbXI1b2V2V05kZFZjWVNiaHQ4aTBzRFpvTkVoSm1B?=
 =?utf-8?B?TXkzeUpuVXNVcXF3eFoySUtkWWFJa29OZS96elNic0VUUlRRTVpJb1V3d09M?=
 =?utf-8?B?RXNwSGlYM2dKakUwcGhGZjZpRG5ORU00RnlMWEdrTVJxOXFPY2gwSCt0OWh4?=
 =?utf-8?B?WWZ5L25IR2libWhmeld2M1hpV1JVa0Z3Si8zejdYNDY2RkZrNFUxYm9yZ2dK?=
 =?utf-8?B?eGRPaXppMGVWR21sTHJ3OVdsb3V5amNsWUt4MkxIeFJOQzhHS0cvc01lbXZp?=
 =?utf-8?B?clU5NDYrQytmbjdJREVwMEVLY0lkeHBoMnNJaXpZMGxibHJ4UnJIYUd1V0Ry?=
 =?utf-8?B?UHc5bndqY0lNVXpaRWxGdldpT0pWbzEvOTNPeitkRUhUNU14VThjM2paNVpP?=
 =?utf-8?B?TCsyUFdlK0x6Y1h6cUlrOWxDZVZiekRpcVhoT2gzSkYzeHJMR3o5RFRhNnl0?=
 =?utf-8?B?azBBY2Y3TUgvSzF1bkwzbDRkR2VPQTdjWHcxb3FCdlV2ekVQa3lLVzFEd2dB?=
 =?utf-8?B?c1Z1RmJGVlVORkJ2NnFnN2ZTZXUvZ0dkbjNzQ3Q0WXQyc21VcUxoZW84UENi?=
 =?utf-8?B?SjJDQkIvTzBHTHNtdHk5bnZlK2ZNSk9hZFMyZkZrM05jMWtlZWJXNXQwc1M4?=
 =?utf-8?B?eWhWY2wveGxydmRIUEVCNWUrQXZHdzBoa1ZmYVNrMm1DYlljd3RYTkJzMnBu?=
 =?utf-8?B?TEhwM1pWT1NJU1lKV256MDY5WUV5M3dQMU5HMEJLN043VjMxY0Y0cGpxd0t1?=
 =?utf-8?B?YTd0eTc3M1JsL3p1a0RBSHRxaUFFdnJyNGZIeDc3SG9wdzhMV25NamRRQlU4?=
 =?utf-8?B?V0VDTy8rYVVnbzMvMnF1dXMxWVdZOWdtay9uT0haWDhwR0FMbDJRbDczUElW?=
 =?utf-8?B?NTRSdFZOWlptNllWanMzaHNlcTZFeGJPbkxIYm9Ha3pnOXI0clNiM0dwd1B1?=
 =?utf-8?B?WTNyV1YxMFo2dEtlUE5EdmE1UEUwK2dsZDMzOFdRcjQwaG0vampJZFJqcm5p?=
 =?utf-8?B?bkM5ZnVMdVZ2SGd3eUg3cUxvY1FnNHpqWGFhMjN5R1NoeDdHQkUvTWdnSzhB?=
 =?utf-8?B?RU9Jd29rdlozUVllUG5ZSjgzb2UrNDlYcFEzNWRpVFY3L0FoMXNCUGJtZkpq?=
 =?utf-8?B?ZVVYZnErUUY3aFVxRkJacXRMcXVDeTJXUnk3Skt5VXd6aHdLRzZzWXhoczBK?=
 =?utf-8?B?YVMyVGhUeXp2WUFFUUFtQmpYZUdQSDhVZVBoZWdQN2JsMjFiQnlpbXhPOG1q?=
 =?utf-8?B?QnpGaWxEQ3ZjeWkvRjVpMzU4QlY1QVI2cGVEV0xlN0VDU21VNjU4N2UwR3JX?=
 =?utf-8?B?T0lRT0dZa2l1VUJjNkZ1MzFWL1J0UlFyQkx3TCtpbzgyMnl6b1RzWkFyRm1U?=
 =?utf-8?B?ZFM2ZjRmZjgvSDN3NTZvUTRjMG81L05scitiT1F0aVpyWWU1RDU3dDF2Ym55?=
 =?utf-8?B?TTcyZlpxaUtZa2tnQUgvcm5ZUkd0M3EwdHBVL2dqOExQQW83MGxEYmoraTlN?=
 =?utf-8?B?VWpLaEZDeWFPcnBHOU5DdE9vUnk3Y2hONlBhd0pQMXZKZmVHMnVUQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f559c12-ed2b-4b31-8fa9-08deb87005c3
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:07:20.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlJeA6xcb11l6pTRLldNCoR2rM+SwJzqCUUh8EPyv3+nHZYjvalr0wmYsrEvRNjFmwOe6/i9Dsc2daUSD2vJ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606

On 5/22/26 6:51 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The variable `v` used to store the event index is inadvertently overwritten by the return value of `perf_allow_cpu()`.
> --
> 
> commit 4a1ba4712c8f6d5b5cbf8536fff7c0deb0a5c8b7
> Author: John Hubbard <jhubbard@nvidia.com>
> 
> perf/core: out-of-line and export perf_allow_cpu/tracepoint()
> 
> This commit moves perf_allow_cpu() and perf_allow_tracepoint() out of
> the perf_event.h header and into kernel/events/core.c. It exports them 
> with EXPORT_SYMBOL_GPL to allow modular code to access these permissions 
> checks, matching the behavior of perf_allow_kernel(). It also provides 
> stubs for when CONFIG_PERF_EVENTS is disabled.
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 6d1f8bad7e1c5..735e502beb966 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
> 
> [ ... ]
> 
>> @@ -14691,6 +14691,24 @@ int perf_allow_kernel(void)
>>  }
>>  EXPORT_SYMBOL_GPL(perf_allow_kernel);
>>  
>> +int perf_allow_cpu(void)
>> +{
>> +	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
>> +		return -EACCES;
>> +
>> +	return security_perf_event_open(PERF_SECURITY_CPU);
>> +}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the usage
> of perf_allow_cpu(), I noticed a pre-existing issue in the p4 PMU code.
> 

And just as with v1 of this patchset, the response is the same:
pre-existing bugs such as that are out of scope for this series.


thanks,
-- 
John Hubbard

> Does this overwrite the event index v? Looking at p4_validate_raw_event()
> in arch/x86/events/intel/p4.c, v is used to index into p4_event_bind_map,
> but it appears to be overwritten by the return value of perf_allow_cpu():
> 
> arch/x86/events/intel/p4.c:p4_validate_raw_event() {
>     ...
> 	if (p4_ht_active() && p4_event_bind_map[v].shared) {
> 		v = perf_allow_cpu();
> 		if (v)
> 			return v;
> 	}
> 
> 	/* ESCR EventMask bits may be invalid */
> 	emask = p4_config_unpack_escr(event->attr.config) & P4_ESCR_EVENTMASK_MASK;
> 	if (emask & ~p4_event_bind_map[v].escr_emask)
> 		return -EINVAL;
>     ...
> }
> 
> If perf_allow_cpu() returns 0 for success, does this mean v becomes 0, and
> the subsequent check uses p4_event_bind_map[0].escr_emask instead of the
> intended event mask?
> 
> Could this allow users to bypass proper event mask checks and program invalid
> hardware ESCR bits?
> 
>> +EXPORT_SYMBOL_GPL(perf_allow_cpu);
> 


