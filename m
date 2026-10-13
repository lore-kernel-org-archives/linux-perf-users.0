Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C682F7F12;
	Tue, 13 Oct 2026 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873918; cv=fail; b=JREeBME4Lfmy+p1xoWHnQxX2Oi7KnZmbK8bDiTkm+4WBVZFkcjVw9X4i+Y+a+CdBLcWvQd/v4zx2k13/gOgKs7KUDcwGdOqwELVsNANUSGaVi8yUTCl8DyuWNhQQlMk3uvbt7kSusVJZHwNlX1S7TULvP5FxpEQ+F7qUTyCOddg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873918; c=relaxed/simple;
	bh=cRBMq/hWkgNek5E4hokHkw4JnPiv/une6bh8kUofVaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qUYrA7cnSfUTTSB1aKsb9FGfABI12iYjPMhklT8XDAHEXmvwk5kBWprqj/nQ8k05tz6eE1EOG996wwtCkI2vdK8UKE9G0EyV/kyMd3dN6QbnafaHW+yeA24ixmvrRsixDbtTifKLMC5PRNqguDga3O+xdcGDeaWBOIUe98wHEQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XXmyRE/w; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XXmyRE/w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDmZ3vlYfom7JLQ6Sbo+5Ih4CDG/gIIkXhIvREY6Axtk0bc2jzBxDieBDb4Lz59hzgS9mOU+fO6Q0Y2sGFOj3FKIidnxVflpLJYl5WlpBT6EfTXEiwk0Vbu/r24DW6+71k48TNySf5DaqeIolS6eZ/c4QTd8zz0678UQxxHIzvF+qmfjdQuj+MOWtNZ9zJdRjUFw1MK52a85Rg1wtGs+VpgejOCnYoqpeQ7GBwR5o/v5dVxJk3ej9IDJzw9lGabX9vkcj9E+nVjDfsfbkhlTBOjsRad6/fY+Yct7QsRdCjjUfqdYbNxVAfSiR2i576PHORZdXibQzSh51oNWfM+c6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fejWSKvm9jQRokD/OUvpPvS2XMpe1WgdLC2E8xyhW2Y=;
 b=KKzw68U1p+i8uFziMGOktIwrTCvciwED5pXyTakBBDdHPvxgLVYc6/oJpX0Z8BB4LcDu7PdNo0pK65NiT8KwG0iHwU8jgudAjaYIs3chyBdqobLZYzg99rrn3fSM64TNsCx2SvbBd62YD/Auc+pNZbCWVgZaSi1UFyyCfxk9dsw6nMAnFjPM7Vx5X+6pjeG+1TNIR1L+3wnVLDYOnK9dWt8ZNOzaNeM2UuPQbeQqWYDU7y+LCA+zBlkorHtQrMtmEiduu3qvbHKuzp9K6SMjBNwArFOyA9Ybk78upPa5n/dXSjXfOGoeX78DWELLmIL0fN7MOCa0ub5/p3XK2/RlGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fejWSKvm9jQRokD/OUvpPvS2XMpe1WgdLC2E8xyhW2Y=;
 b=XXmyRE/whS74/m7Gzw4HuRC00YOLB85umextPeJgmt9Rs3MHPmCMRrl//ydQ7k/qfEd7Vw3UEdHGgXu8zLP9CJPrdzXtA07m9h0NvuRWx12jc4oC2iEoMevWKIw8K4nmwz7g/82AxxWD5FrTxi3Ac+7UaXDwvkSZ5Ig+vz+zN+A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Tue, 13 Oct
 2026 06:45:09 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0472.024; Tue, 13 Oct 2026
 06:45:09 +0000
Message-ID: <94d387f2-ff07-4895-a722-e8ded4203309@amd.com>
Date: Tue, 13 Oct 2026 12:14:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/lbr: Limit branch snapshots to valid entries
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <20261007181002.4005262-1-sandipan.das@amd.com>
 <20261012153014.GU4121339@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20261012153014.GU4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b4::9) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: c22643f1-b3fb-4fc7-cfb4-08df28f585aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|4143699003|261009223027099003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tkYnchTxzl1xJ6bai//MUetnPawjevdmjqfkTIGvajg2jSxbSntUp+GSsoDLZAlXVPELyCBN3d97Atp6pSEAj//omGMwpfL5a9C5hnkaIPSBiTljC2W2xFnKNCit45YVv2joteQjJ7AA48bg9Ak06h7+ckQfuUidBbMn9AP8UZwbZwf08MbFpN2iQjA0TrjO6+cgFl3Y3Ig3J6p+vbN87ErMboAi1Kl1W1VUU9FEqwnptuBmf51Dl6RLiQnTqmUF7twBB9K8+qu8jgqE6n/yGc71MzAgBvzm1ffDPGw6/J5VFxuugwKZVCIjJ5yVbVKLNKnQ/RA9gEo3n68UIeOXIqM1lngP8aJ0NZk8n1QQodQqfynRRfLppMAcI4cJnjIEeQ2m0/X6wSC3AS+WbqQrLdmZxzFFvfCbrjhyefCVrFTG/0JXc3Xl3Ds/7/WE0UeoixT1YfGS3fvyjlUTUFtjR71hC3J5IZYgryoezNlPayoOjWYjJY1B0EGKjqx5qxsNh+tZMO8YLU0ooC77CCPSiO4Fn8D0pZr2ImSTXFcW+in7qRzQHNs0e1naNXPwrKxCmbAUdzVeZpHuGYGTVnwW2yXx1AJUg4r6CX/SFB9dccentTvOvhSS/I6HKyo1VBQEZnGI0Oyuu+pn3AX3C7zjk9dIvLal5gOCFf0cdrtT8DU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzZKVVlDSld1QWRnV2tNLzExYkhVUnJKNzdxTDFVbnN6bEEwZjFjMnNxS2FS?=
 =?utf-8?B?QzNpaWthV2s4aG01QmZ5NTRMQlY0Tkg0TjlKMEZEZjJOL2kyaU4zbHJ3ZDd0?=
 =?utf-8?B?aERsdTBuOHNSdS95WlVQakpoa1NlTEk4WnluREY1d2h6MEFqelcrRHJhWG1V?=
 =?utf-8?B?YU5NS0lVdnMvTk5ucWlOc2xEQWN0SFgyVktCbFBrcnlEUjl2UFkzUzZOb3Qz?=
 =?utf-8?B?S2NQeVRGYktaMytqNFlEakt4SkxpVW51NkpzZVhtb3NXbkdOa216WkEzbW5M?=
 =?utf-8?B?NFpLVzBselIxT3dmc3dOQk96UnhTUVBRT1E1YmNVZ3dlNTd3bDlqS2RNNWVZ?=
 =?utf-8?B?b29OUkJxVWVDKzArNDc3TXZJSk1RVGkyMnAvL2I0aHhWdWErMTJXY3dDd3pp?=
 =?utf-8?B?VkhWM0c0empMRW1LNGZ4MG9DbEVRankvYmFzM216SVJLTnp4OVNURyt3N3Bv?=
 =?utf-8?B?UHhKSEgrbWNFbE1aWllGaldtKy95OGpvdWRxUkwwQWF5czNPUG1LTkc3STAz?=
 =?utf-8?B?Q2VVS201Q2pWMmNDdHUzUy9rZGhpbkFGNUhhcWtjaTFtNXBoS3l6dzZ4MWVm?=
 =?utf-8?B?L3ZGcllKQW5GOEdSNXloRWQ1ZW1IZ3Y5MmdYaUtXTXFvNEliOEZ3d2l5ekZl?=
 =?utf-8?B?Rkhqamc5Mk4zb2w5TEV6bGRyNUNJYXBvQXlOQkVRSWRYbDlKbEZvbENrQXRr?=
 =?utf-8?B?VXdVVFNRQkdsT1N0YkpMVmtTZ0lQRjRqY1B5M0srL1VjVU5NUXlvTlIzVEtD?=
 =?utf-8?B?VWQrVDNVZXlSTjlUK0NpTzh3RS9FV01Bcy9PSHR1b0NrQ1ZhQVIxUC96UDZC?=
 =?utf-8?B?emJBckw1RzRWempoSTFMMkduZ1REVXFWTmxwNEFhZUt5K3JFWXZ2a0NTb205?=
 =?utf-8?B?cERPcDFGdlQwVk1valhyWjQ0UnVXMEIxYkpuSkQzYWRzOFFHMkFjc2t3REhM?=
 =?utf-8?B?cGFLd0F6NGVvc2h3anZFZHJEQTJKWWFMSFhZRnZaTW1zM3U0bGdoZUZVdW8v?=
 =?utf-8?B?VTg3Z05FblhrN1kzU0V2Wmw1V1hiSWVGR0JnK3B5dS9wUnhYNzJiNDY4Q1Ny?=
 =?utf-8?B?c2dFUVVtYTB0eFo0UVRkV0NSUHJleWFic0N5S1FBeEg0b01lYXl1VnpOSnJ0?=
 =?utf-8?B?NFNQWmo1WmpHbDlaN0s0RUVDTmlWRWpWRGFIZldtTmgrdGtKdElMWDNtaGtF?=
 =?utf-8?B?ZWhrNE44Uyt0VGdSMVJZMDlvWmhJVklHVXpmb3pBbmovSEd0WFpsbDB3Z3hQ?=
 =?utf-8?B?U21jVEI0UGdOSkNvMUt4MUxzQVFaMlo5V0dGVTBaWU56SEZmSjFwaS9PK0Jv?=
 =?utf-8?B?UEM2OFJEVy9rT01YWS9EUzZPNWlhOGVROWNhL1pRUnZhZWM4UkE5N0p1dEwz?=
 =?utf-8?B?OTlLejUrbHpvUFpaMjlOUlJwbUdDZ255NWQvZFJsb0U0cndwRllXeXk0d0Y3?=
 =?utf-8?B?R2hJeWQzUE9qL1hCODFUVGxpamZUNDBiM1JXTFR2alVvbkFzQnVYcXREOStt?=
 =?utf-8?B?b3diN0Q1VVFnZ2V3R1Y2MXJ2UHBuVm5zV3Z3N01lOUUzZkxwZVJIUmxLN0p1?=
 =?utf-8?B?TTBnbnN2WUpRSHdUUHJXTmh5dzBOSFlMamQySzVJWm0yS083N3IwTHN4YkU3?=
 =?utf-8?B?Y2NtTHNHM20zRi9NK2UwRzRlNEpkVU9rT3NoUmM4cGRMa0p3NHJ1RGlPQ1lm?=
 =?utf-8?B?YUpNT0xjZUtQRE0wWG9wLy9OWjJWT1RHVm5BeklrNTliOFhWWkMzNWl5UWhk?=
 =?utf-8?B?MStTNDU3ZGJ0K24xMFNTdHBxSzFxYWtCU2dHa0NkalB5QkgyRW1odGY5d2Uw?=
 =?utf-8?B?QWFaZXBxVGxnczVpc045b1U1Y2ptOGtZNU91azgrSjg3R2crcFVVSGlnYmhN?=
 =?utf-8?B?WEp6aGt1cTBURnZPenlIS0ovK3FXZ1BWUXhWSms3alREQjEzc0xoREhhS0VB?=
 =?utf-8?B?NFA4b0s5cFhZaGYwZEZyU2pIM1BYeTVGa3BpMkxyak5HdGRRUW45SWNwYUdT?=
 =?utf-8?B?Vi8yOEpSd1RIOXk2TVprUnNMdXNCL05pTG5PQk1raUUzenlzQkJLVmRocFdz?=
 =?utf-8?B?MkZiVi9vQUdFNGZKcUtNczZvY2N5ZVNySFY1M0JxWlBHbk9vRjVUQS9BMjgz?=
 =?utf-8?B?TVhHTTJ5dnMzNW0zNDRTK0pCbkcvMGgyWTAvVWpJME1zUHJRdi95c3pBMzc5?=
 =?utf-8?B?cWtDTC8ySFJGWFhjUmdiblB1UzFBMUo5c1FTRDV5a1lvV05DMGtxbGUxbzlZ?=
 =?utf-8?B?YW5RR0FEYVlmb0J2dWc3TUZnTzRvdGVUMWwwa3o5dVdrZlFab0FwYXBnTE1I?=
 =?utf-8?Q?5WRRZwnxYxF12WpiwT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22643f1-b3fb-4fc7-cfb4-08df28f585aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 06:45:08.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmHYMJLiDV61ZCm4dwLUBK93SF8UMMjXVIomDyHwhYnUK1dT07bHlOreEBobbS9jw1anYiZNoCf/4iraK+TDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453

On 12-10-2026 21:00, Peter Zijlstra wrote:
> On Wed, Oct 07, 2026 at 11:40:02PM +0530, Sandipan Das wrote:
>> The branch snapshot callback used by bpf_get_branch_snapshot() copies
>> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
>> last LBR read kept fewer branches. The entries past lbr_stack.nr are
>> invalid, but they end up reaching BPF programs.
>>
>> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
>> amd_pmu_lbr_read() skips reading the registers, so that a stale count
>> is never reused.
>>
>> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>  arch/x86/events/amd/core.c | 2 +-
>>  arch/x86/events/amd/lbr.c  | 4 +++-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>> index 49b6b8fce566..bf631f60757c 100644
>> --- a/arch/x86/events/amd/core.c
>> +++ b/arch/x86/events/amd/core.c
>> @@ -944,7 +944,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>>  	cpuc = this_cpu_ptr(&cpu_hw_events);
>>  
>>  	amd_pmu_lbr_read();
>> -	cnt = min(cnt, x86_pmu.lbr_nr);
>> +	cnt = min(cnt, cpuc->lbr_stack.nr);
>>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>>  
>>  	amd_pmu_v2_enable_all(0);
>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>> index 1e1b2f08cb51..a00d3850c4a8 100644
>> --- a/arch/x86/events/amd/lbr.c
>> +++ b/arch/x86/events/amd/lbr.c
>> @@ -165,8 +165,10 @@ void amd_pmu_lbr_read(void)
>>  	struct branch_entry entry;
>>  	int out = 0, idx, i;
>>  
>> -	if (!cpuc->lbr_users)
>> +	if (!cpuc->lbr_users) {
>> +		cpuc->lbr_stack.nr = 0;
>>  		return;
>> +	}
>>  
>>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>>  		entry.from.full	= amd_pmu_lbr_get_from(i);
> 
> You now seem to deviate from what the Intel code does. Please clarify.

Yes, it is a deviation. I thought of proposing the following but didn't
proceed because I was not sure about the if condition in the second hunk
which considers things other than cpuc->lbr_users for an early return.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a34d674df59..5dfb9e9156e8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
        struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);

        intel_pmu_lbr_read();
-       cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
+       cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);

        memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
        intel_pmu_enable_all(0);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 0b446d8912e4..6b070490f461 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1026,8 +1026,10 @@ void intel_pmu_lbr_read(void)
         * but this simple approach seems to work for now.
         */
        if (!cpuc->lbr_users || vlbr_exclude_host() ||
-           cpuc->lbr_users == cpuc->lbr_pebs_users)
+           cpuc->lbr_users == cpuc->lbr_pebs_users) {
+               cpuc->lbr_stack.nr = 0;
                return;
+       }

        x86_pmu.lbr_read(cpuc);

